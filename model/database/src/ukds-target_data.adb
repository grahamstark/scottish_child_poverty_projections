--
-- Created by ada_generator.py on 2017-09-20 20:28:53.463619
-- 

with GNAT.Calendar.Time_IO;
-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.target_data is

   use ada.strings.Unbounded;
   package tio renames GNAT.Calendar.Time_IO;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===
   
   
   function To_String( rec : Target_Dataset ) return String is
   begin
      return  "Target_Dataset: " &
         "run_id = " & rec.run_id'Img &
         "user_id = " & rec.user_id'Img &
         "year = " & rec.year'Img &
         "sernum = " & rec.sernum'Img &
         "country_uk = " & rec.country_uk'Img &
         "country_scotland = " & rec.country_scotland'Img &
         "country_england = " & rec.country_england'Img &
         "country_wales = " & rec.country_wales'Img &
         "country_n_ireland = " & rec.country_n_ireland'Img &
         "household_one_adult_male = " & rec.household_one_adult_male'Img &
         "household_one_adult_female = " & rec.household_one_adult_female'Img &
         "household_two_adults = " & rec.household_two_adults'Img &
         "household_one_adult_one_child = " & rec.household_one_adult_one_child'Img &
         "household_one_adult_two_plus_children = " & rec.household_one_adult_two_plus_children'Img &
         "household_two_plus_adult_one_plus_children = " & rec.household_two_plus_adult_one_plus_children'Img &
         "household_three_plus_person_all_adult = " & rec.household_three_plus_person_all_adult'Img &
         "household_all_households = " & rec.household_all_households'Img &
         "male = " & rec.male'Img &
         "female = " & rec.female'Img &
         "employed = " & rec.employed'Img &
         "employee = " & rec.employee'Img &
         "ilo_unemployed = " & rec.ilo_unemployed'Img &
         "jsa_claimant = " & rec.jsa_claimant'Img &
         "age_0_male = " & rec.age_0_male'Img &
         "age_1_male = " & rec.age_1_male'Img &
         "age_2_male = " & rec.age_2_male'Img &
         "age_3_male = " & rec.age_3_male'Img &
         "age_4_male = " & rec.age_4_male'Img &
         "age_5_male = " & rec.age_5_male'Img &
         "age_6_male = " & rec.age_6_male'Img &
         "age_7_male = " & rec.age_7_male'Img &
         "age_8_male = " & rec.age_8_male'Img &
         "age_9_male = " & rec.age_9_male'Img &
         "age_10_male = " & rec.age_10_male'Img &
         "age_11_male = " & rec.age_11_male'Img &
         "age_12_male = " & rec.age_12_male'Img &
         "age_13_male = " & rec.age_13_male'Img &
         "age_14_male = " & rec.age_14_male'Img &
         "age_15_male = " & rec.age_15_male'Img &
         "age_16_male = " & rec.age_16_male'Img &
         "age_17_male = " & rec.age_17_male'Img &
         "age_18_male = " & rec.age_18_male'Img &
         "age_19_male = " & rec.age_19_male'Img &
         "age_20_male = " & rec.age_20_male'Img &
         "age_21_male = " & rec.age_21_male'Img &
         "age_22_male = " & rec.age_22_male'Img &
         "age_23_male = " & rec.age_23_male'Img &
         "age_24_male = " & rec.age_24_male'Img &
         "age_25_male = " & rec.age_25_male'Img &
         "age_26_male = " & rec.age_26_male'Img &
         "age_27_male = " & rec.age_27_male'Img &
         "age_28_male = " & rec.age_28_male'Img &
         "age_29_male = " & rec.age_29_male'Img &
         "age_30_male = " & rec.age_30_male'Img &
         "age_31_male = " & rec.age_31_male'Img &
         "age_32_male = " & rec.age_32_male'Img &
         "age_33_male = " & rec.age_33_male'Img &
         "age_34_male = " & rec.age_34_male'Img &
         "age_35_male = " & rec.age_35_male'Img &
         "age_36_male = " & rec.age_36_male'Img &
         "age_37_male = " & rec.age_37_male'Img &
         "age_38_male = " & rec.age_38_male'Img &
         "age_39_male = " & rec.age_39_male'Img &
         "age_40_male = " & rec.age_40_male'Img &
         "age_41_male = " & rec.age_41_male'Img &
         "age_42_male = " & rec.age_42_male'Img &
         "age_43_male = " & rec.age_43_male'Img &
         "age_44_male = " & rec.age_44_male'Img &
         "age_45_male = " & rec.age_45_male'Img &
         "age_46_male = " & rec.age_46_male'Img &
         "age_47_male = " & rec.age_47_male'Img &
         "age_48_male = " & rec.age_48_male'Img &
         "age_49_male = " & rec.age_49_male'Img &
         "age_50_male = " & rec.age_50_male'Img &
         "age_51_male = " & rec.age_51_male'Img &
         "age_52_male = " & rec.age_52_male'Img &
         "age_53_male = " & rec.age_53_male'Img &
         "age_54_male = " & rec.age_54_male'Img &
         "age_55_male = " & rec.age_55_male'Img &
         "age_56_male = " & rec.age_56_male'Img &
         "age_57_male = " & rec.age_57_male'Img &
         "age_58_male = " & rec.age_58_male'Img &
         "age_59_male = " & rec.age_59_male'Img &
         "age_60_male = " & rec.age_60_male'Img &
         "age_61_male = " & rec.age_61_male'Img &
         "age_62_male = " & rec.age_62_male'Img &
         "age_63_male = " & rec.age_63_male'Img &
         "age_64_male = " & rec.age_64_male'Img &
         "age_65_male = " & rec.age_65_male'Img &
         "age_66_male = " & rec.age_66_male'Img &
         "age_67_male = " & rec.age_67_male'Img &
         "age_68_male = " & rec.age_68_male'Img &
         "age_69_male = " & rec.age_69_male'Img &
         "age_70_male = " & rec.age_70_male'Img &
         "age_71_male = " & rec.age_71_male'Img &
         "age_72_male = " & rec.age_72_male'Img &
         "age_73_male = " & rec.age_73_male'Img &
         "age_74_male = " & rec.age_74_male'Img &
         "age_75_male = " & rec.age_75_male'Img &
         "age_76_male = " & rec.age_76_male'Img &
         "age_77_male = " & rec.age_77_male'Img &
         "age_78_male = " & rec.age_78_male'Img &
         "age_79_male = " & rec.age_79_male'Img &
         "age_80_male = " & rec.age_80_male'Img &
         "age_81_male = " & rec.age_81_male'Img &
         "age_82_male = " & rec.age_82_male'Img &
         "age_83_male = " & rec.age_83_male'Img &
         "age_84_male = " & rec.age_84_male'Img &
         "age_85_male = " & rec.age_85_male'Img &
         "age_86_male = " & rec.age_86_male'Img &
         "age_87_male = " & rec.age_87_male'Img &
         "age_88_male = " & rec.age_88_male'Img &
         "age_89_male = " & rec.age_89_male'Img &
         "age_90_male = " & rec.age_90_male'Img &
         "age_91_male = " & rec.age_91_male'Img &
         "age_92_male = " & rec.age_92_male'Img &
         "age_93_male = " & rec.age_93_male'Img &
         "age_94_male = " & rec.age_94_male'Img &
         "age_95_male = " & rec.age_95_male'Img &
         "age_96_male = " & rec.age_96_male'Img &
         "age_97_male = " & rec.age_97_male'Img &
         "age_98_male = " & rec.age_98_male'Img &
         "age_99_male = " & rec.age_99_male'Img &
         "age_100_male = " & rec.age_100_male'Img &
         "age_101_male = " & rec.age_101_male'Img &
         "age_102_male = " & rec.age_102_male'Img &
         "age_103_male = " & rec.age_103_male'Img &
         "age_104_male = " & rec.age_104_male'Img &
         "age_105_male = " & rec.age_105_male'Img &
         "age_106_male = " & rec.age_106_male'Img &
         "age_107_male = " & rec.age_107_male'Img &
         "age_108_male = " & rec.age_108_male'Img &
         "age_109_male = " & rec.age_109_male'Img &
         "age_110_male = " & rec.age_110_male'Img &
         "age_0_female = " & rec.age_0_female'Img &
         "age_1_female = " & rec.age_1_female'Img &
         "age_2_female = " & rec.age_2_female'Img &
         "age_3_female = " & rec.age_3_female'Img &
         "age_4_female = " & rec.age_4_female'Img &
         "age_5_female = " & rec.age_5_female'Img &
         "age_6_female = " & rec.age_6_female'Img &
         "age_7_female = " & rec.age_7_female'Img &
         "age_8_female = " & rec.age_8_female'Img &
         "age_9_female = " & rec.age_9_female'Img &
         "age_10_female = " & rec.age_10_female'Img &
         "age_11_female = " & rec.age_11_female'Img &
         "age_12_female = " & rec.age_12_female'Img &
         "age_13_female = " & rec.age_13_female'Img &
         "age_14_female = " & rec.age_14_female'Img &
         "age_15_female = " & rec.age_15_female'Img &
         "age_16_female = " & rec.age_16_female'Img &
         "age_17_female = " & rec.age_17_female'Img &
         "age_18_female = " & rec.age_18_female'Img &
         "age_19_female = " & rec.age_19_female'Img &
         "age_20_female = " & rec.age_20_female'Img &
         "age_21_female = " & rec.age_21_female'Img &
         "age_22_female = " & rec.age_22_female'Img &
         "age_23_female = " & rec.age_23_female'Img &
         "age_24_female = " & rec.age_24_female'Img &
         "age_25_female = " & rec.age_25_female'Img &
         "age_26_female = " & rec.age_26_female'Img &
         "age_27_female = " & rec.age_27_female'Img &
         "age_28_female = " & rec.age_28_female'Img &
         "age_29_female = " & rec.age_29_female'Img &
         "age_30_female = " & rec.age_30_female'Img &
         "age_31_female = " & rec.age_31_female'Img &
         "age_32_female = " & rec.age_32_female'Img &
         "age_33_female = " & rec.age_33_female'Img &
         "age_34_female = " & rec.age_34_female'Img &
         "age_35_female = " & rec.age_35_female'Img &
         "age_36_female = " & rec.age_36_female'Img &
         "age_37_female = " & rec.age_37_female'Img &
         "age_38_female = " & rec.age_38_female'Img &
         "age_39_female = " & rec.age_39_female'Img &
         "age_40_female = " & rec.age_40_female'Img &
         "age_41_female = " & rec.age_41_female'Img &
         "age_42_female = " & rec.age_42_female'Img &
         "age_43_female = " & rec.age_43_female'Img &
         "age_44_female = " & rec.age_44_female'Img &
         "age_45_female = " & rec.age_45_female'Img &
         "age_46_female = " & rec.age_46_female'Img &
         "age_47_female = " & rec.age_47_female'Img &
         "age_48_female = " & rec.age_48_female'Img &
         "age_49_female = " & rec.age_49_female'Img &
         "age_50_female = " & rec.age_50_female'Img &
         "age_51_female = " & rec.age_51_female'Img &
         "age_52_female = " & rec.age_52_female'Img &
         "age_53_female = " & rec.age_53_female'Img &
         "age_54_female = " & rec.age_54_female'Img &
         "age_55_female = " & rec.age_55_female'Img &
         "age_56_female = " & rec.age_56_female'Img &
         "age_57_female = " & rec.age_57_female'Img &
         "age_58_female = " & rec.age_58_female'Img &
         "age_59_female = " & rec.age_59_female'Img &
         "age_60_female = " & rec.age_60_female'Img &
         "age_61_female = " & rec.age_61_female'Img &
         "age_62_female = " & rec.age_62_female'Img &
         "age_63_female = " & rec.age_63_female'Img &
         "age_64_female = " & rec.age_64_female'Img &
         "age_65_female = " & rec.age_65_female'Img &
         "age_66_female = " & rec.age_66_female'Img &
         "age_67_female = " & rec.age_67_female'Img &
         "age_68_female = " & rec.age_68_female'Img &
         "age_69_female = " & rec.age_69_female'Img &
         "age_70_female = " & rec.age_70_female'Img &
         "age_71_female = " & rec.age_71_female'Img &
         "age_72_female = " & rec.age_72_female'Img &
         "age_73_female = " & rec.age_73_female'Img &
         "age_74_female = " & rec.age_74_female'Img &
         "age_75_female = " & rec.age_75_female'Img &
         "age_76_female = " & rec.age_76_female'Img &
         "age_77_female = " & rec.age_77_female'Img &
         "age_78_female = " & rec.age_78_female'Img &
         "age_79_female = " & rec.age_79_female'Img &
         "age_80_female = " & rec.age_80_female'Img &
         "age_81_female = " & rec.age_81_female'Img &
         "age_82_female = " & rec.age_82_female'Img &
         "age_83_female = " & rec.age_83_female'Img &
         "age_84_female = " & rec.age_84_female'Img &
         "age_85_female = " & rec.age_85_female'Img &
         "age_86_female = " & rec.age_86_female'Img &
         "age_87_female = " & rec.age_87_female'Img &
         "age_88_female = " & rec.age_88_female'Img &
         "age_89_female = " & rec.age_89_female'Img &
         "age_90_female = " & rec.age_90_female'Img &
         "age_91_female = " & rec.age_91_female'Img &
         "age_92_female = " & rec.age_92_female'Img &
         "age_93_female = " & rec.age_93_female'Img &
         "age_94_female = " & rec.age_94_female'Img &
         "age_95_female = " & rec.age_95_female'Img &
         "age_96_female = " & rec.age_96_female'Img &
         "age_97_female = " & rec.age_97_female'Img &
         "age_98_female = " & rec.age_98_female'Img &
         "age_99_female = " & rec.age_99_female'Img &
         "age_100_female = " & rec.age_100_female'Img &
         "age_101_female = " & rec.age_101_female'Img &
         "age_102_female = " & rec.age_102_female'Img &
         "age_103_female = " & rec.age_103_female'Img &
         "age_104_female = " & rec.age_104_female'Img &
         "age_105_female = " & rec.age_105_female'Img &
         "age_106_female = " & rec.age_106_female'Img &
         "age_107_female = " & rec.age_107_female'Img &
         "age_108_female = " & rec.age_108_female'Img &
         "age_109_female = " & rec.age_109_female'Img &
         "age_110_female = " & rec.age_110_female'Img &
         "age_0 = " & rec.age_0'Img &
         "age_1 = " & rec.age_1'Img &
         "age_2 = " & rec.age_2'Img &
         "age_3 = " & rec.age_3'Img &
         "age_4 = " & rec.age_4'Img &
         "age_5 = " & rec.age_5'Img &
         "age_6 = " & rec.age_6'Img &
         "age_7 = " & rec.age_7'Img &
         "age_8 = " & rec.age_8'Img &
         "age_9 = " & rec.age_9'Img &
         "age_10 = " & rec.age_10'Img &
         "age_11 = " & rec.age_11'Img &
         "age_12 = " & rec.age_12'Img &
         "age_13 = " & rec.age_13'Img &
         "age_14 = " & rec.age_14'Img &
         "age_15 = " & rec.age_15'Img &
         "age_16 = " & rec.age_16'Img &
         "age_17 = " & rec.age_17'Img &
         "age_18 = " & rec.age_18'Img &
         "age_19 = " & rec.age_19'Img &
         "age_20 = " & rec.age_20'Img &
         "age_21 = " & rec.age_21'Img &
         "age_22 = " & rec.age_22'Img &
         "age_23 = " & rec.age_23'Img &
         "age_24 = " & rec.age_24'Img &
         "age_25 = " & rec.age_25'Img &
         "age_26 = " & rec.age_26'Img &
         "age_27 = " & rec.age_27'Img &
         "age_28 = " & rec.age_28'Img &
         "age_29 = " & rec.age_29'Img &
         "age_30 = " & rec.age_30'Img &
         "age_31 = " & rec.age_31'Img &
         "age_32 = " & rec.age_32'Img &
         "age_33 = " & rec.age_33'Img &
         "age_34 = " & rec.age_34'Img &
         "age_35 = " & rec.age_35'Img &
         "age_36 = " & rec.age_36'Img &
         "age_37 = " & rec.age_37'Img &
         "age_38 = " & rec.age_38'Img &
         "age_39 = " & rec.age_39'Img &
         "age_40 = " & rec.age_40'Img &
         "age_41 = " & rec.age_41'Img &
         "age_42 = " & rec.age_42'Img &
         "age_43 = " & rec.age_43'Img &
         "age_44 = " & rec.age_44'Img &
         "age_45 = " & rec.age_45'Img &
         "age_46 = " & rec.age_46'Img &
         "age_47 = " & rec.age_47'Img &
         "age_48 = " & rec.age_48'Img &
         "age_49 = " & rec.age_49'Img &
         "age_50 = " & rec.age_50'Img &
         "age_51 = " & rec.age_51'Img &
         "age_52 = " & rec.age_52'Img &
         "age_53 = " & rec.age_53'Img &
         "age_54 = " & rec.age_54'Img &
         "age_55 = " & rec.age_55'Img &
         "age_56 = " & rec.age_56'Img &
         "age_57 = " & rec.age_57'Img &
         "age_58 = " & rec.age_58'Img &
         "age_59 = " & rec.age_59'Img &
         "age_60 = " & rec.age_60'Img &
         "age_61 = " & rec.age_61'Img &
         "age_62 = " & rec.age_62'Img &
         "age_63 = " & rec.age_63'Img &
         "age_64 = " & rec.age_64'Img &
         "age_65 = " & rec.age_65'Img &
         "age_66 = " & rec.age_66'Img &
         "age_67 = " & rec.age_67'Img &
         "age_68 = " & rec.age_68'Img &
         "age_69 = " & rec.age_69'Img &
         "age_70 = " & rec.age_70'Img &
         "age_71 = " & rec.age_71'Img &
         "age_72 = " & rec.age_72'Img &
         "age_73 = " & rec.age_73'Img &
         "age_74 = " & rec.age_74'Img &
         "age_75 = " & rec.age_75'Img &
         "age_76 = " & rec.age_76'Img &
         "age_77 = " & rec.age_77'Img &
         "age_78 = " & rec.age_78'Img &
         "age_79 = " & rec.age_79'Img &
         "age_80 = " & rec.age_80'Img &
         "age_81 = " & rec.age_81'Img &
         "age_82 = " & rec.age_82'Img &
         "age_83 = " & rec.age_83'Img &
         "age_84 = " & rec.age_84'Img &
         "age_85 = " & rec.age_85'Img &
         "age_86 = " & rec.age_86'Img &
         "age_87 = " & rec.age_87'Img &
         "age_88 = " & rec.age_88'Img &
         "age_89 = " & rec.age_89'Img &
         "age_90 = " & rec.age_90'Img &
         "age_91 = " & rec.age_91'Img &
         "age_92 = " & rec.age_92'Img &
         "age_93 = " & rec.age_93'Img &
         "age_94 = " & rec.age_94'Img &
         "age_95 = " & rec.age_95'Img &
         "age_96 = " & rec.age_96'Img &
         "age_97 = " & rec.age_97'Img &
         "age_98 = " & rec.age_98'Img &
         "age_99 = " & rec.age_99'Img &
         "age_100 = " & rec.age_100'Img &
         "age_101 = " & rec.age_101'Img &
         "age_102 = " & rec.age_102'Img &
         "age_103 = " & rec.age_103'Img &
         "age_104 = " & rec.age_104'Img &
         "age_105 = " & rec.age_105'Img &
         "age_106 = " & rec.age_106'Img &
         "age_107 = " & rec.age_107'Img &
         "age_108 = " & rec.age_108'Img &
         "age_109 = " & rec.age_109'Img &
         "age_110 = " & rec.age_110'Img;
   end to_String;


   function To_String( rec : Population_Forecasts ) return String is
   begin
      return  "Population_Forecasts: " &
         "year = " & rec.year'Img &
         "rec_type = " & To_String( rec.rec_type ) &
         "variant = " & To_String( rec.variant ) &
         "country = " & To_String( rec.country ) &
         "edition = " & rec.edition'Img &
         "target_group = " & To_String( rec.target_group ) &
         "all_ages = " & rec.all_ages'Img &
         "age_0 = " & rec.age_0'Img &
         "age_1 = " & rec.age_1'Img &
         "age_2 = " & rec.age_2'Img &
         "age_3 = " & rec.age_3'Img &
         "age_4 = " & rec.age_4'Img &
         "age_5 = " & rec.age_5'Img &
         "age_6 = " & rec.age_6'Img &
         "age_7 = " & rec.age_7'Img &
         "age_8 = " & rec.age_8'Img &
         "age_9 = " & rec.age_9'Img &
         "age_10 = " & rec.age_10'Img &
         "age_11 = " & rec.age_11'Img &
         "age_12 = " & rec.age_12'Img &
         "age_13 = " & rec.age_13'Img &
         "age_14 = " & rec.age_14'Img &
         "age_15 = " & rec.age_15'Img &
         "age_16 = " & rec.age_16'Img &
         "age_17 = " & rec.age_17'Img &
         "age_18 = " & rec.age_18'Img &
         "age_19 = " & rec.age_19'Img &
         "age_20 = " & rec.age_20'Img &
         "age_21 = " & rec.age_21'Img &
         "age_22 = " & rec.age_22'Img &
         "age_23 = " & rec.age_23'Img &
         "age_24 = " & rec.age_24'Img &
         "age_25 = " & rec.age_25'Img &
         "age_26 = " & rec.age_26'Img &
         "age_27 = " & rec.age_27'Img &
         "age_28 = " & rec.age_28'Img &
         "age_29 = " & rec.age_29'Img &
         "age_30 = " & rec.age_30'Img &
         "age_31 = " & rec.age_31'Img &
         "age_32 = " & rec.age_32'Img &
         "age_33 = " & rec.age_33'Img &
         "age_34 = " & rec.age_34'Img &
         "age_35 = " & rec.age_35'Img &
         "age_36 = " & rec.age_36'Img &
         "age_37 = " & rec.age_37'Img &
         "age_38 = " & rec.age_38'Img &
         "age_39 = " & rec.age_39'Img &
         "age_40 = " & rec.age_40'Img &
         "age_41 = " & rec.age_41'Img &
         "age_42 = " & rec.age_42'Img &
         "age_43 = " & rec.age_43'Img &
         "age_44 = " & rec.age_44'Img &
         "age_45 = " & rec.age_45'Img &
         "age_46 = " & rec.age_46'Img &
         "age_47 = " & rec.age_47'Img &
         "age_48 = " & rec.age_48'Img &
         "age_49 = " & rec.age_49'Img &
         "age_50 = " & rec.age_50'Img &
         "age_51 = " & rec.age_51'Img &
         "age_52 = " & rec.age_52'Img &
         "age_53 = " & rec.age_53'Img &
         "age_54 = " & rec.age_54'Img &
         "age_55 = " & rec.age_55'Img &
         "age_56 = " & rec.age_56'Img &
         "age_57 = " & rec.age_57'Img &
         "age_58 = " & rec.age_58'Img &
         "age_59 = " & rec.age_59'Img &
         "age_60 = " & rec.age_60'Img &
         "age_61 = " & rec.age_61'Img &
         "age_62 = " & rec.age_62'Img &
         "age_63 = " & rec.age_63'Img &
         "age_64 = " & rec.age_64'Img &
         "age_65 = " & rec.age_65'Img &
         "age_66 = " & rec.age_66'Img &
         "age_67 = " & rec.age_67'Img &
         "age_68 = " & rec.age_68'Img &
         "age_69 = " & rec.age_69'Img &
         "age_70 = " & rec.age_70'Img &
         "age_71 = " & rec.age_71'Img &
         "age_72 = " & rec.age_72'Img &
         "age_73 = " & rec.age_73'Img &
         "age_74 = " & rec.age_74'Img &
         "age_75 = " & rec.age_75'Img &
         "age_76 = " & rec.age_76'Img &
         "age_77 = " & rec.age_77'Img &
         "age_78 = " & rec.age_78'Img &
         "age_79 = " & rec.age_79'Img &
         "age_80 = " & rec.age_80'Img &
         "age_81 = " & rec.age_81'Img &
         "age_82 = " & rec.age_82'Img &
         "age_83 = " & rec.age_83'Img &
         "age_84 = " & rec.age_84'Img &
         "age_85 = " & rec.age_85'Img &
         "age_86 = " & rec.age_86'Img &
         "age_87 = " & rec.age_87'Img &
         "age_88 = " & rec.age_88'Img &
         "age_89 = " & rec.age_89'Img &
         "age_90 = " & rec.age_90'Img &
         "age_91 = " & rec.age_91'Img &
         "age_92 = " & rec.age_92'Img &
         "age_93 = " & rec.age_93'Img &
         "age_94 = " & rec.age_94'Img &
         "age_95 = " & rec.age_95'Img &
         "age_96 = " & rec.age_96'Img &
         "age_97 = " & rec.age_97'Img &
         "age_98 = " & rec.age_98'Img &
         "age_99 = " & rec.age_99'Img &
         "age_100 = " & rec.age_100'Img &
         "age_101 = " & rec.age_101'Img &
         "age_102 = " & rec.age_102'Img &
         "age_103 = " & rec.age_103'Img &
         "age_104 = " & rec.age_104'Img &
         "age_105 = " & rec.age_105'Img &
         "age_106 = " & rec.age_106'Img &
         "age_107 = " & rec.age_107'Img &
         "age_108 = " & rec.age_108'Img &
         "age_109 = " & rec.age_109'Img &
         "age_110 = " & rec.age_110'Img;
   end to_String;


   function To_String( rec : Macro_Forecasts ) return String is
   begin
      return  "Macro_Forecasts: " &
         "year = " & rec.year'Img &
         "rec_type = " & To_String( rec.rec_type ) &
         "variant = " & To_String( rec.variant ) &
         "country = " & To_String( rec.country ) &
         "edition = " & rec.edition'Img &
         "employment = " & rec.employment'Img &
         "employment_rate = " & rec.employment_rate'Img &
         "employees = " & rec.employees'Img &
         "ilo_unemployment = " & rec.ilo_unemployment'Img &
         "ilo_unemployment_rate = " & rec.ilo_unemployment_rate'Img &
         "participation_rate = " & rec.participation_rate'Img &
         "claimant_count = " & rec.claimant_count'Img &
         "average_hours_worked = " & rec.average_hours_worked'Img &
         "total_hours_worked = " & rec.total_hours_worked'Img &
         "labour_share = " & rec.labour_share'Img &
         "compensation_of_employees = " & rec.compensation_of_employees'Img &
         "wages_and_salaries = " & rec.wages_and_salaries'Img &
         "employers_social_contributions = " & rec.employers_social_contributions'Img &
         "mixed_income = " & rec.mixed_income'Img &
         "average_earnings_growth = " & rec.average_earnings_growth'Img &
         "average_earnings_index = " & rec.average_earnings_index'Img &
         "average_hourly_earnings_index = " & rec.average_hourly_earnings_index'Img &
         "productivity_per_hour_index = " & rec.productivity_per_hour_index'Img &
         "productivity_per_worker_index = " & rec.productivity_per_worker_index'Img &
         "real_product_wage = " & rec.real_product_wage'Img &
         "real_consumption_wage = " & rec.real_consumption_wage'Img &
         "rpi = " & rec.rpi'Img &
         "rpix = " & rec.rpix'Img &
         "cpi = " & rec.cpi'Img &
         "producer_output_prices = " & rec.producer_output_prices'Img &
         "mortgage_interest_payments = " & rec.mortgage_interest_payments'Img &
         "actual_rents_for_housing = " & rec.actual_rents_for_housing'Img &
         "consumer_expenditure_deflator = " & rec.consumer_expenditure_deflator'Img &
         "house_price_index = " & rec.house_price_index'Img &
         "gdp_deflator = " & rec.gdp_deflator'Img &
         "lfs_employment = " & rec.lfs_employment'Img &
         "real_household_disposable_income = " & rec.real_household_disposable_income'Img &
         "real_consumption = " & rec.real_consumption'Img &
         "real_gdp = " & rec.real_gdp'Img &
         "lfs_employment_age_16_plus = " & rec.lfs_employment_age_16_plus'Img &
         "real_household_disposable_income_age_16_plus = " & rec.real_household_disposable_income_age_16_plus'Img &
         "real_consumption_age_16_plus = " & rec.real_consumption_age_16_plus'Img &
         "real_gdp_age_16_plus = " & rec.real_gdp_age_16_plus'Img;
   end to_String;


   function To_String( rec : Run ) return String is
   begin
      return  "Run: " &
         "run_id = " & rec.run_id'Img &
         "user_id = " & rec.user_id'Img &
         "description = " & To_String( rec.description ) &
         "macro_source = " & To_String( rec.macro_source ) &
         "household_source = " & To_String( rec.household_source ) &
         "people_source = " & To_String( rec.people_source ) &
         "start_year = " & rec.start_year'Img &
         "end_year = " & rec.end_year'Img;
   end to_String;


   function To_String( rec : Households_Forecasts ) return String is
   begin
      return  "Households_Forecasts: " &
         "year = " & rec.year'Img &
         "rec_type = " & To_String( rec.rec_type ) &
         "variant = " & To_String( rec.variant ) &
         "country = " & To_String( rec.country ) &
         "edition = " & rec.edition'Img &
         "one_adult_male = " & rec.one_adult_male'Img &
         "one_adult_female = " & rec.one_adult_female'Img &
         "two_adults = " & rec.two_adults'Img &
         "one_adult_one_child = " & rec.one_adult_one_child'Img &
         "one_adult_two_plus_children = " & rec.one_adult_two_plus_children'Img &
         "two_plus_adult_one_plus_children = " & rec.two_plus_adult_one_plus_children'Img &
         "three_plus_person_all_adult = " & rec.three_plus_person_all_adult'Img &
         "all_households = " & rec.all_households'Img;
   end to_String;


   function To_String( rec : Forecast_Variant ) return String is
   begin
      return  "Forecast_Variant: " &
         "rec_type = " & To_String( rec.rec_type ) &
         "variant = " & To_String( rec.variant ) &
         "country = " & To_String( rec.country ) &
         "edition = " & rec.edition'Img &
         "source = " & To_String( rec.source ) &
         "description = " & To_String( rec.description ) &
         "url = " & To_String( rec.url ) &
         "filename = " & To_String( rec.filename );
   end to_String;


   function To_String( rec : Country ) return String is
   begin
      return  "Country: " &
         "name = " & To_String( rec.name );
   end to_String;


   function To_String( rec : Forecast_Type ) return String is
   begin
      return  "Forecast_Type: " &
         "name = " & To_String( rec.name ) &
         "description = " & To_String( rec.description );
   end to_String;



        
   -- === CUSTOM PROCS START ===
              
   function To_Array( popn : Population_Forecasts ) return Age_Range_Array is           
      a : Age_Range_Array;           
   begin           
      a( 0 ) := popn.age_0;           
      a( 1 ) := popn.age_1;           
      a( 2 ) := popn.age_2;           
      a( 3 ) := popn.age_3;           
      a( 4 ) := popn.age_4;           
      a( 5 ) := popn.age_5;           
      a( 6 ) := popn.age_6;           
      a( 7 ) := popn.age_7;           
      a( 8 ) := popn.age_8;           
      a( 9 ) := popn.age_9;           
      a( 10 ) := popn.age_10;           
      a( 11 ) := popn.age_11;           
      a( 12 ) := popn.age_12;           
      a( 13 ) := popn.age_13;           
      a( 14 ) := popn.age_14;           
      a( 15 ) := popn.age_15;           
      a( 16 ) := popn.age_16;           
      a( 17 ) := popn.age_17;           
      a( 18 ) := popn.age_18;           
      a( 19 ) := popn.age_19;           
      a( 20 ) := popn.age_20;           
      a( 21 ) := popn.age_21;           
      a( 22 ) := popn.age_22;           
      a( 23 ) := popn.age_23;           
      a( 24 ) := popn.age_24;           
      a( 25 ) := popn.age_25;           
      a( 26 ) := popn.age_26;           
      a( 27 ) := popn.age_27;           
      a( 28 ) := popn.age_28;           
      a( 29 ) := popn.age_29;           
      a( 30 ) := popn.age_30;           
      a( 31 ) := popn.age_31;           
      a( 32 ) := popn.age_32;           
      a( 33 ) := popn.age_33;           
      a( 34 ) := popn.age_34;           
      a( 35 ) := popn.age_35;           
      a( 36 ) := popn.age_36;           
      a( 37 ) := popn.age_37;           
      a( 38 ) := popn.age_38;           
      a( 39 ) := popn.age_39;           
      a( 40 ) := popn.age_40;           
      a( 41 ) := popn.age_41;           
      a( 42 ) := popn.age_42;           
      a( 43 ) := popn.age_43;           
      a( 44 ) := popn.age_44;           
      a( 45 ) := popn.age_45;           
      a( 46 ) := popn.age_46;           
      a( 47 ) := popn.age_47;           
      a( 48 ) := popn.age_48;           
      a( 49 ) := popn.age_49;           
      a( 50 ) := popn.age_50;           
      a( 51 ) := popn.age_51;           
      a( 52 ) := popn.age_52;           
      a( 53 ) := popn.age_53;           
      a( 54 ) := popn.age_54;           
      a( 55 ) := popn.age_55;           
      a( 56 ) := popn.age_56;           
      a( 57 ) := popn.age_57;           
      a( 58 ) := popn.age_58;           
      a( 59 ) := popn.age_59;           
      a( 60 ) := popn.age_60;           
      a( 61 ) := popn.age_61;           
      a( 62 ) := popn.age_62;           
      a( 63 ) := popn.age_63;           
      a( 64 ) := popn.age_64;           
      a( 65 ) := popn.age_65;           
      a( 66 ) := popn.age_66;           
      a( 67 ) := popn.age_67;           
      a( 68 ) := popn.age_68;           
      a( 69 ) := popn.age_69;           
      a( 70 ) := popn.age_70;           
      a( 71 ) := popn.age_71;           
      a( 72 ) := popn.age_72;           
      a( 73 ) := popn.age_73;           
      a( 74 ) := popn.age_74;           
      a( 75 ) := popn.age_75;           
      a( 76 ) := popn.age_76;           
      a( 77 ) := popn.age_77;           
      a( 78 ) := popn.age_78;           
      a( 79 ) := popn.age_79;           
      a( 80 ) := popn.age_80;           
      a( 81 ) := popn.age_81;           
      a( 82 ) := popn.age_82;           
      a( 83 ) := popn.age_83;           
      a( 84 ) := popn.age_84;           
      a( 85 ) := popn.age_85;           
      a( 86 ) := popn.age_86;           
      a( 87 ) := popn.age_87;           
      a( 88 ) := popn.age_88;           
      a( 89 ) := popn.age_89;           
      a( 90 ) := popn.age_90 +          
         popn.age_91 +          
         popn.age_92 +          
         popn.age_93 +          
         popn.age_94 +          
         popn.age_95 +          
         popn.age_96 +          
         popn.age_97 +          
         popn.age_98 +          
         popn.age_99 +          
         popn.age_100+          
         popn.age_102 +          
         popn.age_103 +          
         popn.age_104 +          
         popn.age_105 +          
         popn.age_106 +          
         popn.age_107 +          
         popn.age_108 +          
         popn.age_109 +          
         popn.age_110;           
      return a;           
   end To_Array;           
              
   -- === CUSTOM PROCS END ===

end Ukds.target_data;
