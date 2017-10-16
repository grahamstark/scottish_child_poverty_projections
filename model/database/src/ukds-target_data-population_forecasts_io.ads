--
-- Created by ada_generator.py on 2017-10-16 22:11:03.072056
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

package Ukds.Target_Data.Population_Forecasts_IO is
  
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

   
   function Next_Free_year( connection : Database_Connection := null) return Year_Number;
   function Next_Free_edition( connection : Database_Connection := null) return Year_Number;

   --
   -- returns true if the primary key parts of a_population_forecasts match the defaults in Ukds.Target_Data.Null_Population_Forecasts
   --
   function Is_Null( a_population_forecasts : Population_Forecasts ) return Boolean;
   
   --
   -- returns the single a_population_forecasts matching the primary key fields, or the Ukds.Target_Data.Null_Population_Forecasts record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Population_Forecasts matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Population_Forecasts retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_population_forecasts : Ukds.Target_Data.Population_Forecasts; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Population_Forecasts
   --
   procedure Delete( a_population_forecasts : in out Ukds.Target_Data.Population_Forecasts; connection : Database_Connection := null );
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
   procedure Add_year( c : in out d.Criteria; year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_variant( c : in out d.Criteria; variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_variant( c : in out d.Criteria; variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_target_group( c : in out d.Criteria; target_group : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_target_group( c : in out d.Criteria; target_group : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_all_ages( c : in out d.Criteria; all_ages : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
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
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_target_group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_all_ages_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
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

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Population_Forecasts;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 118, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    6 : target_group             : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    7 : all_ages                 : Parameter_Float    : Amount               :      0.0 
   --    8 : age_0                    : Parameter_Float    : Amount               :      0.0 
   --    9 : age_1                    : Parameter_Float    : Amount               :      0.0 
   --   10 : age_2                    : Parameter_Float    : Amount               :      0.0 
   --   11 : age_3                    : Parameter_Float    : Amount               :      0.0 
   --   12 : age_4                    : Parameter_Float    : Amount               :      0.0 
   --   13 : age_5                    : Parameter_Float    : Amount               :      0.0 
   --   14 : age_6                    : Parameter_Float    : Amount               :      0.0 
   --   15 : age_7                    : Parameter_Float    : Amount               :      0.0 
   --   16 : age_8                    : Parameter_Float    : Amount               :      0.0 
   --   17 : age_9                    : Parameter_Float    : Amount               :      0.0 
   --   18 : age_10                   : Parameter_Float    : Amount               :      0.0 
   --   19 : age_11                   : Parameter_Float    : Amount               :      0.0 
   --   20 : age_12                   : Parameter_Float    : Amount               :      0.0 
   --   21 : age_13                   : Parameter_Float    : Amount               :      0.0 
   --   22 : age_14                   : Parameter_Float    : Amount               :      0.0 
   --   23 : age_15                   : Parameter_Float    : Amount               :      0.0 
   --   24 : age_16                   : Parameter_Float    : Amount               :      0.0 
   --   25 : age_17                   : Parameter_Float    : Amount               :      0.0 
   --   26 : age_18                   : Parameter_Float    : Amount               :      0.0 
   --   27 : age_19                   : Parameter_Float    : Amount               :      0.0 
   --   28 : age_20                   : Parameter_Float    : Amount               :      0.0 
   --   29 : age_21                   : Parameter_Float    : Amount               :      0.0 
   --   30 : age_22                   : Parameter_Float    : Amount               :      0.0 
   --   31 : age_23                   : Parameter_Float    : Amount               :      0.0 
   --   32 : age_24                   : Parameter_Float    : Amount               :      0.0 
   --   33 : age_25                   : Parameter_Float    : Amount               :      0.0 
   --   34 : age_26                   : Parameter_Float    : Amount               :      0.0 
   --   35 : age_27                   : Parameter_Float    : Amount               :      0.0 
   --   36 : age_28                   : Parameter_Float    : Amount               :      0.0 
   --   37 : age_29                   : Parameter_Float    : Amount               :      0.0 
   --   38 : age_30                   : Parameter_Float    : Amount               :      0.0 
   --   39 : age_31                   : Parameter_Float    : Amount               :      0.0 
   --   40 : age_32                   : Parameter_Float    : Amount               :      0.0 
   --   41 : age_33                   : Parameter_Float    : Amount               :      0.0 
   --   42 : age_34                   : Parameter_Float    : Amount               :      0.0 
   --   43 : age_35                   : Parameter_Float    : Amount               :      0.0 
   --   44 : age_36                   : Parameter_Float    : Amount               :      0.0 
   --   45 : age_37                   : Parameter_Float    : Amount               :      0.0 
   --   46 : age_38                   : Parameter_Float    : Amount               :      0.0 
   --   47 : age_39                   : Parameter_Float    : Amount               :      0.0 
   --   48 : age_40                   : Parameter_Float    : Amount               :      0.0 
   --   49 : age_41                   : Parameter_Float    : Amount               :      0.0 
   --   50 : age_42                   : Parameter_Float    : Amount               :      0.0 
   --   51 : age_43                   : Parameter_Float    : Amount               :      0.0 
   --   52 : age_44                   : Parameter_Float    : Amount               :      0.0 
   --   53 : age_45                   : Parameter_Float    : Amount               :      0.0 
   --   54 : age_46                   : Parameter_Float    : Amount               :      0.0 
   --   55 : age_47                   : Parameter_Float    : Amount               :      0.0 
   --   56 : age_48                   : Parameter_Float    : Amount               :      0.0 
   --   57 : age_49                   : Parameter_Float    : Amount               :      0.0 
   --   58 : age_50                   : Parameter_Float    : Amount               :      0.0 
   --   59 : age_51                   : Parameter_Float    : Amount               :      0.0 
   --   60 : age_52                   : Parameter_Float    : Amount               :      0.0 
   --   61 : age_53                   : Parameter_Float    : Amount               :      0.0 
   --   62 : age_54                   : Parameter_Float    : Amount               :      0.0 
   --   63 : age_55                   : Parameter_Float    : Amount               :      0.0 
   --   64 : age_56                   : Parameter_Float    : Amount               :      0.0 
   --   65 : age_57                   : Parameter_Float    : Amount               :      0.0 
   --   66 : age_58                   : Parameter_Float    : Amount               :      0.0 
   --   67 : age_59                   : Parameter_Float    : Amount               :      0.0 
   --   68 : age_60                   : Parameter_Float    : Amount               :      0.0 
   --   69 : age_61                   : Parameter_Float    : Amount               :      0.0 
   --   70 : age_62                   : Parameter_Float    : Amount               :      0.0 
   --   71 : age_63                   : Parameter_Float    : Amount               :      0.0 
   --   72 : age_64                   : Parameter_Float    : Amount               :      0.0 
   --   73 : age_65                   : Parameter_Float    : Amount               :      0.0 
   --   74 : age_66                   : Parameter_Float    : Amount               :      0.0 
   --   75 : age_67                   : Parameter_Float    : Amount               :      0.0 
   --   76 : age_68                   : Parameter_Float    : Amount               :      0.0 
   --   77 : age_69                   : Parameter_Float    : Amount               :      0.0 
   --   78 : age_70                   : Parameter_Float    : Amount               :      0.0 
   --   79 : age_71                   : Parameter_Float    : Amount               :      0.0 
   --   80 : age_72                   : Parameter_Float    : Amount               :      0.0 
   --   81 : age_73                   : Parameter_Float    : Amount               :      0.0 
   --   82 : age_74                   : Parameter_Float    : Amount               :      0.0 
   --   83 : age_75                   : Parameter_Float    : Amount               :      0.0 
   --   84 : age_76                   : Parameter_Float    : Amount               :      0.0 
   --   85 : age_77                   : Parameter_Float    : Amount               :      0.0 
   --   86 : age_78                   : Parameter_Float    : Amount               :      0.0 
   --   87 : age_79                   : Parameter_Float    : Amount               :      0.0 
   --   88 : age_80                   : Parameter_Float    : Amount               :      0.0 
   --   89 : age_81                   : Parameter_Float    : Amount               :      0.0 
   --   90 : age_82                   : Parameter_Float    : Amount               :      0.0 
   --   91 : age_83                   : Parameter_Float    : Amount               :      0.0 
   --   92 : age_84                   : Parameter_Float    : Amount               :      0.0 
   --   93 : age_85                   : Parameter_Float    : Amount               :      0.0 
   --   94 : age_86                   : Parameter_Float    : Amount               :      0.0 
   --   95 : age_87                   : Parameter_Float    : Amount               :      0.0 
   --   96 : age_88                   : Parameter_Float    : Amount               :      0.0 
   --   97 : age_89                   : Parameter_Float    : Amount               :      0.0 
   --   98 : age_90                   : Parameter_Float    : Amount               :      0.0 
   --   99 : age_91                   : Parameter_Float    : Amount               :      0.0 
   --  100 : age_92                   : Parameter_Float    : Amount               :      0.0 
   --  101 : age_93                   : Parameter_Float    : Amount               :      0.0 
   --  102 : age_94                   : Parameter_Float    : Amount               :      0.0 
   --  103 : age_95                   : Parameter_Float    : Amount               :      0.0 
   --  104 : age_96                   : Parameter_Float    : Amount               :      0.0 
   --  105 : age_97                   : Parameter_Float    : Amount               :      0.0 
   --  106 : age_98                   : Parameter_Float    : Amount               :      0.0 
   --  107 : age_99                   : Parameter_Float    : Amount               :      0.0 
   --  108 : age_100                  : Parameter_Float    : Amount               :      0.0 
   --  109 : age_101                  : Parameter_Float    : Amount               :      0.0 
   --  110 : age_102                  : Parameter_Float    : Amount               :      0.0 
   --  111 : age_103                  : Parameter_Float    : Amount               :      0.0 
   --  112 : age_104                  : Parameter_Float    : Amount               :      0.0 
   --  113 : age_105                  : Parameter_Float    : Amount               :      0.0 
   --  114 : age_106                  : Parameter_Float    : Amount               :      0.0 
   --  115 : age_107                  : Parameter_Float    : Amount               :      0.0 
   --  116 : age_108                  : Parameter_Float    : Amount               :      0.0 
   --  117 : age_109                  : Parameter_Float    : Amount               :      0.0 
   --  118 : age_110                  : Parameter_Float    : Amount               :      0.0 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 6, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    6 : target_group             : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Population_Forecasts_IO;
