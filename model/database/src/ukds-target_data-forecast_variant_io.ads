--
-- Created by ada_generator.py on 2017-09-20 23:36:52.606990
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

package Ukds.Target_Data.Forecast_Variant_IO is
  
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

   
   function Next_Free_edition( connection : Database_Connection := null) return Year_Number;

   --
   -- returns true if the primary key parts of a_forecast_variant match the defaults in Ukds.Target_Data.Null_Forecast_Variant
   --
   function Is_Null( a_forecast_variant : Forecast_Variant ) return Boolean;
   
   --
   -- returns the single a_forecast_variant matching the primary key fields, or the Ukds.Target_Data.Null_Forecast_Variant record
   -- if no such record exists
   --
   function Retrieve_By_PK( rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Forecast_Variant matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Forecast_Variant retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Forecast_Variant
   --
   procedure Delete( a_forecast_variant : in out Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null );
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
   function Retrieve_Associated_Ukds_Target_Data_Population_Forecasts( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts_List;
   function Retrieve_Associated_Ukds_Target_Data_Households_Forecasts( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Households_Forecasts_List;

   --
   -- functions to add something to a criteria
   --
   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_variant( c : in out d.Criteria; variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_variant( c : in out d.Criteria; variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_source( c : in out d.Criteria; source : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_source( c : in out d.Criteria; source : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_description( c : in out d.Criteria; description : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_description( c : in out d.Criteria; description : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_url( c : in out d.Criteria; url : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_url( c : in out d.Criteria; url : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_filename( c : in out d.Criteria; filename : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_filename( c : in out d.Criteria; filename : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_source_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_description_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_url_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_filename_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Forecast_Variant;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 8, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    2 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    5 : source                   : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    6 : description              : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    7 : url                      : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    8 : filename                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
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
   --    1 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    2 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : edition                  : Parameter_Integer  : Year_Number          :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Forecast_Variant_IO;
