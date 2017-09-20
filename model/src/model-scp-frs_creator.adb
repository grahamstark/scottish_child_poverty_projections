with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with Data_Constants;
with Base_Model_Types;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Target_Dataset_IO;

with Ukds.Frs.Househol_IO;
with Ukds.Frs.Adult_IO;
with Ukds.Frs.Child_IO;
with DB_Commons;

with Connection_Pool;


package body Model.SCP.FRS_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use UKDS.FRS;
   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   
   use GNATCOLL.SQL.Exec;
   
   package d renames DB_Commons;
   package frsh_io renames Househol_IO;

   
   
   procedure Create_Dataset( the_run : Run ) is
      cursor       : GNATCOLL.SQL.Exec.Forward_Cursor;
      household_r  : Househol;
      ps           : GNATCOLL.SQL.Exec.Prepared_Statement;   
      conn         : Database_Connection;
      count        : Natural := 0;
      frs_criteria : d.Criteria;
   begin
      Connection_Pool.Initialise;
      conn := Connection_Pool.Lease;
      Househol_IO.Add_User_Id( frs_criteria, the_run.user_id );
      Househol_IO.Add_Edition( frs_criteria, 1 );
      Househol_IO.Add_Year( frs_criteria, the_run.start_year, d.GE );
      Househol_IO.Add_Year( frs_criteria, the_run.end_year, d.LE );
      Househol_IO.Add_Year_To_Orderings( frs_criteria, d.Asc );
      Househol_IO.Add_Sernum_To_Orderings( frs_criteria, d.Asc );
      Put_Line( "retrieving HHLS " & d.To_String( frs_criteria ));
      ps := Househol_IO.Get_Prepared_Retrieve_Statement( frs_criteria );  
      cursor.Fetch( conn, ps ); -- "select * from frs.househol where year >= 2011 order by year,sernum" );
      while Has_Row( cursor ) loop 
         household_r := Househol_IO.Map_From_Cursor( cursor );
         
         declare
            hh_crit : d.Criteria;
            targets : Target_Dataset; 
         begin
            targets.run_id := the_run.run_id;
            targets.user_id := the_run.user_id;
            targets.year := household_r.year;
            targets.sernum := household_r.sernum;
            
            Househol_IO.Add_User_Id( hh_crit, household_r.user_id );
            Househol_IO.Add_Edition( hh_crit, household_r.edition );
            Househol_IO.Add_Year( hh_crit, household_r.year );
            Househol_IO.Add_Sernum( hh_crit, household_r.sernum );
            
            Inc( targets.household_all_households );
            Inc( targets.country_uk );
            case household_r.gvtregn is
               when 1 .. 10 | 112000001 .. 112000009 =>
                  Inc( targets.country_england );
               when 11 | 399999999 =>
                  Inc( targets.country_wales );
               when 12 | 299999999 =>
                  Inc( targets.country_scotland );
               when 13 | 499999999 =>
                  Inc( targets.country_n_ireland );
               when others =>
                  Assert( false, "out of range region " & household_r.gvtregn'Img );
            end case;
            
            Assert( household_r.hhcomps >= 1 and household_r.hhcomps <= 17, "household_r.hhcomps out of range " &household_r.hhcomps'Img );  
            case household_r.hhcomps is
               when 1 | -- One male adult, no children over pension age
                    3 =>  -- One male adult, no children, under pension age  
                  Inc( targets.household_one_adult_male );
               when 2 | -- One female adult, no children over pension age
                    4 =>  -- One female adult, no children, under pension age
                  Inc( targets.household_one_adult_female );
               when 5 | -- Two adults, no children, both over pension age
                    6 | -- Two adults, no children, one over pension age
                    7 => -- Two adults, no children, both under pension age
                  Inc( targets.household_two_adults );
               when 8 => -- Three or more adults, no children
                  Inc( targets.household_three_plus_person_all_adult );
               when 9 => -- One adult, one child
                  Inc( targets.household_one_adult_one_child );
               when 10 | -- One adult, two children
                    11 => -- One adult, three or more children
                  Inc( targets.household_one_adult_two_plus_children );
               when 12 | -- Two adults, one child
                    13 | -- Two adults, two children            
                    14 | -- Two adults, three or more children
                    15 | -- Three or more adults, one child
                    16 | -- Three or more adults, two children
                    17 => -- Three or more adults, three or more chidren
                   Inc( targets.household_two_plus_adult_one_plus_children );
               when others => null; -- covered by assert
            end case;
            Adult_IO.Add_Person_To_Orderings( hh_crit, d.Asc );
            Put_Line( d.To_String( hh_crit ));
            Put_Line( "on year " & household_r.year'Img & " sernum " & household_r.sernum'Img );
            declare
               adult_l : FRS.Adult_List := Adult_IO.Retrieve( hh_crit );
               child_l : FRS.Child_List := Child_IO.Retrieve( hh_crit );
            begin
               Put_Line( "num adults " & adult_l.Length'Img );
               Put_Line( "num children " & child_l.Length'Img );
               
               Child_Loop:
               for chld of child_l loop
                  Assert( chld.age >= 0 and chld.age <= 19, "age out of range " & chld.age'Img );
                  Assert( chld.sex = 1 or chld.sex = 2, " sex not 1 or 2 " & chld.sex'Img );
                  if chld.sex = 1 then
                     Inc( targets.male );
                  else
                     Inc( targets.female );
                  end if;
                  case chld.age is
                     when 0 =>
                        Inc( targets.age_0 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_0_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_0_female );
                        end if;
                     when 1 =>
                        Inc( targets.age_1 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_1_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_1_female );
                        end if;
                     when 2 =>
                        Inc( targets.age_2 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_2_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_2_female );
                        end if;
                     when 3 =>
                        Inc( targets.age_3 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_3_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_3_female );
                        end if;
                     when 4 =>
                        Inc( targets.age_4 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_4_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_4_female );
                        end if;
                     when 5 =>
                        Inc( targets.age_5 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_5_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_5_female );
                        end if;
                     when 6 =>
                        Inc( targets.age_6 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_6_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_6_female );
                        end if;
                     when 7 =>
                        Inc( targets.age_7 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_7_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_7_female );
                        end if;
                     when 8 =>
                        Inc( targets.age_8 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_8_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_8_female );
                        end if;
                     when 9 =>
                        Inc( targets.age_9 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_9_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_9_female );
                        end if;
                     when 10 =>
                        Inc( targets.age_10 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_10_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_10_female );
                        end if;
                     when 11 =>
                        Inc( targets.age_11 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_11_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_11_female );
                        end if;
                     when 12 =>
                        Inc( targets.age_12 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_12_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_12_female );
                        end if;
                     when 13 =>
                        Inc( targets.age_13 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_13_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_13_female );
                        end if;
                     when 14 =>
                        Inc( targets.age_14 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_14_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_14_female );
                        end if;
                     when 15 =>
                        Inc( targets.age_15 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_15_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_15_female );
                        end if;
                     when 16 =>
                        Inc( targets.age_16 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_16_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_16_female );
                        end if;
                     when 17 =>
                        Inc( targets.age_17 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_17_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_17_female );
                        end if;
                     when 18 =>
                        Inc( targets.age_18 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_18_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_18_female );
                        end if;
                     when 19 =>
                        Inc( targets.age_19 );
                        if( chld.sex = 1 ) then
                           Inc( targets.age_19_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_19_female );
                        end if;
                     when others =>
                        null; -- covered by assert above
                  end case;
               end loop Child_Loop;
               
               Adult_Loop:
               for adult of adult_l loop
                  if( adult.year <= 2012 and adult.ben3q1 = 1 ) or ( adult.year > 2012 and adult.wageben6 = 1 )then
                     Inc( targets.jsa_claimant );
                  end if;
                  
                  case adult.dvil04a is -- DV for ILO in employment - 4 categories
                     when 1 => --    | InEmpXuf - employed exc. unpaid family worker
                        Inc( targets.employed );
                        if( adult.empstatb /= 1 ) then -- self employed
                           Inc( targets.employee ); -- in employment other than SE, ILO definition, sort of..
                        end if;
                     when 2 => null; -- 2     | UFW - unpaid family worker
                     when 3 => --    | Unemp - ILO unemployed
                        Inc( targets.ilo_unemployed );
                     when 4 => --    | EcInAct - ILO economically inactive
                        null;
                     when others => Assert( False, "out of rangee dvil04a " & adult.dvil04a'Img );
                  end case;
                  Assert( adult.age80 >= 16 and adult.age80 <= 80, "age80 out of range " & adult.age80'Img );
                  Assert( adult.sex = 1 or adult.sex = 2, " sex not 1 or 2 " & adult.sex'Img );
                  if adult.sex = 1 then
                     Inc( targets.male );
                  else
                     Inc( targets.female );
                  end if;
                  case adult.age80 is
                     when 16 =>
                        Inc( targets.age_16 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_16_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_16_female );
                        end if;
                     when 17 =>
                        Inc( targets.age_17 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_17_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_17_female );
                        end if;
                     when 18 =>
                        Inc( targets.age_18 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_18_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_18_female );
                        end if;
                     when 19 =>
                        Inc( targets.age_19 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_19_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_19_female );
                        end if;
                     when 20 =>
                        Inc( targets.age_20 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_20_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_20_female );
                        end if;
                     when 21 =>
                        Inc( targets.age_21 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_21_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_21_female );
                        end if;
                     when 22 =>
                        Inc( targets.age_22 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_22_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_22_female );
                        end if;
                     when 23 =>
                        Inc( targets.age_23 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_23_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_23_female );
                        end if;
                     when 24 =>
                        Inc( targets.age_24 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_24_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_24_female );
                        end if;
                     when 25 =>
                        Inc( targets.age_25 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_25_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_25_female );
                        end if;
                     when 26 =>
                        Inc( targets.age_26 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_26_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_26_female );
                        end if;
                     when 27 =>
                        Inc( targets.age_27 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_27_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_27_female );
                        end if;
                     when 28 =>
                        Inc( targets.age_28 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_28_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_28_female );
                        end if;
                     when 29 =>
                        Inc( targets.age_29 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_29_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_29_female );
                        end if;
                     when 30 =>
                        Inc( targets.age_30 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_30_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_30_female );
                        end if;
                     when 31 =>
                        Inc( targets.age_31 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_31_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_31_female );
                        end if;
                     when 32 =>
                        Inc( targets.age_32 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_32_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_32_female );
                        end if;
                     when 33 =>
                        Inc( targets.age_33 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_33_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_33_female );
                        end if;
                     when 34 =>
                        Inc( targets.age_34 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_34_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_34_female );
                        end if;
                     when 35 =>
                        Inc( targets.age_35 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_35_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_35_female );
                        end if;
                     when 36 =>
                        Inc( targets.age_36 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_36_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_36_female );
                        end if;
                     when 37 =>
                        Inc( targets.age_37 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_37_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_37_female );
                        end if;
                     when 38 =>
                        Inc( targets.age_38 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_38_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_38_female );
                        end if;
                     when 39 =>
                        Inc( targets.age_39 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_39_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_39_female );
                        end if;
                     when 40 =>
                        Inc( targets.age_40 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_40_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_40_female );
                        end if;
                     when 41 =>
                        Inc( targets.age_41 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_41_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_41_female );
                        end if;
                     when 42 =>
                        Inc( targets.age_42 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_42_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_42_female );
                        end if;
                     when 43 =>
                        Inc( targets.age_43 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_43_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_43_female );
                        end if;
                     when 44 =>
                        Inc( targets.age_44 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_44_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_44_female );
                        end if;
                     when 45 =>
                        Inc( targets.age_45 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_45_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_45_female );
                        end if;
                     when 46 =>
                        Inc( targets.age_46 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_46_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_46_female );
                        end if;
                     when 47 =>
                        Inc( targets.age_47 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_47_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_47_female );
                        end if;
                     when 48 =>
                        Inc( targets.age_48 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_48_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_48_female );
                        end if;
                     when 49 =>
                        Inc( targets.age_49 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_49_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_49_female );
                        end if;
                     when 50 =>
                        Inc( targets.age_50 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_50_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_50_female );
                        end if;
                     when 51 =>
                        Inc( targets.age_51 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_51_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_51_female );
                        end if;
                     when 52 =>
                        Inc( targets.age_52 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_52_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_52_female );
                        end if;
                     when 53 =>
                        Inc( targets.age_53 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_53_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_53_female );
                        end if;
                     when 54 =>
                        Inc( targets.age_54 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_54_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_54_female );
                        end if;
                     when 55 =>
                        Inc( targets.age_55 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_55_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_55_female );
                        end if;
                     when 56 =>
                        Inc( targets.age_56 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_56_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_56_female );
                        end if;
                     when 57 =>
                        Inc( targets.age_57 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_57_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_57_female );
                        end if;
                     when 58 =>
                        Inc( targets.age_58 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_58_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_58_female );
                        end if;
                     when 59 =>
                        Inc( targets.age_59 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_59_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_59_female );
                        end if;
                     when 60 =>
                        Inc( targets.age_60 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_60_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_60_female );
                        end if;
                     when 61 =>
                        Inc( targets.age_61 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_61_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_61_female );
                        end if;
                     when 62 =>
                        Inc( targets.age_62 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_62_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_62_female );
                        end if;
                     when 63 =>
                        Inc( targets.age_63 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_63_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_63_female );
                        end if;
                     when 64 =>
                        Inc( targets.age_64 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_64_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_64_female );
                        end if;
                     when 65 =>
                        Inc( targets.age_65 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_65_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_65_female );
                        end if;
                     when 66 =>
                        Inc( targets.age_66 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_66_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_66_female );
                        end if;
                     when 67 =>
                        Inc( targets.age_67 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_67_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_67_female );
                        end if;
                     when 68 =>
                        Inc( targets.age_68 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_68_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_68_female );
                        end if;
                     when 69 =>
                        Inc( targets.age_69 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_69_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_69_female );
                        end if;
                     when 70 =>
                        Inc( targets.age_70 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_70_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_70_female );
                        end if;
                     when 71 =>
                        Inc( targets.age_71 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_71_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_71_female );
                        end if;
                     when 72 =>
                        Inc( targets.age_72 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_72_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_72_female );
                        end if;
                     when 73 =>
                        Inc( targets.age_73 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_73_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_73_female );
                        end if;
                     when 74 =>
                        Inc( targets.age_74 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_74_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_74_female );
                        end if;
                     when 75 =>
                        Inc( targets.age_75 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_75_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_75_female );
                        end if;
                     when 76 =>
                        Inc( targets.age_76 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_76_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_76_female );
                        end if;
                     when 77 =>
                        Inc( targets.age_77 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_77_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_77_female );
                        end if;
                     when 78 =>
                        Inc( targets.age_78 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_78_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_78_female );
                        end if;
                     when 79 =>
                        Inc( targets.age_79 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_79_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_79_female );
                        end if;
                     when 80 =>
                        Inc( targets.age_80 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_80_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_80_female );
                        end if;
                     when 81 =>
                        Inc( targets.age_81 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_81_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_81_female );
                        end if;
                     when 82 =>
                        Inc( targets.age_82 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_82_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_82_female );
                        end if;
                     when 83 =>
                        Inc( targets.age_83 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_83_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_83_female );
                        end if;
                     when 84 =>
                        Inc( targets.age_84 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_84_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_84_female );
                        end if;
                     when 85 =>
                        Inc( targets.age_85 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_85_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_85_female );
                        end if;
                     when 86 =>
                        Inc( targets.age_86 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_86_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_86_female );
                        end if;
                     when 87 =>
                        Inc( targets.age_87 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_87_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_87_female );
                        end if;
                     when 88 =>
                        Inc( targets.age_88 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_88_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_88_female );
                        end if;
                     when 89 =>
                        Inc( targets.age_89 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_89_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_89_female );
                        end if;
                     when 90 =>
                        Inc( targets.age_90 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_90_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_90_female );
                        end if;
                     when 91 =>
                        Inc( targets.age_91 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_91_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_91_female );
                        end if;
                     when 92 =>
                        Inc( targets.age_92 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_92_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_92_female );
                        end if;
                     when 93 =>
                        Inc( targets.age_93 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_93_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_93_female );
                        end if;
                     when 94 =>
                        Inc( targets.age_94 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_94_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_94_female );
                        end if;
                     when 95 =>
                        Inc( targets.age_95 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_95_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_95_female );
                        end if;
                     when 96 =>
                        Inc( targets.age_96 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_96_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_96_female );
                        end if;
                     when 97 =>
                        Inc( targets.age_97 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_97_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_97_female );
                        end if;
                     when 98 =>
                        Inc( targets.age_98 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_98_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_98_female );
                        end if;
                     when 99 =>
                        Inc( targets.age_99 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_99_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_99_female );
                        end if;
                     when 100 =>
                        Inc( targets.age_100 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_100_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_100_female );
                        end if;
                     when 101 =>
                        Inc( targets.age_101 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_101_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_101_female );
                        end if;
                     when 102 =>
                        Inc( targets.age_102 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_102_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_102_female );
                        end if;
                     when 103 =>
                        Inc( targets.age_103 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_103_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_103_female );
                        end if;
                     when 104 =>
                        Inc( targets.age_104 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_104_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_104_female );
                        end if;
                     when 105 =>
                        Inc( targets.age_105 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_105_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_105_female );
                        end if;
                     when 106 =>
                        Inc( targets.age_106 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_106_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_106_female );
                        end if;
                     when 107 =>
                        Inc( targets.age_107 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_107_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_107_female );
                        end if;
                     when 108 =>
                        Inc( targets.age_108 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_108_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_108_female );
                        end if;
                     when 109 =>
                        Inc( targets.age_109 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_109_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_109_female );
                        end if;
                     when 110 =>
                        Inc( targets.age_110 );
                        if( adult.sex = 1 ) then
                           Inc( targets.age_110_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_110_female );
                        end if;
                     when others => null; -- the assert above covers this                            
                  end case;
               end loop Adult_Loop;
            end;
            UKDS.Target_Data.Target_Dataset_IO.Save( targets );
         end;
         count := count + 1;
         Next( cursor );
      end loop;
      Connection_Pool.Return_Connection( conn );
   end Create_Dataset;

end  Model.SCP.FRS_Creator;