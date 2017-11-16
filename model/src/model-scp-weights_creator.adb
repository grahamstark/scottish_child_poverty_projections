with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

with Weighting_Commons;
with Data_Constants;
with Base_Model_Types;
with Text_Utils;

with Maths_Functions.Weights_Generator;
with Maths_Functions;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Target_Dataset_IO;
with Ukds.Target_Data.Output_Weights_IO;
with DB_Commons;

with Connection_Pool;


package body Model.SCP.Weights_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use Text_Utils;   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   use Ada.Strings.Unbounded;


   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.SCP.WEIGHTS_CREATOR" );
   use GNATColl.Traces;
   
   procedure Print_Diffs( 
      diffsf             : File_Type;
      year               : Year_Number;
      header             : String; 
      labels             : Unbounded_String_List; 
      target_populations : Vector;  
      new_populations    : Vector ) is
   use Ada.Text_IO;
      diff : Amount;
   begin
      Put_Line( header );
      Put_Line( year'Img );
      for c in target_populations'Range loop
         Int_IO.Put( c, 0 );
         Put( Tab );
         Put( Prettify_Image( TS( labels.Element( c ))));
         Put( Tab );
         Amount_IO.Put( target_populations( c ), 0, 3, 0 );
         Put( Tab );
         Amount_IO.Put( new_populations( c ), 0, 3, 0 );
         if( target_populations( c ) /= 0.0 )then
            diff := 100.0*( new_populations( c )-target_populations( c ))/target_populations( c );
         end if;
         Put( TAB );
         Amount_IO.Put( diff, 0, 4 , 0 );               
         New_Line;
      end loop;
   end Print_Diffs;

   function Col_Names(
      clauses : Selected_Clauses_Array;
      country : Unbounded_String ) return Unbounded_String_List is
         ls : Unbounded_String_List;
   begin
 
      if clauses( employment_by_sector ) then
         ls.Add_To( "private_sector_employed" );
         ls.Add_To( "public_sector_employed" );
      end if;
      if clauses( household_type ) then 
         if( country = SCO or country = UK ) then
            ls.Add_To( "sco_hhld_one_adult_male" );
            ls.Add_To( "sco_hhld_one_adult_female" );
            ls.Add_To( "sco_hhld_two_adults" );
            ls.Add_To( "sco_hhld_one_adult_one_child" );
            ls.Add_To( "sco_hhld_one_adult_two_plus_children" );
            ls.Add_To( "sco_hhld_two_plus_adult_one_plus_children" );
            ls.Add_To( "sco_hhld_three_plus_person_all_adult" );
         end if;
         if( country = ENG or country = UK ) then
            ls.Add_To( "eng_hhld_one_person_households_male" );
            ls.Add_To( "eng_hhld_one_person_households_female" );
            ls.Add_To( "eng_hhld_one_family_and_no_others_couple_no_dependent_chi + targets.eng_hhld_other_households" );
            ls.Add_To( "eng_hhld_a_couple_and_other_adults_no_dependent_children" );
            ls.Add_To( "eng_hhld_households_with_one_dependent_child" );
            ls.Add_To( "eng_hhld_households_with_two_dependent_children" );
            ls.Add_To( "eng_hhld_households_with_three_dependent_children" );
            -- ls.Add_To( "eng_hhld_other_households" );
         end if;
         if( country = NIR or country = UK ) then
            ls.Add_To( "nir_hhld_one_adult_households" );
            ls.Add_To( "nir_hhld_two_adults_without_children" );
            ls.Add_To( "nir_hhld_other_households_without_children" );
            ls.Add_To( "nir_hhld_one_adult_households_with_children" );
            ls.Add_To( "nir_hhld_other_households_with_children" );
         end if;
         if( country = WAL or country = UK ) then
            ls.Add_To( "wal_hhld_1_person" );
            ls.Add_To( "wal_hhld_2_person_no_children" );
            ls.Add_To( "wal_hhld_2_person_1_adult_1_child" );
            ls.Add_To( "wal_hhld_3_person_no_children" );
            ls.Add_To( "wal_hhld_3_person_2_adults_1_child" );
            ls.Add_To( "wal_hhld_3_person_1_adult_2_children" );
            ls.Add_To( "wal_hhld_4_person_no_children" );
            ls.Add_To( "wal_hhld_4_person_2_plus_adults_1_plus_children" );
            ls.Add_To( "wal_hhld_4_person_1_adult_3_children" );
            ls.Add_To( "wal_hhld_5_plus_person_no_children" );
            ls.Add_To( "wal_hhld_5_plus_person_2_plus_adults_1_plus_children" );
            ls.Add_To( "wal_hhld_5_plus_person_1_adult_4_plus_children" );
         end if;
      end if;
      -- household_all_households : Amount := 0.0;
      if clauses( genders ) then
         ls.Add_To( "male" );
         ls.Add_To( "female" );
      end if;
      if clauses( employment ) then      
            ls.Add_To( "employed" );
      end if;
      if clauses( employees ) then      
         ls.Add_To( "employee" );
      end if;
      if clauses( ilo_unemployment ) then
         ls.Add_To( "ilo_unemployed" );
      end if;
      if clauses( jsa_claimants ) then
         ls.Add_To( "jsa_claimant" );
      end if;
      if clauses( by_year_ages_by_gender ) then
         ls.Add_To( "age_0_male" );
         ls.Add_To( "age_1_male" );
         ls.Add_To( "age_2_male" );
         ls.Add_To( "age_3_male" );
         ls.Add_To( "age_4_male" );
         ls.Add_To( "age_5_male" );
         ls.Add_To( "age_6_male" );
         ls.Add_To( "age_7_male" );
         ls.Add_To( "age_8_male" );
         ls.Add_To( "age_9_male" );
         ls.Add_To( "age_10_male" );
         ls.Add_To( "age_11_male" );
         ls.Add_To( "age_12_male" );
         ls.Add_To( "age_13_male" );
         ls.Add_To( "age_14_male" );
         ls.Add_To( "age_15_male" );
         ls.Add_To( "age_16_male" );
         ls.Add_To( "age_17_male" );
         ls.Add_To( "age_18_male" );
         ls.Add_To( "age_19_male" );
         ls.Add_To( "age_20_male" );
         ls.Add_To( "age_21_male" );
         ls.Add_To( "age_22_male" );
         ls.Add_To( "age_23_male" );
         ls.Add_To( "age_24_male" );
         ls.Add_To( "age_25_male" );
         ls.Add_To( "age_26_male" );
         ls.Add_To( "age_27_male" );
         ls.Add_To( "age_28_male" );
         ls.Add_To( "age_29_male" );
         ls.Add_To( "age_30_male" );
         ls.Add_To( "age_31_male" );
         ls.Add_To( "age_32_male" );
         ls.Add_To( "age_33_male" );
         ls.Add_To( "age_34_male" );
         ls.Add_To( "age_35_male" );
         ls.Add_To( "age_36_male" );
         ls.Add_To( "age_37_male" );
         ls.Add_To( "age_38_male" );
         ls.Add_To( "age_39_male" );
         ls.Add_To( "age_40_male" );
         ls.Add_To( "age_41_male" );
         ls.Add_To( "age_42_male" );
         ls.Add_To( "age_43_male" );
         ls.Add_To( "age_44_male" );
         ls.Add_To( "age_45_male" );
         ls.Add_To( "age_46_male" );
         ls.Add_To( "age_47_male" );
         ls.Add_To( "age_48_male" );
         ls.Add_To( "age_49_male" );
         ls.Add_To( "age_50_male" );
         ls.Add_To( "age_51_male" );
         ls.Add_To( "age_52_male" );
         ls.Add_To( "age_53_male" );
         ls.Add_To( "age_54_male" );
         ls.Add_To( "age_55_male" );
         ls.Add_To( "age_56_male" );
         ls.Add_To( "age_57_male" );
         ls.Add_To( "age_58_male" );
         ls.Add_To( "age_59_male" );
         ls.Add_To( "age_60_male" );
         ls.Add_To( "age_61_male" );
         ls.Add_To( "age_62_male" );
         ls.Add_To( "age_63_male" );
         ls.Add_To( "age_64_male" );
         ls.Add_To( "age_65_male" );
         ls.Add_To( "age_66_male" );
         ls.Add_To( "age_67_male" );
         ls.Add_To( "age_68_male" );
         ls.Add_To( "age_69_male" );
         ls.Add_To( "age_70_male" );
         ls.Add_To( "age_71_male" );
         ls.Add_To( "age_72_male" );
         ls.Add_To( "age_73_male" );
         ls.Add_To( "age_74_male" );
         ls.Add_To( "age_75_male" );
         ls.Add_To( "age_76_male" );
         ls.Add_To( "age_77_male" );
         ls.Add_To( "age_78_male" );
         ls.Add_To( "age_79_male" );
         ls.Add_To( "age_80+_male" );
         ls.Add_To( "age_0_female" );
         ls.Add_To( "age_1_female" );
         ls.Add_To( "age_2_female" );
         ls.Add_To( "age_3_female" );
         ls.Add_To( "age_4_female" );
         ls.Add_To( "age_5_female" );
         ls.Add_To( "age_6_female" );
         ls.Add_To( "age_7_female" );
         ls.Add_To( "age_8_female" );
         ls.Add_To( "age_9_female" );
         ls.Add_To( "age_10_female" );
         ls.Add_To( "age_11_female" );
         ls.Add_To( "age_12_female" );
         ls.Add_To( "age_13_female" );
         ls.Add_To( "age_14_female" );
         ls.Add_To( "age_15_female" );
         ls.Add_To( "age_16_female" );
         ls.Add_To( "age_17_female" );
         ls.Add_To( "age_18_female" );
         ls.Add_To( "age_19_female" );
         ls.Add_To( "age_20_female" );
         ls.Add_To( "age_21_female" );
         ls.Add_To( "age_22_female" );
         ls.Add_To( "age_23_female" );
         ls.Add_To( "age_24_female" );
         ls.Add_To( "age_25_female" );
         ls.Add_To( "age_26_female" );
         ls.Add_To( "age_27_female" );
         ls.Add_To( "age_28_female" );
         ls.Add_To( "age_29_female" );
         ls.Add_To( "age_30_female" );
         ls.Add_To( "age_31_female" );
         ls.Add_To( "age_32_female" );
         ls.Add_To( "age_33_female" );
         ls.Add_To( "age_34_female" );
         ls.Add_To( "age_35_female" );
         ls.Add_To( "age_36_female" );
         ls.Add_To( "age_37_female" );
         ls.Add_To( "age_38_female" );
         ls.Add_To( "age_39_female" );
         ls.Add_To( "age_40_female" );
         ls.Add_To( "age_41_female" );
         ls.Add_To( "age_42_female" );
         ls.Add_To( "age_43_female" );
         ls.Add_To( "age_44_female" );
         ls.Add_To( "age_45_female" );
         ls.Add_To( "age_46_female" );
         ls.Add_To( "age_47_female" );
         ls.Add_To( "age_48_female" );
         ls.Add_To( "age_49_female" );
         ls.Add_To( "age_50_female" );
         ls.Add_To( "age_51_female" );
         ls.Add_To( "age_52_female" );
         ls.Add_To( "age_53_female" );
         ls.Add_To( "age_54_female" );
         ls.Add_To( "age_55_female" );
         ls.Add_To( "age_56_female" );
         ls.Add_To( "age_57_female" );
         ls.Add_To( "age_58_female" );
         ls.Add_To( "age_59_female" );
         ls.Add_To( "age_60_female" );
         ls.Add_To( "age_61_female" );
         ls.Add_To( "age_62_female" );
         ls.Add_To( "age_63_female" );
         ls.Add_To( "age_64_female" );
         ls.Add_To( "age_65_female" );
         ls.Add_To( "age_66_female" );
         ls.Add_To( "age_67_female" );
         ls.Add_To( "age_68_female" );
         ls.Add_To( "age_69_female" );
         ls.Add_To( "age_70_female" );
         ls.Add_To( "age_71_female" );
         ls.Add_To( "age_72_female" );
         ls.Add_To( "age_73_female" );
         ls.Add_To( "age_74_female" );
         ls.Add_To( "age_75_female" );
         ls.Add_To( "age_76_female" );
         ls.Add_To( "age_77_female" );
         ls.Add_To( "age_78_female" );
         ls.Add_To( "age_79_female" );
         ls.Add_To( "age_80+_female" );
      end if;

      if clauses( aggregate_ages_by_gender ) then
         ls.Add_To( "0-4_male" );
         ls.Add_To( "5-10_male" );
         ls.Add_To( "11-15_male" );
         ls.Add_To( "16-19_male" );
         ls.Add_To( "20-24_male" );
         ls.Add_To( "25-29_male" );
         ls.Add_To( "30-34_male" );
         ls.Add_To( "35-39_male" );
         ls.Add_To( "40-44_male" );
         ls.Add_To( "45-49_male" );
         ls.Add_To( "50-54_male" );
         ls.Add_To( "55-59_male" );
         ls.Add_To( "60-64_male" );
         ls.Add_To( "65-69_male" );
         ls.Add_To( "70-74_male" );
         ls.Add_To( "75-79_male" );
         ls.Add_To( "80+_male" );
         ls.Add_To( "0-4_female" );
         ls.Add_To( "5-10_female" );
         ls.Add_To( "11-15_female" );
         ls.Add_To( "16-19_female" );
         ls.Add_To( "20-24_female" );
         ls.Add_To( "25-29_female" );
         ls.Add_To( "30-34_female" );
         ls.Add_To( "35-39_female" );
         ls.Add_To( "40-44_female" );
         ls.Add_To( "45-49_female" );
         ls.Add_To( "50-54_female" );
         ls.Add_To( "55-59_female" );
         ls.Add_To( "60-64_female" );
         ls.Add_To( "65-69_female" );
         ls.Add_To( "70-74_female" );
         ls.Add_To( "75-79_female" );
         ls.Add_To( "80+_female" );
      end if;      
      if clauses( participation_rate ) then
         -- ls.Add_To( "participation_16_19_male" );
         ls.Add_To( "participation_20_24_male" );
         ls.Add_To( "participation_25_29_male" );
         ls.Add_To( "participation_30_34_male" );
         ls.Add_To( "participation_35_39_male" );
         ls.Add_To( "participation_40_44_male" );
         ls.Add_To( "participation_45_49_male" );
         ls.Add_To( "participation_50_54_male" );
         ls.Add_To( "participation_55_59_male" );
         ls.Add_To( "participation_60_64_male" );
         ls.Add_To( "participation_65_69_male" );
         ls.Add_To( "participation_70_74_male" );
         -- ls.Add_To( "participation_75_plus_male" );
         -- ls.Add_To( "participation_16_19_female" );
         ls.Add_To( "participation_20_24_female" );
         ls.Add_To( "participation_25_29_female" );
         ls.Add_To( "participation_30_34_female" );
         ls.Add_To( "participation_35_39_female" );
         ls.Add_To( "participation_40_44_female" );
         ls.Add_To( "participation_45_49_female" );
         ls.Add_To( "participation_50_54_female" );
         ls.Add_To( "participation_55_59_female" );
         ls.Add_To( "participation_60_64_female" );
         ls.Add_To( "participation_65_69_female" );
         ls.Add_To( "participation_70_74_female" );
         -- ls.Add_To( "participation_75_plus_female" );
      end if;
      
      return ls;
   end Col_Names;
   

   procedure Fill_One_Row( 
      clauses        : Selected_Clauses_Array;
      country        : Unbounded_String;
      targets        : Target_Dataset;
      row            : out Vector;
      initial_weight : out Amount ) is
         
         p : Natural := 0;
         tmp : Amount;
         
         procedure Add_Col( v : Amount ) is
         begin
            p := p + 1;
            row( p ) := v;
         end Add_Col;
         
    begin
      
      Assert( not (clauses( by_year_ages ) and clauses( by_year_ages_by_gender )), " by_year_ages and by_year_ages_by_gender can't both be on " );
      Assert( not (clauses( aggregate_ages ) and clauses( aggregate_ages_by_gender )), " aggregate_ages and aggregate_ages_by_gender can't both be on " );
       
      --
      -- this is a SCO/NI oversampling correction 
      --
      initial_weight := 1.0;
      if country = UK then
         if targets.country_scotland > 0.0 then
            initial_weight := 0.5;
         elsif targets.country_n_ireland > 0.0 then
            initial_weight := 0.2;
         end if;
      end if;

      row := ( others => 0.0 );

      if clauses( employment_by_sector ) then
         Add_Col( targets.private_sector_employed );
         Add_Col( targets.public_sector_employed );
      end if;

      if clauses( household_type ) then 
         if( country = SCO or country = UK ) then
            Add_Col( targets.sco_hhld_one_adult_male );
            Add_Col( targets.sco_hhld_one_adult_female );
            Add_Col( targets.sco_hhld_two_adults );
            Add_Col( targets.sco_hhld_one_adult_one_child );
            Add_Col( targets.sco_hhld_one_adult_two_plus_children );
            Add_Col( targets.sco_hhld_two_plus_adult_one_plus_children );
            Add_Col( targets.sco_hhld_three_plus_person_all_adult );
         end if;
         if( country = ENG or country = UK ) then
            Add_Col( targets.eng_hhld_one_person_households_male );
            Add_Col( targets.eng_hhld_one_person_households_female );
            Add_Col( targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi + targets.eng_hhld_other_households );
            Add_Col( targets.eng_hhld_a_couple_and_other_adults_no_dependent_children );
            Add_Col( targets.eng_hhld_households_with_one_dependent_child );
            Add_Col( targets.eng_hhld_households_with_two_dependent_children );
            Add_Col( targets.eng_hhld_households_with_three_dependent_children );
            -- Add_Col( targets.eng_hhld_other_households );
         end if;
         if( country = NIR or country = UK ) then
            Add_Col( targets.nir_hhld_one_adult_households );
            Add_Col( targets.nir_hhld_two_adults_without_children );
            Add_Col( targets.nir_hhld_other_households_without_children );
            Add_Col( targets.nir_hhld_one_adult_households_with_children );
            Add_Col( targets.nir_hhld_other_households_with_children );
         end if;
         if( country = WAL or country = UK ) then
            Add_Col( targets.wal_hhld_1_person );
            Add_Col( targets.wal_hhld_2_person_no_children );
            Add_Col( targets.wal_hhld_2_person_1_adult_1_child );
            Add_Col( targets.wal_hhld_3_person_no_children );
            Add_Col( targets.wal_hhld_3_person_2_adults_1_child );
            Add_Col( targets.wal_hhld_3_person_1_adult_2_children );
            Add_Col( targets.wal_hhld_4_person_no_children );
            Add_Col( targets.wal_hhld_4_person_2_plus_adults_1_plus_children );
            Add_Col( targets.wal_hhld_4_person_1_adult_3_children );
            Add_Col( targets.wal_hhld_5_plus_person_no_children );
            Add_Col( targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children );
            Add_Col( targets.wal_hhld_5_plus_person_1_adult_4_plus_children );
            -- Add_Col( targets.wal_hhld_1_person +
               -- targets.wal_hhld_2_person_no_children +
               -- targets.wal_hhld_2_person_1_adult_1_child +
               -- targets.wal_hhld_3_person_no_children +
               -- targets.wal_hhld_3_person_2_adults_1_child +
               -- targets.wal_hhld_3_person_1_adult_2_children +
               -- targets.wal_hhld_4_person_no_children +
               -- targets.wal_hhld_4_person_2_plus_adults_1_plus_children +
               -- targets.wal_hhld_4_person_1_adult_3_children +
               -- targets.wal_hhld_5_plus_person_no_children +
               -- targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children +
               -- targets.wal_hhld_5_plus_person_1_adult_4_plus_children );
         end if;
      end if;
      -- household_all_households : Amount := 0.0;
      if clauses( genders ) then
         Add_Col( targets.male );
         Add_Col( targets.female );
      end if;
      if clauses( employment ) then      
            Add_Col( targets.employed );
      end if;
      if clauses( employees ) then      
         Add_Col( targets.employee );
      end if;
      if clauses( ilo_unemployment ) then
         Add_Col( targets.ilo_unemployed );
      end if;
      if clauses( jsa_claimants ) then
         Add_Col( targets.jsa_claimant );
      end if;
      if clauses( by_year_ages_by_gender ) then
         Add_Col( targets.age_0_male );
         Add_Col( targets.age_1_male );
         Add_Col( targets.age_2_male );
         Add_Col( targets.age_3_male );
         Add_Col( targets.age_4_male );
         Add_Col( targets.age_5_male );
         Add_Col( targets.age_6_male );
         Add_Col( targets.age_7_male );
         Add_Col( targets.age_8_male );
         Add_Col( targets.age_9_male );
         Add_Col( targets.age_10_male );
         Add_Col( targets.age_11_male );
         Add_Col( targets.age_12_male );
         Add_Col( targets.age_13_male );
         Add_Col( targets.age_14_male );
         Add_Col( targets.age_15_male );
         Add_Col( targets.age_16_male );
         Add_Col( targets.age_17_male );
         Add_Col( targets.age_18_male );
         Add_Col( targets.age_19_male );
         Add_Col( targets.age_20_male );
         Add_Col( targets.age_21_male );
         Add_Col( targets.age_22_male );
         Add_Col( targets.age_23_male );
         Add_Col( targets.age_24_male );
         Add_Col( targets.age_25_male );
         Add_Col( targets.age_26_male );
         Add_Col( targets.age_27_male );
         Add_Col( targets.age_28_male );
         Add_Col( targets.age_29_male );
         Add_Col( targets.age_30_male );
         Add_Col( targets.age_31_male );
         Add_Col( targets.age_32_male );
         Add_Col( targets.age_33_male );
         Add_Col( targets.age_34_male );
         Add_Col( targets.age_35_male );
         Add_Col( targets.age_36_male );
         Add_Col( targets.age_37_male );
         Add_Col( targets.age_38_male );
         Add_Col( targets.age_39_male );
         Add_Col( targets.age_40_male );
         Add_Col( targets.age_41_male );
         Add_Col( targets.age_42_male );
         Add_Col( targets.age_43_male );
         Add_Col( targets.age_44_male );
         Add_Col( targets.age_45_male );
         Add_Col( targets.age_46_male );
         Add_Col( targets.age_47_male );
         Add_Col( targets.age_48_male );
         Add_Col( targets.age_49_male );
         Add_Col( targets.age_50_male );
         Add_Col( targets.age_51_male );
         Add_Col( targets.age_52_male );
         Add_Col( targets.age_53_male );
         Add_Col( targets.age_54_male );
         Add_Col( targets.age_55_male );
         Add_Col( targets.age_56_male );
         Add_Col( targets.age_57_male );
         Add_Col( targets.age_58_male );
         Add_Col( targets.age_59_male );
         Add_Col( targets.age_60_male );
         Add_Col( targets.age_61_male );
         Add_Col( targets.age_62_male );
         Add_Col( targets.age_63_male );
         Add_Col( targets.age_64_male );
         Add_Col( targets.age_65_male );
         Add_Col( targets.age_66_male );
         Add_Col( targets.age_67_male );
         Add_Col( targets.age_68_male );
         Add_Col( targets.age_69_male );
         Add_Col( targets.age_70_male );
         Add_Col( targets.age_71_male );
         Add_Col( targets.age_72_male );
         Add_Col( targets.age_73_male );
         Add_Col( targets.age_74_male );
         Add_Col( targets.age_75_male );
         Add_Col( targets.age_76_male );
         Add_Col( targets.age_77_male );
         Add_Col( targets.age_78_male );
         Add_Col( targets.age_79_male );
         tmp := targets.age_80_male + targets.age_81_male + targets.age_82_male + targets.age_83_male + 
            targets.age_84_male + targets.age_85_male + targets.age_86_male + targets.age_87_male + 
            targets.age_88_male + targets.age_89_male + targets.age_90_male + targets.age_91_male + 
            targets.age_92_male + targets.age_93_male + targets.age_94_male + targets.age_95_male + 
            targets.age_96_male + targets.age_97_male + targets.age_98_male + targets.age_99_male + 
            targets.age_100_male + targets.age_101_male + targets.age_102_male + targets.age_103_male + 
            targets.age_104_male + targets.age_105_male + targets.age_106_male + targets.age_107_male + 
            targets.age_108_male + targets.age_109_male + targets.age_110_male;
         Add_Col( tmp );
         Add_Col( targets.age_0_female );
         Add_Col( targets.age_1_female );
         Add_Col( targets.age_2_female );
         Add_Col( targets.age_3_female );
         Add_Col( targets.age_4_female );
         Add_Col( targets.age_5_female );
         Add_Col( targets.age_6_female );
         Add_Col( targets.age_7_female );
         Add_Col( targets.age_8_female );
         Add_Col( targets.age_9_female );
         Add_Col( targets.age_10_female );
         Add_Col( targets.age_11_female );
         Add_Col( targets.age_12_female );
         Add_Col( targets.age_13_female );
         Add_Col( targets.age_14_female );
         Add_Col( targets.age_15_female );
         Add_Col( targets.age_16_female );
         Add_Col( targets.age_17_female );
         Add_Col( targets.age_18_female );
         Add_Col( targets.age_19_female );
         Add_Col( targets.age_20_female );
         Add_Col( targets.age_21_female );
         Add_Col( targets.age_22_female );
         Add_Col( targets.age_23_female );
         Add_Col( targets.age_24_female );
         Add_Col( targets.age_25_female );
         Add_Col( targets.age_26_female );
         Add_Col( targets.age_27_female );
         Add_Col( targets.age_28_female );
         Add_Col( targets.age_29_female );
         Add_Col( targets.age_30_female );
         Add_Col( targets.age_31_female );
         Add_Col( targets.age_32_female );
         Add_Col( targets.age_33_female );
         Add_Col( targets.age_34_female );
         Add_Col( targets.age_35_female );
         Add_Col( targets.age_36_female );
         Add_Col( targets.age_37_female );
         Add_Col( targets.age_38_female );
         Add_Col( targets.age_39_female );
         Add_Col( targets.age_40_female );
         Add_Col( targets.age_41_female );
         Add_Col( targets.age_42_female );
         Add_Col( targets.age_43_female );
         Add_Col( targets.age_44_female );
         Add_Col( targets.age_45_female );
         Add_Col( targets.age_46_female );
         Add_Col( targets.age_47_female );
         Add_Col( targets.age_48_female );
         Add_Col( targets.age_49_female );
         Add_Col( targets.age_50_female );
         Add_Col( targets.age_51_female );
         Add_Col( targets.age_52_female );
         Add_Col( targets.age_53_female );
         Add_Col( targets.age_54_female );
         Add_Col( targets.age_55_female );
         Add_Col( targets.age_56_female );
         Add_Col( targets.age_57_female );
         Add_Col( targets.age_58_female );
         Add_Col( targets.age_59_female );
         Add_Col( targets.age_60_female );
         Add_Col( targets.age_61_female );
         Add_Col( targets.age_62_female );
         Add_Col( targets.age_63_female );
         Add_Col( targets.age_64_female );
         Add_Col( targets.age_65_female );
         Add_Col( targets.age_66_female );
         Add_Col( targets.age_67_female );
         Add_Col( targets.age_68_female );
         Add_Col( targets.age_69_female );
         Add_Col( targets.age_70_female );
         Add_Col( targets.age_71_female );
         Add_Col( targets.age_72_female );
         Add_Col( targets.age_73_female );
         Add_Col( targets.age_74_female );
         Add_Col( targets.age_75_female );
         Add_Col( targets.age_76_female );
         Add_Col( targets.age_77_female );
         Add_Col( targets.age_78_female );
         Add_Col( targets.age_79_female );
         tmp := targets.age_80_female + targets.age_81_female + targets.age_82_female + targets.age_83_female + 
            targets.age_84_female + targets.age_85_female + targets.age_86_female + targets.age_87_female + 
            targets.age_88_female + targets.age_89_female + targets.age_90_female + targets.age_91_female + 
            targets.age_92_female + targets.age_93_female + targets.age_94_female + targets.age_95_female + 
            targets.age_96_female + targets.age_97_female + targets.age_98_female + targets.age_99_female + 
            targets.age_100_female + targets.age_101_female + targets.age_102_female + targets.age_103_female + 
            targets.age_104_female + targets.age_105_female + targets.age_106_female + targets.age_107_female + 
            targets.age_108_female + targets.age_109_female + targets.age_110_female;
         Add_Col( tmp );
      end if;

      if clauses( aggregate_ages_by_gender ) then
         tmp := targets.age_0_male + targets.age_1_male + targets.age_2_male + targets.age_3_male + targets.age_4_male;
         Add_Col( tmp );
         tmp := targets.age_5_male + targets.age_6_male + targets.age_7_male + targets.age_8_male + targets.age_9_male + targets.age_10_male;
         Add_Col( tmp );
         tmp := targets.age_11_male + targets.age_12_male + targets.age_13_male + targets.age_14_male + targets.age_15_male;
         Add_Col( tmp );
         tmp := targets.age_16_male + targets.age_17_male + targets.age_18_male + targets.age_19_male;
         Add_Col( tmp );
         tmp := targets.age_20_male + targets.age_21_male + targets.age_22_male + targets.age_23_male + targets.age_24_male;
         Add_Col( tmp );
         tmp := targets.age_25_male + targets.age_26_male + targets.age_27_male + targets.age_28_male + targets.age_29_male;
         Add_Col( tmp );
         tmp := targets.age_30_male + targets.age_31_male + targets.age_32_male + targets.age_33_male + targets.age_34_male;
         Add_Col( tmp );
         tmp := targets.age_35_male + targets.age_36_male + targets.age_37_male + targets.age_38_male + targets.age_39_male;
         Add_Col( tmp );
         tmp := targets.age_40_male + targets.age_41_male + targets.age_42_male + targets.age_43_male + targets.age_44_male;
         Add_Col( tmp );
         tmp := targets.age_45_male + targets.age_46_male + targets.age_47_male + targets.age_48_male + targets.age_49_male;
         Add_Col( tmp );
         tmp := targets.age_50_male + targets.age_51_male + targets.age_52_male + targets.age_53_male + targets.age_54_male;
         Add_Col( tmp );
         tmp := targets.age_55_male + targets.age_56_male + targets.age_57_male + targets.age_58_male + targets.age_59_male;
         Add_Col( tmp );
         tmp := targets.age_60_male + targets.age_61_male + targets.age_62_male + targets.age_63_male + targets.age_64_male;
         Add_Col( tmp );
         tmp := targets.age_65_male + targets.age_66_male + targets.age_67_male + targets.age_68_male + targets.age_69_male;
         Add_Col( tmp );
         tmp := targets.age_70_male + targets.age_71_male + targets.age_72_male + targets.age_73_male + targets.age_74_male;
         Add_Col( tmp );
         tmp := targets.age_75_male + targets.age_76_male + targets.age_77_male + targets.age_78_male + targets.age_79_male;
         Add_Col( tmp );
         tmp := targets.age_80_male + targets.age_81_male + targets.age_82_male + targets.age_83_male + 
            targets.age_84_male + targets.age_85_male + targets.age_86_male + targets.age_87_male + 
            targets.age_88_male + targets.age_89_male + targets.age_90_male + targets.age_91_male + 
            targets.age_92_male + targets.age_93_male + targets.age_94_male + targets.age_95_male + 
            targets.age_96_male + targets.age_97_male + targets.age_98_male + targets.age_99_male + 
            targets.age_100_male + targets.age_101_male + targets.age_102_male + targets.age_103_male + 
            targets.age_104_male + targets.age_105_male + targets.age_106_male + targets.age_107_male + 
            targets.age_108_male + targets.age_109_male + targets.age_110_male;
         Add_Col( tmp );
         tmp := targets.age_0_female + targets.age_1_female + targets.age_2_female + targets.age_3_female + targets.age_4_female;
         Add_Col( tmp );
         tmp := targets.age_5_female + targets.age_6_female + targets.age_7_female + targets.age_8_female + targets.age_9_female + targets.age_10_female;
         Add_Col( tmp );
         tmp := targets.age_11_female + targets.age_12_female + targets.age_13_female + targets.age_14_female + targets.age_15_female;
         Add_Col( tmp );
         tmp := targets.age_16_female + targets.age_17_female + targets.age_18_female + targets.age_19_female;
         Add_Col( tmp );
         tmp := targets.age_20_female + targets.age_21_female + targets.age_22_female + targets.age_23_female + targets.age_24_female;
         Add_Col( tmp );
         tmp := targets.age_25_female + targets.age_26_female + targets.age_27_female + targets.age_28_female + targets.age_29_female;
         Add_Col( tmp );
         tmp := targets.age_30_female + targets.age_31_female + targets.age_32_female + targets.age_33_female + targets.age_34_female;
         Add_Col( tmp );
         tmp := targets.age_35_female + targets.age_36_female + targets.age_37_female + targets.age_38_female + targets.age_39_female;
         Add_Col( tmp );
         tmp := targets.age_40_female + targets.age_41_female + targets.age_42_female + targets.age_43_female + targets.age_44_female;
         Add_Col( tmp );
         tmp := targets.age_45_female + targets.age_46_female + targets.age_47_female + targets.age_48_female + targets.age_49_female;
         Add_Col( tmp );
         tmp := targets.age_50_female + targets.age_51_female + targets.age_52_female + targets.age_53_female + targets.age_54_female;
         Add_Col( tmp );
         tmp := targets.age_55_female + targets.age_56_female + targets.age_57_female + targets.age_58_female + targets.age_59_female;
         Add_Col( tmp );
         tmp := targets.age_60_female + targets.age_61_female + targets.age_62_female + targets.age_63_female + targets.age_64_female;
         Add_Col( tmp );
         tmp := targets.age_65_female + targets.age_66_female + targets.age_67_female + targets.age_68_female + targets.age_69_female;
         Add_Col( tmp );
         tmp := targets.age_70_female + targets.age_71_female + targets.age_72_female + targets.age_73_female + targets.age_74_female;
         Add_Col( tmp );
         tmp := targets.age_75_female + targets.age_76_female + targets.age_77_female + targets.age_78_female + targets.age_79_female;
         Add_Col( tmp );
         tmp := targets.age_80_female + targets.age_81_female + targets.age_82_female + targets.age_83_female + targets.age_84_female + 
            targets.age_85_female + targets.age_86_female + targets.age_87_female + targets.age_88_female + 
            targets.age_89_female + targets.age_90_female + targets.age_91_female + targets.age_92_female + 
            targets.age_93_female + targets.age_94_female + targets.age_95_female + targets.age_96_female + 
            targets.age_97_female + targets.age_98_female + targets.age_99_female + targets.age_100_female + 
            targets.age_101_female + targets.age_102_female + targets.age_103_female + targets.age_104_female + 
            targets.age_105_female + targets.age_106_female + targets.age_107_female + targets.age_108_female + 
            targets.age_109_female + targets.age_110_female;
         Add_Col( tmp );
      end if;      
      if clauses( participation_rate ) then
         -- Add_Col( targets.participation_16_19_male );
         Add_Col( targets.participation_20_24_male );
         Add_Col( targets.participation_25_29_male );
         Add_Col( targets.participation_30_34_male );
         Add_Col( targets.participation_35_39_male );
         Add_Col( targets.participation_40_44_male );
         Add_Col( targets.participation_45_49_male );
         Add_Col( targets.participation_50_54_male );
         Add_Col( targets.participation_55_59_male );
         Add_Col( targets.participation_60_64_male );
         Add_Col( targets.participation_65_69_male );
         Add_Col( targets.participation_70_74_male );
         -- Add_Col( targets.participation_75_plus_male );
         -- Add_Col( targets.participation_16_19_female );
         Add_Col( targets.participation_20_24_female );
         Add_Col( targets.participation_25_29_female );
         Add_Col( targets.participation_30_34_female );
         Add_Col( targets.participation_35_39_female );
         Add_Col( targets.participation_40_44_female );
         Add_Col( targets.participation_45_49_female );
         Add_Col( targets.participation_50_54_female );
         Add_Col( targets.participation_55_59_female );
         Add_Col( targets.participation_60_64_female );
         Add_Col( targets.participation_65_69_female );
         Add_Col( targets.participation_70_74_female );
         -- Add_Col( targets.participation_75_plus_female );
      end if;
      Assert( p = row'Length, " not all rows filled " & p'Img & " vs " & row'Length'Img );
    end Fill_One_Row;
      
    
   function Filename_From_Run( the_run : Run ) return String is
      targets_run : Run := Run_IO.Retrieve_By_PK( the_run.targets_run_id, 1 );
   begin
      return 
         Censor_String( the_run.run_id'Img ) & "_" &
         Censor_String( TS( the_run.country )) & "_" &
         Censor_String( the_run.start_year'Img ) & "_" &
         Censor_String( the_run.end_year'Img ) & "_" &
         Censor_String( TS( targets_run.households_variant )) & "_" &
         Censor_String( TS( targets_run.population_variant )) & "_" &
         Censor_String( TS( targets_run.macro_variant )) & "_" &
         Censor_String( the_run.data_start_year'Img ) & "_" &
         Censor_String( the_run.data_end_year'Img );
   end  Filename_From_Run;
   
   procedure Print_Vector( 
      targetsf : File_Type;
      year : Year_Number; 
      target_populations : Vector ) is
   begin
      Put( targetsf, year'Img & TAB );
      for c in target_populations'Range loop
         FIO.Put( targetsf, target_populations( c ), 2, 4, 0 );
         if c < target_populations'Last then
            Put( targetsf, TAB );
         else
            New_Line( targetsf );
         end if;
      end loop;
   end Print_Vector;               
   
   procedure Create_Weights( 
      the_run : Run;
      error   : out Eval_Error_Type ) is

   use GNATCOLL.SQL.Exec;
   package d renames DB_Commons;
   
      col_labels           : constant Unbounded_String_List := Col_Names( the_run.selected_clauses, the_run.country );
      num_data_cols        : constant Positive := Positive( col_labels.Length );
      num_data_rows        : Positive;
      conn                 : Database_Connection;
      d_cursor             : GNATCOLL.SQL.Exec.Direct_Cursor;
      f_cursor             : GNATCOLL.SQL.Exec.Forward_Cursor;
      frs_target_row       : Target_Dataset;
      ps                   : GNATCOLL.SQL.Exec.Prepared_Statement;   
      count                : Natural := 0;
      frs_criteria         : d.Criteria;
      mapped_target_data   : Vector( 1 .. num_data_cols );
      outfile_name         : constant String := "output/" & Filename_From_Run( the_run ) & ".tab";
      targets_outfile_name : constant String := "output/" & Filename_From_Run( the_run ) & "-targets.tab";
      diffs_outfile_name   : constant String := "output/" & Filename_From_Run( the_run ) & "-diffs.tab";
      outf                 : File_Type;
      targetsf             : File_Type;
      diffsf               : File_Type;
    begin
       
      Trace( log_trace,  "Begining run for : " & To_String( the_run ));
      Create( outf, Out_File, outfile_name );
      Create( targetsf, Out_File, targets_outfile_name );
      Create( diffsf, Out_File, diffs_outfile_name );
      Put_Line( targetsf, TAB & col_labels.Join );
      Put_Line( outf, "run_id" & TAB & "user" & TAB & "frs_year" & TAB & "sernum" & TAB & "forecast_year" & TAB & "weight" );

      Connection_Pool.Initialise;
      conn := Connection_Pool.Lease;
      Target_Dataset_IO.Add_User_Id( frs_criteria, the_run.data_run_user_id );
      Target_Dataset_IO.Add_Run_Id( frs_criteria, the_run.data_run_id );
      if the_run.country = SCO then
         Target_Dataset_IO.Add_Country_Scotland( frs_criteria, 1.0 );
      elsif the_run.country = WAL then
         Target_Dataset_IO.Add_Country_Wales( frs_criteria, 1.0 );
      elsif the_run.country = NIR then
         Target_Dataset_IO.Add_Country_N_Ireland( frs_criteria, 1.0 );
      elsif the_run.country = ENG then
         Target_Dataset_IO.Add_Country_England( frs_criteria, 1.0 );
      end if; -- UK doesn't need this
      Target_Dataset_IO.Add_hbai_excluded( frs_criteria, False );
      Target_Dataset_IO.Add_Year( frs_criteria, the_run.data_start_year, d.GE );
      Target_Dataset_IO.Add_Year( frs_criteria, the_run.data_end_year, d.LE );
      Target_Dataset_IO.Add_Year_To_Orderings( frs_criteria, d.Asc );
      Target_Dataset_IO.Add_Sernum_To_Orderings( frs_criteria, d.Asc );
      
      ps := Target_Dataset_IO.Get_Prepared_Retrieve_Statement( frs_criteria );            
      d_cursor.Fetch( conn, ps ); -- hack to get row count, otherwise unused
      num_data_rows := Rows_Count( d_cursor );
      f_cursor.Fetch( conn, ps );
      Trace( log_trace,  "num_data_rows " & num_data_rows'Img );
      --
      -- now we know how many rows & cols in the weighting dataset,
      -- we can declare stuff..
      --
      declare
         package Reweighter is new Maths_Funcs.Weights_Generator(    
            Num_Constraints   => num_data_cols,
            Num_Observations  => num_data_rows );
         subtype Col_Vector is Reweighter.Col_Vector;
         subtype Row_Vector is Reweighter.Row_Vector;
         subtype Dataset    is Reweighter.Dataset;
         type Indexes_Array is array( 1 .. num_data_rows ) of Weights_Index;
         type Indexes_Array_Access is access Indexes_Array; 
         --
         -- Stack overflow workaround
         --
         type Dataset_Access is access Reweighter.Dataset;
         procedure Free_Dataset is new Ada.Unchecked_Deallocation(
            Object => Dataset, Name => Dataset_Access );
         procedure Free_Indexes is new Ada.Unchecked_Deallocation(
            Object => Indexes_Array, Name => Indexes_Array_Access );
         observations       : Dataset_Access;
         target_populations : Row_Vector;
         weights_indexes    : Indexes_Array_Access;
         mapped_frs_data    : Vector( 1 .. num_data_cols );
         new_totals         : Row_Vector;
         weights            : Col_Vector;
         by_country_sample_frequencies : Col_Vector;
      begin
         Trace( log_trace,  "Num Data Columns " & num_data_cols'Img & " Rows " & num_data_rows'Img );
         
         weights_indexes := new Indexes_Array;
         observations := new Dataset;
         observations.all := ( others => ( others => 0.0 ));
         --
         -- load the main dataset
         -- 
         Load_Main_Dataset:
         for row in 1 .. num_data_rows loop
            frs_target_row := Target_Dataset_IO.Map_From_Cursor( f_cursor );
            Fill_One_Row( the_run.selected_clauses, the_run.country, frs_target_row, mapped_frs_data, by_country_sample_frequencies( row ));
            Trace( log_trace,  "made row " &row'Img & "=" & To_String( mapped_frs_data ));
            for col in mapped_target_data'Range loop
               observations.all( row, col ) :=  mapped_frs_data( col );                 
            end loop;
            -- .. and store a list of hrefs and years to go alongside it
            weights_indexes.all( row ).sernum := frs_target_row.sernum;
            weights_indexes.all( row ).year := frs_target_row.year;
            if row < num_data_rows then
               Next( f_cursor );
            end if;
         end loop Load_Main_Dataset;
            
         Each_Year:
         for year in the_run.start_year .. the_run.end_year loop
            declare
               targets     : Target_Dataset := Target_Dataset_IO.Retrieve_By_PK(
                  run_id => the_run.targets_run_id,
                  user_id => the_run.targets_run_user_id,
                  year    => year,
                  sernum  => -9         
               );
               uniform_weight     : Amount;
               base_target        : Amount;
               curr_iterations    : Natural := 0;
               initial_weights    : Col_Vector;
               dummy              : Amount;
            begin
               -- we need this pro tem as we have no hhld count for UK/ENG yet
               if the_run.country = TuS( "SCO" ) then
                  base_target := targets.country_scotland;
               elsif the_run.country = TuS( "UK" ) then
                  base_target := targets.household_all_households;
               end if; 
               uniform_weight := 
                  base_target / sum( by_country_sample_frequencies );
               for row in initial_weights'Range loop -- FIXME should just need '*' but doesn't work..
                  initial_weights(row) := by_country_sample_frequencies(row) * uniform_weight;
               end loop;
               Trace( log_trace,  "on year " & year'Img );
               Trace( log_trace,  "Initial Weight : " & Format( uniform_weight ));
               Trace( log_trace,  "Base Target : " & Format( base_target ));
               -- typecasting thing .. 
               Fill_One_Row( the_run.selected_clauses, the_run.country, targets, mapped_target_data, dummy ); 
               for c in target_populations'Range loop
                  target_populations( c ) :=  mapped_target_data( c );                 
               end loop;
               new_totals := Reweighter.Sum_Dataset( observations.all, initial_weights );
               
               Print_Vector( targetsf, year, target_populations );
               Print_Diffs( diffsf, year, "CRUDE WEIGHTED", col_labels, target_populations, new_totals );
               
               Assert(( for all r of mapped_target_data => r > 0.0 ), 
                  " there is a zero in target output row " & To_String( mapped_target_data ));
               Reweighter.Do_Reweighting(
                  Data               => observations.all, 
                  Which_Function     => the_run.weighting_function,
                  Initial_Weights    => initial_weights,            
                  Target_Populations => target_populations,
                  TolX               => 0.01,
                  TolF               => 0.01,
                  Max_Iterations     => 40,
                  RU                 => the_run.Weighting_Upper_Bound,
                  RL                 => the_run.Weighting_Lower_Bound,
                  New_Weights        => weights,
                  Iterations         => curr_iterations,
                  Error              => error );
               Trace( log_trace,  "error " & error'Img );
               Trace( log_trace,  "iterations " & curr_iterations'Img );
               if error = normal then
                  for row in 1 .. num_data_rows loop
                     declare
                        use Ada.Calendar;
                        out_weight  : constant Output_Weights := ( 
                           run_id => the_run.run_id,
                           user_id => the_run.user_id,
                           year    => weights_indexes.all( row ).year,
                           sernum  => weights_indexes.all( row ).sernum,
                           target_year => year,
                           weight  =>  weights( row ));
                     begin
                        null;
                        Put_Line( outf, To_Tab( out_weight ));
                        -- Trace( log_trace,  "adding " & To_String( out_weight ));
                        -- Output_Weights_IO.Save( out_weight );
                        -- weighter.Add( year, id, this_weight, weight );
                     end;
                  end loop;
               end if;
               new_totals := Reweighter.Sum_Dataset( observations.all, weights );
               Print_Diffs( diffsf, year, "FINAL WEIGHTED", col_labels, target_populations, new_totals );
            end;
         end loop Each_Year;
         Trace( log_trace,  "Done; freeing datasets" );
         Free_Dataset( observations );   
         Free_Indexes( weights_indexes );   
      end; -- decls for main dataset
      Trace( log_trace,  "returning connection" );
      Connection_Pool.Return_Connection( conn );
      Close( outf );
      Close( targetsf );
      Close( diffsf );
   end  Create_Weights; 
   
end Model.SCP.Weights_Creator;