with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;
with Weighting_Commons;
with Data_Constants;
with Base_Model_Types;
with Text_Utils;


with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Macro_Forecasts_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.Target_Dataset_IO;

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
   use GNATCOLL.SQL.Exec;
   
   package d renames DB_Commons;
   
   function Col_Count( 
      clauses : Selected_Clauses_Array ) return Positive is
         count : Natural := 0;
   begin
      if clauses( household_type ) then
         Inc( count, 7 );
      end if;
      -- household_all_households : Amount := 0.0;
      if clauses( genders ) then
         Inc( count, 2 );
      end if;
      if clauses( employment ) then      
         Inc( count, 1 );
      end if;
      if clauses( employees ) then      
         Inc( count, 1 );
      end if;
      if clauses( ilo_unemployment ) then
         Inc( count, 1 );
      end if;
      if clauses( jsa_claimants ) then
         Inc( count, 1 );
      end if;
      if clauses( by_year_ages_by_gender ) then
         Inc( count( 162 );
      end if;
      if clauses( by_year_ages ) then
         Inc( count, 81 );
      end if;
      if clauses( aggregate_ages ) then
         Inc( count, 17 );
      end if;
      if clauses( aggregate_ages_by_gender ) then
         Inc( count, 34 );
      end if;
      
      return count;
   end Col_Count;
   
   procedure Fill_One_Row( 
      clauses  : Selected_Clauses_Array;
      targets  : Target_Dataset;
      row      : out Amount_Array ) is
         
         p : Positive := 1;
         tmp : Amount;
         
         procedure Add_Col( v : Amount ) is
         begin
            row( p ) := v;
            p := p + 1;
         end Add_Col;
         
    begin
      
      Assert( not (clauses( by_year_ages ) and clauses( by_year_ages_by_gender )), " by_year_ages and by_year_ages_by_gender can't both be on " );
      Assert( not (clauses( aggregate_ages ) and clauses( aggregate_ages_by_gender )), " aggregate_ages and aggregate_ages_by_gender can't both be on " );
       
      row := ( others => 0.0 );
      if clauses( household_type ) then
         Add_Col( targets.household_one_adult_male );
         Add_Col( targets.household_one_adult_female );
         Add_Col( targets.household_two_adults );
         Add_Col( targets.household_one_adult_one_child );
         Add_Col( targets.household_one_adult_two_plus_children );
         Add_Col( targets.household_two_plus_adult_one_plus_children );
         Add_Col( targets.household_three_plus_person_all_adult );
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
      if clauses( by_year_ages ) then
         Add_Col( targets.age_0 );
         Add_Col( targets.age_1 );
         Add_Col( targets.age_2 );
         Add_Col( targets.age_3 );
         Add_Col( targets.age_4 );
         Add_Col( targets.age_5 );
         Add_Col( targets.age_6 );
         Add_Col( targets.age_7 );
         Add_Col( targets.age_8 );
         Add_Col( targets.age_9 );
         Add_Col( targets.age_10 );
         Add_Col( targets.age_11 );
         Add_Col( targets.age_12 );
         Add_Col( targets.age_13 );
         Add_Col( targets.age_14 );
         Add_Col( targets.age_15 );
         Add_Col( targets.age_16 );
         Add_Col( targets.age_17 );
         Add_Col( targets.age_18 );
         Add_Col( targets.age_19 );
         Add_Col( targets.age_20 );
         Add_Col( targets.age_21 );
         Add_Col( targets.age_22 );
         Add_Col( targets.age_23 );
         Add_Col( targets.age_24 );
         Add_Col( targets.age_25 );
         Add_Col( targets.age_26 );
         Add_Col( targets.age_27 );
         Add_Col( targets.age_28 );
         Add_Col( targets.age_29 );
         Add_Col( targets.age_30 );
         Add_Col( targets.age_31 );
         Add_Col( targets.age_32 );
         Add_Col( targets.age_33 );
         Add_Col( targets.age_34 );
         Add_Col( targets.age_35 );
         Add_Col( targets.age_36 );
         Add_Col( targets.age_37 );
         Add_Col( targets.age_38 );
         Add_Col( targets.age_39 );
         Add_Col( targets.age_40 );
         Add_Col( targets.age_41 );
         Add_Col( targets.age_42 );
         Add_Col( targets.age_43 );
         Add_Col( targets.age_44 );
         Add_Col( targets.age_45 );
         Add_Col( targets.age_46 );
         Add_Col( targets.age_47 );
         Add_Col( targets.age_48 );
         Add_Col( targets.age_49 );
         Add_Col( targets.age_50 );
         Add_Col( targets.age_51 );
         Add_Col( targets.age_52 );
         Add_Col( targets.age_53 );
         Add_Col( targets.age_54 );
         Add_Col( targets.age_55 );
         Add_Col( targets.age_56 );
         Add_Col( targets.age_57 );
         Add_Col( targets.age_58 );
         Add_Col( targets.age_59 );
         Add_Col( targets.age_60 );
         Add_Col( targets.age_61 );
         Add_Col( targets.age_62 );
         Add_Col( targets.age_63 );
         Add_Col( targets.age_64 );
         Add_Col( targets.age_65 );
         Add_Col( targets.age_66 );
         Add_Col( targets.age_67 );
         Add_Col( targets.age_68 );
         Add_Col( targets.age_69 );
         Add_Col( targets.age_70 );
         Add_Col( targets.age_71 );
         Add_Col( targets.age_72 );
         Add_Col( targets.age_73 );
         Add_Col( targets.age_74 );
         Add_Col( targets.age_75 );
         Add_Col( targets.age_76 );
         Add_Col( targets.age_77 );
         Add_Col( targets.age_78 );
         Add_Col( targets.age_79 );
         tmp := targets.age_80 + targets.age_81 + targets.age_82 + targets.age_83 + 
            targets.age_84 + targets.age_85 + targets.age_86 + targets.age_87 + 
            targets.age_88 + targets.age_89 + targets.age_90 + targets.age_91 + 
            targets.age_92 + targets.age_93 + targets.age_94 + targets.age_95 + 
            targets.age_96 + targets.age_97 + targets.age_98 + targets.age_99 + 
            targets.age_100 + targets.age_101 + targets.age_102 + targets.age_103 + 
            targets.age_104 + targets.age_105 + targets.age_106 + targets.age_107 + 
            targets.age_108 + targets.age_109 + targets.age_110;
         Add_Col( tmp );
      end if;
      if clauses( aggregate_ages ) then
         tmp := targets.age_0 + targets.age_1 + targets.age_2 + targets.age_3 + targets.age_4;
         Add_Col( tmp );         
         tmp := targets.age_5 + targets.age_6 + targets.age_7 + targets.age_8 + targets.age_9 + targets.age_10;
         Add_Col( tmp );
         tmp := targets.age_11 + targets.age_12 + targets.age_13 + targets.age_14 + targets.age_15;
         Add_Col( tmp );
         tmp := targets.age_16 + targets.age_17 + targets.age_18 + targets.age_19;
         Add_Col( tmp );
         tmp := targets.age_20 + targets.age_21 + targets.age_22 + targets.age_23 + targets.age_24;
         Add_Col( tmp );
         tmp := targets.age_25 + targets.age_26 + targets.age_27 + targets.age_28 + targets.age_29;
         Add_Col( tmp );
         tmp := targets.age_30 + targets.age_31 + targets.age_32 + targets.age_33 + targets.age_34;
         Add_Col( tmp );
         tmp := targets.age_35 + targets.age_36 + targets.age_37 + targets.age_38 + targets.age_39;
         Add_Col( tmp );
         tmp := targets.age_40 + targets.age_41 + targets.age_42 + targets.age_43 + targets.age_44;
         Add_Col( tmp );
         tmp := targets.age_45 + targets.age_46 + targets.age_47 + targets.age_48 + targets.age_49;
         Add_Col( tmp );
         tmp := targets.age_50 + targets.age_51 + targets.age_52 + targets.age_53 + targets.age_54;
         Add_Col( tmp );
         tmp := targets.age_55 + targets.age_56 + targets.age_57 + targets.age_58 + targets.age_59;
         Add_Col( tmp );
         tmp := targets.age_60 + targets.age_61 + targets.age_62 + targets.age_63 + targets.age_64;
         Add_Col( tmp );
         tmp := targets.age_65 + targets.age_66 + targets.age_67 + targets.age_68 + targets.age_69;
         Add_Col( tmp );
         tmp := targets.age_70 + targets.age_71 + targets.age_72 + targets.age_73 + targets.age_74;
         Add_Col( tmp );
         tmp := targets.age_75 + targets.age_76 + targets.age_77 + targets.age_78 + targets.age_79;
         Add_Col( tmp );
         tmp := targets.age_80 + targets.age_81 + targets.age_82 + targets.age_83 + targets.age_84 + targets.age_85 + targets.age_86 + targets.age_87 + targets.age_88 + targets.age_89 + targets.age_90 + targets.age_91 + targets.age_92 + targets.age_93 + targets.age_94 + targets.age_95 + targets.age_96 + targets.age_97 + targets.age_98 + targets.age_99 + targets.age_100 + targets.age_101 + targets.age_102 + targets.age_103 + targets.age_104 + targets.age_105 + targets.age_106 + targets.age_107 + targets.age_108 + targets.age_109 + targets.age_110;
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
         tmp := targets.age_80_male + targets.age_81_male + targets.age_82_male + targets.age_83_male + targets.age_84_male + targets.age_85_male + targets.age_86_male + targets.age_87_male + targets.age_88_male + targets.age_89_male + targets.age_90_male + targets.age_91_male + targets.age_92_male + targets.age_93_male + targets.age_94_male + targets.age_95_male + targets.age_96_male + targets.age_97_male + targets.age_98_male + targets.age_99_male + targets.age_100_male + targets.age_101_male + targets.age_102_male + targets.age_103_male + targets.age_104_male + targets.age_105_male + targets.age_106_male + targets.age_107_male + targets.age_108_male + targets.age_109_male + targets.age_110_male;
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
         tmp := targets.age_80_female + targets.age_81_female + targets.age_82_female + targets.age_83_female + targets.age_84_female + targets.age_85_female + targets.age_86_female + targets.age_87_female + targets.age_88_female + targets.age_89_female + targets.age_90_female + targets.age_91_female + targets.age_92_female + targets.age_93_female + targets.age_94_female + targets.age_95_female + targets.age_96_female + targets.age_97_female + targets.age_98_female + targets.age_99_female + targets.age_100_female + targets.age_101_female + targets.age_102_female + targets.age_103_female + targets.age_104_female + targets.age_105_female + targets.age_106_female + targets.age_107_female + targets.age_108_female + targets.age_109_female + targets.age_110_female;
         Add_Col( tmp );
      end if;
      
      Assert( p = row'Length, " not all rows filled " & p'Img & " vs " & row'Length'Img );
      Assert(( for all r of row => r > 0.0 ), " there is a zero in output row " & To_String( row ));
    end Fill_One_Row;
      
   
   procedure Create_Weights( 
      the_run : Run;
      clauses : Selected_Clauses_Array;
      error   : out Eval_Error_Type ) is
   begin
      null;
   end  Create_Weights; 

   
end Model.SCP.Weights_Creator;