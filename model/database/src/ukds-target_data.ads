--
-- Created by ada_generator.py on 2017-09-21 20:55:36.309888
-- 
with Ada.Containers.Vectors;
--
-- FIXME: may not be needed
--
with Ada.Calendar;

with Base_Types; use Base_Types;

with Ada.Strings.Unbounded;
with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;
with SCP_Types;
with Weighting_Commons;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds.target_data is

   use Ada.Strings.Unbounded;
   
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;
   use SCP_Types;
   use Weighting_Commons;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===



   --
   -- record modelling Target_Dataset : 
   --
   type Target_Dataset is record
      run_id : Integer := MISSING_I_KEY;
      user_id : Integer := 0;
      year : Year_Number := 1970;
      sernum : Sernum_Value := 0;
      country_uk : Amount := 0.0;
      country_scotland : Amount := 0.0;
      country_england : Amount := 0.0;
      country_wales : Amount := 0.0;
      country_n_ireland : Amount := 0.0;
      household_one_adult_male : Amount := 0.0;
      household_one_adult_female : Amount := 0.0;
      household_two_adults : Amount := 0.0;
      household_one_adult_one_child : Amount := 0.0;
      household_one_adult_two_plus_children : Amount := 0.0;
      household_two_plus_adult_one_plus_children : Amount := 0.0;
      household_three_plus_person_all_adult : Amount := 0.0;
      household_all_households : Amount := 0.0;
      male : Amount := 0.0;
      female : Amount := 0.0;
      employed : Amount := 0.0;
      employee : Amount := 0.0;
      ilo_unemployed : Amount := 0.0;
      jsa_claimant : Amount := 0.0;
      age_0_male : Amount := 0.0;
      age_1_male : Amount := 0.0;
      age_2_male : Amount := 0.0;
      age_3_male : Amount := 0.0;
      age_4_male : Amount := 0.0;
      age_5_male : Amount := 0.0;
      age_6_male : Amount := 0.0;
      age_7_male : Amount := 0.0;
      age_8_male : Amount := 0.0;
      age_9_male : Amount := 0.0;
      age_10_male : Amount := 0.0;
      age_11_male : Amount := 0.0;
      age_12_male : Amount := 0.0;
      age_13_male : Amount := 0.0;
      age_14_male : Amount := 0.0;
      age_15_male : Amount := 0.0;
      age_16_male : Amount := 0.0;
      age_17_male : Amount := 0.0;
      age_18_male : Amount := 0.0;
      age_19_male : Amount := 0.0;
      age_20_male : Amount := 0.0;
      age_21_male : Amount := 0.0;
      age_22_male : Amount := 0.0;
      age_23_male : Amount := 0.0;
      age_24_male : Amount := 0.0;
      age_25_male : Amount := 0.0;
      age_26_male : Amount := 0.0;
      age_27_male : Amount := 0.0;
      age_28_male : Amount := 0.0;
      age_29_male : Amount := 0.0;
      age_30_male : Amount := 0.0;
      age_31_male : Amount := 0.0;
      age_32_male : Amount := 0.0;
      age_33_male : Amount := 0.0;
      age_34_male : Amount := 0.0;
      age_35_male : Amount := 0.0;
      age_36_male : Amount := 0.0;
      age_37_male : Amount := 0.0;
      age_38_male : Amount := 0.0;
      age_39_male : Amount := 0.0;
      age_40_male : Amount := 0.0;
      age_41_male : Amount := 0.0;
      age_42_male : Amount := 0.0;
      age_43_male : Amount := 0.0;
      age_44_male : Amount := 0.0;
      age_45_male : Amount := 0.0;
      age_46_male : Amount := 0.0;
      age_47_male : Amount := 0.0;
      age_48_male : Amount := 0.0;
      age_49_male : Amount := 0.0;
      age_50_male : Amount := 0.0;
      age_51_male : Amount := 0.0;
      age_52_male : Amount := 0.0;
      age_53_male : Amount := 0.0;
      age_54_male : Amount := 0.0;
      age_55_male : Amount := 0.0;
      age_56_male : Amount := 0.0;
      age_57_male : Amount := 0.0;
      age_58_male : Amount := 0.0;
      age_59_male : Amount := 0.0;
      age_60_male : Amount := 0.0;
      age_61_male : Amount := 0.0;
      age_62_male : Amount := 0.0;
      age_63_male : Amount := 0.0;
      age_64_male : Amount := 0.0;
      age_65_male : Amount := 0.0;
      age_66_male : Amount := 0.0;
      age_67_male : Amount := 0.0;
      age_68_male : Amount := 0.0;
      age_69_male : Amount := 0.0;
      age_70_male : Amount := 0.0;
      age_71_male : Amount := 0.0;
      age_72_male : Amount := 0.0;
      age_73_male : Amount := 0.0;
      age_74_male : Amount := 0.0;
      age_75_male : Amount := 0.0;
      age_76_male : Amount := 0.0;
      age_77_male : Amount := 0.0;
      age_78_male : Amount := 0.0;
      age_79_male : Amount := 0.0;
      age_80_male : Amount := 0.0;
      age_81_male : Amount := 0.0;
      age_82_male : Amount := 0.0;
      age_83_male : Amount := 0.0;
      age_84_male : Amount := 0.0;
      age_85_male : Amount := 0.0;
      age_86_male : Amount := 0.0;
      age_87_male : Amount := 0.0;
      age_88_male : Amount := 0.0;
      age_89_male : Amount := 0.0;
      age_90_male : Amount := 0.0;
      age_91_male : Amount := 0.0;
      age_92_male : Amount := 0.0;
      age_93_male : Amount := 0.0;
      age_94_male : Amount := 0.0;
      age_95_male : Amount := 0.0;
      age_96_male : Amount := 0.0;
      age_97_male : Amount := 0.0;
      age_98_male : Amount := 0.0;
      age_99_male : Amount := 0.0;
      age_100_male : Amount := 0.0;
      age_101_male : Amount := 0.0;
      age_102_male : Amount := 0.0;
      age_103_male : Amount := 0.0;
      age_104_male : Amount := 0.0;
      age_105_male : Amount := 0.0;
      age_106_male : Amount := 0.0;
      age_107_male : Amount := 0.0;
      age_108_male : Amount := 0.0;
      age_109_male : Amount := 0.0;
      age_110_male : Amount := 0.0;
      age_0_female : Amount := 0.0;
      age_1_female : Amount := 0.0;
      age_2_female : Amount := 0.0;
      age_3_female : Amount := 0.0;
      age_4_female : Amount := 0.0;
      age_5_female : Amount := 0.0;
      age_6_female : Amount := 0.0;
      age_7_female : Amount := 0.0;
      age_8_female : Amount := 0.0;
      age_9_female : Amount := 0.0;
      age_10_female : Amount := 0.0;
      age_11_female : Amount := 0.0;
      age_12_female : Amount := 0.0;
      age_13_female : Amount := 0.0;
      age_14_female : Amount := 0.0;
      age_15_female : Amount := 0.0;
      age_16_female : Amount := 0.0;
      age_17_female : Amount := 0.0;
      age_18_female : Amount := 0.0;
      age_19_female : Amount := 0.0;
      age_20_female : Amount := 0.0;
      age_21_female : Amount := 0.0;
      age_22_female : Amount := 0.0;
      age_23_female : Amount := 0.0;
      age_24_female : Amount := 0.0;
      age_25_female : Amount := 0.0;
      age_26_female : Amount := 0.0;
      age_27_female : Amount := 0.0;
      age_28_female : Amount := 0.0;
      age_29_female : Amount := 0.0;
      age_30_female : Amount := 0.0;
      age_31_female : Amount := 0.0;
      age_32_female : Amount := 0.0;
      age_33_female : Amount := 0.0;
      age_34_female : Amount := 0.0;
      age_35_female : Amount := 0.0;
      age_36_female : Amount := 0.0;
      age_37_female : Amount := 0.0;
      age_38_female : Amount := 0.0;
      age_39_female : Amount := 0.0;
      age_40_female : Amount := 0.0;
      age_41_female : Amount := 0.0;
      age_42_female : Amount := 0.0;
      age_43_female : Amount := 0.0;
      age_44_female : Amount := 0.0;
      age_45_female : Amount := 0.0;
      age_46_female : Amount := 0.0;
      age_47_female : Amount := 0.0;
      age_48_female : Amount := 0.0;
      age_49_female : Amount := 0.0;
      age_50_female : Amount := 0.0;
      age_51_female : Amount := 0.0;
      age_52_female : Amount := 0.0;
      age_53_female : Amount := 0.0;
      age_54_female : Amount := 0.0;
      age_55_female : Amount := 0.0;
      age_56_female : Amount := 0.0;
      age_57_female : Amount := 0.0;
      age_58_female : Amount := 0.0;
      age_59_female : Amount := 0.0;
      age_60_female : Amount := 0.0;
      age_61_female : Amount := 0.0;
      age_62_female : Amount := 0.0;
      age_63_female : Amount := 0.0;
      age_64_female : Amount := 0.0;
      age_65_female : Amount := 0.0;
      age_66_female : Amount := 0.0;
      age_67_female : Amount := 0.0;
      age_68_female : Amount := 0.0;
      age_69_female : Amount := 0.0;
      age_70_female : Amount := 0.0;
      age_71_female : Amount := 0.0;
      age_72_female : Amount := 0.0;
      age_73_female : Amount := 0.0;
      age_74_female : Amount := 0.0;
      age_75_female : Amount := 0.0;
      age_76_female : Amount := 0.0;
      age_77_female : Amount := 0.0;
      age_78_female : Amount := 0.0;
      age_79_female : Amount := 0.0;
      age_80_female : Amount := 0.0;
      age_81_female : Amount := 0.0;
      age_82_female : Amount := 0.0;
      age_83_female : Amount := 0.0;
      age_84_female : Amount := 0.0;
      age_85_female : Amount := 0.0;
      age_86_female : Amount := 0.0;
      age_87_female : Amount := 0.0;
      age_88_female : Amount := 0.0;
      age_89_female : Amount := 0.0;
      age_90_female : Amount := 0.0;
      age_91_female : Amount := 0.0;
      age_92_female : Amount := 0.0;
      age_93_female : Amount := 0.0;
      age_94_female : Amount := 0.0;
      age_95_female : Amount := 0.0;
      age_96_female : Amount := 0.0;
      age_97_female : Amount := 0.0;
      age_98_female : Amount := 0.0;
      age_99_female : Amount := 0.0;
      age_100_female : Amount := 0.0;
      age_101_female : Amount := 0.0;
      age_102_female : Amount := 0.0;
      age_103_female : Amount := 0.0;
      age_104_female : Amount := 0.0;
      age_105_female : Amount := 0.0;
      age_106_female : Amount := 0.0;
      age_107_female : Amount := 0.0;
      age_108_female : Amount := 0.0;
      age_109_female : Amount := 0.0;
      age_110_female : Amount := 0.0;
      age_0 : Amount := 0.0;
      age_1 : Amount := 0.0;
      age_2 : Amount := 0.0;
      age_3 : Amount := 0.0;
      age_4 : Amount := 0.0;
      age_5 : Amount := 0.0;
      age_6 : Amount := 0.0;
      age_7 : Amount := 0.0;
      age_8 : Amount := 0.0;
      age_9 : Amount := 0.0;
      age_10 : Amount := 0.0;
      age_11 : Amount := 0.0;
      age_12 : Amount := 0.0;
      age_13 : Amount := 0.0;
      age_14 : Amount := 0.0;
      age_15 : Amount := 0.0;
      age_16 : Amount := 0.0;
      age_17 : Amount := 0.0;
      age_18 : Amount := 0.0;
      age_19 : Amount := 0.0;
      age_20 : Amount := 0.0;
      age_21 : Amount := 0.0;
      age_22 : Amount := 0.0;
      age_23 : Amount := 0.0;
      age_24 : Amount := 0.0;
      age_25 : Amount := 0.0;
      age_26 : Amount := 0.0;
      age_27 : Amount := 0.0;
      age_28 : Amount := 0.0;
      age_29 : Amount := 0.0;
      age_30 : Amount := 0.0;
      age_31 : Amount := 0.0;
      age_32 : Amount := 0.0;
      age_33 : Amount := 0.0;
      age_34 : Amount := 0.0;
      age_35 : Amount := 0.0;
      age_36 : Amount := 0.0;
      age_37 : Amount := 0.0;
      age_38 : Amount := 0.0;
      age_39 : Amount := 0.0;
      age_40 : Amount := 0.0;
      age_41 : Amount := 0.0;
      age_42 : Amount := 0.0;
      age_43 : Amount := 0.0;
      age_44 : Amount := 0.0;
      age_45 : Amount := 0.0;
      age_46 : Amount := 0.0;
      age_47 : Amount := 0.0;
      age_48 : Amount := 0.0;
      age_49 : Amount := 0.0;
      age_50 : Amount := 0.0;
      age_51 : Amount := 0.0;
      age_52 : Amount := 0.0;
      age_53 : Amount := 0.0;
      age_54 : Amount := 0.0;
      age_55 : Amount := 0.0;
      age_56 : Amount := 0.0;
      age_57 : Amount := 0.0;
      age_58 : Amount := 0.0;
      age_59 : Amount := 0.0;
      age_60 : Amount := 0.0;
      age_61 : Amount := 0.0;
      age_62 : Amount := 0.0;
      age_63 : Amount := 0.0;
      age_64 : Amount := 0.0;
      age_65 : Amount := 0.0;
      age_66 : Amount := 0.0;
      age_67 : Amount := 0.0;
      age_68 : Amount := 0.0;
      age_69 : Amount := 0.0;
      age_70 : Amount := 0.0;
      age_71 : Amount := 0.0;
      age_72 : Amount := 0.0;
      age_73 : Amount := 0.0;
      age_74 : Amount := 0.0;
      age_75 : Amount := 0.0;
      age_76 : Amount := 0.0;
      age_77 : Amount := 0.0;
      age_78 : Amount := 0.0;
      age_79 : Amount := 0.0;
      age_80 : Amount := 0.0;
      age_81 : Amount := 0.0;
      age_82 : Amount := 0.0;
      age_83 : Amount := 0.0;
      age_84 : Amount := 0.0;
      age_85 : Amount := 0.0;
      age_86 : Amount := 0.0;
      age_87 : Amount := 0.0;
      age_88 : Amount := 0.0;
      age_89 : Amount := 0.0;
      age_90 : Amount := 0.0;
      age_91 : Amount := 0.0;
      age_92 : Amount := 0.0;
      age_93 : Amount := 0.0;
      age_94 : Amount := 0.0;
      age_95 : Amount := 0.0;
      age_96 : Amount := 0.0;
      age_97 : Amount := 0.0;
      age_98 : Amount := 0.0;
      age_99 : Amount := 0.0;
      age_100 : Amount := 0.0;
      age_101 : Amount := 0.0;
      age_102 : Amount := 0.0;
      age_103 : Amount := 0.0;
      age_104 : Amount := 0.0;
      age_105 : Amount := 0.0;
      age_106 : Amount := 0.0;
      age_107 : Amount := 0.0;
      age_108 : Amount := 0.0;
      age_109 : Amount := 0.0;
      age_110 : Amount := 0.0;
   end record;
   --
   -- container for Target_Dataset : 
   --
   package Target_Dataset_List_Package is new Ada.Containers.Vectors
      (Element_Type => Target_Dataset,
      Index_Type => Positive );
   subtype Target_Dataset_List is Target_Dataset_List_Package.Vector;
   --
   -- default value for Target_Dataset : 
   --
   Null_Target_Dataset : constant Target_Dataset := (
         run_id => MISSING_I_KEY,
         user_id => 0,
         year => 1970,
         sernum => 0,
         country_uk => 0.0,
         country_scotland => 0.0,
         country_england => 0.0,
         country_wales => 0.0,
         country_n_ireland => 0.0,
         household_one_adult_male => 0.0,
         household_one_adult_female => 0.0,
         household_two_adults => 0.0,
         household_one_adult_one_child => 0.0,
         household_one_adult_two_plus_children => 0.0,
         household_two_plus_adult_one_plus_children => 0.0,
         household_three_plus_person_all_adult => 0.0,
         household_all_households => 0.0,
         male => 0.0,
         female => 0.0,
         employed => 0.0,
         employee => 0.0,
         ilo_unemployed => 0.0,
         jsa_claimant => 0.0,
         age_0_male => 0.0,
         age_1_male => 0.0,
         age_2_male => 0.0,
         age_3_male => 0.0,
         age_4_male => 0.0,
         age_5_male => 0.0,
         age_6_male => 0.0,
         age_7_male => 0.0,
         age_8_male => 0.0,
         age_9_male => 0.0,
         age_10_male => 0.0,
         age_11_male => 0.0,
         age_12_male => 0.0,
         age_13_male => 0.0,
         age_14_male => 0.0,
         age_15_male => 0.0,
         age_16_male => 0.0,
         age_17_male => 0.0,
         age_18_male => 0.0,
         age_19_male => 0.0,
         age_20_male => 0.0,
         age_21_male => 0.0,
         age_22_male => 0.0,
         age_23_male => 0.0,
         age_24_male => 0.0,
         age_25_male => 0.0,
         age_26_male => 0.0,
         age_27_male => 0.0,
         age_28_male => 0.0,
         age_29_male => 0.0,
         age_30_male => 0.0,
         age_31_male => 0.0,
         age_32_male => 0.0,
         age_33_male => 0.0,
         age_34_male => 0.0,
         age_35_male => 0.0,
         age_36_male => 0.0,
         age_37_male => 0.0,
         age_38_male => 0.0,
         age_39_male => 0.0,
         age_40_male => 0.0,
         age_41_male => 0.0,
         age_42_male => 0.0,
         age_43_male => 0.0,
         age_44_male => 0.0,
         age_45_male => 0.0,
         age_46_male => 0.0,
         age_47_male => 0.0,
         age_48_male => 0.0,
         age_49_male => 0.0,
         age_50_male => 0.0,
         age_51_male => 0.0,
         age_52_male => 0.0,
         age_53_male => 0.0,
         age_54_male => 0.0,
         age_55_male => 0.0,
         age_56_male => 0.0,
         age_57_male => 0.0,
         age_58_male => 0.0,
         age_59_male => 0.0,
         age_60_male => 0.0,
         age_61_male => 0.0,
         age_62_male => 0.0,
         age_63_male => 0.0,
         age_64_male => 0.0,
         age_65_male => 0.0,
         age_66_male => 0.0,
         age_67_male => 0.0,
         age_68_male => 0.0,
         age_69_male => 0.0,
         age_70_male => 0.0,
         age_71_male => 0.0,
         age_72_male => 0.0,
         age_73_male => 0.0,
         age_74_male => 0.0,
         age_75_male => 0.0,
         age_76_male => 0.0,
         age_77_male => 0.0,
         age_78_male => 0.0,
         age_79_male => 0.0,
         age_80_male => 0.0,
         age_81_male => 0.0,
         age_82_male => 0.0,
         age_83_male => 0.0,
         age_84_male => 0.0,
         age_85_male => 0.0,
         age_86_male => 0.0,
         age_87_male => 0.0,
         age_88_male => 0.0,
         age_89_male => 0.0,
         age_90_male => 0.0,
         age_91_male => 0.0,
         age_92_male => 0.0,
         age_93_male => 0.0,
         age_94_male => 0.0,
         age_95_male => 0.0,
         age_96_male => 0.0,
         age_97_male => 0.0,
         age_98_male => 0.0,
         age_99_male => 0.0,
         age_100_male => 0.0,
         age_101_male => 0.0,
         age_102_male => 0.0,
         age_103_male => 0.0,
         age_104_male => 0.0,
         age_105_male => 0.0,
         age_106_male => 0.0,
         age_107_male => 0.0,
         age_108_male => 0.0,
         age_109_male => 0.0,
         age_110_male => 0.0,
         age_0_female => 0.0,
         age_1_female => 0.0,
         age_2_female => 0.0,
         age_3_female => 0.0,
         age_4_female => 0.0,
         age_5_female => 0.0,
         age_6_female => 0.0,
         age_7_female => 0.0,
         age_8_female => 0.0,
         age_9_female => 0.0,
         age_10_female => 0.0,
         age_11_female => 0.0,
         age_12_female => 0.0,
         age_13_female => 0.0,
         age_14_female => 0.0,
         age_15_female => 0.0,
         age_16_female => 0.0,
         age_17_female => 0.0,
         age_18_female => 0.0,
         age_19_female => 0.0,
         age_20_female => 0.0,
         age_21_female => 0.0,
         age_22_female => 0.0,
         age_23_female => 0.0,
         age_24_female => 0.0,
         age_25_female => 0.0,
         age_26_female => 0.0,
         age_27_female => 0.0,
         age_28_female => 0.0,
         age_29_female => 0.0,
         age_30_female => 0.0,
         age_31_female => 0.0,
         age_32_female => 0.0,
         age_33_female => 0.0,
         age_34_female => 0.0,
         age_35_female => 0.0,
         age_36_female => 0.0,
         age_37_female => 0.0,
         age_38_female => 0.0,
         age_39_female => 0.0,
         age_40_female => 0.0,
         age_41_female => 0.0,
         age_42_female => 0.0,
         age_43_female => 0.0,
         age_44_female => 0.0,
         age_45_female => 0.0,
         age_46_female => 0.0,
         age_47_female => 0.0,
         age_48_female => 0.0,
         age_49_female => 0.0,
         age_50_female => 0.0,
         age_51_female => 0.0,
         age_52_female => 0.0,
         age_53_female => 0.0,
         age_54_female => 0.0,
         age_55_female => 0.0,
         age_56_female => 0.0,
         age_57_female => 0.0,
         age_58_female => 0.0,
         age_59_female => 0.0,
         age_60_female => 0.0,
         age_61_female => 0.0,
         age_62_female => 0.0,
         age_63_female => 0.0,
         age_64_female => 0.0,
         age_65_female => 0.0,
         age_66_female => 0.0,
         age_67_female => 0.0,
         age_68_female => 0.0,
         age_69_female => 0.0,
         age_70_female => 0.0,
         age_71_female => 0.0,
         age_72_female => 0.0,
         age_73_female => 0.0,
         age_74_female => 0.0,
         age_75_female => 0.0,
         age_76_female => 0.0,
         age_77_female => 0.0,
         age_78_female => 0.0,
         age_79_female => 0.0,
         age_80_female => 0.0,
         age_81_female => 0.0,
         age_82_female => 0.0,
         age_83_female => 0.0,
         age_84_female => 0.0,
         age_85_female => 0.0,
         age_86_female => 0.0,
         age_87_female => 0.0,
         age_88_female => 0.0,
         age_89_female => 0.0,
         age_90_female => 0.0,
         age_91_female => 0.0,
         age_92_female => 0.0,
         age_93_female => 0.0,
         age_94_female => 0.0,
         age_95_female => 0.0,
         age_96_female => 0.0,
         age_97_female => 0.0,
         age_98_female => 0.0,
         age_99_female => 0.0,
         age_100_female => 0.0,
         age_101_female => 0.0,
         age_102_female => 0.0,
         age_103_female => 0.0,
         age_104_female => 0.0,
         age_105_female => 0.0,
         age_106_female => 0.0,
         age_107_female => 0.0,
         age_108_female => 0.0,
         age_109_female => 0.0,
         age_110_female => 0.0,
         age_0 => 0.0,
         age_1 => 0.0,
         age_2 => 0.0,
         age_3 => 0.0,
         age_4 => 0.0,
         age_5 => 0.0,
         age_6 => 0.0,
         age_7 => 0.0,
         age_8 => 0.0,
         age_9 => 0.0,
         age_10 => 0.0,
         age_11 => 0.0,
         age_12 => 0.0,
         age_13 => 0.0,
         age_14 => 0.0,
         age_15 => 0.0,
         age_16 => 0.0,
         age_17 => 0.0,
         age_18 => 0.0,
         age_19 => 0.0,
         age_20 => 0.0,
         age_21 => 0.0,
         age_22 => 0.0,
         age_23 => 0.0,
         age_24 => 0.0,
         age_25 => 0.0,
         age_26 => 0.0,
         age_27 => 0.0,
         age_28 => 0.0,
         age_29 => 0.0,
         age_30 => 0.0,
         age_31 => 0.0,
         age_32 => 0.0,
         age_33 => 0.0,
         age_34 => 0.0,
         age_35 => 0.0,
         age_36 => 0.0,
         age_37 => 0.0,
         age_38 => 0.0,
         age_39 => 0.0,
         age_40 => 0.0,
         age_41 => 0.0,
         age_42 => 0.0,
         age_43 => 0.0,
         age_44 => 0.0,
         age_45 => 0.0,
         age_46 => 0.0,
         age_47 => 0.0,
         age_48 => 0.0,
         age_49 => 0.0,
         age_50 => 0.0,
         age_51 => 0.0,
         age_52 => 0.0,
         age_53 => 0.0,
         age_54 => 0.0,
         age_55 => 0.0,
         age_56 => 0.0,
         age_57 => 0.0,
         age_58 => 0.0,
         age_59 => 0.0,
         age_60 => 0.0,
         age_61 => 0.0,
         age_62 => 0.0,
         age_63 => 0.0,
         age_64 => 0.0,
         age_65 => 0.0,
         age_66 => 0.0,
         age_67 => 0.0,
         age_68 => 0.0,
         age_69 => 0.0,
         age_70 => 0.0,
         age_71 => 0.0,
         age_72 => 0.0,
         age_73 => 0.0,
         age_74 => 0.0,
         age_75 => 0.0,
         age_76 => 0.0,
         age_77 => 0.0,
         age_78 => 0.0,
         age_79 => 0.0,
         age_80 => 0.0,
         age_81 => 0.0,
         age_82 => 0.0,
         age_83 => 0.0,
         age_84 => 0.0,
         age_85 => 0.0,
         age_86 => 0.0,
         age_87 => 0.0,
         age_88 => 0.0,
         age_89 => 0.0,
         age_90 => 0.0,
         age_91 => 0.0,
         age_92 => 0.0,
         age_93 => 0.0,
         age_94 => 0.0,
         age_95 => 0.0,
         age_96 => 0.0,
         age_97 => 0.0,
         age_98 => 0.0,
         age_99 => 0.0,
         age_100 => 0.0,
         age_101 => 0.0,
         age_102 => 0.0,
         age_103 => 0.0,
         age_104 => 0.0,
         age_105 => 0.0,
         age_106 => 0.0,
         age_107 => 0.0,
         age_108 => 0.0,
         age_109 => 0.0,
         age_110 => 0.0
   );
   --
   -- simple print routine for Target_Dataset : 
   --
   function To_String( rec : Target_Dataset ) return String;

   --
   -- record modelling Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   type Population_Forecasts is record
      year : Year_Number := 1970;
      rec_type : Unbounded_String := To_Unbounded_String( "persons" );
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := 1970;
      target_group : Unbounded_String := MISSING_W_KEY;
      all_ages : Amount := 0.0;
      age_0 : Amount := 0.0;
      age_1 : Amount := 0.0;
      age_2 : Amount := 0.0;
      age_3 : Amount := 0.0;
      age_4 : Amount := 0.0;
      age_5 : Amount := 0.0;
      age_6 : Amount := 0.0;
      age_7 : Amount := 0.0;
      age_8 : Amount := 0.0;
      age_9 : Amount := 0.0;
      age_10 : Amount := 0.0;
      age_11 : Amount := 0.0;
      age_12 : Amount := 0.0;
      age_13 : Amount := 0.0;
      age_14 : Amount := 0.0;
      age_15 : Amount := 0.0;
      age_16 : Amount := 0.0;
      age_17 : Amount := 0.0;
      age_18 : Amount := 0.0;
      age_19 : Amount := 0.0;
      age_20 : Amount := 0.0;
      age_21 : Amount := 0.0;
      age_22 : Amount := 0.0;
      age_23 : Amount := 0.0;
      age_24 : Amount := 0.0;
      age_25 : Amount := 0.0;
      age_26 : Amount := 0.0;
      age_27 : Amount := 0.0;
      age_28 : Amount := 0.0;
      age_29 : Amount := 0.0;
      age_30 : Amount := 0.0;
      age_31 : Amount := 0.0;
      age_32 : Amount := 0.0;
      age_33 : Amount := 0.0;
      age_34 : Amount := 0.0;
      age_35 : Amount := 0.0;
      age_36 : Amount := 0.0;
      age_37 : Amount := 0.0;
      age_38 : Amount := 0.0;
      age_39 : Amount := 0.0;
      age_40 : Amount := 0.0;
      age_41 : Amount := 0.0;
      age_42 : Amount := 0.0;
      age_43 : Amount := 0.0;
      age_44 : Amount := 0.0;
      age_45 : Amount := 0.0;
      age_46 : Amount := 0.0;
      age_47 : Amount := 0.0;
      age_48 : Amount := 0.0;
      age_49 : Amount := 0.0;
      age_50 : Amount := 0.0;
      age_51 : Amount := 0.0;
      age_52 : Amount := 0.0;
      age_53 : Amount := 0.0;
      age_54 : Amount := 0.0;
      age_55 : Amount := 0.0;
      age_56 : Amount := 0.0;
      age_57 : Amount := 0.0;
      age_58 : Amount := 0.0;
      age_59 : Amount := 0.0;
      age_60 : Amount := 0.0;
      age_61 : Amount := 0.0;
      age_62 : Amount := 0.0;
      age_63 : Amount := 0.0;
      age_64 : Amount := 0.0;
      age_65 : Amount := 0.0;
      age_66 : Amount := 0.0;
      age_67 : Amount := 0.0;
      age_68 : Amount := 0.0;
      age_69 : Amount := 0.0;
      age_70 : Amount := 0.0;
      age_71 : Amount := 0.0;
      age_72 : Amount := 0.0;
      age_73 : Amount := 0.0;
      age_74 : Amount := 0.0;
      age_75 : Amount := 0.0;
      age_76 : Amount := 0.0;
      age_77 : Amount := 0.0;
      age_78 : Amount := 0.0;
      age_79 : Amount := 0.0;
      age_80 : Amount := 0.0;
      age_81 : Amount := 0.0;
      age_82 : Amount := 0.0;
      age_83 : Amount := 0.0;
      age_84 : Amount := 0.0;
      age_85 : Amount := 0.0;
      age_86 : Amount := 0.0;
      age_87 : Amount := 0.0;
      age_88 : Amount := 0.0;
      age_89 : Amount := 0.0;
      age_90 : Amount := 0.0;
      age_91 : Amount := 0.0;
      age_92 : Amount := 0.0;
      age_93 : Amount := 0.0;
      age_94 : Amount := 0.0;
      age_95 : Amount := 0.0;
      age_96 : Amount := 0.0;
      age_97 : Amount := 0.0;
      age_98 : Amount := 0.0;
      age_99 : Amount := 0.0;
      age_100 : Amount := 0.0;
      age_101 : Amount := 0.0;
      age_102 : Amount := 0.0;
      age_103 : Amount := 0.0;
      age_104 : Amount := 0.0;
      age_105 : Amount := 0.0;
      age_106 : Amount := 0.0;
      age_107 : Amount := 0.0;
      age_108 : Amount := 0.0;
      age_109 : Amount := 0.0;
      age_110 : Amount := 0.0;
   end record;
   --
   -- container for Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   package Population_Forecasts_List_Package is new Ada.Containers.Vectors
      (Element_Type => Population_Forecasts,
      Index_Type => Positive );
   subtype Population_Forecasts_List is Population_Forecasts_List_Package.Vector;
   --
   -- default value for Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   Null_Population_Forecasts : constant Population_Forecasts := (
         year => 1970,
         rec_type => To_Unbounded_String( "persons" ),
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => 1970,
         target_group => MISSING_W_KEY,
         all_ages => 0.0,
         age_0 => 0.0,
         age_1 => 0.0,
         age_2 => 0.0,
         age_3 => 0.0,
         age_4 => 0.0,
         age_5 => 0.0,
         age_6 => 0.0,
         age_7 => 0.0,
         age_8 => 0.0,
         age_9 => 0.0,
         age_10 => 0.0,
         age_11 => 0.0,
         age_12 => 0.0,
         age_13 => 0.0,
         age_14 => 0.0,
         age_15 => 0.0,
         age_16 => 0.0,
         age_17 => 0.0,
         age_18 => 0.0,
         age_19 => 0.0,
         age_20 => 0.0,
         age_21 => 0.0,
         age_22 => 0.0,
         age_23 => 0.0,
         age_24 => 0.0,
         age_25 => 0.0,
         age_26 => 0.0,
         age_27 => 0.0,
         age_28 => 0.0,
         age_29 => 0.0,
         age_30 => 0.0,
         age_31 => 0.0,
         age_32 => 0.0,
         age_33 => 0.0,
         age_34 => 0.0,
         age_35 => 0.0,
         age_36 => 0.0,
         age_37 => 0.0,
         age_38 => 0.0,
         age_39 => 0.0,
         age_40 => 0.0,
         age_41 => 0.0,
         age_42 => 0.0,
         age_43 => 0.0,
         age_44 => 0.0,
         age_45 => 0.0,
         age_46 => 0.0,
         age_47 => 0.0,
         age_48 => 0.0,
         age_49 => 0.0,
         age_50 => 0.0,
         age_51 => 0.0,
         age_52 => 0.0,
         age_53 => 0.0,
         age_54 => 0.0,
         age_55 => 0.0,
         age_56 => 0.0,
         age_57 => 0.0,
         age_58 => 0.0,
         age_59 => 0.0,
         age_60 => 0.0,
         age_61 => 0.0,
         age_62 => 0.0,
         age_63 => 0.0,
         age_64 => 0.0,
         age_65 => 0.0,
         age_66 => 0.0,
         age_67 => 0.0,
         age_68 => 0.0,
         age_69 => 0.0,
         age_70 => 0.0,
         age_71 => 0.0,
         age_72 => 0.0,
         age_73 => 0.0,
         age_74 => 0.0,
         age_75 => 0.0,
         age_76 => 0.0,
         age_77 => 0.0,
         age_78 => 0.0,
         age_79 => 0.0,
         age_80 => 0.0,
         age_81 => 0.0,
         age_82 => 0.0,
         age_83 => 0.0,
         age_84 => 0.0,
         age_85 => 0.0,
         age_86 => 0.0,
         age_87 => 0.0,
         age_88 => 0.0,
         age_89 => 0.0,
         age_90 => 0.0,
         age_91 => 0.0,
         age_92 => 0.0,
         age_93 => 0.0,
         age_94 => 0.0,
         age_95 => 0.0,
         age_96 => 0.0,
         age_97 => 0.0,
         age_98 => 0.0,
         age_99 => 0.0,
         age_100 => 0.0,
         age_101 => 0.0,
         age_102 => 0.0,
         age_103 => 0.0,
         age_104 => 0.0,
         age_105 => 0.0,
         age_106 => 0.0,
         age_107 => 0.0,
         age_108 => 0.0,
         age_109 => 0.0,
         age_110 => 0.0
   );
   --
   -- simple print routine for Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   function To_String( rec : Population_Forecasts ) return String;

   --
   -- record modelling Macro_Forecasts : 
   --
   type Macro_Forecasts is record
      year : Year_Number := 1970;
      rec_type : Unbounded_String := To_Unbounded_String( "macro" );
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := 1970;
      employment : Amount := 0.0;
      employment_rate : Amount := 0.0;
      employees : Amount := 0.0;
      ilo_unemployment : Amount := 0.0;
      ilo_unemployment_rate : Amount := 0.0;
      participation_rate : Amount := 0.0;
      claimant_count : Amount := 0.0;
      average_hours_worked : Amount := 0.0;
      total_hours_worked : Amount := 0.0;
      labour_share : Amount := 0.0;
      compensation_of_employees : Amount := 0.0;
      wages_and_salaries : Amount := 0.0;
      employers_social_contributions : Amount := 0.0;
      mixed_income : Amount := 0.0;
      average_earnings_growth : Amount := 0.0;
      average_earnings_index : Amount := 0.0;
      average_hourly_earnings_index : Amount := 0.0;
      productivity_per_hour_index : Amount := 0.0;
      productivity_per_worker_index : Amount := 0.0;
      real_product_wage : Amount := 0.0;
      real_consumption_wage : Amount := 0.0;
      rpi : Amount := 0.0;
      rpix : Amount := 0.0;
      cpi : Amount := 0.0;
      producer_output_prices : Amount := 0.0;
      mortgage_interest_payments : Amount := 0.0;
      actual_rents_for_housing : Amount := 0.0;
      consumer_expenditure_deflator : Amount := 0.0;
      house_price_index : Amount := 0.0;
      gdp_deflator : Amount := 0.0;
      lfs_employment : Amount := 0.0;
      real_household_disposable_income : Amount := 0.0;
      real_consumption : Amount := 0.0;
      real_gdp : Amount := 0.0;
      lfs_employment_age_16_plus : Amount := 0.0;
      real_household_disposable_income_age_16_plus : Amount := 0.0;
      real_consumption_age_16_plus : Amount := 0.0;
      real_gdp_age_16_plus : Amount := 0.0;
   end record;
   --
   -- container for Macro_Forecasts : 
   --
   package Macro_Forecasts_List_Package is new Ada.Containers.Vectors
      (Element_Type => Macro_Forecasts,
      Index_Type => Positive );
   subtype Macro_Forecasts_List is Macro_Forecasts_List_Package.Vector;
   --
   -- default value for Macro_Forecasts : 
   --
   Null_Macro_Forecasts : constant Macro_Forecasts := (
         year => 1970,
         rec_type => To_Unbounded_String( "macro" ),
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => 1970,
         employment => 0.0,
         employment_rate => 0.0,
         employees => 0.0,
         ilo_unemployment => 0.0,
         ilo_unemployment_rate => 0.0,
         participation_rate => 0.0,
         claimant_count => 0.0,
         average_hours_worked => 0.0,
         total_hours_worked => 0.0,
         labour_share => 0.0,
         compensation_of_employees => 0.0,
         wages_and_salaries => 0.0,
         employers_social_contributions => 0.0,
         mixed_income => 0.0,
         average_earnings_growth => 0.0,
         average_earnings_index => 0.0,
         average_hourly_earnings_index => 0.0,
         productivity_per_hour_index => 0.0,
         productivity_per_worker_index => 0.0,
         real_product_wage => 0.0,
         real_consumption_wage => 0.0,
         rpi => 0.0,
         rpix => 0.0,
         cpi => 0.0,
         producer_output_prices => 0.0,
         mortgage_interest_payments => 0.0,
         actual_rents_for_housing => 0.0,
         consumer_expenditure_deflator => 0.0,
         house_price_index => 0.0,
         gdp_deflator => 0.0,
         lfs_employment => 0.0,
         real_household_disposable_income => 0.0,
         real_consumption => 0.0,
         real_gdp => 0.0,
         lfs_employment_age_16_plus => 0.0,
         real_household_disposable_income_age_16_plus => 0.0,
         real_consumption_age_16_plus => 0.0,
         real_gdp_age_16_plus => 0.0
   );
   --
   -- simple print routine for Macro_Forecasts : 
   --
   function To_String( rec : Macro_Forecasts ) return String;

   --
   -- record modelling Output_Weights : 
   --
   type Output_Weights is record
      run_id : Integer := MISSING_I_KEY;
      user_id : Integer := 0;
      year : Year_Number := Year_Number'First;
      sernum : Sernum_Value := 0;
      target_year : Year_Number := 1970;
      weight : Amount := 0.0;
   end record;
   --
   -- container for Output_Weights : 
   --
   package Output_Weights_List_Package is new Ada.Containers.Vectors
      (Element_Type => Output_Weights,
      Index_Type => Positive );
   subtype Output_Weights_List is Output_Weights_List_Package.Vector;
   --
   -- default value for Output_Weights : 
   --
   Null_Output_Weights : constant Output_Weights := (
         run_id => MISSING_I_KEY,
         user_id => 0,
         year => Year_Number'First,
         sernum => 0,
         target_year => 1970,
         weight => 0.0
   );
   --
   -- simple print routine for Output_Weights : 
   --
   function To_String( rec : Output_Weights ) return String;

   --
   -- record modelling Run : 
   --
   type Run is record
      run_id : Integer := MISSING_I_KEY;
      user_id : Integer := 0;
      run_type : Type_Of_Run := Type_Of_Run'First;
      description : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      country : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      macro_variant : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      macro_edition : Year_Number := 1970;
      households_variant : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      households_edition : Year_Number := 1970;
      population_variant : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      population_edition : Year_Number := 1970;
      start_year : Year_Number := 1970;
      end_year : Year_Number := 1970;
      weighting_function : Distance_Function_Type := Distance_Function_Type'First;
      weighting_lower_bound : Rate := 0.2;
      weighting_upper_bound : Rate := 2.0;
      targets_run_id : Integer := 0;
      targets_run_user_id : Integer := 1;
      data_run_id : Integer := 0;
      data_run_user_id : Integer := 1;
      selected_clauses : Selected_Clauses_Array := ( others => false );
   end record;
   --
   -- container for Run : 
   --
   package Run_List_Package is new Ada.Containers.Vectors
      (Element_Type => Run,
      Index_Type => Positive );
   subtype Run_List is Run_List_Package.Vector;
   --
   -- default value for Run : 
   --
   Null_Run : constant Run := (
         run_id => MISSING_I_KEY,
         user_id => 0,
         run_type => Type_Of_Run'First,
         description => Ada.Strings.Unbounded.Null_Unbounded_String,
         country => Ada.Strings.Unbounded.Null_Unbounded_String,
         macro_variant => Ada.Strings.Unbounded.Null_Unbounded_String,
         macro_edition => 1970,
         households_variant => Ada.Strings.Unbounded.Null_Unbounded_String,
         households_edition => 1970,
         population_variant => Ada.Strings.Unbounded.Null_Unbounded_String,
         population_edition => 1970,
         start_year => 1970,
         end_year => 1970,
         weighting_function => Distance_Function_Type'First,
         weighting_lower_bound => 0.2,
         weighting_upper_bound => 2.0,
         targets_run_id => 0,
         targets_run_user_id => 1,
         data_run_id => 0,
         data_run_user_id => 1,
         selected_clauses => ( others => false )
   );
   --
   -- simple print routine for Run : 
   --
   function To_String( rec : Run ) return String;

   --
   -- record modelling Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   type Households_Forecasts is record
      year : Integer := 0;
      rec_type : Unbounded_String := To_Unbounded_String( "households" );
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := 1970;
      one_adult_male : Amount := 0.0;
      one_adult_female : Amount := 0.0;
      two_adults : Amount := 0.0;
      one_adult_one_child : Amount := 0.0;
      one_adult_two_plus_children : Amount := 0.0;
      two_plus_adult_one_plus_children : Amount := 0.0;
      three_plus_person_all_adult : Amount := 0.0;
      all_households : Amount := 0.0;
   end record;
   --
   -- container for Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   package Households_Forecasts_List_Package is new Ada.Containers.Vectors
      (Element_Type => Households_Forecasts,
      Index_Type => Positive );
   subtype Households_Forecasts_List is Households_Forecasts_List_Package.Vector;
   --
   -- default value for Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   Null_Households_Forecasts : constant Households_Forecasts := (
         year => 0,
         rec_type => To_Unbounded_String( "households" ),
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => 1970,
         one_adult_male => 0.0,
         one_adult_female => 0.0,
         two_adults => 0.0,
         one_adult_one_child => 0.0,
         one_adult_two_plus_children => 0.0,
         two_plus_adult_one_plus_children => 0.0,
         three_plus_person_all_adult => 0.0,
         all_households => 0.0
   );
   --
   -- simple print routine for Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   function To_String( rec : Households_Forecasts ) return String;

   --
   -- record modelling Forecast_Variant : 
   --
   type Forecast_Variant is record
      rec_type : Unbounded_String := MISSING_W_KEY;
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := 1970;
      source : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      description : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      url : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      filename : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
   end record;
   --
   -- container for Forecast_Variant : 
   --
   package Forecast_Variant_List_Package is new Ada.Containers.Vectors
      (Element_Type => Forecast_Variant,
      Index_Type => Positive );
   subtype Forecast_Variant_List is Forecast_Variant_List_Package.Vector;
   --
   -- default value for Forecast_Variant : 
   --
   Null_Forecast_Variant : constant Forecast_Variant := (
         rec_type => MISSING_W_KEY,
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => 1970,
         source => Ada.Strings.Unbounded.Null_Unbounded_String,
         description => Ada.Strings.Unbounded.Null_Unbounded_String,
         url => Ada.Strings.Unbounded.Null_Unbounded_String,
         filename => Ada.Strings.Unbounded.Null_Unbounded_String
   );
   --
   -- simple print routine for Forecast_Variant : 
   --
   function To_String( rec : Forecast_Variant ) return String;

   --
   -- record modelling Country : 
   --
   type Country is record
      name : Unbounded_String := MISSING_W_KEY;
   end record;
   --
   -- container for Country : 
   --
   package Country_List_Package is new Ada.Containers.Vectors
      (Element_Type => Country,
      Index_Type => Positive );
   subtype Country_List is Country_List_Package.Vector;
   --
   -- default value for Country : 
   --
   Null_Country : constant Country := (
         name => MISSING_W_KEY
   );
   --
   -- simple print routine for Country : 
   --
   function To_String( rec : Country ) return String;

   --
   -- record modelling Forecast_Type : 
   --
   type Forecast_Type is record
      name : Unbounded_String := MISSING_W_KEY;
      description : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
   end record;
   --
   -- container for Forecast_Type : 
   --
   package Forecast_Type_List_Package is new Ada.Containers.Vectors
      (Element_Type => Forecast_Type,
      Index_Type => Positive );
   subtype Forecast_Type_List is Forecast_Type_List_Package.Vector;
   --
   -- default value for Forecast_Type : 
   --
   Null_Forecast_Type : constant Forecast_Type := (
         name => MISSING_W_KEY,
         description => Ada.Strings.Unbounded.Null_Unbounded_String
   );
   --
   -- simple print routine for Forecast_Type : 
   --
   function To_String( rec : Forecast_Type ) return String;



        
   -- === CUSTOM PROCS START ===
                               
   subtype Forecast_Age_Ranges is Natural range 0 .. 90;                            
   type Age_Range_Array is array( Forecast_Age_Ranges ) of Amount;                             
                              
   function To_Array( popn : Population_Forecasts ) return Age_Range_Array;                            
                               
   -- === CUSTOM PROCS END ===

end Ukds.target_data;
