--
-- Created by ada_generator.py on 2017-09-20 20:28:53.796233
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

-- === CUSTOM IMPORTS START ===
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

   --
   -- functions to add something to a criteria
   --
   procedure Add_run_id( c : in out d.Criteria; run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_description( c : in out d.Criteria; description : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_description( c : in out d.Criteria; description : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_macro_source( c : in out d.Criteria; macro_source : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_macro_source( c : in out d.Criteria; macro_source : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_source( c : in out d.Criteria; household_source : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_household_source( c : in out d.Criteria; household_source : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_people_source( c : in out d.Criteria; people_source : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_people_source( c : in out d.Criteria; people_source : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_start_year( c : in out d.Criteria; start_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_end_year( c : in out d.Criteria; end_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_description_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_macro_source_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_household_source_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_people_source_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_start_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_end_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Run;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 8, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : description              : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : macro_source             : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : household_source         : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    6 : people_source            : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    7 : start_year               : Parameter_Integer  : Year_Number          :        0 
   --    8 : end_year                 : Parameter_Integer  : Year_Number          :        0 
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
