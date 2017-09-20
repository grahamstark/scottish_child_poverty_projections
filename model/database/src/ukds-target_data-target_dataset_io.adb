--
-- Created by ada_generator.py on 2017-09-20 15:38:47.975501
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
         "run_id, user_id, year, sernum, household_one_adult_male, household_one_adult_female, household_two_adults, household_one_adult_one_child, household_one_adult_two_plus_children, household_two_plus_adult_one_plus_children," &
         "household_three_plus_person_all_adult, household_all_households, male, female, employed, employee, ilo_unemployed, jsa_claimant, age_0_male, age_1_male," &
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
         "age_0, age_1, age_2, age_3, age_4, age_5, age_6, age_7, age_8, age_9," &
         "age_10, age_11, age_12, age_13, age_14, age_15, age_16, age_17, age_18, age_19," &
         "age_20, age_21, age_22, age_23, age_24, age_25, age_26, age_27, age_28, age_29," &
         "age_30, age_31, age_32, age_33, age_34, age_35, age_36, age_37, age_38, age_39," &
         "age_40, age_41, age_42, age_43, age_44, age_45, age_46, age_47, age_48, age_49," &
         "age_50, age_51, age_52, age_53, age_54, age_55, age_56, age_57, age_58, age_59," &
         "age_60, age_61, age_62, age_63, age_64, age_65, age_66, age_67, age_68, age_69," &
         "age_70, age_71, age_72, age_73, age_74, age_75, age_76, age_77, age_78, age_79," &
         "age_80, age_81, age_82, age_83, age_84, age_85, age_86, age_87, age_88, age_89," &
         "age_90, age_91, age_92, age_93, age_94, age_95, age_96, age_97, age_98, age_99," &
         "age_100, age_101, age_102, age_103, age_104, age_105, age_106, age_107, age_108, age_109," &
         "age_110 " &
         " from target_data.target_dataset " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.target_dataset (" &
         "run_id, user_id, year, sernum, household_one_adult_male, household_one_adult_female, household_two_adults, household_one_adult_one_child, household_one_adult_two_plus_children, household_two_plus_adult_one_plus_children," &
         "household_three_plus_person_all_adult, household_all_households, male, female, employed, employee, ilo_unemployed, jsa_claimant, age_0_male, age_1_male," &
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
         "age_0, age_1, age_2, age_3, age_4, age_5, age_6, age_7, age_8, age_9," &
         "age_10, age_11, age_12, age_13, age_14, age_15, age_16, age_17, age_18, age_19," &
         "age_20, age_21, age_22, age_23, age_24, age_25, age_26, age_27, age_28, age_29," &
         "age_30, age_31, age_32, age_33, age_34, age_35, age_36, age_37, age_38, age_39," &
         "age_40, age_41, age_42, age_43, age_44, age_45, age_46, age_47, age_48, age_49," &
         "age_50, age_51, age_52, age_53, age_54, age_55, age_56, age_57, age_58, age_59," &
         "age_60, age_61, age_62, age_63, age_64, age_65, age_66, age_67, age_68, age_69," &
         "age_70, age_71, age_72, age_73, age_74, age_75, age_76, age_77, age_78, age_79," &
         "age_80, age_81, age_82, age_83, age_84, age_85, age_86, age_87, age_88, age_89," &
         "age_90, age_91, age_92, age_93, age_94, age_95, age_96, age_97, age_98, age_99," &
         "age_100, age_101, age_102, age_103, age_104, age_105, age_106, age_107, age_108, age_109," &
         "age_110 " &
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
      params : constant SQL_Parameters( 1 .. 351 ) := ( if update_order then (
            1 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_male (Amount)
            2 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_female (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : household_two_adults (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_one_child (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_two_plus_children (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : household_two_plus_adult_one_plus_children (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : household_three_plus_person_all_adult (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : household_all_households (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : male (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : female (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : employed (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : employee (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployed (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : jsa_claimant (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : age_0_male (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : age_1_male (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : age_2_male (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : age_3_male (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : age_4_male (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : age_5_male (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : age_6_male (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : age_7_male (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : age_8_male (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : age_9_male (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : age_10_male (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : age_11_male (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : age_12_male (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : age_13_male (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : age_14_male (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : age_15_male (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : age_16_male (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : age_17_male (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : age_18_male (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : age_19_male (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : age_20_male (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : age_21_male (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : age_22_male (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : age_23_male (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : age_24_male (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : age_25_male (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : age_26_male (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : age_27_male (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : age_28_male (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : age_29_male (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : age_30_male (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : age_31_male (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : age_32_male (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : age_33_male (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : age_34_male (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : age_35_male (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : age_36_male (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : age_37_male (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : age_38_male (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : age_39_male (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : age_40_male (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : age_41_male (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : age_42_male (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : age_43_male (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : age_44_male (Amount)
           60 => ( Parameter_Float, 0.0 ),   --  : age_45_male (Amount)
           61 => ( Parameter_Float, 0.0 ),   --  : age_46_male (Amount)
           62 => ( Parameter_Float, 0.0 ),   --  : age_47_male (Amount)
           63 => ( Parameter_Float, 0.0 ),   --  : age_48_male (Amount)
           64 => ( Parameter_Float, 0.0 ),   --  : age_49_male (Amount)
           65 => ( Parameter_Float, 0.0 ),   --  : age_50_male (Amount)
           66 => ( Parameter_Float, 0.0 ),   --  : age_51_male (Amount)
           67 => ( Parameter_Float, 0.0 ),   --  : age_52_male (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : age_53_male (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : age_54_male (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : age_55_male (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : age_56_male (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : age_57_male (Amount)
           73 => ( Parameter_Float, 0.0 ),   --  : age_58_male (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : age_59_male (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : age_60_male (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : age_61_male (Amount)
           77 => ( Parameter_Float, 0.0 ),   --  : age_62_male (Amount)
           78 => ( Parameter_Float, 0.0 ),   --  : age_63_male (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : age_64_male (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : age_65_male (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : age_66_male (Amount)
           82 => ( Parameter_Float, 0.0 ),   --  : age_67_male (Amount)
           83 => ( Parameter_Float, 0.0 ),   --  : age_68_male (Amount)
           84 => ( Parameter_Float, 0.0 ),   --  : age_69_male (Amount)
           85 => ( Parameter_Float, 0.0 ),   --  : age_70_male (Amount)
           86 => ( Parameter_Float, 0.0 ),   --  : age_71_male (Amount)
           87 => ( Parameter_Float, 0.0 ),   --  : age_72_male (Amount)
           88 => ( Parameter_Float, 0.0 ),   --  : age_73_male (Amount)
           89 => ( Parameter_Float, 0.0 ),   --  : age_74_male (Amount)
           90 => ( Parameter_Float, 0.0 ),   --  : age_75_male (Amount)
           91 => ( Parameter_Float, 0.0 ),   --  : age_76_male (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : age_77_male (Amount)
           93 => ( Parameter_Float, 0.0 ),   --  : age_78_male (Amount)
           94 => ( Parameter_Float, 0.0 ),   --  : age_79_male (Amount)
           95 => ( Parameter_Float, 0.0 ),   --  : age_80_male (Amount)
           96 => ( Parameter_Float, 0.0 ),   --  : age_81_male (Amount)
           97 => ( Parameter_Float, 0.0 ),   --  : age_82_male (Amount)
           98 => ( Parameter_Float, 0.0 ),   --  : age_83_male (Amount)
           99 => ( Parameter_Float, 0.0 ),   --  : age_84_male (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : age_85_male (Amount)
           101 => ( Parameter_Float, 0.0 ),   --  : age_86_male (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : age_87_male (Amount)
           103 => ( Parameter_Float, 0.0 ),   --  : age_88_male (Amount)
           104 => ( Parameter_Float, 0.0 ),   --  : age_89_male (Amount)
           105 => ( Parameter_Float, 0.0 ),   --  : age_90_male (Amount)
           106 => ( Parameter_Float, 0.0 ),   --  : age_91_male (Amount)
           107 => ( Parameter_Float, 0.0 ),   --  : age_92_male (Amount)
           108 => ( Parameter_Float, 0.0 ),   --  : age_93_male (Amount)
           109 => ( Parameter_Float, 0.0 ),   --  : age_94_male (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : age_95_male (Amount)
           111 => ( Parameter_Float, 0.0 ),   --  : age_96_male (Amount)
           112 => ( Parameter_Float, 0.0 ),   --  : age_97_male (Amount)
           113 => ( Parameter_Float, 0.0 ),   --  : age_98_male (Amount)
           114 => ( Parameter_Float, 0.0 ),   --  : age_99_male (Amount)
           115 => ( Parameter_Float, 0.0 ),   --  : age_100_male (Amount)
           116 => ( Parameter_Float, 0.0 ),   --  : age_101_male (Amount)
           117 => ( Parameter_Float, 0.0 ),   --  : age_102_male (Amount)
           118 => ( Parameter_Float, 0.0 ),   --  : age_103_male (Amount)
           119 => ( Parameter_Float, 0.0 ),   --  : age_104_male (Amount)
           120 => ( Parameter_Float, 0.0 ),   --  : age_105_male (Amount)
           121 => ( Parameter_Float, 0.0 ),   --  : age_106_male (Amount)
           122 => ( Parameter_Float, 0.0 ),   --  : age_107_male (Amount)
           123 => ( Parameter_Float, 0.0 ),   --  : age_108_male (Amount)
           124 => ( Parameter_Float, 0.0 ),   --  : age_109_male (Amount)
           125 => ( Parameter_Float, 0.0 ),   --  : age_110_male (Amount)
           126 => ( Parameter_Float, 0.0 ),   --  : age_0_female (Amount)
           127 => ( Parameter_Float, 0.0 ),   --  : age_1_female (Amount)
           128 => ( Parameter_Float, 0.0 ),   --  : age_2_female (Amount)
           129 => ( Parameter_Float, 0.0 ),   --  : age_3_female (Amount)
           130 => ( Parameter_Float, 0.0 ),   --  : age_4_female (Amount)
           131 => ( Parameter_Float, 0.0 ),   --  : age_5_female (Amount)
           132 => ( Parameter_Float, 0.0 ),   --  : age_6_female (Amount)
           133 => ( Parameter_Float, 0.0 ),   --  : age_7_female (Amount)
           134 => ( Parameter_Float, 0.0 ),   --  : age_8_female (Amount)
           135 => ( Parameter_Float, 0.0 ),   --  : age_9_female (Amount)
           136 => ( Parameter_Float, 0.0 ),   --  : age_10_female (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : age_11_female (Amount)
           138 => ( Parameter_Float, 0.0 ),   --  : age_12_female (Amount)
           139 => ( Parameter_Float, 0.0 ),   --  : age_13_female (Amount)
           140 => ( Parameter_Float, 0.0 ),   --  : age_14_female (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : age_15_female (Amount)
           142 => ( Parameter_Float, 0.0 ),   --  : age_16_female (Amount)
           143 => ( Parameter_Float, 0.0 ),   --  : age_17_female (Amount)
           144 => ( Parameter_Float, 0.0 ),   --  : age_18_female (Amount)
           145 => ( Parameter_Float, 0.0 ),   --  : age_19_female (Amount)
           146 => ( Parameter_Float, 0.0 ),   --  : age_20_female (Amount)
           147 => ( Parameter_Float, 0.0 ),   --  : age_21_female (Amount)
           148 => ( Parameter_Float, 0.0 ),   --  : age_22_female (Amount)
           149 => ( Parameter_Float, 0.0 ),   --  : age_23_female (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : age_24_female (Amount)
           151 => ( Parameter_Float, 0.0 ),   --  : age_25_female (Amount)
           152 => ( Parameter_Float, 0.0 ),   --  : age_26_female (Amount)
           153 => ( Parameter_Float, 0.0 ),   --  : age_27_female (Amount)
           154 => ( Parameter_Float, 0.0 ),   --  : age_28_female (Amount)
           155 => ( Parameter_Float, 0.0 ),   --  : age_29_female (Amount)
           156 => ( Parameter_Float, 0.0 ),   --  : age_30_female (Amount)
           157 => ( Parameter_Float, 0.0 ),   --  : age_31_female (Amount)
           158 => ( Parameter_Float, 0.0 ),   --  : age_32_female (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : age_33_female (Amount)
           160 => ( Parameter_Float, 0.0 ),   --  : age_34_female (Amount)
           161 => ( Parameter_Float, 0.0 ),   --  : age_35_female (Amount)
           162 => ( Parameter_Float, 0.0 ),   --  : age_36_female (Amount)
           163 => ( Parameter_Float, 0.0 ),   --  : age_37_female (Amount)
           164 => ( Parameter_Float, 0.0 ),   --  : age_38_female (Amount)
           165 => ( Parameter_Float, 0.0 ),   --  : age_39_female (Amount)
           166 => ( Parameter_Float, 0.0 ),   --  : age_40_female (Amount)
           167 => ( Parameter_Float, 0.0 ),   --  : age_41_female (Amount)
           168 => ( Parameter_Float, 0.0 ),   --  : age_42_female (Amount)
           169 => ( Parameter_Float, 0.0 ),   --  : age_43_female (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : age_44_female (Amount)
           171 => ( Parameter_Float, 0.0 ),   --  : age_45_female (Amount)
           172 => ( Parameter_Float, 0.0 ),   --  : age_46_female (Amount)
           173 => ( Parameter_Float, 0.0 ),   --  : age_47_female (Amount)
           174 => ( Parameter_Float, 0.0 ),   --  : age_48_female (Amount)
           175 => ( Parameter_Float, 0.0 ),   --  : age_49_female (Amount)
           176 => ( Parameter_Float, 0.0 ),   --  : age_50_female (Amount)
           177 => ( Parameter_Float, 0.0 ),   --  : age_51_female (Amount)
           178 => ( Parameter_Float, 0.0 ),   --  : age_52_female (Amount)
           179 => ( Parameter_Float, 0.0 ),   --  : age_53_female (Amount)
           180 => ( Parameter_Float, 0.0 ),   --  : age_54_female (Amount)
           181 => ( Parameter_Float, 0.0 ),   --  : age_55_female (Amount)
           182 => ( Parameter_Float, 0.0 ),   --  : age_56_female (Amount)
           183 => ( Parameter_Float, 0.0 ),   --  : age_57_female (Amount)
           184 => ( Parameter_Float, 0.0 ),   --  : age_58_female (Amount)
           185 => ( Parameter_Float, 0.0 ),   --  : age_59_female (Amount)
           186 => ( Parameter_Float, 0.0 ),   --  : age_60_female (Amount)
           187 => ( Parameter_Float, 0.0 ),   --  : age_61_female (Amount)
           188 => ( Parameter_Float, 0.0 ),   --  : age_62_female (Amount)
           189 => ( Parameter_Float, 0.0 ),   --  : age_63_female (Amount)
           190 => ( Parameter_Float, 0.0 ),   --  : age_64_female (Amount)
           191 => ( Parameter_Float, 0.0 ),   --  : age_65_female (Amount)
           192 => ( Parameter_Float, 0.0 ),   --  : age_66_female (Amount)
           193 => ( Parameter_Float, 0.0 ),   --  : age_67_female (Amount)
           194 => ( Parameter_Float, 0.0 ),   --  : age_68_female (Amount)
           195 => ( Parameter_Float, 0.0 ),   --  : age_69_female (Amount)
           196 => ( Parameter_Float, 0.0 ),   --  : age_70_female (Amount)
           197 => ( Parameter_Float, 0.0 ),   --  : age_71_female (Amount)
           198 => ( Parameter_Float, 0.0 ),   --  : age_72_female (Amount)
           199 => ( Parameter_Float, 0.0 ),   --  : age_73_female (Amount)
           200 => ( Parameter_Float, 0.0 ),   --  : age_74_female (Amount)
           201 => ( Parameter_Float, 0.0 ),   --  : age_75_female (Amount)
           202 => ( Parameter_Float, 0.0 ),   --  : age_76_female (Amount)
           203 => ( Parameter_Float, 0.0 ),   --  : age_77_female (Amount)
           204 => ( Parameter_Float, 0.0 ),   --  : age_78_female (Amount)
           205 => ( Parameter_Float, 0.0 ),   --  : age_79_female (Amount)
           206 => ( Parameter_Float, 0.0 ),   --  : age_80_female (Amount)
           207 => ( Parameter_Float, 0.0 ),   --  : age_81_female (Amount)
           208 => ( Parameter_Float, 0.0 ),   --  : age_82_female (Amount)
           209 => ( Parameter_Float, 0.0 ),   --  : age_83_female (Amount)
           210 => ( Parameter_Float, 0.0 ),   --  : age_84_female (Amount)
           211 => ( Parameter_Float, 0.0 ),   --  : age_85_female (Amount)
           212 => ( Parameter_Float, 0.0 ),   --  : age_86_female (Amount)
           213 => ( Parameter_Float, 0.0 ),   --  : age_87_female (Amount)
           214 => ( Parameter_Float, 0.0 ),   --  : age_88_female (Amount)
           215 => ( Parameter_Float, 0.0 ),   --  : age_89_female (Amount)
           216 => ( Parameter_Float, 0.0 ),   --  : age_90_female (Amount)
           217 => ( Parameter_Float, 0.0 ),   --  : age_91_female (Amount)
           218 => ( Parameter_Float, 0.0 ),   --  : age_92_female (Amount)
           219 => ( Parameter_Float, 0.0 ),   --  : age_93_female (Amount)
           220 => ( Parameter_Float, 0.0 ),   --  : age_94_female (Amount)
           221 => ( Parameter_Float, 0.0 ),   --  : age_95_female (Amount)
           222 => ( Parameter_Float, 0.0 ),   --  : age_96_female (Amount)
           223 => ( Parameter_Float, 0.0 ),   --  : age_97_female (Amount)
           224 => ( Parameter_Float, 0.0 ),   --  : age_98_female (Amount)
           225 => ( Parameter_Float, 0.0 ),   --  : age_99_female (Amount)
           226 => ( Parameter_Float, 0.0 ),   --  : age_100_female (Amount)
           227 => ( Parameter_Float, 0.0 ),   --  : age_101_female (Amount)
           228 => ( Parameter_Float, 0.0 ),   --  : age_102_female (Amount)
           229 => ( Parameter_Float, 0.0 ),   --  : age_103_female (Amount)
           230 => ( Parameter_Float, 0.0 ),   --  : age_104_female (Amount)
           231 => ( Parameter_Float, 0.0 ),   --  : age_105_female (Amount)
           232 => ( Parameter_Float, 0.0 ),   --  : age_106_female (Amount)
           233 => ( Parameter_Float, 0.0 ),   --  : age_107_female (Amount)
           234 => ( Parameter_Float, 0.0 ),   --  : age_108_female (Amount)
           235 => ( Parameter_Float, 0.0 ),   --  : age_109_female (Amount)
           236 => ( Parameter_Float, 0.0 ),   --  : age_110_female (Amount)
           237 => ( Parameter_Float, 0.0 ),   --  : age_0 (Amount)
           238 => ( Parameter_Float, 0.0 ),   --  : age_1 (Amount)
           239 => ( Parameter_Float, 0.0 ),   --  : age_2 (Amount)
           240 => ( Parameter_Float, 0.0 ),   --  : age_3 (Amount)
           241 => ( Parameter_Float, 0.0 ),   --  : age_4 (Amount)
           242 => ( Parameter_Float, 0.0 ),   --  : age_5 (Amount)
           243 => ( Parameter_Float, 0.0 ),   --  : age_6 (Amount)
           244 => ( Parameter_Float, 0.0 ),   --  : age_7 (Amount)
           245 => ( Parameter_Float, 0.0 ),   --  : age_8 (Amount)
           246 => ( Parameter_Float, 0.0 ),   --  : age_9 (Amount)
           247 => ( Parameter_Float, 0.0 ),   --  : age_10 (Amount)
           248 => ( Parameter_Float, 0.0 ),   --  : age_11 (Amount)
           249 => ( Parameter_Float, 0.0 ),   --  : age_12 (Amount)
           250 => ( Parameter_Float, 0.0 ),   --  : age_13 (Amount)
           251 => ( Parameter_Float, 0.0 ),   --  : age_14 (Amount)
           252 => ( Parameter_Float, 0.0 ),   --  : age_15 (Amount)
           253 => ( Parameter_Float, 0.0 ),   --  : age_16 (Amount)
           254 => ( Parameter_Float, 0.0 ),   --  : age_17 (Amount)
           255 => ( Parameter_Float, 0.0 ),   --  : age_18 (Amount)
           256 => ( Parameter_Float, 0.0 ),   --  : age_19 (Amount)
           257 => ( Parameter_Float, 0.0 ),   --  : age_20 (Amount)
           258 => ( Parameter_Float, 0.0 ),   --  : age_21 (Amount)
           259 => ( Parameter_Float, 0.0 ),   --  : age_22 (Amount)
           260 => ( Parameter_Float, 0.0 ),   --  : age_23 (Amount)
           261 => ( Parameter_Float, 0.0 ),   --  : age_24 (Amount)
           262 => ( Parameter_Float, 0.0 ),   --  : age_25 (Amount)
           263 => ( Parameter_Float, 0.0 ),   --  : age_26 (Amount)
           264 => ( Parameter_Float, 0.0 ),   --  : age_27 (Amount)
           265 => ( Parameter_Float, 0.0 ),   --  : age_28 (Amount)
           266 => ( Parameter_Float, 0.0 ),   --  : age_29 (Amount)
           267 => ( Parameter_Float, 0.0 ),   --  : age_30 (Amount)
           268 => ( Parameter_Float, 0.0 ),   --  : age_31 (Amount)
           269 => ( Parameter_Float, 0.0 ),   --  : age_32 (Amount)
           270 => ( Parameter_Float, 0.0 ),   --  : age_33 (Amount)
           271 => ( Parameter_Float, 0.0 ),   --  : age_34 (Amount)
           272 => ( Parameter_Float, 0.0 ),   --  : age_35 (Amount)
           273 => ( Parameter_Float, 0.0 ),   --  : age_36 (Amount)
           274 => ( Parameter_Float, 0.0 ),   --  : age_37 (Amount)
           275 => ( Parameter_Float, 0.0 ),   --  : age_38 (Amount)
           276 => ( Parameter_Float, 0.0 ),   --  : age_39 (Amount)
           277 => ( Parameter_Float, 0.0 ),   --  : age_40 (Amount)
           278 => ( Parameter_Float, 0.0 ),   --  : age_41 (Amount)
           279 => ( Parameter_Float, 0.0 ),   --  : age_42 (Amount)
           280 => ( Parameter_Float, 0.0 ),   --  : age_43 (Amount)
           281 => ( Parameter_Float, 0.0 ),   --  : age_44 (Amount)
           282 => ( Parameter_Float, 0.0 ),   --  : age_45 (Amount)
           283 => ( Parameter_Float, 0.0 ),   --  : age_46 (Amount)
           284 => ( Parameter_Float, 0.0 ),   --  : age_47 (Amount)
           285 => ( Parameter_Float, 0.0 ),   --  : age_48 (Amount)
           286 => ( Parameter_Float, 0.0 ),   --  : age_49 (Amount)
           287 => ( Parameter_Float, 0.0 ),   --  : age_50 (Amount)
           288 => ( Parameter_Float, 0.0 ),   --  : age_51 (Amount)
           289 => ( Parameter_Float, 0.0 ),   --  : age_52 (Amount)
           290 => ( Parameter_Float, 0.0 ),   --  : age_53 (Amount)
           291 => ( Parameter_Float, 0.0 ),   --  : age_54 (Amount)
           292 => ( Parameter_Float, 0.0 ),   --  : age_55 (Amount)
           293 => ( Parameter_Float, 0.0 ),   --  : age_56 (Amount)
           294 => ( Parameter_Float, 0.0 ),   --  : age_57 (Amount)
           295 => ( Parameter_Float, 0.0 ),   --  : age_58 (Amount)
           296 => ( Parameter_Float, 0.0 ),   --  : age_59 (Amount)
           297 => ( Parameter_Float, 0.0 ),   --  : age_60 (Amount)
           298 => ( Parameter_Float, 0.0 ),   --  : age_61 (Amount)
           299 => ( Parameter_Float, 0.0 ),   --  : age_62 (Amount)
           300 => ( Parameter_Float, 0.0 ),   --  : age_63 (Amount)
           301 => ( Parameter_Float, 0.0 ),   --  : age_64 (Amount)
           302 => ( Parameter_Float, 0.0 ),   --  : age_65 (Amount)
           303 => ( Parameter_Float, 0.0 ),   --  : age_66 (Amount)
           304 => ( Parameter_Float, 0.0 ),   --  : age_67 (Amount)
           305 => ( Parameter_Float, 0.0 ),   --  : age_68 (Amount)
           306 => ( Parameter_Float, 0.0 ),   --  : age_69 (Amount)
           307 => ( Parameter_Float, 0.0 ),   --  : age_70 (Amount)
           308 => ( Parameter_Float, 0.0 ),   --  : age_71 (Amount)
           309 => ( Parameter_Float, 0.0 ),   --  : age_72 (Amount)
           310 => ( Parameter_Float, 0.0 ),   --  : age_73 (Amount)
           311 => ( Parameter_Float, 0.0 ),   --  : age_74 (Amount)
           312 => ( Parameter_Float, 0.0 ),   --  : age_75 (Amount)
           313 => ( Parameter_Float, 0.0 ),   --  : age_76 (Amount)
           314 => ( Parameter_Float, 0.0 ),   --  : age_77 (Amount)
           315 => ( Parameter_Float, 0.0 ),   --  : age_78 (Amount)
           316 => ( Parameter_Float, 0.0 ),   --  : age_79 (Amount)
           317 => ( Parameter_Float, 0.0 ),   --  : age_80 (Amount)
           318 => ( Parameter_Float, 0.0 ),   --  : age_81 (Amount)
           319 => ( Parameter_Float, 0.0 ),   --  : age_82 (Amount)
           320 => ( Parameter_Float, 0.0 ),   --  : age_83 (Amount)
           321 => ( Parameter_Float, 0.0 ),   --  : age_84 (Amount)
           322 => ( Parameter_Float, 0.0 ),   --  : age_85 (Amount)
           323 => ( Parameter_Float, 0.0 ),   --  : age_86 (Amount)
           324 => ( Parameter_Float, 0.0 ),   --  : age_87 (Amount)
           325 => ( Parameter_Float, 0.0 ),   --  : age_88 (Amount)
           326 => ( Parameter_Float, 0.0 ),   --  : age_89 (Amount)
           327 => ( Parameter_Float, 0.0 ),   --  : age_90 (Amount)
           328 => ( Parameter_Float, 0.0 ),   --  : age_91 (Amount)
           329 => ( Parameter_Float, 0.0 ),   --  : age_92 (Amount)
           330 => ( Parameter_Float, 0.0 ),   --  : age_93 (Amount)
           331 => ( Parameter_Float, 0.0 ),   --  : age_94 (Amount)
           332 => ( Parameter_Float, 0.0 ),   --  : age_95 (Amount)
           333 => ( Parameter_Float, 0.0 ),   --  : age_96 (Amount)
           334 => ( Parameter_Float, 0.0 ),   --  : age_97 (Amount)
           335 => ( Parameter_Float, 0.0 ),   --  : age_98 (Amount)
           336 => ( Parameter_Float, 0.0 ),   --  : age_99 (Amount)
           337 => ( Parameter_Float, 0.0 ),   --  : age_100 (Amount)
           338 => ( Parameter_Float, 0.0 ),   --  : age_101 (Amount)
           339 => ( Parameter_Float, 0.0 ),   --  : age_102 (Amount)
           340 => ( Parameter_Float, 0.0 ),   --  : age_103 (Amount)
           341 => ( Parameter_Float, 0.0 ),   --  : age_104 (Amount)
           342 => ( Parameter_Float, 0.0 ),   --  : age_105 (Amount)
           343 => ( Parameter_Float, 0.0 ),   --  : age_106 (Amount)
           344 => ( Parameter_Float, 0.0 ),   --  : age_107 (Amount)
           345 => ( Parameter_Float, 0.0 ),   --  : age_108 (Amount)
           346 => ( Parameter_Float, 0.0 ),   --  : age_109 (Amount)
           347 => ( Parameter_Float, 0.0 ),   --  : age_110 (Amount)
           348 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           351 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_male (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_female (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : household_two_adults (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_one_child (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : household_one_adult_two_plus_children (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : household_two_plus_adult_one_plus_children (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : household_three_plus_person_all_adult (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : household_all_households (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : male (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : female (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : employed (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : employee (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployed (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : jsa_claimant (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : age_0_male (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : age_1_male (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : age_2_male (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : age_3_male (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : age_4_male (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : age_5_male (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : age_6_male (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : age_7_male (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : age_8_male (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : age_9_male (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : age_10_male (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : age_11_male (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : age_12_male (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : age_13_male (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : age_14_male (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : age_15_male (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : age_16_male (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : age_17_male (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : age_18_male (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : age_19_male (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : age_20_male (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : age_21_male (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : age_22_male (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : age_23_male (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : age_24_male (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : age_25_male (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : age_26_male (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : age_27_male (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : age_28_male (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : age_29_male (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : age_30_male (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : age_31_male (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : age_32_male (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : age_33_male (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : age_34_male (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : age_35_male (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : age_36_male (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : age_37_male (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : age_38_male (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : age_39_male (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : age_40_male (Amount)
           60 => ( Parameter_Float, 0.0 ),   --  : age_41_male (Amount)
           61 => ( Parameter_Float, 0.0 ),   --  : age_42_male (Amount)
           62 => ( Parameter_Float, 0.0 ),   --  : age_43_male (Amount)
           63 => ( Parameter_Float, 0.0 ),   --  : age_44_male (Amount)
           64 => ( Parameter_Float, 0.0 ),   --  : age_45_male (Amount)
           65 => ( Parameter_Float, 0.0 ),   --  : age_46_male (Amount)
           66 => ( Parameter_Float, 0.0 ),   --  : age_47_male (Amount)
           67 => ( Parameter_Float, 0.0 ),   --  : age_48_male (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : age_49_male (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : age_50_male (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : age_51_male (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : age_52_male (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : age_53_male (Amount)
           73 => ( Parameter_Float, 0.0 ),   --  : age_54_male (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : age_55_male (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : age_56_male (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : age_57_male (Amount)
           77 => ( Parameter_Float, 0.0 ),   --  : age_58_male (Amount)
           78 => ( Parameter_Float, 0.0 ),   --  : age_59_male (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : age_60_male (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : age_61_male (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : age_62_male (Amount)
           82 => ( Parameter_Float, 0.0 ),   --  : age_63_male (Amount)
           83 => ( Parameter_Float, 0.0 ),   --  : age_64_male (Amount)
           84 => ( Parameter_Float, 0.0 ),   --  : age_65_male (Amount)
           85 => ( Parameter_Float, 0.0 ),   --  : age_66_male (Amount)
           86 => ( Parameter_Float, 0.0 ),   --  : age_67_male (Amount)
           87 => ( Parameter_Float, 0.0 ),   --  : age_68_male (Amount)
           88 => ( Parameter_Float, 0.0 ),   --  : age_69_male (Amount)
           89 => ( Parameter_Float, 0.0 ),   --  : age_70_male (Amount)
           90 => ( Parameter_Float, 0.0 ),   --  : age_71_male (Amount)
           91 => ( Parameter_Float, 0.0 ),   --  : age_72_male (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : age_73_male (Amount)
           93 => ( Parameter_Float, 0.0 ),   --  : age_74_male (Amount)
           94 => ( Parameter_Float, 0.0 ),   --  : age_75_male (Amount)
           95 => ( Parameter_Float, 0.0 ),   --  : age_76_male (Amount)
           96 => ( Parameter_Float, 0.0 ),   --  : age_77_male (Amount)
           97 => ( Parameter_Float, 0.0 ),   --  : age_78_male (Amount)
           98 => ( Parameter_Float, 0.0 ),   --  : age_79_male (Amount)
           99 => ( Parameter_Float, 0.0 ),   --  : age_80_male (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : age_81_male (Amount)
           101 => ( Parameter_Float, 0.0 ),   --  : age_82_male (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : age_83_male (Amount)
           103 => ( Parameter_Float, 0.0 ),   --  : age_84_male (Amount)
           104 => ( Parameter_Float, 0.0 ),   --  : age_85_male (Amount)
           105 => ( Parameter_Float, 0.0 ),   --  : age_86_male (Amount)
           106 => ( Parameter_Float, 0.0 ),   --  : age_87_male (Amount)
           107 => ( Parameter_Float, 0.0 ),   --  : age_88_male (Amount)
           108 => ( Parameter_Float, 0.0 ),   --  : age_89_male (Amount)
           109 => ( Parameter_Float, 0.0 ),   --  : age_90_male (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : age_91_male (Amount)
           111 => ( Parameter_Float, 0.0 ),   --  : age_92_male (Amount)
           112 => ( Parameter_Float, 0.0 ),   --  : age_93_male (Amount)
           113 => ( Parameter_Float, 0.0 ),   --  : age_94_male (Amount)
           114 => ( Parameter_Float, 0.0 ),   --  : age_95_male (Amount)
           115 => ( Parameter_Float, 0.0 ),   --  : age_96_male (Amount)
           116 => ( Parameter_Float, 0.0 ),   --  : age_97_male (Amount)
           117 => ( Parameter_Float, 0.0 ),   --  : age_98_male (Amount)
           118 => ( Parameter_Float, 0.0 ),   --  : age_99_male (Amount)
           119 => ( Parameter_Float, 0.0 ),   --  : age_100_male (Amount)
           120 => ( Parameter_Float, 0.0 ),   --  : age_101_male (Amount)
           121 => ( Parameter_Float, 0.0 ),   --  : age_102_male (Amount)
           122 => ( Parameter_Float, 0.0 ),   --  : age_103_male (Amount)
           123 => ( Parameter_Float, 0.0 ),   --  : age_104_male (Amount)
           124 => ( Parameter_Float, 0.0 ),   --  : age_105_male (Amount)
           125 => ( Parameter_Float, 0.0 ),   --  : age_106_male (Amount)
           126 => ( Parameter_Float, 0.0 ),   --  : age_107_male (Amount)
           127 => ( Parameter_Float, 0.0 ),   --  : age_108_male (Amount)
           128 => ( Parameter_Float, 0.0 ),   --  : age_109_male (Amount)
           129 => ( Parameter_Float, 0.0 ),   --  : age_110_male (Amount)
           130 => ( Parameter_Float, 0.0 ),   --  : age_0_female (Amount)
           131 => ( Parameter_Float, 0.0 ),   --  : age_1_female (Amount)
           132 => ( Parameter_Float, 0.0 ),   --  : age_2_female (Amount)
           133 => ( Parameter_Float, 0.0 ),   --  : age_3_female (Amount)
           134 => ( Parameter_Float, 0.0 ),   --  : age_4_female (Amount)
           135 => ( Parameter_Float, 0.0 ),   --  : age_5_female (Amount)
           136 => ( Parameter_Float, 0.0 ),   --  : age_6_female (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : age_7_female (Amount)
           138 => ( Parameter_Float, 0.0 ),   --  : age_8_female (Amount)
           139 => ( Parameter_Float, 0.0 ),   --  : age_9_female (Amount)
           140 => ( Parameter_Float, 0.0 ),   --  : age_10_female (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : age_11_female (Amount)
           142 => ( Parameter_Float, 0.0 ),   --  : age_12_female (Amount)
           143 => ( Parameter_Float, 0.0 ),   --  : age_13_female (Amount)
           144 => ( Parameter_Float, 0.0 ),   --  : age_14_female (Amount)
           145 => ( Parameter_Float, 0.0 ),   --  : age_15_female (Amount)
           146 => ( Parameter_Float, 0.0 ),   --  : age_16_female (Amount)
           147 => ( Parameter_Float, 0.0 ),   --  : age_17_female (Amount)
           148 => ( Parameter_Float, 0.0 ),   --  : age_18_female (Amount)
           149 => ( Parameter_Float, 0.0 ),   --  : age_19_female (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : age_20_female (Amount)
           151 => ( Parameter_Float, 0.0 ),   --  : age_21_female (Amount)
           152 => ( Parameter_Float, 0.0 ),   --  : age_22_female (Amount)
           153 => ( Parameter_Float, 0.0 ),   --  : age_23_female (Amount)
           154 => ( Parameter_Float, 0.0 ),   --  : age_24_female (Amount)
           155 => ( Parameter_Float, 0.0 ),   --  : age_25_female (Amount)
           156 => ( Parameter_Float, 0.0 ),   --  : age_26_female (Amount)
           157 => ( Parameter_Float, 0.0 ),   --  : age_27_female (Amount)
           158 => ( Parameter_Float, 0.0 ),   --  : age_28_female (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : age_29_female (Amount)
           160 => ( Parameter_Float, 0.0 ),   --  : age_30_female (Amount)
           161 => ( Parameter_Float, 0.0 ),   --  : age_31_female (Amount)
           162 => ( Parameter_Float, 0.0 ),   --  : age_32_female (Amount)
           163 => ( Parameter_Float, 0.0 ),   --  : age_33_female (Amount)
           164 => ( Parameter_Float, 0.0 ),   --  : age_34_female (Amount)
           165 => ( Parameter_Float, 0.0 ),   --  : age_35_female (Amount)
           166 => ( Parameter_Float, 0.0 ),   --  : age_36_female (Amount)
           167 => ( Parameter_Float, 0.0 ),   --  : age_37_female (Amount)
           168 => ( Parameter_Float, 0.0 ),   --  : age_38_female (Amount)
           169 => ( Parameter_Float, 0.0 ),   --  : age_39_female (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : age_40_female (Amount)
           171 => ( Parameter_Float, 0.0 ),   --  : age_41_female (Amount)
           172 => ( Parameter_Float, 0.0 ),   --  : age_42_female (Amount)
           173 => ( Parameter_Float, 0.0 ),   --  : age_43_female (Amount)
           174 => ( Parameter_Float, 0.0 ),   --  : age_44_female (Amount)
           175 => ( Parameter_Float, 0.0 ),   --  : age_45_female (Amount)
           176 => ( Parameter_Float, 0.0 ),   --  : age_46_female (Amount)
           177 => ( Parameter_Float, 0.0 ),   --  : age_47_female (Amount)
           178 => ( Parameter_Float, 0.0 ),   --  : age_48_female (Amount)
           179 => ( Parameter_Float, 0.0 ),   --  : age_49_female (Amount)
           180 => ( Parameter_Float, 0.0 ),   --  : age_50_female (Amount)
           181 => ( Parameter_Float, 0.0 ),   --  : age_51_female (Amount)
           182 => ( Parameter_Float, 0.0 ),   --  : age_52_female (Amount)
           183 => ( Parameter_Float, 0.0 ),   --  : age_53_female (Amount)
           184 => ( Parameter_Float, 0.0 ),   --  : age_54_female (Amount)
           185 => ( Parameter_Float, 0.0 ),   --  : age_55_female (Amount)
           186 => ( Parameter_Float, 0.0 ),   --  : age_56_female (Amount)
           187 => ( Parameter_Float, 0.0 ),   --  : age_57_female (Amount)
           188 => ( Parameter_Float, 0.0 ),   --  : age_58_female (Amount)
           189 => ( Parameter_Float, 0.0 ),   --  : age_59_female (Amount)
           190 => ( Parameter_Float, 0.0 ),   --  : age_60_female (Amount)
           191 => ( Parameter_Float, 0.0 ),   --  : age_61_female (Amount)
           192 => ( Parameter_Float, 0.0 ),   --  : age_62_female (Amount)
           193 => ( Parameter_Float, 0.0 ),   --  : age_63_female (Amount)
           194 => ( Parameter_Float, 0.0 ),   --  : age_64_female (Amount)
           195 => ( Parameter_Float, 0.0 ),   --  : age_65_female (Amount)
           196 => ( Parameter_Float, 0.0 ),   --  : age_66_female (Amount)
           197 => ( Parameter_Float, 0.0 ),   --  : age_67_female (Amount)
           198 => ( Parameter_Float, 0.0 ),   --  : age_68_female (Amount)
           199 => ( Parameter_Float, 0.0 ),   --  : age_69_female (Amount)
           200 => ( Parameter_Float, 0.0 ),   --  : age_70_female (Amount)
           201 => ( Parameter_Float, 0.0 ),   --  : age_71_female (Amount)
           202 => ( Parameter_Float, 0.0 ),   --  : age_72_female (Amount)
           203 => ( Parameter_Float, 0.0 ),   --  : age_73_female (Amount)
           204 => ( Parameter_Float, 0.0 ),   --  : age_74_female (Amount)
           205 => ( Parameter_Float, 0.0 ),   --  : age_75_female (Amount)
           206 => ( Parameter_Float, 0.0 ),   --  : age_76_female (Amount)
           207 => ( Parameter_Float, 0.0 ),   --  : age_77_female (Amount)
           208 => ( Parameter_Float, 0.0 ),   --  : age_78_female (Amount)
           209 => ( Parameter_Float, 0.0 ),   --  : age_79_female (Amount)
           210 => ( Parameter_Float, 0.0 ),   --  : age_80_female (Amount)
           211 => ( Parameter_Float, 0.0 ),   --  : age_81_female (Amount)
           212 => ( Parameter_Float, 0.0 ),   --  : age_82_female (Amount)
           213 => ( Parameter_Float, 0.0 ),   --  : age_83_female (Amount)
           214 => ( Parameter_Float, 0.0 ),   --  : age_84_female (Amount)
           215 => ( Parameter_Float, 0.0 ),   --  : age_85_female (Amount)
           216 => ( Parameter_Float, 0.0 ),   --  : age_86_female (Amount)
           217 => ( Parameter_Float, 0.0 ),   --  : age_87_female (Amount)
           218 => ( Parameter_Float, 0.0 ),   --  : age_88_female (Amount)
           219 => ( Parameter_Float, 0.0 ),   --  : age_89_female (Amount)
           220 => ( Parameter_Float, 0.0 ),   --  : age_90_female (Amount)
           221 => ( Parameter_Float, 0.0 ),   --  : age_91_female (Amount)
           222 => ( Parameter_Float, 0.0 ),   --  : age_92_female (Amount)
           223 => ( Parameter_Float, 0.0 ),   --  : age_93_female (Amount)
           224 => ( Parameter_Float, 0.0 ),   --  : age_94_female (Amount)
           225 => ( Parameter_Float, 0.0 ),   --  : age_95_female (Amount)
           226 => ( Parameter_Float, 0.0 ),   --  : age_96_female (Amount)
           227 => ( Parameter_Float, 0.0 ),   --  : age_97_female (Amount)
           228 => ( Parameter_Float, 0.0 ),   --  : age_98_female (Amount)
           229 => ( Parameter_Float, 0.0 ),   --  : age_99_female (Amount)
           230 => ( Parameter_Float, 0.0 ),   --  : age_100_female (Amount)
           231 => ( Parameter_Float, 0.0 ),   --  : age_101_female (Amount)
           232 => ( Parameter_Float, 0.0 ),   --  : age_102_female (Amount)
           233 => ( Parameter_Float, 0.0 ),   --  : age_103_female (Amount)
           234 => ( Parameter_Float, 0.0 ),   --  : age_104_female (Amount)
           235 => ( Parameter_Float, 0.0 ),   --  : age_105_female (Amount)
           236 => ( Parameter_Float, 0.0 ),   --  : age_106_female (Amount)
           237 => ( Parameter_Float, 0.0 ),   --  : age_107_female (Amount)
           238 => ( Parameter_Float, 0.0 ),   --  : age_108_female (Amount)
           239 => ( Parameter_Float, 0.0 ),   --  : age_109_female (Amount)
           240 => ( Parameter_Float, 0.0 ),   --  : age_110_female (Amount)
           241 => ( Parameter_Float, 0.0 ),   --  : age_0 (Amount)
           242 => ( Parameter_Float, 0.0 ),   --  : age_1 (Amount)
           243 => ( Parameter_Float, 0.0 ),   --  : age_2 (Amount)
           244 => ( Parameter_Float, 0.0 ),   --  : age_3 (Amount)
           245 => ( Parameter_Float, 0.0 ),   --  : age_4 (Amount)
           246 => ( Parameter_Float, 0.0 ),   --  : age_5 (Amount)
           247 => ( Parameter_Float, 0.0 ),   --  : age_6 (Amount)
           248 => ( Parameter_Float, 0.0 ),   --  : age_7 (Amount)
           249 => ( Parameter_Float, 0.0 ),   --  : age_8 (Amount)
           250 => ( Parameter_Float, 0.0 ),   --  : age_9 (Amount)
           251 => ( Parameter_Float, 0.0 ),   --  : age_10 (Amount)
           252 => ( Parameter_Float, 0.0 ),   --  : age_11 (Amount)
           253 => ( Parameter_Float, 0.0 ),   --  : age_12 (Amount)
           254 => ( Parameter_Float, 0.0 ),   --  : age_13 (Amount)
           255 => ( Parameter_Float, 0.0 ),   --  : age_14 (Amount)
           256 => ( Parameter_Float, 0.0 ),   --  : age_15 (Amount)
           257 => ( Parameter_Float, 0.0 ),   --  : age_16 (Amount)
           258 => ( Parameter_Float, 0.0 ),   --  : age_17 (Amount)
           259 => ( Parameter_Float, 0.0 ),   --  : age_18 (Amount)
           260 => ( Parameter_Float, 0.0 ),   --  : age_19 (Amount)
           261 => ( Parameter_Float, 0.0 ),   --  : age_20 (Amount)
           262 => ( Parameter_Float, 0.0 ),   --  : age_21 (Amount)
           263 => ( Parameter_Float, 0.0 ),   --  : age_22 (Amount)
           264 => ( Parameter_Float, 0.0 ),   --  : age_23 (Amount)
           265 => ( Parameter_Float, 0.0 ),   --  : age_24 (Amount)
           266 => ( Parameter_Float, 0.0 ),   --  : age_25 (Amount)
           267 => ( Parameter_Float, 0.0 ),   --  : age_26 (Amount)
           268 => ( Parameter_Float, 0.0 ),   --  : age_27 (Amount)
           269 => ( Parameter_Float, 0.0 ),   --  : age_28 (Amount)
           270 => ( Parameter_Float, 0.0 ),   --  : age_29 (Amount)
           271 => ( Parameter_Float, 0.0 ),   --  : age_30 (Amount)
           272 => ( Parameter_Float, 0.0 ),   --  : age_31 (Amount)
           273 => ( Parameter_Float, 0.0 ),   --  : age_32 (Amount)
           274 => ( Parameter_Float, 0.0 ),   --  : age_33 (Amount)
           275 => ( Parameter_Float, 0.0 ),   --  : age_34 (Amount)
           276 => ( Parameter_Float, 0.0 ),   --  : age_35 (Amount)
           277 => ( Parameter_Float, 0.0 ),   --  : age_36 (Amount)
           278 => ( Parameter_Float, 0.0 ),   --  : age_37 (Amount)
           279 => ( Parameter_Float, 0.0 ),   --  : age_38 (Amount)
           280 => ( Parameter_Float, 0.0 ),   --  : age_39 (Amount)
           281 => ( Parameter_Float, 0.0 ),   --  : age_40 (Amount)
           282 => ( Parameter_Float, 0.0 ),   --  : age_41 (Amount)
           283 => ( Parameter_Float, 0.0 ),   --  : age_42 (Amount)
           284 => ( Parameter_Float, 0.0 ),   --  : age_43 (Amount)
           285 => ( Parameter_Float, 0.0 ),   --  : age_44 (Amount)
           286 => ( Parameter_Float, 0.0 ),   --  : age_45 (Amount)
           287 => ( Parameter_Float, 0.0 ),   --  : age_46 (Amount)
           288 => ( Parameter_Float, 0.0 ),   --  : age_47 (Amount)
           289 => ( Parameter_Float, 0.0 ),   --  : age_48 (Amount)
           290 => ( Parameter_Float, 0.0 ),   --  : age_49 (Amount)
           291 => ( Parameter_Float, 0.0 ),   --  : age_50 (Amount)
           292 => ( Parameter_Float, 0.0 ),   --  : age_51 (Amount)
           293 => ( Parameter_Float, 0.0 ),   --  : age_52 (Amount)
           294 => ( Parameter_Float, 0.0 ),   --  : age_53 (Amount)
           295 => ( Parameter_Float, 0.0 ),   --  : age_54 (Amount)
           296 => ( Parameter_Float, 0.0 ),   --  : age_55 (Amount)
           297 => ( Parameter_Float, 0.0 ),   --  : age_56 (Amount)
           298 => ( Parameter_Float, 0.0 ),   --  : age_57 (Amount)
           299 => ( Parameter_Float, 0.0 ),   --  : age_58 (Amount)
           300 => ( Parameter_Float, 0.0 ),   --  : age_59 (Amount)
           301 => ( Parameter_Float, 0.0 ),   --  : age_60 (Amount)
           302 => ( Parameter_Float, 0.0 ),   --  : age_61 (Amount)
           303 => ( Parameter_Float, 0.0 ),   --  : age_62 (Amount)
           304 => ( Parameter_Float, 0.0 ),   --  : age_63 (Amount)
           305 => ( Parameter_Float, 0.0 ),   --  : age_64 (Amount)
           306 => ( Parameter_Float, 0.0 ),   --  : age_65 (Amount)
           307 => ( Parameter_Float, 0.0 ),   --  : age_66 (Amount)
           308 => ( Parameter_Float, 0.0 ),   --  : age_67 (Amount)
           309 => ( Parameter_Float, 0.0 ),   --  : age_68 (Amount)
           310 => ( Parameter_Float, 0.0 ),   --  : age_69 (Amount)
           311 => ( Parameter_Float, 0.0 ),   --  : age_70 (Amount)
           312 => ( Parameter_Float, 0.0 ),   --  : age_71 (Amount)
           313 => ( Parameter_Float, 0.0 ),   --  : age_72 (Amount)
           314 => ( Parameter_Float, 0.0 ),   --  : age_73 (Amount)
           315 => ( Parameter_Float, 0.0 ),   --  : age_74 (Amount)
           316 => ( Parameter_Float, 0.0 ),   --  : age_75 (Amount)
           317 => ( Parameter_Float, 0.0 ),   --  : age_76 (Amount)
           318 => ( Parameter_Float, 0.0 ),   --  : age_77 (Amount)
           319 => ( Parameter_Float, 0.0 ),   --  : age_78 (Amount)
           320 => ( Parameter_Float, 0.0 ),   --  : age_79 (Amount)
           321 => ( Parameter_Float, 0.0 ),   --  : age_80 (Amount)
           322 => ( Parameter_Float, 0.0 ),   --  : age_81 (Amount)
           323 => ( Parameter_Float, 0.0 ),   --  : age_82 (Amount)
           324 => ( Parameter_Float, 0.0 ),   --  : age_83 (Amount)
           325 => ( Parameter_Float, 0.0 ),   --  : age_84 (Amount)
           326 => ( Parameter_Float, 0.0 ),   --  : age_85 (Amount)
           327 => ( Parameter_Float, 0.0 ),   --  : age_86 (Amount)
           328 => ( Parameter_Float, 0.0 ),   --  : age_87 (Amount)
           329 => ( Parameter_Float, 0.0 ),   --  : age_88 (Amount)
           330 => ( Parameter_Float, 0.0 ),   --  : age_89 (Amount)
           331 => ( Parameter_Float, 0.0 ),   --  : age_90 (Amount)
           332 => ( Parameter_Float, 0.0 ),   --  : age_91 (Amount)
           333 => ( Parameter_Float, 0.0 ),   --  : age_92 (Amount)
           334 => ( Parameter_Float, 0.0 ),   --  : age_93 (Amount)
           335 => ( Parameter_Float, 0.0 ),   --  : age_94 (Amount)
           336 => ( Parameter_Float, 0.0 ),   --  : age_95 (Amount)
           337 => ( Parameter_Float, 0.0 ),   --  : age_96 (Amount)
           338 => ( Parameter_Float, 0.0 ),   --  : age_97 (Amount)
           339 => ( Parameter_Float, 0.0 ),   --  : age_98 (Amount)
           340 => ( Parameter_Float, 0.0 ),   --  : age_99 (Amount)
           341 => ( Parameter_Float, 0.0 ),   --  : age_100 (Amount)
           342 => ( Parameter_Float, 0.0 ),   --  : age_101 (Amount)
           343 => ( Parameter_Float, 0.0 ),   --  : age_102 (Amount)
           344 => ( Parameter_Float, 0.0 ),   --  : age_103 (Amount)
           345 => ( Parameter_Float, 0.0 ),   --  : age_104 (Amount)
           346 => ( Parameter_Float, 0.0 ),   --  : age_105 (Amount)
           347 => ( Parameter_Float, 0.0 ),   --  : age_106 (Amount)
           348 => ( Parameter_Float, 0.0 ),   --  : age_107 (Amount)
           349 => ( Parameter_Float, 0.0 ),   --  : age_108 (Amount)
           350 => ( Parameter_Float, 0.0 ),   --  : age_109 (Amount)
           351 => ( Parameter_Float, 0.0 )   --  : age_110 (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268, $269, $270, $271, $272, $273, $274, $275, $276, $277, $278, $279, $280, $281, $282, $283, $284, $285, $286, $287, $288, $289, $290, $291, $292, $293, $294, $295, $296, $297, $298, $299, $300, $301, $302, $303, $304, $305, $306, $307, $308, $309, $310, $311, $312, $313, $314, $315, $316, $317, $318, $319, $320, $321, $322, $323, $324, $325, $326, $327, $328, $329, $330, $331, $332, $333, $334, $335, $336, $337, $338, $339, $340, $341, $342, $343, $344, $345, $346, $347, $348, $349, $350, $351 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 4 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " household_one_adult_male = $1, household_one_adult_female = $2, household_two_adults = $3, household_one_adult_one_child = $4, household_one_adult_two_plus_children = $5, household_two_plus_adult_one_plus_children = $6, household_three_plus_person_all_adult = $7, household_all_households = $8, male = $9, female = $10, employed = $11, employee = $12, ilo_unemployed = $13, jsa_claimant = $14, age_0_male = $15, age_1_male = $16, age_2_male = $17, age_3_male = $18, age_4_male = $19, age_5_male = $20, age_6_male = $21, age_7_male = $22, age_8_male = $23, age_9_male = $24, age_10_male = $25, age_11_male = $26, age_12_male = $27, age_13_male = $28, age_14_male = $29, age_15_male = $30, age_16_male = $31, age_17_male = $32, age_18_male = $33, age_19_male = $34, age_20_male = $35, age_21_male = $36, age_22_male = $37, age_23_male = $38, age_24_male = $39, age_25_male = $40, age_26_male = $41, age_27_male = $42, age_28_male = $43, age_29_male = $44, age_30_male = $45, age_31_male = $46, age_32_male = $47, age_33_male = $48, age_34_male = $49, age_35_male = $50, age_36_male = $51, age_37_male = $52, age_38_male = $53, age_39_male = $54, age_40_male = $55, age_41_male = $56, age_42_male = $57, age_43_male = $58, age_44_male = $59, age_45_male = $60, age_46_male = $61, age_47_male = $62, age_48_male = $63, age_49_male = $64, age_50_male = $65, age_51_male = $66, age_52_male = $67, age_53_male = $68, age_54_male = $69, age_55_male = $70, age_56_male = $71, age_57_male = $72, age_58_male = $73, age_59_male = $74, age_60_male = $75, age_61_male = $76, age_62_male = $77, age_63_male = $78, age_64_male = $79, age_65_male = $80, age_66_male = $81, age_67_male = $82, age_68_male = $83, age_69_male = $84, age_70_male = $85, age_71_male = $86, age_72_male = $87, age_73_male = $88, age_74_male = $89, age_75_male = $90, age_76_male = $91, age_77_male = $92, age_78_male = $93, age_79_male = $94, age_80_male = $95, age_81_male = $96, age_82_male = $97, age_83_male = $98, age_84_male = $99, age_85_male = $100, age_86_male = $101, age_87_male = $102, age_88_male = $103, age_89_male = $104, age_90_male = $105, age_91_male = $106, age_92_male = $107, age_93_male = $108, age_94_male = $109, age_95_male = $110, age_96_male = $111, age_97_male = $112, age_98_male = $113, age_99_male = $114, age_100_male = $115, age_101_male = $116, age_102_male = $117, age_103_male = $118, age_104_male = $119, age_105_male = $120, age_106_male = $121, age_107_male = $122, age_108_male = $123, age_109_male = $124, age_110_male = $125, age_0_female = $126, age_1_female = $127, age_2_female = $128, age_3_female = $129, age_4_female = $130, age_5_female = $131, age_6_female = $132, age_7_female = $133, age_8_female = $134, age_9_female = $135, age_10_female = $136, age_11_female = $137, age_12_female = $138, age_13_female = $139, age_14_female = $140, age_15_female = $141, age_16_female = $142, age_17_female = $143, age_18_female = $144, age_19_female = $145, age_20_female = $146, age_21_female = $147, age_22_female = $148, age_23_female = $149, age_24_female = $150, age_25_female = $151, age_26_female = $152, age_27_female = $153, age_28_female = $154, age_29_female = $155, age_30_female = $156, age_31_female = $157, age_32_female = $158, age_33_female = $159, age_34_female = $160, age_35_female = $161, age_36_female = $162, age_37_female = $163, age_38_female = $164, age_39_female = $165, age_40_female = $166, age_41_female = $167, age_42_female = $168, age_43_female = $169, age_44_female = $170, age_45_female = $171, age_46_female = $172, age_47_female = $173, age_48_female = $174, age_49_female = $175, age_50_female = $176, age_51_female = $177, age_52_female = $178, age_53_female = $179, age_54_female = $180, age_55_female = $181, age_56_female = $182, age_57_female = $183, age_58_female = $184, age_59_female = $185, age_60_female = $186, age_61_female = $187, age_62_female = $188, age_63_female = $189, age_64_female = $190, age_65_female = $191, age_66_female = $192, age_67_female = $193, age_68_female = $194, age_69_female = $195, age_70_female = $196, age_71_female = $197, age_72_female = $198, age_73_female = $199, age_74_female = $200, age_75_female = $201, age_76_female = $202, age_77_female = $203, age_78_female = $204, age_79_female = $205, age_80_female = $206, age_81_female = $207, age_82_female = $208, age_83_female = $209, age_84_female = $210, age_85_female = $211, age_86_female = $212, age_87_female = $213, age_88_female = $214, age_89_female = $215, age_90_female = $216, age_91_female = $217, age_92_female = $218, age_93_female = $219, age_94_female = $220, age_95_female = $221, age_96_female = $222, age_97_female = $223, age_98_female = $224, age_99_female = $225, age_100_female = $226, age_101_female = $227, age_102_female = $228, age_103_female = $229, age_104_female = $230, age_105_female = $231, age_106_female = $232, age_107_female = $233, age_108_female = $234, age_109_female = $235, age_110_female = $236, age_0 = $237, age_1 = $238, age_2 = $239, age_3 = $240, age_4 = $241, age_5 = $242, age_6 = $243, age_7 = $244, age_8 = $245, age_9 = $246, age_10 = $247, age_11 = $248, age_12 = $249, age_13 = $250, age_14 = $251, age_15 = $252, age_16 = $253, age_17 = $254, age_18 = $255, age_19 = $256, age_20 = $257, age_21 = $258, age_22 = $259, age_23 = $260, age_24 = $261, age_25 = $262, age_26 = $263, age_27 = $264, age_28 = $265, age_29 = $266, age_30 = $267, age_31 = $268, age_32 = $269, age_33 = $270, age_34 = $271, age_35 = $272, age_36 = $273, age_37 = $274, age_38 = $275, age_39 = $276, age_40 = $277, age_41 = $278, age_42 = $279, age_43 = $280, age_44 = $281, age_45 = $282, age_46 = $283, age_47 = $284, age_48 = $285, age_49 = $286, age_50 = $287, age_51 = $288, age_52 = $289, age_53 = $290, age_54 = $291, age_55 = $292, age_56 = $293, age_57 = $294, age_58 = $295, age_59 = $296, age_60 = $297, age_61 = $298, age_62 = $299, age_63 = $300, age_64 = $301, age_65 = $302, age_66 = $303, age_67 = $304, age_68 = $305, age_69 = $306, age_70 = $307, age_71 = $308, age_72 = $309, age_73 = $310, age_74 = $311, age_75 = $312, age_76 = $313, age_77 = $314, age_78 = $315, age_79 = $316, age_80 = $317, age_81 = $318, age_82 = $319, age_83 = $320, age_84 = $321, age_85 = $322, age_86 = $323, age_87 = $324, age_88 = $325, age_89 = $326, age_90 = $327, age_91 = $328, age_92 = $329, age_93 = $330, age_94 = $331, age_95 = $332, age_96 = $333, age_97 = $334, age_98 = $335, age_99 = $336, age_100 = $337, age_101 = $338, age_102 = $339, age_103 = $340, age_104 = $341, age_105 = $342, age_106 = $343, age_107 = $344, age_108 = $345, age_109 = $346, age_110 = $347 where run_id = $348 and user_id = $349 and year = $350 and sernum = $351"; 
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
   function Next_Free_year( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

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
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset is
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
        
   function Exists( run_id : Integer; user_id : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean  is
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
      params( 3 ) := "+"( Integer'Pos( year ));
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
         a_target_dataset.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_target_dataset.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_target_dataset.household_one_adult_male:= Amount'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_target_dataset.household_one_adult_female:= Amount'Value( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_target_dataset.household_two_adults:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_target_dataset.household_one_adult_one_child:= Amount'Value( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_target_dataset.household_one_adult_two_plus_children:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_target_dataset.household_two_plus_adult_one_plus_children:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_target_dataset.household_three_plus_person_all_adult:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_target_dataset.household_all_households:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_target_dataset.male:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_target_dataset.female:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_target_dataset.employed:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_target_dataset.employee:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_target_dataset.ilo_unemployed:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_target_dataset.jsa_claimant:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_target_dataset.age_0_male:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_target_dataset.age_1_male:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_target_dataset.age_2_male:= Amount'Value( gse.Value( cursor, 20 ));
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_target_dataset.age_3_male:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_target_dataset.age_4_male:= Amount'Value( gse.Value( cursor, 22 ));
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_target_dataset.age_5_male:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_target_dataset.age_6_male:= Amount'Value( gse.Value( cursor, 24 ));
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_target_dataset.age_7_male:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_target_dataset.age_8_male:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_target_dataset.age_9_male:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_target_dataset.age_10_male:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_target_dataset.age_11_male:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_target_dataset.age_12_male:= Amount'Value( gse.Value( cursor, 30 ));
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_target_dataset.age_13_male:= Amount'Value( gse.Value( cursor, 31 ));
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_target_dataset.age_14_male:= Amount'Value( gse.Value( cursor, 32 ));
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_target_dataset.age_15_male:= Amount'Value( gse.Value( cursor, 33 ));
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_target_dataset.age_16_male:= Amount'Value( gse.Value( cursor, 34 ));
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_target_dataset.age_17_male:= Amount'Value( gse.Value( cursor, 35 ));
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_target_dataset.age_18_male:= Amount'Value( gse.Value( cursor, 36 ));
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_target_dataset.age_19_male:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_target_dataset.age_20_male:= Amount'Value( gse.Value( cursor, 38 ));
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_target_dataset.age_21_male:= Amount'Value( gse.Value( cursor, 39 ));
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_target_dataset.age_22_male:= Amount'Value( gse.Value( cursor, 40 ));
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_target_dataset.age_23_male:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_target_dataset.age_24_male:= Amount'Value( gse.Value( cursor, 42 ));
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_target_dataset.age_25_male:= Amount'Value( gse.Value( cursor, 43 ));
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_target_dataset.age_26_male:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_target_dataset.age_27_male:= Amount'Value( gse.Value( cursor, 45 ));
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_target_dataset.age_28_male:= Amount'Value( gse.Value( cursor, 46 ));
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_target_dataset.age_29_male:= Amount'Value( gse.Value( cursor, 47 ));
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_target_dataset.age_30_male:= Amount'Value( gse.Value( cursor, 48 ));
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_target_dataset.age_31_male:= Amount'Value( gse.Value( cursor, 49 ));
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_target_dataset.age_32_male:= Amount'Value( gse.Value( cursor, 50 ));
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_target_dataset.age_33_male:= Amount'Value( gse.Value( cursor, 51 ));
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_target_dataset.age_34_male:= Amount'Value( gse.Value( cursor, 52 ));
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_target_dataset.age_35_male:= Amount'Value( gse.Value( cursor, 53 ));
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_target_dataset.age_36_male:= Amount'Value( gse.Value( cursor, 54 ));
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_target_dataset.age_37_male:= Amount'Value( gse.Value( cursor, 55 ));
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_target_dataset.age_38_male:= Amount'Value( gse.Value( cursor, 56 ));
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_target_dataset.age_39_male:= Amount'Value( gse.Value( cursor, 57 ));
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_target_dataset.age_40_male:= Amount'Value( gse.Value( cursor, 58 ));
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_target_dataset.age_41_male:= Amount'Value( gse.Value( cursor, 59 ));
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_target_dataset.age_42_male:= Amount'Value( gse.Value( cursor, 60 ));
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_target_dataset.age_43_male:= Amount'Value( gse.Value( cursor, 61 ));
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_target_dataset.age_44_male:= Amount'Value( gse.Value( cursor, 62 ));
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_target_dataset.age_45_male:= Amount'Value( gse.Value( cursor, 63 ));
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_target_dataset.age_46_male:= Amount'Value( gse.Value( cursor, 64 ));
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_target_dataset.age_47_male:= Amount'Value( gse.Value( cursor, 65 ));
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_target_dataset.age_48_male:= Amount'Value( gse.Value( cursor, 66 ));
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_target_dataset.age_49_male:= Amount'Value( gse.Value( cursor, 67 ));
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_target_dataset.age_50_male:= Amount'Value( gse.Value( cursor, 68 ));
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_target_dataset.age_51_male:= Amount'Value( gse.Value( cursor, 69 ));
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_target_dataset.age_52_male:= Amount'Value( gse.Value( cursor, 70 ));
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_target_dataset.age_53_male:= Amount'Value( gse.Value( cursor, 71 ));
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_target_dataset.age_54_male:= Amount'Value( gse.Value( cursor, 72 ));
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_target_dataset.age_55_male:= Amount'Value( gse.Value( cursor, 73 ));
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_target_dataset.age_56_male:= Amount'Value( gse.Value( cursor, 74 ));
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_target_dataset.age_57_male:= Amount'Value( gse.Value( cursor, 75 ));
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_target_dataset.age_58_male:= Amount'Value( gse.Value( cursor, 76 ));
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_target_dataset.age_59_male:= Amount'Value( gse.Value( cursor, 77 ));
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_target_dataset.age_60_male:= Amount'Value( gse.Value( cursor, 78 ));
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_target_dataset.age_61_male:= Amount'Value( gse.Value( cursor, 79 ));
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_target_dataset.age_62_male:= Amount'Value( gse.Value( cursor, 80 ));
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_target_dataset.age_63_male:= Amount'Value( gse.Value( cursor, 81 ));
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_target_dataset.age_64_male:= Amount'Value( gse.Value( cursor, 82 ));
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_target_dataset.age_65_male:= Amount'Value( gse.Value( cursor, 83 ));
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_target_dataset.age_66_male:= Amount'Value( gse.Value( cursor, 84 ));
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_target_dataset.age_67_male:= Amount'Value( gse.Value( cursor, 85 ));
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_target_dataset.age_68_male:= Amount'Value( gse.Value( cursor, 86 ));
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_target_dataset.age_69_male:= Amount'Value( gse.Value( cursor, 87 ));
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_target_dataset.age_70_male:= Amount'Value( gse.Value( cursor, 88 ));
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_target_dataset.age_71_male:= Amount'Value( gse.Value( cursor, 89 ));
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_target_dataset.age_72_male:= Amount'Value( gse.Value( cursor, 90 ));
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_target_dataset.age_73_male:= Amount'Value( gse.Value( cursor, 91 ));
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_target_dataset.age_74_male:= Amount'Value( gse.Value( cursor, 92 ));
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_target_dataset.age_75_male:= Amount'Value( gse.Value( cursor, 93 ));
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_target_dataset.age_76_male:= Amount'Value( gse.Value( cursor, 94 ));
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_target_dataset.age_77_male:= Amount'Value( gse.Value( cursor, 95 ));
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_target_dataset.age_78_male:= Amount'Value( gse.Value( cursor, 96 ));
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_target_dataset.age_79_male:= Amount'Value( gse.Value( cursor, 97 ));
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_target_dataset.age_80_male:= Amount'Value( gse.Value( cursor, 98 ));
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_target_dataset.age_81_male:= Amount'Value( gse.Value( cursor, 99 ));
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_target_dataset.age_82_male:= Amount'Value( gse.Value( cursor, 100 ));
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_target_dataset.age_83_male:= Amount'Value( gse.Value( cursor, 101 ));
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_target_dataset.age_84_male:= Amount'Value( gse.Value( cursor, 102 ));
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_target_dataset.age_85_male:= Amount'Value( gse.Value( cursor, 103 ));
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_target_dataset.age_86_male:= Amount'Value( gse.Value( cursor, 104 ));
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_target_dataset.age_87_male:= Amount'Value( gse.Value( cursor, 105 ));
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_target_dataset.age_88_male:= Amount'Value( gse.Value( cursor, 106 ));
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_target_dataset.age_89_male:= Amount'Value( gse.Value( cursor, 107 ));
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_target_dataset.age_90_male:= Amount'Value( gse.Value( cursor, 108 ));
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_target_dataset.age_91_male:= Amount'Value( gse.Value( cursor, 109 ));
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_target_dataset.age_92_male:= Amount'Value( gse.Value( cursor, 110 ));
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_target_dataset.age_93_male:= Amount'Value( gse.Value( cursor, 111 ));
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_target_dataset.age_94_male:= Amount'Value( gse.Value( cursor, 112 ));
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_target_dataset.age_95_male:= Amount'Value( gse.Value( cursor, 113 ));
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_target_dataset.age_96_male:= Amount'Value( gse.Value( cursor, 114 ));
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_target_dataset.age_97_male:= Amount'Value( gse.Value( cursor, 115 ));
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_target_dataset.age_98_male:= Amount'Value( gse.Value( cursor, 116 ));
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_target_dataset.age_99_male:= Amount'Value( gse.Value( cursor, 117 ));
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_target_dataset.age_100_male:= Amount'Value( gse.Value( cursor, 118 ));
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_target_dataset.age_101_male:= Amount'Value( gse.Value( cursor, 119 ));
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_target_dataset.age_102_male:= Amount'Value( gse.Value( cursor, 120 ));
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_target_dataset.age_103_male:= Amount'Value( gse.Value( cursor, 121 ));
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_target_dataset.age_104_male:= Amount'Value( gse.Value( cursor, 122 ));
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_target_dataset.age_105_male:= Amount'Value( gse.Value( cursor, 123 ));
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_target_dataset.age_106_male:= Amount'Value( gse.Value( cursor, 124 ));
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_target_dataset.age_107_male:= Amount'Value( gse.Value( cursor, 125 ));
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_target_dataset.age_108_male:= Amount'Value( gse.Value( cursor, 126 ));
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_target_dataset.age_109_male:= Amount'Value( gse.Value( cursor, 127 ));
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_target_dataset.age_110_male:= Amount'Value( gse.Value( cursor, 128 ));
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_target_dataset.age_0_female:= Amount'Value( gse.Value( cursor, 129 ));
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_target_dataset.age_1_female:= Amount'Value( gse.Value( cursor, 130 ));
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_target_dataset.age_2_female:= Amount'Value( gse.Value( cursor, 131 ));
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_target_dataset.age_3_female:= Amount'Value( gse.Value( cursor, 132 ));
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_target_dataset.age_4_female:= Amount'Value( gse.Value( cursor, 133 ));
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_target_dataset.age_5_female:= Amount'Value( gse.Value( cursor, 134 ));
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_target_dataset.age_6_female:= Amount'Value( gse.Value( cursor, 135 ));
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_target_dataset.age_7_female:= Amount'Value( gse.Value( cursor, 136 ));
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_target_dataset.age_8_female:= Amount'Value( gse.Value( cursor, 137 ));
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_target_dataset.age_9_female:= Amount'Value( gse.Value( cursor, 138 ));
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_target_dataset.age_10_female:= Amount'Value( gse.Value( cursor, 139 ));
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_target_dataset.age_11_female:= Amount'Value( gse.Value( cursor, 140 ));
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_target_dataset.age_12_female:= Amount'Value( gse.Value( cursor, 141 ));
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_target_dataset.age_13_female:= Amount'Value( gse.Value( cursor, 142 ));
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_target_dataset.age_14_female:= Amount'Value( gse.Value( cursor, 143 ));
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_target_dataset.age_15_female:= Amount'Value( gse.Value( cursor, 144 ));
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_target_dataset.age_16_female:= Amount'Value( gse.Value( cursor, 145 ));
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_target_dataset.age_17_female:= Amount'Value( gse.Value( cursor, 146 ));
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_target_dataset.age_18_female:= Amount'Value( gse.Value( cursor, 147 ));
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_target_dataset.age_19_female:= Amount'Value( gse.Value( cursor, 148 ));
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_target_dataset.age_20_female:= Amount'Value( gse.Value( cursor, 149 ));
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_target_dataset.age_21_female:= Amount'Value( gse.Value( cursor, 150 ));
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_target_dataset.age_22_female:= Amount'Value( gse.Value( cursor, 151 ));
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_target_dataset.age_23_female:= Amount'Value( gse.Value( cursor, 152 ));
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_target_dataset.age_24_female:= Amount'Value( gse.Value( cursor, 153 ));
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_target_dataset.age_25_female:= Amount'Value( gse.Value( cursor, 154 ));
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_target_dataset.age_26_female:= Amount'Value( gse.Value( cursor, 155 ));
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_target_dataset.age_27_female:= Amount'Value( gse.Value( cursor, 156 ));
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_target_dataset.age_28_female:= Amount'Value( gse.Value( cursor, 157 ));
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_target_dataset.age_29_female:= Amount'Value( gse.Value( cursor, 158 ));
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_target_dataset.age_30_female:= Amount'Value( gse.Value( cursor, 159 ));
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_target_dataset.age_31_female:= Amount'Value( gse.Value( cursor, 160 ));
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_target_dataset.age_32_female:= Amount'Value( gse.Value( cursor, 161 ));
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_target_dataset.age_33_female:= Amount'Value( gse.Value( cursor, 162 ));
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_target_dataset.age_34_female:= Amount'Value( gse.Value( cursor, 163 ));
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_target_dataset.age_35_female:= Amount'Value( gse.Value( cursor, 164 ));
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_target_dataset.age_36_female:= Amount'Value( gse.Value( cursor, 165 ));
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_target_dataset.age_37_female:= Amount'Value( gse.Value( cursor, 166 ));
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_target_dataset.age_38_female:= Amount'Value( gse.Value( cursor, 167 ));
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_target_dataset.age_39_female:= Amount'Value( gse.Value( cursor, 168 ));
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_target_dataset.age_40_female:= Amount'Value( gse.Value( cursor, 169 ));
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_target_dataset.age_41_female:= Amount'Value( gse.Value( cursor, 170 ));
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_target_dataset.age_42_female:= Amount'Value( gse.Value( cursor, 171 ));
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_target_dataset.age_43_female:= Amount'Value( gse.Value( cursor, 172 ));
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_target_dataset.age_44_female:= Amount'Value( gse.Value( cursor, 173 ));
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_target_dataset.age_45_female:= Amount'Value( gse.Value( cursor, 174 ));
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_target_dataset.age_46_female:= Amount'Value( gse.Value( cursor, 175 ));
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_target_dataset.age_47_female:= Amount'Value( gse.Value( cursor, 176 ));
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_target_dataset.age_48_female:= Amount'Value( gse.Value( cursor, 177 ));
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_target_dataset.age_49_female:= Amount'Value( gse.Value( cursor, 178 ));
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_target_dataset.age_50_female:= Amount'Value( gse.Value( cursor, 179 ));
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_target_dataset.age_51_female:= Amount'Value( gse.Value( cursor, 180 ));
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_target_dataset.age_52_female:= Amount'Value( gse.Value( cursor, 181 ));
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_target_dataset.age_53_female:= Amount'Value( gse.Value( cursor, 182 ));
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_target_dataset.age_54_female:= Amount'Value( gse.Value( cursor, 183 ));
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_target_dataset.age_55_female:= Amount'Value( gse.Value( cursor, 184 ));
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_target_dataset.age_56_female:= Amount'Value( gse.Value( cursor, 185 ));
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_target_dataset.age_57_female:= Amount'Value( gse.Value( cursor, 186 ));
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_target_dataset.age_58_female:= Amount'Value( gse.Value( cursor, 187 ));
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_target_dataset.age_59_female:= Amount'Value( gse.Value( cursor, 188 ));
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_target_dataset.age_60_female:= Amount'Value( gse.Value( cursor, 189 ));
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_target_dataset.age_61_female:= Amount'Value( gse.Value( cursor, 190 ));
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_target_dataset.age_62_female:= Amount'Value( gse.Value( cursor, 191 ));
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_target_dataset.age_63_female:= Amount'Value( gse.Value( cursor, 192 ));
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_target_dataset.age_64_female:= Amount'Value( gse.Value( cursor, 193 ));
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_target_dataset.age_65_female:= Amount'Value( gse.Value( cursor, 194 ));
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_target_dataset.age_66_female:= Amount'Value( gse.Value( cursor, 195 ));
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_target_dataset.age_67_female:= Amount'Value( gse.Value( cursor, 196 ));
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_target_dataset.age_68_female:= Amount'Value( gse.Value( cursor, 197 ));
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_target_dataset.age_69_female:= Amount'Value( gse.Value( cursor, 198 ));
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_target_dataset.age_70_female:= Amount'Value( gse.Value( cursor, 199 ));
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_target_dataset.age_71_female:= Amount'Value( gse.Value( cursor, 200 ));
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_target_dataset.age_72_female:= Amount'Value( gse.Value( cursor, 201 ));
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_target_dataset.age_73_female:= Amount'Value( gse.Value( cursor, 202 ));
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_target_dataset.age_74_female:= Amount'Value( gse.Value( cursor, 203 ));
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_target_dataset.age_75_female:= Amount'Value( gse.Value( cursor, 204 ));
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_target_dataset.age_76_female:= Amount'Value( gse.Value( cursor, 205 ));
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_target_dataset.age_77_female:= Amount'Value( gse.Value( cursor, 206 ));
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_target_dataset.age_78_female:= Amount'Value( gse.Value( cursor, 207 ));
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_target_dataset.age_79_female:= Amount'Value( gse.Value( cursor, 208 ));
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_target_dataset.age_80_female:= Amount'Value( gse.Value( cursor, 209 ));
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_target_dataset.age_81_female:= Amount'Value( gse.Value( cursor, 210 ));
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_target_dataset.age_82_female:= Amount'Value( gse.Value( cursor, 211 ));
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_target_dataset.age_83_female:= Amount'Value( gse.Value( cursor, 212 ));
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_target_dataset.age_84_female:= Amount'Value( gse.Value( cursor, 213 ));
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_target_dataset.age_85_female:= Amount'Value( gse.Value( cursor, 214 ));
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_target_dataset.age_86_female:= Amount'Value( gse.Value( cursor, 215 ));
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_target_dataset.age_87_female:= Amount'Value( gse.Value( cursor, 216 ));
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_target_dataset.age_88_female:= Amount'Value( gse.Value( cursor, 217 ));
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_target_dataset.age_89_female:= Amount'Value( gse.Value( cursor, 218 ));
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_target_dataset.age_90_female:= Amount'Value( gse.Value( cursor, 219 ));
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_target_dataset.age_91_female:= Amount'Value( gse.Value( cursor, 220 ));
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_target_dataset.age_92_female:= Amount'Value( gse.Value( cursor, 221 ));
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_target_dataset.age_93_female:= Amount'Value( gse.Value( cursor, 222 ));
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_target_dataset.age_94_female:= Amount'Value( gse.Value( cursor, 223 ));
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_target_dataset.age_95_female:= Amount'Value( gse.Value( cursor, 224 ));
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_target_dataset.age_96_female:= Amount'Value( gse.Value( cursor, 225 ));
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_target_dataset.age_97_female:= Amount'Value( gse.Value( cursor, 226 ));
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_target_dataset.age_98_female:= Amount'Value( gse.Value( cursor, 227 ));
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_target_dataset.age_99_female:= Amount'Value( gse.Value( cursor, 228 ));
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_target_dataset.age_100_female:= Amount'Value( gse.Value( cursor, 229 ));
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_target_dataset.age_101_female:= Amount'Value( gse.Value( cursor, 230 ));
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_target_dataset.age_102_female:= Amount'Value( gse.Value( cursor, 231 ));
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_target_dataset.age_103_female:= Amount'Value( gse.Value( cursor, 232 ));
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_target_dataset.age_104_female:= Amount'Value( gse.Value( cursor, 233 ));
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_target_dataset.age_105_female:= Amount'Value( gse.Value( cursor, 234 ));
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_target_dataset.age_106_female:= Amount'Value( gse.Value( cursor, 235 ));
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_target_dataset.age_107_female:= Amount'Value( gse.Value( cursor, 236 ));
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_target_dataset.age_108_female:= Amount'Value( gse.Value( cursor, 237 ));
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_target_dataset.age_109_female:= Amount'Value( gse.Value( cursor, 238 ));
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_target_dataset.age_110_female:= Amount'Value( gse.Value( cursor, 239 ));
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_target_dataset.age_0:= Amount'Value( gse.Value( cursor, 240 ));
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_target_dataset.age_1:= Amount'Value( gse.Value( cursor, 241 ));
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_target_dataset.age_2:= Amount'Value( gse.Value( cursor, 242 ));
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_target_dataset.age_3:= Amount'Value( gse.Value( cursor, 243 ));
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_target_dataset.age_4:= Amount'Value( gse.Value( cursor, 244 ));
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_target_dataset.age_5:= Amount'Value( gse.Value( cursor, 245 ));
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_target_dataset.age_6:= Amount'Value( gse.Value( cursor, 246 ));
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_target_dataset.age_7:= Amount'Value( gse.Value( cursor, 247 ));
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_target_dataset.age_8:= Amount'Value( gse.Value( cursor, 248 ));
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_target_dataset.age_9:= Amount'Value( gse.Value( cursor, 249 ));
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_target_dataset.age_10:= Amount'Value( gse.Value( cursor, 250 ));
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_target_dataset.age_11:= Amount'Value( gse.Value( cursor, 251 ));
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_target_dataset.age_12:= Amount'Value( gse.Value( cursor, 252 ));
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_target_dataset.age_13:= Amount'Value( gse.Value( cursor, 253 ));
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_target_dataset.age_14:= Amount'Value( gse.Value( cursor, 254 ));
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_target_dataset.age_15:= Amount'Value( gse.Value( cursor, 255 ));
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_target_dataset.age_16:= Amount'Value( gse.Value( cursor, 256 ));
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_target_dataset.age_17:= Amount'Value( gse.Value( cursor, 257 ));
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_target_dataset.age_18:= Amount'Value( gse.Value( cursor, 258 ));
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_target_dataset.age_19:= Amount'Value( gse.Value( cursor, 259 ));
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_target_dataset.age_20:= Amount'Value( gse.Value( cursor, 260 ));
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_target_dataset.age_21:= Amount'Value( gse.Value( cursor, 261 ));
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_target_dataset.age_22:= Amount'Value( gse.Value( cursor, 262 ));
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_target_dataset.age_23:= Amount'Value( gse.Value( cursor, 263 ));
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_target_dataset.age_24:= Amount'Value( gse.Value( cursor, 264 ));
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_target_dataset.age_25:= Amount'Value( gse.Value( cursor, 265 ));
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_target_dataset.age_26:= Amount'Value( gse.Value( cursor, 266 ));
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_target_dataset.age_27:= Amount'Value( gse.Value( cursor, 267 ));
      end if;
      if not gse.Is_Null( cursor, 268 )then
         a_target_dataset.age_28:= Amount'Value( gse.Value( cursor, 268 ));
      end if;
      if not gse.Is_Null( cursor, 269 )then
         a_target_dataset.age_29:= Amount'Value( gse.Value( cursor, 269 ));
      end if;
      if not gse.Is_Null( cursor, 270 )then
         a_target_dataset.age_30:= Amount'Value( gse.Value( cursor, 270 ));
      end if;
      if not gse.Is_Null( cursor, 271 )then
         a_target_dataset.age_31:= Amount'Value( gse.Value( cursor, 271 ));
      end if;
      if not gse.Is_Null( cursor, 272 )then
         a_target_dataset.age_32:= Amount'Value( gse.Value( cursor, 272 ));
      end if;
      if not gse.Is_Null( cursor, 273 )then
         a_target_dataset.age_33:= Amount'Value( gse.Value( cursor, 273 ));
      end if;
      if not gse.Is_Null( cursor, 274 )then
         a_target_dataset.age_34:= Amount'Value( gse.Value( cursor, 274 ));
      end if;
      if not gse.Is_Null( cursor, 275 )then
         a_target_dataset.age_35:= Amount'Value( gse.Value( cursor, 275 ));
      end if;
      if not gse.Is_Null( cursor, 276 )then
         a_target_dataset.age_36:= Amount'Value( gse.Value( cursor, 276 ));
      end if;
      if not gse.Is_Null( cursor, 277 )then
         a_target_dataset.age_37:= Amount'Value( gse.Value( cursor, 277 ));
      end if;
      if not gse.Is_Null( cursor, 278 )then
         a_target_dataset.age_38:= Amount'Value( gse.Value( cursor, 278 ));
      end if;
      if not gse.Is_Null( cursor, 279 )then
         a_target_dataset.age_39:= Amount'Value( gse.Value( cursor, 279 ));
      end if;
      if not gse.Is_Null( cursor, 280 )then
         a_target_dataset.age_40:= Amount'Value( gse.Value( cursor, 280 ));
      end if;
      if not gse.Is_Null( cursor, 281 )then
         a_target_dataset.age_41:= Amount'Value( gse.Value( cursor, 281 ));
      end if;
      if not gse.Is_Null( cursor, 282 )then
         a_target_dataset.age_42:= Amount'Value( gse.Value( cursor, 282 ));
      end if;
      if not gse.Is_Null( cursor, 283 )then
         a_target_dataset.age_43:= Amount'Value( gse.Value( cursor, 283 ));
      end if;
      if not gse.Is_Null( cursor, 284 )then
         a_target_dataset.age_44:= Amount'Value( gse.Value( cursor, 284 ));
      end if;
      if not gse.Is_Null( cursor, 285 )then
         a_target_dataset.age_45:= Amount'Value( gse.Value( cursor, 285 ));
      end if;
      if not gse.Is_Null( cursor, 286 )then
         a_target_dataset.age_46:= Amount'Value( gse.Value( cursor, 286 ));
      end if;
      if not gse.Is_Null( cursor, 287 )then
         a_target_dataset.age_47:= Amount'Value( gse.Value( cursor, 287 ));
      end if;
      if not gse.Is_Null( cursor, 288 )then
         a_target_dataset.age_48:= Amount'Value( gse.Value( cursor, 288 ));
      end if;
      if not gse.Is_Null( cursor, 289 )then
         a_target_dataset.age_49:= Amount'Value( gse.Value( cursor, 289 ));
      end if;
      if not gse.Is_Null( cursor, 290 )then
         a_target_dataset.age_50:= Amount'Value( gse.Value( cursor, 290 ));
      end if;
      if not gse.Is_Null( cursor, 291 )then
         a_target_dataset.age_51:= Amount'Value( gse.Value( cursor, 291 ));
      end if;
      if not gse.Is_Null( cursor, 292 )then
         a_target_dataset.age_52:= Amount'Value( gse.Value( cursor, 292 ));
      end if;
      if not gse.Is_Null( cursor, 293 )then
         a_target_dataset.age_53:= Amount'Value( gse.Value( cursor, 293 ));
      end if;
      if not gse.Is_Null( cursor, 294 )then
         a_target_dataset.age_54:= Amount'Value( gse.Value( cursor, 294 ));
      end if;
      if not gse.Is_Null( cursor, 295 )then
         a_target_dataset.age_55:= Amount'Value( gse.Value( cursor, 295 ));
      end if;
      if not gse.Is_Null( cursor, 296 )then
         a_target_dataset.age_56:= Amount'Value( gse.Value( cursor, 296 ));
      end if;
      if not gse.Is_Null( cursor, 297 )then
         a_target_dataset.age_57:= Amount'Value( gse.Value( cursor, 297 ));
      end if;
      if not gse.Is_Null( cursor, 298 )then
         a_target_dataset.age_58:= Amount'Value( gse.Value( cursor, 298 ));
      end if;
      if not gse.Is_Null( cursor, 299 )then
         a_target_dataset.age_59:= Amount'Value( gse.Value( cursor, 299 ));
      end if;
      if not gse.Is_Null( cursor, 300 )then
         a_target_dataset.age_60:= Amount'Value( gse.Value( cursor, 300 ));
      end if;
      if not gse.Is_Null( cursor, 301 )then
         a_target_dataset.age_61:= Amount'Value( gse.Value( cursor, 301 ));
      end if;
      if not gse.Is_Null( cursor, 302 )then
         a_target_dataset.age_62:= Amount'Value( gse.Value( cursor, 302 ));
      end if;
      if not gse.Is_Null( cursor, 303 )then
         a_target_dataset.age_63:= Amount'Value( gse.Value( cursor, 303 ));
      end if;
      if not gse.Is_Null( cursor, 304 )then
         a_target_dataset.age_64:= Amount'Value( gse.Value( cursor, 304 ));
      end if;
      if not gse.Is_Null( cursor, 305 )then
         a_target_dataset.age_65:= Amount'Value( gse.Value( cursor, 305 ));
      end if;
      if not gse.Is_Null( cursor, 306 )then
         a_target_dataset.age_66:= Amount'Value( gse.Value( cursor, 306 ));
      end if;
      if not gse.Is_Null( cursor, 307 )then
         a_target_dataset.age_67:= Amount'Value( gse.Value( cursor, 307 ));
      end if;
      if not gse.Is_Null( cursor, 308 )then
         a_target_dataset.age_68:= Amount'Value( gse.Value( cursor, 308 ));
      end if;
      if not gse.Is_Null( cursor, 309 )then
         a_target_dataset.age_69:= Amount'Value( gse.Value( cursor, 309 ));
      end if;
      if not gse.Is_Null( cursor, 310 )then
         a_target_dataset.age_70:= Amount'Value( gse.Value( cursor, 310 ));
      end if;
      if not gse.Is_Null( cursor, 311 )then
         a_target_dataset.age_71:= Amount'Value( gse.Value( cursor, 311 ));
      end if;
      if not gse.Is_Null( cursor, 312 )then
         a_target_dataset.age_72:= Amount'Value( gse.Value( cursor, 312 ));
      end if;
      if not gse.Is_Null( cursor, 313 )then
         a_target_dataset.age_73:= Amount'Value( gse.Value( cursor, 313 ));
      end if;
      if not gse.Is_Null( cursor, 314 )then
         a_target_dataset.age_74:= Amount'Value( gse.Value( cursor, 314 ));
      end if;
      if not gse.Is_Null( cursor, 315 )then
         a_target_dataset.age_75:= Amount'Value( gse.Value( cursor, 315 ));
      end if;
      if not gse.Is_Null( cursor, 316 )then
         a_target_dataset.age_76:= Amount'Value( gse.Value( cursor, 316 ));
      end if;
      if not gse.Is_Null( cursor, 317 )then
         a_target_dataset.age_77:= Amount'Value( gse.Value( cursor, 317 ));
      end if;
      if not gse.Is_Null( cursor, 318 )then
         a_target_dataset.age_78:= Amount'Value( gse.Value( cursor, 318 ));
      end if;
      if not gse.Is_Null( cursor, 319 )then
         a_target_dataset.age_79:= Amount'Value( gse.Value( cursor, 319 ));
      end if;
      if not gse.Is_Null( cursor, 320 )then
         a_target_dataset.age_80:= Amount'Value( gse.Value( cursor, 320 ));
      end if;
      if not gse.Is_Null( cursor, 321 )then
         a_target_dataset.age_81:= Amount'Value( gse.Value( cursor, 321 ));
      end if;
      if not gse.Is_Null( cursor, 322 )then
         a_target_dataset.age_82:= Amount'Value( gse.Value( cursor, 322 ));
      end if;
      if not gse.Is_Null( cursor, 323 )then
         a_target_dataset.age_83:= Amount'Value( gse.Value( cursor, 323 ));
      end if;
      if not gse.Is_Null( cursor, 324 )then
         a_target_dataset.age_84:= Amount'Value( gse.Value( cursor, 324 ));
      end if;
      if not gse.Is_Null( cursor, 325 )then
         a_target_dataset.age_85:= Amount'Value( gse.Value( cursor, 325 ));
      end if;
      if not gse.Is_Null( cursor, 326 )then
         a_target_dataset.age_86:= Amount'Value( gse.Value( cursor, 326 ));
      end if;
      if not gse.Is_Null( cursor, 327 )then
         a_target_dataset.age_87:= Amount'Value( gse.Value( cursor, 327 ));
      end if;
      if not gse.Is_Null( cursor, 328 )then
         a_target_dataset.age_88:= Amount'Value( gse.Value( cursor, 328 ));
      end if;
      if not gse.Is_Null( cursor, 329 )then
         a_target_dataset.age_89:= Amount'Value( gse.Value( cursor, 329 ));
      end if;
      if not gse.Is_Null( cursor, 330 )then
         a_target_dataset.age_90:= Amount'Value( gse.Value( cursor, 330 ));
      end if;
      if not gse.Is_Null( cursor, 331 )then
         a_target_dataset.age_91:= Amount'Value( gse.Value( cursor, 331 ));
      end if;
      if not gse.Is_Null( cursor, 332 )then
         a_target_dataset.age_92:= Amount'Value( gse.Value( cursor, 332 ));
      end if;
      if not gse.Is_Null( cursor, 333 )then
         a_target_dataset.age_93:= Amount'Value( gse.Value( cursor, 333 ));
      end if;
      if not gse.Is_Null( cursor, 334 )then
         a_target_dataset.age_94:= Amount'Value( gse.Value( cursor, 334 ));
      end if;
      if not gse.Is_Null( cursor, 335 )then
         a_target_dataset.age_95:= Amount'Value( gse.Value( cursor, 335 ));
      end if;
      if not gse.Is_Null( cursor, 336 )then
         a_target_dataset.age_96:= Amount'Value( gse.Value( cursor, 336 ));
      end if;
      if not gse.Is_Null( cursor, 337 )then
         a_target_dataset.age_97:= Amount'Value( gse.Value( cursor, 337 ));
      end if;
      if not gse.Is_Null( cursor, 338 )then
         a_target_dataset.age_98:= Amount'Value( gse.Value( cursor, 338 ));
      end if;
      if not gse.Is_Null( cursor, 339 )then
         a_target_dataset.age_99:= Amount'Value( gse.Value( cursor, 339 ));
      end if;
      if not gse.Is_Null( cursor, 340 )then
         a_target_dataset.age_100:= Amount'Value( gse.Value( cursor, 340 ));
      end if;
      if not gse.Is_Null( cursor, 341 )then
         a_target_dataset.age_101:= Amount'Value( gse.Value( cursor, 341 ));
      end if;
      if not gse.Is_Null( cursor, 342 )then
         a_target_dataset.age_102:= Amount'Value( gse.Value( cursor, 342 ));
      end if;
      if not gse.Is_Null( cursor, 343 )then
         a_target_dataset.age_103:= Amount'Value( gse.Value( cursor, 343 ));
      end if;
      if not gse.Is_Null( cursor, 344 )then
         a_target_dataset.age_104:= Amount'Value( gse.Value( cursor, 344 ));
      end if;
      if not gse.Is_Null( cursor, 345 )then
         a_target_dataset.age_105:= Amount'Value( gse.Value( cursor, 345 ));
      end if;
      if not gse.Is_Null( cursor, 346 )then
         a_target_dataset.age_106:= Amount'Value( gse.Value( cursor, 346 ));
      end if;
      if not gse.Is_Null( cursor, 347 )then
         a_target_dataset.age_107:= Amount'Value( gse.Value( cursor, 347 ));
      end if;
      if not gse.Is_Null( cursor, 348 )then
         a_target_dataset.age_108:= Amount'Value( gse.Value( cursor, 348 ));
      end if;
      if not gse.Is_Null( cursor, 349 )then
         a_target_dataset.age_109:= Amount'Value( gse.Value( cursor, 349 ));
      end if;
      if not gse.Is_Null( cursor, 350 )then
         a_target_dataset.age_110:= Amount'Value( gse.Value( cursor, 350 ));
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

      params( 1 ) := "+"( Float( a_target_dataset.household_one_adult_male ));
      params( 2 ) := "+"( Float( a_target_dataset.household_one_adult_female ));
      params( 3 ) := "+"( Float( a_target_dataset.household_two_adults ));
      params( 4 ) := "+"( Float( a_target_dataset.household_one_adult_one_child ));
      params( 5 ) := "+"( Float( a_target_dataset.household_one_adult_two_plus_children ));
      params( 6 ) := "+"( Float( a_target_dataset.household_two_plus_adult_one_plus_children ));
      params( 7 ) := "+"( Float( a_target_dataset.household_three_plus_person_all_adult ));
      params( 8 ) := "+"( Float( a_target_dataset.household_all_households ));
      params( 9 ) := "+"( Float( a_target_dataset.male ));
      params( 10 ) := "+"( Float( a_target_dataset.female ));
      params( 11 ) := "+"( Float( a_target_dataset.employed ));
      params( 12 ) := "+"( Float( a_target_dataset.employee ));
      params( 13 ) := "+"( Float( a_target_dataset.ilo_unemployed ));
      params( 14 ) := "+"( Float( a_target_dataset.jsa_claimant ));
      params( 15 ) := "+"( Float( a_target_dataset.age_0_male ));
      params( 16 ) := "+"( Float( a_target_dataset.age_1_male ));
      params( 17 ) := "+"( Float( a_target_dataset.age_2_male ));
      params( 18 ) := "+"( Float( a_target_dataset.age_3_male ));
      params( 19 ) := "+"( Float( a_target_dataset.age_4_male ));
      params( 20 ) := "+"( Float( a_target_dataset.age_5_male ));
      params( 21 ) := "+"( Float( a_target_dataset.age_6_male ));
      params( 22 ) := "+"( Float( a_target_dataset.age_7_male ));
      params( 23 ) := "+"( Float( a_target_dataset.age_8_male ));
      params( 24 ) := "+"( Float( a_target_dataset.age_9_male ));
      params( 25 ) := "+"( Float( a_target_dataset.age_10_male ));
      params( 26 ) := "+"( Float( a_target_dataset.age_11_male ));
      params( 27 ) := "+"( Float( a_target_dataset.age_12_male ));
      params( 28 ) := "+"( Float( a_target_dataset.age_13_male ));
      params( 29 ) := "+"( Float( a_target_dataset.age_14_male ));
      params( 30 ) := "+"( Float( a_target_dataset.age_15_male ));
      params( 31 ) := "+"( Float( a_target_dataset.age_16_male ));
      params( 32 ) := "+"( Float( a_target_dataset.age_17_male ));
      params( 33 ) := "+"( Float( a_target_dataset.age_18_male ));
      params( 34 ) := "+"( Float( a_target_dataset.age_19_male ));
      params( 35 ) := "+"( Float( a_target_dataset.age_20_male ));
      params( 36 ) := "+"( Float( a_target_dataset.age_21_male ));
      params( 37 ) := "+"( Float( a_target_dataset.age_22_male ));
      params( 38 ) := "+"( Float( a_target_dataset.age_23_male ));
      params( 39 ) := "+"( Float( a_target_dataset.age_24_male ));
      params( 40 ) := "+"( Float( a_target_dataset.age_25_male ));
      params( 41 ) := "+"( Float( a_target_dataset.age_26_male ));
      params( 42 ) := "+"( Float( a_target_dataset.age_27_male ));
      params( 43 ) := "+"( Float( a_target_dataset.age_28_male ));
      params( 44 ) := "+"( Float( a_target_dataset.age_29_male ));
      params( 45 ) := "+"( Float( a_target_dataset.age_30_male ));
      params( 46 ) := "+"( Float( a_target_dataset.age_31_male ));
      params( 47 ) := "+"( Float( a_target_dataset.age_32_male ));
      params( 48 ) := "+"( Float( a_target_dataset.age_33_male ));
      params( 49 ) := "+"( Float( a_target_dataset.age_34_male ));
      params( 50 ) := "+"( Float( a_target_dataset.age_35_male ));
      params( 51 ) := "+"( Float( a_target_dataset.age_36_male ));
      params( 52 ) := "+"( Float( a_target_dataset.age_37_male ));
      params( 53 ) := "+"( Float( a_target_dataset.age_38_male ));
      params( 54 ) := "+"( Float( a_target_dataset.age_39_male ));
      params( 55 ) := "+"( Float( a_target_dataset.age_40_male ));
      params( 56 ) := "+"( Float( a_target_dataset.age_41_male ));
      params( 57 ) := "+"( Float( a_target_dataset.age_42_male ));
      params( 58 ) := "+"( Float( a_target_dataset.age_43_male ));
      params( 59 ) := "+"( Float( a_target_dataset.age_44_male ));
      params( 60 ) := "+"( Float( a_target_dataset.age_45_male ));
      params( 61 ) := "+"( Float( a_target_dataset.age_46_male ));
      params( 62 ) := "+"( Float( a_target_dataset.age_47_male ));
      params( 63 ) := "+"( Float( a_target_dataset.age_48_male ));
      params( 64 ) := "+"( Float( a_target_dataset.age_49_male ));
      params( 65 ) := "+"( Float( a_target_dataset.age_50_male ));
      params( 66 ) := "+"( Float( a_target_dataset.age_51_male ));
      params( 67 ) := "+"( Float( a_target_dataset.age_52_male ));
      params( 68 ) := "+"( Float( a_target_dataset.age_53_male ));
      params( 69 ) := "+"( Float( a_target_dataset.age_54_male ));
      params( 70 ) := "+"( Float( a_target_dataset.age_55_male ));
      params( 71 ) := "+"( Float( a_target_dataset.age_56_male ));
      params( 72 ) := "+"( Float( a_target_dataset.age_57_male ));
      params( 73 ) := "+"( Float( a_target_dataset.age_58_male ));
      params( 74 ) := "+"( Float( a_target_dataset.age_59_male ));
      params( 75 ) := "+"( Float( a_target_dataset.age_60_male ));
      params( 76 ) := "+"( Float( a_target_dataset.age_61_male ));
      params( 77 ) := "+"( Float( a_target_dataset.age_62_male ));
      params( 78 ) := "+"( Float( a_target_dataset.age_63_male ));
      params( 79 ) := "+"( Float( a_target_dataset.age_64_male ));
      params( 80 ) := "+"( Float( a_target_dataset.age_65_male ));
      params( 81 ) := "+"( Float( a_target_dataset.age_66_male ));
      params( 82 ) := "+"( Float( a_target_dataset.age_67_male ));
      params( 83 ) := "+"( Float( a_target_dataset.age_68_male ));
      params( 84 ) := "+"( Float( a_target_dataset.age_69_male ));
      params( 85 ) := "+"( Float( a_target_dataset.age_70_male ));
      params( 86 ) := "+"( Float( a_target_dataset.age_71_male ));
      params( 87 ) := "+"( Float( a_target_dataset.age_72_male ));
      params( 88 ) := "+"( Float( a_target_dataset.age_73_male ));
      params( 89 ) := "+"( Float( a_target_dataset.age_74_male ));
      params( 90 ) := "+"( Float( a_target_dataset.age_75_male ));
      params( 91 ) := "+"( Float( a_target_dataset.age_76_male ));
      params( 92 ) := "+"( Float( a_target_dataset.age_77_male ));
      params( 93 ) := "+"( Float( a_target_dataset.age_78_male ));
      params( 94 ) := "+"( Float( a_target_dataset.age_79_male ));
      params( 95 ) := "+"( Float( a_target_dataset.age_80_male ));
      params( 96 ) := "+"( Float( a_target_dataset.age_81_male ));
      params( 97 ) := "+"( Float( a_target_dataset.age_82_male ));
      params( 98 ) := "+"( Float( a_target_dataset.age_83_male ));
      params( 99 ) := "+"( Float( a_target_dataset.age_84_male ));
      params( 100 ) := "+"( Float( a_target_dataset.age_85_male ));
      params( 101 ) := "+"( Float( a_target_dataset.age_86_male ));
      params( 102 ) := "+"( Float( a_target_dataset.age_87_male ));
      params( 103 ) := "+"( Float( a_target_dataset.age_88_male ));
      params( 104 ) := "+"( Float( a_target_dataset.age_89_male ));
      params( 105 ) := "+"( Float( a_target_dataset.age_90_male ));
      params( 106 ) := "+"( Float( a_target_dataset.age_91_male ));
      params( 107 ) := "+"( Float( a_target_dataset.age_92_male ));
      params( 108 ) := "+"( Float( a_target_dataset.age_93_male ));
      params( 109 ) := "+"( Float( a_target_dataset.age_94_male ));
      params( 110 ) := "+"( Float( a_target_dataset.age_95_male ));
      params( 111 ) := "+"( Float( a_target_dataset.age_96_male ));
      params( 112 ) := "+"( Float( a_target_dataset.age_97_male ));
      params( 113 ) := "+"( Float( a_target_dataset.age_98_male ));
      params( 114 ) := "+"( Float( a_target_dataset.age_99_male ));
      params( 115 ) := "+"( Float( a_target_dataset.age_100_male ));
      params( 116 ) := "+"( Float( a_target_dataset.age_101_male ));
      params( 117 ) := "+"( Float( a_target_dataset.age_102_male ));
      params( 118 ) := "+"( Float( a_target_dataset.age_103_male ));
      params( 119 ) := "+"( Float( a_target_dataset.age_104_male ));
      params( 120 ) := "+"( Float( a_target_dataset.age_105_male ));
      params( 121 ) := "+"( Float( a_target_dataset.age_106_male ));
      params( 122 ) := "+"( Float( a_target_dataset.age_107_male ));
      params( 123 ) := "+"( Float( a_target_dataset.age_108_male ));
      params( 124 ) := "+"( Float( a_target_dataset.age_109_male ));
      params( 125 ) := "+"( Float( a_target_dataset.age_110_male ));
      params( 126 ) := "+"( Float( a_target_dataset.age_0_female ));
      params( 127 ) := "+"( Float( a_target_dataset.age_1_female ));
      params( 128 ) := "+"( Float( a_target_dataset.age_2_female ));
      params( 129 ) := "+"( Float( a_target_dataset.age_3_female ));
      params( 130 ) := "+"( Float( a_target_dataset.age_4_female ));
      params( 131 ) := "+"( Float( a_target_dataset.age_5_female ));
      params( 132 ) := "+"( Float( a_target_dataset.age_6_female ));
      params( 133 ) := "+"( Float( a_target_dataset.age_7_female ));
      params( 134 ) := "+"( Float( a_target_dataset.age_8_female ));
      params( 135 ) := "+"( Float( a_target_dataset.age_9_female ));
      params( 136 ) := "+"( Float( a_target_dataset.age_10_female ));
      params( 137 ) := "+"( Float( a_target_dataset.age_11_female ));
      params( 138 ) := "+"( Float( a_target_dataset.age_12_female ));
      params( 139 ) := "+"( Float( a_target_dataset.age_13_female ));
      params( 140 ) := "+"( Float( a_target_dataset.age_14_female ));
      params( 141 ) := "+"( Float( a_target_dataset.age_15_female ));
      params( 142 ) := "+"( Float( a_target_dataset.age_16_female ));
      params( 143 ) := "+"( Float( a_target_dataset.age_17_female ));
      params( 144 ) := "+"( Float( a_target_dataset.age_18_female ));
      params( 145 ) := "+"( Float( a_target_dataset.age_19_female ));
      params( 146 ) := "+"( Float( a_target_dataset.age_20_female ));
      params( 147 ) := "+"( Float( a_target_dataset.age_21_female ));
      params( 148 ) := "+"( Float( a_target_dataset.age_22_female ));
      params( 149 ) := "+"( Float( a_target_dataset.age_23_female ));
      params( 150 ) := "+"( Float( a_target_dataset.age_24_female ));
      params( 151 ) := "+"( Float( a_target_dataset.age_25_female ));
      params( 152 ) := "+"( Float( a_target_dataset.age_26_female ));
      params( 153 ) := "+"( Float( a_target_dataset.age_27_female ));
      params( 154 ) := "+"( Float( a_target_dataset.age_28_female ));
      params( 155 ) := "+"( Float( a_target_dataset.age_29_female ));
      params( 156 ) := "+"( Float( a_target_dataset.age_30_female ));
      params( 157 ) := "+"( Float( a_target_dataset.age_31_female ));
      params( 158 ) := "+"( Float( a_target_dataset.age_32_female ));
      params( 159 ) := "+"( Float( a_target_dataset.age_33_female ));
      params( 160 ) := "+"( Float( a_target_dataset.age_34_female ));
      params( 161 ) := "+"( Float( a_target_dataset.age_35_female ));
      params( 162 ) := "+"( Float( a_target_dataset.age_36_female ));
      params( 163 ) := "+"( Float( a_target_dataset.age_37_female ));
      params( 164 ) := "+"( Float( a_target_dataset.age_38_female ));
      params( 165 ) := "+"( Float( a_target_dataset.age_39_female ));
      params( 166 ) := "+"( Float( a_target_dataset.age_40_female ));
      params( 167 ) := "+"( Float( a_target_dataset.age_41_female ));
      params( 168 ) := "+"( Float( a_target_dataset.age_42_female ));
      params( 169 ) := "+"( Float( a_target_dataset.age_43_female ));
      params( 170 ) := "+"( Float( a_target_dataset.age_44_female ));
      params( 171 ) := "+"( Float( a_target_dataset.age_45_female ));
      params( 172 ) := "+"( Float( a_target_dataset.age_46_female ));
      params( 173 ) := "+"( Float( a_target_dataset.age_47_female ));
      params( 174 ) := "+"( Float( a_target_dataset.age_48_female ));
      params( 175 ) := "+"( Float( a_target_dataset.age_49_female ));
      params( 176 ) := "+"( Float( a_target_dataset.age_50_female ));
      params( 177 ) := "+"( Float( a_target_dataset.age_51_female ));
      params( 178 ) := "+"( Float( a_target_dataset.age_52_female ));
      params( 179 ) := "+"( Float( a_target_dataset.age_53_female ));
      params( 180 ) := "+"( Float( a_target_dataset.age_54_female ));
      params( 181 ) := "+"( Float( a_target_dataset.age_55_female ));
      params( 182 ) := "+"( Float( a_target_dataset.age_56_female ));
      params( 183 ) := "+"( Float( a_target_dataset.age_57_female ));
      params( 184 ) := "+"( Float( a_target_dataset.age_58_female ));
      params( 185 ) := "+"( Float( a_target_dataset.age_59_female ));
      params( 186 ) := "+"( Float( a_target_dataset.age_60_female ));
      params( 187 ) := "+"( Float( a_target_dataset.age_61_female ));
      params( 188 ) := "+"( Float( a_target_dataset.age_62_female ));
      params( 189 ) := "+"( Float( a_target_dataset.age_63_female ));
      params( 190 ) := "+"( Float( a_target_dataset.age_64_female ));
      params( 191 ) := "+"( Float( a_target_dataset.age_65_female ));
      params( 192 ) := "+"( Float( a_target_dataset.age_66_female ));
      params( 193 ) := "+"( Float( a_target_dataset.age_67_female ));
      params( 194 ) := "+"( Float( a_target_dataset.age_68_female ));
      params( 195 ) := "+"( Float( a_target_dataset.age_69_female ));
      params( 196 ) := "+"( Float( a_target_dataset.age_70_female ));
      params( 197 ) := "+"( Float( a_target_dataset.age_71_female ));
      params( 198 ) := "+"( Float( a_target_dataset.age_72_female ));
      params( 199 ) := "+"( Float( a_target_dataset.age_73_female ));
      params( 200 ) := "+"( Float( a_target_dataset.age_74_female ));
      params( 201 ) := "+"( Float( a_target_dataset.age_75_female ));
      params( 202 ) := "+"( Float( a_target_dataset.age_76_female ));
      params( 203 ) := "+"( Float( a_target_dataset.age_77_female ));
      params( 204 ) := "+"( Float( a_target_dataset.age_78_female ));
      params( 205 ) := "+"( Float( a_target_dataset.age_79_female ));
      params( 206 ) := "+"( Float( a_target_dataset.age_80_female ));
      params( 207 ) := "+"( Float( a_target_dataset.age_81_female ));
      params( 208 ) := "+"( Float( a_target_dataset.age_82_female ));
      params( 209 ) := "+"( Float( a_target_dataset.age_83_female ));
      params( 210 ) := "+"( Float( a_target_dataset.age_84_female ));
      params( 211 ) := "+"( Float( a_target_dataset.age_85_female ));
      params( 212 ) := "+"( Float( a_target_dataset.age_86_female ));
      params( 213 ) := "+"( Float( a_target_dataset.age_87_female ));
      params( 214 ) := "+"( Float( a_target_dataset.age_88_female ));
      params( 215 ) := "+"( Float( a_target_dataset.age_89_female ));
      params( 216 ) := "+"( Float( a_target_dataset.age_90_female ));
      params( 217 ) := "+"( Float( a_target_dataset.age_91_female ));
      params( 218 ) := "+"( Float( a_target_dataset.age_92_female ));
      params( 219 ) := "+"( Float( a_target_dataset.age_93_female ));
      params( 220 ) := "+"( Float( a_target_dataset.age_94_female ));
      params( 221 ) := "+"( Float( a_target_dataset.age_95_female ));
      params( 222 ) := "+"( Float( a_target_dataset.age_96_female ));
      params( 223 ) := "+"( Float( a_target_dataset.age_97_female ));
      params( 224 ) := "+"( Float( a_target_dataset.age_98_female ));
      params( 225 ) := "+"( Float( a_target_dataset.age_99_female ));
      params( 226 ) := "+"( Float( a_target_dataset.age_100_female ));
      params( 227 ) := "+"( Float( a_target_dataset.age_101_female ));
      params( 228 ) := "+"( Float( a_target_dataset.age_102_female ));
      params( 229 ) := "+"( Float( a_target_dataset.age_103_female ));
      params( 230 ) := "+"( Float( a_target_dataset.age_104_female ));
      params( 231 ) := "+"( Float( a_target_dataset.age_105_female ));
      params( 232 ) := "+"( Float( a_target_dataset.age_106_female ));
      params( 233 ) := "+"( Float( a_target_dataset.age_107_female ));
      params( 234 ) := "+"( Float( a_target_dataset.age_108_female ));
      params( 235 ) := "+"( Float( a_target_dataset.age_109_female ));
      params( 236 ) := "+"( Float( a_target_dataset.age_110_female ));
      params( 237 ) := "+"( Float( a_target_dataset.age_0 ));
      params( 238 ) := "+"( Float( a_target_dataset.age_1 ));
      params( 239 ) := "+"( Float( a_target_dataset.age_2 ));
      params( 240 ) := "+"( Float( a_target_dataset.age_3 ));
      params( 241 ) := "+"( Float( a_target_dataset.age_4 ));
      params( 242 ) := "+"( Float( a_target_dataset.age_5 ));
      params( 243 ) := "+"( Float( a_target_dataset.age_6 ));
      params( 244 ) := "+"( Float( a_target_dataset.age_7 ));
      params( 245 ) := "+"( Float( a_target_dataset.age_8 ));
      params( 246 ) := "+"( Float( a_target_dataset.age_9 ));
      params( 247 ) := "+"( Float( a_target_dataset.age_10 ));
      params( 248 ) := "+"( Float( a_target_dataset.age_11 ));
      params( 249 ) := "+"( Float( a_target_dataset.age_12 ));
      params( 250 ) := "+"( Float( a_target_dataset.age_13 ));
      params( 251 ) := "+"( Float( a_target_dataset.age_14 ));
      params( 252 ) := "+"( Float( a_target_dataset.age_15 ));
      params( 253 ) := "+"( Float( a_target_dataset.age_16 ));
      params( 254 ) := "+"( Float( a_target_dataset.age_17 ));
      params( 255 ) := "+"( Float( a_target_dataset.age_18 ));
      params( 256 ) := "+"( Float( a_target_dataset.age_19 ));
      params( 257 ) := "+"( Float( a_target_dataset.age_20 ));
      params( 258 ) := "+"( Float( a_target_dataset.age_21 ));
      params( 259 ) := "+"( Float( a_target_dataset.age_22 ));
      params( 260 ) := "+"( Float( a_target_dataset.age_23 ));
      params( 261 ) := "+"( Float( a_target_dataset.age_24 ));
      params( 262 ) := "+"( Float( a_target_dataset.age_25 ));
      params( 263 ) := "+"( Float( a_target_dataset.age_26 ));
      params( 264 ) := "+"( Float( a_target_dataset.age_27 ));
      params( 265 ) := "+"( Float( a_target_dataset.age_28 ));
      params( 266 ) := "+"( Float( a_target_dataset.age_29 ));
      params( 267 ) := "+"( Float( a_target_dataset.age_30 ));
      params( 268 ) := "+"( Float( a_target_dataset.age_31 ));
      params( 269 ) := "+"( Float( a_target_dataset.age_32 ));
      params( 270 ) := "+"( Float( a_target_dataset.age_33 ));
      params( 271 ) := "+"( Float( a_target_dataset.age_34 ));
      params( 272 ) := "+"( Float( a_target_dataset.age_35 ));
      params( 273 ) := "+"( Float( a_target_dataset.age_36 ));
      params( 274 ) := "+"( Float( a_target_dataset.age_37 ));
      params( 275 ) := "+"( Float( a_target_dataset.age_38 ));
      params( 276 ) := "+"( Float( a_target_dataset.age_39 ));
      params( 277 ) := "+"( Float( a_target_dataset.age_40 ));
      params( 278 ) := "+"( Float( a_target_dataset.age_41 ));
      params( 279 ) := "+"( Float( a_target_dataset.age_42 ));
      params( 280 ) := "+"( Float( a_target_dataset.age_43 ));
      params( 281 ) := "+"( Float( a_target_dataset.age_44 ));
      params( 282 ) := "+"( Float( a_target_dataset.age_45 ));
      params( 283 ) := "+"( Float( a_target_dataset.age_46 ));
      params( 284 ) := "+"( Float( a_target_dataset.age_47 ));
      params( 285 ) := "+"( Float( a_target_dataset.age_48 ));
      params( 286 ) := "+"( Float( a_target_dataset.age_49 ));
      params( 287 ) := "+"( Float( a_target_dataset.age_50 ));
      params( 288 ) := "+"( Float( a_target_dataset.age_51 ));
      params( 289 ) := "+"( Float( a_target_dataset.age_52 ));
      params( 290 ) := "+"( Float( a_target_dataset.age_53 ));
      params( 291 ) := "+"( Float( a_target_dataset.age_54 ));
      params( 292 ) := "+"( Float( a_target_dataset.age_55 ));
      params( 293 ) := "+"( Float( a_target_dataset.age_56 ));
      params( 294 ) := "+"( Float( a_target_dataset.age_57 ));
      params( 295 ) := "+"( Float( a_target_dataset.age_58 ));
      params( 296 ) := "+"( Float( a_target_dataset.age_59 ));
      params( 297 ) := "+"( Float( a_target_dataset.age_60 ));
      params( 298 ) := "+"( Float( a_target_dataset.age_61 ));
      params( 299 ) := "+"( Float( a_target_dataset.age_62 ));
      params( 300 ) := "+"( Float( a_target_dataset.age_63 ));
      params( 301 ) := "+"( Float( a_target_dataset.age_64 ));
      params( 302 ) := "+"( Float( a_target_dataset.age_65 ));
      params( 303 ) := "+"( Float( a_target_dataset.age_66 ));
      params( 304 ) := "+"( Float( a_target_dataset.age_67 ));
      params( 305 ) := "+"( Float( a_target_dataset.age_68 ));
      params( 306 ) := "+"( Float( a_target_dataset.age_69 ));
      params( 307 ) := "+"( Float( a_target_dataset.age_70 ));
      params( 308 ) := "+"( Float( a_target_dataset.age_71 ));
      params( 309 ) := "+"( Float( a_target_dataset.age_72 ));
      params( 310 ) := "+"( Float( a_target_dataset.age_73 ));
      params( 311 ) := "+"( Float( a_target_dataset.age_74 ));
      params( 312 ) := "+"( Float( a_target_dataset.age_75 ));
      params( 313 ) := "+"( Float( a_target_dataset.age_76 ));
      params( 314 ) := "+"( Float( a_target_dataset.age_77 ));
      params( 315 ) := "+"( Float( a_target_dataset.age_78 ));
      params( 316 ) := "+"( Float( a_target_dataset.age_79 ));
      params( 317 ) := "+"( Float( a_target_dataset.age_80 ));
      params( 318 ) := "+"( Float( a_target_dataset.age_81 ));
      params( 319 ) := "+"( Float( a_target_dataset.age_82 ));
      params( 320 ) := "+"( Float( a_target_dataset.age_83 ));
      params( 321 ) := "+"( Float( a_target_dataset.age_84 ));
      params( 322 ) := "+"( Float( a_target_dataset.age_85 ));
      params( 323 ) := "+"( Float( a_target_dataset.age_86 ));
      params( 324 ) := "+"( Float( a_target_dataset.age_87 ));
      params( 325 ) := "+"( Float( a_target_dataset.age_88 ));
      params( 326 ) := "+"( Float( a_target_dataset.age_89 ));
      params( 327 ) := "+"( Float( a_target_dataset.age_90 ));
      params( 328 ) := "+"( Float( a_target_dataset.age_91 ));
      params( 329 ) := "+"( Float( a_target_dataset.age_92 ));
      params( 330 ) := "+"( Float( a_target_dataset.age_93 ));
      params( 331 ) := "+"( Float( a_target_dataset.age_94 ));
      params( 332 ) := "+"( Float( a_target_dataset.age_95 ));
      params( 333 ) := "+"( Float( a_target_dataset.age_96 ));
      params( 334 ) := "+"( Float( a_target_dataset.age_97 ));
      params( 335 ) := "+"( Float( a_target_dataset.age_98 ));
      params( 336 ) := "+"( Float( a_target_dataset.age_99 ));
      params( 337 ) := "+"( Float( a_target_dataset.age_100 ));
      params( 338 ) := "+"( Float( a_target_dataset.age_101 ));
      params( 339 ) := "+"( Float( a_target_dataset.age_102 ));
      params( 340 ) := "+"( Float( a_target_dataset.age_103 ));
      params( 341 ) := "+"( Float( a_target_dataset.age_104 ));
      params( 342 ) := "+"( Float( a_target_dataset.age_105 ));
      params( 343 ) := "+"( Float( a_target_dataset.age_106 ));
      params( 344 ) := "+"( Float( a_target_dataset.age_107 ));
      params( 345 ) := "+"( Float( a_target_dataset.age_108 ));
      params( 346 ) := "+"( Float( a_target_dataset.age_109 ));
      params( 347 ) := "+"( Float( a_target_dataset.age_110 ));
      params( 348 ) := "+"( Integer'Pos( a_target_dataset.run_id ));
      params( 349 ) := "+"( Integer'Pos( a_target_dataset.user_id ));
      params( 350 ) := "+"( Integer'Pos( a_target_dataset.year ));
      params( 351 ) := As_Bigint( a_target_dataset.sernum );
      
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
      params( 3 ) := "+"( Integer'Pos( a_target_dataset.year ));
      params( 4 ) := As_Bigint( a_target_dataset.sernum );
      params( 5 ) := "+"( Float( a_target_dataset.household_one_adult_male ));
      params( 6 ) := "+"( Float( a_target_dataset.household_one_adult_female ));
      params( 7 ) := "+"( Float( a_target_dataset.household_two_adults ));
      params( 8 ) := "+"( Float( a_target_dataset.household_one_adult_one_child ));
      params( 9 ) := "+"( Float( a_target_dataset.household_one_adult_two_plus_children ));
      params( 10 ) := "+"( Float( a_target_dataset.household_two_plus_adult_one_plus_children ));
      params( 11 ) := "+"( Float( a_target_dataset.household_three_plus_person_all_adult ));
      params( 12 ) := "+"( Float( a_target_dataset.household_all_households ));
      params( 13 ) := "+"( Float( a_target_dataset.male ));
      params( 14 ) := "+"( Float( a_target_dataset.female ));
      params( 15 ) := "+"( Float( a_target_dataset.employed ));
      params( 16 ) := "+"( Float( a_target_dataset.employee ));
      params( 17 ) := "+"( Float( a_target_dataset.ilo_unemployed ));
      params( 18 ) := "+"( Float( a_target_dataset.jsa_claimant ));
      params( 19 ) := "+"( Float( a_target_dataset.age_0_male ));
      params( 20 ) := "+"( Float( a_target_dataset.age_1_male ));
      params( 21 ) := "+"( Float( a_target_dataset.age_2_male ));
      params( 22 ) := "+"( Float( a_target_dataset.age_3_male ));
      params( 23 ) := "+"( Float( a_target_dataset.age_4_male ));
      params( 24 ) := "+"( Float( a_target_dataset.age_5_male ));
      params( 25 ) := "+"( Float( a_target_dataset.age_6_male ));
      params( 26 ) := "+"( Float( a_target_dataset.age_7_male ));
      params( 27 ) := "+"( Float( a_target_dataset.age_8_male ));
      params( 28 ) := "+"( Float( a_target_dataset.age_9_male ));
      params( 29 ) := "+"( Float( a_target_dataset.age_10_male ));
      params( 30 ) := "+"( Float( a_target_dataset.age_11_male ));
      params( 31 ) := "+"( Float( a_target_dataset.age_12_male ));
      params( 32 ) := "+"( Float( a_target_dataset.age_13_male ));
      params( 33 ) := "+"( Float( a_target_dataset.age_14_male ));
      params( 34 ) := "+"( Float( a_target_dataset.age_15_male ));
      params( 35 ) := "+"( Float( a_target_dataset.age_16_male ));
      params( 36 ) := "+"( Float( a_target_dataset.age_17_male ));
      params( 37 ) := "+"( Float( a_target_dataset.age_18_male ));
      params( 38 ) := "+"( Float( a_target_dataset.age_19_male ));
      params( 39 ) := "+"( Float( a_target_dataset.age_20_male ));
      params( 40 ) := "+"( Float( a_target_dataset.age_21_male ));
      params( 41 ) := "+"( Float( a_target_dataset.age_22_male ));
      params( 42 ) := "+"( Float( a_target_dataset.age_23_male ));
      params( 43 ) := "+"( Float( a_target_dataset.age_24_male ));
      params( 44 ) := "+"( Float( a_target_dataset.age_25_male ));
      params( 45 ) := "+"( Float( a_target_dataset.age_26_male ));
      params( 46 ) := "+"( Float( a_target_dataset.age_27_male ));
      params( 47 ) := "+"( Float( a_target_dataset.age_28_male ));
      params( 48 ) := "+"( Float( a_target_dataset.age_29_male ));
      params( 49 ) := "+"( Float( a_target_dataset.age_30_male ));
      params( 50 ) := "+"( Float( a_target_dataset.age_31_male ));
      params( 51 ) := "+"( Float( a_target_dataset.age_32_male ));
      params( 52 ) := "+"( Float( a_target_dataset.age_33_male ));
      params( 53 ) := "+"( Float( a_target_dataset.age_34_male ));
      params( 54 ) := "+"( Float( a_target_dataset.age_35_male ));
      params( 55 ) := "+"( Float( a_target_dataset.age_36_male ));
      params( 56 ) := "+"( Float( a_target_dataset.age_37_male ));
      params( 57 ) := "+"( Float( a_target_dataset.age_38_male ));
      params( 58 ) := "+"( Float( a_target_dataset.age_39_male ));
      params( 59 ) := "+"( Float( a_target_dataset.age_40_male ));
      params( 60 ) := "+"( Float( a_target_dataset.age_41_male ));
      params( 61 ) := "+"( Float( a_target_dataset.age_42_male ));
      params( 62 ) := "+"( Float( a_target_dataset.age_43_male ));
      params( 63 ) := "+"( Float( a_target_dataset.age_44_male ));
      params( 64 ) := "+"( Float( a_target_dataset.age_45_male ));
      params( 65 ) := "+"( Float( a_target_dataset.age_46_male ));
      params( 66 ) := "+"( Float( a_target_dataset.age_47_male ));
      params( 67 ) := "+"( Float( a_target_dataset.age_48_male ));
      params( 68 ) := "+"( Float( a_target_dataset.age_49_male ));
      params( 69 ) := "+"( Float( a_target_dataset.age_50_male ));
      params( 70 ) := "+"( Float( a_target_dataset.age_51_male ));
      params( 71 ) := "+"( Float( a_target_dataset.age_52_male ));
      params( 72 ) := "+"( Float( a_target_dataset.age_53_male ));
      params( 73 ) := "+"( Float( a_target_dataset.age_54_male ));
      params( 74 ) := "+"( Float( a_target_dataset.age_55_male ));
      params( 75 ) := "+"( Float( a_target_dataset.age_56_male ));
      params( 76 ) := "+"( Float( a_target_dataset.age_57_male ));
      params( 77 ) := "+"( Float( a_target_dataset.age_58_male ));
      params( 78 ) := "+"( Float( a_target_dataset.age_59_male ));
      params( 79 ) := "+"( Float( a_target_dataset.age_60_male ));
      params( 80 ) := "+"( Float( a_target_dataset.age_61_male ));
      params( 81 ) := "+"( Float( a_target_dataset.age_62_male ));
      params( 82 ) := "+"( Float( a_target_dataset.age_63_male ));
      params( 83 ) := "+"( Float( a_target_dataset.age_64_male ));
      params( 84 ) := "+"( Float( a_target_dataset.age_65_male ));
      params( 85 ) := "+"( Float( a_target_dataset.age_66_male ));
      params( 86 ) := "+"( Float( a_target_dataset.age_67_male ));
      params( 87 ) := "+"( Float( a_target_dataset.age_68_male ));
      params( 88 ) := "+"( Float( a_target_dataset.age_69_male ));
      params( 89 ) := "+"( Float( a_target_dataset.age_70_male ));
      params( 90 ) := "+"( Float( a_target_dataset.age_71_male ));
      params( 91 ) := "+"( Float( a_target_dataset.age_72_male ));
      params( 92 ) := "+"( Float( a_target_dataset.age_73_male ));
      params( 93 ) := "+"( Float( a_target_dataset.age_74_male ));
      params( 94 ) := "+"( Float( a_target_dataset.age_75_male ));
      params( 95 ) := "+"( Float( a_target_dataset.age_76_male ));
      params( 96 ) := "+"( Float( a_target_dataset.age_77_male ));
      params( 97 ) := "+"( Float( a_target_dataset.age_78_male ));
      params( 98 ) := "+"( Float( a_target_dataset.age_79_male ));
      params( 99 ) := "+"( Float( a_target_dataset.age_80_male ));
      params( 100 ) := "+"( Float( a_target_dataset.age_81_male ));
      params( 101 ) := "+"( Float( a_target_dataset.age_82_male ));
      params( 102 ) := "+"( Float( a_target_dataset.age_83_male ));
      params( 103 ) := "+"( Float( a_target_dataset.age_84_male ));
      params( 104 ) := "+"( Float( a_target_dataset.age_85_male ));
      params( 105 ) := "+"( Float( a_target_dataset.age_86_male ));
      params( 106 ) := "+"( Float( a_target_dataset.age_87_male ));
      params( 107 ) := "+"( Float( a_target_dataset.age_88_male ));
      params( 108 ) := "+"( Float( a_target_dataset.age_89_male ));
      params( 109 ) := "+"( Float( a_target_dataset.age_90_male ));
      params( 110 ) := "+"( Float( a_target_dataset.age_91_male ));
      params( 111 ) := "+"( Float( a_target_dataset.age_92_male ));
      params( 112 ) := "+"( Float( a_target_dataset.age_93_male ));
      params( 113 ) := "+"( Float( a_target_dataset.age_94_male ));
      params( 114 ) := "+"( Float( a_target_dataset.age_95_male ));
      params( 115 ) := "+"( Float( a_target_dataset.age_96_male ));
      params( 116 ) := "+"( Float( a_target_dataset.age_97_male ));
      params( 117 ) := "+"( Float( a_target_dataset.age_98_male ));
      params( 118 ) := "+"( Float( a_target_dataset.age_99_male ));
      params( 119 ) := "+"( Float( a_target_dataset.age_100_male ));
      params( 120 ) := "+"( Float( a_target_dataset.age_101_male ));
      params( 121 ) := "+"( Float( a_target_dataset.age_102_male ));
      params( 122 ) := "+"( Float( a_target_dataset.age_103_male ));
      params( 123 ) := "+"( Float( a_target_dataset.age_104_male ));
      params( 124 ) := "+"( Float( a_target_dataset.age_105_male ));
      params( 125 ) := "+"( Float( a_target_dataset.age_106_male ));
      params( 126 ) := "+"( Float( a_target_dataset.age_107_male ));
      params( 127 ) := "+"( Float( a_target_dataset.age_108_male ));
      params( 128 ) := "+"( Float( a_target_dataset.age_109_male ));
      params( 129 ) := "+"( Float( a_target_dataset.age_110_male ));
      params( 130 ) := "+"( Float( a_target_dataset.age_0_female ));
      params( 131 ) := "+"( Float( a_target_dataset.age_1_female ));
      params( 132 ) := "+"( Float( a_target_dataset.age_2_female ));
      params( 133 ) := "+"( Float( a_target_dataset.age_3_female ));
      params( 134 ) := "+"( Float( a_target_dataset.age_4_female ));
      params( 135 ) := "+"( Float( a_target_dataset.age_5_female ));
      params( 136 ) := "+"( Float( a_target_dataset.age_6_female ));
      params( 137 ) := "+"( Float( a_target_dataset.age_7_female ));
      params( 138 ) := "+"( Float( a_target_dataset.age_8_female ));
      params( 139 ) := "+"( Float( a_target_dataset.age_9_female ));
      params( 140 ) := "+"( Float( a_target_dataset.age_10_female ));
      params( 141 ) := "+"( Float( a_target_dataset.age_11_female ));
      params( 142 ) := "+"( Float( a_target_dataset.age_12_female ));
      params( 143 ) := "+"( Float( a_target_dataset.age_13_female ));
      params( 144 ) := "+"( Float( a_target_dataset.age_14_female ));
      params( 145 ) := "+"( Float( a_target_dataset.age_15_female ));
      params( 146 ) := "+"( Float( a_target_dataset.age_16_female ));
      params( 147 ) := "+"( Float( a_target_dataset.age_17_female ));
      params( 148 ) := "+"( Float( a_target_dataset.age_18_female ));
      params( 149 ) := "+"( Float( a_target_dataset.age_19_female ));
      params( 150 ) := "+"( Float( a_target_dataset.age_20_female ));
      params( 151 ) := "+"( Float( a_target_dataset.age_21_female ));
      params( 152 ) := "+"( Float( a_target_dataset.age_22_female ));
      params( 153 ) := "+"( Float( a_target_dataset.age_23_female ));
      params( 154 ) := "+"( Float( a_target_dataset.age_24_female ));
      params( 155 ) := "+"( Float( a_target_dataset.age_25_female ));
      params( 156 ) := "+"( Float( a_target_dataset.age_26_female ));
      params( 157 ) := "+"( Float( a_target_dataset.age_27_female ));
      params( 158 ) := "+"( Float( a_target_dataset.age_28_female ));
      params( 159 ) := "+"( Float( a_target_dataset.age_29_female ));
      params( 160 ) := "+"( Float( a_target_dataset.age_30_female ));
      params( 161 ) := "+"( Float( a_target_dataset.age_31_female ));
      params( 162 ) := "+"( Float( a_target_dataset.age_32_female ));
      params( 163 ) := "+"( Float( a_target_dataset.age_33_female ));
      params( 164 ) := "+"( Float( a_target_dataset.age_34_female ));
      params( 165 ) := "+"( Float( a_target_dataset.age_35_female ));
      params( 166 ) := "+"( Float( a_target_dataset.age_36_female ));
      params( 167 ) := "+"( Float( a_target_dataset.age_37_female ));
      params( 168 ) := "+"( Float( a_target_dataset.age_38_female ));
      params( 169 ) := "+"( Float( a_target_dataset.age_39_female ));
      params( 170 ) := "+"( Float( a_target_dataset.age_40_female ));
      params( 171 ) := "+"( Float( a_target_dataset.age_41_female ));
      params( 172 ) := "+"( Float( a_target_dataset.age_42_female ));
      params( 173 ) := "+"( Float( a_target_dataset.age_43_female ));
      params( 174 ) := "+"( Float( a_target_dataset.age_44_female ));
      params( 175 ) := "+"( Float( a_target_dataset.age_45_female ));
      params( 176 ) := "+"( Float( a_target_dataset.age_46_female ));
      params( 177 ) := "+"( Float( a_target_dataset.age_47_female ));
      params( 178 ) := "+"( Float( a_target_dataset.age_48_female ));
      params( 179 ) := "+"( Float( a_target_dataset.age_49_female ));
      params( 180 ) := "+"( Float( a_target_dataset.age_50_female ));
      params( 181 ) := "+"( Float( a_target_dataset.age_51_female ));
      params( 182 ) := "+"( Float( a_target_dataset.age_52_female ));
      params( 183 ) := "+"( Float( a_target_dataset.age_53_female ));
      params( 184 ) := "+"( Float( a_target_dataset.age_54_female ));
      params( 185 ) := "+"( Float( a_target_dataset.age_55_female ));
      params( 186 ) := "+"( Float( a_target_dataset.age_56_female ));
      params( 187 ) := "+"( Float( a_target_dataset.age_57_female ));
      params( 188 ) := "+"( Float( a_target_dataset.age_58_female ));
      params( 189 ) := "+"( Float( a_target_dataset.age_59_female ));
      params( 190 ) := "+"( Float( a_target_dataset.age_60_female ));
      params( 191 ) := "+"( Float( a_target_dataset.age_61_female ));
      params( 192 ) := "+"( Float( a_target_dataset.age_62_female ));
      params( 193 ) := "+"( Float( a_target_dataset.age_63_female ));
      params( 194 ) := "+"( Float( a_target_dataset.age_64_female ));
      params( 195 ) := "+"( Float( a_target_dataset.age_65_female ));
      params( 196 ) := "+"( Float( a_target_dataset.age_66_female ));
      params( 197 ) := "+"( Float( a_target_dataset.age_67_female ));
      params( 198 ) := "+"( Float( a_target_dataset.age_68_female ));
      params( 199 ) := "+"( Float( a_target_dataset.age_69_female ));
      params( 200 ) := "+"( Float( a_target_dataset.age_70_female ));
      params( 201 ) := "+"( Float( a_target_dataset.age_71_female ));
      params( 202 ) := "+"( Float( a_target_dataset.age_72_female ));
      params( 203 ) := "+"( Float( a_target_dataset.age_73_female ));
      params( 204 ) := "+"( Float( a_target_dataset.age_74_female ));
      params( 205 ) := "+"( Float( a_target_dataset.age_75_female ));
      params( 206 ) := "+"( Float( a_target_dataset.age_76_female ));
      params( 207 ) := "+"( Float( a_target_dataset.age_77_female ));
      params( 208 ) := "+"( Float( a_target_dataset.age_78_female ));
      params( 209 ) := "+"( Float( a_target_dataset.age_79_female ));
      params( 210 ) := "+"( Float( a_target_dataset.age_80_female ));
      params( 211 ) := "+"( Float( a_target_dataset.age_81_female ));
      params( 212 ) := "+"( Float( a_target_dataset.age_82_female ));
      params( 213 ) := "+"( Float( a_target_dataset.age_83_female ));
      params( 214 ) := "+"( Float( a_target_dataset.age_84_female ));
      params( 215 ) := "+"( Float( a_target_dataset.age_85_female ));
      params( 216 ) := "+"( Float( a_target_dataset.age_86_female ));
      params( 217 ) := "+"( Float( a_target_dataset.age_87_female ));
      params( 218 ) := "+"( Float( a_target_dataset.age_88_female ));
      params( 219 ) := "+"( Float( a_target_dataset.age_89_female ));
      params( 220 ) := "+"( Float( a_target_dataset.age_90_female ));
      params( 221 ) := "+"( Float( a_target_dataset.age_91_female ));
      params( 222 ) := "+"( Float( a_target_dataset.age_92_female ));
      params( 223 ) := "+"( Float( a_target_dataset.age_93_female ));
      params( 224 ) := "+"( Float( a_target_dataset.age_94_female ));
      params( 225 ) := "+"( Float( a_target_dataset.age_95_female ));
      params( 226 ) := "+"( Float( a_target_dataset.age_96_female ));
      params( 227 ) := "+"( Float( a_target_dataset.age_97_female ));
      params( 228 ) := "+"( Float( a_target_dataset.age_98_female ));
      params( 229 ) := "+"( Float( a_target_dataset.age_99_female ));
      params( 230 ) := "+"( Float( a_target_dataset.age_100_female ));
      params( 231 ) := "+"( Float( a_target_dataset.age_101_female ));
      params( 232 ) := "+"( Float( a_target_dataset.age_102_female ));
      params( 233 ) := "+"( Float( a_target_dataset.age_103_female ));
      params( 234 ) := "+"( Float( a_target_dataset.age_104_female ));
      params( 235 ) := "+"( Float( a_target_dataset.age_105_female ));
      params( 236 ) := "+"( Float( a_target_dataset.age_106_female ));
      params( 237 ) := "+"( Float( a_target_dataset.age_107_female ));
      params( 238 ) := "+"( Float( a_target_dataset.age_108_female ));
      params( 239 ) := "+"( Float( a_target_dataset.age_109_female ));
      params( 240 ) := "+"( Float( a_target_dataset.age_110_female ));
      params( 241 ) := "+"( Float( a_target_dataset.age_0 ));
      params( 242 ) := "+"( Float( a_target_dataset.age_1 ));
      params( 243 ) := "+"( Float( a_target_dataset.age_2 ));
      params( 244 ) := "+"( Float( a_target_dataset.age_3 ));
      params( 245 ) := "+"( Float( a_target_dataset.age_4 ));
      params( 246 ) := "+"( Float( a_target_dataset.age_5 ));
      params( 247 ) := "+"( Float( a_target_dataset.age_6 ));
      params( 248 ) := "+"( Float( a_target_dataset.age_7 ));
      params( 249 ) := "+"( Float( a_target_dataset.age_8 ));
      params( 250 ) := "+"( Float( a_target_dataset.age_9 ));
      params( 251 ) := "+"( Float( a_target_dataset.age_10 ));
      params( 252 ) := "+"( Float( a_target_dataset.age_11 ));
      params( 253 ) := "+"( Float( a_target_dataset.age_12 ));
      params( 254 ) := "+"( Float( a_target_dataset.age_13 ));
      params( 255 ) := "+"( Float( a_target_dataset.age_14 ));
      params( 256 ) := "+"( Float( a_target_dataset.age_15 ));
      params( 257 ) := "+"( Float( a_target_dataset.age_16 ));
      params( 258 ) := "+"( Float( a_target_dataset.age_17 ));
      params( 259 ) := "+"( Float( a_target_dataset.age_18 ));
      params( 260 ) := "+"( Float( a_target_dataset.age_19 ));
      params( 261 ) := "+"( Float( a_target_dataset.age_20 ));
      params( 262 ) := "+"( Float( a_target_dataset.age_21 ));
      params( 263 ) := "+"( Float( a_target_dataset.age_22 ));
      params( 264 ) := "+"( Float( a_target_dataset.age_23 ));
      params( 265 ) := "+"( Float( a_target_dataset.age_24 ));
      params( 266 ) := "+"( Float( a_target_dataset.age_25 ));
      params( 267 ) := "+"( Float( a_target_dataset.age_26 ));
      params( 268 ) := "+"( Float( a_target_dataset.age_27 ));
      params( 269 ) := "+"( Float( a_target_dataset.age_28 ));
      params( 270 ) := "+"( Float( a_target_dataset.age_29 ));
      params( 271 ) := "+"( Float( a_target_dataset.age_30 ));
      params( 272 ) := "+"( Float( a_target_dataset.age_31 ));
      params( 273 ) := "+"( Float( a_target_dataset.age_32 ));
      params( 274 ) := "+"( Float( a_target_dataset.age_33 ));
      params( 275 ) := "+"( Float( a_target_dataset.age_34 ));
      params( 276 ) := "+"( Float( a_target_dataset.age_35 ));
      params( 277 ) := "+"( Float( a_target_dataset.age_36 ));
      params( 278 ) := "+"( Float( a_target_dataset.age_37 ));
      params( 279 ) := "+"( Float( a_target_dataset.age_38 ));
      params( 280 ) := "+"( Float( a_target_dataset.age_39 ));
      params( 281 ) := "+"( Float( a_target_dataset.age_40 ));
      params( 282 ) := "+"( Float( a_target_dataset.age_41 ));
      params( 283 ) := "+"( Float( a_target_dataset.age_42 ));
      params( 284 ) := "+"( Float( a_target_dataset.age_43 ));
      params( 285 ) := "+"( Float( a_target_dataset.age_44 ));
      params( 286 ) := "+"( Float( a_target_dataset.age_45 ));
      params( 287 ) := "+"( Float( a_target_dataset.age_46 ));
      params( 288 ) := "+"( Float( a_target_dataset.age_47 ));
      params( 289 ) := "+"( Float( a_target_dataset.age_48 ));
      params( 290 ) := "+"( Float( a_target_dataset.age_49 ));
      params( 291 ) := "+"( Float( a_target_dataset.age_50 ));
      params( 292 ) := "+"( Float( a_target_dataset.age_51 ));
      params( 293 ) := "+"( Float( a_target_dataset.age_52 ));
      params( 294 ) := "+"( Float( a_target_dataset.age_53 ));
      params( 295 ) := "+"( Float( a_target_dataset.age_54 ));
      params( 296 ) := "+"( Float( a_target_dataset.age_55 ));
      params( 297 ) := "+"( Float( a_target_dataset.age_56 ));
      params( 298 ) := "+"( Float( a_target_dataset.age_57 ));
      params( 299 ) := "+"( Float( a_target_dataset.age_58 ));
      params( 300 ) := "+"( Float( a_target_dataset.age_59 ));
      params( 301 ) := "+"( Float( a_target_dataset.age_60 ));
      params( 302 ) := "+"( Float( a_target_dataset.age_61 ));
      params( 303 ) := "+"( Float( a_target_dataset.age_62 ));
      params( 304 ) := "+"( Float( a_target_dataset.age_63 ));
      params( 305 ) := "+"( Float( a_target_dataset.age_64 ));
      params( 306 ) := "+"( Float( a_target_dataset.age_65 ));
      params( 307 ) := "+"( Float( a_target_dataset.age_66 ));
      params( 308 ) := "+"( Float( a_target_dataset.age_67 ));
      params( 309 ) := "+"( Float( a_target_dataset.age_68 ));
      params( 310 ) := "+"( Float( a_target_dataset.age_69 ));
      params( 311 ) := "+"( Float( a_target_dataset.age_70 ));
      params( 312 ) := "+"( Float( a_target_dataset.age_71 ));
      params( 313 ) := "+"( Float( a_target_dataset.age_72 ));
      params( 314 ) := "+"( Float( a_target_dataset.age_73 ));
      params( 315 ) := "+"( Float( a_target_dataset.age_74 ));
      params( 316 ) := "+"( Float( a_target_dataset.age_75 ));
      params( 317 ) := "+"( Float( a_target_dataset.age_76 ));
      params( 318 ) := "+"( Float( a_target_dataset.age_77 ));
      params( 319 ) := "+"( Float( a_target_dataset.age_78 ));
      params( 320 ) := "+"( Float( a_target_dataset.age_79 ));
      params( 321 ) := "+"( Float( a_target_dataset.age_80 ));
      params( 322 ) := "+"( Float( a_target_dataset.age_81 ));
      params( 323 ) := "+"( Float( a_target_dataset.age_82 ));
      params( 324 ) := "+"( Float( a_target_dataset.age_83 ));
      params( 325 ) := "+"( Float( a_target_dataset.age_84 ));
      params( 326 ) := "+"( Float( a_target_dataset.age_85 ));
      params( 327 ) := "+"( Float( a_target_dataset.age_86 ));
      params( 328 ) := "+"( Float( a_target_dataset.age_87 ));
      params( 329 ) := "+"( Float( a_target_dataset.age_88 ));
      params( 330 ) := "+"( Float( a_target_dataset.age_89 ));
      params( 331 ) := "+"( Float( a_target_dataset.age_90 ));
      params( 332 ) := "+"( Float( a_target_dataset.age_91 ));
      params( 333 ) := "+"( Float( a_target_dataset.age_92 ));
      params( 334 ) := "+"( Float( a_target_dataset.age_93 ));
      params( 335 ) := "+"( Float( a_target_dataset.age_94 ));
      params( 336 ) := "+"( Float( a_target_dataset.age_95 ));
      params( 337 ) := "+"( Float( a_target_dataset.age_96 ));
      params( 338 ) := "+"( Float( a_target_dataset.age_97 ));
      params( 339 ) := "+"( Float( a_target_dataset.age_98 ));
      params( 340 ) := "+"( Float( a_target_dataset.age_99 ));
      params( 341 ) := "+"( Float( a_target_dataset.age_100 ));
      params( 342 ) := "+"( Float( a_target_dataset.age_101 ));
      params( 343 ) := "+"( Float( a_target_dataset.age_102 ));
      params( 344 ) := "+"( Float( a_target_dataset.age_103 ));
      params( 345 ) := "+"( Float( a_target_dataset.age_104 ));
      params( 346 ) := "+"( Float( a_target_dataset.age_105 ));
      params( 347 ) := "+"( Float( a_target_dataset.age_106 ));
      params( 348 ) := "+"( Float( a_target_dataset.age_107 ));
      params( 349 ) := "+"( Float( a_target_dataset.age_108 ));
      params( 350 ) := "+"( Float( a_target_dataset.age_109 ));
      params( 351 ) := "+"( Float( a_target_dataset.age_110 ));
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


   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, year );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   procedure Add_household_one_adult_male( c : in out d.Criteria; household_one_adult_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_one_adult_male", op, join, Long_Float( household_one_adult_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_male;


   procedure Add_household_one_adult_female( c : in out d.Criteria; household_one_adult_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_one_adult_female", op, join, Long_Float( household_one_adult_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_female;


   procedure Add_household_two_adults( c : in out d.Criteria; household_two_adults : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_two_adults", op, join, Long_Float( household_two_adults ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_two_adults;


   procedure Add_household_one_adult_one_child( c : in out d.Criteria; household_one_adult_one_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_one_adult_one_child", op, join, Long_Float( household_one_adult_one_child ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_one_child;


   procedure Add_household_one_adult_two_plus_children( c : in out d.Criteria; household_one_adult_two_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_one_adult_two_plus_children", op, join, Long_Float( household_one_adult_two_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_two_plus_children;


   procedure Add_household_two_plus_adult_one_plus_children( c : in out d.Criteria; household_two_plus_adult_one_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_two_plus_adult_one_plus_children", op, join, Long_Float( household_two_plus_adult_one_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_two_plus_adult_one_plus_children;


   procedure Add_household_three_plus_person_all_adult( c : in out d.Criteria; household_three_plus_person_all_adult : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_three_plus_person_all_adult", op, join, Long_Float( household_three_plus_person_all_adult ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_three_plus_person_all_adult;


   procedure Add_household_all_households( c : in out d.Criteria; household_all_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "household_all_households", op, join, Long_Float( household_all_households ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_all_households;


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


   procedure Add_age_0( c : in out d.Criteria; age_0 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_0", op, join, Long_Float( age_0 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0;


   procedure Add_age_1( c : in out d.Criteria; age_1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_1", op, join, Long_Float( age_1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1;


   procedure Add_age_2( c : in out d.Criteria; age_2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_2", op, join, Long_Float( age_2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2;


   procedure Add_age_3( c : in out d.Criteria; age_3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_3", op, join, Long_Float( age_3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3;


   procedure Add_age_4( c : in out d.Criteria; age_4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_4", op, join, Long_Float( age_4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4;


   procedure Add_age_5( c : in out d.Criteria; age_5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_5", op, join, Long_Float( age_5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5;


   procedure Add_age_6( c : in out d.Criteria; age_6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_6", op, join, Long_Float( age_6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6;


   procedure Add_age_7( c : in out d.Criteria; age_7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_7", op, join, Long_Float( age_7 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7;


   procedure Add_age_8( c : in out d.Criteria; age_8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_8", op, join, Long_Float( age_8 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8;


   procedure Add_age_9( c : in out d.Criteria; age_9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_9", op, join, Long_Float( age_9 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9;


   procedure Add_age_10( c : in out d.Criteria; age_10 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_10", op, join, Long_Float( age_10 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10;


   procedure Add_age_11( c : in out d.Criteria; age_11 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_11", op, join, Long_Float( age_11 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11;


   procedure Add_age_12( c : in out d.Criteria; age_12 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_12", op, join, Long_Float( age_12 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12;


   procedure Add_age_13( c : in out d.Criteria; age_13 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_13", op, join, Long_Float( age_13 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13;


   procedure Add_age_14( c : in out d.Criteria; age_14 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_14", op, join, Long_Float( age_14 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14;


   procedure Add_age_15( c : in out d.Criteria; age_15 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_15", op, join, Long_Float( age_15 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15;


   procedure Add_age_16( c : in out d.Criteria; age_16 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_16", op, join, Long_Float( age_16 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16;


   procedure Add_age_17( c : in out d.Criteria; age_17 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_17", op, join, Long_Float( age_17 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17;


   procedure Add_age_18( c : in out d.Criteria; age_18 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_18", op, join, Long_Float( age_18 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18;


   procedure Add_age_19( c : in out d.Criteria; age_19 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_19", op, join, Long_Float( age_19 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19;


   procedure Add_age_20( c : in out d.Criteria; age_20 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_20", op, join, Long_Float( age_20 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20;


   procedure Add_age_21( c : in out d.Criteria; age_21 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_21", op, join, Long_Float( age_21 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21;


   procedure Add_age_22( c : in out d.Criteria; age_22 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_22", op, join, Long_Float( age_22 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22;


   procedure Add_age_23( c : in out d.Criteria; age_23 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_23", op, join, Long_Float( age_23 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23;


   procedure Add_age_24( c : in out d.Criteria; age_24 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_24", op, join, Long_Float( age_24 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24;


   procedure Add_age_25( c : in out d.Criteria; age_25 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_25", op, join, Long_Float( age_25 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25;


   procedure Add_age_26( c : in out d.Criteria; age_26 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_26", op, join, Long_Float( age_26 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26;


   procedure Add_age_27( c : in out d.Criteria; age_27 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_27", op, join, Long_Float( age_27 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27;


   procedure Add_age_28( c : in out d.Criteria; age_28 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_28", op, join, Long_Float( age_28 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28;


   procedure Add_age_29( c : in out d.Criteria; age_29 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_29", op, join, Long_Float( age_29 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29;


   procedure Add_age_30( c : in out d.Criteria; age_30 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_30", op, join, Long_Float( age_30 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30;


   procedure Add_age_31( c : in out d.Criteria; age_31 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_31", op, join, Long_Float( age_31 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31;


   procedure Add_age_32( c : in out d.Criteria; age_32 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_32", op, join, Long_Float( age_32 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32;


   procedure Add_age_33( c : in out d.Criteria; age_33 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_33", op, join, Long_Float( age_33 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33;


   procedure Add_age_34( c : in out d.Criteria; age_34 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_34", op, join, Long_Float( age_34 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34;


   procedure Add_age_35( c : in out d.Criteria; age_35 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_35", op, join, Long_Float( age_35 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35;


   procedure Add_age_36( c : in out d.Criteria; age_36 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_36", op, join, Long_Float( age_36 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36;


   procedure Add_age_37( c : in out d.Criteria; age_37 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_37", op, join, Long_Float( age_37 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37;


   procedure Add_age_38( c : in out d.Criteria; age_38 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_38", op, join, Long_Float( age_38 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38;


   procedure Add_age_39( c : in out d.Criteria; age_39 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_39", op, join, Long_Float( age_39 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39;


   procedure Add_age_40( c : in out d.Criteria; age_40 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_40", op, join, Long_Float( age_40 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40;


   procedure Add_age_41( c : in out d.Criteria; age_41 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_41", op, join, Long_Float( age_41 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41;


   procedure Add_age_42( c : in out d.Criteria; age_42 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_42", op, join, Long_Float( age_42 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42;


   procedure Add_age_43( c : in out d.Criteria; age_43 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_43", op, join, Long_Float( age_43 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43;


   procedure Add_age_44( c : in out d.Criteria; age_44 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_44", op, join, Long_Float( age_44 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44;


   procedure Add_age_45( c : in out d.Criteria; age_45 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_45", op, join, Long_Float( age_45 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45;


   procedure Add_age_46( c : in out d.Criteria; age_46 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_46", op, join, Long_Float( age_46 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46;


   procedure Add_age_47( c : in out d.Criteria; age_47 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_47", op, join, Long_Float( age_47 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47;


   procedure Add_age_48( c : in out d.Criteria; age_48 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_48", op, join, Long_Float( age_48 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48;


   procedure Add_age_49( c : in out d.Criteria; age_49 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_49", op, join, Long_Float( age_49 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49;


   procedure Add_age_50( c : in out d.Criteria; age_50 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_50", op, join, Long_Float( age_50 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50;


   procedure Add_age_51( c : in out d.Criteria; age_51 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_51", op, join, Long_Float( age_51 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51;


   procedure Add_age_52( c : in out d.Criteria; age_52 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_52", op, join, Long_Float( age_52 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52;


   procedure Add_age_53( c : in out d.Criteria; age_53 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_53", op, join, Long_Float( age_53 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53;


   procedure Add_age_54( c : in out d.Criteria; age_54 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_54", op, join, Long_Float( age_54 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54;


   procedure Add_age_55( c : in out d.Criteria; age_55 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_55", op, join, Long_Float( age_55 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55;


   procedure Add_age_56( c : in out d.Criteria; age_56 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_56", op, join, Long_Float( age_56 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56;


   procedure Add_age_57( c : in out d.Criteria; age_57 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_57", op, join, Long_Float( age_57 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57;


   procedure Add_age_58( c : in out d.Criteria; age_58 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_58", op, join, Long_Float( age_58 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58;


   procedure Add_age_59( c : in out d.Criteria; age_59 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_59", op, join, Long_Float( age_59 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59;


   procedure Add_age_60( c : in out d.Criteria; age_60 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_60", op, join, Long_Float( age_60 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60;


   procedure Add_age_61( c : in out d.Criteria; age_61 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_61", op, join, Long_Float( age_61 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61;


   procedure Add_age_62( c : in out d.Criteria; age_62 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_62", op, join, Long_Float( age_62 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62;


   procedure Add_age_63( c : in out d.Criteria; age_63 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_63", op, join, Long_Float( age_63 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63;


   procedure Add_age_64( c : in out d.Criteria; age_64 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_64", op, join, Long_Float( age_64 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64;


   procedure Add_age_65( c : in out d.Criteria; age_65 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_65", op, join, Long_Float( age_65 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65;


   procedure Add_age_66( c : in out d.Criteria; age_66 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_66", op, join, Long_Float( age_66 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66;


   procedure Add_age_67( c : in out d.Criteria; age_67 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_67", op, join, Long_Float( age_67 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67;


   procedure Add_age_68( c : in out d.Criteria; age_68 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_68", op, join, Long_Float( age_68 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68;


   procedure Add_age_69( c : in out d.Criteria; age_69 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_69", op, join, Long_Float( age_69 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69;


   procedure Add_age_70( c : in out d.Criteria; age_70 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_70", op, join, Long_Float( age_70 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70;


   procedure Add_age_71( c : in out d.Criteria; age_71 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_71", op, join, Long_Float( age_71 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71;


   procedure Add_age_72( c : in out d.Criteria; age_72 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_72", op, join, Long_Float( age_72 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72;


   procedure Add_age_73( c : in out d.Criteria; age_73 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_73", op, join, Long_Float( age_73 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73;


   procedure Add_age_74( c : in out d.Criteria; age_74 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_74", op, join, Long_Float( age_74 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74;


   procedure Add_age_75( c : in out d.Criteria; age_75 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_75", op, join, Long_Float( age_75 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75;


   procedure Add_age_76( c : in out d.Criteria; age_76 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_76", op, join, Long_Float( age_76 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76;


   procedure Add_age_77( c : in out d.Criteria; age_77 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_77", op, join, Long_Float( age_77 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77;


   procedure Add_age_78( c : in out d.Criteria; age_78 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_78", op, join, Long_Float( age_78 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78;


   procedure Add_age_79( c : in out d.Criteria; age_79 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_79", op, join, Long_Float( age_79 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79;


   procedure Add_age_80( c : in out d.Criteria; age_80 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_80", op, join, Long_Float( age_80 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80;


   procedure Add_age_81( c : in out d.Criteria; age_81 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_81", op, join, Long_Float( age_81 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81;


   procedure Add_age_82( c : in out d.Criteria; age_82 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_82", op, join, Long_Float( age_82 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82;


   procedure Add_age_83( c : in out d.Criteria; age_83 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_83", op, join, Long_Float( age_83 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83;


   procedure Add_age_84( c : in out d.Criteria; age_84 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_84", op, join, Long_Float( age_84 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84;


   procedure Add_age_85( c : in out d.Criteria; age_85 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_85", op, join, Long_Float( age_85 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85;


   procedure Add_age_86( c : in out d.Criteria; age_86 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_86", op, join, Long_Float( age_86 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86;


   procedure Add_age_87( c : in out d.Criteria; age_87 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_87", op, join, Long_Float( age_87 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87;


   procedure Add_age_88( c : in out d.Criteria; age_88 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_88", op, join, Long_Float( age_88 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88;


   procedure Add_age_89( c : in out d.Criteria; age_89 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_89", op, join, Long_Float( age_89 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89;


   procedure Add_age_90( c : in out d.Criteria; age_90 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_90", op, join, Long_Float( age_90 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90;


   procedure Add_age_91( c : in out d.Criteria; age_91 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_91", op, join, Long_Float( age_91 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91;


   procedure Add_age_92( c : in out d.Criteria; age_92 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_92", op, join, Long_Float( age_92 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92;


   procedure Add_age_93( c : in out d.Criteria; age_93 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_93", op, join, Long_Float( age_93 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93;


   procedure Add_age_94( c : in out d.Criteria; age_94 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_94", op, join, Long_Float( age_94 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94;


   procedure Add_age_95( c : in out d.Criteria; age_95 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_95", op, join, Long_Float( age_95 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95;


   procedure Add_age_96( c : in out d.Criteria; age_96 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_96", op, join, Long_Float( age_96 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96;


   procedure Add_age_97( c : in out d.Criteria; age_97 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_97", op, join, Long_Float( age_97 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97;


   procedure Add_age_98( c : in out d.Criteria; age_98 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_98", op, join, Long_Float( age_98 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98;


   procedure Add_age_99( c : in out d.Criteria; age_99 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_99", op, join, Long_Float( age_99 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99;


   procedure Add_age_100( c : in out d.Criteria; age_100 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_100", op, join, Long_Float( age_100 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100;


   procedure Add_age_101( c : in out d.Criteria; age_101 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_101", op, join, Long_Float( age_101 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101;


   procedure Add_age_102( c : in out d.Criteria; age_102 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_102", op, join, Long_Float( age_102 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102;


   procedure Add_age_103( c : in out d.Criteria; age_103 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_103", op, join, Long_Float( age_103 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103;


   procedure Add_age_104( c : in out d.Criteria; age_104 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_104", op, join, Long_Float( age_104 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104;


   procedure Add_age_105( c : in out d.Criteria; age_105 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_105", op, join, Long_Float( age_105 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105;


   procedure Add_age_106( c : in out d.Criteria; age_106 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_106", op, join, Long_Float( age_106 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106;


   procedure Add_age_107( c : in out d.Criteria; age_107 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_107", op, join, Long_Float( age_107 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107;


   procedure Add_age_108( c : in out d.Criteria; age_108 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_108", op, join, Long_Float( age_108 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108;


   procedure Add_age_109( c : in out d.Criteria; age_109 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_109", op, join, Long_Float( age_109 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109;


   procedure Add_age_110( c : in out d.Criteria; age_110 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_110", op, join, Long_Float( age_110 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110;


   
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


   procedure Add_household_one_adult_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_one_adult_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_male_To_Orderings;


   procedure Add_household_one_adult_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_one_adult_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_female_To_Orderings;


   procedure Add_household_two_adults_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_two_adults", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_two_adults_To_Orderings;


   procedure Add_household_one_adult_one_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_one_adult_one_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_one_child_To_Orderings;


   procedure Add_household_one_adult_two_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_one_adult_two_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_one_adult_two_plus_children_To_Orderings;


   procedure Add_household_two_plus_adult_one_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_two_plus_adult_one_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_two_plus_adult_one_plus_children_To_Orderings;


   procedure Add_household_three_plus_person_all_adult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_three_plus_person_all_adult", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_three_plus_person_all_adult_To_Orderings;


   procedure Add_household_all_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "household_all_households", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_household_all_households_To_Orderings;


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


   procedure Add_age_0_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_0", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0_To_Orderings;


   procedure Add_age_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1_To_Orderings;


   procedure Add_age_2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2_To_Orderings;


   procedure Add_age_3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3_To_Orderings;


   procedure Add_age_4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4_To_Orderings;


   procedure Add_age_5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5_To_Orderings;


   procedure Add_age_6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6_To_Orderings;


   procedure Add_age_7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7_To_Orderings;


   procedure Add_age_8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8_To_Orderings;


   procedure Add_age_9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9_To_Orderings;


   procedure Add_age_10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10_To_Orderings;


   procedure Add_age_11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11_To_Orderings;


   procedure Add_age_12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12_To_Orderings;


   procedure Add_age_13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13_To_Orderings;


   procedure Add_age_14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14_To_Orderings;


   procedure Add_age_15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15_To_Orderings;


   procedure Add_age_16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_To_Orderings;


   procedure Add_age_17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17_To_Orderings;


   procedure Add_age_18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18_To_Orderings;


   procedure Add_age_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19_To_Orderings;


   procedure Add_age_20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_20", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_To_Orderings;


   procedure Add_age_21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_21", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21_To_Orderings;


   procedure Add_age_22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_22", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22_To_Orderings;


   procedure Add_age_23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_23", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23_To_Orderings;


   procedure Add_age_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_24", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24_To_Orderings;


   procedure Add_age_25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_25", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_To_Orderings;


   procedure Add_age_26_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_26", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26_To_Orderings;


   procedure Add_age_27_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_27", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27_To_Orderings;


   procedure Add_age_28_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_28", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28_To_Orderings;


   procedure Add_age_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_29", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29_To_Orderings;


   procedure Add_age_30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_30", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_To_Orderings;


   procedure Add_age_31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_31", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31_To_Orderings;


   procedure Add_age_32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_32", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32_To_Orderings;


   procedure Add_age_33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_33", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33_To_Orderings;


   procedure Add_age_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_34", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34_To_Orderings;


   procedure Add_age_35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_35", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_To_Orderings;


   procedure Add_age_36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_36", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36_To_Orderings;


   procedure Add_age_37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_37", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37_To_Orderings;


   procedure Add_age_38_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_38", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38_To_Orderings;


   procedure Add_age_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_39", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39_To_Orderings;


   procedure Add_age_40_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_40", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_To_Orderings;


   procedure Add_age_41_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_41", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41_To_Orderings;


   procedure Add_age_42_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_42", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42_To_Orderings;


   procedure Add_age_43_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_43", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43_To_Orderings;


   procedure Add_age_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_44", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44_To_Orderings;


   procedure Add_age_45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_45", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_To_Orderings;


   procedure Add_age_46_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_46", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46_To_Orderings;


   procedure Add_age_47_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_47", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47_To_Orderings;


   procedure Add_age_48_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_48", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48_To_Orderings;


   procedure Add_age_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_49", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49_To_Orderings;


   procedure Add_age_50_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_50", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_To_Orderings;


   procedure Add_age_51_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_51", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51_To_Orderings;


   procedure Add_age_52_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_52", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52_To_Orderings;


   procedure Add_age_53_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_53", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53_To_Orderings;


   procedure Add_age_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_54", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54_To_Orderings;


   procedure Add_age_55_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_55", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_To_Orderings;


   procedure Add_age_56_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_56", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56_To_Orderings;


   procedure Add_age_57_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_57", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57_To_Orderings;


   procedure Add_age_58_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_58", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58_To_Orderings;


   procedure Add_age_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_59", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59_To_Orderings;


   procedure Add_age_60_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_60", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_To_Orderings;


   procedure Add_age_61_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_61", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61_To_Orderings;


   procedure Add_age_62_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_62", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62_To_Orderings;


   procedure Add_age_63_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_63", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63_To_Orderings;


   procedure Add_age_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_64", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64_To_Orderings;


   procedure Add_age_65_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_65", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_To_Orderings;


   procedure Add_age_66_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_66", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66_To_Orderings;


   procedure Add_age_67_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_67", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67_To_Orderings;


   procedure Add_age_68_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_68", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68_To_Orderings;


   procedure Add_age_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_69", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69_To_Orderings;


   procedure Add_age_70_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_70", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_To_Orderings;


   procedure Add_age_71_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_71", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71_To_Orderings;


   procedure Add_age_72_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_72", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72_To_Orderings;


   procedure Add_age_73_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_73", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73_To_Orderings;


   procedure Add_age_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_74", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74_To_Orderings;


   procedure Add_age_75_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_75", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_To_Orderings;


   procedure Add_age_76_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_76", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76_To_Orderings;


   procedure Add_age_77_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_77", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77_To_Orderings;


   procedure Add_age_78_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_78", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78_To_Orderings;


   procedure Add_age_79_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_79", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79_To_Orderings;


   procedure Add_age_80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80_To_Orderings;


   procedure Add_age_81_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_81", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81_To_Orderings;


   procedure Add_age_82_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_82", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82_To_Orderings;


   procedure Add_age_83_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_83", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83_To_Orderings;


   procedure Add_age_84_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_84", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84_To_Orderings;


   procedure Add_age_85_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_85", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85_To_Orderings;


   procedure Add_age_86_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_86", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86_To_Orderings;


   procedure Add_age_87_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_87", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87_To_Orderings;


   procedure Add_age_88_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_88", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88_To_Orderings;


   procedure Add_age_89_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_89", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89_To_Orderings;


   procedure Add_age_90_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_90", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90_To_Orderings;


   procedure Add_age_91_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_91", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91_To_Orderings;


   procedure Add_age_92_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_92", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92_To_Orderings;


   procedure Add_age_93_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_93", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93_To_Orderings;


   procedure Add_age_94_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_94", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94_To_Orderings;


   procedure Add_age_95_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_95", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95_To_Orderings;


   procedure Add_age_96_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_96", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96_To_Orderings;


   procedure Add_age_97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_97", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97_To_Orderings;


   procedure Add_age_98_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_98", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98_To_Orderings;


   procedure Add_age_99_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_99", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99_To_Orderings;


   procedure Add_age_100_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_100", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100_To_Orderings;


   procedure Add_age_101_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_101", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101_To_Orderings;


   procedure Add_age_102_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_102", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102_To_Orderings;


   procedure Add_age_103_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_103", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103_To_Orderings;


   procedure Add_age_104_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_104", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104_To_Orderings;


   procedure Add_age_105_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_105", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105_To_Orderings;


   procedure Add_age_106_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_106", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106_To_Orderings;


   procedure Add_age_107_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_107", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107_To_Orderings;


   procedure Add_age_108_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_108", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108_To_Orderings;


   procedure Add_age_109_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_109", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109_To_Orderings;


   procedure Add_age_110_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_110", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Target_Dataset_IO;
