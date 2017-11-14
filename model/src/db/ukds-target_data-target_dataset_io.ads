--
-- Created by ada_generator.py on 2017-11-14 11:49:19.060388
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
   function Next_Free_year( connection : Database_Connection := null) return Year_Number;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;

   --
   -- returns true if the primary key parts of a_target_dataset match the defaults in Ukds.Target_Data.Null_Target_Dataset
   --
   function Is_Null( a_target_dataset : Target_Dataset ) return Boolean;
   
   --
   -- returns the single a_target_dataset matching the primary key fields, or the Ukds.Target_Data.Null_Target_Dataset record
   -- if no such record exists
   --
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; year : Year_Number; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( run_id : Integer; user_id : Integer; year : Year_Number; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
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
   procedure Add_year( c : in out d.Criteria; year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbai_excluded( c : in out d.Criteria; hbai_excluded : Boolean; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_uk( c : in out d.Criteria; country_uk : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_scotland( c : in out d.Criteria; country_scotland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_england( c : in out d.Criteria; country_england : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_wales( c : in out d.Criteria; country_wales : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country_n_ireland( c : in out d.Criteria; country_n_ireland : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_all_households( c : in out d.Criteria; household_all_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_one_adult_male( c : in out d.Criteria; sco_hhld_one_adult_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_one_adult_female( c : in out d.Criteria; sco_hhld_one_adult_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_two_adults( c : in out d.Criteria; sco_hhld_two_adults : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_one_adult_one_child( c : in out d.Criteria; sco_hhld_one_adult_one_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_one_adult_two_plus_children( c : in out d.Criteria; sco_hhld_one_adult_two_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_two_plus_adult_one_plus_children( c : in out d.Criteria; sco_hhld_two_plus_adult_one_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sco_hhld_three_plus_person_all_adult( c : in out d.Criteria; sco_hhld_three_plus_person_all_adult : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_one_person_households_male( c : in out d.Criteria; eng_hhld_one_person_households_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_one_person_households_female( c : in out d.Criteria; eng_hhld_one_person_households_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_one_family_and_no_others_couple_no_dependent_chi( c : in out d.Criteria; eng_hhld_one_family_and_no_others_couple_no_dependent_chi : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_a_couple_and_other_adults_no_dependent_children( c : in out d.Criteria; eng_hhld_a_couple_and_other_adults_no_dependent_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_households_with_one_dependent_child( c : in out d.Criteria; eng_hhld_households_with_one_dependent_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_households_with_two_dependent_children( c : in out d.Criteria; eng_hhld_households_with_two_dependent_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_households_with_three_dependent_children( c : in out d.Criteria; eng_hhld_households_with_three_dependent_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eng_hhld_other_households( c : in out d.Criteria; eng_hhld_other_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nir_hhld_one_adult_households( c : in out d.Criteria; nir_hhld_one_adult_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nir_hhld_two_adults_without_children( c : in out d.Criteria; nir_hhld_two_adults_without_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nir_hhld_other_households_without_children( c : in out d.Criteria; nir_hhld_other_households_without_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nir_hhld_one_adult_households_with_children( c : in out d.Criteria; nir_hhld_one_adult_households_with_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nir_hhld_other_households_with_children( c : in out d.Criteria; nir_hhld_other_households_with_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_1_person( c : in out d.Criteria; wal_hhld_1_person : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_2_person_no_children( c : in out d.Criteria; wal_hhld_2_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_2_person_1_adult_1_child( c : in out d.Criteria; wal_hhld_2_person_1_adult_1_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_3_person_no_children( c : in out d.Criteria; wal_hhld_3_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_3_person_2_adults_1_child( c : in out d.Criteria; wal_hhld_3_person_2_adults_1_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_3_person_1_adult_2_children( c : in out d.Criteria; wal_hhld_3_person_1_adult_2_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_4_person_no_children( c : in out d.Criteria; wal_hhld_4_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_4_person_2_plus_adults_1_plus_children( c : in out d.Criteria; wal_hhld_4_person_2_plus_adults_1_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_4_person_1_adult_3_children( c : in out d.Criteria; wal_hhld_4_person_1_adult_3_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_5_plus_person_no_children( c : in out d.Criteria; wal_hhld_5_plus_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_5_plus_person_2_plus_adults_1_plus_children( c : in out d.Criteria; wal_hhld_5_plus_person_2_plus_adults_1_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wal_hhld_5_plus_person_1_adult_4_plus_children( c : in out d.Criteria; wal_hhld_5_plus_person_1_adult_4_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_male( c : in out d.Criteria; male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_female( c : in out d.Criteria; female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employed( c : in out d.Criteria; employed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employee( c : in out d.Criteria; employee : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ilo_unemployed( c : in out d.Criteria; ilo_unemployed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jsa_claimant( c : in out d.Criteria; jsa_claimant : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_private_sector_employed( c : in out d.Criteria; private_sector_employed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_public_sector_employed( c : in out d.Criteria; public_sector_employed : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
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
   procedure Add_participation_16_19_male( c : in out d.Criteria; participation_16_19_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_20_24_male( c : in out d.Criteria; participation_20_24_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_25_29_male( c : in out d.Criteria; participation_25_29_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_30_34_male( c : in out d.Criteria; participation_30_34_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_35_39_male( c : in out d.Criteria; participation_35_39_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_40_44_male( c : in out d.Criteria; participation_40_44_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_45_49_male( c : in out d.Criteria; participation_45_49_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_50_54_male( c : in out d.Criteria; participation_50_54_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_55_59_male( c : in out d.Criteria; participation_55_59_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_60_64_male( c : in out d.Criteria; participation_60_64_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_65_69_male( c : in out d.Criteria; participation_65_69_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_70_74_male( c : in out d.Criteria; participation_70_74_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_75_plus_male( c : in out d.Criteria; participation_75_plus_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_16_19_female( c : in out d.Criteria; participation_16_19_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_20_24_female( c : in out d.Criteria; participation_20_24_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_25_29_female( c : in out d.Criteria; participation_25_29_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_30_34_female( c : in out d.Criteria; participation_30_34_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_35_39_female( c : in out d.Criteria; participation_35_39_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_40_44_female( c : in out d.Criteria; participation_40_44_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_45_49_female( c : in out d.Criteria; participation_45_49_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_50_54_female( c : in out d.Criteria; participation_50_54_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_55_59_female( c : in out d.Criteria; participation_55_59_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_60_64_female( c : in out d.Criteria; participation_60_64_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_65_69_female( c : in out d.Criteria; participation_65_69_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_70_74_female( c : in out d.Criteria; participation_70_74_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_75_plus_female( c : in out d.Criteria; participation_75_plus_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_one_adult_hh( c : in out d.Criteria; one_adult_hh : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_two_adult_hh( c : in out d.Criteria; two_adult_hh : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_other_hh( c : in out d.Criteria; other_hh : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbai_excluded_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_uk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_scotland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_england_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_wales_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_n_ireland_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_all_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_one_adult_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_one_adult_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_two_adults_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_one_adult_one_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_one_adult_two_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_two_plus_adult_one_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sco_hhld_three_plus_person_all_adult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_one_person_households_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_one_person_households_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_one_family_and_no_others_couple_no_dependent_chi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_a_couple_and_other_adults_no_dependent_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_households_with_one_dependent_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_households_with_two_dependent_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_households_with_three_dependent_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eng_hhld_other_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nir_hhld_one_adult_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nir_hhld_two_adults_without_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nir_hhld_other_households_without_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nir_hhld_one_adult_households_with_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nir_hhld_other_households_with_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_1_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_2_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_2_person_1_adult_1_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_3_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_3_person_2_adults_1_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_3_person_1_adult_2_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_4_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_4_person_2_plus_adults_1_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_4_person_1_adult_3_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_5_plus_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_5_plus_person_2_plus_adults_1_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wal_hhld_5_plus_person_1_adult_4_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ilo_unemployed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jsa_claimant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_private_sector_employed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_public_sector_employed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
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
   procedure Add_participation_16_19_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_20_24_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_25_29_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_30_34_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_35_39_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_40_44_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_45_49_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_50_54_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_55_59_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_60_64_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_65_69_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_70_74_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_75_plus_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_16_19_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_20_24_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_25_29_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_30_34_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_35_39_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_40_44_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_45_49_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_50_54_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_55_59_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_60_64_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_65_69_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_70_74_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_75_plus_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_one_adult_hh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_two_adult_hh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_other_hh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Target_Dataset;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 302, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : hbai_excluded            : Parameter_Integer  : Boolean              :        0 
   --    6 : country_uk               : Parameter_Float    : Amount               :      0.0 
   --    7 : country_scotland         : Parameter_Float    : Amount               :      0.0 
   --    8 : country_england          : Parameter_Float    : Amount               :      0.0 
   --    9 : country_wales            : Parameter_Float    : Amount               :      0.0 
   --   10 : country_n_ireland        : Parameter_Float    : Amount               :      0.0 
   --   11 : household_all_households : Parameter_Float    : Amount               :      0.0 
   --   12 : sco_hhld_one_adult_male  : Parameter_Float    : Amount               :      0.0 
   --   13 : sco_hhld_one_adult_female : Parameter_Float    : Amount               :      0.0 
   --   14 : sco_hhld_two_adults      : Parameter_Float    : Amount               :      0.0 
   --   15 : sco_hhld_one_adult_one_child : Parameter_Float    : Amount               :      0.0 
   --   16 : sco_hhld_one_adult_two_plus_children : Parameter_Float    : Amount               :      0.0 
   --   17 : sco_hhld_two_plus_adult_one_plus_children : Parameter_Float    : Amount               :      0.0 
   --   18 : sco_hhld_three_plus_person_all_adult : Parameter_Float    : Amount               :      0.0 
   --   19 : eng_hhld_one_person_households_male : Parameter_Float    : Amount               :      0.0 
   --   20 : eng_hhld_one_person_households_female : Parameter_Float    : Amount               :      0.0 
   --   21 : eng_hhld_one_family_and_no_others_couple_no_dependent_chi : Parameter_Float    : Amount               :      0.0 
   --   22 : eng_hhld_a_couple_and_other_adults_no_dependent_children : Parameter_Float    : Amount               :      0.0 
   --   23 : eng_hhld_households_with_one_dependent_child : Parameter_Float    : Amount               :      0.0 
   --   24 : eng_hhld_households_with_two_dependent_children : Parameter_Float    : Amount               :      0.0 
   --   25 : eng_hhld_households_with_three_dependent_children : Parameter_Float    : Amount               :      0.0 
   --   26 : eng_hhld_other_households : Parameter_Float    : Amount               :      0.0 
   --   27 : nir_hhld_one_adult_households : Parameter_Float    : Amount               :      0.0 
   --   28 : nir_hhld_two_adults_without_children : Parameter_Float    : Amount               :      0.0 
   --   29 : nir_hhld_other_households_without_children : Parameter_Float    : Amount               :      0.0 
   --   30 : nir_hhld_one_adult_households_with_children : Parameter_Float    : Amount               :      0.0 
   --   31 : nir_hhld_other_households_with_children : Parameter_Float    : Amount               :      0.0 
   --   32 : wal_hhld_1_person        : Parameter_Float    : Amount               :      0.0 
   --   33 : wal_hhld_2_person_no_children : Parameter_Float    : Amount               :      0.0 
   --   34 : wal_hhld_2_person_1_adult_1_child : Parameter_Float    : Amount               :      0.0 
   --   35 : wal_hhld_3_person_no_children : Parameter_Float    : Amount               :      0.0 
   --   36 : wal_hhld_3_person_2_adults_1_child : Parameter_Float    : Amount               :      0.0 
   --   37 : wal_hhld_3_person_1_adult_2_children : Parameter_Float    : Amount               :      0.0 
   --   38 : wal_hhld_4_person_no_children : Parameter_Float    : Amount               :      0.0 
   --   39 : wal_hhld_4_person_2_plus_adults_1_plus_children : Parameter_Float    : Amount               :      0.0 
   --   40 : wal_hhld_4_person_1_adult_3_children : Parameter_Float    : Amount               :      0.0 
   --   41 : wal_hhld_5_plus_person_no_children : Parameter_Float    : Amount               :      0.0 
   --   42 : wal_hhld_5_plus_person_2_plus_adults_1_plus_children : Parameter_Float    : Amount               :      0.0 
   --   43 : wal_hhld_5_plus_person_1_adult_4_plus_children : Parameter_Float    : Amount               :      0.0 
   --   44 : male                     : Parameter_Float    : Amount               :      0.0 
   --   45 : female                   : Parameter_Float    : Amount               :      0.0 
   --   46 : employed                 : Parameter_Float    : Amount               :      0.0 
   --   47 : employee                 : Parameter_Float    : Amount               :      0.0 
   --   48 : ilo_unemployed           : Parameter_Float    : Amount               :      0.0 
   --   49 : jsa_claimant             : Parameter_Float    : Amount               :      0.0 
   --   50 : private_sector_employed  : Parameter_Float    : Amount               :      0.0 
   --   51 : public_sector_employed   : Parameter_Float    : Amount               :      0.0 
   --   52 : age_0_male               : Parameter_Float    : Amount               :      0.0 
   --   53 : age_1_male               : Parameter_Float    : Amount               :      0.0 
   --   54 : age_2_male               : Parameter_Float    : Amount               :      0.0 
   --   55 : age_3_male               : Parameter_Float    : Amount               :      0.0 
   --   56 : age_4_male               : Parameter_Float    : Amount               :      0.0 
   --   57 : age_5_male               : Parameter_Float    : Amount               :      0.0 
   --   58 : age_6_male               : Parameter_Float    : Amount               :      0.0 
   --   59 : age_7_male               : Parameter_Float    : Amount               :      0.0 
   --   60 : age_8_male               : Parameter_Float    : Amount               :      0.0 
   --   61 : age_9_male               : Parameter_Float    : Amount               :      0.0 
   --   62 : age_10_male              : Parameter_Float    : Amount               :      0.0 
   --   63 : age_11_male              : Parameter_Float    : Amount               :      0.0 
   --   64 : age_12_male              : Parameter_Float    : Amount               :      0.0 
   --   65 : age_13_male              : Parameter_Float    : Amount               :      0.0 
   --   66 : age_14_male              : Parameter_Float    : Amount               :      0.0 
   --   67 : age_15_male              : Parameter_Float    : Amount               :      0.0 
   --   68 : age_16_male              : Parameter_Float    : Amount               :      0.0 
   --   69 : age_17_male              : Parameter_Float    : Amount               :      0.0 
   --   70 : age_18_male              : Parameter_Float    : Amount               :      0.0 
   --   71 : age_19_male              : Parameter_Float    : Amount               :      0.0 
   --   72 : age_20_male              : Parameter_Float    : Amount               :      0.0 
   --   73 : age_21_male              : Parameter_Float    : Amount               :      0.0 
   --   74 : age_22_male              : Parameter_Float    : Amount               :      0.0 
   --   75 : age_23_male              : Parameter_Float    : Amount               :      0.0 
   --   76 : age_24_male              : Parameter_Float    : Amount               :      0.0 
   --   77 : age_25_male              : Parameter_Float    : Amount               :      0.0 
   --   78 : age_26_male              : Parameter_Float    : Amount               :      0.0 
   --   79 : age_27_male              : Parameter_Float    : Amount               :      0.0 
   --   80 : age_28_male              : Parameter_Float    : Amount               :      0.0 
   --   81 : age_29_male              : Parameter_Float    : Amount               :      0.0 
   --   82 : age_30_male              : Parameter_Float    : Amount               :      0.0 
   --   83 : age_31_male              : Parameter_Float    : Amount               :      0.0 
   --   84 : age_32_male              : Parameter_Float    : Amount               :      0.0 
   --   85 : age_33_male              : Parameter_Float    : Amount               :      0.0 
   --   86 : age_34_male              : Parameter_Float    : Amount               :      0.0 
   --   87 : age_35_male              : Parameter_Float    : Amount               :      0.0 
   --   88 : age_36_male              : Parameter_Float    : Amount               :      0.0 
   --   89 : age_37_male              : Parameter_Float    : Amount               :      0.0 
   --   90 : age_38_male              : Parameter_Float    : Amount               :      0.0 
   --   91 : age_39_male              : Parameter_Float    : Amount               :      0.0 
   --   92 : age_40_male              : Parameter_Float    : Amount               :      0.0 
   --   93 : age_41_male              : Parameter_Float    : Amount               :      0.0 
   --   94 : age_42_male              : Parameter_Float    : Amount               :      0.0 
   --   95 : age_43_male              : Parameter_Float    : Amount               :      0.0 
   --   96 : age_44_male              : Parameter_Float    : Amount               :      0.0 
   --   97 : age_45_male              : Parameter_Float    : Amount               :      0.0 
   --   98 : age_46_male              : Parameter_Float    : Amount               :      0.0 
   --   99 : age_47_male              : Parameter_Float    : Amount               :      0.0 
   --  100 : age_48_male              : Parameter_Float    : Amount               :      0.0 
   --  101 : age_49_male              : Parameter_Float    : Amount               :      0.0 
   --  102 : age_50_male              : Parameter_Float    : Amount               :      0.0 
   --  103 : age_51_male              : Parameter_Float    : Amount               :      0.0 
   --  104 : age_52_male              : Parameter_Float    : Amount               :      0.0 
   --  105 : age_53_male              : Parameter_Float    : Amount               :      0.0 
   --  106 : age_54_male              : Parameter_Float    : Amount               :      0.0 
   --  107 : age_55_male              : Parameter_Float    : Amount               :      0.0 
   --  108 : age_56_male              : Parameter_Float    : Amount               :      0.0 
   --  109 : age_57_male              : Parameter_Float    : Amount               :      0.0 
   --  110 : age_58_male              : Parameter_Float    : Amount               :      0.0 
   --  111 : age_59_male              : Parameter_Float    : Amount               :      0.0 
   --  112 : age_60_male              : Parameter_Float    : Amount               :      0.0 
   --  113 : age_61_male              : Parameter_Float    : Amount               :      0.0 
   --  114 : age_62_male              : Parameter_Float    : Amount               :      0.0 
   --  115 : age_63_male              : Parameter_Float    : Amount               :      0.0 
   --  116 : age_64_male              : Parameter_Float    : Amount               :      0.0 
   --  117 : age_65_male              : Parameter_Float    : Amount               :      0.0 
   --  118 : age_66_male              : Parameter_Float    : Amount               :      0.0 
   --  119 : age_67_male              : Parameter_Float    : Amount               :      0.0 
   --  120 : age_68_male              : Parameter_Float    : Amount               :      0.0 
   --  121 : age_69_male              : Parameter_Float    : Amount               :      0.0 
   --  122 : age_70_male              : Parameter_Float    : Amount               :      0.0 
   --  123 : age_71_male              : Parameter_Float    : Amount               :      0.0 
   --  124 : age_72_male              : Parameter_Float    : Amount               :      0.0 
   --  125 : age_73_male              : Parameter_Float    : Amount               :      0.0 
   --  126 : age_74_male              : Parameter_Float    : Amount               :      0.0 
   --  127 : age_75_male              : Parameter_Float    : Amount               :      0.0 
   --  128 : age_76_male              : Parameter_Float    : Amount               :      0.0 
   --  129 : age_77_male              : Parameter_Float    : Amount               :      0.0 
   --  130 : age_78_male              : Parameter_Float    : Amount               :      0.0 
   --  131 : age_79_male              : Parameter_Float    : Amount               :      0.0 
   --  132 : age_80_male              : Parameter_Float    : Amount               :      0.0 
   --  133 : age_81_male              : Parameter_Float    : Amount               :      0.0 
   --  134 : age_82_male              : Parameter_Float    : Amount               :      0.0 
   --  135 : age_83_male              : Parameter_Float    : Amount               :      0.0 
   --  136 : age_84_male              : Parameter_Float    : Amount               :      0.0 
   --  137 : age_85_male              : Parameter_Float    : Amount               :      0.0 
   --  138 : age_86_male              : Parameter_Float    : Amount               :      0.0 
   --  139 : age_87_male              : Parameter_Float    : Amount               :      0.0 
   --  140 : age_88_male              : Parameter_Float    : Amount               :      0.0 
   --  141 : age_89_male              : Parameter_Float    : Amount               :      0.0 
   --  142 : age_90_male              : Parameter_Float    : Amount               :      0.0 
   --  143 : age_91_male              : Parameter_Float    : Amount               :      0.0 
   --  144 : age_92_male              : Parameter_Float    : Amount               :      0.0 
   --  145 : age_93_male              : Parameter_Float    : Amount               :      0.0 
   --  146 : age_94_male              : Parameter_Float    : Amount               :      0.0 
   --  147 : age_95_male              : Parameter_Float    : Amount               :      0.0 
   --  148 : age_96_male              : Parameter_Float    : Amount               :      0.0 
   --  149 : age_97_male              : Parameter_Float    : Amount               :      0.0 
   --  150 : age_98_male              : Parameter_Float    : Amount               :      0.0 
   --  151 : age_99_male              : Parameter_Float    : Amount               :      0.0 
   --  152 : age_100_male             : Parameter_Float    : Amount               :      0.0 
   --  153 : age_101_male             : Parameter_Float    : Amount               :      0.0 
   --  154 : age_102_male             : Parameter_Float    : Amount               :      0.0 
   --  155 : age_103_male             : Parameter_Float    : Amount               :      0.0 
   --  156 : age_104_male             : Parameter_Float    : Amount               :      0.0 
   --  157 : age_105_male             : Parameter_Float    : Amount               :      0.0 
   --  158 : age_106_male             : Parameter_Float    : Amount               :      0.0 
   --  159 : age_107_male             : Parameter_Float    : Amount               :      0.0 
   --  160 : age_108_male             : Parameter_Float    : Amount               :      0.0 
   --  161 : age_109_male             : Parameter_Float    : Amount               :      0.0 
   --  162 : age_110_male             : Parameter_Float    : Amount               :      0.0 
   --  163 : age_0_female             : Parameter_Float    : Amount               :      0.0 
   --  164 : age_1_female             : Parameter_Float    : Amount               :      0.0 
   --  165 : age_2_female             : Parameter_Float    : Amount               :      0.0 
   --  166 : age_3_female             : Parameter_Float    : Amount               :      0.0 
   --  167 : age_4_female             : Parameter_Float    : Amount               :      0.0 
   --  168 : age_5_female             : Parameter_Float    : Amount               :      0.0 
   --  169 : age_6_female             : Parameter_Float    : Amount               :      0.0 
   --  170 : age_7_female             : Parameter_Float    : Amount               :      0.0 
   --  171 : age_8_female             : Parameter_Float    : Amount               :      0.0 
   --  172 : age_9_female             : Parameter_Float    : Amount               :      0.0 
   --  173 : age_10_female            : Parameter_Float    : Amount               :      0.0 
   --  174 : age_11_female            : Parameter_Float    : Amount               :      0.0 
   --  175 : age_12_female            : Parameter_Float    : Amount               :      0.0 
   --  176 : age_13_female            : Parameter_Float    : Amount               :      0.0 
   --  177 : age_14_female            : Parameter_Float    : Amount               :      0.0 
   --  178 : age_15_female            : Parameter_Float    : Amount               :      0.0 
   --  179 : age_16_female            : Parameter_Float    : Amount               :      0.0 
   --  180 : age_17_female            : Parameter_Float    : Amount               :      0.0 
   --  181 : age_18_female            : Parameter_Float    : Amount               :      0.0 
   --  182 : age_19_female            : Parameter_Float    : Amount               :      0.0 
   --  183 : age_20_female            : Parameter_Float    : Amount               :      0.0 
   --  184 : age_21_female            : Parameter_Float    : Amount               :      0.0 
   --  185 : age_22_female            : Parameter_Float    : Amount               :      0.0 
   --  186 : age_23_female            : Parameter_Float    : Amount               :      0.0 
   --  187 : age_24_female            : Parameter_Float    : Amount               :      0.0 
   --  188 : age_25_female            : Parameter_Float    : Amount               :      0.0 
   --  189 : age_26_female            : Parameter_Float    : Amount               :      0.0 
   --  190 : age_27_female            : Parameter_Float    : Amount               :      0.0 
   --  191 : age_28_female            : Parameter_Float    : Amount               :      0.0 
   --  192 : age_29_female            : Parameter_Float    : Amount               :      0.0 
   --  193 : age_30_female            : Parameter_Float    : Amount               :      0.0 
   --  194 : age_31_female            : Parameter_Float    : Amount               :      0.0 
   --  195 : age_32_female            : Parameter_Float    : Amount               :      0.0 
   --  196 : age_33_female            : Parameter_Float    : Amount               :      0.0 
   --  197 : age_34_female            : Parameter_Float    : Amount               :      0.0 
   --  198 : age_35_female            : Parameter_Float    : Amount               :      0.0 
   --  199 : age_36_female            : Parameter_Float    : Amount               :      0.0 
   --  200 : age_37_female            : Parameter_Float    : Amount               :      0.0 
   --  201 : age_38_female            : Parameter_Float    : Amount               :      0.0 
   --  202 : age_39_female            : Parameter_Float    : Amount               :      0.0 
   --  203 : age_40_female            : Parameter_Float    : Amount               :      0.0 
   --  204 : age_41_female            : Parameter_Float    : Amount               :      0.0 
   --  205 : age_42_female            : Parameter_Float    : Amount               :      0.0 
   --  206 : age_43_female            : Parameter_Float    : Amount               :      0.0 
   --  207 : age_44_female            : Parameter_Float    : Amount               :      0.0 
   --  208 : age_45_female            : Parameter_Float    : Amount               :      0.0 
   --  209 : age_46_female            : Parameter_Float    : Amount               :      0.0 
   --  210 : age_47_female            : Parameter_Float    : Amount               :      0.0 
   --  211 : age_48_female            : Parameter_Float    : Amount               :      0.0 
   --  212 : age_49_female            : Parameter_Float    : Amount               :      0.0 
   --  213 : age_50_female            : Parameter_Float    : Amount               :      0.0 
   --  214 : age_51_female            : Parameter_Float    : Amount               :      0.0 
   --  215 : age_52_female            : Parameter_Float    : Amount               :      0.0 
   --  216 : age_53_female            : Parameter_Float    : Amount               :      0.0 
   --  217 : age_54_female            : Parameter_Float    : Amount               :      0.0 
   --  218 : age_55_female            : Parameter_Float    : Amount               :      0.0 
   --  219 : age_56_female            : Parameter_Float    : Amount               :      0.0 
   --  220 : age_57_female            : Parameter_Float    : Amount               :      0.0 
   --  221 : age_58_female            : Parameter_Float    : Amount               :      0.0 
   --  222 : age_59_female            : Parameter_Float    : Amount               :      0.0 
   --  223 : age_60_female            : Parameter_Float    : Amount               :      0.0 
   --  224 : age_61_female            : Parameter_Float    : Amount               :      0.0 
   --  225 : age_62_female            : Parameter_Float    : Amount               :      0.0 
   --  226 : age_63_female            : Parameter_Float    : Amount               :      0.0 
   --  227 : age_64_female            : Parameter_Float    : Amount               :      0.0 
   --  228 : age_65_female            : Parameter_Float    : Amount               :      0.0 
   --  229 : age_66_female            : Parameter_Float    : Amount               :      0.0 
   --  230 : age_67_female            : Parameter_Float    : Amount               :      0.0 
   --  231 : age_68_female            : Parameter_Float    : Amount               :      0.0 
   --  232 : age_69_female            : Parameter_Float    : Amount               :      0.0 
   --  233 : age_70_female            : Parameter_Float    : Amount               :      0.0 
   --  234 : age_71_female            : Parameter_Float    : Amount               :      0.0 
   --  235 : age_72_female            : Parameter_Float    : Amount               :      0.0 
   --  236 : age_73_female            : Parameter_Float    : Amount               :      0.0 
   --  237 : age_74_female            : Parameter_Float    : Amount               :      0.0 
   --  238 : age_75_female            : Parameter_Float    : Amount               :      0.0 
   --  239 : age_76_female            : Parameter_Float    : Amount               :      0.0 
   --  240 : age_77_female            : Parameter_Float    : Amount               :      0.0 
   --  241 : age_78_female            : Parameter_Float    : Amount               :      0.0 
   --  242 : age_79_female            : Parameter_Float    : Amount               :      0.0 
   --  243 : age_80_female            : Parameter_Float    : Amount               :      0.0 
   --  244 : age_81_female            : Parameter_Float    : Amount               :      0.0 
   --  245 : age_82_female            : Parameter_Float    : Amount               :      0.0 
   --  246 : age_83_female            : Parameter_Float    : Amount               :      0.0 
   --  247 : age_84_female            : Parameter_Float    : Amount               :      0.0 
   --  248 : age_85_female            : Parameter_Float    : Amount               :      0.0 
   --  249 : age_86_female            : Parameter_Float    : Amount               :      0.0 
   --  250 : age_87_female            : Parameter_Float    : Amount               :      0.0 
   --  251 : age_88_female            : Parameter_Float    : Amount               :      0.0 
   --  252 : age_89_female            : Parameter_Float    : Amount               :      0.0 
   --  253 : age_90_female            : Parameter_Float    : Amount               :      0.0 
   --  254 : age_91_female            : Parameter_Float    : Amount               :      0.0 
   --  255 : age_92_female            : Parameter_Float    : Amount               :      0.0 
   --  256 : age_93_female            : Parameter_Float    : Amount               :      0.0 
   --  257 : age_94_female            : Parameter_Float    : Amount               :      0.0 
   --  258 : age_95_female            : Parameter_Float    : Amount               :      0.0 
   --  259 : age_96_female            : Parameter_Float    : Amount               :      0.0 
   --  260 : age_97_female            : Parameter_Float    : Amount               :      0.0 
   --  261 : age_98_female            : Parameter_Float    : Amount               :      0.0 
   --  262 : age_99_female            : Parameter_Float    : Amount               :      0.0 
   --  263 : age_100_female           : Parameter_Float    : Amount               :      0.0 
   --  264 : age_101_female           : Parameter_Float    : Amount               :      0.0 
   --  265 : age_102_female           : Parameter_Float    : Amount               :      0.0 
   --  266 : age_103_female           : Parameter_Float    : Amount               :      0.0 
   --  267 : age_104_female           : Parameter_Float    : Amount               :      0.0 
   --  268 : age_105_female           : Parameter_Float    : Amount               :      0.0 
   --  269 : age_106_female           : Parameter_Float    : Amount               :      0.0 
   --  270 : age_107_female           : Parameter_Float    : Amount               :      0.0 
   --  271 : age_108_female           : Parameter_Float    : Amount               :      0.0 
   --  272 : age_109_female           : Parameter_Float    : Amount               :      0.0 
   --  273 : age_110_female           : Parameter_Float    : Amount               :      0.0 
   --  274 : participation_16_19_male : Parameter_Float    : Amount               :      0.0 
   --  275 : participation_20_24_male : Parameter_Float    : Amount               :      0.0 
   --  276 : participation_25_29_male : Parameter_Float    : Amount               :      0.0 
   --  277 : participation_30_34_male : Parameter_Float    : Amount               :      0.0 
   --  278 : participation_35_39_male : Parameter_Float    : Amount               :      0.0 
   --  279 : participation_40_44_male : Parameter_Float    : Amount               :      0.0 
   --  280 : participation_45_49_male : Parameter_Float    : Amount               :      0.0 
   --  281 : participation_50_54_male : Parameter_Float    : Amount               :      0.0 
   --  282 : participation_55_59_male : Parameter_Float    : Amount               :      0.0 
   --  283 : participation_60_64_male : Parameter_Float    : Amount               :      0.0 
   --  284 : participation_65_69_male : Parameter_Float    : Amount               :      0.0 
   --  285 : participation_70_74_male : Parameter_Float    : Amount               :      0.0 
   --  286 : participation_75_plus_male : Parameter_Float    : Amount               :      0.0 
   --  287 : participation_16_19_female : Parameter_Float    : Amount               :      0.0 
   --  288 : participation_20_24_female : Parameter_Float    : Amount               :      0.0 
   --  289 : participation_25_29_female : Parameter_Float    : Amount               :      0.0 
   --  290 : participation_30_34_female : Parameter_Float    : Amount               :      0.0 
   --  291 : participation_35_39_female : Parameter_Float    : Amount               :      0.0 
   --  292 : participation_40_44_female : Parameter_Float    : Amount               :      0.0 
   --  293 : participation_45_49_female : Parameter_Float    : Amount               :      0.0 
   --  294 : participation_50_54_female : Parameter_Float    : Amount               :      0.0 
   --  295 : participation_55_59_female : Parameter_Float    : Amount               :      0.0 
   --  296 : participation_60_64_female : Parameter_Float    : Amount               :      0.0 
   --  297 : participation_65_69_female : Parameter_Float    : Amount               :      0.0 
   --  298 : participation_70_74_female : Parameter_Float    : Amount               :      0.0 
   --  299 : participation_75_plus_female : Parameter_Float    : Amount               :      0.0 
   --  300 : one_adult_hh             : Parameter_Float    : Amount               :      0.0 
   --  301 : two_adult_hh             : Parameter_Float    : Amount               :      0.0 
   --  302 : other_hh                 : Parameter_Float    : Amount               :      0.0 
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
   --    3 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Target_Dataset_IO;
