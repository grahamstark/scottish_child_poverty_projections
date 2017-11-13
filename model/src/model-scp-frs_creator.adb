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
with Ukds.Frs.Job_IO;
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

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.SCP.FRS_CREATOR" );
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
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
      Log( "retrieving HHLS " & d.To_String( frs_criteria ));
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
            Assert( household_r.hhcomps >= 1 and household_r.hhcomps <= 17, "household_r.hhcomps out of range " &household_r.hhcomps'Img );
            
         
            case household_r.gvtregn is
               when 1 .. 10 | 112000001 .. 112000009 =>
                  Inc( targets.country_england );
                  
                  
                  case household_r.hhcomps is
                     when 1 | -- One male adult, no children over pension age
                          3 =>  -- One male adult, no children, under pension age  
                        Inc( targets.eng_hhld_one_person_households_male );
                     when 2 | -- One female adult, no children over pension age
                          4 =>  -- One female adult, no children, under pension age
                        Inc( targets.eng_hhld_one_person_households_female );
                     when 5 | -- Two adults, no children, both over pension age
                          6 | -- Two adults, no children, one over pension age
                          7 => -- Two adults, no children, both under pension age
                        Inc( targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi );
                     when 8 => -- Three or more adults, no children
                        Inc( targets.eng_hhld_a_couple_and_other_adults_no_dependent_children );
                     when 9 | -- One adult, one child
                         12 | -- Two adults, one child
                         15 => -- Three or more adults, one child
                          
                        Inc( targets.eng_hhld_households_with_one_dependent_child );
                     when 10 | -- One adult, two children
                          13 | -- Two adults, two children            
                          16 => -- Three or more adults, two children                     
                       Inc( targets.eng_hhld_households_with_two_dependent_children );
                     when 
                          11 | -- One adult, three or more children
                          14 | -- Two adults, three or more children
                          17 => -- Three or more adults, three or more chidren
                        if household_r.depchldh = 3 then
                           Inc( targets.eng_hhld_households_with_three_dependent_children );
                        else
                           Inc( targets.eng_hhld_other_households );
                        end if;
                     when others => null; -- covered by assert
                  end case;
               when 11 | 399999999 =>
                  Inc( targets.country_wales );
                  case household_r.hhcomps is
                     when 1 | -- One male adult, no children over pension age
                          3 =>  -- One male adult, no children, under pension age  
                        Inc( targets.wal_hhld_1_person );
                     when 2 | -- One female adult, no children over pension age
                          4 =>  -- One female adult, no children, under pension age
                        Inc( targets.wal_hhld_1_person );
                     when 5 | -- Two adults, no children, both over pension age
                          6 | -- Two adults, no children, one over pension age
                          7 => -- Two adults, no children, both under pension age
                        Inc( targets.wal_hhld_2_person_no_children );
                     when 8 => -- Three or more adults, no children
                        Assert( household_r.adulth >= 3, " 8 needs >= 3 ads; is " & household_r.adulth'Img );
                        if household_r.adulth = 3 then 
                           Inc( targets.wal_hhld_3_person_no_children );
                        elsif household_r.adulth = 4 then                           
                           Inc( targets.wal_hhld_4_person_no_children );
                        else
                           Inc( targets.wal_hhld_5_plus_person_no_children );
                        end if;
                     when 9 => -- One adult, one child
                        Inc( targets.wal_hhld_2_person_1_adult_1_child );
                     when 10 => -- One adult, two children
                        Inc( targets.wal_hhld_3_person_1_adult_2_children );                        
                     when 11 => -- One adult, three or more children
                        
                        Assert( household_r.depchldh >= 3, "not enough kids for 11" & household_r.depchldh'Img );
                        if household_r.depchldh = 3 then
                           Inc( targets.wal_hhld_4_person_1_adult_3_children );
                        else 
                           Inc( targets.wal_hhld_5_plus_person_1_adult_4_plus_children );
                        end if;
                     when 12 => -- Two adults, one child
                        Inc( targets.wal_hhld_3_person_2_adults_1_child );
                     when 13 => -- Two adults, two children
                        Inc( targets.wal_hhld_4_person_2_plus_adults_1_plus_children );
                     when 14 => -- Two adults, three or more children
                        Inc( targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children );
                     when 15 | -- Three or more adults, one child                          
                          16 | -- Three or more adults, two children
                          17 => -- Three or more adults, three or more chidren
                       Inc( targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children );
                     when others => null; -- covered by assert
                  end case;
                  
                  
               when 12 | 299999999 =>
                  Inc( targets.country_scotland );
                  case household_r.hhcomps is
                     when 1 | -- One male adult, no children over pension age
                          3 =>  -- One male adult, no children, under pension age  
                        Inc( targets.sco_hhld_one_adult_male );
                     when 2 | -- One female adult, no children over pension age
                          4 =>  -- One female adult, no children, under pension age
                        Inc( targets.sco_hhld_one_adult_female );
                     when 5 | -- Two adults, no children, both over pension age
                          6 | -- Two adults, no children, one over pension age
                          7 => -- Two adults, no children, both under pension age
                        Inc( targets.sco_hhld_two_adults );
                     when 8 => -- Three or more adults, no children
                        Inc( targets.sco_hhld_three_plus_person_all_adult );
                     when 9 => -- One adult, one child
                        Inc( targets.sco_hhld_one_adult_one_child );
                     when 10 | -- One adult, two children
                          11 => -- One adult, three or more children
                        Inc( targets.sco_hhld_one_adult_two_plus_children );
                     when 12 | -- Two adults, one child
                          13 | -- Two adults, two children            
                          14 | -- Two adults, three or more children
                          15 | -- Three or more adults, one child
                          16 | -- Three or more adults, two children
                          17 => -- Three or more adults, three or more chidren
                         Inc( targets.sco_hhld_two_plus_adult_one_plus_children );
                     when others => null; -- covered by assert
                  end case;

               when 13 | 499999999 =>
                  Inc( targets.country_n_ireland );
                  case household_r.hhcomps is
                     when 1 | -- One male adult, no children over pension age
                          3 |  -- One male adult, no children, under pension age  
                          2 | -- One female adult, no children over pension age
                          4 =>  -- One female adult, no children, under pension age
                        Inc( targets.nir_hhld_one_adult_households );
                     when 5 | -- Two adults, no children, both over pension age
                          6 | -- Two adults, no children, one over pension age
                          7 => -- Two adults, no children, both under pension age
                        Inc( targets.nir_hhld_two_adults_without_children );
                     when 8 => -- Three or more adults, no children
                        Inc( targets.nir_hhld_other_households_without_children );
                     when 9 | -- One adult, one child
                         10 | -- One adult, two children
                         11 => -- One adult, three or more children
                            Inc( targets.nir_hhld_one_adult_households_with_children );
                     when
                         12 | -- Two adults, one child
                         13 | -- Two adults, two children            
                         14 | -- Two adults, three or more children
                         15 | -- Three or more adults, one child
                         16 | -- Three or more adults, two children
                         17 => -- Three or more adults, three or more chidren
                        Inc( targets.nir_hhld_other_households_with_children );
                     when others => null; -- covered by assert
                  end case;
                  
               when others =>
                  Assert( false, "out of range region " & household_r.gvtregn'Img );
            end case;
            
            
            
            Adult_IO.Add_Person_To_Orderings( hh_crit, d.Asc );
            Log( d.To_String( hh_crit ));
            Log( "on year " & household_r.year'Img & " sernum " & household_r.sernum'Img );
            declare
               adult_l : FRS.Adult_List := Adult_IO.Retrieve( hh_crit );
               child_l : FRS.Child_List := Child_IO.Retrieve( hh_crit );
               
            begin
               Log( "num adults " & adult_l.Length'Img );
               Log( "num children " & child_l.Length'Img );
               
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
                        if( chld.sex = 1 ) then
                           Inc( targets.age_0_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_0_female );
                        end if;
                     when 1 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_1_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_1_female );
                        end if;
                     when 2 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_2_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_2_female );
                        end if;
                     when 3 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_3_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_3_female );
                        end if;
                     when 4 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_4_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_4_female );
                        end if;
                     when 5 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_5_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_5_female );
                        end if;
                     when 6 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_6_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_6_female );
                        end if;
                     when 7 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_7_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_7_female );
                        end if;
                     when 8 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_8_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_8_female );
                        end if;
                     when 9 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_9_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_9_female );
                        end if;
                     when 10 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_10_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_10_female );
                        end if;
                     when 11 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_11_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_11_female );
                        end if;
                     when 12 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_12_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_12_female );
                        end if;
                     when 13 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_13_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_13_female );
                        end if;
                     when 14 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_14_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_14_female );
                        end if;
                     when 15 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_15_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_15_female );
                        end if;
                     when 16 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_16_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_16_female );
                        end if;
                     when 17 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_17_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_17_female );
                        end if;
                     when 18 =>
                        if( chld.sex = 1 ) then
                           Inc( targets.age_18_male );
                        elsif( chld.sex = 2 ) then
                           Inc( targets.age_18_female );
                        end if;
                     when 19 =>
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
                        if( adult.sex = 1 ) then
                           Inc( targets.age_16_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_16_female );
                        end if;
                     when 17 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_17_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_17_female );
                        end if;
                     when 18 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_18_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_18_female );
                        end if;
                     when 19 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_19_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_19_female );
                        end if;
                     when 20 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_20_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_20_female );
                        end if;
                     when 21 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_21_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_21_female );
                        end if;
                     when 22 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_22_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_22_female );
                        end if;
                     when 23 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_23_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_23_female );
                        end if;
                     when 24 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_24_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_24_female );
                        end if;
                     when 25 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_25_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_25_female );
                        end if;
                     when 26 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_26_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_26_female );
                        end if;
                     when 27 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_27_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_27_female );
                        end if;
                     when 28 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_28_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_28_female );
                        end if;
                     when 29 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_29_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_29_female );
                        end if;
                     when 30 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_30_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_30_female );
                        end if;
                     when 31 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_31_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_31_female );
                        end if;
                     when 32 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_32_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_32_female );
                        end if;
                     when 33 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_33_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_33_female );
                        end if;
                     when 34 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_34_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_34_female );
                        end if;
                     when 35 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_35_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_35_female );
                        end if;
                     when 36 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_36_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_36_female );
                        end if;
                     when 37 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_37_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_37_female );
                        end if;
                     when 38 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_38_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_38_female );
                        end if;
                     when 39 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_39_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_39_female );
                        end if;
                     when 40 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_40_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_40_female );
                        end if;
                     when 41 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_41_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_41_female );
                        end if;
                     when 42 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_42_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_42_female );
                        end if;
                     when 43 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_43_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_43_female );
                        end if;
                     when 44 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_44_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_44_female );
                        end if;
                     when 45 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_45_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_45_female );
                        end if;
                     when 46 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_46_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_46_female );
                        end if;
                     when 47 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_47_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_47_female );
                        end if;
                     when 48 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_48_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_48_female );
                        end if;
                     when 49 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_49_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_49_female );
                        end if;
                     when 50 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_50_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_50_female );
                        end if;
                     when 51 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_51_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_51_female );
                        end if;
                     when 52 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_52_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_52_female );
                        end if;
                     when 53 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_53_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_53_female );
                        end if;
                     when 54 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_54_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_54_female );
                        end if;
                     when 55 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_55_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_55_female );
                        end if;
                     when 56 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_56_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_56_female );
                        end if;
                     when 57 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_57_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_57_female );
                        end if;
                     when 58 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_58_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_58_female );
                        end if;
                     when 59 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_59_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_59_female );
                        end if;
                     when 60 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_60_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_60_female );
                        end if;
                     when 61 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_61_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_61_female );
                        end if;
                     when 62 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_62_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_62_female );
                        end if;
                     when 63 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_63_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_63_female );
                        end if;
                     when 64 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_64_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_64_female );
                        end if;
                     when 65 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_65_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_65_female );
                        end if;
                     when 66 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_66_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_66_female );
                        end if;
                     when 67 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_67_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_67_female );
                        end if;
                     when 68 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_68_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_68_female );
                        end if;
                     when 69 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_69_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_69_female );
                        end if;
                     when 70 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_70_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_70_female );
                        end if;
                     when 71 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_71_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_71_female );
                        end if;
                     when 72 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_72_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_72_female );
                        end if;
                     when 73 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_73_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_73_female );
                        end if;
                     when 74 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_74_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_74_female );
                        end if;
                     when 75 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_75_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_75_female );
                        end if;
                     when 76 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_76_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_76_female );
                        end if;
                     when 77 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_77_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_77_female );
                        end if;
                     when 78 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_78_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_78_female );
                        end if;
                     when 79 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_79_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_79_female );
                        end if;
                     when 80 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_80_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_80_female );
                        end if;
                     when 81 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_81_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_81_female );
                        end if;
                     when 82 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_82_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_82_female );
                        end if;
                     when 83 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_83_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_83_female );
                        end if;
                     when 84 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_84_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_84_female );
                        end if;
                     when 85 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_85_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_85_female );
                        end if;
                     when 86 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_86_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_86_female );
                        end if;
                     when 87 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_87_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_87_female );
                        end if;
                     when 88 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_88_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_88_female );
                        end if;
                     when 89 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_89_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_89_female );
                        end if;
                     when 90 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_90_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_90_female );
                        end if;
                     when 91 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_91_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_91_female );
                        end if;
                     when 92 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_92_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_92_female );
                        end if;
                     when 93 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_93_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_93_female );
                        end if;
                     when 94 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_94_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_94_female );
                        end if;
                     when 95 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_95_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_95_female );
                        end if;
                     when 96 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_96_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_96_female );
                        end if;
                     when 97 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_97_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_97_female );
                        end if;
                     when 98 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_98_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_98_female );
                        end if;
                     when 99 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_99_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_99_female );
                        end if;
                     when 100 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_100_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_100_female );
                        end if;
                     when 101 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_101_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_101_female );
                        end if;
                     when 102 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_102_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_102_female );
                        end if;
                     when 103 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_103_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_103_female );
                        end if;
                     when 104 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_104_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_104_female );
                        end if;
                     when 105 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_105_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_105_female );
                        end if;
                     when 106 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_106_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_106_female );
                        end if;
                     when 107 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_107_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_107_female );
                        end if;
                     when 108 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_108_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_108_female );
                        end if;
                     when 109 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_109_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_109_female );
                        end if;
                     when 110 =>
                        if( adult.sex = 1 ) then
                           Inc( targets.age_110_male );
                        elsif( adult.sex = 2 ) then
                           Inc( targets.age_110_female );
                        end if;
                     when others => null; -- the assert above covers this                            
                  end case;
                  
                  --
                  -- public / private split
                  -- ??? here, we'll add one for each job a person has, so possibly
                  -- both public and private
                  --
                  declare
                     
                     job_l : FRS.Job_List;  
                     job_crit : d.Criteria;
                  begin

                     Job_IO.Add_User_Id( job_crit, adult.user_id );
                     Job_IO.Add_Edition( job_crit, adult.edition );
                     Job_IO.Add_Year( job_crit, adult.year );
                     Job_IO.Add_Sernum( job_crit, adult.sernum );
                     Job_IO.Add_Benunit( job_crit, adult.benunit );
                     Job_IO.Add_Person( job_crit, adult.person );
                     job_l  := Job_IO.Retrieve( job_crit );
                     for job of job_l loop
                        case job.jobsect is
                           when 1 => 
                              Inc( targets.private_sector_employed );
                           when 2 =>   
                              Inc( targets.public_sector_employed );
                           when -1 | -2 =>
                               null; -- harmless missing indicators
                           when others =>
                              Assert( false, "pub/priv(jobsect) indicator out of range " & job.jobsect'Img );
                           end case;
                     end loop;
                  end;
                  
                  if adult.DVIL04A /= 4 then -- not inactive == active in our terms
                     case adult.age80 is
                        when 16 .. 19 => if( adult.sex = 1 ) then 
                           Inc( targets.participation_16_19_male ); 
                        else 
                           Inc(  targets.participation_16_19_female ); 
                        end if;
                        
                        when 20 .. 24 => 
                           if( adult.sex = 1 ) then 
                              Inc( targets.participation_20_24_male ); 
                           else 
                              Inc(  targets.participation_20_24_female ); 
                           end if;
                        when 25 .. 29 => if( adult.sex = 1 ) then Inc( targets.participation_25_29_male ); else Inc(  targets.participation_25_29_female ); end if;
                        when 30 .. 34 => if( adult.sex = 1 ) then Inc( targets.participation_30_34_male ); else Inc(  targets.participation_30_34_female ); end if;
                        when 35 .. 39 => if( adult.sex = 1 ) then Inc( targets.participation_35_39_male ); else Inc(  targets.participation_35_39_female ); end if;
                        when 40 .. 44 => if( adult.sex = 1 ) then Inc( targets.participation_40_44_male ); else Inc(  targets.participation_40_44_female ); end if;
                        when 45 .. 49 => if( adult.sex = 1 ) then Inc( targets.participation_45_49_male ); else Inc(  targets.participation_45_49_female ); end if;
                        when 50 .. 54 => if( adult.sex = 1 ) then Inc( targets.participation_50_54_male ); else Inc(  targets.participation_50_54_female ); end if;
                        when 55 .. 59 => if( adult.sex = 1 ) then Inc( targets.participation_55_59_male ); else Inc(  targets.participation_55_59_female ); end if;
                        when 60 .. 64 => if( adult.sex = 1 ) then Inc( targets.participation_60_64_male ); else Inc(  targets.participation_60_64_female ); end if;
                        when 65 .. 69 => if( adult.sex = 1 ) then Inc( targets.participation_65_69_male ); else Inc(  targets.participation_65_69_female ); end if;
                        when 70 .. 74 => if( adult.sex = 1 ) then Inc( targets.participation_70_74_male ); else Inc(  targets.participation_70_74_female ); end if;
                        when 75 .. 120 => if( adult.sex = 1 ) then Inc( targets.participation_75_plus_male ); else Inc(  targets.participation_75_plus_female ); end if;
                        when others => Assert( false, "age out of range for adult; " & adult.age80'Img );
                     end case;
                  end if;
                  
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