--
-- Created by ada_generator.py on 2017-10-19 12:07:28.511868
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

with Ukds.Target_Data.Target_Dataset_IO;
with Ukds.Target_Data.Output_Weights_IO;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Run_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.RUN_IO" );
   
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
         "run_id, user_id, run_type, description, country, macro_variant, macro_edition, households_variant, households_edition, population_variant," &
         "population_edition, start_year, end_year, weighting_function, weighting_lower_bound, weighting_upper_bound, targets_run_id, targets_run_user_id, data_run_id, data_run_user_id," &
         "selected_clauses " &
         " from target_data.run " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.run (" &
         "run_id, user_id, run_type, description, country, macro_variant, macro_edition, households_variant, households_edition, population_variant," &
         "population_edition, start_year, end_year, weighting_function, weighting_lower_bound, weighting_upper_bound, targets_run_id, targets_run_user_id, data_run_id, data_run_user_id," &
         "selected_clauses " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.run ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.run set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 21 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : run_type (Type_Of_Run)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : description (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : macro_variant (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : macro_edition (Year_Number)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : households_variant (Unbounded_String)
            7 => ( Parameter_Integer, 0 ),   --  : households_edition (Year_Number)
            8 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : population_variant (Unbounded_String)
            9 => ( Parameter_Integer, 0 ),   --  : population_edition (Year_Number)
           10 => ( Parameter_Integer, 0 ),   --  : start_year (Year_Number)
           11 => ( Parameter_Integer, 0 ),   --  : end_year (Year_Number)
           12 => ( Parameter_Integer, 0 ),   --  : weighting_function (Distance_Function_Type)
           13 => ( Parameter_Float, 0.0 ),   --  : weighting_lower_bound (Rate)
           14 => ( Parameter_Float, 0.0 ),   --  : weighting_upper_bound (Rate)
           15 => ( Parameter_Integer, 0 ),   --  : targets_run_id (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : targets_run_user_id (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : data_run_id (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : data_run_user_id (Integer)
           19 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : selected_clauses (Boolean)
           20 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
           21 => ( Parameter_Integer, 0 )   --  : user_id (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : run_type (Type_Of_Run)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : description (Unbounded_String)
            5 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : macro_variant (Unbounded_String)
            7 => ( Parameter_Integer, 0 ),   --  : macro_edition (Year_Number)
            8 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : households_variant (Unbounded_String)
            9 => ( Parameter_Integer, 0 ),   --  : households_edition (Year_Number)
           10 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : population_variant (Unbounded_String)
           11 => ( Parameter_Integer, 0 ),   --  : population_edition (Year_Number)
           12 => ( Parameter_Integer, 0 ),   --  : start_year (Year_Number)
           13 => ( Parameter_Integer, 0 ),   --  : end_year (Year_Number)
           14 => ( Parameter_Integer, 0 ),   --  : weighting_function (Distance_Function_Type)
           15 => ( Parameter_Float, 0.0 ),   --  : weighting_lower_bound (Rate)
           16 => ( Parameter_Float, 0.0 ),   --  : weighting_upper_bound (Rate)
           17 => ( Parameter_Integer, 0 ),   --  : targets_run_id (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : targets_run_user_id (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : data_run_id (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : data_run_user_id (Integer)
           21 => ( Parameter_Text, null, Null_Unbounded_String )   --  : selected_clauses (Boolean)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 2 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : run_id (Integer)
            2 => ( Parameter_Integer, 0 )   --  : user_id (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where run_id = $1 and user_id = $2"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " run_type = $1, description = $2, country = $3, macro_variant = $4, macro_edition = $5, households_variant = $6, households_edition = $7, population_variant = $8, population_edition = $9, start_year = $10, end_year = $11, weighting_function = $12, weighting_lower_bound = $13, weighting_upper_bound = $14, targets_run_id = $15, targets_run_user_id = $16, data_run_id = $17, data_run_user_id = $18, selected_clauses = $19 where run_id = $20 and user_id = $21"; 
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


   
   Next_Free_run_id_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( run_id ) + 1, 1 ) from target_data.run", SCHEMA_NAME );
   Next_Free_run_id_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_run_id_query, On_Server => True );
   -- 
   -- Next highest avaiable value of run_id - useful for saving  
   --
   function Next_Free_run_id( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_run_id_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_run_id;


   Next_Free_user_id_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from target_data.run", SCHEMA_NAME );
   Next_Free_user_id_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_user_id_query, On_Server => True );
   -- 
   -- Next highest avaiable value of user_id - useful for saving  
   --
   function Next_Free_user_id( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_user_id_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_user_id;



   --
   -- returns true if the primary key parts of Ukds.Target_Data.Run match the defaults in Ukds.Target_Data.Null_Run
   --
   --
   -- Does this Ukds.Target_Data.Run equal the default Ukds.Target_Data.Null_Run ?
   --
   function Is_Null( a_run : Run ) return Boolean is
   begin
      return a_run = Ukds.Target_Data.Null_Run;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Run matching the primary key fields, or the Ukds.Target_Data.Null_Run record
   -- if no such record exists
   --
   function Retrieve_By_PK( run_id : Integer; user_id : Integer; connection : Database_Connection := null ) return Ukds.Target_Data.Run is
      l : Ukds.Target_Data.Run_List;
      a_run : Ukds.Target_Data.Run;
      c : d.Criteria;
   begin      
      Add_run_id( c, run_id );
      Add_user_id( c, user_id );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Run_List_Package.is_empty( l ) ) then
         a_run := Ukds.Target_Data.Run_List_Package.First_Element( l );
      else
         a_run := Ukds.Target_Data.Null_Run;
      end if;
      return a_run;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.run where run_id = $1 and user_id = $2", 
        On_Server => True );
        
   function Exists( run_id : Integer; user_id : Integer; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
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
      params( 1 ) := "+"( Integer'Pos( run_id ));
      params( 2 ) := "+"( Integer'Pos( user_id ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Run matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Run_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Run retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Run is
      a_run : Ukds.Target_Data.Run;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_run.run_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_run.user_id := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         declare
            i : constant Integer := gse.Integer_Value( cursor, 2 );
      begin
            a_run.run_type := Type_Of_Run'Val( i );
            end;
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_run.description:= To_Unbounded_String( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_run.country:= To_Unbounded_String( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_run.macro_variant:= To_Unbounded_String( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_run.macro_edition := Year_Number'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_run.households_variant:= To_Unbounded_String( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_run.households_edition := Year_Number'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_run.population_variant:= To_Unbounded_String( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_run.population_edition := Year_Number'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_run.start_year := Year_Number'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_run.end_year := Year_Number'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         declare
            i : constant Integer := gse.Integer_Value( cursor, 13 );
      begin
            a_run.weighting_function := Distance_Function_Type'Val( i );
            end;
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_run.weighting_lower_bound:= Rate'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_run.weighting_upper_bound:= Rate'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_run.targets_run_id := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_run.targets_run_user_id := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_run.data_run_id := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_run.data_run_user_id := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         declare
            s : constant String := gse.Value( cursor, 20 );
         begin
            Selected_Clauses_Array_Package.SQL_Map_To_Array( s, a_run.selected_clauses );
         end;
      end if;
      return a_run;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Run_List is
      l : Ukds.Target_Data.Run_List;
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
            a_run : Ukds.Target_Data.Run := Map_From_Cursor( cursor );
         begin
            l.append( a_run ); 
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
   
   procedure Update( a_run : Ukds.Target_Data.Run; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_description : aliased String := To_String( a_run.description );
      aliased_country : aliased String := To_String( a_run.country );
      aliased_macro_variant : aliased String := To_String( a_run.macro_variant );
      aliased_households_variant : aliased String := To_String( a_run.households_variant );
      aliased_population_variant : aliased String := To_String( a_run.population_variant );
      aliased_selected_clauses : aliased String := Selected_Clauses_Array_Package.Array_To_SQL_String( a_run.selected_clauses );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Type_Of_Run'Pos( a_run.run_type ));
      params( 2 ) := "+"( aliased_description'Access );
      params( 3 ) := "+"( aliased_country'Access );
      params( 4 ) := "+"( aliased_macro_variant'Access );
      params( 5 ) := "+"( Year_Number'Pos( a_run.macro_edition ));
      params( 6 ) := "+"( aliased_households_variant'Access );
      params( 7 ) := "+"( Year_Number'Pos( a_run.households_edition ));
      params( 8 ) := "+"( aliased_population_variant'Access );
      params( 9 ) := "+"( Year_Number'Pos( a_run.population_edition ));
      params( 10 ) := "+"( Year_Number'Pos( a_run.start_year ));
      params( 11 ) := "+"( Year_Number'Pos( a_run.end_year ));
      params( 12 ) := "+"( Distance_Function_Type'Pos( a_run.weighting_function ));
      params( 13 ) := "+"( Float( a_run.weighting_lower_bound ));
      params( 14 ) := "+"( Float( a_run.weighting_upper_bound ));
      params( 15 ) := "+"( Integer'Pos( a_run.targets_run_id ));
      params( 16 ) := "+"( Integer'Pos( a_run.targets_run_user_id ));
      params( 17 ) := "+"( Integer'Pos( a_run.data_run_id ));
      params( 18 ) := "+"( Integer'Pos( a_run.data_run_user_id ));
      params( 19 ) := "+"( aliased_selected_clauses'Access );
      params( 20 ) := "+"( Integer'Pos( a_run.run_id ));
      params( 21 ) := "+"( Integer'Pos( a_run.user_id ));
      
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

   procedure Save( a_run : Ukds.Target_Data.Run; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_description : aliased String := To_String( a_run.description );
      aliased_country : aliased String := To_String( a_run.country );
      aliased_macro_variant : aliased String := To_String( a_run.macro_variant );
      aliased_households_variant : aliased String := To_String( a_run.households_variant );
      aliased_population_variant : aliased String := To_String( a_run.population_variant );
      aliased_selected_clauses : aliased String := Selected_Clauses_Array_Package.Array_To_SQL_String( a_run.selected_clauses );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_run.run_id, a_run.user_id ) then
         Update( a_run, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_run.run_id ));
      params( 2 ) := "+"( Integer'Pos( a_run.user_id ));
      params( 3 ) := "+"( Type_Of_Run'Pos( a_run.run_type ));
      params( 4 ) := "+"( aliased_description'Access );
      params( 5 ) := "+"( aliased_country'Access );
      params( 6 ) := "+"( aliased_macro_variant'Access );
      params( 7 ) := "+"( Year_Number'Pos( a_run.macro_edition ));
      params( 8 ) := "+"( aliased_households_variant'Access );
      params( 9 ) := "+"( Year_Number'Pos( a_run.households_edition ));
      params( 10 ) := "+"( aliased_population_variant'Access );
      params( 11 ) := "+"( Year_Number'Pos( a_run.population_edition ));
      params( 12 ) := "+"( Year_Number'Pos( a_run.start_year ));
      params( 13 ) := "+"( Year_Number'Pos( a_run.end_year ));
      params( 14 ) := "+"( Distance_Function_Type'Pos( a_run.weighting_function ));
      params( 15 ) := "+"( Float( a_run.weighting_lower_bound ));
      params( 16 ) := "+"( Float( a_run.weighting_upper_bound ));
      params( 17 ) := "+"( Integer'Pos( a_run.targets_run_id ));
      params( 18 ) := "+"( Integer'Pos( a_run.targets_run_user_id ));
      params( 19 ) := "+"( Integer'Pos( a_run.data_run_id ));
      params( 20 ) := "+"( Integer'Pos( a_run.data_run_user_id ));
      params( 21 ) := "+"( aliased_selected_clauses'Access );
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Run
   --

   procedure Delete( a_run : in out Ukds.Target_Data.Run; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_run_id( c, a_run.run_id );
      Add_user_id( c, a_run.user_id );
      Delete( c, connection );
      a_run := Ukds.Target_Data.Null_Run;
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
   function Retrieve_Associated_Ukds_Target_Data_Target_Datasets( a_run : Ukds.Target_Data.Run; connection : Database_Connection := null ) return Ukds.Target_Data.Target_Dataset_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Target_Dataset_IO.Add_Run_Id( c, a_run.Run_Id );
      Ukds.Target_Data.Target_Dataset_IO.Add_User_Id( c, a_run.User_Id );
      return Ukds.Target_Data.Target_Dataset_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Target_Datasets;


   function Retrieve_Associated_Ukds_Target_Data_Output_Weights( a_run : Ukds.Target_Data.Run; connection : Database_Connection := null ) return Ukds.Target_Data.Output_Weights_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Output_Weights_IO.Add_Run_Id( c, a_run.Run_Id );
      Ukds.Target_Data.Output_Weights_IO.Add_User_Id( c, a_run.User_Id );
      return Ukds.Target_Data.Output_Weights_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Output_Weights;



   --
   -- functions to add something to a criteria
   --
   procedure Add_run_id( c : in out d.Criteria; run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "run_id", op, join, run_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_run_id;


   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "user_id", op, join, user_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id;


   procedure Add_run_type( c : in out d.Criteria; run_type : Type_Of_Run; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "run_type", op, join, Integer( Type_Of_Run'Pos( run_type )) );
   begin
      d.add_to_criteria( c, elem );
   end Add_run_type;


   procedure Add_description( c : in out d.Criteria; description : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "description", op, join, To_String( description ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_description;


   procedure Add_description( c : in out d.Criteria; description : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "description", op, join, description );
   begin
      d.add_to_criteria( c, elem );
   end Add_description;


   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, To_String( country ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, country, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_macro_variant( c : in out d.Criteria; macro_variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "macro_variant", op, join, To_String( macro_variant ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_macro_variant;


   procedure Add_macro_variant( c : in out d.Criteria; macro_variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "macro_variant", op, join, macro_variant, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_macro_variant;


   procedure Add_macro_edition( c : in out d.Criteria; macro_edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "macro_edition", op, join, Integer( macro_edition ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_macro_edition;


   procedure Add_households_variant( c : in out d.Criteria; households_variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "households_variant", op, join, To_String( households_variant ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_households_variant;


   procedure Add_households_variant( c : in out d.Criteria; households_variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "households_variant", op, join, households_variant, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_households_variant;


   procedure Add_households_edition( c : in out d.Criteria; households_edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "households_edition", op, join, Integer( households_edition ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_households_edition;


   procedure Add_population_variant( c : in out d.Criteria; population_variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "population_variant", op, join, To_String( population_variant ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_population_variant;


   procedure Add_population_variant( c : in out d.Criteria; population_variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "population_variant", op, join, population_variant, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_population_variant;


   procedure Add_population_edition( c : in out d.Criteria; population_edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "population_edition", op, join, Integer( population_edition ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_population_edition;


   procedure Add_start_year( c : in out d.Criteria; start_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "start_year", op, join, Integer( start_year ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_start_year;


   procedure Add_end_year( c : in out d.Criteria; end_year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "end_year", op, join, Integer( end_year ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_end_year;


   procedure Add_weighting_function( c : in out d.Criteria; weighting_function : Distance_Function_Type; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "weighting_function", op, join, Integer( Distance_Function_Type'Pos( weighting_function )) );
   begin
      d.add_to_criteria( c, elem );
   end Add_weighting_function;


   procedure Add_weighting_lower_bound( c : in out d.Criteria; weighting_lower_bound : Rate; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "weighting_lower_bound", op, join, Long_Float( weighting_lower_bound ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_weighting_lower_bound;


   procedure Add_weighting_upper_bound( c : in out d.Criteria; weighting_upper_bound : Rate; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "weighting_upper_bound", op, join, Long_Float( weighting_upper_bound ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_weighting_upper_bound;


   procedure Add_targets_run_id( c : in out d.Criteria; targets_run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "targets_run_id", op, join, targets_run_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_targets_run_id;


   procedure Add_targets_run_user_id( c : in out d.Criteria; targets_run_user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "targets_run_user_id", op, join, targets_run_user_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_targets_run_user_id;


   procedure Add_data_run_id( c : in out d.Criteria; data_run_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "data_run_id", op, join, data_run_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_data_run_id;


   procedure Add_data_run_user_id( c : in out d.Criteria; data_run_user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "data_run_user_id", op, join, data_run_user_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_data_run_user_id;


   procedure Add_selected_clauses( c : in out d.Criteria; selected_clauses : Selected_Clauses_Array; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "selected_clauses", op, join, Selected_Clauses_Array_Package.Array_To_SQL_String( selected_clauses ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_selected_clauses;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "run_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_run_id_To_Orderings;


   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "user_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id_To_Orderings;


   procedure Add_run_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "run_type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_run_type_To_Orderings;


   procedure Add_description_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "description", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_description_To_Orderings;


   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_To_Orderings;


   procedure Add_macro_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "macro_variant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_macro_variant_To_Orderings;


   procedure Add_macro_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "macro_edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_macro_edition_To_Orderings;


   procedure Add_households_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "households_variant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_households_variant_To_Orderings;


   procedure Add_households_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "households_edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_households_edition_To_Orderings;


   procedure Add_population_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "population_variant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_population_variant_To_Orderings;


   procedure Add_population_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "population_edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_population_edition_To_Orderings;


   procedure Add_start_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "start_year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_start_year_To_Orderings;


   procedure Add_end_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "end_year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_end_year_To_Orderings;


   procedure Add_weighting_function_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "weighting_function", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_weighting_function_To_Orderings;


   procedure Add_weighting_lower_bound_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "weighting_lower_bound", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_weighting_lower_bound_To_Orderings;


   procedure Add_weighting_upper_bound_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "weighting_upper_bound", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_weighting_upper_bound_To_Orderings;


   procedure Add_targets_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "targets_run_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_targets_run_id_To_Orderings;


   procedure Add_targets_run_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "targets_run_user_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_targets_run_user_id_To_Orderings;


   procedure Add_data_run_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "data_run_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_data_run_id_To_Orderings;


   procedure Add_data_run_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "data_run_user_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_data_run_user_id_To_Orderings;


   procedure Add_selected_clauses_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "selected_clauses", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_selected_clauses_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Run_IO;
