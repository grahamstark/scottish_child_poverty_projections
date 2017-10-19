--
-- Created by ada_generator.py on 2017-10-19 12:07:28.775846
-- 
with Ukds;


with Ada.Containers.Vectors;

with Environment;

with DB_Commons; 

with GNATCOLL.SQL_Impl;
with GNATCOLL.SQL.Postgres;
with DB_Commons.PSQL;


with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with Text_IO;
with Ada.Strings.Maps;
with Connection_Pool;
with GNATColl.Traces;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Target_Dataset_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.TARGET_DATASET_IO" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --

   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "run_id, user_id, year, sernum, country_uk, country_scotland, country_england, country_wales, country_n_ireland, household_all_households," &
         "sco_hhld_one_adult_male, sco_hhld_one_adult_female, sco_hhld_two_adults, sco_hhld_one_adult_one_child, sco_hhld_one_adult_two_plus_children, sco_hhld_two_plus_adult_one_plus_children, sco_hhld_three_plus_person_all_adult, eng_hhld_one_person_households_male, eng_hhld_one_person_households_female, eng_hhld_one_family_and_no_others_couple_no_dependent_chi," &
         "eng_hhld_a_couple_and_other_adults_no_dependent_children, eng_hhld_households_with_one_dependent_child, eng_hhld_households_with_two_dependent_children, eng_hhld_households_with_three_dependent_children, eng_hhld_other_households, nir_hhld_one_adult_households, nir_hhld_two_adults_without_children, nir_hhld_other_households_without_children, nir_hhld_one_adult_households_with_children, nir_hhld_other_households_with_children," &
         "wal_hhld_1_person, wal_hhld_2_person_no_children, wal_hhld_2_person_1_adult_1_child, wal_hhld_3_person_no_children, wal_hhld_3_person_2_adults_1_child, wal_hhld_3_person_1_adult_2_children, wal_hhld_4_person_no_children, wal_hhld_4_person_2_plus_adults_1_plus_children, wal_hhld_4_person_1_adult_3_children, wal_hhld_5_plus_person_no_children," &
         "wal_hhld_5_plus_person_2_plus_adults_1_plus_children, wal_hhld_5_plus_person_1_adult_4_plus_children, male, female, employed, employee, ilo_unemployed, jsa_claimant, age_0_male, age_1_male," &
         "age_2_male, age_3_male, age_4_male, age_5_male, age_6_male, age_7_male, age_8_male, age_9_male, age_10_male, age_11_male," &
         "age_12_male, age_13_male, age_14_male, age_15_male, age_16_male, age_17_male, age_18_male, age_19_male, age_20_male, age_21_male," &
         "age_22_male, age_23_male, age_24_male, age_25_male, age_26_male, age_27_male, age_28_male, age_29_male, age_30_male, age_31_male," &
         "age_32_male, age_33_male, age_34_male, age_35_male, age_36_male, age_37_male, age_38_male, age_39_male, age_40_male, age_41_male," &
         "age_42_male, age_43_male, age_44_male, age_45_male, age_46_male, age_47_male, age_48_male, age_49_male, age_50_male, age_51_male," &
         "age_52_male, age_53_male, age_54_male, age_55_male, age_56_male, age_57_male, age_58_male, age_59_male, age_60_male, age_61_male," &
         "age_62_male, age_63_male, age_64_male, age_65_male, age_66_male, age_67_male, age_68_male, age_69_male, age_70_male, age_71_male," &
         "age_72_male, age_73_male, age_74_male, age_75_male, age_76_male, age_77_male, age_78_male, age_79_male, age_80_male, age_81_male," &
         "age_82_male, age_83_male, age_84_male, age_85_male, age_86_male, age_87_male, age_88_male, age_89_male, age_90_male, age_91_male," &
         "age_92_male, age_93_male, age_94_male, age_95_male, age_96_male, age_97_male, age_98_male, age_99_male, age_100_male, age_101_male," &
         "age_102_male, age_103_male, age_104_male, age_105_male, age_106_male, age_107_male, age_108_male, age_109_male, age_110_male, age_0_female," &
         "age_1_female, age_2_female, age_3_female, age_4_female, age_5_female, age_6_female, age_7_female, age_8_female, age_9_female, age_10_female," &
         "age_11_female, age_12_female, age_13_female, age_14_female, age_15_female, age_16_female, age_17_female, age_18_female, age_19_female, age_20_female," &
         "age_21_female, age_22_female, age_23_female, age_24_female, age_25_female, age_26_female, age_27_female, age_28_female, age_29_female, age_30_female," &
         "age_31_female, age_32_female, age_33_female, age_34_female, age_35_female, age_36_female, age_37_female, age_38_female, age_39_female, age_40_female," &
         "age_41_female, age_42_female, age_43_female, age_44_female, age_45_female, age_46_female, age_47_female, age_48_female, age_49_female, age_50_female," &
         "age_51_female, age_52_female, age_53_female, age_54_female, age_55_female, age_56_female, age_57_female, age_58_female, age_59_female, age_60_female," &
         "age_61_female, age_62_female, age_63_female, age_64_female, age_65_female, age_66_female, age_67_female, age_68_female, age_69_female, age_70_female," &
         "age_71_female, age_72_female, age_73_female, age_74_female, age_75_female, age_76_female, age_77_female, age_78_female, age_79_female, age_80_female," &
         "age_81_female, age_82_female, age_83_female, age_84_female, age_85_female, age_86_female, age_87_female, age_88_female, age_89_female, age_90_female," &
         "age_91_female, age_92_female, age_93_female, age_94_female, age_95_female, age_96_female, age_97_female, age_98_female, age_99_female, age_100_female," &
         "age_101_female, age_102_female, age_103_female, age_104_female, age_105_female, age_106_female, age_107_female, age_108_female, age_109_female, age_110_female," &
         "participation_16_19_male, participation_20_24_male, participation_25_29_male, participation_30_34_male, participation_35_39_male, participation_40_44_male, participation_45_49_male, participation_50_54_male, participation_55_59_male, participation_60_64_male," &
         "participation_65_69_male, participation_70_74_male, participation_75_plus_male, participation_16_19_female, participation_20_24_female, participation_25_29_female, participation_30_34_female, participation_35_39_female, participation_40_44_female, participation_45_49_female," &
         "participation_50_54_female, participation_55_59_female, participation_60_64_female, participation_65_69_female, participation_70_74_female, participation_75_plus_female, one_adult_hh_wales, two_adult_hhs_wales, other_hh_wales, one_adult_hh_nireland," &
         "two_adult_hhs_nireland, other_hh_nireland, one_adult_hh_england, two_adult_hhs_england, other_hh_england, one_adult_hh_scotland, two_adult_hhs_scotland, other_hh_scotland " &
         " from target_data.target_dataset " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.target_dataset (" &
         "run_id, user_id, year, sernum, country_uk, country_scotland, country_england, country_wales, country_n_ireland, household_all_households," &
         "sco_hhld_one_adult_male, sco_hhld_one_adult_female, sco_hhld_two_adults, sco_hhld_one_adult_one_child, sco_hhld_one_adult_two_plus_children, sco_hhld_two_plus_adult_one_plus_children, sco_hhld_three_plus_person_all_adult, eng_hhld_one_person_households_male, eng_hhld_one_person_households_female, eng_hhld_one_family_and_no_others_couple_no_dependent_chi," &
         "eng_hhld_a_couple_and_other_adults_no_dependent_children, eng_hhld_households_with_one_dependent_child, eng_hhld_households_with_two_dependent_children, eng_hhld_households_with_three_dependent_children, eng_hhld_other_households, nir_hhld_one_adult_households, nir_hhld_two_adults_without_children, nir_hhld_other_households_without_children, nir_hhld_one_adult_households_with_children, nir_hhld_other_households_with_children," &
         "wal_hhld_1_person, wal_hhld_2_person_no_children, wal_hhld_2_person_1_adult_1_child, wal_hhld_3_person_no_children, wal_hhld_3_person_2_adults_1_child, wal_hhld_3_person_1_adult_2_children, wal_hhld_4_person_no_children, wal_hhld_4_person_2_plus_adults_1_plus_children, wal_hhld_4_person_1_adult_3_children, wal_hhld_5_plus_person_no_children," &
         "wal_hhld_5_plus_person_2_plus_adults_1_plus_children, wal_hhld_5_plus_person_1_adult_4_plus_children, male, female, employed, employee, ilo_unemployed, jsa_claimant, age_0_male, age_1_male," &
         "age_2_male, age_3_male, age_4_male, age_5_male, age_6_male, age_7_male, age_8_male, age_9_male, age_10_male, age_11_male," &
         "age_12_male, age_13_male, age_14_male, age_15_male, age_16_male, age_17_male, age_18_male, age_19_male, age_20_male, age_21_male," &
         "age_22_male, age_23_male, age_24_male, age_25_male, age_26_male, age_27_male, age_28_male, age_29_male, age_30_male, age_31_male," &
         "age_32_male, age_33_male, age_34_male, age_35_male, age_36_male, age_37_male, age_38_male, age_39_male, age_40_male, age_41_male," &
         "age_42_male, age_43_male, age_44_male, age_45_male, age_46_male, age_47_male, age_48_male, age_49_male, age_50_male, age_51_male," &
         "age_52_male, age_53_male, age_54_male, age_55_male, age_56_male, age_57_male, age_58_male, age_59_male, age_60_male, age_61_male," &
         "age_62_male, age_63_male, age_64_male, age_65_male, age_66_male, age_67_male, age_68_male, age_69_male, age_70_male, age_71_male," &
         "age_72_male, age_73_male, age_74_male, age_75_male, age_76_male, age_77_male, age_78_male, age_79_male, age_80_male, age_81_male," &
         "age_82_male, age_83_male, age_84_male, age_85_male, age_86_male, age_87_male, age_88_male, age_89_male, age_90_male, age_91_male," &
         "age_92_male, age_93_male, age_94_male, age_95_male, age_96_male, age_97_male, age_98_male, age_99_male, age_100_male, age_101_male," &
         "age_102_male, age_103_male, age_104_male, age_105_male, age_106_male, age_107_male, age_108_male, age_109_male, age_110_male, age_0_female," &
         "age_1_female, age_2_female, age_3_female, age_4_female, age_5_female, age_6_female, age_7_female, age_8_female, age_9_female, age_10_female," &
         "age_11_female, age_12_female, age_13_female, age_14_female, age_15_female, age_16_female, age_17_female, age_18_female, age_19_female, age_20_female," &
         "age_21_female, age_22_female, age_23_female, age_24_female, age_25_female, age_26_female, age_27_female, age_28_female, age_29_female, age_30_female," &
         "age_31_female, age_32_female, age_33_female, age_34_female, age_35_female, age_36_female, age_37_female, age_38_female, age_39_female, age_40_female," &
         "age_41_female, age_42_female, age_43_female, age_44_female, age_45_female, age_46_female, age_47_female, age_48_female, age_49_female, age_50_female," &
         "age_51_female, age_52_female, age_53_female, age_54_female, age_55_female, age_56_female, age_57_female, age_58_female, age_59_female, age_60_female," &
         "age_61_female, age_62_female, age_63_female, age_64_female, age_65_female, age_66_female, age_67_female, age_68_female, age_69_female, age_70_female," &
         "age_71_female, age_72_female, age_73_female, age_74_female, age_75_female, age_76_female, age_77_female, age_78_female, age_79_female, age_80_female," &
         "age_81_female, age_82_female, age_83_female, age_84_female, age_85_female, age_86_female, age_87_female, age_88_female, age_89_female, age_90_female," &
         "age_91_female, age_92_female, age_93_female, age_94_female, age_95_female, age_96_female, age_97_female, age_98_female, age_99_female, age_100_female," &
         "age_101_female, age_102_female, age_103_female, age_104_female, age_105_female, age_106_female, age_107_female, age_108_female, age_109_female, age_110_female," &
         "participation_16_19_male, participation_20_24_male, participation_25_29_male, participation_30_34_male, participation_35_39_male, participation_40_44_male, participation_45_49_male, participation_50_54_male, participation_55_59_male, participation_60_64_male," &
         "participation_65_69_male, participation_70_74_male, participation_75_plus_male, participation_16_19_female, participation_20_24_female, participation_25_29_female, participation_30_34_female, participation_35_39_female, participation_40_44_female, participation_45_49_female," &
         "participation_50_54_female, participation_55_59_female, participation_60_64_female, participation_65_69_female, participation_70_74_female, participation_75_plus_female, one_adult_hh_wales, two_adult_hhs_wales, other_hh_wales, one_adult_hh_nireland," &
         "two_adult_hhs_nireland, other_hh_nireland, one_adult_hh_england, two_adult_hhs_england, other_hh_england, one_adult_hh_scotland, two_adult_hhs_scotland, other_hh_scotland " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.target_dataset ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.target_dataset set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 308 ) := ( if update_order then (
            1 => ( Parameter_Float, 0.0 ),   --  : country_uk (Amount)
            2 => ( Parameter_Float, 0.0 ),   --  : country_scotland (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : country_england (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : country_wales (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : country_n_ireland (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : household_all_households (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_male (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_female (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_two_adults (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_one_child (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_two_plus_children (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_two_plus_adult_one_plus_children (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_three_plus_person_all_adult (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_one_person_households_male (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_one_person_households_female (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_one_family_and_no_others_couple_no_dependent_chi (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_a_couple_and_other_adults_no_dependent_children (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_households_with_one_dependent_child (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_households_with_two_dependent_children (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_households_with_three_dependent_children (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_other_households (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_one_adult_households (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_two_adults_without_children (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_other_households_without_children (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_one_adult_households_with_children (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_other_households_with_children (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_1_person (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_2_person_no_children (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_2_person_1_adult_1_child (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_3_person_no_children (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_3_person_2_adults_1_child (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_3_person_1_adult_2_children (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_4_person_no_children (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_4_person_2_plus_adults_1_plus_children (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_4_person_1_adult_3_children (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_5_plus_person_no_children (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_5_plus_person_2_plus_adults_1_plus_children (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_5_plus_person_1_adult_4_plus_children (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : male (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : female (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : employed (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : employee (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployed (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : jsa_claimant (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : age_0_male (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : age_1_male (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : age_2_male (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : age_3_male (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : age_4_male (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : age_5_male (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : age_6_male (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : age_7_male (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : age_8_male (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : age_9_male (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : age_10_male (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : age_11_male (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : age_12_male (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : age_13_male (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : age_14_male (Amount)
           60 => ( Parameter_Float, 0.0 ),   --  : age_15_male (Amount)
           61 => ( Parameter_Float, 0.0 ),   --  : age_16_male (Amount)
           62 => ( Parameter_Float, 0.0 ),   --  : age_17_male (Amount)
           63 => ( Parameter_Float, 0.0 ),   --  : age_18_male (Amount)
           64 => ( Parameter_Float, 0.0 ),   --  : age_19_male (Amount)
           65 => ( Parameter_Float, 0.0 ),   --  : age_20_male (Amount)
           66 => ( Parameter_Float, 0.0 ),   --  : age_21_male (Amount)
           67 => ( Parameter_Float, 0.0 ),   --  : age_22_male (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : age_23_male (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : age_24_male (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : age_25_male (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : age_26_male (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : age_27_male (Amount)
           73 => ( Parameter_Float, 0.0 ),   --  : age_28_male (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : age_29_male (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : age_30_male (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : age_31_male (Amount)
           77 => ( Parameter_Float, 0.0 ),   --  : age_32_male (Amount)
           78 => ( Parameter_Float, 0.0 ),   --  : age_33_male (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : age_34_male (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : age_35_male (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : age_36_male (Amount)
           82 => ( Parameter_Float, 0.0 ),   --  : age_37_male (Amount)
           83 => ( Parameter_Float, 0.0 ),   --  : age_38_male (Amount)
           84 => ( Parameter_Float, 0.0 ),   --  : age_39_male (Amount)
           85 => ( Parameter_Float, 0.0 ),   --  : age_40_male (Amount)
           86 => ( Parameter_Float, 0.0 ),   --  : age_41_male (Amount)
           87 => ( Parameter_Float, 0.0 ),   --  : age_42_male (Amount)
           88 => ( Parameter_Float, 0.0 ),   --  : age_43_male (Amount)
           89 => ( Parameter_Float, 0.0 ),   --  : age_44_male (Amount)
           90 => ( Parameter_Float, 0.0 ),   --  : age_45_male (Amount)
           91 => ( Parameter_Float, 0.0 ),   --  : age_46_male (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : age_47_male (Amount)
           93 => ( Parameter_Float, 0.0 ),   --  : age_48_male (Amount)
           94 => ( Parameter_Float, 0.0 ),   --  : age_49_male (Amount)
           95 => ( Parameter_Float, 0.0 ),   --  : age_50_male (Amount)
           96 => ( Parameter_Float, 0.0 ),   --  : age_51_male (Amount)
           97 => ( Parameter_Float, 0.0 ),   --  : age_52_male (Amount)
           98 => ( Parameter_Float, 0.0 ),   --  : age_53_male (Amount)
           99 => ( Parameter_Float, 0.0 ),   --  : age_54_male (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : age_55_male (Amount)
           101 => ( Parameter_Float, 0.0 ),   --  : age_56_male (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : age_57_male (Amount)
           103 => ( Parameter_Float, 0.0 ),   --  : age_58_male (Amount)
           104 => ( Parameter_Float, 0.0 ),   --  : age_59_male (Amount)
           105 => ( Parameter_Float, 0.0 ),   --  : age_60_male (Amount)
           106 => ( Parameter_Float, 0.0 ),   --  : age_61_male (Amount)
           107 => ( Parameter_Float, 0.0 ),   --  : age_62_male (Amount)
           108 => ( Parameter_Float, 0.0 ),   --  : age_63_male (Amount)
           109 => ( Parameter_Float, 0.0 ),   --  : age_64_male (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : age_65_male (Amount)
           111 => ( Parameter_Float, 0.0 ),   --  : age_66_male (Amount)
           112 => ( Parameter_Float, 0.0 ),   --  : age_67_male (Amount)
           113 => ( Parameter_Float, 0.0 ),   --  : age_68_male (Amount)
           114 => ( Parameter_Float, 0.0 ),   --  : age_69_male (Amount)
           115 => ( Parameter_Float, 0.0 ),   --  : age_70_male (Amount)
           116 => ( Parameter_Float, 0.0 ),   --  : age_71_male (Amount)
           117 => ( Parameter_Float, 0.0 ),   --  : age_72_male (Amount)
           118 => ( Parameter_Float, 0.0 ),   --  : age_73_male (Amount)
           119 => ( Parameter_Float, 0.0 ),   --  : age_74_male (Amount)
           120 => ( Parameter_Float, 0.0 ),   --  : age_75_male (Amount)
           121 => ( Parameter_Float, 0.0 ),   --  : age_76_male (Amount)
           122 => ( Parameter_Float, 0.0 ),   --  : age_77_male (Amount)
           123 => ( Parameter_Float, 0.0 ),   --  : age_78_male (Amount)
           124 => ( Parameter_Float, 0.0 ),   --  : age_79_male (Amount)
           125 => ( Parameter_Float, 0.0 ),   --  : age_80_male (Amount)
           126 => ( Parameter_Float, 0.0 ),   --  : age_81_male (Amount)
           127 => ( Parameter_Float, 0.0 ),   --  : age_82_male (Amount)
           128 => ( Parameter_Float, 0.0 ),   --  : age_83_male (Amount)
           129 => ( Parameter_Float, 0.0 ),   --  : age_84_male (Amount)
           130 => ( Parameter_Float, 0.0 ),   --  : age_85_male (Amount)
           131 => ( Parameter_Float, 0.0 ),   --  : age_86_male (Amount)
           132 => ( Parameter_Float, 0.0 ),   --  : age_87_male (Amount)
           133 => ( Parameter_Float, 0.0 ),   --  : age_88_male (Amount)
           134 => ( Parameter_Float, 0.0 ),   --  : age_89_male (Amount)
           135 => ( Parameter_Float, 0.0 ),   --  : age_90_male (Amount)
           136 => ( Parameter_Float, 0.0 ),   --  : age_91_male (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : age_92_male (Amount)
           138 => ( Parameter_Float, 0.0 ),   --  : age_93_male (Amount)
           139 => ( Parameter_Float, 0.0 ),   --  : age_94_male (Amount)
           140 => ( Parameter_Float, 0.0 ),   --  : age_95_male (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : age_96_male (Amount)
           142 => ( Parameter_Float, 0.0 ),   --  : age_97_male (Amount)
           143 => ( Parameter_Float, 0.0 ),   --  : age_98_male (Amount)
           144 => ( Parameter_Float, 0.0 ),   --  : age_99_male (Amount)
           145 => ( Parameter_Float, 0.0 ),   --  : age_100_male (Amount)
           146 => ( Parameter_Float, 0.0 ),   --  : age_101_male (Amount)
           147 => ( Parameter_Float, 0.0 ),   --  : age_102_male (Amount)
           148 => ( Parameter_Float, 0.0 ),   --  : age_103_male (Amount)
           149 => ( Parameter_Float, 0.0 ),   --  : age_104_male (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : age_105_male (Amount)
           151 => ( Parameter_Float, 0.0 ),   --  : age_106_male (Amount)
           152 => ( Parameter_Float, 0.0 ),   --  : age_107_male (Amount)
           153 => ( Parameter_Float, 0.0 ),   --  : age_108_male (Amount)
           154 => ( Parameter_Float, 0.0 ),   --  : age_109_male (Amount)
           155 => ( Parameter_Float, 0.0 ),   --  : age_110_male (Amount)
           156 => ( Parameter_Float, 0.0 ),   --  : age_0_female (Amount)
           157 => ( Parameter_Float, 0.0 ),   --  : age_1_female (Amount)
           158 => ( Parameter_Float, 0.0 ),   --  : age_2_female (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : age_3_female (Amount)
           160 => ( Parameter_Float, 0.0 ),   --  : age_4_female (Amount)
           161 => ( Parameter_Float, 0.0 ),   --  : age_5_female (Amount)
           162 => ( Parameter_Float, 0.0 ),   --  : age_6_female (Amount)
           163 => ( Parameter_Float, 0.0 ),   --  : age_7_female (Amount)
           164 => ( Parameter_Float, 0.0 ),   --  : age_8_female (Amount)
           165 => ( Parameter_Float, 0.0 ),   --  : age_9_female (Amount)
           166 => ( Parameter_Float, 0.0 ),   --  : age_10_female (Amount)
           167 => ( Parameter_Float, 0.0 ),   --  : age_11_female (Amount)
           168 => ( Parameter_Float, 0.0 ),   --  : age_12_female (Amount)
           169 => ( Parameter_Float, 0.0 ),   --  : age_13_female (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : age_14_female (Amount)
           171 => ( Parameter_Float, 0.0 ),   --  : age_15_female (Amount)
           172 => ( Parameter_Float, 0.0 ),   --  : age_16_female (Amount)
           173 => ( Parameter_Float, 0.0 ),   --  : age_17_female (Amount)
           174 => ( Parameter_Float, 0.0 ),   --  : age_18_female (Amount)
           175 => ( Parameter_Float, 0.0 ),   --  : age_19_female (Amount)
           176 => ( Parameter_Float, 0.0 ),   --  : age_20_female (Amount)
           177 => ( Parameter_Float, 0.0 ),   --  : age_21_female (Amount)
           178 => ( Parameter_Float, 0.0 ),   --  : age_22_female (Amount)
           179 => ( Parameter_Float, 0.0 ),   --  : age_23_female (Amount)
           180 => ( Parameter_Float, 0.0 ),   --  : age_24_female (Amount)
           181 => ( Parameter_Float, 0.0 ),   --  : age_25_female (Amount)
           182 => ( Parameter_Float, 0.0 ),   --  : age_26_female (Amount)
           183 => ( Parameter_Float, 0.0 ),   --  : age_27_female (Amount)
           184 => ( Parameter_Float, 0.0 ),   --  : age_28_female (Amount)
           185 => ( Parameter_Float, 0.0 ),   --  : age_29_female (Amount)
           186 => ( Parameter_Float, 0.0 ),   --  : age_30_female (Amount)
           187 => ( Parameter_Float, 0.0 ),   --  : age_31_female (Amount)
           188 => ( Parameter_Float, 0.0 ),   --  : age_32_female (Amount)
           189 => ( Parameter_Float, 0.0 ),   --  : age_33_female (Amount)
           190 => ( Parameter_Float, 0.0 ),   --  : age_34_female (Amount)
           191 => ( Parameter_Float, 0.0 ),   --  : age_35_female (Amount)
           192 => ( Parameter_Float, 0.0 ),   --  : age_36_female (Amount)
           193 => ( Parameter_Float, 0.0 ),   --  : age_37_female (Amount)
           194 => ( Parameter_Float, 0.0 ),   --  : age_38_female (Amount)
           195 => ( Parameter_Float, 0.0 ),   --  : age_39_female (Amount)
           196 => ( Parameter_Float, 0.0 ),   --  : age_40_female (Amount)
           197 => ( Parameter_Float, 0.0 ),   --  : age_41_female (Amount)
           198 => ( Parameter_Float, 0.0 ),   --  : age_42_female (Amount)
           199 => ( Parameter_Float, 0.0 ),   --  : age_43_female (Amount)
           200 => ( Parameter_Float, 0.0 ),   --  : age_44_female (Amount)
           201 => ( Parameter_Float, 0.0 ),   --  : age_45_female (Amount)
           202 => ( Parameter_Float, 0.0 ),   --  : age_46_female (Amount)
           203 => ( Parameter_Float, 0.0 ),   --  : age_47_female (Amount)
           204 => ( Parameter_Float, 0.0 ),   --  : age_48_female (Amount)
           205 => ( Parameter_Float, 0.0 ),   --  : age_49_female (Amount)
           206 => ( Parameter_Float, 0.0 ),   --  : age_50_female (Amount)
           207 => ( Parameter_Float, 0.0 ),   --  : age_51_female (Amount)
           208 => ( Parameter_Float, 0.0 ),   --  : age_52_female (Amount)
           209 => ( Parameter_Float, 0.0 ),   --  : age_53_female (Amount)
           210 => ( Parameter_Float, 0.0 ),   --  : age_54_female (Amount)
           211 => ( Parameter_Float, 0.0 ),   --  : age_55_female (Amount)
           212 => ( Parameter_Float, 0.0 ),   --  : age_56_female (Amount)
           213 => ( Parameter_Float, 0.0 ),   --  : age_57_female (Amount)
           214 => ( Parameter_Float, 0.0 ),   --  : age_58_female (Amount)
           215 => ( Parameter_Float, 0.0 ),   --  : age_59_female (Amount)
           216 => ( Parameter_Float, 0.0 ),   --  : age_60_female (Amount)
           217 => ( Parameter_Float, 0.0 ),   --  : age_61_female (Amount)
           218 => ( Parameter_Float, 0.0 ),   --  : age_62_female (Amount)
           219 => ( Parameter_Float, 0.0 ),   --  : age_63_female (Amount)
           220 => ( Parameter_Float, 0.0 ),   --  : age_64_female (Amount)
           221 => ( Parameter_Float, 0.0 ),   --  : age_65_female (Amount)
           222 => ( Parameter_Float, 0.0 ),   --  : age_66_female (Amount)
           223 => ( Parameter_Float, 0.0 ),   --  : age_67_female (Amount)
           224 => ( Parameter_Float, 0.0 ),   --  : age_68_female (Amount)
           225 => ( Parameter_Float, 0.0 ),   --  : age_69_female (Amount)
           226 => ( Parameter_Float, 0.0 ),   --  : age_70_female (Amount)
           227 => ( Parameter_Float, 0.0 ),   --  : age_71_female (Amount)
           228 => ( Parameter_Float, 0.0 ),   --  : age_72_female (Amount)
           229 => ( Parameter_Float, 0.0 ),   --  : age_73_female (Amount)
           230 => ( Parameter_Float, 0.0 ),   --  : age_74_female (Amount)
           231 => ( Parameter_Float, 0.0 ),   --  : age_75_female (Amount)
           232 => ( Parameter_Float, 0.0 ),   --  : age_76_female (Amount)
           233 => ( Parameter_Float, 0.0 ),   --  : age_77_female (Amount)
           234 => ( Parameter_Float, 0.0 ),   --  : age_78_female (Amount)
           235 => ( Parameter_Float, 0.0 ),   --  : age_79_female (Amount)
           236 => ( Parameter_Float, 0.0 ),   --  : age_80_female (Amount)
           237 => ( Parameter_Float, 0.0 ),   --  : age_81_female (Amount)
           238 => ( Parameter_Float, 0.0 ),   --  : age_82_female (Amount)
           239 => ( Parameter_Float, 0.0 ),   --  : age_83_female (Amount)
           240 => ( Parameter_Float, 0.0 ),   --  : age_84_female (Amount)
           241 => ( Parameter_Float, 0.0 ),   --  : age_85_female (Amount)
           242 => ( Parameter_Float, 0.0 ),   --  : age_86_female (Amount)
           243 => ( Parameter_Float, 0.0 ),   --  : age_87_female (Amount)
           244 => ( Parameter_Float, 0.0 ),   --  : age_88_female (Amount)
           245 => ( Parameter_Float, 0.0 ),   --  : age_89_female (Amount)
           246 => ( Parameter_Float, 0.0 ),   --  : age_90_female (Amount)
           247 => ( Parameter_Float, 0.0 ),   --  : age_91_female (Amount)
           248 => ( Parameter_Float, 0.0 ),   --  : age_92_female (Amount)
           249 => ( Parameter_Float, 0.0 ),   --  : age_93_female (Amount)
           250 => ( Parameter_Float, 0.0 ),   --  : age_94_female (Amount)
           251 => ( Parameter_Float, 0.0 ),   --  : age_95_female (Amount)
           252 => ( Parameter_Float, 0.0 ),   --  : age_96_female (Amount)
           253 => ( Parameter_Float, 0.0 ),   --  : age_97_female (Amount)
           254 => ( Parameter_Float, 0.0 ),   --  : age_98_female (Amount)
           255 => ( Parameter_Float, 0.0 ),   --  : age_99_female (Amount)
           256 => ( Parameter_Float, 0.0 ),   --  : age_100_female (Amount)
           257 => ( Parameter_Float, 0.0 ),   --  : age_101_female (Amount)
           258 => ( Parameter_Float, 0.0 ),   --  : age_102_female (Amount)
           259 => ( Parameter_Float, 0.0 ),   --  : age_103_female (Amount)
           260 => ( Parameter_Float, 0.0 ),   --  : age_104_female (Amount)
           261 => ( Parameter_Float, 0.0 ),   --  : age_105_female (Amount)
           262 => ( Parameter_Float, 0.0 ),   --  : age_106_female (Amount)
           263 => ( Parameter_Float, 0.0 ),   --  : age_107_female (Amount)
           264 => ( Parameter_Float, 0.0 ),   --  : age_108_female (Amount)
           265 => ( Parameter_Float, 0.0 ),   --  : age_109_female (Amount)
           266 => ( Parameter_Float, 0.0 ),   --  : age_110_female (Amount)
           267 => ( Parameter_Float, 0.0 ),   --  : participation_16_19_male (Amount)
           268 => ( Parameter_Float, 0.0 ),   --  : participation_20_24_male (Amount)
           269 => ( Parameter_Float, 0.0 ),   --  : participation_25_29_male (Amount)
           270 => ( Parameter_Float, 0.0 ),   --  : participation_30_34_male (Amount)
           271 => ( Parameter_Float, 0.0 ),   --  : participation_35_39_male (Amount)
           272 => ( Parameter_Float, 0.0 ),   --  : participation_40_44_male (Amount)
           273 => ( Parameter_Float, 0.0 ),   --  : participation_45_49_male (Amount)
           274 => ( Parameter_Float, 0.0 ),   --  : participation_50_54_male (Amount)
           275 => ( Parameter_Float, 0.0 ),   --  : participation_55_59_male (Amount)
           276 => ( Parameter_Float, 0.0 ),   --  : participation_60_64_male (Amount)
           277 => ( Parameter_Float, 0.0 ),   --  : participation_65_69_male (Amount)
           278 => ( Parameter_Float, 0.0 ),   --  : participation_70_74_male (Amount)
           279 => ( Parameter_Float, 0.0 ),   --  : participation_75_plus_male (Amount)
           280 => ( Parameter_Float, 0.0 ),   --  : participation_16_19_female (Amount)
           281 => ( Parameter_Float, 0.0 ),   --  : participation_20_24_female (Amount)
           282 => ( Parameter_Float, 0.0 ),   --  : participation_25_29_female (Amount)
           283 => ( Parameter_Float, 0.0 ),   --  : participation_30_34_female (Amount)
           284 => ( Parameter_Float, 0.0 ),   --  : participation_35_39_female (Amount)
           285 => ( Parameter_Float, 0.0 ),   --  : participation_40_44_female (Amount)
           286 => ( Parameter_Float, 0.0 ),   --  : participation_45_49_female (Amount)
           287 => ( Parameter_Float, 0.0 ),   --  : participation_50_54_female (Amount)
           288 => ( Parameter_Float, 0.0 ),   --  : participation_55_59_female (Amount)
           289 => ( Parameter_Float, 0.0 ),   --  : participation_60_64_female (Amount)
           290 => ( Parameter_Float, 0.0 ),   --  : participation_65_69_female (Amount)
           291 => ( Parameter_Float, 0.0 ),   --  : participation_70_74_female (Amount)
           292 => ( Parameter_Float, 0.0 ),   --  : participation_75_plus_female (Amount)
           293 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_wales (Amount)
           294 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_wales (Amount)
           295 => ( Parameter_Float, 0.0 ),   --  : other_hh_wales (Amount)
           296 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_nireland (Amount)
           297 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_nireland (Amount)
           298 => ( Parameter_Float, 0.0 ),   --  : other_hh_nireland (Amount)
           299 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_england (Amount)
           300 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_england (Amount)
           301 => ( Parameter_Float, 0.0 ),   --  : other_hh_england (Amount)
           302 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_scotland (Amount)
           303 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_scotland (Amount)
           304 => ( Parameter_Float, 0.0 ),   --  : other_hh_scotland (Amount)
           305 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : year (Year_Number)
           308 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Year_Number)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Float, 0.0 ),   --  : country_uk (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : country_scotland (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : country_england (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : country_wales (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : country_n_ireland (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : household_all_households (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_male (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_female (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_two_adults (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_one_child (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_one_adult_two_plus_children (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_two_plus_adult_one_plus_children (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : sco_hhld_three_plus_person_all_adult (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_one_person_households_male (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_one_person_households_female (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_one_family_and_no_others_couple_no_dependent_chi (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_a_couple_and_other_adults_no_dependent_children (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_households_with_one_dependent_child (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_households_with_two_dependent_children (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_households_with_three_dependent_children (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : eng_hhld_other_households (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_one_adult_households (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_two_adults_without_children (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_other_households_without_children (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_one_adult_households_with_children (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : nir_hhld_other_households_with_children (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_1_person (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_2_person_no_children (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_2_person_1_adult_1_child (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_3_person_no_children (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_3_person_2_adults_1_child (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_3_person_1_adult_2_children (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_4_person_no_children (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_4_person_2_plus_adults_1_plus_children (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_4_person_1_adult_3_children (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_5_plus_person_no_children (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_5_plus_person_2_plus_adults_1_plus_children (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : wal_hhld_5_plus_person_1_adult_4_plus_children (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : male (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : female (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : employed (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : employee (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployed (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : jsa_claimant (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : age_0_male (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : age_1_male (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : age_2_male (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : age_3_male (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : age_4_male (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : age_5_male (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : age_6_male (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : age_7_male (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : age_8_male (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : age_9_male (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : age_10_male (Amount)
           60 => ( Parameter_Float, 0.0 ),   --  : age_11_male (Amount)
           61 => ( Parameter_Float, 0.0 ),   --  : age_12_male (Amount)
           62 => ( Parameter_Float, 0.0 ),   --  : age_13_male (Amount)
           63 => ( Parameter_Float, 0.0 ),   --  : age_14_male (Amount)
           64 => ( Parameter_Float, 0.0 ),   --  : age_15_male (Amount)
           65 => ( Parameter_Float, 0.0 ),   --  : age_16_male (Amount)
           66 => ( Parameter_Float, 0.0 ),   --  : age_17_male (Amount)
           67 => ( Parameter_Float, 0.0 ),   --  : age_18_male (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : age_19_male (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : age_20_male (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : age_21_male (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : age_22_male (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : age_23_male (Amount)
           73 => ( Parameter_Float, 0.0 ),   --  : age_24_male (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : age_25_male (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : age_26_male (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : age_27_male (Amount)
           77 => ( Parameter_Float, 0.0 ),   --  : age_28_male (Amount)
           78 => ( Parameter_Float, 0.0 ),   --  : age_29_male (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : age_30_male (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : age_31_male (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : age_32_male (Amount)
           82 => ( Parameter_Float, 0.0 ),   --  : age_33_male (Amount)
           83 => ( Parameter_Float, 0.0 ),   --  : age_34_male (Amount)
           84 => ( Parameter_Float, 0.0 ),   --  : age_35_male (Amount)
           85 => ( Parameter_Float, 0.0 ),   --  : age_36_male (Amount)
           86 => ( Parameter_Float, 0.0 ),   --  : age_37_male (Amount)
           87 => ( Parameter_Float, 0.0 ),   --  : age_38_male (Amount)
           88 => ( Parameter_Float, 0.0 ),   --  : age_39_male (Amount)
           89 => ( Parameter_Float, 0.0 ),   --  : age_40_male (Amount)
           90 => ( Parameter_Float, 0.0 ),   --  : age_41_male (Amount)
           91 => ( Parameter_Float, 0.0 ),   --  : age_42_male (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : age_43_male (Amount)
           93 => ( Parameter_Float, 0.0 ),   --  : age_44_male (Amount)
           94 => ( Parameter_Float, 0.0 ),   --  : age_45_male (Amount)
           95 => ( Parameter_Float, 0.0 ),   --  : age_46_male (Amount)
           96 => ( Parameter_Float, 0.0 ),   --  : age_47_male (Amount)
           97 => ( Parameter_Float, 0.0 ),   --  : age_48_male (Amount)
           98 => ( Parameter_Float, 0.0 ),   --  : age_49_male (Amount)
           99 => ( Parameter_Float, 0.0 ),   --  : age_50_male (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : age_51_male (Amount)
           101 => ( Parameter_Float, 0.0 ),   --  : age_52_male (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : age_53_male (Amount)
           103 => ( Parameter_Float, 0.0 ),   --  : age_54_male (Amount)
           104 => ( Parameter_Float, 0.0 ),   --  : age_55_male (Amount)
           105 => ( Parameter_Float, 0.0 ),   --  : age_56_male (Amount)
           106 => ( Parameter_Float, 0.0 ),   --  : age_57_male (Amount)
           107 => ( Parameter_Float, 0.0 ),   --  : age_58_male (Amount)
           108 => ( Parameter_Float, 0.0 ),   --  : age_59_male (Amount)
           109 => ( Parameter_Float, 0.0 ),   --  : age_60_male (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : age_61_male (Amount)
           111 => ( Parameter_Float, 0.0 ),   --  : age_62_male (Amount)
           112 => ( Parameter_Float, 0.0 ),   --  : age_63_male (Amount)
           113 => ( Parameter_Float, 0.0 ),   --  : age_64_male (Amount)
           114 => ( Parameter_Float, 0.0 ),   --  : age_65_male (Amount)
           115 => ( Parameter_Float, 0.0 ),   --  : age_66_male (Amount)
           116 => ( Parameter_Float, 0.0 ),   --  : age_67_male (Amount)
           117 => ( Parameter_Float, 0.0 ),   --  : age_68_male (Amount)
           118 => ( Parameter_Float, 0.0 ),   --  : age_69_male (Amount)
           119 => ( Parameter_Float, 0.0 ),   --  : age_70_male (Amount)
           120 => ( Parameter_Float, 0.0 ),   --  : age_71_male (Amount)
           121 => ( Parameter_Float, 0.0 ),   --  : age_72_male (Amount)
           122 => ( Parameter_Float, 0.0 ),   --  : age_73_male (Amount)
           123 => ( Parameter_Float, 0.0 ),   --  : age_74_male (Amount)
           124 => ( Parameter_Float, 0.0 ),   --  : age_75_male (Amount)
           125 => ( Parameter_Float, 0.0 ),   --  : age_76_male (Amount)
           126 => ( Parameter_Float, 0.0 ),   --  : age_77_male (Amount)
           127 => ( Parameter_Float, 0.0 ),   --  : age_78_male (Amount)
           128 => ( Parameter_Float, 0.0 ),   --  : age_79_male (Amount)
           129 => ( Parameter_Float, 0.0 ),   --  : age_80_male (Amount)
           130 => ( Parameter_Float, 0.0 ),   --  : age_81_male (Amount)
           131 => ( Parameter_Float, 0.0 ),   --  : age_82_male (Amount)
           132 => ( Parameter_Float, 0.0 ),   --  : age_83_male (Amount)
           133 => ( Parameter_Float, 0.0 ),   --  : age_84_male (Amount)
           134 => ( Parameter_Float, 0.0 ),   --  : age_85_male (Amount)
           135 => ( Parameter_Float, 0.0 ),   --  : age_86_male (Amount)
           136 => ( Parameter_Float, 0.0 ),   --  : age_87_male (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : age_88_male (Amount)
           138 => ( Parameter_Float, 0.0 ),   --  : age_89_male (Amount)
           139 => ( Parameter_Float, 0.0 ),   --  : age_90_male (Amount)
           140 => ( Parameter_Float, 0.0 ),   --  : age_91_male (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : age_92_male (Amount)
           142 => ( Parameter_Float, 0.0 ),   --  : age_93_male (Amount)
           143 => ( Parameter_Float, 0.0 ),   --  : age_94_male (Amount)
           144 => ( Parameter_Float, 0.0 ),   --  : age_95_male (Amount)
           145 => ( Parameter_Float, 0.0 ),   --  : age_96_male (Amount)
           146 => ( Parameter_Float, 0.0 ),   --  : age_97_male (Amount)
           147 => ( Parameter_Float, 0.0 ),   --  : age_98_male (Amount)
           148 => ( Parameter_Float, 0.0 ),   --  : age_99_male (Amount)
           149 => ( Parameter_Float, 0.0 ),   --  : age_100_male (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : age_101_male (Amount)
           151 => ( Parameter_Float, 0.0 ),   --  : age_102_male (Amount)
           152 => ( Parameter_Float, 0.0 ),   --  : age_103_male (Amount)
           153 => ( Parameter_Float, 0.0 ),   --  : age_104_male (Amount)
           154 => ( Parameter_Float, 0.0 ),   --  : age_105_male (Amount)
           155 => ( Parameter_Float, 0.0 ),   --  : age_106_male (Amount)
           156 => ( Parameter_Float, 0.0 ),   --  : age_107_male (Amount)
           157 => ( Parameter_Float, 0.0 ),   --  : age_108_male (Amount)
           158 => ( Parameter_Float, 0.0 ),   --  : age_109_male (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : age_110_male (Amount)
           160 => ( Parameter_Float, 0.0 ),   --  : age_0_female (Amount)
           161 => ( Parameter_Float, 0.0 ),   --  : age_1_female (Amount)
           162 => ( Parameter_Float, 0.0 ),   --  : age_2_female (Amount)
           163 => ( Parameter_Float, 0.0 ),   --  : age_3_female (Amount)
           164 => ( Parameter_Float, 0.0 ),   --  : age_4_female (Amount)
           165 => ( Parameter_Float, 0.0 ),   --  : age_5_female (Amount)
           166 => ( Parameter_Float, 0.0 ),   --  : age_6_female (Amount)
           167 => ( Parameter_Float, 0.0 ),   --  : age_7_female (Amount)
           168 => ( Parameter_Float, 0.0 ),   --  : age_8_female (Amount)
           169 => ( Parameter_Float, 0.0 ),   --  : age_9_female (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : age_10_female (Amount)
           171 => ( Parameter_Float, 0.0 ),   --  : age_11_female (Amount)
           172 => ( Parameter_Float, 0.0 ),   --  : age_12_female (Amount)
           173 => ( Parameter_Float, 0.0 ),   --  : age_13_female (Amount)
           174 => ( Parameter_Float, 0.0 ),   --  : age_14_female (Amount)
           175 => ( Parameter_Float, 0.0 ),   --  : age_15_female (Amount)
           176 => ( Parameter_Float, 0.0 ),   --  : age_16_female (Amount)
           177 => ( Parameter_Float, 0.0 ),   --  : age_17_female (Amount)
           178 => ( Parameter_Float, 0.0 ),   --  : age_18_female (Amount)
           179 => ( Parameter_Float, 0.0 ),   --  : age_19_female (Amount)
           180 => ( Parameter_Float, 0.0 ),   --  : age_20_female (Amount)
           181 => ( Parameter_Float, 0.0 ),   --  : age_21_female (Amount)
           182 => ( Parameter_Float, 0.0 ),   --  : age_22_female (Amount)
           183 => ( Parameter_Float, 0.0 ),   --  : age_23_female (Amount)
           184 => ( Parameter_Float, 0.0 ),   --  : age_24_female (Amount)
           185 => ( Parameter_Float, 0.0 ),   --  : age_25_female (Amount)
           186 => ( Parameter_Float, 0.0 ),   --  : age_26_female (Amount)
           187 => ( Parameter_Float, 0.0 ),   --  : age_27_female (Amount)
           188 => ( Parameter_Float, 0.0 ),   --  : age_28_female (Amount)
           189 => ( Parameter_Float, 0.0 ),   --  : age_29_female (Amount)
           190 => ( Parameter_Float, 0.0 ),   --  : age_30_female (Amount)
           191 => ( Parameter_Float, 0.0 ),   --  : age_31_female (Amount)
           192 => ( Parameter_Float, 0.0 ),   --  : age_32_female (Amount)
           193 => ( Parameter_Float, 0.0 ),   --  : age_33_female (Amount)
           194 => ( Parameter_Float, 0.0 ),   --  : age_34_female (Amount)
           195 => ( Parameter_Float, 0.0 ),   --  : age_35_female (Amount)
           196 => ( Parameter_Float, 0.0 ),   --  : age_36_female (Amount)
           197 => ( Parameter_Float, 0.0 ),   --  : age_37_female (Amount)
           198 => ( Parameter_Float, 0.0 ),   --  : age_38_female (Amount)
           199 => ( Parameter_Float, 0.0 ),   --  : age_39_female (Amount)
           200 => ( Parameter_Float, 0.0 ),   --  : age_40_female (Amount)
           201 => ( Parameter_Float, 0.0 ),   --  : age_41_female (Amount)
           202 => ( Parameter_Float, 0.0 ),   --  : age_42_female (Amount)
           203 => ( Parameter_Float, 0.0 ),   --  : age_43_female (Amount)
           204 => ( Parameter_Float, 0.0 ),   --  : age_44_female (Amount)
           205 => ( Parameter_Float, 0.0 ),   --  : age_45_female (Amount)
           206 => ( Parameter_Float, 0.0 ),   --  : age_46_female (Amount)
           207 => ( Parameter_Float, 0.0 ),   --  : age_47_female (Amount)
           208 => ( Parameter_Float, 0.0 ),   --  : age_48_female (Amount)
           209 => ( Parameter_Float, 0.0 ),   --  : age_49_female (Amount)
           210 => ( Parameter_Float, 0.0 ),   --  : age_50_female (Amount)
           211 => ( Parameter_Float, 0.0 ),   --  : age_51_female (Amount)
           212 => ( Parameter_Float, 0.0 ),   --  : age_52_female (Amount)
           213 => ( Parameter_Float, 0.0 ),   --  : age_53_female (Amount)
           214 => ( Parameter_Float, 0.0 ),   --  : age_54_female (Amount)
           215 => ( Parameter_Float, 0.0 ),   --  : age_55_female (Amount)
           216 => ( Parameter_Float, 0.0 ),   --  : age_56_female (Amount)
           217 => ( Parameter_Float, 0.0 ),   --  : age_57_female (Amount)
           218 => ( Parameter_Float, 0.0 ),   --  : age_58_female (Amount)
           219 => ( Parameter_Float, 0.0 ),   --  : age_59_female (Amount)
           220 => ( Parameter_Float, 0.0 ),   --  : age_60_female (Amount)
           221 => ( Parameter_Float, 0.0 ),   --  : age_61_female (Amount)
           222 => ( Parameter_Float, 0.0 ),   --  : age_62_female (Amount)
           223 => ( Parameter_Float, 0.0 ),   --  : age_63_female (Amount)
           224 => ( Parameter_Float, 0.0 ),   --  : age_64_female (Amount)
           225 => ( Parameter_Float, 0.0 ),   --  : age_65_female (Amount)
           226 => ( Parameter_Float, 0.0 ),   --  : age_66_female (Amount)
           227 => ( Parameter_Float, 0.0 ),   --  : age_67_female (Amount)
           228 => ( Parameter_Float, 0.0 ),   --  : age_68_female (Amount)
           229 => ( Parameter_Float, 0.0 ),   --  : age_69_female (Amount)
           230 => ( Parameter_Float, 0.0 ),   --  : age_70_female (Amount)
           231 => ( Parameter_Float, 0.0 ),   --  : age_71_female (Amount)
           232 => ( Parameter_Float, 0.0 ),   --  : age_72_female (Amount)
           233 => ( Parameter_Float, 0.0 ),   --  : age_73_female (Amount)
           234 => ( Parameter_Float, 0.0 ),   --  : age_74_female (Amount)
           235 => ( Parameter_Float, 0.0 ),   --  : age_75_female (Amount)
           236 => ( Parameter_Float, 0.0 ),   --  : age_76_female (Amount)
           237 => ( Parameter_Float, 0.0 ),   --  : age_77_female (Amount)
           238 => ( Parameter_Float, 0.0 ),   --  : age_78_female (Amount)
           239 => ( Parameter_Float, 0.0 ),   --  : age_79_female (Amount)
           240 => ( Parameter_Float, 0.0 ),   --  : age_80_female (Amount)
           241 => ( Parameter_Float, 0.0 ),   --  : age_81_female (Amount)
           242 => ( Parameter_Float, 0.0 ),   --  : age_82_female (Amount)
           243 => ( Parameter_Float, 0.0 ),   --  : age_83_female (Amount)
           244 => ( Parameter_Float, 0.0 ),   --  : age_84_female (Amount)
           245 => ( Parameter_Float, 0.0 ),   --  : age_85_female (Amount)
           246 => ( Parameter_Float, 0.0 ),   --  : age_86_female (Amount)
           247 => ( Parameter_Float, 0.0 ),   --  : age_87_female (Amount)
           248 => ( Parameter_Float, 0.0 ),   --  : age_88_female (Amount)
           249 => ( Parameter_Float, 0.0 ),   --  : age_89_female (Amount)
           250 => ( Parameter_Float, 0.0 ),   --  : age_90_female (Amount)
           251 => ( Parameter_Float, 0.0 ),   --  : age_91_female (Amount)
           252 => ( Parameter_Float, 0.0 ),   --  : age_92_female (Amount)
           253 => ( Parameter_Float, 0.0 ),   --  : age_93_female (Amount)
           254 => ( Parameter_Float, 0.0 ),   --  : age_94_female (Amount)
           255 => ( Parameter_Float, 0.0 ),   --  : age_95_female (Amount)
           256 => ( Parameter_Float, 0.0 ),   --  : age_96_female (Amount)
           257 => ( Parameter_Float, 0.0 ),   --  : age_97_female (Amount)
           258 => ( Parameter_Float, 0.0 ),   --  : age_98_female (Amount)
           259 => ( Parameter_Float, 0.0 ),   --  : age_99_female (Amount)
           260 => ( Parameter_Float, 0.0 ),   --  : age_100_female (Amount)
           261 => ( Parameter_Float, 0.0 ),   --  : age_101_female (Amount)
           262 => ( Parameter_Float, 0.0 ),   --  : age_102_female (Amount)
           263 => ( Parameter_Float, 0.0 ),   --  : age_103_female (Amount)
           264 => ( Parameter_Float, 0.0 ),   --  : age_104_female (Amount)
           265 => ( Parameter_Float, 0.0 ),   --  : age_105_female (Amount)
           266 => ( Parameter_Float, 0.0 ),   --  : age_106_female (Amount)
           267 => ( Parameter_Float, 0.0 ),   --  : age_107_female (Amount)
           268 => ( Parameter_Float, 0.0 ),   --  : age_108_female (Amount)
           269 => ( Parameter_Float, 0.0 ),   --  : age_109_female (Amount)
           270 => ( Parameter_Float, 0.0 ),   --  : age_110_female (Amount)
           271 => ( Parameter_Float, 0.0 ),   --  : participation_16_19_male (Amount)
           272 => ( Parameter_Float, 0.0 ),   --  : participation_20_24_male (Amount)
           273 => ( Parameter_Float, 0.0 ),   --  : participation_25_29_male (Amount)
           274 => ( Parameter_Float, 0.0 ),   --  : participation_30_34_male (Amount)
           275 => ( Parameter_Float, 0.0 ),   --  : participation_35_39_male (Amount)
           276 => ( Parameter_Float, 0.0 ),   --  : participation_40_44_male (Amount)
           277 => ( Parameter_Float, 0.0 ),   --  : participation_45_49_male (Amount)
           278 => ( Parameter_Float, 0.0 ),   --  : participation_50_54_male (Amount)
           279 => ( Parameter_Float, 0.0 ),   --  : participation_55_59_male (Amount)
           280 => ( Parameter_Float, 0.0 ),   --  : participation_60_64_male (Amount)
           281 => ( Parameter_Float, 0.0 ),   --  : participation_65_69_male (Amount)
           282 => ( Parameter_Float, 0.0 ),   --  : participation_70_74_male (Amount)
           283 => ( Parameter_Float, 0.0 ),   --  : participation_75_plus_male (Amount)
           284 => ( Parameter_Float, 0.0 ),   --  : participation_16_19_female (Amount)
           285 => ( Parameter_Float, 0.0 ),   --  : participation_20_24_female (Amount)
           286 => ( Parameter_Float, 0.0 ),   --  : participation_25_29_female (Amount)
           287 => ( Parameter_Float, 0.0 ),   --  : participation_30_34_female (Amount)
           288 => ( Parameter_Float, 0.0 ),   --  : participation_35_39_female (Amount)
           289 => ( Parameter_Float, 0.0 ),   --  : participation_40_44_female (Amount)
           290 => ( Parameter_Float, 0.0 ),   --  : participation_45_49_female (Amount)
           291 => ( Parameter_Float, 0.0 ),   --  : participation_50_54_female (Amount)
           292 => ( Parameter_Float, 0.0 ),   --  : participation_55_59_female (Amount)
           293 => ( Parameter_Float, 0.0 ),   --  : participation_60_64_female (Amount)
           294 => ( Parameter_Float, 0.0 ),   --  : participation_65_69_female (Amount)
           295 => ( Parameter_Float, 0.0 ),   --  : participation_70_74_female (Amount)
           296 => ( Parameter_Float, 0.0 ),   --  : participation_75_plus_female (Amount)
           297 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_wales (Amount)
           298 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_wales (Amount)
           299 => ( Parameter_Float, 0.0 ),   --  : other_hh_wales (Amount)
           300 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_nireland (Amount)
           301 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_nireland (Amount)
           302 => ( Parameter_Float, 0.0 ),   --  : other_hh_nireland (Amount)
           303 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_england (Amount)
           304 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_england (Amount)
           305 => ( Parameter_Float, 0.0 ),   --  : other_hh_england (Amount)
           306 => ( Parameter_Float, 0.0 ),   --  : one_adult_hh_scotland (Amount)
           307 => ( Parameter_Float, 0.0 ),   --  : two_adult_hhs_scotland (Amount)
           308 => ( Parameter_Float, 0.0 )   --  : other_hh_scotland (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268, $269, $270, $271, $272, $273, $274, $275, $276, $277, $278, $279, $280, $281, $282, $283, $284, $285, $286, $287, $288, $289, $290, $291, $292, $293, $294, $295, $296, $297, $298, $299, $300, $301, $302, $303, $304, $305, $306, $307, $308 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 4 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Year_Number)
            4 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where run_id = $1 and user_id = $2 and year = $3 and sernum = $4"; 
   begin 
      return Get_Prepared_Retrieve_Statement( s ); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return gse.Prepared_Statement is 
   begin 
      return Get_Prepared_Retrieve_Statement( d.To_String( crit )); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) & sqlstr; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Retrieve_Statement; 


   function Get_Prepared_Update_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " country_uk = $1, country_scotland = $2, country_england = $3, country_wales = $4, country_n_ireland = $5, household_all_households = $6, sco_hhld_one_adult_male = $7, sco_hhld_one_adult_female = $8, sco_hhld_two_adults = $9, sco_hhld_one_adult_one_child = $10, sco_hhld_one_adult_two_plus_children = $11, sco_hhld_two_plus_adult_one_plus_children = $12, sco_hhld_three_plus_person_all_adult = $13, eng_hhld_one_person_households_male = $14, eng_hhld_one_person_households_female = $15, eng_hhld_one_family_and_no_others_couple_no_dependent_chi = $16, eng_hhld_a_couple_and_other_adults_no_dependent_children = $17, eng_hhld_households_with_one_dependent_child = $18, eng_hhld_households_with_two_dependent_children = $19, eng_hhld_households_with_three_dependent_children = $20, eng_hhld_other_households = $21, nir_hhld_one_adult_households = $22, nir_hhld_two_adults_without_children = $23, nir_hhld_other_households_without_children = $24, nir_hhld_one_adult_households_with_children = $25, nir_hhld_other_households_with_children = $26, wal_hhld_1_person = $27, wal_hhld_2_person_no_children = $28, wal_hhld_2_person_1_adult_1_child = $29, wal_hhld_3_person_no_children = $30, wal_hhld_3_person_2_adults_1_child = $31, wal_hhld_3_person_1_adult_2_children = $32, wal_hhld_4_person_no_children = $33, wal_hhld_4_person_2_plus_adults_1_plus_children = $34, wal_hhld_4_person_1_adult_3_children = $35, wal_hhld_5_plus_person_no_children = $36, wal_hhld_5_plus_person_2_plus_adults_1_plus_children = $37, wal_hhld_5_plus_person_1_adult_4_plus_children = $38, male = $39, female = $40, employed = $41, employee = $42, ilo_unemployed = $43, jsa_claimant = $44, age_0_male = $45, age_1_male = $46, age_2_male = $47, age_3_male = $48, age_4_male = $49, age_5_male = $50, age_6_male = $51, age_7_male = $52, age_8_male = $53, age_9_male = $54, age_10_male = $55, age_11_male = $56, age_12_male = $57, age_13_male = $58, age_14_male = $59, age_15_male = $60, age_16_male = $61, age_17_male = $62, age_18_male = $63, age_19_male = $64, age_20_male = $65, age_21_male = $66, age_22_male = $67, age_23_male = $68, age_24_male = $69, age_25_male = $70, age_26_male = $71, age_27_male = $72, age_28_male = $73, age_29_male = $74, age_30_male = $75, age_31_male = $76, age_32_male = $77, age_33_male = $78, age_34_male = $79, age_35_male = $80, age_36_male = $81, age_37_male = $82, age_38_male = $83, age_39_male = $84, age_40_male = $85, age_41_male = $86, age_42_male = $87, age_43_male = $88, age_44_male = $89, age_45_male = $90, age_46_male = $91, age_47_male = $92, age_48_male = $93, age_49_male = $94, age_50_male = $95, age_51_male = $96, age_52_male = $97, age_53_male = $98, age_54_male = $99, age_55_male = $100, age_56_male = $101, age_57_male = $102, age_58_male = $103, age_59_male = $104, age_60_male = $105, age_61_male = $106, age_62_male = $107, age_63_male = $108, age_64_male = $109, age_65_male = $110, age_66_male = $111, age_67_male = $112, age_68_male = $113, age_69_male = $114, age_70_male = $115, age_71_male = $116, age_72_male = $117, age_73_male = $118, age_74_male = $119, age_75_male = $120, age_76_male = $121, age_77_male = $122, age_78_male = $123, age_79_male = $124, age_80_male = $125, age_81_male = $126, age_82_male = $127, age_83_male = $128, age_84_male = $129, age_85_male = $130, age_86_male = $131, age_87_male = $132, age_88_male = $133, age_89_male = $134, age_90_male = $135, age_91_male = $136, age_92_male = $137, age_93_male = $138, age_94_male = $139, age_95_male = $140, age_96_male = $141, age_97_male = $142, age_98_male = $143, age_99_male = $144, age_100_male = $145, age_101_male = $146, age_102_male = $147, age_103_male = $148, age_104_male = $149, age_105_male = $150, age_106_male = $151, age_107_male = $152, age_108_male = $153, age_109_male = $154, age_110_male = $155, age_0_female = $156, age_1_female = $157, age_2_female = $158, age_3_female = $159, age_4_female = $160, age_5_female = $161, age_6_female = $162, age_7_female = $163, age_8_female = $164, age_9_female = $165, age_10_female = $166, age_11_female = $167, age_12_female = $168, age_13_female = $169, age_14_female = $170, age_15_female = $171, age_16_female = $172, age_17_female = $173, age_18_female = $174, age_19_female = $175, age_20_female = $176, age_21_female = $177, age_22_female = $178, age_23_female = $179, age_24_female = $180, age_25_female = $181, age_26_female = $182, age_27_female = $183, age_28_female = $184, age_29_female = $185, age_30_female = $186, age_31_female = $187, age_32_female = $188, age_33_female = $189, age_34_female = $190, age_35_female = $191, age_36_female = $192, age_37_female = $193, age_38_female = $194, age_39_female = $195, age_40_female = $196, age_41_female = $197, age_42_female = $198, age_43_female = $199, age_44_female = $200, age_45_female = $201, age_46_female = $202, age_47_female = $203, age_48_female = $204, age_49_female = $205, age_50_female = $206, age_51_female = $207, age_52_female = $208, age_53_female = $209, age_54_female = $210, age_55_female = $211, age_56_female = $212, age_57_female = $213, age_58_female = $214, age_59_female = $215, age_60_female = $216, age_61_female = $217, age_62_female = $218, age_63_female = $219, age_64_female = $220, age_65_female = $221, age_66_female = $222, age_67_female = $223, age_68_female = $224, age_69_female = $225, age_70_female = $226, age_71_female = $227, age_72_female = $228, age_73_female = $229, age_74_female = $230, age_75_female = $231, age_76_female = $232, age_77_female = $233, age_78_female = $234, age_79_female = $235, age_80_female = $236, age_81_female = $237, age_82_female = $238, age_83_female = $239, age_84_female = $240, age_85_female = $241, age_86_female = $242, age_87_female = $243, age_88_female = $244, age_89_female = $245, age_90_female = $246, age_91_female = $247, age_92_female = $248, age_93_female = $249, age_94_female = $250, age_95_female = $251, age_96_female = $252, age_97_female = $253, age_98_female = $254, age_99_female = $255, age_100_female = $256, age_101_female = $257, age_102_female = $258, age_103_female = $259, age_104_female = $260, age_105_female = $261, age_106_female = $262, age_107_female = $263, age_108_female = $264, age_109_female = $265, age_110_female = $266, participation_16_19_male = $267, participation_20_24_male = $268, participation_25_29_male = $269, participation_30_34_male = $270, participation_35_39_male = $271, participation_40_44_male = $272, participation_45_49_male = $273, participation_50_54_male = $274, participation_55_59_male = $275, participation_60_64_male = $276, participation_65_69_male = $277, participation_70_74_male = $278, participation_75_plus_male = $279, participation_16_19_female = $280, participation_20_24_female = $281, participation_25_29_female = $282, participation_30_34_female = $283, participation_35_39_female = $284, participation_40_44_female = $285, participation_45_49_female = $286, participation_50_54_female = $287, participation_55_59_female = $288, participation_60_64_female = $289, participation_65_69_female = $290, participation_70_74_female = $291, participation_75_plus_female = $292, one_adult_hh_wales = $293, two_adult_hhs_wales = $294, other_hh_wales = $295, one_adult_hh_nireland = $296, two_adult_hhs_nireland = $297, other_hh_nireland = $298, one_adult_hh_england = $299, two_adult_hhs_england = $300, other_hh_england = $301, one_adult_hh_scotland = $302, two_adult_hhs_scotland = $303, other_hh_scotland = $304 where run_id = $305 and user_id = $306 and year = $307 and sernum = $308"; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Update_Statement; 


   
   
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     


   
   Next_Free_run_id_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( run_id ) + 1, 1 ) from target_data.target_dataset", SCHEMA_NAME );
   Next_Free_run_id_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_run_id_query, On_Server => True );
   -- 
   -- Next highest avaiable value of run_id - useful for saving  
   --
   function Next_Free_run_id( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_run_id_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_run_id;


   Next_Free_user_id_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from target_data.target_dataset", SCHEMA_NAME );
   Next_Free_user_id_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_user_id_query, On_Server => True );
   -- 
   -- Next highest avaiable value of user_id - useful for saving  
   --
   function Next_Free_user_id( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_user_id_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_user_id;


   Next_Free_year_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from target_data.target_dataset", SCHEMA_NAME );
   Next_Free_year_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_year_query, On_Server => True );
   -- 
   -- Next highest avaiable value of year - useful for saving  
   --
   function Next_Free_year( connection : Database_Connection := null) return Year_Number is
      cursor              : gse.Forward_Cursor;
      ai                  : Year_Number;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Year_Number'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_year;


   Next_Free_sernum_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from target_data.target_dataset", SCHEMA_NAME );
   Next_Free_sernum_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_sernum_query, On_Server => True );
   -- 
   -- Next highest avaiable value of sernum - useful for saving  
   --
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value is
      cursor              : gse.Forward_Cursor;
      ai                  : Sernum_Value;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_sernum_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Sernum_Value'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_sernum;



   --
   -- returns true if the primary key parts of Ukds.Target_Data.Target_Dataset match the defaults in Ukds.Target_Data.Null_Target_Dataset
   --
   --
   -- Does this Ukds.Target_Data.Target_Dataset equal the default Ukds.Target_Data.Null_Target_Dataset ?
   --
   function Is_Null( a_target_dataset : Target_Dataset ) return Boolean is
   begin
      return a_target_dataset = Ukds.Target_Data.Null_Target_Dataset;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Target_Dataset matching the primary key fields, or the Ukds.Target_Data.Null_Target_Dataset record
   -- if no such record exists
   --
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; year : Year_Number; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset is
      l : Ukds.Target_Data.Target_Dataset_List;
      a_target_dataset : Ukds.Target_Data.Target_Dataset;
      c : d.Criteria;
   begin      
      Add_run_id( c, run_id );
      Add_user_id( c, user_id );
      Add_year( c, year );
      Add_sernum( c, sernum );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Target_Dataset_List_Package.is_empty( l ) ) then
         a_target_dataset := Ukds.Target_Data.Target_Dataset_List_Package.First_Element( l );
      else
         a_target_dataset := Ukds.Target_Data.Null_Target_Dataset;
      end if;
      return a_target_dataset;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.target_dataset where run_id = $1 and user_id = $2 and year = $3 and sernum = $4", 
        On_Server => True );
        
   function Exists( run_id : Integer; user_id : Integer; year : Year_Number; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      cursor : gse.Forward_Cursor;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      found : Boolean;        
   begin 
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      params( 1 ) := "+"( Integer'Pos( run_id ));
      params( 2 ) := "+"( Integer'Pos( user_id ));
      params( 3 ) := "+"( Year_Number'Pos( year ));
      params( 4 ) := As_Bigint( sernum );
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Target_Dataset matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Target_Dataset retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Target_Dataset is
      a_target_dataset : Ukds.Target_Data.Target_Dataset;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_target_dataset.run_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_target_dataset.user_id := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_target_dataset.year := Year_Number'Value( gse.Value( cursor, 2 ));
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_target_dataset.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_target_dataset.country_uk:= Amount'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_target_dataset.country_scotland:= Amount'Value( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_target_dataset.country_england:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_target_dataset.country_wales:= Amount'Value( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_target_dataset.country_n_ireland:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_target_dataset.household_all_households:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_target_dataset.sco_hhld_one_adult_male:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_target_dataset.sco_hhld_one_adult_female:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_target_dataset.sco_hhld_two_adults:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_target_dataset.sco_hhld_one_adult_one_child:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_target_dataset.sco_hhld_one_adult_two_plus_children:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_target_dataset.sco_hhld_two_plus_adult_one_plus_children:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_target_dataset.sco_hhld_three_plus_person_all_adult:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_target_dataset.eng_hhld_one_person_households_male:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_target_dataset.eng_hhld_one_person_households_female:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_target_dataset.eng_hhld_one_family_and_no_others_couple_no_dependent_chi:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_target_dataset.eng_hhld_a_couple_and_other_adults_no_dependent_children:= Amount'Value( gse.Value( cursor, 20 ));
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_target_dataset.eng_hhld_households_with_one_dependent_child:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_target_dataset.eng_hhld_households_with_two_dependent_children:= Amount'Value( gse.Value( cursor, 22 ));
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_target_dataset.eng_hhld_households_with_three_dependent_children:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_target_dataset.eng_hhld_other_households:= Amount'Value( gse.Value( cursor, 24 ));
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_target_dataset.nir_hhld_one_adult_households:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_target_dataset.nir_hhld_two_adults_without_children:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_target_dataset.nir_hhld_other_households_without_children:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_target_dataset.nir_hhld_one_adult_households_with_children:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_target_dataset.nir_hhld_other_households_with_children:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_target_dataset.wal_hhld_1_person:= Amount'Value( gse.Value( cursor, 30 ));
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_target_dataset.wal_hhld_2_person_no_children:= Amount'Value( gse.Value( cursor, 31 ));
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_target_dataset.wal_hhld_2_person_1_adult_1_child:= Amount'Value( gse.Value( cursor, 32 ));
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_target_dataset.wal_hhld_3_person_no_children:= Amount'Value( gse.Value( cursor, 33 ));
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_target_dataset.wal_hhld_3_person_2_adults_1_child:= Amount'Value( gse.Value( cursor, 34 ));
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_target_dataset.wal_hhld_3_person_1_adult_2_children:= Amount'Value( gse.Value( cursor, 35 ));
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_target_dataset.wal_hhld_4_person_no_children:= Amount'Value( gse.Value( cursor, 36 ));
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_target_dataset.wal_hhld_4_person_2_plus_adults_1_plus_children:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_target_dataset.wal_hhld_4_person_1_adult_3_children:= Amount'Value( gse.Value( cursor, 38 ));
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_target_dataset.wal_hhld_5_plus_person_no_children:= Amount'Value( gse.Value( cursor, 39 ));
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_target_dataset.wal_hhld_5_plus_person_2_plus_adults_1_plus_children:= Amount'Value( gse.Value( cursor, 40 ));
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_target_dataset.wal_hhld_5_plus_person_1_adult_4_plus_children:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_target_dataset.male:= Amount'Value( gse.Value( cursor, 42 ));
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_target_dataset.female:= Amount'Value( gse.Value( cursor, 43 ));
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_target_dataset.employed:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_target_dataset.employee:= Amount'Value( gse.Value( cursor, 45 ));
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_target_dataset.ilo_unemployed:= Amount'Value( gse.Value( cursor, 46 ));
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_target_dataset.jsa_claimant:= Amount'Value( gse.Value( cursor, 47 ));
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_target_dataset.age_0_male:= Amount'Value( gse.Value( cursor, 48 ));
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_target_dataset.age_1_male:= Amount'Value( gse.Value( cursor, 49 ));
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_target_dataset.age_2_male:= Amount'Value( gse.Value( cursor, 50 ));
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_target_dataset.age_3_male:= Amount'Value( gse.Value( cursor, 51 ));
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_target_dataset.age_4_male:= Amount'Value( gse.Value( cursor, 52 ));
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_target_dataset.age_5_male:= Amount'Value( gse.Value( cursor, 53 ));
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_target_dataset.age_6_male:= Amount'Value( gse.Value( cursor, 54 ));
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_target_dataset.age_7_male:= Amount'Value( gse.Value( cursor, 55 ));
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_target_dataset.age_8_male:= Amount'Value( gse.Value( cursor, 56 ));
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_target_dataset.age_9_male:= Amount'Value( gse.Value( cursor, 57 ));
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_target_dataset.age_10_male:= Amount'Value( gse.Value( cursor, 58 ));
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_target_dataset.age_11_male:= Amount'Value( gse.Value( cursor, 59 ));
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_target_dataset.age_12_male:= Amount'Value( gse.Value( cursor, 60 ));
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_target_dataset.age_13_male:= Amount'Value( gse.Value( cursor, 61 ));
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_target_dataset.age_14_male:= Amount'Value( gse.Value( cursor, 62 ));
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_target_dataset.age_15_male:= Amount'Value( gse.Value( cursor, 63 ));
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_target_dataset.age_16_male:= Amount'Value( gse.Value( cursor, 64 ));
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_target_dataset.age_17_male:= Amount'Value( gse.Value( cursor, 65 ));
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_target_dataset.age_18_male:= Amount'Value( gse.Value( cursor, 66 ));
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_target_dataset.age_19_male:= Amount'Value( gse.Value( cursor, 67 ));
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_target_dataset.age_20_male:= Amount'Value( gse.Value( cursor, 68 ));
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_target_dataset.age_21_male:= Amount'Value( gse.Value( cursor, 69 ));
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_target_dataset.age_22_male:= Amount'Value( gse.Value( cursor, 70 ));
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_target_dataset.age_23_male:= Amount'Value( gse.Value( cursor, 71 ));
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_target_dataset.age_24_male:= Amount'Value( gse.Value( cursor, 72 ));
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_target_dataset.age_25_male:= Amount'Value( gse.Value( cursor, 73 ));
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_target_dataset.age_26_male:= Amount'Value( gse.Value( cursor, 74 ));
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_target_dataset.age_27_male:= Amount'Value( gse.Value( cursor, 75 ));
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_target_dataset.age_28_male:= Amount'Value( gse.Value( cursor, 76 ));
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_target_dataset.age_29_male:= Amount'Value( gse.Value( cursor, 77 ));
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_target_dataset.age_30_male:= Amount'Value( gse.Value( cursor, 78 ));
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_target_dataset.age_31_male:= Amount'Value( gse.Value( cursor, 79 ));
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_target_dataset.age_32_male:= Amount'Value( gse.Value( cursor, 80 ));
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_target_dataset.age_33_male:= Amount'Value( gse.Value( cursor, 81 ));
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_target_dataset.age_34_male:= Amount'Value( gse.Value( cursor, 82 ));
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_target_dataset.age_35_male:= Amount'Value( gse.Value( cursor, 83 ));
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_target_dataset.age_36_male:= Amount'Value( gse.Value( cursor, 84 ));
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_target_dataset.age_37_male:= Amount'Value( gse.Value( cursor, 85 ));
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_target_dataset.age_38_male:= Amount'Value( gse.Value( cursor, 86 ));
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_target_dataset.age_39_male:= Amount'Value( gse.Value( cursor, 87 ));
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_target_dataset.age_40_male:= Amount'Value( gse.Value( cursor, 88 ));
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_target_dataset.age_41_male:= Amount'Value( gse.Value( cursor, 89 ));
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_target_dataset.age_42_male:= Amount'Value( gse.Value( cursor, 90 ));
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_target_dataset.age_43_male:= Amount'Value( gse.Value( cursor, 91 ));
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_target_dataset.age_44_male:= Amount'Value( gse.Value( cursor, 92 ));
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_target_dataset.age_45_male:= Amount'Value( gse.Value( cursor, 93 ));
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_target_dataset.age_46_male:= Amount'Value( gse.Value( cursor, 94 ));
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_target_dataset.age_47_male:= Amount'Value( gse.Value( cursor, 95 ));
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_target_dataset.age_48_male:= Amount'Value( gse.Value( cursor, 96 ));
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_target_dataset.age_49_male:= Amount'Value( gse.Value( cursor, 97 ));
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_target_dataset.age_50_male:= Amount'Value( gse.Value( cursor, 98 ));
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_target_dataset.age_51_male:= Amount'Value( gse.Value( cursor, 99 ));
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_target_dataset.age_52_male:= Amount'Value( gse.Value( cursor, 100 ));
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_target_dataset.age_53_male:= Amount'Value( gse.Value( cursor, 101 ));
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_target_dataset.age_54_male:= Amount'Value( gse.Value( cursor, 102 ));
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_target_dataset.age_55_male:= Amount'Value( gse.Value( cursor, 103 ));
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_target_dataset.age_56_male:= Amount'Value( gse.Value( cursor, 104 ));
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_target_dataset.age_57_male:= Amount'Value( gse.Value( cursor, 105 ));
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_target_dataset.age_58_male:= Amount'Value( gse.Value( cursor, 106 ));
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_target_dataset.age_59_male:= Amount'Value( gse.Value( cursor, 107 ));
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_target_dataset.age_60_male:= Amount'Value( gse.Value( cursor, 108 ));
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_target_dataset.age_61_male:= Amount'Value( gse.Value( cursor, 109 ));
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_target_dataset.age_62_male:= Amount'Value( gse.Value( cursor, 110 ));
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_target_dataset.age_63_male:= Amount'Value( gse.Value( cursor, 111 ));
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_target_dataset.age_64_male:= Amount'Value( gse.Value( cursor, 112 ));
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_target_dataset.age_65_male:= Amount'Value( gse.Value( cursor, 113 ));
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_target_dataset.age_66_male:= Amount'Value( gse.Value( cursor, 114 ));
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_target_dataset.age_67_male:= Amount'Value( gse.Value( cursor, 115 ));
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_target_dataset.age_68_male:= Amount'Value( gse.Value( cursor, 116 ));
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_target_dataset.age_69_male:= Amount'Value( gse.Value( cursor, 117 ));
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_target_dataset.age_70_male:= Amount'Value( gse.Value( cursor, 118 ));
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_target_dataset.age_71_male:= Amount'Value( gse.Value( cursor, 119 ));
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_target_dataset.age_72_male:= Amount'Value( gse.Value( cursor, 120 ));
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_target_dataset.age_73_male:= Amount'Value( gse.Value( cursor, 121 ));
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_target_dataset.age_74_male:= Amount'Value( gse.Value( cursor, 122 ));
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_target_dataset.age_75_male:= Amount'Value( gse.Value( cursor, 123 ));
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_target_dataset.age_76_male:= Amount'Value( gse.Value( cursor, 124 ));
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_target_dataset.age_77_male:= Amount'Value( gse.Value( cursor, 125 ));
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_target_dataset.age_78_male:= Amount'Value( gse.Value( cursor, 126 ));
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_target_dataset.age_79_male:= Amount'Value( gse.Value( cursor, 127 ));
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_target_dataset.age_80_male:= Amount'Value( gse.Value( cursor, 128 ));
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_target_dataset.age_81_male:= Amount'Value( gse.Value( cursor, 129 ));
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_target_dataset.age_82_male:= Amount'Value( gse.Value( cursor, 130 ));
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_target_dataset.age_83_male:= Amount'Value( gse.Value( cursor, 131 ));
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_target_dataset.age_84_male:= Amount'Value( gse.Value( cursor, 132 ));
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_target_dataset.age_85_male:= Amount'Value( gse.Value( cursor, 133 ));
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_target_dataset.age_86_male:= Amount'Value( gse.Value( cursor, 134 ));
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_target_dataset.age_87_male:= Amount'Value( gse.Value( cursor, 135 ));
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_target_dataset.age_88_male:= Amount'Value( gse.Value( cursor, 136 ));
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_target_dataset.age_89_male:= Amount'Value( gse.Value( cursor, 137 ));
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_target_dataset.age_90_male:= Amount'Value( gse.Value( cursor, 138 ));
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_target_dataset.age_91_male:= Amount'Value( gse.Value( cursor, 139 ));
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_target_dataset.age_92_male:= Amount'Value( gse.Value( cursor, 140 ));
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_target_dataset.age_93_male:= Amount'Value( gse.Value( cursor, 141 ));
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_target_dataset.age_94_male:= Amount'Value( gse.Value( cursor, 142 ));
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_target_dataset.age_95_male:= Amount'Value( gse.Value( cursor, 143 ));
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_target_dataset.age_96_male:= Amount'Value( gse.Value( cursor, 144 ));
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_target_dataset.age_97_male:= Amount'Value( gse.Value( cursor, 145 ));
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_target_dataset.age_98_male:= Amount'Value( gse.Value( cursor, 146 ));
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_target_dataset.age_99_male:= Amount'Value( gse.Value( cursor, 147 ));
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_target_dataset.age_100_male:= Amount'Value( gse.Value( cursor, 148 ));
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_target_dataset.age_101_male:= Amount'Value( gse.Value( cursor, 149 ));
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_target_dataset.age_102_male:= Amount'Value( gse.Value( cursor, 150 ));
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_target_dataset.age_103_male:= Amount'Value( gse.Value( cursor, 151 ));
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_target_dataset.age_104_male:= Amount'Value( gse.Value( cursor, 152 ));
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_target_dataset.age_105_male:= Amount'Value( gse.Value( cursor, 153 ));
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_target_dataset.age_106_male:= Amount'Value( gse.Value( cursor, 154 ));
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_target_dataset.age_107_male:= Amount'Value( gse.Value( cursor, 155 ));
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_target_dataset.age_108_male:= Amount'Value( gse.Value( cursor, 156 ));
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_target_dataset.age_109_male:= Amount'Value( gse.Value( cursor, 157 ));
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_target_dataset.age_110_male:= Amount'Value( gse.Value( cursor, 158 ));
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_target_dataset.age_0_female:= Amount'Value( gse.Value( cursor, 159 ));
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_target_dataset.age_1_female:= Amount'Value( gse.Value( cursor, 160 ));
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_target_dataset.age_2_female:= Amount'Value( gse.Value( cursor, 161 ));
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_target_dataset.age_3_female:= Amount'Value( gse.Value( cursor, 162 ));
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_target_dataset.age_4_female:= Amount'Value( gse.Value( cursor, 163 ));
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_target_dataset.age_5_female:= Amount'Value( gse.Value( cursor, 164 ));
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_target_dataset.age_6_female:= Amount'Value( gse.Value( cursor, 165 ));
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_target_dataset.age_7_female:= Amount'Value( gse.Value( cursor, 166 ));
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_target_dataset.age_8_female:= Amount'Value( gse.Value( cursor, 167 ));
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_target_dataset.age_9_female:= Amount'Value( gse.Value( cursor, 168 ));
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_target_dataset.age_10_female:= Amount'Value( gse.Value( cursor, 169 ));
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_target_dataset.age_11_female:= Amount'Value( gse.Value( cursor, 170 ));
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_target_dataset.age_12_female:= Amount'Value( gse.Value( cursor, 171 ));
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_target_dataset.age_13_female:= Amount'Value( gse.Value( cursor, 172 ));
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_target_dataset.age_14_female:= Amount'Value( gse.Value( cursor, 173 ));
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_target_dataset.age_15_female:= Amount'Value( gse.Value( cursor, 174 ));
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_target_dataset.age_16_female:= Amount'Value( gse.Value( cursor, 175 ));
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_target_dataset.age_17_female:= Amount'Value( gse.Value( cursor, 176 ));
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_target_dataset.age_18_female:= Amount'Value( gse.Value( cursor, 177 ));
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_target_dataset.age_19_female:= Amount'Value( gse.Value( cursor, 178 ));
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_target_dataset.age_20_female:= Amount'Value( gse.Value( cursor, 179 ));
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_target_dataset.age_21_female:= Amount'Value( gse.Value( cursor, 180 ));
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_target_dataset.age_22_female:= Amount'Value( gse.Value( cursor, 181 ));
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_target_dataset.age_23_female:= Amount'Value( gse.Value( cursor, 182 ));
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_target_dataset.age_24_female:= Amount'Value( gse.Value( cursor, 183 ));
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_target_dataset.age_25_female:= Amount'Value( gse.Value( cursor, 184 ));
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_target_dataset.age_26_female:= Amount'Value( gse.Value( cursor, 185 ));
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_target_dataset.age_27_female:= Amount'Value( gse.Value( cursor, 186 ));
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_target_dataset.age_28_female:= Amount'Value( gse.Value( cursor, 187 ));
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_target_dataset.age_29_female:= Amount'Value( gse.Value( cursor, 188 ));
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_target_dataset.age_30_female:= Amount'Value( gse.Value( cursor, 189 ));
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_target_dataset.age_31_female:= Amount'Value( gse.Value( cursor, 190 ));
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_target_dataset.age_32_female:= Amount'Value( gse.Value( cursor, 191 ));
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_target_dataset.age_33_female:= Amount'Value( gse.Value( cursor, 192 ));
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_target_dataset.age_34_female:= Amount'Value( gse.Value( cursor, 193 ));
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_target_dataset.age_35_female:= Amount'Value( gse.Value( cursor, 194 ));
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_target_dataset.age_36_female:= Amount'Value( gse.Value( cursor, 195 ));
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_target_dataset.age_37_female:= Amount'Value( gse.Value( cursor, 196 ));
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_target_dataset.age_38_female:= Amount'Value( gse.Value( cursor, 197 ));
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_target_dataset.age_39_female:= Amount'Value( gse.Value( cursor, 198 ));
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_target_dataset.age_40_female:= Amount'Value( gse.Value( cursor, 199 ));
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_target_dataset.age_41_female:= Amount'Value( gse.Value( cursor, 200 ));
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_target_dataset.age_42_female:= Amount'Value( gse.Value( cursor, 201 ));
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_target_dataset.age_43_female:= Amount'Value( gse.Value( cursor, 202 ));
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_target_dataset.age_44_female:= Amount'Value( gse.Value( cursor, 203 ));
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_target_dataset.age_45_female:= Amount'Value( gse.Value( cursor, 204 ));
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_target_dataset.age_46_female:= Amount'Value( gse.Value( cursor, 205 ));
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_target_dataset.age_47_female:= Amount'Value( gse.Value( cursor, 206 ));
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_target_dataset.age_48_female:= Amount'Value( gse.Value( cursor, 207 ));
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_target_dataset.age_49_female:= Amount'Value( gse.Value( cursor, 208 ));
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_target_dataset.age_50_female:= Amount'Value( gse.Value( cursor, 209 ));
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_target_dataset.age_51_female:= Amount'Value( gse.Value( cursor, 210 ));
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_target_dataset.age_52_female:= Amount'Value( gse.Value( cursor, 211 ));
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_target_dataset.age_53_female:= Amount'Value( gse.Value( cursor, 212 ));
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_target_dataset.age_54_female:= Amount'Value( gse.Value( cursor, 213 ));
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_target_dataset.age_55_female:= Amount'Value( gse.Value( cursor, 214 ));
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_target_dataset.age_56_female:= Amount'Value( gse.Value( cursor, 215 ));
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_target_dataset.age_57_female:= Amount'Value( gse.Value( cursor, 216 ));
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_target_dataset.age_58_female:= Amount'Value( gse.Value( cursor, 217 ));
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_target_dataset.age_59_female:= Amount'Value( gse.Value( cursor, 218 ));
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_target_dataset.age_60_female:= Amount'Value( gse.Value( cursor, 219 ));
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_target_dataset.age_61_female:= Amount'Value( gse.Value( cursor, 220 ));
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_target_dataset.age_62_female:= Amount'Value( gse.Value( cursor, 221 ));
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_target_dataset.age_63_female:= Amount'Value( gse.Value( cursor, 222 ));
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_target_dataset.age_64_female:= Amount'Value( gse.Value( cursor, 223 ));
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_target_dataset.age_65_female:= Amount'Value( gse.Value( cursor, 224 ));
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_target_dataset.age_66_female:= Amount'Value( gse.Value( cursor, 225 ));
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_target_dataset.age_67_female:= Amount'Value( gse.Value( cursor, 226 ));
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_target_dataset.age_68_female:= Amount'Value( gse.Value( cursor, 227 ));
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_target_dataset.age_69_female:= Amount'Value( gse.Value( cursor, 228 ));
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_target_dataset.age_70_female:= Amount'Value( gse.Value( cursor, 229 ));
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_target_dataset.age_71_female:= Amount'Value( gse.Value( cursor, 230 ));
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_target_dataset.age_72_female:= Amount'Value( gse.Value( cursor, 231 ));
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_target_dataset.age_73_female:= Amount'Value( gse.Value( cursor, 232 ));
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_target_dataset.age_74_female:= Amount'Value( gse.Value( cursor, 233 ));
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_target_dataset.age_75_female:= Amount'Value( gse.Value( cursor, 234 ));
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_target_dataset.age_76_female:= Amount'Value( gse.Value( cursor, 235 ));
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_target_dataset.age_77_female:= Amount'Value( gse.Value( cursor, 236 ));
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_target_dataset.age_78_female:= Amount'Value( gse.Value( cursor, 237 ));
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_target_dataset.age_79_female:= Amount'Value( gse.Value( cursor, 238 ));
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_target_dataset.age_80_female:= Amount'Value( gse.Value( cursor, 239 ));
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_target_dataset.age_81_female:= Amount'Value( gse.Value( cursor, 240 ));
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_target_dataset.age_82_female:= Amount'Value( gse.Value( cursor, 241 ));
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_target_dataset.age_83_female:= Amount'Value( gse.Value( cursor, 242 ));
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_target_dataset.age_84_female:= Amount'Value( gse.Value( cursor, 243 ));
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_target_dataset.age_85_female:= Amount'Value( gse.Value( cursor, 244 ));
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_target_dataset.age_86_female:= Amount'Value( gse.Value( cursor, 245 ));
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_target_dataset.age_87_female:= Amount'Value( gse.Value( cursor, 246 ));
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_target_dataset.age_88_female:= Amount'Value( gse.Value( cursor, 247 ));
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_target_dataset.age_89_female:= Amount'Value( gse.Value( cursor, 248 ));
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_target_dataset.age_90_female:= Amount'Value( gse.Value( cursor, 249 ));
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_target_dataset.age_91_female:= Amount'Value( gse.Value( cursor, 250 ));
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_target_dataset.age_92_female:= Amount'Value( gse.Value( cursor, 251 ));
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_target_dataset.age_93_female:= Amount'Value( gse.Value( cursor, 252 ));
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_target_dataset.age_94_female:= Amount'Value( gse.Value( cursor, 253 ));
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_target_dataset.age_95_female:= Amount'Value( gse.Value( cursor, 254 ));
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_target_dataset.age_96_female:= Amount'Value( gse.Value( cursor, 255 ));
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_target_dataset.age_97_female:= Amount'Value( gse.Value( cursor, 256 ));
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_target_dataset.age_98_female:= Amount'Value( gse.Value( cursor, 257 ));
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_target_dataset.age_99_female:= Amount'Value( gse.Value( cursor, 258 ));
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_target_dataset.age_100_female:= Amount'Value( gse.Value( cursor, 259 ));
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_target_dataset.age_101_female:= Amount'Value( gse.Value( cursor, 260 ));
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_target_dataset.age_102_female:= Amount'Value( gse.Value( cursor, 261 ));
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_target_dataset.age_103_female:= Amount'Value( gse.Value( cursor, 262 ));
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_target_dataset.age_104_female:= Amount'Value( gse.Value( cursor, 263 ));
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_target_dataset.age_105_female:= Amount'Value( gse.Value( cursor, 264 ));
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_target_dataset.age_106_female:= Amount'Value( gse.Value( cursor, 265 ));
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_target_dataset.age_107_female:= Amount'Value( gse.Value( cursor, 266 ));
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_target_dataset.age_108_female:= Amount'Value( gse.Value( cursor, 267 ));
      end if;
      if not gse.Is_Null( cursor, 268 )then
         a_target_dataset.age_109_female:= Amount'Value( gse.Value( cursor, 268 ));
      end if;
      if not gse.Is_Null( cursor, 269 )then
         a_target_dataset.age_110_female:= Amount'Value( gse.Value( cursor, 269 ));
      end if;
      if not gse.Is_Null( cursor, 270 )then
         a_target_dataset.participation_16_19_male:= Amount'Value( gse.Value( cursor, 270 ));
      end if;
      if not gse.Is_Null( cursor, 271 )then
         a_target_dataset.participation_20_24_male:= Amount'Value( gse.Value( cursor, 271 ));
      end if;
      if not gse.Is_Null( cursor, 272 )then
         a_target_dataset.participation_25_29_male:= Amount'Value( gse.Value( cursor, 272 ));
      end if;
      if not gse.Is_Null( cursor, 273 )then
         a_target_dataset.participation_30_34_male:= Amount'Value( gse.Value( cursor, 273 ));
      end if;
      if not gse.Is_Null( cursor, 274 )then
         a_target_dataset.participation_35_39_male:= Amount'Value( gse.Value( cursor, 274 ));
      end if;
      if not gse.Is_Null( cursor, 275 )then
         a_target_dataset.participation_40_44_male:= Amount'Value( gse.Value( cursor, 275 ));
      end if;
      if not gse.Is_Null( cursor, 276 )then
         a_target_dataset.participation_45_49_male:= Amount'Value( gse.Value( cursor, 276 ));
      end if;
      if not gse.Is_Null( cursor, 277 )then
         a_target_dataset.participation_50_54_male:= Amount'Value( gse.Value( cursor, 277 ));
      end if;
      if not gse.Is_Null( cursor, 278 )then
         a_target_dataset.participation_55_59_male:= Amount'Value( gse.Value( cursor, 278 ));
      end if;
      if not gse.Is_Null( cursor, 279 )then
         a_target_dataset.participation_60_64_male:= Amount'Value( gse.Value( cursor, 279 ));
      end if;
      if not gse.Is_Null( cursor, 280 )then
         a_target_dataset.participation_65_69_male:= Amount'Value( gse.Value( cursor, 280 ));
      end if;
      if not gse.Is_Null( cursor, 281 )then
         a_target_dataset.participation_70_74_male:= Amount'Value( gse.Value( cursor, 281 ));
      end if;
      if not gse.Is_Null( cursor, 282 )then
         a_target_dataset.participation_75_plus_male:= Amount'Value( gse.Value( cursor, 282 ));
      end if;
      if not gse.Is_Null( cursor, 283 )then
         a_target_dataset.participation_16_19_female:= Amount'Value( gse.Value( cursor, 283 ));
      end if;
      if not gse.Is_Null( cursor, 284 )then
         a_target_dataset.participation_20_24_female:= Amount'Value( gse.Value( cursor, 284 ));
      end if;
      if not gse.Is_Null( cursor, 285 )then
         a_target_dataset.participation_25_29_female:= Amount'Value( gse.Value( cursor, 285 ));
      end if;
      if not gse.Is_Null( cursor, 286 )then
         a_target_dataset.participation_30_34_female:= Amount'Value( gse.Value( cursor, 286 ));
      end if;
      if not gse.Is_Null( cursor, 287 )then
         a_target_dataset.participation_35_39_female:= Amount'Value( gse.Value( cursor, 287 ));
      end if;
      if not gse.Is_Null( cursor, 288 )then
         a_target_dataset.participation_40_44_female:= Amount'Value( gse.Value( cursor, 288 ));
      end if;
      if not gse.Is_Null( cursor, 289 )then
         a_target_dataset.participation_45_49_female:= Amount'Value( gse.Value( cursor, 289 ));
      end if;
      if not gse.Is_Null( cursor, 290 )then
         a_target_dataset.participation_50_54_female:= Amount'Value( gse.Value( cursor, 290 ));
      end if;
      if not gse.Is_Null( cursor, 291 )then
         a_target_dataset.participation_55_59_female:= Amount'Value( gse.Value( cursor, 291 ));
      end if;
      if not gse.Is_Null( cursor, 292 )then
         a_target_dataset.participation_60_64_female:= Amount'Value( gse.Value( cursor, 292 ));
      end if;
      if not gse.Is_Null( cursor, 293 )then
         a_target_dataset.participation_65_69_female:= Amount'Value( gse.Value( cursor, 293 ));
      end if;
      if not gse.Is_Null( cursor, 294 )then
         a_target_dataset.participation_70_74_female:= Amount'Value( gse.Value( cursor, 294 ));
      end if;
      if not gse.Is_Null( cursor, 295 )then
         a_target_dataset.participation_75_plus_female:= Amount'Value( gse.Value( cursor, 295 ));
      end if;
      if not gse.Is_Null( cursor, 296 )then
         a_target_dataset.one_adult_hh_wales:= Amount'Value( gse.Value( cursor, 296 ));
      end if;
      if not gse.Is_Null( cursor, 297 )then
         a_target_dataset.two_adult_hhs_wales:= Amount'Value( gse.Value( cursor, 297 ));
      end if;
      if not gse.Is_Null( cursor, 298 )then
         a_target_dataset.other_hh_wales:= Amount'Value( gse.Value( cursor, 298 ));
      end if;
      if not gse.Is_Null( cursor, 299 )then
         a_target_dataset.one_adult_hh_nireland:= Amount'Value( gse.Value( cursor, 299 ));
      end if;
      if not gse.Is_Null( cursor, 300 )then
         a_target_dataset.two_adult_hhs_nireland:= Amount'Value( gse.Value( cursor, 300 ));
      end if;
      if not gse.Is_Null( cursor, 301 )then
         a_target_dataset.other_hh_nireland:= Amount'Value( gse.Value( cursor, 301 ));
      end if;
      if not gse.Is_Null( cursor, 302 )then
         a_target_dataset.one_adult_hh_england:= Amount'Value( gse.Value( cursor, 302 ));
      end if;
      if not gse.Is_Null( cursor, 303 )then
         a_target_dataset.two_adult_hhs_england:= Amount'Value( gse.Value( cursor, 303 ));
      end if;
      if not gse.Is_Null( cursor, 304 )then
         a_target_dataset.other_hh_england:= Amount'Value( gse.Value( cursor, 304 ));
      end if;
      if not gse.Is_Null( cursor, 305 )then
         a_target_dataset.one_adult_hh_scotland:= Amount'Value( gse.Value( cursor, 305 ));
      end if;
      if not gse.Is_Null( cursor, 306 )then
         a_target_dataset.two_adult_hhs_scotland:= Amount'Value( gse.Value( cursor, 306 ));
      end if;
      if not gse.Is_Null( cursor, 307 )then
         a_target_dataset.other_hh_scotland:= Amount'Value( gse.Value( cursor, 307 ));
      end if;
      return a_target_dataset;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset_List is
      l : Ukds.Target_Data.Target_Dataset_List;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) 
         & " " & sqlstr;
      cursor   : gse.Forward_Cursor;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "retrieve made this as query " & query );
      cursor.Fetch( local_connection, query );
      Check_Result( local_connection );
      while gse.Has_Row( cursor ) loop
         declare
            a_target_dataset : Ukds.Target_Data.Target_Dataset := Map_From_Cursor( cursor );
         begin
            l.append( a_target_dataset ); 
         end;
         gse.Next( cursor );
      end loop;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --

   UPDATE_PS : constant gse.Prepared_Statement := Get_Prepared_Update_Statement;
   
   procedure Update( a_target_dataset : Ukds.Target_Data.Target_Dataset; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Float( a_target_dataset.country_uk ));
      params( 2 ) := "+"( Float( a_target_dataset.country_scotland ));
      params( 3 ) := "+"( Float( a_target_dataset.country_england ));
      params( 4 ) := "+"( Float( a_target_dataset.country_wales ));
      params( 5 ) := "+"( Float( a_target_dataset.country_n_ireland ));
      params( 6 ) := "+"( Float( a_target_dataset.household_all_households ));
      params( 7 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_male ));
      params( 8 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_female ));
      params( 9 ) := "+"( Float( a_target_dataset.sco_hhld_two_adults ));
      params( 10 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_one_child ));
      params( 11 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_two_plus_children ));
      params( 12 ) := "+"( Float( a_target_dataset.sco_hhld_two_plus_adult_one_plus_children ));
      params( 13 ) := "+"( Float( a_target_dataset.sco_hhld_three_plus_person_all_adult ));
      params( 14 ) := "+"( Float( a_target_dataset.eng_hhld_one_person_households_male ));
      params( 15 ) := "+"( Float( a_target_dataset.eng_hhld_one_person_households_female ));
      params( 16 ) := "+"( Float( a_target_dataset.eng_hhld_one_family_and_no_others_couple_no_dependent_chi ));
      params( 17 ) := "+"( Float( a_target_dataset.eng_hhld_a_couple_and_other_adults_no_dependent_children ));
      params( 18 ) := "+"( Float( a_target_dataset.eng_hhld_households_with_one_dependent_child ));
      params( 19 ) := "+"( Float( a_target_dataset.eng_hhld_households_with_two_dependent_children ));
      params( 20 ) := "+"( Float( a_target_dataset.eng_hhld_households_with_three_dependent_children ));
      params( 21 ) := "+"( Float( a_target_dataset.eng_hhld_other_households ));
      params( 22 ) := "+"( Float( a_target_dataset.nir_hhld_one_adult_households ));
      params( 23 ) := "+"( Float( a_target_dataset.nir_hhld_two_adults_without_children ));
      params( 24 ) := "+"( Float( a_target_dataset.nir_hhld_other_households_without_children ));
      params( 25 ) := "+"( Float( a_target_dataset.nir_hhld_one_adult_households_with_children ));
      params( 26 ) := "+"( Float( a_target_dataset.nir_hhld_other_households_with_children ));
      params( 27 ) := "+"( Float( a_target_dataset.wal_hhld_1_person ));
      params( 28 ) := "+"( Float( a_target_dataset.wal_hhld_2_person_no_children ));
      params( 29 ) := "+"( Float( a_target_dataset.wal_hhld_2_person_1_adult_1_child ));
      params( 30 ) := "+"( Float( a_target_dataset.wal_hhld_3_person_no_children ));
      params( 31 ) := "+"( Float( a_target_dataset.wal_hhld_3_person_2_adults_1_child ));
      params( 32 ) := "+"( Float( a_target_dataset.wal_hhld_3_person_1_adult_2_children ));
      params( 33 ) := "+"( Float( a_target_dataset.wal_hhld_4_person_no_children ));
      params( 34 ) := "+"( Float( a_target_dataset.wal_hhld_4_person_2_plus_adults_1_plus_children ));
      params( 35 ) := "+"( Float( a_target_dataset.wal_hhld_4_person_1_adult_3_children ));
      params( 36 ) := "+"( Float( a_target_dataset.wal_hhld_5_plus_person_no_children ));
      params( 37 ) := "+"( Float( a_target_dataset.wal_hhld_5_plus_person_2_plus_adults_1_plus_children ));
      params( 38 ) := "+"( Float( a_target_dataset.wal_hhld_5_plus_person_1_adult_4_plus_children ));
      params( 39 ) := "+"( Float( a_target_dataset.male ));
      params( 40 ) := "+"( Float( a_target_dataset.female ));
      params( 41 ) := "+"( Float( a_target_dataset.employed ));
      params( 42 ) := "+"( Float( a_target_dataset.employee ));
      params( 43 ) := "+"( Float( a_target_dataset.ilo_unemployed ));
      params( 44 ) := "+"( Float( a_target_dataset.jsa_claimant ));
      params( 45 ) := "+"( Float( a_target_dataset.age_0_male ));
      params( 46 ) := "+"( Float( a_target_dataset.age_1_male ));
      params( 47 ) := "+"( Float( a_target_dataset.age_2_male ));
      params( 48 ) := "+"( Float( a_target_dataset.age_3_male ));
      params( 49 ) := "+"( Float( a_target_dataset.age_4_male ));
      params( 50 ) := "+"( Float( a_target_dataset.age_5_male ));
      params( 51 ) := "+"( Float( a_target_dataset.age_6_male ));
      params( 52 ) := "+"( Float( a_target_dataset.age_7_male ));
      params( 53 ) := "+"( Float( a_target_dataset.age_8_male ));
      params( 54 ) := "+"( Float( a_target_dataset.age_9_male ));
      params( 55 ) := "+"( Float( a_target_dataset.age_10_male ));
      params( 56 ) := "+"( Float( a_target_dataset.age_11_male ));
      params( 57 ) := "+"( Float( a_target_dataset.age_12_male ));
      params( 58 ) := "+"( Float( a_target_dataset.age_13_male ));
      params( 59 ) := "+"( Float( a_target_dataset.age_14_male ));
      params( 60 ) := "+"( Float( a_target_dataset.age_15_male ));
      params( 61 ) := "+"( Float( a_target_dataset.age_16_male ));
      params( 62 ) := "+"( Float( a_target_dataset.age_17_male ));
      params( 63 ) := "+"( Float( a_target_dataset.age_18_male ));
      params( 64 ) := "+"( Float( a_target_dataset.age_19_male ));
      params( 65 ) := "+"( Float( a_target_dataset.age_20_male ));
      params( 66 ) := "+"( Float( a_target_dataset.age_21_male ));
      params( 67 ) := "+"( Float( a_target_dataset.age_22_male ));
      params( 68 ) := "+"( Float( a_target_dataset.age_23_male ));
      params( 69 ) := "+"( Float( a_target_dataset.age_24_male ));
      params( 70 ) := "+"( Float( a_target_dataset.age_25_male ));
      params( 71 ) := "+"( Float( a_target_dataset.age_26_male ));
      params( 72 ) := "+"( Float( a_target_dataset.age_27_male ));
      params( 73 ) := "+"( Float( a_target_dataset.age_28_male ));
      params( 74 ) := "+"( Float( a_target_dataset.age_29_male ));
      params( 75 ) := "+"( Float( a_target_dataset.age_30_male ));
      params( 76 ) := "+"( Float( a_target_dataset.age_31_male ));
      params( 77 ) := "+"( Float( a_target_dataset.age_32_male ));
      params( 78 ) := "+"( Float( a_target_dataset.age_33_male ));
      params( 79 ) := "+"( Float( a_target_dataset.age_34_male ));
      params( 80 ) := "+"( Float( a_target_dataset.age_35_male ));
      params( 81 ) := "+"( Float( a_target_dataset.age_36_male ));
      params( 82 ) := "+"( Float( a_target_dataset.age_37_male ));
      params( 83 ) := "+"( Float( a_target_dataset.age_38_male ));
      params( 84 ) := "+"( Float( a_target_dataset.age_39_male ));
      params( 85 ) := "+"( Float( a_target_dataset.age_40_male ));
      params( 86 ) := "+"( Float( a_target_dataset.age_41_male ));
      params( 87 ) := "+"( Float( a_target_dataset.age_42_male ));
      params( 88 ) := "+"( Float( a_target_dataset.age_43_male ));
      params( 89 ) := "+"( Float( a_target_dataset.age_44_male ));
      params( 90 ) := "+"( Float( a_target_dataset.age_45_male ));
      params( 91 ) := "+"( Float( a_target_dataset.age_46_male ));
      params( 92 ) := "+"( Float( a_target_dataset.age_47_male ));
      params( 93 ) := "+"( Float( a_target_dataset.age_48_male ));
      params( 94 ) := "+"( Float( a_target_dataset.age_49_male ));
      params( 95 ) := "+"( Float( a_target_dataset.age_50_male ));
      params( 96 ) := "+"( Float( a_target_dataset.age_51_male ));
      params( 97 ) := "+"( Float( a_target_dataset.age_52_male ));
      params( 98 ) := "+"( Float( a_target_dataset.age_53_male ));
      params( 99 ) := "+"( Float( a_target_dataset.age_54_male ));
      params( 100 ) := "+"( Float( a_target_dataset.age_55_male ));
      params( 101 ) := "+"( Float( a_target_dataset.age_56_male ));
      params( 102 ) := "+"( Float( a_target_dataset.age_57_male ));
      params( 103 ) := "+"( Float( a_target_dataset.age_58_male ));
      params( 104 ) := "+"( Float( a_target_dataset.age_59_male ));
      params( 105 ) := "+"( Float( a_target_dataset.age_60_male ));
      params( 106 ) := "+"( Float( a_target_dataset.age_61_male ));
      params( 107 ) := "+"( Float( a_target_dataset.age_62_male ));
      params( 108 ) := "+"( Float( a_target_dataset.age_63_male ));
      params( 109 ) := "+"( Float( a_target_dataset.age_64_male ));
      params( 110 ) := "+"( Float( a_target_dataset.age_65_male ));
      params( 111 ) := "+"( Float( a_target_dataset.age_66_male ));
      params( 112 ) := "+"( Float( a_target_dataset.age_67_male ));
      params( 113 ) := "+"( Float( a_target_dataset.age_68_male ));
      params( 114 ) := "+"( Float( a_target_dataset.age_69_male ));
      params( 115 ) := "+"( Float( a_target_dataset.age_70_male ));
      params( 116 ) := "+"( Float( a_target_dataset.age_71_male ));
      params( 117 ) := "+"( Float( a_target_dataset.age_72_male ));
      params( 118 ) := "+"( Float( a_target_dataset.age_73_male ));
      params( 119 ) := "+"( Float( a_target_dataset.age_74_male ));
      params( 120 ) := "+"( Float( a_target_dataset.age_75_male ));
      params( 121 ) := "+"( Float( a_target_dataset.age_76_male ));
      params( 122 ) := "+"( Float( a_target_dataset.age_77_male ));
      params( 123 ) := "+"( Float( a_target_dataset.age_78_male ));
      params( 124 ) := "+"( Float( a_target_dataset.age_79_male ));
      params( 125 ) := "+"( Float( a_target_dataset.age_80_male ));
      params( 126 ) := "+"( Float( a_target_dataset.age_81_male ));
      params( 127 ) := "+"( Float( a_target_dataset.age_82_male ));
      params( 128 ) := "+"( Float( a_target_dataset.age_83_male ));
      params( 129 ) := "+"( Float( a_target_dataset.age_84_male ));
      params( 130 ) := "+"( Float( a_target_dataset.age_85_male ));
      params( 131 ) := "+"( Float( a_target_dataset.age_86_male ));
      params( 132 ) := "+"( Float( a_target_dataset.age_87_male ));
      params( 133 ) := "+"( Float( a_target_dataset.age_88_male ));
      params( 134 ) := "+"( Float( a_target_dataset.age_89_male ));
      params( 135 ) := "+"( Float( a_target_dataset.age_90_male ));
      params( 136 ) := "+"( Float( a_target_dataset.age_91_male ));
      params( 137 ) := "+"( Float( a_target_dataset.age_92_male ));
      params( 138 ) := "+"( Float( a_target_dataset.age_93_male ));
      params( 139 ) := "+"( Float( a_target_dataset.age_94_male ));
      params( 140 ) := "+"( Float( a_target_dataset.age_95_male ));
      params( 141 ) := "+"( Float( a_target_dataset.age_96_male ));
      params( 142 ) := "+"( Float( a_target_dataset.age_97_male ));
      params( 143 ) := "+"( Float( a_target_dataset.age_98_male ));
      params( 144 ) := "+"( Float( a_target_dataset.age_99_male ));
      params( 145 ) := "+"( Float( a_target_dataset.age_100_male ));
      params( 146 ) := "+"( Float( a_target_dataset.age_101_male ));
      params( 147 ) := "+"( Float( a_target_dataset.age_102_male ));
      params( 148 ) := "+"( Float( a_target_dataset.age_103_male ));
      params( 149 ) := "+"( Float( a_target_dataset.age_104_male ));
      params( 150 ) := "+"( Float( a_target_dataset.age_105_male ));
      params( 151 ) := "+"( Float( a_target_dataset.age_106_male ));
      params( 152 ) := "+"( Float( a_target_dataset.age_107_male ));
      params( 153 ) := "+"( Float( a_target_dataset.age_108_male ));
      params( 154 ) := "+"( Float( a_target_dataset.age_109_male ));
      params( 155 ) := "+"( Float( a_target_dataset.age_110_male ));
      params( 156 ) := "+"( Float( a_target_dataset.age_0_female ));
      params( 157 ) := "+"( Float( a_target_dataset.age_1_female ));
      params( 158 ) := "+"( Float( a_target_dataset.age_2_female ));
      params( 159 ) := "+"( Float( a_target_dataset.age_3_female ));
      params( 160 ) := "+"( Float( a_target_dataset.age_4_female ));
      params( 161 ) := "+"( Float( a_target_dataset.age_5_female ));
      params( 162 ) := "+"( Float( a_target_dataset.age_6_female ));
      params( 163 ) := "+"( Float( a_target_dataset.age_7_female ));
      params( 164 ) := "+"( Float( a_target_dataset.age_8_female ));
      params( 165 ) := "+"( Float( a_target_dataset.age_9_female ));
      params( 166 ) := "+"( Float( a_target_dataset.age_10_female ));
      params( 167 ) := "+"( Float( a_target_dataset.age_11_female ));
      params( 168 ) := "+"( Float( a_target_dataset.age_12_female ));
      params( 169 ) := "+"( Float( a_target_dataset.age_13_female ));
      params( 170 ) := "+"( Float( a_target_dataset.age_14_female ));
      params( 171 ) := "+"( Float( a_target_dataset.age_15_female ));
      params( 172 ) := "+"( Float( a_target_dataset.age_16_female ));
      params( 173 ) := "+"( Float( a_target_dataset.age_17_female ));
      params( 174 ) := "+"( Float( a_target_dataset.age_18_female ));
      params( 175 ) := "+"( Float( a_target_dataset.age_19_female ));
      params( 176 ) := "+"( Float( a_target_dataset.age_20_female ));
      params( 177 ) := "+"( Float( a_target_dataset.age_21_female ));
      params( 178 ) := "+"( Float( a_target_dataset.age_22_female ));
      params( 179 ) := "+"( Float( a_target_dataset.age_23_female ));
      params( 180 ) := "+"( Float( a_target_dataset.age_24_female ));
      params( 181 ) := "+"( Float( a_target_dataset.age_25_female ));
      params( 182 ) := "+"( Float( a_target_dataset.age_26_female ));
      params( 183 ) := "+"( Float( a_target_dataset.age_27_female ));
      params( 184 ) := "+"( Float( a_target_dataset.age_28_female ));
      params( 185 ) := "+"( Float( a_target_dataset.age_29_female ));
      params( 186 ) := "+"( Float( a_target_dataset.age_30_female ));
      params( 187 ) := "+"( Float( a_target_dataset.age_31_female ));
      params( 188 ) := "+"( Float( a_target_dataset.age_32_female ));
      params( 189 ) := "+"( Float( a_target_dataset.age_33_female ));
      params( 190 ) := "+"( Float( a_target_dataset.age_34_female ));
      params( 191 ) := "+"( Float( a_target_dataset.age_35_female ));
      params( 192 ) := "+"( Float( a_target_dataset.age_36_female ));
      params( 193 ) := "+"( Float( a_target_dataset.age_37_female ));
      params( 194 ) := "+"( Float( a_target_dataset.age_38_female ));
      params( 195 ) := "+"( Float( a_target_dataset.age_39_female ));
      params( 196 ) := "+"( Float( a_target_dataset.age_40_female ));
      params( 197 ) := "+"( Float( a_target_dataset.age_41_female ));
      params( 198 ) := "+"( Float( a_target_dataset.age_42_female ));
      params( 199 ) := "+"( Float( a_target_dataset.age_43_female ));
      params( 200 ) := "+"( Float( a_target_dataset.age_44_female ));
      params( 201 ) := "+"( Float( a_target_dataset.age_45_female ));
      params( 202 ) := "+"( Float( a_target_dataset.age_46_female ));
      params( 203 ) := "+"( Float( a_target_dataset.age_47_female ));
      params( 204 ) := "+"( Float( a_target_dataset.age_48_female ));
      params( 205 ) := "+"( Float( a_target_dataset.age_49_female ));
      params( 206 ) := "+"( Float( a_target_dataset.age_50_female ));
      params( 207 ) := "+"( Float( a_target_dataset.age_51_female ));
      params( 208 ) := "+"( Float( a_target_dataset.age_52_female ));
      params( 209 ) := "+"( Float( a_target_dataset.age_53_female ));
      params( 210 ) := "+"( Float( a_target_dataset.age_54_female ));
      params( 211 ) := "+"( Float( a_target_dataset.age_55_female ));
      params( 212 ) := "+"( Float( a_target_dataset.age_56_female ));
      params( 213 ) := "+"( Float( a_target_dataset.age_57_female ));
      params( 214 ) := "+"( Float( a_target_dataset.age_58_female ));
      params( 215 ) := "+"( Float( a_target_dataset.age_59_female ));
      params( 216 ) := "+"( Float( a_target_dataset.age_60_female ));
      params( 217 ) := "+"( Float( a_target_dataset.age_61_female ));
      params( 218 ) := "+"( Float( a_target_dataset.age_62_female ));
      params( 219 ) := "+"( Float( a_target_dataset.age_63_female ));
      params( 220 ) := "+"( Float( a_target_dataset.age_64_female ));
      params( 221 ) := "+"( Float( a_target_dataset.age_65_female ));
      params( 222 ) := "+"( Float( a_target_dataset.age_66_female ));
      params( 223 ) := "+"( Float( a_target_dataset.age_67_female ));
      params( 224 ) := "+"( Float( a_target_dataset.age_68_female ));
      params( 225 ) := "+"( Float( a_target_dataset.age_69_female ));
      params( 226 ) := "+"( Float( a_target_dataset.age_70_female ));
      params( 227 ) := "+"( Float( a_target_dataset.age_71_female ));
      params( 228 ) := "+"( Float( a_target_dataset.age_72_female ));
      params( 229 ) := "+"( Float( a_target_dataset.age_73_female ));
      params( 230 ) := "+"( Float( a_target_dataset.age_74_female ));
      params( 231 ) := "+"( Float( a_target_dataset.age_75_female ));
      params( 232 ) := "+"( Float( a_target_dataset.age_76_female ));
      params( 233 ) := "+"( Float( a_target_dataset.age_77_female ));
      params( 234 ) := "+"( Float( a_target_dataset.age_78_female ));
      params( 235 ) := "+"( Float( a_target_dataset.age_79_female ));
      params( 236 ) := "+"( Float( a_target_dataset.age_80_female ));
      params( 237 ) := "+"( Float( a_target_dataset.age_81_female ));
      params( 238 ) := "+"( Float( a_target_dataset.age_82_female ));
      params( 239 ) := "+"( Float( a_target_dataset.age_83_female ));
      params( 240 ) := "+"( Float( a_target_dataset.age_84_female ));
      params( 241 ) := "+"( Float( a_target_dataset.age_85_female ));
      params( 242 ) := "+"( Float( a_target_dataset.age_86_female ));
      params( 243 ) := "+"( Float( a_target_dataset.age_87_female ));
      params( 244 ) := "+"( Float( a_target_dataset.age_88_female ));
      params( 245 ) := "+"( Float( a_target_dataset.age_89_female ));
      params( 246 ) := "+"( Float( a_target_dataset.age_90_female ));
      params( 247 ) := "+"( Float( a_target_dataset.age_91_female ));
      params( 248 ) := "+"( Float( a_target_dataset.age_92_female ));
      params( 249 ) := "+"( Float( a_target_dataset.age_93_female ));
      params( 250 ) := "+"( Float( a_target_dataset.age_94_female ));
      params( 251 ) := "+"( Float( a_target_dataset.age_95_female ));
      params( 252 ) := "+"( Float( a_target_dataset.age_96_female ));
      params( 253 ) := "+"( Float( a_target_dataset.age_97_female ));
      params( 254 ) := "+"( Float( a_target_dataset.age_98_female ));
      params( 255 ) := "+"( Float( a_target_dataset.age_99_female ));
      params( 256 ) := "+"( Float( a_target_dataset.age_100_female ));
      params( 257 ) := "+"( Float( a_target_dataset.age_101_female ));
      params( 258 ) := "+"( Float( a_target_dataset.age_102_female ));
      params( 259 ) := "+"( Float( a_target_dataset.age_103_female ));
      params( 260 ) := "+"( Float( a_target_dataset.age_104_female ));
      params( 261 ) := "+"( Float( a_target_dataset.age_105_female ));
      params( 262 ) := "+"( Float( a_target_dataset.age_106_female ));
      params( 263 ) := "+"( Float( a_target_dataset.age_107_female ));
      params( 264 ) := "+"( Float( a_target_dataset.age_108_female ));
      params( 265 ) := "+"( Float( a_target_dataset.age_109_female ));
      params( 266 ) := "+"( Float( a_target_dataset.age_110_female ));
      params( 267 ) := "+"( Float( a_target_dataset.participation_16_19_male ));
      params( 268 ) := "+"( Float( a_target_dataset.participation_20_24_male ));
      params( 269 ) := "+"( Float( a_target_dataset.participation_25_29_male ));
      params( 270 ) := "+"( Float( a_target_dataset.participation_30_34_male ));
      params( 271 ) := "+"( Float( a_target_dataset.participation_35_39_male ));
      params( 272 ) := "+"( Float( a_target_dataset.participation_40_44_male ));
      params( 273 ) := "+"( Float( a_target_dataset.participation_45_49_male ));
      params( 274 ) := "+"( Float( a_target_dataset.participation_50_54_male ));
      params( 275 ) := "+"( Float( a_target_dataset.participation_55_59_male ));
      params( 276 ) := "+"( Float( a_target_dataset.participation_60_64_male ));
      params( 277 ) := "+"( Float( a_target_dataset.participation_65_69_male ));
      params( 278 ) := "+"( Float( a_target_dataset.participation_70_74_male ));
      params( 279 ) := "+"( Float( a_target_dataset.participation_75_plus_male ));
      params( 280 ) := "+"( Float( a_target_dataset.participation_16_19_female ));
      params( 281 ) := "+"( Float( a_target_dataset.participation_20_24_female ));
      params( 282 ) := "+"( Float( a_target_dataset.participation_25_29_female ));
      params( 283 ) := "+"( Float( a_target_dataset.participation_30_34_female ));
      params( 284 ) := "+"( Float( a_target_dataset.participation_35_39_female ));
      params( 285 ) := "+"( Float( a_target_dataset.participation_40_44_female ));
      params( 286 ) := "+"( Float( a_target_dataset.participation_45_49_female ));
      params( 287 ) := "+"( Float( a_target_dataset.participation_50_54_female ));
      params( 288 ) := "+"( Float( a_target_dataset.participation_55_59_female ));
      params( 289 ) := "+"( Float( a_target_dataset.participation_60_64_female ));
      params( 290 ) := "+"( Float( a_target_dataset.participation_65_69_female ));
      params( 291 ) := "+"( Float( a_target_dataset.participation_70_74_female ));
      params( 292 ) := "+"( Float( a_target_dataset.participation_75_plus_female ));
      params( 293 ) := "+"( Float( a_target_dataset.one_adult_hh_wales ));
      params( 294 ) := "+"( Float( a_target_dataset.two_adult_hhs_wales ));
      params( 295 ) := "+"( Float( a_target_dataset.other_hh_wales ));
      params( 296 ) := "+"( Float( a_target_dataset.one_adult_hh_nireland ));
      params( 297 ) := "+"( Float( a_target_dataset.two_adult_hhs_nireland ));
      params( 298 ) := "+"( Float( a_target_dataset.other_hh_nireland ));
      params( 299 ) := "+"( Float( a_target_dataset.one_adult_hh_england ));
      params( 300 ) := "+"( Float( a_target_dataset.two_adult_hhs_england ));
      params( 301 ) := "+"( Float( a_target_dataset.other_hh_england ));
      params( 302 ) := "+"( Float( a_target_dataset.one_adult_hh_scotland ));
      params( 303 ) := "+"( Float( a_target_dataset.two_adult_hhs_scotland ));
      params( 304 ) := "+"( Float( a_target_dataset.other_hh_scotland ));
      params( 305 ) := "+"( Integer'Pos( a_target_dataset.run_id ));
      params( 306 ) := "+"( Integer'Pos( a_target_dataset.user_id ));
      params( 307 ) := "+"( Year_Number'Pos( a_target_dataset.year ));
      params( 308 ) := As_Bigint( a_target_dataset.sernum );
      
      gse.Execute( local_connection, UPDATE_PS, params );
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   SAVE_PS : constant gse.Prepared_Statement := Get_Prepared_Insert_Statement;      

   procedure Save( a_target_dataset : Ukds.Target_Data.Target_Dataset; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_target_dataset.run_id, a_target_dataset.user_id, a_target_dataset.year, a_target_dataset.sernum ) then
         Update( a_target_dataset, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_target_dataset.run_id ));
      params( 2 ) := "+"( Integer'Pos( a_target_dataset.user_id ));
      params( 3 ) := "+"( Year_Number'Pos( a_target_dataset.year ));
      params( 4 ) := As_Bigint( a_target_dataset.sernum );
      params( 5 ) := "+"( Float( a_target_dataset.country_uk ));
      params( 6 ) := "+"( Float( a_target_dataset.country_scotland ));
      params( 7 ) := "+"( Float( a_target_dataset.country_england ));
      params( 8 ) := "+"( Float( a_target_dataset.country_wales ));
      params( 9 ) := "+"( Float( a_target_dataset.country_n_ireland ));
      params( 10 ) := "+"( Float( a_target_dataset.household_all_households ));
      params( 11 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_male ));
      params( 12 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_female ));
      params( 13 ) := "+"( Float( a_target_dataset.sco_hhld_two_adults ));
      params( 14 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_one_child ));
      params( 15 ) := "+"( Float( a_target_dataset.sco_hhld_one_adult_two_plus_children ));
      params( 16 ) := "+"( Float( a_target_dataset.sco_hhld_two_plus_adult_one_plus_children ));
      params( 17 ) := "+"( Float( a_target_dataset.sco_hhld_three_plus_person_all_adult ));
      params( 18 ) := "+"( Float( a_target_dataset.eng_hhld_one_person_households_male ));
      params( 19 ) := "+"( Float( a_target_dataset.eng_hhld_one_person_households_female ));
      params( 20 ) := "+"( Float( a_target_dataset.eng_hhld_one_family_and_no_others_couple_no_dependent_chi ));
      params( 21 ) := "+"( Float( a_target_dataset.eng_hhld_a_couple_and_other_adults_no_dependent_children ));
      params( 22 ) := "+"( Float( a_target_dataset.eng_hhld_households_with_one_dependent_child ));
      params( 23 ) := "+"( Float( a_target_dataset.eng_hhld_households_with_two_dependent_children ));
      params( 24 ) := "+"( Float( a_target_dataset.eng_hhld_households_with_three_dependent_children ));
      params( 25 ) := "+"( Float( a_target_dataset.eng_hhld_other_households ));
      params( 26 ) := "+"( Float( a_target_dataset.nir_hhld_one_adult_households ));
      params( 27 ) := "+"( Float( a_target_dataset.nir_hhld_two_adults_without_children ));
      params( 28 ) := "+"( Float( a_target_dataset.nir_hhld_other_households_without_children ));
      params( 29 ) := "+"( Float( a_target_dataset.nir_hhld_one_adult_households_with_children ));
      params( 30 ) := "+"( Float( a_target_dataset.nir_hhld_other_households_with_children ));
      params( 31 ) := "+"( Float( a_target_dataset.wal_hhld_1_person ));
      params( 32 ) := "+"( Float( a_target_dataset.wal_hhld_2_person_no_children ));
      params( 33 ) := "+"( Float( a_target_dataset.wal_hhld_2_person_1_adult_1_child ));
      params( 34 ) := "+"( Float( a_target_dataset.wal_hhld_3_person_no_children ));
      params( 35 ) := "+"( Float( a_target_dataset.wal_hhld_3_person_2_adults_1_child ));
      params( 36 ) := "+"( Float( a_target_dataset.wal_hhld_3_person_1_adult_2_children ));
      params( 37 ) := "+"( Float( a_target_dataset.wal_hhld_4_person_no_children ));
      params( 38 ) := "+"( Float( a_target_dataset.wal_hhld_4_person_2_plus_adults_1_plus_children ));
      params( 39 ) := "+"( Float( a_target_dataset.wal_hhld_4_person_1_adult_3_children ));
      params( 40 ) := "+"( Float( a_target_dataset.wal_hhld_5_plus_person_no_children ));
      params( 41 ) := "+"( Float( a_target_dataset.wal_hhld_5_plus_person_2_plus_adults_1_plus_children ));
      params( 42 ) := "+"( Float( a_target_dataset.wal_hhld_5_plus_person_1_adult_4_plus_children ));
      params( 43 ) := "+"( Float( a_target_dataset.male ));
      params( 44 ) := "+"( Float( a_target_dataset.female ));
      params( 45 ) := "+"( Float( a_target_dataset.employed ));
      params( 46 ) := "+"( Float( a_target_dataset.employee ));
      params( 47 ) := "+"( Float( a_target_dataset.ilo_unemployed ));
      params( 48 ) := "+"( Float( a_target_dataset.jsa_claimant ));
      params( 49 ) := "+"( Float( a_target_dataset.age_0_male ));
      params( 50 ) := "+"( Float( a_target_dataset.age_1_male ));
      params( 51 ) := "+"( Float( a_target_dataset.age_2_male ));
      params( 52 ) := "+"( Float( a_target_dataset.age_3_male ));
      params( 53 ) := "+"( Float( a_target_dataset.age_4_male ));
      params( 54 ) := "+"( Float( a_target_dataset.age_5_male ));
      params( 55 ) := "+"( Float( a_target_dataset.age_6_male ));
      params( 56 ) := "+"( Float( a_target_dataset.age_7_male ));
      params( 57 ) := "+"( Float( a_target_dataset.age_8_male ));
      params( 58 ) := "+"( Float( a_target_dataset.age_9_male ));
      params( 59 ) := "+"( Float( a_target_dataset.age_10_male ));
      params( 60 ) := "+"( Float( a_target_dataset.age_11_male ));
      params( 61 ) := "+"( Float( a_target_dataset.age_12_male ));
      params( 62 ) := "+"( Float( a_target_dataset.age_13_male ));
      params( 63 ) := "+"( Float( a_target_dataset.age_14_male ));
      params( 64 ) := "+"( Float( a_target_dataset.age_15_male ));
      params( 65 ) := "+"( Float( a_target_dataset.age_16_male ));
      params( 66 ) := "+"( Float( a_target_dataset.age_17_male ));
      params( 67 ) := "+"( Float( a_target_dataset.age_18_male ));
      params( 68 ) := "+"( Float( a_target_dataset.age_19_male ));
      params( 69 ) := "+"( Float( a_target_dataset.age_20_male ));
      params( 70 ) := "+"( Float( a_target_dataset.age_21_male ));
      params( 71 ) := "+"( Float( a_target_dataset.age_22_male ));
      params( 72 ) := "+"( Float( a_target_dataset.age_23_male ));
      params( 73 ) := "+"( Float( a_target_dataset.age_24_male ));
      params( 74 ) := "+"( Float( a_target_dataset.age_25_male ));
      params( 75 ) := "+"( Float( a_target_dataset.age_26_male ));
      params( 76 ) := "+"( Float( a_target_dataset.age_27_male ));
      params( 77 ) := "+"( Float( a_target_dataset.age_28_male ));
      params( 78 ) := "+"( Float( a_target_dataset.age_29_male ));
      params( 79 ) := "+"( Float( a_target_dataset.age_30_male ));
      params( 80 ) := "+"( Float( a_target_dataset.age_31_male ));
      params( 81 ) := "+"( Float( a_target_dataset.age_32_male ));
      params( 82 ) := "+"( Float( a_target_dataset.age_33_male ));
      params( 83 ) := "+"( Float( a_target_dataset.age_34_male ));
      params( 84 ) := "+"( Float( a_target_dataset.age_35_male ));
      params( 85 ) := "+"( Float( a_target_dataset.age_36_male ));
      params( 86 ) := "+"( Float( a_target_dataset.age_37_male ));
      params( 87 ) := "+"( Float( a_target_dataset.age_38_male ));
      params( 88 ) := "+"( Float( a_target_dataset.age_39_male ));
      params( 89 ) := "+"( Float( a_target_dataset.age_40_male ));
      params( 90 ) := "+"( Float( a_target_dataset.age_41_male ));
      params( 91 ) := "+"( Float( a_target_dataset.age_42_male ));
      params( 92 ) := "+"( Float( a_target_dataset.age_43_male ));
      params( 93 ) := "+"( Float( a_target_dataset.age_44_male ));
      params( 94 ) := "+"( Float( a_target_dataset.age_45_male ));
      params( 95 ) := "+"( Float( a_target_dataset.age_46_male ));
      params( 96 ) := "+"( Float( a_target_dataset.age_47_male ));
      params( 97 ) := "+"( Float( a_target_dataset.age_48_male ));
      params( 98 ) := "+"( Float( a_target_dataset.age_49_male ));
      params( 99 ) := "+"( Float( a_target_dataset.age_50_male ));
      params( 100 ) := "+"( Float( a_target_dataset.age_51_male ));
      params( 101 ) := "+"( Float( a_target_dataset.age_52_male ));
      params( 102 ) := "+"( Float( a_target_dataset.age_53_male ));
      params( 103 ) := "+"( Float( a_target_dataset.age_54_male ));
      params( 104 ) := "+"( Float( a_target_dataset.age_55_male ));
      params( 105 ) := "+"( Float( a_target_dataset.age_56_male ));
      params( 106 ) := "+"( Float( a_target_dataset.age_57_male ));
      params( 107 ) := "+"( Float( a_target_dataset.age_58_male ));
      params( 108 ) := "+"( Float( a_target_dataset.age_59_male ));
      params( 109 ) := "+"( Float( a_target_dataset.age_60_male ));
      params( 110 ) := "+"( Float( a_target_dataset.age_61_male ));
      params( 111 ) := "+"( Float( a_target_dataset.age_62_male ));
      params( 112 ) := "+"( Float( a_target_dataset.age_63_male ));
      params( 113 ) := "+"( Float( a_target_dataset.age_64_male ));
      params( 114 ) := "+"( Float( a_target_dataset.age_65_male ));
      params( 115 ) := "+"( Float( a_target_dataset.age_66_male ));
      params( 116 ) := "+"( Float( a_target_dataset.age_67_male ));
      params( 117 ) := "+"( Float( a_target_dataset.age_68_male ));
      params( 118 ) := "+"( Float( a_target_dataset.age_69_male ));
      params( 119 ) := "+"( Float( a_target_dataset.age_70_male ));
      params( 120 ) := "+"( Float( a_target_dataset.age_71_male ));
      params( 121 ) := "+"( Float( a_target_dataset.age_72_male ));
      params( 122 ) := "+"( Float( a_target_dataset.age_73_male ));
      params( 123 ) := "+"( Float( a_target_dataset.age_74_male ));
      params( 124 ) := "+"( Float( a_target_dataset.age_75_male ));
      params( 125 ) := "+"( Float( a_target_dataset.age_76_male ));
      params( 126 ) := "+"( Float( a_target_dataset.age_77_male ));
      params( 127 ) := "+"( Float( a_target_dataset.age_78_male ));
      params( 128 ) := "+"( Float( a_target_dataset.age_79_male ));
      params( 129 ) := "+"( Float( a_target_dataset.age_80_male ));
      params( 130 ) := "+"( Float( a_target_dataset.age_81_male ));
      params( 131 ) := "+"( Float( a_target_dataset.age_82_male ));
      params( 132 ) := "+"( Float( a_target_dataset.age_83_male ));
      params( 133 ) := "+"( Float( a_target_dataset.age_84_male ));
      params( 134 ) := "+"( Float( a_target_dataset.age_85_male ));
      params( 135 ) := "+"( Float( a_target_dataset.age_86_male ));
      params( 136 ) := "+"( Float( a_target_dataset.age_87_male ));
      params( 137 ) := "+"( Float( a_target_dataset.age_88_male ));
      params( 138 ) := "+"( Float( a_target_dataset.age_89_male ));
      params( 139 ) := "+"( Float( a_target_dataset.age_90_male ));
      params( 140 ) := "+"( Float( a_target_dataset.age_91_male ));
      params( 141 ) := "+"( Float( a_target_dataset.age_92_male ));
      params( 142 ) := "+"( Float( a_target_dataset.age_93_male ));
      params( 143 ) := "+"( Float( a_target_dataset.age_94_male ));
      params( 144 ) := "+"( Float( a_target_dataset.age_95_male ));
      params( 145 ) := "+"( Float( a_target_dataset.age_96_male ));
      params( 146 ) := "+"( Float( a_target_dataset.age_97_male ));
      params( 147 ) := "+"( Float( a_target_dataset.age_98_male ));
      params( 148 ) := "+"( Float( a_target_dataset.age_99_male ));
      params( 149 ) := "+"( Float( a_target_dataset.age_100_male ));
      params( 150 ) := "+"( Float( a_target_dataset.age_101_male ));
      params( 151 ) := "+"( Float( a_target_dataset.age_102_male ));
      params( 152 ) := "+"( Float( a_target_dataset.age_103_male ));
      params( 153 ) := "+"( Float( a_target_dataset.age_104_male ));
      params( 154 ) := "+"( Float( a_target_dataset.age_105_male ));
      params( 155 ) := "+"( Float( a_target_dataset.age_106_male ));
      params( 156 ) := "+"( Float( a_target_dataset.age_107_male ));
      params( 157 ) := "+"( Float( a_target_dataset.age_108_male ));
      params( 158 ) := "+"( Float( a_target_dataset.age_109_male ));
      params( 159 ) := "+"( Float( a_target_dataset.age_110_male ));
      params( 160 ) := "+"( Float( a_target_dataset.age_0_female ));
      params( 161 ) := "+"( Float( a_target_dataset.age_1_female ));
      params( 162 ) := "+"( Float( a_target_dataset.age_2_female ));
      params( 163 ) := "+"( Float( a_target_dataset.age_3_female ));
      params( 164 ) := "+"( Float( a_target_dataset.age_4_female ));
      params( 165 ) := "+"( Float( a_target_dataset.age_5_female ));
      params( 166 ) := "+"( Float( a_target_dataset.age_6_female ));
      params( 167 ) := "+"( Float( a_target_dataset.age_7_female ));
      params( 168 ) := "+"( Float( a_target_dataset.age_8_female ));
      params( 169 ) := "+"( Float( a_target_dataset.age_9_female ));
      params( 170 ) := "+"( Float( a_target_dataset.age_10_female ));
      params( 171 ) := "+"( Float( a_target_dataset.age_11_female ));
      params( 172 ) := "+"( Float( a_target_dataset.age_12_female ));
      params( 173 ) := "+"( Float( a_target_dataset.age_13_female ));
      params( 174 ) := "+"( Float( a_target_dataset.age_14_female ));
      params( 175 ) := "+"( Float( a_target_dataset.age_15_female ));
      params( 176 ) := "+"( Float( a_target_dataset.age_16_female ));
      params( 177 ) := "+"( Float( a_target_dataset.age_17_female ));
      params( 178 ) := "+"( Float( a_target_dataset.age_18_female ));
      params( 179 ) := "+"( Float( a_target_dataset.age_19_female ));
      params( 180 ) := "+"( Float( a_target_dataset.age_20_female ));
      params( 181 ) := "+"( Float( a_target_dataset.age_21_female ));
      params( 182 ) := "+"( Float( a_target_dataset.age_22_female ));
      params( 183 ) := "+"( Float( a_target_dataset.age_23_female ));
      params( 184 ) := "+"( Float( a_target_dataset.age_24_female ));
      params( 185 ) := "+"( Float( a_target_dataset.age_25_female ));
      params( 186 ) := "+"( Float( a_target_dataset.age_26_female ));
      params( 187 ) := "+"( Float( a_target_dataset.age_27_female ));
      params( 188 ) := "+"( Float( a_target_dataset.age_28_female ));
      params( 189 ) := "+"( Float( a_target_dataset.age_29_female ));
      params( 190 ) := "+"( Float( a_target_dataset.age_30_female ));
      params( 191 ) := "+"( Float( a_target_dataset.age_31_female ));
      params( 192 ) := "+"( Float( a_target_dataset.age_32_female ));
      params( 193 ) := "+"( Float( a_target_dataset.age_33_female ));
      params( 194 ) := "+"( Float( a_target_dataset.age_34_female ));
      params( 195 ) := "+"( Float( a_target_dataset.age_35_female ));
      params( 196 ) := "+"( Float( a_target_dataset.age_36_female ));
      params( 197 ) := "+"( Float( a_target_dataset.age_37_female ));
      params( 198 ) := "+"( Float( a_target_dataset.age_38_female ));
      params( 199 ) := "+"( Float( a_target_dataset.age_39_female ));
      params( 200 ) := "+"( Float( a_target_dataset.age_40_female ));
      params( 201 ) := "+"( Float( a_target_dataset.age_41_female ));
      params( 202 ) := "+"( Float( a_target_dataset.age_42_female ));
      params( 203 ) := "+"( Float( a_target_dataset.age_43_female ));
      params( 204 ) := "+"( Float( a_target_dataset.age_44_female ));
      params( 205 ) := "+"( Float( a_target_dataset.age_45_female ));
      params( 206 ) := "+"( Float( a_target_dataset.age_46_female ));
      params( 207 ) := "+"( Float( a_target_dataset.age_47_female ));
      params( 208 ) := "+"( Float( a_target_dataset.age_48_female ));
      params( 209 ) := "+"( Float( a_target_dataset.age_49_female ));
      params( 210 ) := "+"( Float( a_target_dataset.age_50_female ));
      params( 211 ) := "+"( Float( a_target_dataset.age_51_female ));
      params( 212 ) := "+"( Float( a_target_dataset.age_52_female ));
      params( 213 ) := "+"( Float( a_target_dataset.age_53_female ));
      params( 214 ) := "+"( Float( a_target_dataset.age_54_female ));
      params( 215 ) := "+"( Float( a_target_dataset.age_55_female ));
      params( 216 ) := "+"( Float( a_target_dataset.age_56_female ));
      params( 217 ) := "+"( Float( a_target_dataset.age_57_female ));
      params( 218 ) := "+"( Float( a_target_dataset.age_58_female ));
      params( 219 ) := "+"( Float( a_target_dataset.age_59_female ));
      params( 220 ) := "+"( Float( a_target_dataset.age_60_female ));
      params( 221 ) := "+"( Float( a_target_dataset.age_61_female ));
      params( 222 ) := "+"( Float( a_target_dataset.age_62_female ));
      params( 223 ) := "+"( Float( a_target_dataset.age_63_female ));
      params( 224 ) := "+"( Float( a_target_dataset.age_64_female ));
      params( 225 ) := "+"( Float( a_target_dataset.age_65_female ));
      params( 226 ) := "+"( Float( a_target_dataset.age_66_female ));
      params( 227 ) := "+"( Float( a_target_dataset.age_67_female ));
      params( 228 ) := "+"( Float( a_target_dataset.age_68_female ));
      params( 229 ) := "+"( Float( a_target_dataset.age_69_female ));
      params( 230 ) := "+"( Float( a_target_dataset.age_70_female ));
      params( 231 ) := "+"( Float( a_target_dataset.age_71_female ));
      params( 232 ) := "+"( Float( a_target_dataset.age_72_female ));
      params( 233 ) := "+"( Float( a_target_dataset.age_73_female ));
      params( 234 ) := "+"( Float( a_target_dataset.age_74_female ));
      params( 235 ) := "+"( Float( a_target_dataset.age_75_female ));
      params( 236 ) := "+"( Float( a_target_dataset.age_76_female ));
      params( 237 ) := "+"( Float( a_target_dataset.age_77_female ));
      params( 238 ) := "+"( Float( a_target_dataset.age_78_female ));
      params( 239 ) := "+"( Float( a_target_dataset.age_79_female ));
      params( 240 ) := "+"( Float( a_target_dataset.age_80_female ));
      params( 241 ) := "+"( Float( a_target_dataset.age_81_female ));
      params( 242 ) := "+"( Float( a_target_dataset.age_82_female ));
      params( 243 ) := "+"( Float( a_target_dataset.age_83_female ));
      params( 244 ) := "+"( Float( a_target_dataset.age_84_female ));
      params( 245 ) := "+"( Float( a_target_dataset.age_85_female ));
      params( 246 ) := "+"( Float( a_target_dataset.age_86_female ));
      params( 247 ) := "+"( Float( a_target_dataset.age_87_female ));
      params( 248 ) := "+"( Float( a_target_dataset.age_88_female ));
      params( 249 ) := "+"( Float( a_target_dataset.age_89_female ));
      params( 250 ) := "+"( Float( a_target_dataset.age_90_female ));
      params( 251 ) := "+"( Float( a_target_dataset.age_91_female ));
      params( 252 ) := "+"( Float( a_target_dataset.age_92_female ));
      params( 253 ) := "+"( Float( a_target_dataset.age_93_female ));
      params( 254 ) := "+"( Float( a_target_dataset.age_94_female ));
      params( 255 ) := "+"( Float( a_target_dataset.age_95_female ));
      params( 256 ) := "+"( Float( a_target_dataset.age_96_female ));
      params( 257 ) := "+"( Float( a_target_dataset.age_97_female ));
      params( 258 ) := "+"( Float( a_target_dataset.age_98_female ));
      params( 259 ) := "+"( Float( a_target_dataset.age_99_female ));
      params( 260 ) := "+"( Float( a_target_dataset.age_100_female ));
      params( 261 ) := "+"( Float( a_target_dataset.age_101_female ));
      params( 262 ) := "+"( Float( a_target_dataset.age_102_female ));
      params( 263 ) := "+"( Float( a_target_dataset.age_103_female ));
      params( 264 ) := "+"( Float( a_target_dataset.age_104_female ));
      params( 265 ) := "+"( Float( a_target_dataset.age_105_female ));
      params( 266 ) := "+"( Float( a_target_dataset.age_106_female ));
      params( 267 ) := "+"( Float( a_target_dataset.age_107_female ));
      params( 268 ) := "+"( Float( a_target_dataset.age_108_female ));
      params( 269 ) := "+"( Float( a_target_dataset.age_109_female ));
      params( 270 ) := "+"( Float( a_target_dataset.age_110_female ));
      params( 271 ) := "+"( Float( a_target_dataset.participation_16_19_male ));
      params( 272 ) := "+"( Float( a_target_dataset.participation_20_24_male ));
      params( 273 ) := "+"( Float( a_target_dataset.participation_25_29_male ));
      params( 274 ) := "+"( Float( a_target_dataset.participation_30_34_male ));
      params( 275 ) := "+"( Float( a_target_dataset.participation_35_39_male ));
      params( 276 ) := "+"( Float( a_target_dataset.participation_40_44_male ));
      params( 277 ) := "+"( Float( a_target_dataset.participation_45_49_male ));
      params( 278 ) := "+"( Float( a_target_dataset.participation_50_54_male ));
      params( 279 ) := "+"( Float( a_target_dataset.participation_55_59_male ));
      params( 280 ) := "+"( Float( a_target_dataset.participation_60_64_male ));
      params( 281 ) := "+"( Float( a_target_dataset.participation_65_69_male ));
      params( 282 ) := "+"( Float( a_target_dataset.participation_70_74_male ));
      params( 283 ) := "+"( Float( a_target_dataset.participation_75_plus_male ));
      params( 284 ) := "+"( Float( a_target_dataset.participation_16_19_female ));
      params( 285 ) := "+"( Float( a_target_dataset.participation_20_24_female ));
      params( 286 ) := "+"( Float( a_target_dataset.participation_25_29_female ));
      params( 287 ) := "+"( Float( a_target_dataset.participation_30_34_female ));
      params( 288 ) := "+"( Float( a_target_dataset.participation_35_39_female ));
      params( 289 ) := "+"( Float( a_target_dataset.participation_40_44_female ));
      params( 290 ) := "+"( Float( a_target_dataset.participation_45_49_female ));
      params( 291 ) := "+"( Float( a_target_dataset.participation_50_54_female ));
      params( 292 ) := "+"( Float( a_target_dataset.participation_55_59_female ));
      params( 293 ) := "+"( Float( a_target_dataset.participation_60_64_female ));
      params( 294 ) := "+"( Float( a_target_dataset.participation_65_69_female ));
      params( 295 ) := "+"( Float( a_target_dataset.participation_70_74_female ));
      params( 296 ) := "+"( Float( a_target_dataset.participation_75_plus_female ));
      params( 297 ) := "+"( Float( a_target_dataset.one_adult_hh_wales ));
      params( 298 ) := "+"( Float( a_target_dataset.two_adult_hhs_wales ));
      params( 299 ) := "+"( Float( a_target_dataset.other_hh_wales ));
      params( 300 ) := "+"( Float( a_target_dataset.one_adult_hh_nireland ));
      params( 301 ) := "+"( Float( a_target_dataset.two_adult_hhs_nireland ));
      params( 302 ) := "+"( Float( a_target_dataset.other_hh_nireland ));
      params( 303 ) := "+"( Float( a_target_dataset.one_adult_hh_england ));
      params( 304 ) := "+"( Float( a_target_dataset.two_adult_hhs_england ));
      params( 305 ) := "+"( Float( a_target_dataset.other_hh_england ));
      params( 306 ) := "+"( Float( a_target_dataset.one_adult_hh_scotland ));
      params( 307 ) := "+"( Float( a_target_dataset.two_adult_hhs_scotland ));
      params( 308 ) := "+"( Float( a_target_dataset.other_hh_scotland ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Target_Dataset
   --

   procedure Delete( a_target_dataset : in out Ukds.Target_Data.Target_Dataset; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_run_id( c, a_target_dataset.run_id );
      Add_user_id( c, a_target_dataset.user_id );
      Add_year( c, a_target_dataset.year );
      Add_sernum( c, a_target_dataset.sernum );
      Delete( c, connection );
      a_target_dataset := Ukds.Target_Data.Null_Target_Dataset;
      Log( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null ) is
   begin      
      delete( d.to_string( c ), connection );
      Log( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_clause : String; connection : gse.Database_Connection := null ) is
      local_connection : gse.Database_Connection;     
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( DELETE_PART, SCHEMA_NAME ) & where_clause;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "delete; executing query" & query );
      gse.Execute( local_connection, query );
      Check_Result( local_connection );
      Log( "delete; execute query OK" );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_run_id( c : in out d.Criteria; run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "run_id", op, join, run_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_run_id;


   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "user_id", op, join, user_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id;


   procedure Add_year( c : in out d.Criteria; year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, Integer( year ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   procedure Add_country_uk( c : in out d.Criteria; country_uk : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country_uk", op, join, Long_Float( country_uk ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_uk;


   procedure Add_country_scotland( c : in out d.Criteria; country_scotland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country_scotland", op, join, Long_Float( country_scotland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_scotland;


   procedure Add_country_england( c : in out d.Criteria; country_england : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country_england", op, join, Long_Float( country_england ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_england;


   procedure Add_country_wales( c : in out d.Criteria; country_wales : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country_wales", op, join, Long_Float( country_wales ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_wales;


   procedure Add_country_n_ireland( c : in out d.Criteria; country_n_ireland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country_n_ireland", op, join, Long_Float( country_n_ireland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_n_ireland;


   procedure Add_household_all_households( c : in out d.Criteria; household_all_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_all_households", op, join, Long_Float( household_all_households ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_all_households;


   procedure Add_sco_hhld_one_adult_male( c : in out d.Criteria; sco_hhld_one_adult_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_one_adult_male", op, join, Long_Float( sco_hhld_one_adult_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_male;


   procedure Add_sco_hhld_one_adult_female( c : in out d.Criteria; sco_hhld_one_adult_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_one_adult_female", op, join, Long_Float( sco_hhld_one_adult_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_female;


   procedure Add_sco_hhld_two_adults( c : in out d.Criteria; sco_hhld_two_adults : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_two_adults", op, join, Long_Float( sco_hhld_two_adults ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_two_adults;


   procedure Add_sco_hhld_one_adult_one_child( c : in out d.Criteria; sco_hhld_one_adult_one_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_one_adult_one_child", op, join, Long_Float( sco_hhld_one_adult_one_child ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_one_child;


   procedure Add_sco_hhld_one_adult_two_plus_children( c : in out d.Criteria; sco_hhld_one_adult_two_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_one_adult_two_plus_children", op, join, Long_Float( sco_hhld_one_adult_two_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_two_plus_children;


   procedure Add_sco_hhld_two_plus_adult_one_plus_children( c : in out d.Criteria; sco_hhld_two_plus_adult_one_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_two_plus_adult_one_plus_children", op, join, Long_Float( sco_hhld_two_plus_adult_one_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_two_plus_adult_one_plus_children;


   procedure Add_sco_hhld_three_plus_person_all_adult( c : in out d.Criteria; sco_hhld_three_plus_person_all_adult : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sco_hhld_three_plus_person_all_adult", op, join, Long_Float( sco_hhld_three_plus_person_all_adult ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_three_plus_person_all_adult;


   procedure Add_eng_hhld_one_person_households_male( c : in out d.Criteria; eng_hhld_one_person_households_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_one_person_households_male", op, join, Long_Float( eng_hhld_one_person_households_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_one_person_households_male;


   procedure Add_eng_hhld_one_person_households_female( c : in out d.Criteria; eng_hhld_one_person_households_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_one_person_households_female", op, join, Long_Float( eng_hhld_one_person_households_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_one_person_households_female;


   procedure Add_eng_hhld_one_family_and_no_others_couple_no_dependent_chi( c : in out d.Criteria; eng_hhld_one_family_and_no_others_couple_no_dependent_chi : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_one_family_and_no_others_couple_no_dependent_chi", op, join, Long_Float( eng_hhld_one_family_and_no_others_couple_no_dependent_chi ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_one_family_and_no_others_couple_no_dependent_chi;


   procedure Add_eng_hhld_a_couple_and_other_adults_no_dependent_children( c : in out d.Criteria; eng_hhld_a_couple_and_other_adults_no_dependent_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_a_couple_and_other_adults_no_dependent_children", op, join, Long_Float( eng_hhld_a_couple_and_other_adults_no_dependent_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_a_couple_and_other_adults_no_dependent_children;


   procedure Add_eng_hhld_households_with_one_dependent_child( c : in out d.Criteria; eng_hhld_households_with_one_dependent_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_households_with_one_dependent_child", op, join, Long_Float( eng_hhld_households_with_one_dependent_child ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_households_with_one_dependent_child;


   procedure Add_eng_hhld_households_with_two_dependent_children( c : in out d.Criteria; eng_hhld_households_with_two_dependent_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_households_with_two_dependent_children", op, join, Long_Float( eng_hhld_households_with_two_dependent_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_households_with_two_dependent_children;


   procedure Add_eng_hhld_households_with_three_dependent_children( c : in out d.Criteria; eng_hhld_households_with_three_dependent_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_households_with_three_dependent_children", op, join, Long_Float( eng_hhld_households_with_three_dependent_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_households_with_three_dependent_children;


   procedure Add_eng_hhld_other_households( c : in out d.Criteria; eng_hhld_other_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eng_hhld_other_households", op, join, Long_Float( eng_hhld_other_households ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_other_households;


   procedure Add_nir_hhld_one_adult_households( c : in out d.Criteria; nir_hhld_one_adult_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nir_hhld_one_adult_households", op, join, Long_Float( nir_hhld_one_adult_households ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_one_adult_households;


   procedure Add_nir_hhld_two_adults_without_children( c : in out d.Criteria; nir_hhld_two_adults_without_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nir_hhld_two_adults_without_children", op, join, Long_Float( nir_hhld_two_adults_without_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_two_adults_without_children;


   procedure Add_nir_hhld_other_households_without_children( c : in out d.Criteria; nir_hhld_other_households_without_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nir_hhld_other_households_without_children", op, join, Long_Float( nir_hhld_other_households_without_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_other_households_without_children;


   procedure Add_nir_hhld_one_adult_households_with_children( c : in out d.Criteria; nir_hhld_one_adult_households_with_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nir_hhld_one_adult_households_with_children", op, join, Long_Float( nir_hhld_one_adult_households_with_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_one_adult_households_with_children;


   procedure Add_nir_hhld_other_households_with_children( c : in out d.Criteria; nir_hhld_other_households_with_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nir_hhld_other_households_with_children", op, join, Long_Float( nir_hhld_other_households_with_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_other_households_with_children;


   procedure Add_wal_hhld_1_person( c : in out d.Criteria; wal_hhld_1_person : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_1_person", op, join, Long_Float( wal_hhld_1_person ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_1_person;


   procedure Add_wal_hhld_2_person_no_children( c : in out d.Criteria; wal_hhld_2_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_2_person_no_children", op, join, Long_Float( wal_hhld_2_person_no_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_2_person_no_children;


   procedure Add_wal_hhld_2_person_1_adult_1_child( c : in out d.Criteria; wal_hhld_2_person_1_adult_1_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_2_person_1_adult_1_child", op, join, Long_Float( wal_hhld_2_person_1_adult_1_child ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_2_person_1_adult_1_child;


   procedure Add_wal_hhld_3_person_no_children( c : in out d.Criteria; wal_hhld_3_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_3_person_no_children", op, join, Long_Float( wal_hhld_3_person_no_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_3_person_no_children;


   procedure Add_wal_hhld_3_person_2_adults_1_child( c : in out d.Criteria; wal_hhld_3_person_2_adults_1_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_3_person_2_adults_1_child", op, join, Long_Float( wal_hhld_3_person_2_adults_1_child ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_3_person_2_adults_1_child;


   procedure Add_wal_hhld_3_person_1_adult_2_children( c : in out d.Criteria; wal_hhld_3_person_1_adult_2_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_3_person_1_adult_2_children", op, join, Long_Float( wal_hhld_3_person_1_adult_2_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_3_person_1_adult_2_children;


   procedure Add_wal_hhld_4_person_no_children( c : in out d.Criteria; wal_hhld_4_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_4_person_no_children", op, join, Long_Float( wal_hhld_4_person_no_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_4_person_no_children;


   procedure Add_wal_hhld_4_person_2_plus_adults_1_plus_children( c : in out d.Criteria; wal_hhld_4_person_2_plus_adults_1_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_4_person_2_plus_adults_1_plus_children", op, join, Long_Float( wal_hhld_4_person_2_plus_adults_1_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_4_person_2_plus_adults_1_plus_children;


   procedure Add_wal_hhld_4_person_1_adult_3_children( c : in out d.Criteria; wal_hhld_4_person_1_adult_3_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_4_person_1_adult_3_children", op, join, Long_Float( wal_hhld_4_person_1_adult_3_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_4_person_1_adult_3_children;


   procedure Add_wal_hhld_5_plus_person_no_children( c : in out d.Criteria; wal_hhld_5_plus_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_5_plus_person_no_children", op, join, Long_Float( wal_hhld_5_plus_person_no_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_5_plus_person_no_children;


   procedure Add_wal_hhld_5_plus_person_2_plus_adults_1_plus_children( c : in out d.Criteria; wal_hhld_5_plus_person_2_plus_adults_1_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_5_plus_person_2_plus_adults_1_plus_children", op, join, Long_Float( wal_hhld_5_plus_person_2_plus_adults_1_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_5_plus_person_2_plus_adults_1_plus_children;


   procedure Add_wal_hhld_5_plus_person_1_adult_4_plus_children( c : in out d.Criteria; wal_hhld_5_plus_person_1_adult_4_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wal_hhld_5_plus_person_1_adult_4_plus_children", op, join, Long_Float( wal_hhld_5_plus_person_1_adult_4_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_5_plus_person_1_adult_4_plus_children;


   procedure Add_male( c : in out d.Criteria; male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "male", op, join, Long_Float( male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_male;


   procedure Add_female( c : in out d.Criteria; female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "female", op, join, Long_Float( female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_female;


   procedure Add_employed( c : in out d.Criteria; employed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "employed", op, join, Long_Float( employed ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_employed;


   procedure Add_employee( c : in out d.Criteria; employee : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "employee", op, join, Long_Float( employee ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_employee;


   procedure Add_ilo_unemployed( c : in out d.Criteria; ilo_unemployed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ilo_unemployed", op, join, Long_Float( ilo_unemployed ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ilo_unemployed;


   procedure Add_jsa_claimant( c : in out d.Criteria; jsa_claimant : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jsa_claimant", op, join, Long_Float( jsa_claimant ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_jsa_claimant;


   procedure Add_age_0_male( c : in out d.Criteria; age_0_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_0_male", op, join, Long_Float( age_0_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0_male;


   procedure Add_age_1_male( c : in out d.Criteria; age_1_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_1_male", op, join, Long_Float( age_1_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1_male;


   procedure Add_age_2_male( c : in out d.Criteria; age_2_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_2_male", op, join, Long_Float( age_2_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2_male;


   procedure Add_age_3_male( c : in out d.Criteria; age_3_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_3_male", op, join, Long_Float( age_3_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3_male;


   procedure Add_age_4_male( c : in out d.Criteria; age_4_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_4_male", op, join, Long_Float( age_4_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4_male;


   procedure Add_age_5_male( c : in out d.Criteria; age_5_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_5_male", op, join, Long_Float( age_5_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5_male;


   procedure Add_age_6_male( c : in out d.Criteria; age_6_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_6_male", op, join, Long_Float( age_6_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6_male;


   procedure Add_age_7_male( c : in out d.Criteria; age_7_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_7_male", op, join, Long_Float( age_7_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7_male;


   procedure Add_age_8_male( c : in out d.Criteria; age_8_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_8_male", op, join, Long_Float( age_8_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8_male;


   procedure Add_age_9_male( c : in out d.Criteria; age_9_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_9_male", op, join, Long_Float( age_9_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9_male;


   procedure Add_age_10_male( c : in out d.Criteria; age_10_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_10_male", op, join, Long_Float( age_10_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10_male;


   procedure Add_age_11_male( c : in out d.Criteria; age_11_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_11_male", op, join, Long_Float( age_11_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11_male;


   procedure Add_age_12_male( c : in out d.Criteria; age_12_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_12_male", op, join, Long_Float( age_12_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12_male;


   procedure Add_age_13_male( c : in out d.Criteria; age_13_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_13_male", op, join, Long_Float( age_13_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13_male;


   procedure Add_age_14_male( c : in out d.Criteria; age_14_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_14_male", op, join, Long_Float( age_14_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14_male;


   procedure Add_age_15_male( c : in out d.Criteria; age_15_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_15_male", op, join, Long_Float( age_15_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15_male;


   procedure Add_age_16_male( c : in out d.Criteria; age_16_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_16_male", op, join, Long_Float( age_16_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_male;


   procedure Add_age_17_male( c : in out d.Criteria; age_17_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_17_male", op, join, Long_Float( age_17_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17_male;


   procedure Add_age_18_male( c : in out d.Criteria; age_18_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_18_male", op, join, Long_Float( age_18_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18_male;


   procedure Add_age_19_male( c : in out d.Criteria; age_19_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_19_male", op, join, Long_Float( age_19_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19_male;


   procedure Add_age_20_male( c : in out d.Criteria; age_20_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_20_male", op, join, Long_Float( age_20_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_male;


   procedure Add_age_21_male( c : in out d.Criteria; age_21_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_21_male", op, join, Long_Float( age_21_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21_male;


   procedure Add_age_22_male( c : in out d.Criteria; age_22_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_22_male", op, join, Long_Float( age_22_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22_male;


   procedure Add_age_23_male( c : in out d.Criteria; age_23_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_23_male", op, join, Long_Float( age_23_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23_male;


   procedure Add_age_24_male( c : in out d.Criteria; age_24_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_24_male", op, join, Long_Float( age_24_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24_male;


   procedure Add_age_25_male( c : in out d.Criteria; age_25_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_25_male", op, join, Long_Float( age_25_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_male;


   procedure Add_age_26_male( c : in out d.Criteria; age_26_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_26_male", op, join, Long_Float( age_26_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26_male;


   procedure Add_age_27_male( c : in out d.Criteria; age_27_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_27_male", op, join, Long_Float( age_27_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27_male;


   procedure Add_age_28_male( c : in out d.Criteria; age_28_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_28_male", op, join, Long_Float( age_28_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28_male;


   procedure Add_age_29_male( c : in out d.Criteria; age_29_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_29_male", op, join, Long_Float( age_29_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29_male;


   procedure Add_age_30_male( c : in out d.Criteria; age_30_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_30_male", op, join, Long_Float( age_30_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_male;


   procedure Add_age_31_male( c : in out d.Criteria; age_31_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_31_male", op, join, Long_Float( age_31_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31_male;


   procedure Add_age_32_male( c : in out d.Criteria; age_32_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_32_male", op, join, Long_Float( age_32_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32_male;


   procedure Add_age_33_male( c : in out d.Criteria; age_33_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_33_male", op, join, Long_Float( age_33_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33_male;


   procedure Add_age_34_male( c : in out d.Criteria; age_34_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_34_male", op, join, Long_Float( age_34_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34_male;


   procedure Add_age_35_male( c : in out d.Criteria; age_35_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_35_male", op, join, Long_Float( age_35_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_male;


   procedure Add_age_36_male( c : in out d.Criteria; age_36_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_36_male", op, join, Long_Float( age_36_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36_male;


   procedure Add_age_37_male( c : in out d.Criteria; age_37_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_37_male", op, join, Long_Float( age_37_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37_male;


   procedure Add_age_38_male( c : in out d.Criteria; age_38_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_38_male", op, join, Long_Float( age_38_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38_male;


   procedure Add_age_39_male( c : in out d.Criteria; age_39_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_39_male", op, join, Long_Float( age_39_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39_male;


   procedure Add_age_40_male( c : in out d.Criteria; age_40_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_40_male", op, join, Long_Float( age_40_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_male;


   procedure Add_age_41_male( c : in out d.Criteria; age_41_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_41_male", op, join, Long_Float( age_41_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41_male;


   procedure Add_age_42_male( c : in out d.Criteria; age_42_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_42_male", op, join, Long_Float( age_42_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42_male;


   procedure Add_age_43_male( c : in out d.Criteria; age_43_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_43_male", op, join, Long_Float( age_43_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43_male;


   procedure Add_age_44_male( c : in out d.Criteria; age_44_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_44_male", op, join, Long_Float( age_44_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44_male;


   procedure Add_age_45_male( c : in out d.Criteria; age_45_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_45_male", op, join, Long_Float( age_45_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_male;


   procedure Add_age_46_male( c : in out d.Criteria; age_46_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_46_male", op, join, Long_Float( age_46_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46_male;


   procedure Add_age_47_male( c : in out d.Criteria; age_47_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_47_male", op, join, Long_Float( age_47_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47_male;


   procedure Add_age_48_male( c : in out d.Criteria; age_48_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_48_male", op, join, Long_Float( age_48_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48_male;


   procedure Add_age_49_male( c : in out d.Criteria; age_49_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_49_male", op, join, Long_Float( age_49_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49_male;


   procedure Add_age_50_male( c : in out d.Criteria; age_50_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_50_male", op, join, Long_Float( age_50_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_male;


   procedure Add_age_51_male( c : in out d.Criteria; age_51_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_51_male", op, join, Long_Float( age_51_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51_male;


   procedure Add_age_52_male( c : in out d.Criteria; age_52_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_52_male", op, join, Long_Float( age_52_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52_male;


   procedure Add_age_53_male( c : in out d.Criteria; age_53_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_53_male", op, join, Long_Float( age_53_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53_male;


   procedure Add_age_54_male( c : in out d.Criteria; age_54_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_54_male", op, join, Long_Float( age_54_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54_male;


   procedure Add_age_55_male( c : in out d.Criteria; age_55_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_55_male", op, join, Long_Float( age_55_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_male;


   procedure Add_age_56_male( c : in out d.Criteria; age_56_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_56_male", op, join, Long_Float( age_56_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56_male;


   procedure Add_age_57_male( c : in out d.Criteria; age_57_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_57_male", op, join, Long_Float( age_57_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57_male;


   procedure Add_age_58_male( c : in out d.Criteria; age_58_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_58_male", op, join, Long_Float( age_58_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58_male;


   procedure Add_age_59_male( c : in out d.Criteria; age_59_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_59_male", op, join, Long_Float( age_59_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59_male;


   procedure Add_age_60_male( c : in out d.Criteria; age_60_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_60_male", op, join, Long_Float( age_60_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_male;


   procedure Add_age_61_male( c : in out d.Criteria; age_61_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_61_male", op, join, Long_Float( age_61_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61_male;


   procedure Add_age_62_male( c : in out d.Criteria; age_62_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_62_male", op, join, Long_Float( age_62_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62_male;


   procedure Add_age_63_male( c : in out d.Criteria; age_63_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_63_male", op, join, Long_Float( age_63_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63_male;


   procedure Add_age_64_male( c : in out d.Criteria; age_64_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_64_male", op, join, Long_Float( age_64_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64_male;


   procedure Add_age_65_male( c : in out d.Criteria; age_65_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_65_male", op, join, Long_Float( age_65_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_male;


   procedure Add_age_66_male( c : in out d.Criteria; age_66_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_66_male", op, join, Long_Float( age_66_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66_male;


   procedure Add_age_67_male( c : in out d.Criteria; age_67_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_67_male", op, join, Long_Float( age_67_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67_male;


   procedure Add_age_68_male( c : in out d.Criteria; age_68_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_68_male", op, join, Long_Float( age_68_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68_male;


   procedure Add_age_69_male( c : in out d.Criteria; age_69_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_69_male", op, join, Long_Float( age_69_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69_male;


   procedure Add_age_70_male( c : in out d.Criteria; age_70_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_70_male", op, join, Long_Float( age_70_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_male;


   procedure Add_age_71_male( c : in out d.Criteria; age_71_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_71_male", op, join, Long_Float( age_71_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71_male;


   procedure Add_age_72_male( c : in out d.Criteria; age_72_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_72_male", op, join, Long_Float( age_72_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72_male;


   procedure Add_age_73_male( c : in out d.Criteria; age_73_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_73_male", op, join, Long_Float( age_73_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73_male;


   procedure Add_age_74_male( c : in out d.Criteria; age_74_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_74_male", op, join, Long_Float( age_74_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74_male;


   procedure Add_age_75_male( c : in out d.Criteria; age_75_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_75_male", op, join, Long_Float( age_75_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_male;


   procedure Add_age_76_male( c : in out d.Criteria; age_76_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_76_male", op, join, Long_Float( age_76_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76_male;


   procedure Add_age_77_male( c : in out d.Criteria; age_77_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_77_male", op, join, Long_Float( age_77_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77_male;


   procedure Add_age_78_male( c : in out d.Criteria; age_78_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_78_male", op, join, Long_Float( age_78_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78_male;


   procedure Add_age_79_male( c : in out d.Criteria; age_79_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_79_male", op, join, Long_Float( age_79_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79_male;


   procedure Add_age_80_male( c : in out d.Criteria; age_80_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_80_male", op, join, Long_Float( age_80_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80_male;


   procedure Add_age_81_male( c : in out d.Criteria; age_81_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_81_male", op, join, Long_Float( age_81_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81_male;


   procedure Add_age_82_male( c : in out d.Criteria; age_82_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_82_male", op, join, Long_Float( age_82_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82_male;


   procedure Add_age_83_male( c : in out d.Criteria; age_83_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_83_male", op, join, Long_Float( age_83_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83_male;


   procedure Add_age_84_male( c : in out d.Criteria; age_84_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_84_male", op, join, Long_Float( age_84_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84_male;


   procedure Add_age_85_male( c : in out d.Criteria; age_85_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_85_male", op, join, Long_Float( age_85_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85_male;


   procedure Add_age_86_male( c : in out d.Criteria; age_86_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_86_male", op, join, Long_Float( age_86_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86_male;


   procedure Add_age_87_male( c : in out d.Criteria; age_87_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_87_male", op, join, Long_Float( age_87_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87_male;


   procedure Add_age_88_male( c : in out d.Criteria; age_88_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_88_male", op, join, Long_Float( age_88_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88_male;


   procedure Add_age_89_male( c : in out d.Criteria; age_89_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_89_male", op, join, Long_Float( age_89_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89_male;


   procedure Add_age_90_male( c : in out d.Criteria; age_90_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_90_male", op, join, Long_Float( age_90_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90_male;


   procedure Add_age_91_male( c : in out d.Criteria; age_91_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_91_male", op, join, Long_Float( age_91_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91_male;


   procedure Add_age_92_male( c : in out d.Criteria; age_92_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_92_male", op, join, Long_Float( age_92_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92_male;


   procedure Add_age_93_male( c : in out d.Criteria; age_93_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_93_male", op, join, Long_Float( age_93_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93_male;


   procedure Add_age_94_male( c : in out d.Criteria; age_94_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_94_male", op, join, Long_Float( age_94_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94_male;


   procedure Add_age_95_male( c : in out d.Criteria; age_95_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_95_male", op, join, Long_Float( age_95_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95_male;


   procedure Add_age_96_male( c : in out d.Criteria; age_96_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_96_male", op, join, Long_Float( age_96_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96_male;


   procedure Add_age_97_male( c : in out d.Criteria; age_97_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_97_male", op, join, Long_Float( age_97_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97_male;


   procedure Add_age_98_male( c : in out d.Criteria; age_98_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_98_male", op, join, Long_Float( age_98_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98_male;


   procedure Add_age_99_male( c : in out d.Criteria; age_99_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_99_male", op, join, Long_Float( age_99_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99_male;


   procedure Add_age_100_male( c : in out d.Criteria; age_100_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_100_male", op, join, Long_Float( age_100_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100_male;


   procedure Add_age_101_male( c : in out d.Criteria; age_101_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_101_male", op, join, Long_Float( age_101_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101_male;


   procedure Add_age_102_male( c : in out d.Criteria; age_102_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_102_male", op, join, Long_Float( age_102_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102_male;


   procedure Add_age_103_male( c : in out d.Criteria; age_103_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_103_male", op, join, Long_Float( age_103_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103_male;


   procedure Add_age_104_male( c : in out d.Criteria; age_104_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_104_male", op, join, Long_Float( age_104_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104_male;


   procedure Add_age_105_male( c : in out d.Criteria; age_105_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_105_male", op, join, Long_Float( age_105_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105_male;


   procedure Add_age_106_male( c : in out d.Criteria; age_106_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_106_male", op, join, Long_Float( age_106_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106_male;


   procedure Add_age_107_male( c : in out d.Criteria; age_107_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_107_male", op, join, Long_Float( age_107_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107_male;


   procedure Add_age_108_male( c : in out d.Criteria; age_108_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_108_male", op, join, Long_Float( age_108_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108_male;


   procedure Add_age_109_male( c : in out d.Criteria; age_109_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_109_male", op, join, Long_Float( age_109_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109_male;


   procedure Add_age_110_male( c : in out d.Criteria; age_110_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_110_male", op, join, Long_Float( age_110_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110_male;


   procedure Add_age_0_female( c : in out d.Criteria; age_0_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_0_female", op, join, Long_Float( age_0_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0_female;


   procedure Add_age_1_female( c : in out d.Criteria; age_1_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_1_female", op, join, Long_Float( age_1_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1_female;


   procedure Add_age_2_female( c : in out d.Criteria; age_2_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_2_female", op, join, Long_Float( age_2_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2_female;


   procedure Add_age_3_female( c : in out d.Criteria; age_3_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_3_female", op, join, Long_Float( age_3_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3_female;


   procedure Add_age_4_female( c : in out d.Criteria; age_4_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_4_female", op, join, Long_Float( age_4_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4_female;


   procedure Add_age_5_female( c : in out d.Criteria; age_5_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_5_female", op, join, Long_Float( age_5_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5_female;


   procedure Add_age_6_female( c : in out d.Criteria; age_6_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_6_female", op, join, Long_Float( age_6_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6_female;


   procedure Add_age_7_female( c : in out d.Criteria; age_7_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_7_female", op, join, Long_Float( age_7_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7_female;


   procedure Add_age_8_female( c : in out d.Criteria; age_8_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_8_female", op, join, Long_Float( age_8_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8_female;


   procedure Add_age_9_female( c : in out d.Criteria; age_9_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_9_female", op, join, Long_Float( age_9_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9_female;


   procedure Add_age_10_female( c : in out d.Criteria; age_10_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_10_female", op, join, Long_Float( age_10_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10_female;


   procedure Add_age_11_female( c : in out d.Criteria; age_11_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_11_female", op, join, Long_Float( age_11_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11_female;


   procedure Add_age_12_female( c : in out d.Criteria; age_12_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_12_female", op, join, Long_Float( age_12_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12_female;


   procedure Add_age_13_female( c : in out d.Criteria; age_13_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_13_female", op, join, Long_Float( age_13_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13_female;


   procedure Add_age_14_female( c : in out d.Criteria; age_14_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_14_female", op, join, Long_Float( age_14_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14_female;


   procedure Add_age_15_female( c : in out d.Criteria; age_15_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_15_female", op, join, Long_Float( age_15_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15_female;


   procedure Add_age_16_female( c : in out d.Criteria; age_16_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_16_female", op, join, Long_Float( age_16_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_female;


   procedure Add_age_17_female( c : in out d.Criteria; age_17_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_17_female", op, join, Long_Float( age_17_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17_female;


   procedure Add_age_18_female( c : in out d.Criteria; age_18_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_18_female", op, join, Long_Float( age_18_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18_female;


   procedure Add_age_19_female( c : in out d.Criteria; age_19_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_19_female", op, join, Long_Float( age_19_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19_female;


   procedure Add_age_20_female( c : in out d.Criteria; age_20_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_20_female", op, join, Long_Float( age_20_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_female;


   procedure Add_age_21_female( c : in out d.Criteria; age_21_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_21_female", op, join, Long_Float( age_21_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21_female;


   procedure Add_age_22_female( c : in out d.Criteria; age_22_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_22_female", op, join, Long_Float( age_22_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22_female;


   procedure Add_age_23_female( c : in out d.Criteria; age_23_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_23_female", op, join, Long_Float( age_23_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23_female;


   procedure Add_age_24_female( c : in out d.Criteria; age_24_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_24_female", op, join, Long_Float( age_24_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24_female;


   procedure Add_age_25_female( c : in out d.Criteria; age_25_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_25_female", op, join, Long_Float( age_25_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_female;


   procedure Add_age_26_female( c : in out d.Criteria; age_26_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_26_female", op, join, Long_Float( age_26_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26_female;


   procedure Add_age_27_female( c : in out d.Criteria; age_27_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_27_female", op, join, Long_Float( age_27_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27_female;


   procedure Add_age_28_female( c : in out d.Criteria; age_28_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_28_female", op, join, Long_Float( age_28_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28_female;


   procedure Add_age_29_female( c : in out d.Criteria; age_29_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_29_female", op, join, Long_Float( age_29_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29_female;


   procedure Add_age_30_female( c : in out d.Criteria; age_30_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_30_female", op, join, Long_Float( age_30_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_female;


   procedure Add_age_31_female( c : in out d.Criteria; age_31_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_31_female", op, join, Long_Float( age_31_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31_female;


   procedure Add_age_32_female( c : in out d.Criteria; age_32_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_32_female", op, join, Long_Float( age_32_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32_female;


   procedure Add_age_33_female( c : in out d.Criteria; age_33_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_33_female", op, join, Long_Float( age_33_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33_female;


   procedure Add_age_34_female( c : in out d.Criteria; age_34_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_34_female", op, join, Long_Float( age_34_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34_female;


   procedure Add_age_35_female( c : in out d.Criteria; age_35_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_35_female", op, join, Long_Float( age_35_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_female;


   procedure Add_age_36_female( c : in out d.Criteria; age_36_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_36_female", op, join, Long_Float( age_36_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36_female;


   procedure Add_age_37_female( c : in out d.Criteria; age_37_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_37_female", op, join, Long_Float( age_37_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37_female;


   procedure Add_age_38_female( c : in out d.Criteria; age_38_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_38_female", op, join, Long_Float( age_38_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38_female;


   procedure Add_age_39_female( c : in out d.Criteria; age_39_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_39_female", op, join, Long_Float( age_39_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39_female;


   procedure Add_age_40_female( c : in out d.Criteria; age_40_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_40_female", op, join, Long_Float( age_40_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_female;


   procedure Add_age_41_female( c : in out d.Criteria; age_41_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_41_female", op, join, Long_Float( age_41_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41_female;


   procedure Add_age_42_female( c : in out d.Criteria; age_42_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_42_female", op, join, Long_Float( age_42_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42_female;


   procedure Add_age_43_female( c : in out d.Criteria; age_43_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_43_female", op, join, Long_Float( age_43_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43_female;


   procedure Add_age_44_female( c : in out d.Criteria; age_44_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_44_female", op, join, Long_Float( age_44_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44_female;


   procedure Add_age_45_female( c : in out d.Criteria; age_45_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_45_female", op, join, Long_Float( age_45_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_female;


   procedure Add_age_46_female( c : in out d.Criteria; age_46_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_46_female", op, join, Long_Float( age_46_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46_female;


   procedure Add_age_47_female( c : in out d.Criteria; age_47_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_47_female", op, join, Long_Float( age_47_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47_female;


   procedure Add_age_48_female( c : in out d.Criteria; age_48_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_48_female", op, join, Long_Float( age_48_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48_female;


   procedure Add_age_49_female( c : in out d.Criteria; age_49_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_49_female", op, join, Long_Float( age_49_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49_female;


   procedure Add_age_50_female( c : in out d.Criteria; age_50_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_50_female", op, join, Long_Float( age_50_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_female;


   procedure Add_age_51_female( c : in out d.Criteria; age_51_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_51_female", op, join, Long_Float( age_51_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51_female;


   procedure Add_age_52_female( c : in out d.Criteria; age_52_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_52_female", op, join, Long_Float( age_52_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52_female;


   procedure Add_age_53_female( c : in out d.Criteria; age_53_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_53_female", op, join, Long_Float( age_53_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53_female;


   procedure Add_age_54_female( c : in out d.Criteria; age_54_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_54_female", op, join, Long_Float( age_54_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54_female;


   procedure Add_age_55_female( c : in out d.Criteria; age_55_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_55_female", op, join, Long_Float( age_55_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_female;


   procedure Add_age_56_female( c : in out d.Criteria; age_56_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_56_female", op, join, Long_Float( age_56_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56_female;


   procedure Add_age_57_female( c : in out d.Criteria; age_57_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_57_female", op, join, Long_Float( age_57_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57_female;


   procedure Add_age_58_female( c : in out d.Criteria; age_58_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_58_female", op, join, Long_Float( age_58_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58_female;


   procedure Add_age_59_female( c : in out d.Criteria; age_59_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_59_female", op, join, Long_Float( age_59_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59_female;


   procedure Add_age_60_female( c : in out d.Criteria; age_60_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_60_female", op, join, Long_Float( age_60_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_female;


   procedure Add_age_61_female( c : in out d.Criteria; age_61_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_61_female", op, join, Long_Float( age_61_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61_female;


   procedure Add_age_62_female( c : in out d.Criteria; age_62_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_62_female", op, join, Long_Float( age_62_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62_female;


   procedure Add_age_63_female( c : in out d.Criteria; age_63_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_63_female", op, join, Long_Float( age_63_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63_female;


   procedure Add_age_64_female( c : in out d.Criteria; age_64_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_64_female", op, join, Long_Float( age_64_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64_female;


   procedure Add_age_65_female( c : in out d.Criteria; age_65_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_65_female", op, join, Long_Float( age_65_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_female;


   procedure Add_age_66_female( c : in out d.Criteria; age_66_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_66_female", op, join, Long_Float( age_66_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66_female;


   procedure Add_age_67_female( c : in out d.Criteria; age_67_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_67_female", op, join, Long_Float( age_67_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67_female;


   procedure Add_age_68_female( c : in out d.Criteria; age_68_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_68_female", op, join, Long_Float( age_68_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68_female;


   procedure Add_age_69_female( c : in out d.Criteria; age_69_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_69_female", op, join, Long_Float( age_69_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69_female;


   procedure Add_age_70_female( c : in out d.Criteria; age_70_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_70_female", op, join, Long_Float( age_70_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_female;


   procedure Add_age_71_female( c : in out d.Criteria; age_71_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_71_female", op, join, Long_Float( age_71_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71_female;


   procedure Add_age_72_female( c : in out d.Criteria; age_72_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_72_female", op, join, Long_Float( age_72_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72_female;


   procedure Add_age_73_female( c : in out d.Criteria; age_73_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_73_female", op, join, Long_Float( age_73_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73_female;


   procedure Add_age_74_female( c : in out d.Criteria; age_74_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_74_female", op, join, Long_Float( age_74_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74_female;


   procedure Add_age_75_female( c : in out d.Criteria; age_75_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_75_female", op, join, Long_Float( age_75_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_female;


   procedure Add_age_76_female( c : in out d.Criteria; age_76_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_76_female", op, join, Long_Float( age_76_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76_female;


   procedure Add_age_77_female( c : in out d.Criteria; age_77_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_77_female", op, join, Long_Float( age_77_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77_female;


   procedure Add_age_78_female( c : in out d.Criteria; age_78_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_78_female", op, join, Long_Float( age_78_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78_female;


   procedure Add_age_79_female( c : in out d.Criteria; age_79_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_79_female", op, join, Long_Float( age_79_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79_female;


   procedure Add_age_80_female( c : in out d.Criteria; age_80_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_80_female", op, join, Long_Float( age_80_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80_female;


   procedure Add_age_81_female( c : in out d.Criteria; age_81_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_81_female", op, join, Long_Float( age_81_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81_female;


   procedure Add_age_82_female( c : in out d.Criteria; age_82_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_82_female", op, join, Long_Float( age_82_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82_female;


   procedure Add_age_83_female( c : in out d.Criteria; age_83_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_83_female", op, join, Long_Float( age_83_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83_female;


   procedure Add_age_84_female( c : in out d.Criteria; age_84_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_84_female", op, join, Long_Float( age_84_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84_female;


   procedure Add_age_85_female( c : in out d.Criteria; age_85_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_85_female", op, join, Long_Float( age_85_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85_female;


   procedure Add_age_86_female( c : in out d.Criteria; age_86_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_86_female", op, join, Long_Float( age_86_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86_female;


   procedure Add_age_87_female( c : in out d.Criteria; age_87_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_87_female", op, join, Long_Float( age_87_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87_female;


   procedure Add_age_88_female( c : in out d.Criteria; age_88_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_88_female", op, join, Long_Float( age_88_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88_female;


   procedure Add_age_89_female( c : in out d.Criteria; age_89_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_89_female", op, join, Long_Float( age_89_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89_female;


   procedure Add_age_90_female( c : in out d.Criteria; age_90_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_90_female", op, join, Long_Float( age_90_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90_female;


   procedure Add_age_91_female( c : in out d.Criteria; age_91_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_91_female", op, join, Long_Float( age_91_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91_female;


   procedure Add_age_92_female( c : in out d.Criteria; age_92_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_92_female", op, join, Long_Float( age_92_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92_female;


   procedure Add_age_93_female( c : in out d.Criteria; age_93_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_93_female", op, join, Long_Float( age_93_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93_female;


   procedure Add_age_94_female( c : in out d.Criteria; age_94_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_94_female", op, join, Long_Float( age_94_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94_female;


   procedure Add_age_95_female( c : in out d.Criteria; age_95_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_95_female", op, join, Long_Float( age_95_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95_female;


   procedure Add_age_96_female( c : in out d.Criteria; age_96_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_96_female", op, join, Long_Float( age_96_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96_female;


   procedure Add_age_97_female( c : in out d.Criteria; age_97_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_97_female", op, join, Long_Float( age_97_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97_female;


   procedure Add_age_98_female( c : in out d.Criteria; age_98_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_98_female", op, join, Long_Float( age_98_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98_female;


   procedure Add_age_99_female( c : in out d.Criteria; age_99_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_99_female", op, join, Long_Float( age_99_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99_female;


   procedure Add_age_100_female( c : in out d.Criteria; age_100_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_100_female", op, join, Long_Float( age_100_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100_female;


   procedure Add_age_101_female( c : in out d.Criteria; age_101_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_101_female", op, join, Long_Float( age_101_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101_female;


   procedure Add_age_102_female( c : in out d.Criteria; age_102_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_102_female", op, join, Long_Float( age_102_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102_female;


   procedure Add_age_103_female( c : in out d.Criteria; age_103_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_103_female", op, join, Long_Float( age_103_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103_female;


   procedure Add_age_104_female( c : in out d.Criteria; age_104_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_104_female", op, join, Long_Float( age_104_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104_female;


   procedure Add_age_105_female( c : in out d.Criteria; age_105_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_105_female", op, join, Long_Float( age_105_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105_female;


   procedure Add_age_106_female( c : in out d.Criteria; age_106_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_106_female", op, join, Long_Float( age_106_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106_female;


   procedure Add_age_107_female( c : in out d.Criteria; age_107_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_107_female", op, join, Long_Float( age_107_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107_female;


   procedure Add_age_108_female( c : in out d.Criteria; age_108_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_108_female", op, join, Long_Float( age_108_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108_female;


   procedure Add_age_109_female( c : in out d.Criteria; age_109_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_109_female", op, join, Long_Float( age_109_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109_female;


   procedure Add_age_110_female( c : in out d.Criteria; age_110_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_110_female", op, join, Long_Float( age_110_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110_female;


   procedure Add_participation_16_19_male( c : in out d.Criteria; participation_16_19_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_16_19_male", op, join, Long_Float( participation_16_19_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_16_19_male;


   procedure Add_participation_20_24_male( c : in out d.Criteria; participation_20_24_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_20_24_male", op, join, Long_Float( participation_20_24_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_20_24_male;


   procedure Add_participation_25_29_male( c : in out d.Criteria; participation_25_29_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_25_29_male", op, join, Long_Float( participation_25_29_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_25_29_male;


   procedure Add_participation_30_34_male( c : in out d.Criteria; participation_30_34_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_30_34_male", op, join, Long_Float( participation_30_34_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_30_34_male;


   procedure Add_participation_35_39_male( c : in out d.Criteria; participation_35_39_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_35_39_male", op, join, Long_Float( participation_35_39_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_35_39_male;


   procedure Add_participation_40_44_male( c : in out d.Criteria; participation_40_44_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_40_44_male", op, join, Long_Float( participation_40_44_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_40_44_male;


   procedure Add_participation_45_49_male( c : in out d.Criteria; participation_45_49_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_45_49_male", op, join, Long_Float( participation_45_49_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_45_49_male;


   procedure Add_participation_50_54_male( c : in out d.Criteria; participation_50_54_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_50_54_male", op, join, Long_Float( participation_50_54_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_50_54_male;


   procedure Add_participation_55_59_male( c : in out d.Criteria; participation_55_59_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_55_59_male", op, join, Long_Float( participation_55_59_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_55_59_male;


   procedure Add_participation_60_64_male( c : in out d.Criteria; participation_60_64_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_60_64_male", op, join, Long_Float( participation_60_64_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_60_64_male;


   procedure Add_participation_65_69_male( c : in out d.Criteria; participation_65_69_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_65_69_male", op, join, Long_Float( participation_65_69_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_65_69_male;


   procedure Add_participation_70_74_male( c : in out d.Criteria; participation_70_74_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_70_74_male", op, join, Long_Float( participation_70_74_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_70_74_male;


   procedure Add_participation_75_plus_male( c : in out d.Criteria; participation_75_plus_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_75_plus_male", op, join, Long_Float( participation_75_plus_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_75_plus_male;


   procedure Add_participation_16_19_female( c : in out d.Criteria; participation_16_19_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_16_19_female", op, join, Long_Float( participation_16_19_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_16_19_female;


   procedure Add_participation_20_24_female( c : in out d.Criteria; participation_20_24_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_20_24_female", op, join, Long_Float( participation_20_24_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_20_24_female;


   procedure Add_participation_25_29_female( c : in out d.Criteria; participation_25_29_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_25_29_female", op, join, Long_Float( participation_25_29_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_25_29_female;


   procedure Add_participation_30_34_female( c : in out d.Criteria; participation_30_34_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_30_34_female", op, join, Long_Float( participation_30_34_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_30_34_female;


   procedure Add_participation_35_39_female( c : in out d.Criteria; participation_35_39_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_35_39_female", op, join, Long_Float( participation_35_39_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_35_39_female;


   procedure Add_participation_40_44_female( c : in out d.Criteria; participation_40_44_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_40_44_female", op, join, Long_Float( participation_40_44_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_40_44_female;


   procedure Add_participation_45_49_female( c : in out d.Criteria; participation_45_49_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_45_49_female", op, join, Long_Float( participation_45_49_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_45_49_female;


   procedure Add_participation_50_54_female( c : in out d.Criteria; participation_50_54_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_50_54_female", op, join, Long_Float( participation_50_54_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_50_54_female;


   procedure Add_participation_55_59_female( c : in out d.Criteria; participation_55_59_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_55_59_female", op, join, Long_Float( participation_55_59_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_55_59_female;


   procedure Add_participation_60_64_female( c : in out d.Criteria; participation_60_64_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_60_64_female", op, join, Long_Float( participation_60_64_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_60_64_female;


   procedure Add_participation_65_69_female( c : in out d.Criteria; participation_65_69_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_65_69_female", op, join, Long_Float( participation_65_69_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_65_69_female;


   procedure Add_participation_70_74_female( c : in out d.Criteria; participation_70_74_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_70_74_female", op, join, Long_Float( participation_70_74_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_70_74_female;


   procedure Add_participation_75_plus_female( c : in out d.Criteria; participation_75_plus_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_75_plus_female", op, join, Long_Float( participation_75_plus_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_75_plus_female;


   procedure Add_one_adult_hh_wales( c : in out d.Criteria; one_adult_hh_wales : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_hh_wales", op, join, Long_Float( one_adult_hh_wales ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_wales;


   procedure Add_two_adult_hhs_wales( c : in out d.Criteria; two_adult_hhs_wales : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "two_adult_hhs_wales", op, join, Long_Float( two_adult_hhs_wales ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_wales;


   procedure Add_other_hh_wales( c : in out d.Criteria; other_hh_wales : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "other_hh_wales", op, join, Long_Float( other_hh_wales ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_wales;


   procedure Add_one_adult_hh_nireland( c : in out d.Criteria; one_adult_hh_nireland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_hh_nireland", op, join, Long_Float( one_adult_hh_nireland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_nireland;


   procedure Add_two_adult_hhs_nireland( c : in out d.Criteria; two_adult_hhs_nireland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "two_adult_hhs_nireland", op, join, Long_Float( two_adult_hhs_nireland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_nireland;


   procedure Add_other_hh_nireland( c : in out d.Criteria; other_hh_nireland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "other_hh_nireland", op, join, Long_Float( other_hh_nireland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_nireland;


   procedure Add_one_adult_hh_england( c : in out d.Criteria; one_adult_hh_england : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_hh_england", op, join, Long_Float( one_adult_hh_england ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_england;


   procedure Add_two_adult_hhs_england( c : in out d.Criteria; two_adult_hhs_england : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "two_adult_hhs_england", op, join, Long_Float( two_adult_hhs_england ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_england;


   procedure Add_other_hh_england( c : in out d.Criteria; other_hh_england : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "other_hh_england", op, join, Long_Float( other_hh_england ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_england;


   procedure Add_one_adult_hh_scotland( c : in out d.Criteria; one_adult_hh_scotland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_hh_scotland", op, join, Long_Float( one_adult_hh_scotland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_scotland;


   procedure Add_two_adult_hhs_scotland( c : in out d.Criteria; two_adult_hhs_scotland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "two_adult_hhs_scotland", op, join, Long_Float( two_adult_hhs_scotland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_scotland;


   procedure Add_other_hh_scotland( c : in out d.Criteria; other_hh_scotland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "other_hh_scotland", op, join, Long_Float( other_hh_scotland ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_scotland;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "run_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_run_id_To_Orderings;


   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "user_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id_To_Orderings;


   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_year_To_Orderings;


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;


   procedure Add_country_uk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country_uk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_uk_To_Orderings;


   procedure Add_country_scotland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country_scotland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_scotland_To_Orderings;


   procedure Add_country_england_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country_england", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_england_To_Orderings;


   procedure Add_country_wales_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country_wales", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_wales_To_Orderings;


   procedure Add_country_n_ireland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country_n_ireland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_n_ireland_To_Orderings;


   procedure Add_household_all_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_all_households", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_all_households_To_Orderings;


   procedure Add_sco_hhld_one_adult_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_one_adult_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_male_To_Orderings;


   procedure Add_sco_hhld_one_adult_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_one_adult_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_female_To_Orderings;


   procedure Add_sco_hhld_two_adults_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_two_adults", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_two_adults_To_Orderings;


   procedure Add_sco_hhld_one_adult_one_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_one_adult_one_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_one_child_To_Orderings;


   procedure Add_sco_hhld_one_adult_two_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_one_adult_two_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_one_adult_two_plus_children_To_Orderings;


   procedure Add_sco_hhld_two_plus_adult_one_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_two_plus_adult_one_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_two_plus_adult_one_plus_children_To_Orderings;


   procedure Add_sco_hhld_three_plus_person_all_adult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sco_hhld_three_plus_person_all_adult", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sco_hhld_three_plus_person_all_adult_To_Orderings;


   procedure Add_eng_hhld_one_person_households_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_one_person_households_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_one_person_households_male_To_Orderings;


   procedure Add_eng_hhld_one_person_households_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_one_person_households_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_one_person_households_female_To_Orderings;


   procedure Add_eng_hhld_one_family_and_no_others_couple_no_dependent_chi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_one_family_and_no_others_couple_no_dependent_chi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_one_family_and_no_others_couple_no_dependent_chi_To_Orderings;


   procedure Add_eng_hhld_a_couple_and_other_adults_no_dependent_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_a_couple_and_other_adults_no_dependent_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_a_couple_and_other_adults_no_dependent_children_To_Orderings;


   procedure Add_eng_hhld_households_with_one_dependent_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_households_with_one_dependent_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_households_with_one_dependent_child_To_Orderings;


   procedure Add_eng_hhld_households_with_two_dependent_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_households_with_two_dependent_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_households_with_two_dependent_children_To_Orderings;


   procedure Add_eng_hhld_households_with_three_dependent_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_households_with_three_dependent_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_households_with_three_dependent_children_To_Orderings;


   procedure Add_eng_hhld_other_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eng_hhld_other_households", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eng_hhld_other_households_To_Orderings;


   procedure Add_nir_hhld_one_adult_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nir_hhld_one_adult_households", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_one_adult_households_To_Orderings;


   procedure Add_nir_hhld_two_adults_without_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nir_hhld_two_adults_without_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_two_adults_without_children_To_Orderings;


   procedure Add_nir_hhld_other_households_without_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nir_hhld_other_households_without_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_other_households_without_children_To_Orderings;


   procedure Add_nir_hhld_one_adult_households_with_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nir_hhld_one_adult_households_with_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_one_adult_households_with_children_To_Orderings;


   procedure Add_nir_hhld_other_households_with_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nir_hhld_other_households_with_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nir_hhld_other_households_with_children_To_Orderings;


   procedure Add_wal_hhld_1_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_1_person", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_1_person_To_Orderings;


   procedure Add_wal_hhld_2_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_2_person_no_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_2_person_no_children_To_Orderings;


   procedure Add_wal_hhld_2_person_1_adult_1_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_2_person_1_adult_1_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_2_person_1_adult_1_child_To_Orderings;


   procedure Add_wal_hhld_3_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_3_person_no_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_3_person_no_children_To_Orderings;


   procedure Add_wal_hhld_3_person_2_adults_1_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_3_person_2_adults_1_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_3_person_2_adults_1_child_To_Orderings;


   procedure Add_wal_hhld_3_person_1_adult_2_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_3_person_1_adult_2_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_3_person_1_adult_2_children_To_Orderings;


   procedure Add_wal_hhld_4_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_4_person_no_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_4_person_no_children_To_Orderings;


   procedure Add_wal_hhld_4_person_2_plus_adults_1_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_4_person_2_plus_adults_1_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_4_person_2_plus_adults_1_plus_children_To_Orderings;


   procedure Add_wal_hhld_4_person_1_adult_3_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_4_person_1_adult_3_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_4_person_1_adult_3_children_To_Orderings;


   procedure Add_wal_hhld_5_plus_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_5_plus_person_no_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_5_plus_person_no_children_To_Orderings;


   procedure Add_wal_hhld_5_plus_person_2_plus_adults_1_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_5_plus_person_2_plus_adults_1_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_5_plus_person_2_plus_adults_1_plus_children_To_Orderings;


   procedure Add_wal_hhld_5_plus_person_1_adult_4_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wal_hhld_5_plus_person_1_adult_4_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wal_hhld_5_plus_person_1_adult_4_plus_children_To_Orderings;


   procedure Add_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_male_To_Orderings;


   procedure Add_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_female_To_Orderings;


   procedure Add_employed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "employed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_employed_To_Orderings;


   procedure Add_employee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "employee", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_employee_To_Orderings;


   procedure Add_ilo_unemployed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ilo_unemployed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ilo_unemployed_To_Orderings;


   procedure Add_jsa_claimant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jsa_claimant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jsa_claimant_To_Orderings;


   procedure Add_age_0_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_0_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0_male_To_Orderings;


   procedure Add_age_1_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_1_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1_male_To_Orderings;


   procedure Add_age_2_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_2_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2_male_To_Orderings;


   procedure Add_age_3_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_3_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3_male_To_Orderings;


   procedure Add_age_4_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_4_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4_male_To_Orderings;


   procedure Add_age_5_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_5_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5_male_To_Orderings;


   procedure Add_age_6_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_6_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6_male_To_Orderings;


   procedure Add_age_7_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_7_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7_male_To_Orderings;


   procedure Add_age_8_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_8_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8_male_To_Orderings;


   procedure Add_age_9_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_9_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9_male_To_Orderings;


   procedure Add_age_10_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_10_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10_male_To_Orderings;


   procedure Add_age_11_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_11_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11_male_To_Orderings;


   procedure Add_age_12_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_12_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12_male_To_Orderings;


   procedure Add_age_13_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_13_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13_male_To_Orderings;


   procedure Add_age_14_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_14_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14_male_To_Orderings;


   procedure Add_age_15_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_15_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15_male_To_Orderings;


   procedure Add_age_16_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_16_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_male_To_Orderings;


   procedure Add_age_17_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_17_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17_male_To_Orderings;


   procedure Add_age_18_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_18_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18_male_To_Orderings;


   procedure Add_age_19_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_19_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19_male_To_Orderings;


   procedure Add_age_20_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_20_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_male_To_Orderings;


   procedure Add_age_21_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_21_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21_male_To_Orderings;


   procedure Add_age_22_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_22_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22_male_To_Orderings;


   procedure Add_age_23_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_23_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23_male_To_Orderings;


   procedure Add_age_24_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_24_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24_male_To_Orderings;


   procedure Add_age_25_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_25_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_male_To_Orderings;


   procedure Add_age_26_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_26_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26_male_To_Orderings;


   procedure Add_age_27_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_27_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27_male_To_Orderings;


   procedure Add_age_28_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_28_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28_male_To_Orderings;


   procedure Add_age_29_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_29_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29_male_To_Orderings;


   procedure Add_age_30_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_30_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_male_To_Orderings;


   procedure Add_age_31_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_31_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31_male_To_Orderings;


   procedure Add_age_32_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_32_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32_male_To_Orderings;


   procedure Add_age_33_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_33_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33_male_To_Orderings;


   procedure Add_age_34_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_34_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34_male_To_Orderings;


   procedure Add_age_35_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_35_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_male_To_Orderings;


   procedure Add_age_36_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_36_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36_male_To_Orderings;


   procedure Add_age_37_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_37_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37_male_To_Orderings;


   procedure Add_age_38_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_38_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38_male_To_Orderings;


   procedure Add_age_39_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_39_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39_male_To_Orderings;


   procedure Add_age_40_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_40_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_male_To_Orderings;


   procedure Add_age_41_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_41_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41_male_To_Orderings;


   procedure Add_age_42_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_42_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42_male_To_Orderings;


   procedure Add_age_43_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_43_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43_male_To_Orderings;


   procedure Add_age_44_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_44_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44_male_To_Orderings;


   procedure Add_age_45_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_45_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_male_To_Orderings;


   procedure Add_age_46_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_46_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46_male_To_Orderings;


   procedure Add_age_47_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_47_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47_male_To_Orderings;


   procedure Add_age_48_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_48_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48_male_To_Orderings;


   procedure Add_age_49_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_49_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49_male_To_Orderings;


   procedure Add_age_50_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_50_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_male_To_Orderings;


   procedure Add_age_51_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_51_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51_male_To_Orderings;


   procedure Add_age_52_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_52_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52_male_To_Orderings;


   procedure Add_age_53_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_53_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53_male_To_Orderings;


   procedure Add_age_54_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_54_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54_male_To_Orderings;


   procedure Add_age_55_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_55_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_male_To_Orderings;


   procedure Add_age_56_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_56_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56_male_To_Orderings;


   procedure Add_age_57_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_57_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57_male_To_Orderings;


   procedure Add_age_58_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_58_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58_male_To_Orderings;


   procedure Add_age_59_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_59_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59_male_To_Orderings;


   procedure Add_age_60_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_60_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_male_To_Orderings;


   procedure Add_age_61_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_61_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61_male_To_Orderings;


   procedure Add_age_62_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_62_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62_male_To_Orderings;


   procedure Add_age_63_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_63_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63_male_To_Orderings;


   procedure Add_age_64_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_64_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64_male_To_Orderings;


   procedure Add_age_65_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_65_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_male_To_Orderings;


   procedure Add_age_66_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_66_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66_male_To_Orderings;


   procedure Add_age_67_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_67_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67_male_To_Orderings;


   procedure Add_age_68_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_68_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68_male_To_Orderings;


   procedure Add_age_69_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_69_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69_male_To_Orderings;


   procedure Add_age_70_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_70_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_male_To_Orderings;


   procedure Add_age_71_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_71_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71_male_To_Orderings;


   procedure Add_age_72_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_72_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72_male_To_Orderings;


   procedure Add_age_73_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_73_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73_male_To_Orderings;


   procedure Add_age_74_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_74_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74_male_To_Orderings;


   procedure Add_age_75_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_75_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_male_To_Orderings;


   procedure Add_age_76_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_76_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76_male_To_Orderings;


   procedure Add_age_77_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_77_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77_male_To_Orderings;


   procedure Add_age_78_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_78_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78_male_To_Orderings;


   procedure Add_age_79_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_79_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79_male_To_Orderings;


   procedure Add_age_80_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_80_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80_male_To_Orderings;


   procedure Add_age_81_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_81_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81_male_To_Orderings;


   procedure Add_age_82_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_82_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82_male_To_Orderings;


   procedure Add_age_83_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_83_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83_male_To_Orderings;


   procedure Add_age_84_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_84_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84_male_To_Orderings;


   procedure Add_age_85_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_85_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85_male_To_Orderings;


   procedure Add_age_86_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_86_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86_male_To_Orderings;


   procedure Add_age_87_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_87_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87_male_To_Orderings;


   procedure Add_age_88_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_88_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88_male_To_Orderings;


   procedure Add_age_89_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_89_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89_male_To_Orderings;


   procedure Add_age_90_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_90_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90_male_To_Orderings;


   procedure Add_age_91_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_91_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91_male_To_Orderings;


   procedure Add_age_92_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_92_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92_male_To_Orderings;


   procedure Add_age_93_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_93_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93_male_To_Orderings;


   procedure Add_age_94_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_94_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94_male_To_Orderings;


   procedure Add_age_95_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_95_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95_male_To_Orderings;


   procedure Add_age_96_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_96_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96_male_To_Orderings;


   procedure Add_age_97_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_97_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97_male_To_Orderings;


   procedure Add_age_98_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_98_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98_male_To_Orderings;


   procedure Add_age_99_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_99_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99_male_To_Orderings;


   procedure Add_age_100_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_100_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100_male_To_Orderings;


   procedure Add_age_101_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_101_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101_male_To_Orderings;


   procedure Add_age_102_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_102_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102_male_To_Orderings;


   procedure Add_age_103_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_103_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103_male_To_Orderings;


   procedure Add_age_104_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_104_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104_male_To_Orderings;


   procedure Add_age_105_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_105_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105_male_To_Orderings;


   procedure Add_age_106_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_106_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106_male_To_Orderings;


   procedure Add_age_107_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_107_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107_male_To_Orderings;


   procedure Add_age_108_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_108_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108_male_To_Orderings;


   procedure Add_age_109_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_109_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109_male_To_Orderings;


   procedure Add_age_110_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_110_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110_male_To_Orderings;


   procedure Add_age_0_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_0_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0_female_To_Orderings;


   procedure Add_age_1_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_1_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1_female_To_Orderings;


   procedure Add_age_2_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_2_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2_female_To_Orderings;


   procedure Add_age_3_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_3_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3_female_To_Orderings;


   procedure Add_age_4_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_4_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4_female_To_Orderings;


   procedure Add_age_5_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_5_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5_female_To_Orderings;


   procedure Add_age_6_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_6_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6_female_To_Orderings;


   procedure Add_age_7_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_7_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7_female_To_Orderings;


   procedure Add_age_8_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_8_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8_female_To_Orderings;


   procedure Add_age_9_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_9_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9_female_To_Orderings;


   procedure Add_age_10_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_10_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10_female_To_Orderings;


   procedure Add_age_11_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_11_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11_female_To_Orderings;


   procedure Add_age_12_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_12_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12_female_To_Orderings;


   procedure Add_age_13_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_13_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13_female_To_Orderings;


   procedure Add_age_14_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_14_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14_female_To_Orderings;


   procedure Add_age_15_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_15_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15_female_To_Orderings;


   procedure Add_age_16_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_16_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_female_To_Orderings;


   procedure Add_age_17_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_17_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17_female_To_Orderings;


   procedure Add_age_18_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_18_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18_female_To_Orderings;


   procedure Add_age_19_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_19_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19_female_To_Orderings;


   procedure Add_age_20_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_20_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_female_To_Orderings;


   procedure Add_age_21_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_21_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21_female_To_Orderings;


   procedure Add_age_22_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_22_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22_female_To_Orderings;


   procedure Add_age_23_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_23_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23_female_To_Orderings;


   procedure Add_age_24_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_24_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24_female_To_Orderings;


   procedure Add_age_25_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_25_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_female_To_Orderings;


   procedure Add_age_26_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_26_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26_female_To_Orderings;


   procedure Add_age_27_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_27_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27_female_To_Orderings;


   procedure Add_age_28_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_28_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28_female_To_Orderings;


   procedure Add_age_29_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_29_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29_female_To_Orderings;


   procedure Add_age_30_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_30_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_female_To_Orderings;


   procedure Add_age_31_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_31_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31_female_To_Orderings;


   procedure Add_age_32_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_32_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32_female_To_Orderings;


   procedure Add_age_33_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_33_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33_female_To_Orderings;


   procedure Add_age_34_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_34_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34_female_To_Orderings;


   procedure Add_age_35_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_35_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_female_To_Orderings;


   procedure Add_age_36_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_36_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36_female_To_Orderings;


   procedure Add_age_37_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_37_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37_female_To_Orderings;


   procedure Add_age_38_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_38_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38_female_To_Orderings;


   procedure Add_age_39_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_39_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39_female_To_Orderings;


   procedure Add_age_40_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_40_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_female_To_Orderings;


   procedure Add_age_41_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_41_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41_female_To_Orderings;


   procedure Add_age_42_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_42_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42_female_To_Orderings;


   procedure Add_age_43_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_43_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43_female_To_Orderings;


   procedure Add_age_44_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_44_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44_female_To_Orderings;


   procedure Add_age_45_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_45_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_female_To_Orderings;


   procedure Add_age_46_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_46_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46_female_To_Orderings;


   procedure Add_age_47_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_47_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47_female_To_Orderings;


   procedure Add_age_48_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_48_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48_female_To_Orderings;


   procedure Add_age_49_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_49_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49_female_To_Orderings;


   procedure Add_age_50_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_50_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_female_To_Orderings;


   procedure Add_age_51_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_51_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51_female_To_Orderings;


   procedure Add_age_52_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_52_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52_female_To_Orderings;


   procedure Add_age_53_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_53_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53_female_To_Orderings;


   procedure Add_age_54_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_54_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54_female_To_Orderings;


   procedure Add_age_55_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_55_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_female_To_Orderings;


   procedure Add_age_56_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_56_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56_female_To_Orderings;


   procedure Add_age_57_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_57_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57_female_To_Orderings;


   procedure Add_age_58_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_58_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58_female_To_Orderings;


   procedure Add_age_59_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_59_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59_female_To_Orderings;


   procedure Add_age_60_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_60_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_female_To_Orderings;


   procedure Add_age_61_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_61_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61_female_To_Orderings;


   procedure Add_age_62_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_62_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62_female_To_Orderings;


   procedure Add_age_63_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_63_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63_female_To_Orderings;


   procedure Add_age_64_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_64_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64_female_To_Orderings;


   procedure Add_age_65_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_65_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_female_To_Orderings;


   procedure Add_age_66_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_66_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66_female_To_Orderings;


   procedure Add_age_67_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_67_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67_female_To_Orderings;


   procedure Add_age_68_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_68_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68_female_To_Orderings;


   procedure Add_age_69_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_69_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69_female_To_Orderings;


   procedure Add_age_70_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_70_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_female_To_Orderings;


   procedure Add_age_71_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_71_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71_female_To_Orderings;


   procedure Add_age_72_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_72_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72_female_To_Orderings;


   procedure Add_age_73_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_73_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73_female_To_Orderings;


   procedure Add_age_74_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_74_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74_female_To_Orderings;


   procedure Add_age_75_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_75_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_female_To_Orderings;


   procedure Add_age_76_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_76_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76_female_To_Orderings;


   procedure Add_age_77_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_77_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77_female_To_Orderings;


   procedure Add_age_78_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_78_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78_female_To_Orderings;


   procedure Add_age_79_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_79_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79_female_To_Orderings;


   procedure Add_age_80_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_80_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80_female_To_Orderings;


   procedure Add_age_81_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_81_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81_female_To_Orderings;


   procedure Add_age_82_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_82_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82_female_To_Orderings;


   procedure Add_age_83_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_83_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83_female_To_Orderings;


   procedure Add_age_84_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_84_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84_female_To_Orderings;


   procedure Add_age_85_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_85_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85_female_To_Orderings;


   procedure Add_age_86_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_86_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86_female_To_Orderings;


   procedure Add_age_87_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_87_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87_female_To_Orderings;


   procedure Add_age_88_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_88_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88_female_To_Orderings;


   procedure Add_age_89_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_89_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89_female_To_Orderings;


   procedure Add_age_90_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_90_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90_female_To_Orderings;


   procedure Add_age_91_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_91_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91_female_To_Orderings;


   procedure Add_age_92_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_92_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92_female_To_Orderings;


   procedure Add_age_93_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_93_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93_female_To_Orderings;


   procedure Add_age_94_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_94_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94_female_To_Orderings;


   procedure Add_age_95_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_95_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95_female_To_Orderings;


   procedure Add_age_96_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_96_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96_female_To_Orderings;


   procedure Add_age_97_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_97_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97_female_To_Orderings;


   procedure Add_age_98_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_98_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98_female_To_Orderings;


   procedure Add_age_99_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_99_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99_female_To_Orderings;


   procedure Add_age_100_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_100_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100_female_To_Orderings;


   procedure Add_age_101_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_101_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101_female_To_Orderings;


   procedure Add_age_102_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_102_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102_female_To_Orderings;


   procedure Add_age_103_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_103_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103_female_To_Orderings;


   procedure Add_age_104_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_104_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104_female_To_Orderings;


   procedure Add_age_105_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_105_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105_female_To_Orderings;


   procedure Add_age_106_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_106_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106_female_To_Orderings;


   procedure Add_age_107_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_107_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107_female_To_Orderings;


   procedure Add_age_108_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_108_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108_female_To_Orderings;


   procedure Add_age_109_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_109_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109_female_To_Orderings;


   procedure Add_age_110_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_110_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110_female_To_Orderings;


   procedure Add_participation_16_19_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_16_19_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_16_19_male_To_Orderings;


   procedure Add_participation_20_24_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_20_24_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_20_24_male_To_Orderings;


   procedure Add_participation_25_29_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_25_29_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_25_29_male_To_Orderings;


   procedure Add_participation_30_34_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_30_34_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_30_34_male_To_Orderings;


   procedure Add_participation_35_39_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_35_39_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_35_39_male_To_Orderings;


   procedure Add_participation_40_44_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_40_44_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_40_44_male_To_Orderings;


   procedure Add_participation_45_49_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_45_49_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_45_49_male_To_Orderings;


   procedure Add_participation_50_54_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_50_54_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_50_54_male_To_Orderings;


   procedure Add_participation_55_59_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_55_59_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_55_59_male_To_Orderings;


   procedure Add_participation_60_64_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_60_64_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_60_64_male_To_Orderings;


   procedure Add_participation_65_69_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_65_69_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_65_69_male_To_Orderings;


   procedure Add_participation_70_74_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_70_74_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_70_74_male_To_Orderings;


   procedure Add_participation_75_plus_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_75_plus_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_75_plus_male_To_Orderings;


   procedure Add_participation_16_19_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_16_19_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_16_19_female_To_Orderings;


   procedure Add_participation_20_24_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_20_24_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_20_24_female_To_Orderings;


   procedure Add_participation_25_29_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_25_29_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_25_29_female_To_Orderings;


   procedure Add_participation_30_34_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_30_34_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_30_34_female_To_Orderings;


   procedure Add_participation_35_39_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_35_39_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_35_39_female_To_Orderings;


   procedure Add_participation_40_44_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_40_44_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_40_44_female_To_Orderings;


   procedure Add_participation_45_49_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_45_49_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_45_49_female_To_Orderings;


   procedure Add_participation_50_54_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_50_54_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_50_54_female_To_Orderings;


   procedure Add_participation_55_59_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_55_59_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_55_59_female_To_Orderings;


   procedure Add_participation_60_64_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_60_64_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_60_64_female_To_Orderings;


   procedure Add_participation_65_69_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_65_69_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_65_69_female_To_Orderings;


   procedure Add_participation_70_74_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_70_74_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_70_74_female_To_Orderings;


   procedure Add_participation_75_plus_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_75_plus_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_75_plus_female_To_Orderings;


   procedure Add_one_adult_hh_wales_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_hh_wales", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_wales_To_Orderings;


   procedure Add_two_adult_hhs_wales_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "two_adult_hhs_wales", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_wales_To_Orderings;


   procedure Add_other_hh_wales_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "other_hh_wales", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_wales_To_Orderings;


   procedure Add_one_adult_hh_nireland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_hh_nireland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_nireland_To_Orderings;


   procedure Add_two_adult_hhs_nireland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "two_adult_hhs_nireland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_nireland_To_Orderings;


   procedure Add_other_hh_nireland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "other_hh_nireland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_nireland_To_Orderings;


   procedure Add_one_adult_hh_england_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_hh_england", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_england_To_Orderings;


   procedure Add_two_adult_hhs_england_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "two_adult_hhs_england", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_england_To_Orderings;


   procedure Add_other_hh_england_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "other_hh_england", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_england_To_Orderings;


   procedure Add_one_adult_hh_scotland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_hh_scotland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_hh_scotland_To_Orderings;


   procedure Add_two_adult_hhs_scotland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "two_adult_hhs_scotland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adult_hhs_scotland_To_Orderings;


   procedure Add_other_hh_scotland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "other_hh_scotland", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_other_hh_scotland_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Target_Dataset_IO;
