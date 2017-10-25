--
-- Created by ada_generator.py on 2017-10-25 13:04:26.302417
-- 
with Ukds;


with Ada.Containers.Vectors;

with Environment;

with DB_Commons; 

with GNATCOLL.SQL_Impl;
with GNATCOLL.SQL.Postgres;
with DB_Commons.PSQL;


with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with Text_IO;
with Ada.Strings.Maps;
with Connection_Pool;
with GNATColl.Traces;

with Ukds.Target_Data.Forecast_Variant_IO;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Forecast_Type_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.FORECAST_TYPE_IO" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --

   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "name, description " &
         " from target_data.forecast_type " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.forecast_type (" &
         "name, description " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.forecast_type ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.forecast_type set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 2 ) := ( if update_order then (
            1 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : description (Unbounded_String)
            2 => ( Parameter_Text, null, Null_Unbounded_String )   --  : name (Unbounded_String)
      ) else (
            1 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : name (Unbounded_String)
            2 => ( Parameter_Text, null, Null_Unbounded_String )   --  : description (Unbounded_String)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 1 ) := (
            1 => ( Parameter_Text, null, Null_Unbounded_String )   --  : name (Unbounded_String)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where name = $1"; 
   begin 
      return Get_Prepared_Retrieve_Statement( s ); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return gse.Prepared_Statement is 
   begin 
      return Get_Prepared_Retrieve_Statement( d.To_String( crit )); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) & sqlstr; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Retrieve_Statement; 


   function Get_Prepared_Update_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " description = $1 where name = $2"; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Update_Statement; 


   
   
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     


   

   --
   -- returns true if the primary key parts of Ukds.Target_Data.Forecast_Type match the defaults in Ukds.Target_Data.Null_Forecast_Type
   --
   --
   -- Does this Ukds.Target_Data.Forecast_Type equal the default Ukds.Target_Data.Null_Forecast_Type ?
   --
   function Is_Null( a_forecast_type : Forecast_Type ) return Boolean is
   begin
      return a_forecast_type = Ukds.Target_Data.Null_Forecast_Type;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Forecast_Type matching the primary key fields, or the Ukds.Target_Data.Null_Forecast_Type record
   -- if no such record exists
   --
   function Retrieve_By_PK( name : Unbounded_String; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Type is
      l : Ukds.Target_Data.Forecast_Type_List;
      a_forecast_type : Ukds.Target_Data.Forecast_Type;
      c : d.Criteria;
   begin      
      Add_name( c, name );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Forecast_Type_List_Package.is_empty( l ) ) then
         a_forecast_type := Ukds.Target_Data.Forecast_Type_List_Package.First_Element( l );
      else
         a_forecast_type := Ukds.Target_Data.Null_Forecast_Type;
      end if;
      return a_forecast_type;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.forecast_type where name = $1", 
        On_Server => True );
        
   function Exists( name : Unbounded_String; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      aliased_name : aliased String := To_String( name );
      cursor : gse.Forward_Cursor;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      found : Boolean;        
   begin 
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      params( 1 ) := "+"( aliased_name'Access );
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Forecast_Type matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Type_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Forecast_Type retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Forecast_Type is
      a_forecast_type : Ukds.Target_Data.Forecast_Type;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_forecast_type.name:= To_Unbounded_String( gse.Value( cursor, 0 ));
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_forecast_type.description:= To_Unbounded_String( gse.Value( cursor, 1 ));
      end if;
      return a_forecast_type;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Type_List is
      l : Ukds.Target_Data.Forecast_Type_List;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) 
         & " " & sqlstr;
      cursor   : gse.Forward_Cursor;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "retrieve made this as query " & query );
      cursor.Fetch( local_connection, query );
      Check_Result( local_connection );
      while gse.Has_Row( cursor ) loop
         declare
            a_forecast_type : Ukds.Target_Data.Forecast_Type := Map_From_Cursor( cursor );
         begin
            l.append( a_forecast_type ); 
         end;
         gse.Next( cursor );
      end loop;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --

   UPDATE_PS : constant gse.Prepared_Statement := Get_Prepared_Update_Statement;
   
   procedure Update( a_forecast_type : Ukds.Target_Data.Forecast_Type; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_name : aliased String := To_String( a_forecast_type.name );
      aliased_description : aliased String := To_String( a_forecast_type.description );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( aliased_description'Access );
      params( 2 ) := "+"( aliased_name'Access );
      
      gse.Execute( local_connection, UPDATE_PS, params );
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   SAVE_PS : constant gse.Prepared_Statement := Get_Prepared_Insert_Statement;      

   procedure Save( a_forecast_type : Ukds.Target_Data.Forecast_Type; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_name : aliased String := To_String( a_forecast_type.name );
      aliased_description : aliased String := To_String( a_forecast_type.description );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_forecast_type.name ) then
         Update( a_forecast_type, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( aliased_name'Access );
      params( 2 ) := "+"( aliased_description'Access );
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Forecast_Type
   --

   procedure Delete( a_forecast_type : in out Ukds.Target_Data.Forecast_Type; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_name( c, a_forecast_type.name );
      Delete( c, connection );
      a_forecast_type := Ukds.Target_Data.Null_Forecast_Type;
      Log( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null ) is
   begin      
      delete( d.to_string( c ), connection );
      Log( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_clause : String; connection : gse.Database_Connection := null ) is
      local_connection : gse.Database_Connection;     
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( DELETE_PART, SCHEMA_NAME ) & where_clause;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "delete; executing query" & query );
      gse.Execute( local_connection, query );
      Check_Result( local_connection );
      Log( "delete; execute query OK" );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --
   function Retrieve_Associated_Ukds_Target_Data_Forecast_Variants( a_forecast_type : Ukds.Target_Data.Forecast_Type; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Forecast_Variant_IO.Add_Rec_Type( c, a_forecast_type.Name );
      return Ukds.Target_Data.Forecast_Variant_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Forecast_Variants;



   --
   -- functions to add something to a criteria
   --
   procedure Add_name( c : in out d.Criteria; name : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "name", op, join, To_String( name ), 120 );
   begin
      d.add_to_criteria( c, elem );
   end Add_name;


   procedure Add_name( c : in out d.Criteria; name : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "name", op, join, name, 120 );
   begin
      d.add_to_criteria( c, elem );
   end Add_name;


   procedure Add_description( c : in out d.Criteria; description : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "description", op, join, To_String( description ), 120 );
   begin
      d.add_to_criteria( c, elem );
   end Add_description;


   procedure Add_description( c : in out d.Criteria; description : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "description", op, join, description, 120 );
   begin
      d.add_to_criteria( c, elem );
   end Add_description;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_name_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "name", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_name_To_Orderings;


   procedure Add_description_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "description", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_description_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Forecast_Type_IO;
