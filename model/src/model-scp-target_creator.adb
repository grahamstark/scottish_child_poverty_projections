with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with Data_Constants;
with Base_Model_Types;
with Text_Utils;
with SCP_Types;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Macro_Forecasts_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.England_Households_IO;
with Ukds.Target_Data.Wales_Households_IO;
with Ukds.Target_Data.Nireland_Households_IO;


with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.Target_Dataset_IO;

with DB_Commons;

with Connection_Pool;


package body Model.SCP.Target_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use Text_Utils;   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   use Ada.Strings.Unbounded;
   use GNATCOLL.SQL.Exec;
   use SCP_Types;
   
   package d renames DB_Commons;
   

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.SCP.TARGET_CREATOR" );
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
   procedure Create_Dataset( the_run : Run ) is
      pop_crit : d.Criteria;
      mac_crit : d.Criteria;
      hh_crit : d.Criteria;
   begin
      -- Population_Forecasts_IO.Add_Variant( pop_crit, the_run.people_source ); 
      -- Households_Forecasts_IO.Add_Variant( hh_crit, the_run.household_source );
      -- Macro_Forecasts_IO.Add_Variant( mac_crit, the_run.macro_source );
      for year in the_run.start_year .. the_run.end_year loop
         
         declare
            female_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "FEMALES" )                           
            );
            male_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => PERSONS,
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "MALES" )                           
            );
            scottish_households : constant Households_Forecasts := Households_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => SCO,
               edition  => the_run.households_edition                   
            );
           england_hhlds : constant England_Households := England_Households_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => ENG,
               edition  => the_run.households_edition                   
            );
            wales_hhlds : constant Wales_Households := Wales_Households_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => WAL,
               edition  => the_run.households_edition                   
            );
            nireland_hhlds : constant Nireland_Households := Nireland_Households_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => NIR,
               edition  => the_run.households_edition                   
            );
            
            macro_data : constant Macro_Forecasts := Macro_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => MACRO,
               variant  => the_run.macro_variant,
               country  => UK, -- for now ..
               edition  => the_run.macro_edition                   
            );
            
            
            
            age_16_plus : Amount := 0.0;
            targets     : Target_Dataset; 
         begin

            targets.run_id := the_run.run_id;
            targets.user_id := the_run.user_id;
            targets.year := year;
            targets.sernum := Sernum_Value'First;
            if scottish_households /= Null_Households_Forecasts then
               targets.sco_hhld_one_adult_male := scottish_households.one_adult_male;
               targets.sco_hhld_one_adult_female := scottish_households.one_adult_female;
               targets.sco_hhld_two_adults := scottish_households.two_adults;
               targets.sco_hhld_one_adult_one_child := scottish_households.one_adult_one_child;
               targets.sco_hhld_one_adult_two_plus_children := scottish_households.one_adult_two_plus_children;
               targets.sco_hhld_two_plus_adult_one_plus_children := scottish_households.two_plus_adult_one_plus_children;
               targets.sco_hhld_three_plus_person_all_adult := scottish_households.three_plus_person_all_adult;
               targets.household_all_households := targets.household_all_households + scottish_households.all_households;
               targets.country_scotland := scottish_households.all_households;
            end if;
            if england_hhlds /= Null_England_Households then   -- actually this is redundant since we'll assign to zero either way          
               targets.eng_hhld_one_person_households_male := england_hhlds.one_person_households_male;
               targets.eng_hhld_one_person_households_female := england_hhlds.one_person_households_female;
               targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi := england_hhlds.one_family_and_no_others_couple_no_dependent_children;
               targets.eng_hhld_a_couple_and_other_adults_no_dependent_children := england_hhlds.a_couple_and_one_or_more_other_adults_no_dependent_children;
               targets.eng_hhld_households_with_one_dependent_child := england_hhlds.households_with_one_dependent_child;
               targets.eng_hhld_households_with_two_dependent_children := england_hhlds.households_with_two_dependent_children;
               targets.eng_hhld_households_with_three_dependent_children := england_hhlds.households_with_three_dependent_children;
               targets.eng_hhld_other_households := england_hhlds.other_households;
               declare
                  s : constant Amount := 
                  targets.eng_hhld_one_person_households_male +
                  targets.eng_hhld_one_person_households_female +
                  targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi +
                  targets.eng_hhld_a_couple_and_other_adults_no_dependent_children +
                  targets.eng_hhld_households_with_one_dependent_child +
                  targets.eng_hhld_households_with_two_dependent_children +
                  targets.eng_hhld_households_with_three_dependent_children +
                  targets.eng_hhld_other_households;
               begin      
                  Inc( targets.household_all_households, s );
                  Inc( targets.country_england, s );              
               end;
            end if;
            
            
            
            targets.age_0_male := male_popn.age_0;
            targets.age_0_female := female_popn.age_0;
            targets.age_1_male := male_popn.age_1;
            targets.age_1_female := female_popn.age_1;
            targets.age_2_male := male_popn.age_2;
            targets.age_2_female := female_popn.age_2;
            targets.age_3_male := male_popn.age_3;
            targets.age_3_female := female_popn.age_3;
            targets.age_4_male := male_popn.age_4;
            targets.age_4_female := female_popn.age_4;
            targets.age_5_male := male_popn.age_5;
            targets.age_5_female := female_popn.age_5;
            targets.age_6_male := male_popn.age_6;
            targets.age_6_female := female_popn.age_6;
            targets.age_7_male := male_popn.age_7;
            targets.age_7_female := female_popn.age_7;
            targets.age_8_male := male_popn.age_8;
            targets.age_8_female := female_popn.age_8;
            targets.age_9_male := male_popn.age_9;
            targets.age_9_female := female_popn.age_9;
            targets.age_10_male := male_popn.age_10;
            targets.age_10_female := female_popn.age_10;
            targets.age_11_male := male_popn.age_11;
            targets.age_11_female := female_popn.age_11;
            targets.age_12_male := male_popn.age_12;
            targets.age_12_female := female_popn.age_12;
            targets.age_13_male := male_popn.age_13;
            targets.age_13_female := female_popn.age_13;
            targets.age_14_male := male_popn.age_14;
            targets.age_14_female := female_popn.age_14;
            targets.age_15_male := male_popn.age_15;
            targets.age_15_female := female_popn.age_15;
            targets.age_16_male := male_popn.age_16;
            targets.age_16_female := female_popn.age_16;
            targets.age_17_male := male_popn.age_17;
            targets.age_17_female := female_popn.age_17;
            targets.age_18_male := male_popn.age_18;
            targets.age_18_female := female_popn.age_18;
            targets.age_19_male := male_popn.age_19;
            targets.age_19_female := female_popn.age_19;
            targets.age_20_male := male_popn.age_20;
            targets.age_20_female := female_popn.age_20;
            targets.age_21_male := male_popn.age_21;
            targets.age_21_female := female_popn.age_21;
            targets.age_22_male := male_popn.age_22;
            targets.age_22_female := female_popn.age_22;
            targets.age_23_male := male_popn.age_23;
            targets.age_23_female := female_popn.age_23;
            targets.age_24_male := male_popn.age_24;
            targets.age_24_female := female_popn.age_24;
            targets.age_25_male := male_popn.age_25;
            targets.age_25_female := female_popn.age_25;
            targets.age_26_male := male_popn.age_26;
            targets.age_26_female := female_popn.age_26;
            targets.age_27_male := male_popn.age_27;
            targets.age_27_female := female_popn.age_27;
            targets.age_28_male := male_popn.age_28;
            targets.age_28_female := female_popn.age_28;
            targets.age_29_male := male_popn.age_29;
            targets.age_29_female := female_popn.age_29;
            targets.age_30_male := male_popn.age_30;
            targets.age_30_female := female_popn.age_30;
            targets.age_31_male := male_popn.age_31;
            targets.age_31_female := female_popn.age_31;
            targets.age_32_male := male_popn.age_32;
            targets.age_32_female := female_popn.age_32;
            targets.age_33_male := male_popn.age_33;
            targets.age_33_female := female_popn.age_33;
            targets.age_34_male := male_popn.age_34;
            targets.age_34_female := female_popn.age_34;
            targets.age_35_male := male_popn.age_35;
            targets.age_35_female := female_popn.age_35;
            targets.age_36_male := male_popn.age_36;
            targets.age_36_female := female_popn.age_36;
            targets.age_37_male := male_popn.age_37;
            targets.age_37_female := female_popn.age_37;
            targets.age_38_male := male_popn.age_38;
            targets.age_38_female := female_popn.age_38;
            targets.age_39_male := male_popn.age_39;
            targets.age_39_female := female_popn.age_39;
            targets.age_40_male := male_popn.age_40;
            targets.age_40_female := female_popn.age_40;
            targets.age_41_male := male_popn.age_41;
            targets.age_41_female := female_popn.age_41;
            targets.age_42_male := male_popn.age_42;
            targets.age_42_female := female_popn.age_42;
            targets.age_43_male := male_popn.age_43;
            targets.age_43_female := female_popn.age_43;
            targets.age_44_male := male_popn.age_44;
            targets.age_44_female := female_popn.age_44;
            targets.age_45_male := male_popn.age_45;
            targets.age_45_female := female_popn.age_45;
            targets.age_46_male := male_popn.age_46;
            targets.age_46_female := female_popn.age_46;
            targets.age_47_male := male_popn.age_47;
            targets.age_47_female := female_popn.age_47;
            targets.age_48_male := male_popn.age_48;
            targets.age_48_female := female_popn.age_48;
            targets.age_49_male := male_popn.age_49;
            targets.age_49_female := female_popn.age_49;
            targets.age_50_male := male_popn.age_50;
            targets.age_50_female := female_popn.age_50;
            targets.age_51_male := male_popn.age_51;
            targets.age_51_female := female_popn.age_51;
            targets.age_52_male := male_popn.age_52;
            targets.age_52_female := female_popn.age_52;
            targets.age_53_male := male_popn.age_53;
            targets.age_53_female := female_popn.age_53;
            targets.age_54_male := male_popn.age_54;
            targets.age_54_female := female_popn.age_54;
            targets.age_55_male := male_popn.age_55;
            targets.age_55_female := female_popn.age_55;
            targets.age_56_male := male_popn.age_56;
            targets.age_56_female := female_popn.age_56;
            targets.age_57_male := male_popn.age_57;
            targets.age_57_female := female_popn.age_57;
            targets.age_58_male := male_popn.age_58;
            targets.age_58_female := female_popn.age_58;
            targets.age_59_male := male_popn.age_59;
            targets.age_59_female := female_popn.age_59;
            targets.age_60_male := male_popn.age_60;
            targets.age_60_female := female_popn.age_60;
            targets.age_61_male := male_popn.age_61;
            targets.age_61_female := female_popn.age_61;
            targets.age_62_male := male_popn.age_62;
            targets.age_62_female := female_popn.age_62;
            targets.age_63_male := male_popn.age_63;
            targets.age_63_female := female_popn.age_63;
            targets.age_64_male := male_popn.age_64;
            targets.age_64_female := female_popn.age_64;
            targets.age_65_male := male_popn.age_65;
            targets.age_65_female := female_popn.age_65;
            targets.age_66_male := male_popn.age_66;
            targets.age_66_female := female_popn.age_66;
            targets.age_67_male := male_popn.age_67;
            targets.age_67_female := female_popn.age_67;
            targets.age_68_male := male_popn.age_68;
            targets.age_68_female := female_popn.age_68;
            targets.age_69_male := male_popn.age_69;
            targets.age_69_female := female_popn.age_69;
            targets.age_70_male := male_popn.age_70;
            targets.age_70_female := female_popn.age_70;
            targets.age_71_male := male_popn.age_71;
            targets.age_71_female := female_popn.age_71;
            targets.age_72_male := male_popn.age_72;
            targets.age_72_female := female_popn.age_72;
            targets.age_73_male := male_popn.age_73;
            targets.age_73_female := female_popn.age_73;
            targets.age_74_male := male_popn.age_74;
            targets.age_74_female := female_popn.age_74;
            targets.age_75_male := male_popn.age_75;
            targets.age_75_female := female_popn.age_75;
            targets.age_76_male := male_popn.age_76;
            targets.age_76_female := female_popn.age_76;
            targets.age_77_male := male_popn.age_77;
            targets.age_77_female := female_popn.age_77;
            targets.age_78_male := male_popn.age_78;
            targets.age_78_female := female_popn.age_78;
            targets.age_79_male := male_popn.age_79;
            targets.age_79_female := female_popn.age_79;
            targets.age_80_male := male_popn.age_80;
            targets.age_80_female := female_popn.age_80;
            targets.age_81_male := male_popn.age_81;
            targets.age_81_female := female_popn.age_81;
            targets.age_82_male := male_popn.age_82;
            targets.age_82_female := female_popn.age_82;
            targets.age_83_male := male_popn.age_83;
            targets.age_83_female := female_popn.age_83;
            targets.age_84_male := male_popn.age_84;
            targets.age_84_female := female_popn.age_84;
            targets.age_85_male := male_popn.age_85;
            targets.age_85_female := female_popn.age_85;
            targets.age_86_male := male_popn.age_86;
            targets.age_86_female := female_popn.age_86;
            targets.age_87_male := male_popn.age_87;
            targets.age_87_female := female_popn.age_87;
            targets.age_88_male := male_popn.age_88;
            targets.age_88_female := female_popn.age_88;
            targets.age_89_male := male_popn.age_89;
            targets.age_89_female := female_popn.age_89;
            targets.age_90_male := male_popn.age_90;
            targets.age_90_female := female_popn.age_90;
            targets.age_91_male := male_popn.age_91;
            targets.age_91_female := female_popn.age_91;
            targets.age_92_male := male_popn.age_92;
            targets.age_92_female := female_popn.age_92;
            targets.age_93_male := male_popn.age_93;
            targets.age_93_female := female_popn.age_93;
            targets.age_94_male := male_popn.age_94;
            targets.age_94_female := female_popn.age_94;
            targets.age_95_male := male_popn.age_95;
            targets.age_95_female := female_popn.age_95;
            targets.age_96_male := male_popn.age_96;
            targets.age_96_female := female_popn.age_96;
            targets.age_97_male := male_popn.age_97;
            targets.age_97_female := female_popn.age_97;
            targets.age_98_male := male_popn.age_98;
            targets.age_98_female := female_popn.age_98;
            targets.age_99_male := male_popn.age_99;
            targets.age_99_female := female_popn.age_99;
            targets.age_100_male := male_popn.age_100;
            targets.age_100_female := female_popn.age_100;
            targets.age_101_male := male_popn.age_101;
            targets.age_101_female := female_popn.age_101;
            targets.age_102_male := male_popn.age_102;
            targets.age_102_female := female_popn.age_102;
            targets.age_103_male := male_popn.age_103;
            targets.age_103_female := female_popn.age_103;
            targets.age_104_male := male_popn.age_104;
            targets.age_104_female := female_popn.age_104;
            targets.age_105_male := male_popn.age_105;
            targets.age_105_female := female_popn.age_105;
            targets.age_106_male := male_popn.age_106;
            targets.age_106_female := female_popn.age_106;
            targets.age_107_male := male_popn.age_107;
            targets.age_107_female := female_popn.age_107;
            targets.age_108_male := male_popn.age_108;
            targets.age_108_female := female_popn.age_108;
            targets.age_109_male := male_popn.age_109;
            targets.age_109_female := female_popn.age_109;
            targets.age_110_male := male_popn.age_110;
            targets.age_110_female := female_popn.age_110;
                       
            Inc( targets.male, male_popn.age_0 );
            Inc( targets.female, female_popn.age_0 );
            Inc( targets.male, male_popn.age_1 );
            Inc( targets.female, female_popn.age_1 );
            Inc( targets.male, male_popn.age_2 );
            Inc( targets.female, female_popn.age_2 );
            Inc( targets.male, male_popn.age_3 );
            Inc( targets.female, female_popn.age_3 );
            Inc( targets.male, male_popn.age_4 );
            Inc( targets.female, female_popn.age_4 );
            Inc( targets.male, male_popn.age_5 );
            Inc( targets.female, female_popn.age_5 );
            Inc( targets.male, male_popn.age_6 );
            Inc( targets.female, female_popn.age_6 );
            Inc( targets.male, male_popn.age_7 );
            Inc( targets.female, female_popn.age_7 );
            Inc( targets.male, male_popn.age_8 );
            Inc( targets.female, female_popn.age_8 );
            Inc( targets.male, male_popn.age_9 );
            Inc( targets.female, female_popn.age_9 );
            Inc( targets.male, male_popn.age_10 );
            Inc( targets.female, female_popn.age_10 );
            Inc( targets.male, male_popn.age_11 );
            Inc( targets.female, female_popn.age_11 );
            Inc( targets.male, male_popn.age_12 );
            Inc( targets.female, female_popn.age_12 );
            Inc( targets.male, male_popn.age_13 );
            Inc( targets.female, female_popn.age_13 );
            Inc( targets.male, male_popn.age_14 );
            Inc( targets.female, female_popn.age_14 );
            Inc( targets.male, male_popn.age_15 );
            Inc( targets.female, female_popn.age_15 );
            Inc( targets.male, male_popn.age_16 );
            Inc( targets.female, female_popn.age_16 );
            Inc( targets.male, male_popn.age_17 );
            Inc( targets.female, female_popn.age_17 );
            Inc( targets.male, male_popn.age_18 );
            Inc( targets.female, female_popn.age_18 );
            Inc( targets.male, male_popn.age_19 );
            Inc( targets.female, female_popn.age_19 );
            Inc( targets.male, male_popn.age_20 );
            Inc( targets.female, female_popn.age_20 );
            Inc( targets.male, male_popn.age_21 );
            Inc( targets.female, female_popn.age_21 );
            Inc( targets.male, male_popn.age_22 );
            Inc( targets.female, female_popn.age_22 );
            Inc( targets.male, male_popn.age_23 );
            Inc( targets.female, female_popn.age_23 );
            Inc( targets.male, male_popn.age_24 );
            Inc( targets.female, female_popn.age_24 );
            Inc( targets.male, male_popn.age_25 );
            Inc( targets.female, female_popn.age_25 );
            Inc( targets.male, male_popn.age_26 );
            Inc( targets.female, female_popn.age_26 );
            Inc( targets.male, male_popn.age_27 );
            Inc( targets.female, female_popn.age_27 );
            Inc( targets.male, male_popn.age_28 );
            Inc( targets.female, female_popn.age_28 );
            Inc( targets.male, male_popn.age_29 );
            Inc( targets.female, female_popn.age_29 );
            Inc( targets.male, male_popn.age_30 );
            Inc( targets.female, female_popn.age_30 );
            Inc( targets.male, male_popn.age_31 );
            Inc( targets.female, female_popn.age_31 );
            Inc( targets.male, male_popn.age_32 );
            Inc( targets.female, female_popn.age_32 );
            Inc( targets.male, male_popn.age_33 );
            Inc( targets.female, female_popn.age_33 );
            Inc( targets.male, male_popn.age_34 );
            Inc( targets.female, female_popn.age_34 );
            Inc( targets.male, male_popn.age_35 );
            Inc( targets.female, female_popn.age_35 );
            Inc( targets.male, male_popn.age_36 );
            Inc( targets.female, female_popn.age_36 );
            Inc( targets.male, male_popn.age_37 );
            Inc( targets.female, female_popn.age_37 );
            Inc( targets.male, male_popn.age_38 );
            Inc( targets.female, female_popn.age_38 );
            Inc( targets.male, male_popn.age_39 );
            Inc( targets.female, female_popn.age_39 );
            Inc( targets.male, male_popn.age_40 );
            Inc( targets.female, female_popn.age_40 );
            Inc( targets.male, male_popn.age_41 );
            Inc( targets.female, female_popn.age_41 );
            Inc( targets.male, male_popn.age_42 );
            Inc( targets.female, female_popn.age_42 );
            Inc( targets.male, male_popn.age_43 );
            Inc( targets.female, female_popn.age_43 );
            Inc( targets.male, male_popn.age_44 );
            Inc( targets.female, female_popn.age_44 );
            Inc( targets.male, male_popn.age_45 );
            Inc( targets.female, female_popn.age_45 );
            Inc( targets.male, male_popn.age_46 );
            Inc( targets.female, female_popn.age_46 );
            Inc( targets.male, male_popn.age_47 );
            Inc( targets.female, female_popn.age_47 );
            Inc( targets.male, male_popn.age_48 );
            Inc( targets.female, female_popn.age_48 );
            Inc( targets.male, male_popn.age_49 );
            Inc( targets.female, female_popn.age_49 );
            Inc( targets.male, male_popn.age_50 );
            Inc( targets.female, female_popn.age_50 );
            Inc( targets.male, male_popn.age_51 );
            Inc( targets.female, female_popn.age_51 );
            Inc( targets.male, male_popn.age_52 );
            Inc( targets.female, female_popn.age_52 );
            Inc( targets.male, male_popn.age_53 );
            Inc( targets.female, female_popn.age_53 );
            Inc( targets.male, male_popn.age_54 );
            Inc( targets.female, female_popn.age_54 );
            Inc( targets.male, male_popn.age_55 );
            Inc( targets.female, female_popn.age_55 );
            Inc( targets.male, male_popn.age_56 );
            Inc( targets.female, female_popn.age_56 );
            Inc( targets.male, male_popn.age_57 );
            Inc( targets.female, female_popn.age_57 );
            Inc( targets.male, male_popn.age_58 );
            Inc( targets.female, female_popn.age_58 );
            Inc( targets.male, male_popn.age_59 );
            Inc( targets.female, female_popn.age_59 );
            Inc( targets.male, male_popn.age_60 );
            Inc( targets.female, female_popn.age_60 );
            Inc( targets.male, male_popn.age_61 );
            Inc( targets.female, female_popn.age_61 );
            Inc( targets.male, male_popn.age_62 );
            Inc( targets.female, female_popn.age_62 );
            Inc( targets.male, male_popn.age_63 );
            Inc( targets.female, female_popn.age_63 );
            Inc( targets.male, male_popn.age_64 );
            Inc( targets.female, female_popn.age_64 );
            Inc( targets.male, male_popn.age_65 );
            Inc( targets.female, female_popn.age_65 );
            Inc( targets.male, male_popn.age_66 );
            Inc( targets.female, female_popn.age_66 );
            Inc( targets.male, male_popn.age_67 );
            Inc( targets.female, female_popn.age_67 );
            Inc( targets.male, male_popn.age_68 );
            Inc( targets.female, female_popn.age_68 );
            Inc( targets.male, male_popn.age_69 );
            Inc( targets.female, female_popn.age_69 );
            Inc( targets.male, male_popn.age_70 );
            Inc( targets.female, female_popn.age_70 );
            Inc( targets.male, male_popn.age_71 );
            Inc( targets.female, female_popn.age_71 );
            Inc( targets.male, male_popn.age_72 );
            Inc( targets.female, female_popn.age_72 );
            Inc( targets.male, male_popn.age_73 );
            Inc( targets.female, female_popn.age_73 );
            Inc( targets.male, male_popn.age_74 );
            Inc( targets.female, female_popn.age_74 );
            Inc( targets.male, male_popn.age_75 );
            Inc( targets.female, female_popn.age_75 );
            Inc( targets.male, male_popn.age_76 );
            Inc( targets.female, female_popn.age_76 );
            Inc( targets.male, male_popn.age_77 );
            Inc( targets.female, female_popn.age_77 );
            Inc( targets.male, male_popn.age_78 );
            Inc( targets.female, female_popn.age_78 );
            Inc( targets.male, male_popn.age_79 );
            Inc( targets.female, female_popn.age_79 );
            Inc( targets.male, male_popn.age_80 );
            Inc( targets.female, female_popn.age_80 );
            Inc( targets.male, male_popn.age_81 );
            Inc( targets.female, female_popn.age_81 );
            Inc( targets.male, male_popn.age_82 );
            Inc( targets.female, female_popn.age_82 );
            Inc( targets.male, male_popn.age_83 );
            Inc( targets.female, female_popn.age_83 );
            Inc( targets.male, male_popn.age_84 );
            Inc( targets.female, female_popn.age_84 );
            Inc( targets.male, male_popn.age_85 );
            Inc( targets.female, female_popn.age_85 );
            Inc( targets.male, male_popn.age_86 );
            Inc( targets.female, female_popn.age_86 );
            Inc( targets.male, male_popn.age_87 );
            Inc( targets.female, female_popn.age_87 );
            Inc( targets.male, male_popn.age_88 );
            Inc( targets.female, female_popn.age_88 );
            Inc( targets.male, male_popn.age_89 );
            Inc( targets.female, female_popn.age_89 );
            Inc( targets.male, male_popn.age_90 );
            Inc( targets.female, female_popn.age_90 );
            Inc( targets.male, male_popn.age_91 );
            Inc( targets.female, female_popn.age_91 );
            Inc( targets.male, male_popn.age_92 );
            Inc( targets.female, female_popn.age_92 );
            Inc( targets.male, male_popn.age_93 );
            Inc( targets.female, female_popn.age_93 );
            Inc( targets.male, male_popn.age_94 );
            Inc( targets.female, female_popn.age_94 );
            Inc( targets.male, male_popn.age_95 );
            Inc( targets.female, female_popn.age_95 );
            Inc( targets.male, male_popn.age_96 );
            Inc( targets.female, female_popn.age_96 );
            Inc( targets.male, male_popn.age_97 );
            Inc( targets.female, female_popn.age_97 );
            Inc( targets.male, male_popn.age_98 );
            Inc( targets.female, female_popn.age_98 );
            Inc( targets.male, male_popn.age_99 );
            Inc( targets.female, female_popn.age_99 );
            Inc( targets.male, male_popn.age_100 );
            Inc( targets.female, female_popn.age_100 );
            Inc( targets.male, male_popn.age_101 );
            Inc( targets.female, female_popn.age_101 );
            Inc( targets.male, male_popn.age_102 );
            Inc( targets.female, female_popn.age_102 );
            Inc( targets.male, male_popn.age_103 );
            Inc( targets.female, female_popn.age_103 );
            Inc( targets.male, male_popn.age_104 );
            Inc( targets.female, female_popn.age_104 );
            Inc( targets.male, male_popn.age_105 );
            Inc( targets.female, female_popn.age_105 );
            Inc( targets.male, male_popn.age_106 );
            Inc( targets.female, female_popn.age_106 );
            Inc( targets.male, male_popn.age_107 );
            Inc( targets.female, female_popn.age_107 );
            Inc( targets.male, male_popn.age_108 );
            Inc( targets.female, female_popn.age_108 );
            Inc( targets.male, male_popn.age_109 );
            Inc( targets.female, female_popn.age_109 );
            Inc( targets.male, male_popn.age_110 );
            Inc( targets.female, female_popn.age_110 );
            Inc( age_16_plus, male_popn.age_16 + female_popn.age_16 );
            Inc( age_16_plus, male_popn.age_17 + female_popn.age_17 );
            Inc( age_16_plus, male_popn.age_18 + female_popn.age_18 );
            Inc( age_16_plus, male_popn.age_19 + female_popn.age_19 );
            Inc( age_16_plus, male_popn.age_20 + female_popn.age_20 );
            Inc( age_16_plus, male_popn.age_21 + female_popn.age_21 );
            Inc( age_16_plus, male_popn.age_22 + female_popn.age_22 );
            Inc( age_16_plus, male_popn.age_23 + female_popn.age_23 );
            Inc( age_16_plus, male_popn.age_24 + female_popn.age_24 );
            Inc( age_16_plus, male_popn.age_25 + female_popn.age_25 );
            Inc( age_16_plus, male_popn.age_26 + female_popn.age_26 );
            Inc( age_16_plus, male_popn.age_27 + female_popn.age_27 );
            Inc( age_16_plus, male_popn.age_28 + female_popn.age_28 );
            Inc( age_16_plus, male_popn.age_29 + female_popn.age_29 );
            Inc( age_16_plus, male_popn.age_30 + female_popn.age_30 );
            Inc( age_16_plus, male_popn.age_31 + female_popn.age_31 );
            Inc( age_16_plus, male_popn.age_32 + female_popn.age_32 );
            Inc( age_16_plus, male_popn.age_33 + female_popn.age_33 );
            Inc( age_16_plus, male_popn.age_34 + female_popn.age_34 );
            Inc( age_16_plus, male_popn.age_35 + female_popn.age_35 );
            Inc( age_16_plus, male_popn.age_36 + female_popn.age_36 );
            Inc( age_16_plus, male_popn.age_37 + female_popn.age_37 );
            Inc( age_16_plus, male_popn.age_38 + female_popn.age_38 );
            Inc( age_16_plus, male_popn.age_39 + female_popn.age_39 );
            Inc( age_16_plus, male_popn.age_40 + female_popn.age_40 );
            Inc( age_16_plus, male_popn.age_41 + female_popn.age_41 );
            Inc( age_16_plus, male_popn.age_42 + female_popn.age_42 );
            Inc( age_16_plus, male_popn.age_43 + female_popn.age_43 );
            Inc( age_16_plus, male_popn.age_44 + female_popn.age_44 );
            Inc( age_16_plus, male_popn.age_45 + female_popn.age_45 );
            Inc( age_16_plus, male_popn.age_46 + female_popn.age_46 );
            Inc( age_16_plus, male_popn.age_47 + female_popn.age_47 );
            Inc( age_16_plus, male_popn.age_48 + female_popn.age_48 );
            Inc( age_16_plus, male_popn.age_49 + female_popn.age_49 );
            Inc( age_16_plus, male_popn.age_50 + female_popn.age_50 );
            Inc( age_16_plus, male_popn.age_51 + female_popn.age_51 );
            Inc( age_16_plus, male_popn.age_52 + female_popn.age_52 );
            Inc( age_16_plus, male_popn.age_53 + female_popn.age_53 );
            Inc( age_16_plus, male_popn.age_54 + female_popn.age_54 );
            Inc( age_16_plus, male_popn.age_55 + female_popn.age_55 );
            Inc( age_16_plus, male_popn.age_56 + female_popn.age_56 );
            Inc( age_16_plus, male_popn.age_57 + female_popn.age_57 );
            Inc( age_16_plus, male_popn.age_58 + female_popn.age_58 );
            Inc( age_16_plus, male_popn.age_59 + female_popn.age_59 );
            Inc( age_16_plus, male_popn.age_60 + female_popn.age_60 );
            Inc( age_16_plus, male_popn.age_61 + female_popn.age_61 );
            Inc( age_16_plus, male_popn.age_62 + female_popn.age_62 );
            Inc( age_16_plus, male_popn.age_63 + female_popn.age_63 );
            Inc( age_16_plus, male_popn.age_64 + female_popn.age_64 );
            Inc( age_16_plus, male_popn.age_65 + female_popn.age_65 );
            Inc( age_16_plus, male_popn.age_66 + female_popn.age_66 );
            Inc( age_16_plus, male_popn.age_67 + female_popn.age_67 );
            Inc( age_16_plus, male_popn.age_68 + female_popn.age_68 );
            Inc( age_16_plus, male_popn.age_69 + female_popn.age_69 );
            Inc( age_16_plus, male_popn.age_70 + female_popn.age_70 );
            Inc( age_16_plus, male_popn.age_71 + female_popn.age_71 );
            Inc( age_16_plus, male_popn.age_72 + female_popn.age_72 );
            Inc( age_16_plus, male_popn.age_73 + female_popn.age_73 );
            Inc( age_16_plus, male_popn.age_74 + female_popn.age_74 );
            Inc( age_16_plus, male_popn.age_75 + female_popn.age_75 );
            Inc( age_16_plus, male_popn.age_76 + female_popn.age_76 );
            Inc( age_16_plus, male_popn.age_77 + female_popn.age_77 );
            Inc( age_16_plus, male_popn.age_78 + female_popn.age_78 );
            Inc( age_16_plus, male_popn.age_79 + female_popn.age_79 );
            Inc( age_16_plus, male_popn.age_80 + female_popn.age_80 );
            Inc( age_16_plus, male_popn.age_81 + female_popn.age_81 );
            Inc( age_16_plus, male_popn.age_82 + female_popn.age_82 );
            Inc( age_16_plus, male_popn.age_83 + female_popn.age_83 );
            Inc( age_16_plus, male_popn.age_84 + female_popn.age_84 );
            Inc( age_16_plus, male_popn.age_85 + female_popn.age_85 );
            Inc( age_16_plus, male_popn.age_86 + female_popn.age_86 );
            Inc( age_16_plus, male_popn.age_87 + female_popn.age_87 );
            Inc( age_16_plus, male_popn.age_88 + female_popn.age_88 );
            Inc( age_16_plus, male_popn.age_89 + female_popn.age_89 );
            Inc( age_16_plus, male_popn.age_90 + female_popn.age_90 );
            Inc( age_16_plus, male_popn.age_91 + female_popn.age_91 );
            Inc( age_16_plus, male_popn.age_92 + female_popn.age_92 );
            Inc( age_16_plus, male_popn.age_93 + female_popn.age_93 );
            Inc( age_16_plus, male_popn.age_94 + female_popn.age_94 );
            Inc( age_16_plus, male_popn.age_95 + female_popn.age_95 );
            Inc( age_16_plus, male_popn.age_96 + female_popn.age_96 );
            Inc( age_16_plus, male_popn.age_97 + female_popn.age_97 );
            Inc( age_16_plus, male_popn.age_98 + female_popn.age_98 );
            Inc( age_16_plus, male_popn.age_99 + female_popn.age_99 );
            Inc( age_16_plus, male_popn.age_100 + female_popn.age_100 );
            Inc( age_16_plus, male_popn.age_101 + female_popn.age_101 );
            Inc( age_16_plus, male_popn.age_102 + female_popn.age_102 );
            Inc( age_16_plus, male_popn.age_103 + female_popn.age_103 );
            Inc( age_16_plus, male_popn.age_104 + female_popn.age_104 );
            Inc( age_16_plus, male_popn.age_105 + female_popn.age_105 );
            Inc( age_16_plus, male_popn.age_106 + female_popn.age_106 );
            Inc( age_16_plus, male_popn.age_107 + female_popn.age_107 );
            Inc( age_16_plus, male_popn.age_108 + female_popn.age_108 );
            Inc( age_16_plus, male_popn.age_109 + female_popn.age_109 );
            Inc( age_16_plus, male_popn.age_110 + female_popn.age_110 );
            -- targets.age_0 := male_popn.age_0 + female_popn.age_0;
            -- targets.age_1 := male_popn.age_1 + female_popn.age_1;
            -- targets.age_2 := male_popn.age_2 + female_popn.age_2;
            -- targets.age_3 := male_popn.age_3 + female_popn.age_3;
            -- targets.age_4 := male_popn.age_4 + female_popn.age_4;
            -- targets.age_5 := male_popn.age_5 + female_popn.age_5;
            -- targets.age_6 := male_popn.age_6 + female_popn.age_6;
            -- targets.age_7 := male_popn.age_7 + female_popn.age_7;
            -- targets.age_8 := male_popn.age_8 + female_popn.age_8;
            -- targets.age_9 := male_popn.age_9 + female_popn.age_9;
            -- targets.age_10 := male_popn.age_10 + female_popn.age_10;
            -- targets.age_11 := male_popn.age_11 + female_popn.age_11;
            -- targets.age_12 := male_popn.age_12 + female_popn.age_12;
            -- targets.age_13 := male_popn.age_13 + female_popn.age_13;
            -- targets.age_14 := male_popn.age_14 + female_popn.age_14;
            -- targets.age_15 := male_popn.age_15 + female_popn.age_15;
            -- targets.age_16 := male_popn.age_16 + female_popn.age_16;
            -- targets.age_17 := male_popn.age_17 + female_popn.age_17;
            -- targets.age_18 := male_popn.age_18 + female_popn.age_18;
            -- targets.age_19 := male_popn.age_19 + female_popn.age_19;
            -- targets.age_20 := male_popn.age_20 + female_popn.age_20;
            -- targets.age_21 := male_popn.age_21 + female_popn.age_21;
            -- targets.age_22 := male_popn.age_22 + female_popn.age_22;
            -- targets.age_23 := male_popn.age_23 + female_popn.age_23;
            -- targets.age_24 := male_popn.age_24 + female_popn.age_24;
            -- targets.age_25 := male_popn.age_25 + female_popn.age_25;
            -- targets.age_26 := male_popn.age_26 + female_popn.age_26;
            -- targets.age_27 := male_popn.age_27 + female_popn.age_27;
            -- targets.age_28 := male_popn.age_28 + female_popn.age_28;
            -- targets.age_29 := male_popn.age_29 + female_popn.age_29;
            -- targets.age_30 := male_popn.age_30 + female_popn.age_30;
            -- targets.age_31 := male_popn.age_31 + female_popn.age_31;
            -- targets.age_32 := male_popn.age_32 + female_popn.age_32;
            -- targets.age_33 := male_popn.age_33 + female_popn.age_33;
            -- targets.age_34 := male_popn.age_34 + female_popn.age_34;
            -- targets.age_35 := male_popn.age_35 + female_popn.age_35;
            -- targets.age_36 := male_popn.age_36 + female_popn.age_36;
            -- targets.age_37 := male_popn.age_37 + female_popn.age_37;
            -- targets.age_38 := male_popn.age_38 + female_popn.age_38;
            -- targets.age_39 := male_popn.age_39 + female_popn.age_39;
            -- targets.age_40 := male_popn.age_40 + female_popn.age_40;
            -- targets.age_41 := male_popn.age_41 + female_popn.age_41;
            -- targets.age_42 := male_popn.age_42 + female_popn.age_42;
            -- targets.age_43 := male_popn.age_43 + female_popn.age_43;
            -- targets.age_44 := male_popn.age_44 + female_popn.age_44;
            -- targets.age_45 := male_popn.age_45 + female_popn.age_45;
            -- targets.age_46 := male_popn.age_46 + female_popn.age_46;
            -- targets.age_47 := male_popn.age_47 + female_popn.age_47;
            -- targets.age_48 := male_popn.age_48 + female_popn.age_48;
            -- targets.age_49 := male_popn.age_49 + female_popn.age_49;
            -- targets.age_50 := male_popn.age_50 + female_popn.age_50;
            -- targets.age_51 := male_popn.age_51 + female_popn.age_51;
            -- targets.age_52 := male_popn.age_52 + female_popn.age_52;
            -- targets.age_53 := male_popn.age_53 + female_popn.age_53;
            -- targets.age_54 := male_popn.age_54 + female_popn.age_54;
            -- targets.age_55 := male_popn.age_55 + female_popn.age_55;
            -- targets.age_56 := male_popn.age_56 + female_popn.age_56;
            -- targets.age_57 := male_popn.age_57 + female_popn.age_57;
            -- targets.age_58 := male_popn.age_58 + female_popn.age_58;
            -- targets.age_59 := male_popn.age_59 + female_popn.age_59;
            -- targets.age_60 := male_popn.age_60 + female_popn.age_60;
            -- targets.age_61 := male_popn.age_61 + female_popn.age_61;
            -- targets.age_62 := male_popn.age_62 + female_popn.age_62;
            -- targets.age_63 := male_popn.age_63 + female_popn.age_63;
            -- targets.age_64 := male_popn.age_64 + female_popn.age_64;
            -- targets.age_65 := male_popn.age_65 + female_popn.age_65;
            -- targets.age_66 := male_popn.age_66 + female_popn.age_66;
            -- targets.age_67 := male_popn.age_67 + female_popn.age_67;
            -- targets.age_68 := male_popn.age_68 + female_popn.age_68;
            -- targets.age_69 := male_popn.age_69 + female_popn.age_69;
            -- targets.age_70 := male_popn.age_70 + female_popn.age_70;
            -- targets.age_71 := male_popn.age_71 + female_popn.age_71;
            -- targets.age_72 := male_popn.age_72 + female_popn.age_72;
            -- targets.age_73 := male_popn.age_73 + female_popn.age_73;
            -- targets.age_74 := male_popn.age_74 + female_popn.age_74;
            -- targets.age_75 := male_popn.age_75 + female_popn.age_75;
            -- targets.age_76 := male_popn.age_76 + female_popn.age_76;
            -- targets.age_77 := male_popn.age_77 + female_popn.age_77;
            -- targets.age_78 := male_popn.age_78 + female_popn.age_78;
            -- targets.age_79 := male_popn.age_79 + female_popn.age_79;
            -- targets.age_80 := male_popn.age_80 + female_popn.age_80;
            -- targets.age_81 := male_popn.age_81 + female_popn.age_81;
            -- targets.age_82 := male_popn.age_82 + female_popn.age_82;
            -- targets.age_83 := male_popn.age_83 + female_popn.age_83;
            -- targets.age_84 := male_popn.age_84 + female_popn.age_84;
            -- targets.age_85 := male_popn.age_85 + female_popn.age_85;
            -- targets.age_86 := male_popn.age_86 + female_popn.age_86;
            -- targets.age_87 := male_popn.age_87 + female_popn.age_87;
            -- targets.age_88 := male_popn.age_88 + female_popn.age_88;
            -- targets.age_89 := male_popn.age_89 + female_popn.age_89;
            -- targets.age_90 := male_popn.age_90 + female_popn.age_90;
            -- targets.age_91 := male_popn.age_91 + female_popn.age_91;
            -- targets.age_92 := male_popn.age_92 + female_popn.age_92;
            -- targets.age_93 := male_popn.age_93 + female_popn.age_93;
            -- targets.age_94 := male_popn.age_94 + female_popn.age_94;
            -- targets.age_95 := male_popn.age_95 + female_popn.age_95;
            -- targets.age_96 := male_popn.age_96 + female_popn.age_96;
            -- targets.age_97 := male_popn.age_97 + female_popn.age_97;
            -- targets.age_98 := male_popn.age_98 + female_popn.age_98;
            -- targets.age_99 := male_popn.age_99 + female_popn.age_99;
            -- targets.age_100 := male_popn.age_100 + female_popn.age_100;
            -- targets.age_101 := male_popn.age_101 + female_popn.age_101;
            -- targets.age_102 := male_popn.age_102 + female_popn.age_102;
            -- targets.age_103 := male_popn.age_103 + female_popn.age_103;
            -- targets.age_104 := male_popn.age_104 + female_popn.age_104;
            -- targets.age_105 := male_popn.age_105 + female_popn.age_105;
            -- targets.age_106 := male_popn.age_106 + female_popn.age_106;
            -- targets.age_107 := male_popn.age_107 + female_popn.age_107;
            -- targets.age_108 := male_popn.age_108 + female_popn.age_108;
            -- targets.age_109 := male_popn.age_109 + female_popn.age_109;
            -- targets.age_110 := male_popn.age_110 + female_popn.age_110;     
            
            targets.employed := age_16_plus * macro_data.employment_rate/100.0;
            targets.ilo_unemployed := age_16_plus * macro_data.ilo_unemployment_rate/100.0;
            
            --
            -- TODO participation scale down for scotland
            -- 
            
            
            -- horrible reverse engineering
            -- TODO BOUNDS ON YEARS
            declare               
               implied_16_plus        : constant Amount := 100.0*macro_data.employment/macro_data.employment_rate;
               implied_employees_rate : constant Amount := macro_data.employees/implied_16_plus;
               implied_claimant_rate  : constant Amount := macro_data.claimant_count/implied_16_plus;
            begin
               Log( "over 16s " & Format( age_16_plus ));
               Log( "implied 16 plus (UK) " & Format( implied_16_plus ));
               Log( "implied employees_rate " & Format( implied_employees_rate*100.0 ));               
               Log( "implied_claimant_rate " & Format( implied_claimant_rate*100.0 ));               
               targets.employee := implied_employees_rate*age_16_plus;
               targets.jsa_claimant := implied_claimant_rate*age_16_plus;
            end; 
            
            Log( To_String( targets )); 
            
            UKDS.Target_Data.Target_Dataset_IO.Save( targets );
         end;
      end loop;
   end Create_Dataset;

end Model.SCP.Target_Creator;