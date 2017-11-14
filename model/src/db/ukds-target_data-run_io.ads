--
-- Created by ada_generator.py on 2017-11-14 11:49:18.935063
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
-- THIS IS AN RSYNC TESTX
-- === CUSTOM IMPORTS END ===

package Ukds.Target_Data.Run_IO is
  
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

   --
   -- returns true if the primary key parts of a_run match the defaults in Ukds.Target_Data.Null_Run
   --
   function Is_Null( a_run : Run ) return Boolean;
   
   --
   -- returns the single a_run matching the primary key fields, or the Ukds.Target_Data.Null_Run record
   -- if no such record exists
   --
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; connection : Database_Connection := null ) return Ukds.Target_Data.Run;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( run_id : Integer; user_id : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Run matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Run_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Run retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Run_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_run : Ukds.Target_Data.Run; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Run
   --
   procedure Delete( a_run : in out Ukds.Target_Data.Run; connection : Database_Connection := null );
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
   function Retrieve_Associated_Ukds_Target_Data_Target_Datasets( a_run : Ukds.Target_Data.Run; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset_List;
   function Retrieve_Associated_Ukds_Target_Data_Output_Weights( a_run : Ukds.Target_Data.Run; connection : Database_Connection := null ) return Ukds.Target_Data.Output_Weights_List;

   --
   -- functions to add something to a criteria
   --
   procedure Add_run_id( c : in out d.Criteria; run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_run_type( c : in out d.Criteria; run_type : Type_Of_Run; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_description( c : in out d.Criteria; description : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_description( c : in out d.Criteria; description : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_macro_variant( c : in out d.Criteria; macro_variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_macro_variant( c : in out d.Criteria; macro_variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_macro_edition( c : in out d.Criteria; macro_edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_households_variant( c : in out d.Criteria; households_variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_households_variant( c : in out d.Criteria; households_variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_households_edition( c : in out d.Criteria; households_edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_population_variant( c : in out d.Criteria; population_variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_population_variant( c : in out d.Criteria; population_variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_population_edition( c : in out d.Criteria; population_edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_start_year( c : in out d.Criteria; start_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_end_year( c : in out d.Criteria; end_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_data_start_year( c : in out d.Criteria; data_start_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_data_end_year( c : in out d.Criteria; data_end_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_weighting_function( c : in out d.Criteria; weighting_function : Distance_Function_Type; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_weighting_lower_bound( c : in out d.Criteria; weighting_lower_bound : Rate; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_weighting_upper_bound( c : in out d.Criteria; weighting_upper_bound : Rate; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_targets_run_id( c : in out d.Criteria; targets_run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_targets_run_user_id( c : in out d.Criteria; targets_run_user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_data_run_id( c : in out d.Criteria; data_run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_data_run_user_id( c : in out d.Criteria; data_run_user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uk_wide_only( c : in out d.Criteria; uk_wide_only : Boolean; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_selected_clauses( c : in out d.Criteria; selected_clauses : Selected_Clauses_Array; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_run_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_description_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_macro_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_macro_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_households_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_households_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_population_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_population_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_start_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_end_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_data_start_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_data_end_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_weighting_function_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_weighting_lower_bound_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_weighting_upper_bound_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_targets_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_targets_run_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_data_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_data_run_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uk_wide_only_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_selected_clauses_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Run;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 24, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : run_type                 : Parameter_Integer  : Type_Of_Run          :        0 
   --    4 : description              : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    6 : macro_variant            : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    7 : macro_edition            : Parameter_Integer  : Year_Number          :        0 
   --    8 : households_variant       : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    9 : households_edition       : Parameter_Integer  : Year_Number          :        0 
   --   10 : population_variant       : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --   11 : population_edition       : Parameter_Integer  : Year_Number          :        0 
   --   12 : start_year               : Parameter_Integer  : Year_Number          :        0 
   --   13 : end_year                 : Parameter_Integer  : Year_Number          :        0 
   --   14 : data_start_year          : Parameter_Integer  : Year_Number          :        0 
   --   15 : data_end_year            : Parameter_Integer  : Year_Number          :        0 
   --   16 : weighting_function       : Parameter_Integer  : Distance_Function_Type :        0 
   --   17 : weighting_lower_bound    : Parameter_Float    : Rate                 :      0.0 
   --   18 : weighting_upper_bound    : Parameter_Float    : Rate                 :      0.0 
   --   19 : targets_run_id           : Parameter_Integer  : Integer              :        0 
   --   20 : targets_run_user_id      : Parameter_Integer  : Integer              :        0 
   --   21 : data_run_id              : Parameter_Integer  : Integer              :        0 
   --   22 : data_run_user_id         : Parameter_Integer  : Integer              :        0 
   --   23 : uk_wide_only             : Parameter_Integer  : Boolean              :        0 
   --   24 : selected_clauses         : Parameter_Text     : Boolean              : null, Null_Unbounded_String 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 2, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Run_IO;
