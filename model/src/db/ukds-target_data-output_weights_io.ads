--
-- Created by ada_generator.py on 2017-11-14 11:49:18.948187
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

package Ukds.Target_Data.Output_Weights_IO is
  
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
   function Next_Free_target_year( connection : Database_Connection := null) return Year_Number;

   --
   -- returns true if the primary key parts of a_output_weights match the defaults in Ukds.Target_Data.Null_Output_Weights
   --
   function Is_Null( a_output_weights : Output_Weights ) return Boolean;
   
   --
   -- returns the single a_output_weights matching the primary key fields, or the Ukds.Target_Data.Null_Output_Weights record
   -- if no such record exists
   --
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; year : Year_Number; sernum : Sernum_Value; target_year : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Output_Weights;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( run_id : Integer; user_id : Integer; year : Year_Number; sernum : Sernum_Value; target_year : Year_Number; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Output_Weights matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Output_Weights_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Output_Weights retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Output_Weights_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_output_weights : Ukds.Target_Data.Output_Weights; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Output_Weights
   --
   procedure Delete( a_output_weights : in out Ukds.Target_Data.Output_Weights; connection : Database_Connection := null );
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
   procedure Add_target_year( c : in out d.Criteria; target_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_weight( c : in out d.Criteria; weight : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_target_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_weight_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Output_Weights;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 6, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : target_year              : Parameter_Integer  : Year_Number          :        0 
   --    6 : weight                   : Parameter_Float    : Amount               :      0.0 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 5, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : run_id                   : Parameter_Integer  : Integer              :        0 
   --    2 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : target_year              : Parameter_Integer  : Year_Number          :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Output_Weights_IO;
