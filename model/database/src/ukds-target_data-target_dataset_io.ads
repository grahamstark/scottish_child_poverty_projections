--
-- Created by ada_generator.py on 2017-09-21 13:28:53.033568
-- 
with Ukds;
with DB_Commons;
with Base_Types;
with ADA.Calendar;
with Ada.Strings.Unbounded;

with GNATCOLL.SQL.Exec;

with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;
with SCP_Types;
with Weighting_Commons;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds.Target_Data.Target_Dataset_IO is
  
   package d renames DB_Commons;   
   use Base_Types;
   use Ada.Strings.Unbounded;
   use Ada.Calendar;
   
   SCHEMA_NAME : constant String := "target_data";
   
   use GNATCOLL.SQL.Exec;
   
   use Ukds;
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;
   use SCP_Types;
   use Weighting_Commons;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_run_id( connection : Database_Connection := null) return Integer;
   function Next_Free_user_id( connection : Database_Connection := null) return Integer;
   function Next_Free_year( connection : Database_Connection := null) return Integer;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;

   --
   -- returns true if the primary key parts of a_target_dataset match the defaults in Ukds.Target_Data.Null_Target_Dataset
   --
   function Is_Null( a_target_dataset : Target_Dataset ) return Boolean;
   
   --
   -- returns the single a_target_dataset matching the primary key fields, or the Ukds.Target_Data.Null_Target_Dataset record
   -- if no such record exists
   --
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( run_id : Integer; user_id : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Target_Dataset matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Target_Dataset retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_target_dataset : Ukds.Target_Data.Target_Dataset; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Target_Dataset
   --
   procedure Delete( a_target_dataset : in out Ukds.Target_Data.Target_Dataset; connection : Database_Connection := null );
   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null );
   --
   -- delete all the records identified by the where SQL clause 
   --
   procedure Delete( where_Clause : String; connection : Database_Connection := null );
   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_run_id( c : in out d.Criteria; run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_uk( c : in out d.Criteria; country_uk : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_scotland( c : in out d.Criteria; country_scotland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_england( c : in out d.Criteria; country_england : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_wales( c : in out d.Criteria; country_wales : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_n_ireland( c : in out d.Criteria; country_n_ireland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_one_adult_male( c : in out d.Criteria; household_one_adult_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_one_adult_female( c : in out d.Criteria; household_one_adult_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_two_adults( c : in out d.Criteria; household_two_adults : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_one_adult_one_child( c : in out d.Criteria; household_one_adult_one_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_one_adult_two_plus_children( c : in out d.Criteria; household_one_adult_two_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_two_plus_adult_one_plus_children( c : in out d.Criteria; household_two_plus_adult_one_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_three_plus_person_all_adult( c : in out d.Criteria; household_three_plus_person_all_adult : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_all_households( c : in out d.Criteria; household_all_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_male( c : in out d.Criteria; male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_female( c : in out d.Criteria; female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employed( c : in out d.Criteria; employed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employee( c : in out d.Criteria; employee : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ilo_unemployed( c : in out d.Criteria; ilo_unemployed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jsa_claimant( c : in out d.Criteria; jsa_claimant : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_0_male( c : in out d.Criteria; age_0_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_1_male( c : in out d.Criteria; age_1_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_2_male( c : in out d.Criteria; age_2_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_3_male( c : in out d.Criteria; age_3_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_4_male( c : in out d.Criteria; age_4_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_5_male( c : in out d.Criteria; age_5_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_6_male( c : in out d.Criteria; age_6_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_7_male( c : in out d.Criteria; age_7_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_8_male( c : in out d.Criteria; age_8_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_9_male( c : in out d.Criteria; age_9_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_10_male( c : in out d.Criteria; age_10_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_11_male( c : in out d.Criteria; age_11_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_12_male( c : in out d.Criteria; age_12_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_13_male( c : in out d.Criteria; age_13_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_14_male( c : in out d.Criteria; age_14_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_15_male( c : in out d.Criteria; age_15_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_16_male( c : in out d.Criteria; age_16_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_17_male( c : in out d.Criteria; age_17_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_18_male( c : in out d.Criteria; age_18_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_19_male( c : in out d.Criteria; age_19_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_20_male( c : in out d.Criteria; age_20_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_21_male( c : in out d.Criteria; age_21_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_22_male( c : in out d.Criteria; age_22_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_23_male( c : in out d.Criteria; age_23_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_24_male( c : in out d.Criteria; age_24_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_25_male( c : in out d.Criteria; age_25_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_26_male( c : in out d.Criteria; age_26_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_27_male( c : in out d.Criteria; age_27_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_28_male( c : in out d.Criteria; age_28_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_29_male( c : in out d.Criteria; age_29_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_30_male( c : in out d.Criteria; age_30_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_31_male( c : in out d.Criteria; age_31_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_32_male( c : in out d.Criteria; age_32_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_33_male( c : in out d.Criteria; age_33_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_34_male( c : in out d.Criteria; age_34_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_35_male( c : in out d.Criteria; age_35_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_36_male( c : in out d.Criteria; age_36_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_37_male( c : in out d.Criteria; age_37_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_38_male( c : in out d.Criteria; age_38_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_39_male( c : in out d.Criteria; age_39_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_40_male( c : in out d.Criteria; age_40_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_41_male( c : in out d.Criteria; age_41_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_42_male( c : in out d.Criteria; age_42_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_43_male( c : in out d.Criteria; age_43_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_44_male( c : in out d.Criteria; age_44_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_45_male( c : in out d.Criteria; age_45_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_46_male( c : in out d.Criteria; age_46_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_47_male( c : in out d.Criteria; age_47_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_48_male( c : in out d.Criteria; age_48_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_49_male( c : in out d.Criteria; age_49_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_50_male( c : in out d.Criteria; age_50_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_51_male( c : in out d.Criteria; age_51_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_52_male( c : in out d.Criteria; age_52_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_53_male( c : in out d.Criteria; age_53_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_54_male( c : in out d.Criteria; age_54_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_55_male( c : in out d.Criteria; age_55_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_56_male( c : in out d.Criteria; age_56_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_57_male( c : in out d.Criteria; age_57_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_58_male( c : in out d.Criteria; age_58_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_59_male( c : in out d.Criteria; age_59_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_60_male( c : in out d.Criteria; age_60_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_61_male( c : in out d.Criteria; age_61_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_62_male( c : in out d.Criteria; age_62_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_63_male( c : in out d.Criteria; age_63_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_64_male( c : in out d.Criteria; age_64_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_65_male( c : in out d.Criteria; age_65_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_66_male( c : in out d.Criteria; age_66_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_67_male( c : in out d.Criteria; age_67_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_68_male( c : in out d.Criteria; age_68_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_69_male( c : in out d.Criteria; age_69_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_70_male( c : in out d.Criteria; age_70_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_71_male( c : in out d.Criteria; age_71_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_72_male( c : in out d.Criteria; age_72_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_73_male( c : in out d.Criteria; age_73_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_74_male( c : in out d.Criteria; age_74_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_75_male( c : in out d.Criteria; age_75_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_76_male( c : in out d.Criteria; age_76_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_77_male( c : in out d.Criteria; age_77_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_78_male( c : in out d.Criteria; age_78_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_79_male( c : in out d.Criteria; age_79_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_80_male( c : in out d.Criteria; age_80_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_81_male( c : in out d.Criteria; age_81_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_82_male( c : in out d.Criteria; age_82_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_83_male( c : in out d.Criteria; age_83_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_84_male( c : in out d.Criteria; age_84_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_85_male( c : in out d.Criteria; age_85_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_86_male( c : in out d.Criteria; age_86_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_87_male( c : in out d.Criteria; age_87_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_88_male( c : in out d.Criteria; age_88_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_89_male( c : in out d.Criteria; age_89_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_90_male( c : in out d.Criteria; age_90_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_91_male( c : in out d.Criteria; age_91_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_92_male( c : in out d.Criteria; age_92_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_93_male( c : in out d.Criteria; age_93_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_94_male( c : in out d.Criteria; age_94_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_95_male( c : in out d.Criteria; age_95_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_96_male( c : in out d.Criteria; age_96_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_97_male( c : in out d.Criteria; age_97_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_98_male( c : in out d.Criteria; age_98_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_99_male( c : in out d.Criteria; age_99_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_100_male( c : in out d.Criteria; age_100_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_101_male( c : in out d.Criteria; age_101_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_102_male( c : in out d.Criteria; age_102_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_103_male( c : in out d.Criteria; age_103_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_104_male( c : in out d.Criteria; age_104_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_105_male( c : in out d.Criteria; age_105_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_106_male( c : in out d.Criteria; age_106_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_107_male( c : in out d.Criteria; age_107_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_108_male( c : in out d.Criteria; age_108_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_109_male( c : in out d.Criteria; age_109_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_110_male( c : in out d.Criteria; age_110_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_0_female( c : in out d.Criteria; age_0_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_1_female( c : in out d.Criteria; age_1_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_2_female( c : in out d.Criteria; age_2_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_3_female( c : in out d.Criteria; age_3_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_4_female( c : in out d.Criteria; age_4_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_5_female( c : in out d.Criteria; age_5_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_6_female( c : in out d.Criteria; age_6_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_7_female( c : in out d.Criteria; age_7_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_8_female( c : in out d.Criteria; age_8_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_9_female( c : in out d.Criteria; age_9_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_10_female( c : in out d.Criteria; age_10_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_11_female( c : in out d.Criteria; age_11_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_12_female( c : in out d.Criteria; age_12_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_13_female( c : in out d.Criteria; age_13_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_14_female( c : in out d.Criteria; age_14_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_15_female( c : in out d.Criteria; age_15_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_16_female( c : in out d.Criteria; age_16_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_17_female( c : in out d.Criteria; age_17_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_18_female( c : in out d.Criteria; age_18_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_19_female( c : in out d.Criteria; age_19_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_20_female( c : in out d.Criteria; age_20_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_21_female( c : in out d.Criteria; age_21_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_22_female( c : in out d.Criteria; age_22_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_23_female( c : in out d.Criteria; age_23_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_24_female( c : in out d.Criteria; age_24_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_25_female( c : in out d.Criteria; age_25_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_26_female( c : in out d.Criteria; age_26_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_27_female( c : in out d.Criteria; age_27_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_28_female( c : in out d.Criteria; age_28_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_29_female( c : in out d.Criteria; age_29_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_30_female( c : in out d.Criteria; age_30_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_31_female( c : in out d.Criteria; age_31_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_32_female( c : in out d.Criteria; age_32_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_33_female( c : in out d.Criteria; age_33_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_34_female( c : in out d.Criteria; age_34_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_35_female( c : in out d.Criteria; age_35_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_36_female( c : in out d.Criteria; age_36_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_37_female( c : in out d.Criteria; age_37_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_38_female( c : in out d.Criteria; age_38_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_39_female( c : in out d.Criteria; age_39_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_40_female( c : in out d.Criteria; age_40_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_41_female( c : in out d.Criteria; age_41_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_42_female( c : in out d.Criteria; age_42_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_43_female( c : in out d.Criteria; age_43_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_44_female( c : in out d.Criteria; age_44_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_45_female( c : in out d.Criteria; age_45_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_46_female( c : in out d.Criteria; age_46_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_47_female( c : in out d.Criteria; age_47_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_48_female( c : in out d.Criteria; age_48_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_49_female( c : in out d.Criteria; age_49_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_50_female( c : in out d.Criteria; age_50_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_51_female( c : in out d.Criteria; age_51_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_52_female( c : in out d.Criteria; age_52_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_53_female( c : in out d.Criteria; age_53_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_54_female( c : in out d.Criteria; age_54_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_55_female( c : in out d.Criteria; age_55_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_56_female( c : in out d.Criteria; age_56_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_57_female( c : in out d.Criteria; age_57_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_58_female( c : in out d.Criteria; age_58_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_59_female( c : in out d.Criteria; age_59_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_60_female( c : in out d.Criteria; age_60_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_61_female( c : in out d.Criteria; age_61_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_62_female( c : in out d.Criteria; age_62_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_63_female( c : in out d.Criteria; age_63_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_64_female( c : in out d.Criteria; age_64_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_65_female( c : in out d.Criteria; age_65_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_66_female( c : in out d.Criteria; age_66_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_67_female( c : in out d.Criteria; age_67_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_68_female( c : in out d.Criteria; age_68_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_69_female( c : in out d.Criteria; age_69_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_70_female( c : in out d.Criteria; age_70_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_71_female( c : in out d.Criteria; age_71_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_72_female( c : in out d.Criteria; age_72_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_73_female( c : in out d.Criteria; age_73_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_74_female( c : in out d.Criteria; age_74_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_75_female( c : in out d.Criteria; age_75_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_76_female( c : in out d.Criteria; age_76_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_77_female( c : in out d.Criteria; age_77_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_78_female( c : in out d.Criteria; age_78_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_79_female( c : in out d.Criteria; age_79_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_80_female( c : in out d.Criteria; age_80_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_81_female( c : in out d.Criteria; age_81_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_82_female( c : in out d.Criteria; age_82_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_83_female( c : in out d.Criteria; age_83_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_84_female( c : in out d.Criteria; age_84_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_85_female( c : in out d.Criteria; age_85_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_86_female( c : in out d.Criteria; age_86_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_87_female( c : in out d.Criteria; age_87_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_88_female( c : in out d.Criteria; age_88_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_89_female( c : in out d.Criteria; age_89_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_90_female( c : in out d.Criteria; age_90_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_91_female( c : in out d.Criteria; age_91_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_92_female( c : in out d.Criteria; age_92_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_93_female( c : in out d.Criteria; age_93_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_94_female( c : in out d.Criteria; age_94_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_95_female( c : in out d.Criteria; age_95_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_96_female( c : in out d.Criteria; age_96_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_97_female( c : in out d.Criteria; age_97_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_98_female( c : in out d.Criteria; age_98_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_99_female( c : in out d.Criteria; age_99_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_100_female( c : in out d.Criteria; age_100_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_101_female( c : in out d.Criteria; age_101_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_102_female( c : in out d.Criteria; age_102_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_103_female( c : in out d.Criteria; age_103_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_104_female( c : in out d.Criteria; age_104_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_105_female( c : in out d.Criteria; age_105_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_106_female( c : in out d.Criteria; age_106_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_107_female( c : in out d.Criteria; age_107_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_108_female( c : in out d.Criteria; age_108_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_109_female( c : in out d.Criteria; age_109_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_110_female( c : in out d.Criteria; age_110_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_0( c : in out d.Criteria; age_0 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_1( c : in out d.Criteria; age_1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_2( c : in out d.Criteria; age_2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_3( c : in out d.Criteria; age_3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_4( c : in out d.Criteria; age_4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_5( c : in out d.Criteria; age_5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_6( c : in out d.Criteria; age_6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_7( c : in out d.Criteria; age_7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_8( c : in out d.Criteria; age_8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_9( c : in out d.Criteria; age_9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_10( c : in out d.Criteria; age_10 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_11( c : in out d.Criteria; age_11 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_12( c : in out d.Criteria; age_12 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_13( c : in out d.Criteria; age_13 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_14( c : in out d.Criteria; age_14 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_15( c : in out d.Criteria; age_15 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_16( c : in out d.Criteria; age_16 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_17( c : in out d.Criteria; age_17 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_18( c : in out d.Criteria; age_18 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_19( c : in out d.Criteria; age_19 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_20( c : in out d.Criteria; age_20 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_21( c : in out d.Criteria; age_21 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_22( c : in out d.Criteria; age_22 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_23( c : in out d.Criteria; age_23 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_24( c : in out d.Criteria; age_24 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_25( c : in out d.Criteria; age_25 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_26( c : in out d.Criteria; age_26 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_27( c : in out d.Criteria; age_27 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_28( c : in out d.Criteria; age_28 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_29( c : in out d.Criteria; age_29 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_30( c : in out d.Criteria; age_30 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_31( c : in out d.Criteria; age_31 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_32( c : in out d.Criteria; age_32 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_33( c : in out d.Criteria; age_33 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_34( c : in out d.Criteria; age_34 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_35( c : in out d.Criteria; age_35 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_36( c : in out d.Criteria; age_36 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_37( c : in out d.Criteria; age_37 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_38( c : in out d.Criteria; age_38 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_39( c : in out d.Criteria; age_39 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_40( c : in out d.Criteria; age_40 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_41( c : in out d.Criteria; age_41 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_42( c : in out d.Criteria; age_42 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_43( c : in out d.Criteria; age_43 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_44( c : in out d.Criteria; age_44 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_45( c : in out d.Criteria; age_45 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_46( c : in out d.Criteria; age_46 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_47( c : in out d.Criteria; age_47 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_48( c : in out d.Criteria; age_48 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_49( c : in out d.Criteria; age_49 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_50( c : in out d.Criteria; age_50 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_51( c : in out d.Criteria; age_51 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_52( c : in out d.Criteria; age_52 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_53( c : in out d.Criteria; age_53 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_54( c : in out d.Criteria; age_54 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_55( c : in out d.Criteria; age_55 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_56( c : in out d.Criteria; age_56 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_57( c : in out d.Criteria; age_57 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_58( c : in out d.Criteria; age_58 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_59( c : in out d.Criteria; age_59 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_60( c : in out d.Criteria; age_60 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_61( c : in out d.Criteria; age_61 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_62( c : in out d.Criteria; age_62 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_63( c : in out d.Criteria; age_63 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_64( c : in out d.Criteria; age_64 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_65( c : in out d.Criteria; age_65 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_66( c : in out d.Criteria; age_66 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_67( c : in out d.Criteria; age_67 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_68( c : in out d.Criteria; age_68 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_69( c : in out d.Criteria; age_69 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_70( c : in out d.Criteria; age_70 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_71( c : in out d.Criteria; age_71 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_72( c : in out d.Criteria; age_72 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_73( c : in out d.Criteria; age_73 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_74( c : in out d.Criteria; age_74 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_75( c : in out d.Criteria; age_75 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_76( c : in out d.Criteria; age_76 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_77( c : in out d.Criteria; age_77 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_78( c : in out d.Criteria; age_78 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_79( c : in out d.Criteria; age_79 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_80( c : in out d.Criteria; age_80 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_81( c : in out d.Criteria; age_81 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_82( c : in out d.Criteria; age_82 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_83( c : in out d.Criteria; age_83 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_84( c : in out d.Criteria; age_84 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_85( c : in out d.Criteria; age_85 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_86( c : in out d.Criteria; age_86 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_87( c : in out d.Criteria; age_87 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_88( c : in out d.Criteria; age_88 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_89( c : in out d.Criteria; age_89 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_90( c : in out d.Criteria; age_90 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_91( c : in out d.Criteria; age_91 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_92( c : in out d.Criteria; age_92 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_93( c : in out d.Criteria; age_93 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_94( c : in out d.Criteria; age_94 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_95( c : in out d.Criteria; age_95 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_96( c : in out d.Criteria; age_96 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_97( c : in out d.Criteria; age_97 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_98( c : in out d.Criteria; age_98 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_99( c : in out d.Criteria; age_99 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_100( c : in out d.Criteria; age_100 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_101( c : in out d.Criteria; age_101 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_102( c : in out d.Criteria; age_102 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_103( c : in out d.Criteria; age_103 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_104( c : in out d.Criteria; age_104 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_105( c : in out d.Criteria; age_105 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_106( c : in out d.Criteria; age_106 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_107( c : in out d.Criteria; age_107 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_108( c : in out d.Criteria; age_108 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_109( c : in out d.Criteria; age_109 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_110( c : in out d.Criteria; age_110 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_uk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_scotland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_england_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_wales_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_n_ireland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_one_adult_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_one_adult_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_two_adults_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_one_adult_one_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_one_adult_two_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_two_plus_adult_one_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_three_plus_person_all_adult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_all_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ilo_unemployed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jsa_claimant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_0_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_1_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_2_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_3_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_4_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_5_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_6_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_7_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_8_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_9_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_10_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_11_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_12_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_13_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_14_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_15_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_16_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_17_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_18_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_19_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_20_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_21_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_22_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_23_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_24_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_25_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_26_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_27_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_28_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_29_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_30_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_31_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_32_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_33_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_34_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_35_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_36_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_37_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_38_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_39_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_40_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_41_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_42_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_43_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_44_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_45_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_46_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_47_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_48_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_49_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_50_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_51_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_52_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_53_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_54_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_55_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_56_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_57_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_58_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_59_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_60_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_61_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_62_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_63_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_64_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_65_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_66_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_67_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_68_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_69_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_70_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_71_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_72_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_73_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_74_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_75_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_76_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_77_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_78_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_79_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_80_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_81_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_82_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_83_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_84_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_85_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_86_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_87_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_88_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_89_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_90_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_91_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_92_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_93_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_94_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_95_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_96_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_97_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_98_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_99_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_100_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_101_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_102_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_103_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_104_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_105_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_106_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_107_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_108_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_109_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_110_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_0_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_1_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_2_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_3_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_4_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_5_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_6_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_7_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_8_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_9_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_10_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_11_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_12_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_13_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_14_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_15_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_16_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_17_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_18_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_19_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_20_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_21_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_22_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_23_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_24_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_25_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_26_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_27_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_28_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_29_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_30_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_31_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_32_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_33_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_34_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_35_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_36_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_37_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_38_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_39_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_40_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_41_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_42_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_43_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_44_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_45_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_46_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_47_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_48_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_49_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_50_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_51_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_52_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_53_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_54_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_55_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_56_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_57_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_58_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_59_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_60_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_61_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_62_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_63_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_64_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_65_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_66_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_67_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_68_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_69_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_70_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_71_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_72_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_73_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_74_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_75_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_76_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_77_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_78_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_79_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_80_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_81_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_82_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_83_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_84_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_85_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_86_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_87_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_88_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_89_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_90_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_91_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_92_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_93_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_94_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_95_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_96_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_97_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_98_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_99_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_100_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_101_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_102_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_103_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_104_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_105_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_106_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_107_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_108_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_109_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_110_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_0_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_26_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_27_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_28_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_38_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_40_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_41_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_42_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_43_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_46_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_47_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_48_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_50_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_51_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_52_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_53_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_55_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_56_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_57_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_58_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_60_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_61_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_62_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_63_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_65_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_66_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_67_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_68_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_70_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_71_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_72_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_73_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_75_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_76_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_77_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_78_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_79_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_81_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_82_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_83_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_84_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_85_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_86_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_87_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_88_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_89_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_90_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_91_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_92_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_93_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_94_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_95_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_96_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_98_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_99_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_100_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_101_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_102_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_103_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_104_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_105_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_106_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_107_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_108_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_109_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_110_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Target_Dataset;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 356, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : country_uk               : Parameter_Float    : Amount               :      0.0 
   --    6 : country_scotland         : Parameter_Float    : Amount               :      0.0 
   --    7 : country_england          : Parameter_Float    : Amount               :      0.0 
   --    8 : country_wales            : Parameter_Float    : Amount               :      0.0 
   --    9 : country_n_ireland        : Parameter_Float    : Amount               :      0.0 
   --   10 : household_one_adult_male : Parameter_Float    : Amount               :      0.0 
   --   11 : household_one_adult_female : Parameter_Float    : Amount               :      0.0 
   --   12 : household_two_adults     : Parameter_Float    : Amount               :      0.0 
   --   13 : household_one_adult_one_child : Parameter_Float    : Amount               :      0.0 
   --   14 : household_one_adult_two_plus_children : Parameter_Float    : Amount               :      0.0 
   --   15 : household_two_plus_adult_one_plus_children : Parameter_Float    : Amount               :      0.0 
   --   16 : household_three_plus_person_all_adult : Parameter_Float    : Amount               :      0.0 
   --   17 : household_all_households : Parameter_Float    : Amount               :      0.0 
   --   18 : male                     : Parameter_Float    : Amount               :      0.0 
   --   19 : female                   : Parameter_Float    : Amount               :      0.0 
   --   20 : employed                 : Parameter_Float    : Amount               :      0.0 
   --   21 : employee                 : Parameter_Float    : Amount               :      0.0 
   --   22 : ilo_unemployed           : Parameter_Float    : Amount               :      0.0 
   --   23 : jsa_claimant             : Parameter_Float    : Amount               :      0.0 
   --   24 : age_0_male               : Parameter_Float    : Amount               :      0.0 
   --   25 : age_1_male               : Parameter_Float    : Amount               :      0.0 
   --   26 : age_2_male               : Parameter_Float    : Amount               :      0.0 
   --   27 : age_3_male               : Parameter_Float    : Amount               :      0.0 
   --   28 : age_4_male               : Parameter_Float    : Amount               :      0.0 
   --   29 : age_5_male               : Parameter_Float    : Amount               :      0.0 
   --   30 : age_6_male               : Parameter_Float    : Amount               :      0.0 
   --   31 : age_7_male               : Parameter_Float    : Amount               :      0.0 
   --   32 : age_8_male               : Parameter_Float    : Amount               :      0.0 
   --   33 : age_9_male               : Parameter_Float    : Amount               :      0.0 
   --   34 : age_10_male              : Parameter_Float    : Amount               :      0.0 
   --   35 : age_11_male              : Parameter_Float    : Amount               :      0.0 
   --   36 : age_12_male              : Parameter_Float    : Amount               :      0.0 
   --   37 : age_13_male              : Parameter_Float    : Amount               :      0.0 
   --   38 : age_14_male              : Parameter_Float    : Amount               :      0.0 
   --   39 : age_15_male              : Parameter_Float    : Amount               :      0.0 
   --   40 : age_16_male              : Parameter_Float    : Amount               :      0.0 
   --   41 : age_17_male              : Parameter_Float    : Amount               :      0.0 
   --   42 : age_18_male              : Parameter_Float    : Amount               :      0.0 
   --   43 : age_19_male              : Parameter_Float    : Amount               :      0.0 
   --   44 : age_20_male              : Parameter_Float    : Amount               :      0.0 
   --   45 : age_21_male              : Parameter_Float    : Amount               :      0.0 
   --   46 : age_22_male              : Parameter_Float    : Amount               :      0.0 
   --   47 : age_23_male              : Parameter_Float    : Amount               :      0.0 
   --   48 : age_24_male              : Parameter_Float    : Amount               :      0.0 
   --   49 : age_25_male              : Parameter_Float    : Amount               :      0.0 
   --   50 : age_26_male              : Parameter_Float    : Amount               :      0.0 
   --   51 : age_27_male              : Parameter_Float    : Amount               :      0.0 
   --   52 : age_28_male              : Parameter_Float    : Amount               :      0.0 
   --   53 : age_29_male              : Parameter_Float    : Amount               :      0.0 
   --   54 : age_30_male              : Parameter_Float    : Amount               :      0.0 
   --   55 : age_31_male              : Parameter_Float    : Amount               :      0.0 
   --   56 : age_32_male              : Parameter_Float    : Amount               :      0.0 
   --   57 : age_33_male              : Parameter_Float    : Amount               :      0.0 
   --   58 : age_34_male              : Parameter_Float    : Amount               :      0.0 
   --   59 : age_35_male              : Parameter_Float    : Amount               :      0.0 
   --   60 : age_36_male              : Parameter_Float    : Amount               :      0.0 
   --   61 : age_37_male              : Parameter_Float    : Amount               :      0.0 
   --   62 : age_38_male              : Parameter_Float    : Amount               :      0.0 
   --   63 : age_39_male              : Parameter_Float    : Amount               :      0.0 
   --   64 : age_40_male              : Parameter_Float    : Amount               :      0.0 
   --   65 : age_41_male              : Parameter_Float    : Amount               :      0.0 
   --   66 : age_42_male              : Parameter_Float    : Amount               :      0.0 
   --   67 : age_43_male              : Parameter_Float    : Amount               :      0.0 
   --   68 : age_44_male              : Parameter_Float    : Amount               :      0.0 
   --   69 : age_45_male              : Parameter_Float    : Amount               :      0.0 
   --   70 : age_46_male              : Parameter_Float    : Amount               :      0.0 
   --   71 : age_47_male              : Parameter_Float    : Amount               :      0.0 
   --   72 : age_48_male              : Parameter_Float    : Amount               :      0.0 
   --   73 : age_49_male              : Parameter_Float    : Amount               :      0.0 
   --   74 : age_50_male              : Parameter_Float    : Amount               :      0.0 
   --   75 : age_51_male              : Parameter_Float    : Amount               :      0.0 
   --   76 : age_52_male              : Parameter_Float    : Amount               :      0.0 
   --   77 : age_53_male              : Parameter_Float    : Amount               :      0.0 
   --   78 : age_54_male              : Parameter_Float    : Amount               :      0.0 
   --   79 : age_55_male              : Parameter_Float    : Amount               :      0.0 
   --   80 : age_56_male              : Parameter_Float    : Amount               :      0.0 
   --   81 : age_57_male              : Parameter_Float    : Amount               :      0.0 
   --   82 : age_58_male              : Parameter_Float    : Amount               :      0.0 
   --   83 : age_59_male              : Parameter_Float    : Amount               :      0.0 
   --   84 : age_60_male              : Parameter_Float    : Amount               :      0.0 
   --   85 : age_61_male              : Parameter_Float    : Amount               :      0.0 
   --   86 : age_62_male              : Parameter_Float    : Amount               :      0.0 
   --   87 : age_63_male              : Parameter_Float    : Amount               :      0.0 
   --   88 : age_64_male              : Parameter_Float    : Amount               :      0.0 
   --   89 : age_65_male              : Parameter_Float    : Amount               :      0.0 
   --   90 : age_66_male              : Parameter_Float    : Amount               :      0.0 
   --   91 : age_67_male              : Parameter_Float    : Amount               :      0.0 
   --   92 : age_68_male              : Parameter_Float    : Amount               :      0.0 
   --   93 : age_69_male              : Parameter_Float    : Amount               :      0.0 
   --   94 : age_70_male              : Parameter_Float    : Amount               :      0.0 
   --   95 : age_71_male              : Parameter_Float    : Amount               :      0.0 
   --   96 : age_72_male              : Parameter_Float    : Amount               :      0.0 
   --   97 : age_73_male              : Parameter_Float    : Amount               :      0.0 
   --   98 : age_74_male              : Parameter_Float    : Amount               :      0.0 
   --   99 : age_75_male              : Parameter_Float    : Amount               :      0.0 
   --  100 : age_76_male              : Parameter_Float    : Amount               :      0.0 
   --  101 : age_77_male              : Parameter_Float    : Amount               :      0.0 
   --  102 : age_78_male              : Parameter_Float    : Amount               :      0.0 
   --  103 : age_79_male              : Parameter_Float    : Amount               :      0.0 
   --  104 : age_80_male              : Parameter_Float    : Amount               :      0.0 
   --  105 : age_81_male              : Parameter_Float    : Amount               :      0.0 
   --  106 : age_82_male              : Parameter_Float    : Amount               :      0.0 
   --  107 : age_83_male              : Parameter_Float    : Amount               :      0.0 
   --  108 : age_84_male              : Parameter_Float    : Amount               :      0.0 
   --  109 : age_85_male              : Parameter_Float    : Amount               :      0.0 
   --  110 : age_86_male              : Parameter_Float    : Amount               :      0.0 
   --  111 : age_87_male              : Parameter_Float    : Amount               :      0.0 
   --  112 : age_88_male              : Parameter_Float    : Amount               :      0.0 
   --  113 : age_89_male              : Parameter_Float    : Amount               :      0.0 
   --  114 : age_90_male              : Parameter_Float    : Amount               :      0.0 
   --  115 : age_91_male              : Parameter_Float    : Amount               :      0.0 
   --  116 : age_92_male              : Parameter_Float    : Amount               :      0.0 
   --  117 : age_93_male              : Parameter_Float    : Amount               :      0.0 
   --  118 : age_94_male              : Parameter_Float    : Amount               :      0.0 
   --  119 : age_95_male              : Parameter_Float    : Amount               :      0.0 
   --  120 : age_96_male              : Parameter_Float    : Amount               :      0.0 
   --  121 : age_97_male              : Parameter_Float    : Amount               :      0.0 
   --  122 : age_98_male              : Parameter_Float    : Amount               :      0.0 
   --  123 : age_99_male              : Parameter_Float    : Amount               :      0.0 
   --  124 : age_100_male             : Parameter_Float    : Amount               :      0.0 
   --  125 : age_101_male             : Parameter_Float    : Amount               :      0.0 
   --  126 : age_102_male             : Parameter_Float    : Amount               :      0.0 
   --  127 : age_103_male             : Parameter_Float    : Amount               :      0.0 
   --  128 : age_104_male             : Parameter_Float    : Amount               :      0.0 
   --  129 : age_105_male             : Parameter_Float    : Amount               :      0.0 
   --  130 : age_106_male             : Parameter_Float    : Amount               :      0.0 
   --  131 : age_107_male             : Parameter_Float    : Amount               :      0.0 
   --  132 : age_108_male             : Parameter_Float    : Amount               :      0.0 
   --  133 : age_109_male             : Parameter_Float    : Amount               :      0.0 
   --  134 : age_110_male             : Parameter_Float    : Amount               :      0.0 
   --  135 : age_0_female             : Parameter_Float    : Amount               :      0.0 
   --  136 : age_1_female             : Parameter_Float    : Amount               :      0.0 
   --  137 : age_2_female             : Parameter_Float    : Amount               :      0.0 
   --  138 : age_3_female             : Parameter_Float    : Amount               :      0.0 
   --  139 : age_4_female             : Parameter_Float    : Amount               :      0.0 
   --  140 : age_5_female             : Parameter_Float    : Amount               :      0.0 
   --  141 : age_6_female             : Parameter_Float    : Amount               :      0.0 
   --  142 : age_7_female             : Parameter_Float    : Amount               :      0.0 
   --  143 : age_8_female             : Parameter_Float    : Amount               :      0.0 
   --  144 : age_9_female             : Parameter_Float    : Amount               :      0.0 
   --  145 : age_10_female            : Parameter_Float    : Amount               :      0.0 
   --  146 : age_11_female            : Parameter_Float    : Amount               :      0.0 
   --  147 : age_12_female            : Parameter_Float    : Amount               :      0.0 
   --  148 : age_13_female            : Parameter_Float    : Amount               :      0.0 
   --  149 : age_14_female            : Parameter_Float    : Amount               :      0.0 
   --  150 : age_15_female            : Parameter_Float    : Amount               :      0.0 
   --  151 : age_16_female            : Parameter_Float    : Amount               :      0.0 
   --  152 : age_17_female            : Parameter_Float    : Amount               :      0.0 
   --  153 : age_18_female            : Parameter_Float    : Amount               :      0.0 
   --  154 : age_19_female            : Parameter_Float    : Amount               :      0.0 
   --  155 : age_20_female            : Parameter_Float    : Amount               :      0.0 
   --  156 : age_21_female            : Parameter_Float    : Amount               :      0.0 
   --  157 : age_22_female            : Parameter_Float    : Amount               :      0.0 
   --  158 : age_23_female            : Parameter_Float    : Amount               :      0.0 
   --  159 : age_24_female            : Parameter_Float    : Amount               :      0.0 
   --  160 : age_25_female            : Parameter_Float    : Amount               :      0.0 
   --  161 : age_26_female            : Parameter_Float    : Amount               :      0.0 
   --  162 : age_27_female            : Parameter_Float    : Amount               :      0.0 
   --  163 : age_28_female            : Parameter_Float    : Amount               :      0.0 
   --  164 : age_29_female            : Parameter_Float    : Amount               :      0.0 
   --  165 : age_30_female            : Parameter_Float    : Amount               :      0.0 
   --  166 : age_31_female            : Parameter_Float    : Amount               :      0.0 
   --  167 : age_32_female            : Parameter_Float    : Amount               :      0.0 
   --  168 : age_33_female            : Parameter_Float    : Amount               :      0.0 
   --  169 : age_34_female            : Parameter_Float    : Amount               :      0.0 
   --  170 : age_35_female            : Parameter_Float    : Amount               :      0.0 
   --  171 : age_36_female            : Parameter_Float    : Amount               :      0.0 
   --  172 : age_37_female            : Parameter_Float    : Amount               :      0.0 
   --  173 : age_38_female            : Parameter_Float    : Amount               :      0.0 
   --  174 : age_39_female            : Parameter_Float    : Amount               :      0.0 
   --  175 : age_40_female            : Parameter_Float    : Amount               :      0.0 
   --  176 : age_41_female            : Parameter_Float    : Amount               :      0.0 
   --  177 : age_42_female            : Parameter_Float    : Amount               :      0.0 
   --  178 : age_43_female            : Parameter_Float    : Amount               :      0.0 
   --  179 : age_44_female            : Parameter_Float    : Amount               :      0.0 
   --  180 : age_45_female            : Parameter_Float    : Amount               :      0.0 
   --  181 : age_46_female            : Parameter_Float    : Amount               :      0.0 
   --  182 : age_47_female            : Parameter_Float    : Amount               :      0.0 
   --  183 : age_48_female            : Parameter_Float    : Amount               :      0.0 
   --  184 : age_49_female            : Parameter_Float    : Amount               :      0.0 
   --  185 : age_50_female            : Parameter_Float    : Amount               :      0.0 
   --  186 : age_51_female            : Parameter_Float    : Amount               :      0.0 
   --  187 : age_52_female            : Parameter_Float    : Amount               :      0.0 
   --  188 : age_53_female            : Parameter_Float    : Amount               :      0.0 
   --  189 : age_54_female            : Parameter_Float    : Amount               :      0.0 
   --  190 : age_55_female            : Parameter_Float    : Amount               :      0.0 
   --  191 : age_56_female            : Parameter_Float    : Amount               :      0.0 
   --  192 : age_57_female            : Parameter_Float    : Amount               :      0.0 
   --  193 : age_58_female            : Parameter_Float    : Amount               :      0.0 
   --  194 : age_59_female            : Parameter_Float    : Amount               :      0.0 
   --  195 : age_60_female            : Parameter_Float    : Amount               :      0.0 
   --  196 : age_61_female            : Parameter_Float    : Amount               :      0.0 
   --  197 : age_62_female            : Parameter_Float    : Amount               :      0.0 
   --  198 : age_63_female            : Parameter_Float    : Amount               :      0.0 
   --  199 : age_64_female            : Parameter_Float    : Amount               :      0.0 
   --  200 : age_65_female            : Parameter_Float    : Amount               :      0.0 
   --  201 : age_66_female            : Parameter_Float    : Amount               :      0.0 
   --  202 : age_67_female            : Parameter_Float    : Amount               :      0.0 
   --  203 : age_68_female            : Parameter_Float    : Amount               :      0.0 
   --  204 : age_69_female            : Parameter_Float    : Amount               :      0.0 
   --  205 : age_70_female            : Parameter_Float    : Amount               :      0.0 
   --  206 : age_71_female            : Parameter_Float    : Amount               :      0.0 
   --  207 : age_72_female            : Parameter_Float    : Amount               :      0.0 
   --  208 : age_73_female            : Parameter_Float    : Amount               :      0.0 
   --  209 : age_74_female            : Parameter_Float    : Amount               :      0.0 
   --  210 : age_75_female            : Parameter_Float    : Amount               :      0.0 
   --  211 : age_76_female            : Parameter_Float    : Amount               :      0.0 
   --  212 : age_77_female            : Parameter_Float    : Amount               :      0.0 
   --  213 : age_78_female            : Parameter_Float    : Amount               :      0.0 
   --  214 : age_79_female            : Parameter_Float    : Amount               :      0.0 
   --  215 : age_80_female            : Parameter_Float    : Amount               :      0.0 
   --  216 : age_81_female            : Parameter_Float    : Amount               :      0.0 
   --  217 : age_82_female            : Parameter_Float    : Amount               :      0.0 
   --  218 : age_83_female            : Parameter_Float    : Amount               :      0.0 
   --  219 : age_84_female            : Parameter_Float    : Amount               :      0.0 
   --  220 : age_85_female            : Parameter_Float    : Amount               :      0.0 
   --  221 : age_86_female            : Parameter_Float    : Amount               :      0.0 
   --  222 : age_87_female            : Parameter_Float    : Amount               :      0.0 
   --  223 : age_88_female            : Parameter_Float    : Amount               :      0.0 
   --  224 : age_89_female            : Parameter_Float    : Amount               :      0.0 
   --  225 : age_90_female            : Parameter_Float    : Amount               :      0.0 
   --  226 : age_91_female            : Parameter_Float    : Amount               :      0.0 
   --  227 : age_92_female            : Parameter_Float    : Amount               :      0.0 
   --  228 : age_93_female            : Parameter_Float    : Amount               :      0.0 
   --  229 : age_94_female            : Parameter_Float    : Amount               :      0.0 
   --  230 : age_95_female            : Parameter_Float    : Amount               :      0.0 
   --  231 : age_96_female            : Parameter_Float    : Amount               :      0.0 
   --  232 : age_97_female            : Parameter_Float    : Amount               :      0.0 
   --  233 : age_98_female            : Parameter_Float    : Amount               :      0.0 
   --  234 : age_99_female            : Parameter_Float    : Amount               :      0.0 
   --  235 : age_100_female           : Parameter_Float    : Amount               :      0.0 
   --  236 : age_101_female           : Parameter_Float    : Amount               :      0.0 
   --  237 : age_102_female           : Parameter_Float    : Amount               :      0.0 
   --  238 : age_103_female           : Parameter_Float    : Amount               :      0.0 
   --  239 : age_104_female           : Parameter_Float    : Amount               :      0.0 
   --  240 : age_105_female           : Parameter_Float    : Amount               :      0.0 
   --  241 : age_106_female           : Parameter_Float    : Amount               :      0.0 
   --  242 : age_107_female           : Parameter_Float    : Amount               :      0.0 
   --  243 : age_108_female           : Parameter_Float    : Amount               :      0.0 
   --  244 : age_109_female           : Parameter_Float    : Amount               :      0.0 
   --  245 : age_110_female           : Parameter_Float    : Amount               :      0.0 
   --  246 : age_0                    : Parameter_Float    : Amount               :      0.0 
   --  247 : age_1                    : Parameter_Float    : Amount               :      0.0 
   --  248 : age_2                    : Parameter_Float    : Amount               :      0.0 
   --  249 : age_3                    : Parameter_Float    : Amount               :      0.0 
   --  250 : age_4                    : Parameter_Float    : Amount               :      0.0 
   --  251 : age_5                    : Parameter_Float    : Amount               :      0.0 
   --  252 : age_6                    : Parameter_Float    : Amount               :      0.0 
   --  253 : age_7                    : Parameter_Float    : Amount               :      0.0 
   --  254 : age_8                    : Parameter_Float    : Amount               :      0.0 
   --  255 : age_9                    : Parameter_Float    : Amount               :      0.0 
   --  256 : age_10                   : Parameter_Float    : Amount               :      0.0 
   --  257 : age_11                   : Parameter_Float    : Amount               :      0.0 
   --  258 : age_12                   : Parameter_Float    : Amount               :      0.0 
   --  259 : age_13                   : Parameter_Float    : Amount               :      0.0 
   --  260 : age_14                   : Parameter_Float    : Amount               :      0.0 
   --  261 : age_15                   : Parameter_Float    : Amount               :      0.0 
   --  262 : age_16                   : Parameter_Float    : Amount               :      0.0 
   --  263 : age_17                   : Parameter_Float    : Amount               :      0.0 
   --  264 : age_18                   : Parameter_Float    : Amount               :      0.0 
   --  265 : age_19                   : Parameter_Float    : Amount               :      0.0 
   --  266 : age_20                   : Parameter_Float    : Amount               :      0.0 
   --  267 : age_21                   : Parameter_Float    : Amount               :      0.0 
   --  268 : age_22                   : Parameter_Float    : Amount               :      0.0 
   --  269 : age_23                   : Parameter_Float    : Amount               :      0.0 
   --  270 : age_24                   : Parameter_Float    : Amount               :      0.0 
   --  271 : age_25                   : Parameter_Float    : Amount               :      0.0 
   --  272 : age_26                   : Parameter_Float    : Amount               :      0.0 
   --  273 : age_27                   : Parameter_Float    : Amount               :      0.0 
   --  274 : age_28                   : Parameter_Float    : Amount               :      0.0 
   --  275 : age_29                   : Parameter_Float    : Amount               :      0.0 
   --  276 : age_30                   : Parameter_Float    : Amount               :      0.0 
   --  277 : age_31                   : Parameter_Float    : Amount               :      0.0 
   --  278 : age_32                   : Parameter_Float    : Amount               :      0.0 
   --  279 : age_33                   : Parameter_Float    : Amount               :      0.0 
   --  280 : age_34                   : Parameter_Float    : Amount               :      0.0 
   --  281 : age_35                   : Parameter_Float    : Amount               :      0.0 
   --  282 : age_36                   : Parameter_Float    : Amount               :      0.0 
   --  283 : age_37                   : Parameter_Float    : Amount               :      0.0 
   --  284 : age_38                   : Parameter_Float    : Amount               :      0.0 
   --  285 : age_39                   : Parameter_Float    : Amount               :      0.0 
   --  286 : age_40                   : Parameter_Float    : Amount               :      0.0 
   --  287 : age_41                   : Parameter_Float    : Amount               :      0.0 
   --  288 : age_42                   : Parameter_Float    : Amount               :      0.0 
   --  289 : age_43                   : Parameter_Float    : Amount               :      0.0 
   --  290 : age_44                   : Parameter_Float    : Amount               :      0.0 
   --  291 : age_45                   : Parameter_Float    : Amount               :      0.0 
   --  292 : age_46                   : Parameter_Float    : Amount               :      0.0 
   --  293 : age_47                   : Parameter_Float    : Amount               :      0.0 
   --  294 : age_48                   : Parameter_Float    : Amount               :      0.0 
   --  295 : age_49                   : Parameter_Float    : Amount               :      0.0 
   --  296 : age_50                   : Parameter_Float    : Amount               :      0.0 
   --  297 : age_51                   : Parameter_Float    : Amount               :      0.0 
   --  298 : age_52                   : Parameter_Float    : Amount               :      0.0 
   --  299 : age_53                   : Parameter_Float    : Amount               :      0.0 
   --  300 : age_54                   : Parameter_Float    : Amount               :      0.0 
   --  301 : age_55                   : Parameter_Float    : Amount               :      0.0 
   --  302 : age_56                   : Parameter_Float    : Amount               :      0.0 
   --  303 : age_57                   : Parameter_Float    : Amount               :      0.0 
   --  304 : age_58                   : Parameter_Float    : Amount               :      0.0 
   --  305 : age_59                   : Parameter_Float    : Amount               :      0.0 
   --  306 : age_60                   : Parameter_Float    : Amount               :      0.0 
   --  307 : age_61                   : Parameter_Float    : Amount               :      0.0 
   --  308 : age_62                   : Parameter_Float    : Amount               :      0.0 
   --  309 : age_63                   : Parameter_Float    : Amount               :      0.0 
   --  310 : age_64                   : Parameter_Float    : Amount               :      0.0 
   --  311 : age_65                   : Parameter_Float    : Amount               :      0.0 
   --  312 : age_66                   : Parameter_Float    : Amount               :      0.0 
   --  313 : age_67                   : Parameter_Float    : Amount               :      0.0 
   --  314 : age_68                   : Parameter_Float    : Amount               :      0.0 
   --  315 : age_69                   : Parameter_Float    : Amount               :      0.0 
   --  316 : age_70                   : Parameter_Float    : Amount               :      0.0 
   --  317 : age_71                   : Parameter_Float    : Amount               :      0.0 
   --  318 : age_72                   : Parameter_Float    : Amount               :      0.0 
   --  319 : age_73                   : Parameter_Float    : Amount               :      0.0 
   --  320 : age_74                   : Parameter_Float    : Amount               :      0.0 
   --  321 : age_75                   : Parameter_Float    : Amount               :      0.0 
   --  322 : age_76                   : Parameter_Float    : Amount               :      0.0 
   --  323 : age_77                   : Parameter_Float    : Amount               :      0.0 
   --  324 : age_78                   : Parameter_Float    : Amount               :      0.0 
   --  325 : age_79                   : Parameter_Float    : Amount               :      0.0 
   --  326 : age_80                   : Parameter_Float    : Amount               :      0.0 
   --  327 : age_81                   : Parameter_Float    : Amount               :      0.0 
   --  328 : age_82                   : Parameter_Float    : Amount               :      0.0 
   --  329 : age_83                   : Parameter_Float    : Amount               :      0.0 
   --  330 : age_84                   : Parameter_Float    : Amount               :      0.0 
   --  331 : age_85                   : Parameter_Float    : Amount               :      0.0 
   --  332 : age_86                   : Parameter_Float    : Amount               :      0.0 
   --  333 : age_87                   : Parameter_Float    : Amount               :      0.0 
   --  334 : age_88                   : Parameter_Float    : Amount               :      0.0 
   --  335 : age_89                   : Parameter_Float    : Amount               :      0.0 
   --  336 : age_90                   : Parameter_Float    : Amount               :      0.0 
   --  337 : age_91                   : Parameter_Float    : Amount               :      0.0 
   --  338 : age_92                   : Parameter_Float    : Amount               :      0.0 
   --  339 : age_93                   : Parameter_Float    : Amount               :      0.0 
   --  340 : age_94                   : Parameter_Float    : Amount               :      0.0 
   --  341 : age_95                   : Parameter_Float    : Amount               :      0.0 
   --  342 : age_96                   : Parameter_Float    : Amount               :      0.0 
   --  343 : age_97                   : Parameter_Float    : Amount               :      0.0 
   --  344 : age_98                   : Parameter_Float    : Amount               :      0.0 
   --  345 : age_99                   : Parameter_Float    : Amount               :      0.0 
   --  346 : age_100                  : Parameter_Float    : Amount               :      0.0 
   --  347 : age_101                  : Parameter_Float    : Amount               :      0.0 
   --  348 : age_102                  : Parameter_Float    : Amount               :      0.0 
   --  349 : age_103                  : Parameter_Float    : Amount               :      0.0 
   --  350 : age_104                  : Parameter_Float    : Amount               :      0.0 
   --  351 : age_105                  : Parameter_Float    : Amount               :      0.0 
   --  352 : age_106                  : Parameter_Float    : Amount               :      0.0 
   --  353 : age_107                  : Parameter_Float    : Amount               :      0.0 
   --  354 : age_108                  : Parameter_Float    : Amount               :      0.0 
   --  355 : age_109                  : Parameter_Float    : Amount               :      0.0 
   --  356 : age_110                  : Parameter_Float    : Amount               :      0.0 
   function Get_Configured_Insert_Params( update_order : Boolean := False ) return GNATCOLL.SQL.Exec.SQL_Parameters;


--
-- a prepared statement of the form insert into xx values ( [ everything, including pk fields ] )
--
   function Get_Prepared_Insert_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;

--
-- a prepared statement of the form update xx set [ everything except pk fields ] where [pk fields ] 
-- 
   function Get_Prepared_Update_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 4, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Target_Dataset_IO;
