--
-- Created by ada_generator.py on 2017-11-13 10:51:13.240511
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


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Households_Forecasts_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.HOUSEHOLDS_FORECASTS_IO" );
   
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
         "year, rec_type, variant, country, edition, one_adult_male, one_adult_female, two_adults, one_adult_one_child, one_adult_two_plus_children," &
         "two_plus_adult_one_plus_children, three_plus_person_all_adult, all_households " &
         " from target_data.households_forecasts " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.households_forecasts (" &
         "year, rec_type, variant, country, edition, one_adult_male, one_adult_female, two_adults, one_adult_one_child, one_adult_two_plus_children," &
         "two_plus_adult_one_plus_children, three_plus_person_all_adult, all_households " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.households_forecasts ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.households_forecasts set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 13 ) := ( if update_order then (
            1 => ( Parameter_Float, 0.0 ),   --  : one_adult_male (Amount)
            2 => ( Parameter_Float, 0.0 ),   --  : one_adult_female (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : two_adults (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : one_adult_one_child (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : one_adult_two_plus_children (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : two_plus_adult_one_plus_children (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : three_plus_person_all_adult (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : all_households (Amount)
            9 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           10 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
           11 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
           12 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
           13 => ( Parameter_Integer, 0 )   --  : edition (Year_Number)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            6 => ( Parameter_Float, 0.0 ),   --  : one_adult_male (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : one_adult_female (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : two_adults (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : one_adult_one_child (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : one_adult_two_plus_children (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : two_plus_adult_one_plus_children (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : three_plus_person_all_adult (Amount)
           13 => ( Parameter_Float, 0.0 )   --  : all_households (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 5 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 )   --  : edition (Year_Number)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " one_adult_male = $1, one_adult_female = $2, two_adults = $3, one_adult_one_child = $4, one_adult_two_plus_children = $5, two_plus_adult_one_plus_children = $6, three_plus_person_all_adult = $7, all_households = $8 where year = $9 and rec_type = $10 and variant = $11 and country = $12 and edition = $13"; 
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


   
   Next_Free_year_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from target_data.households_forecasts", SCHEMA_NAME );
   Next_Free_year_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_year_query, On_Server => True );
   -- 
   -- Next highest avaiable value of year - useful for saving  
   --
   function Next_Free_year( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_year;


   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from target_data.households_forecasts", SCHEMA_NAME );
   Next_Free_edition_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_edition_query, On_Server => True );
   -- 
   -- Next highest avaiable value of edition - useful for saving  
   --
   function Next_Free_edition( connection : Database_Connection := null) return Year_Number is
      cursor              : gse.Forward_Cursor;
      ai                  : Year_Number;
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
      
      cursor.Fetch( local_connection, Next_Free_edition_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Year_Number'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_edition;



   --
   -- returns true if the primary key parts of Ukds.Target_Data.Households_Forecasts match the defaults in Ukds.Target_Data.Null_Households_Forecasts
   --
   --
   -- Does this Ukds.Target_Data.Households_Forecasts equal the default Ukds.Target_Data.Null_Households_Forecasts ?
   --
   function Is_Null( a_households_forecasts : Households_Forecasts ) return Boolean is
   begin
      return a_households_forecasts = Ukds.Target_Data.Null_Households_Forecasts;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Households_Forecasts matching the primary key fields, or the Ukds.Target_Data.Null_Households_Forecasts record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Integer; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Households_Forecasts is
      l : Ukds.Target_Data.Households_Forecasts_List;
      a_households_forecasts : Ukds.Target_Data.Households_Forecasts;
      c : d.Criteria;
   begin      
      Add_year( c, year );
      Add_rec_type( c, rec_type );
      Add_variant( c, variant );
      Add_country( c, country );
      Add_edition( c, edition );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Households_Forecasts_List_Package.is_empty( l ) ) then
         a_households_forecasts := Ukds.Target_Data.Households_Forecasts_List_Package.First_Element( l );
      else
         a_households_forecasts := Ukds.Target_Data.Null_Households_Forecasts;
      end if;
      return a_households_forecasts;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.households_forecasts where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5", 
        On_Server => True );
        
   function Exists( year : Integer; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      aliased_rec_type : aliased String := To_String( rec_type );
      aliased_variant : aliased String := To_String( variant );
      aliased_country : aliased String := To_String( country );
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
      params( 1 ) := "+"( Integer'Pos( year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( edition ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Households_Forecasts matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Households_Forecasts_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Households_Forecasts retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Households_Forecasts is
      a_households_forecasts : Ukds.Target_Data.Households_Forecasts;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_households_forecasts.year := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_households_forecasts.rec_type:= To_Unbounded_String( gse.Value( cursor, 1 ));
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_households_forecasts.variant:= To_Unbounded_String( gse.Value( cursor, 2 ));
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_households_forecasts.country:= To_Unbounded_String( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_households_forecasts.edition := Year_Number'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_households_forecasts.one_adult_male:= Amount'Value( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_households_forecasts.one_adult_female:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_households_forecasts.two_adults:= Amount'Value( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_households_forecasts.one_adult_one_child:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_households_forecasts.one_adult_two_plus_children:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_households_forecasts.two_plus_adult_one_plus_children:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_households_forecasts.three_plus_person_all_adult:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_households_forecasts.all_households:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      return a_households_forecasts;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Households_Forecasts_List is
      l : Ukds.Target_Data.Households_Forecasts_List;
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
            a_households_forecasts : Ukds.Target_Data.Households_Forecasts := Map_From_Cursor( cursor );
         begin
            l.append( a_households_forecasts ); 
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
   
   procedure Update( a_households_forecasts : Ukds.Target_Data.Households_Forecasts; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_households_forecasts.rec_type );
      aliased_variant : aliased String := To_String( a_households_forecasts.variant );
      aliased_country : aliased String := To_String( a_households_forecasts.country );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Float( a_households_forecasts.one_adult_male ));
      params( 2 ) := "+"( Float( a_households_forecasts.one_adult_female ));
      params( 3 ) := "+"( Float( a_households_forecasts.two_adults ));
      params( 4 ) := "+"( Float( a_households_forecasts.one_adult_one_child ));
      params( 5 ) := "+"( Float( a_households_forecasts.one_adult_two_plus_children ));
      params( 6 ) := "+"( Float( a_households_forecasts.two_plus_adult_one_plus_children ));
      params( 7 ) := "+"( Float( a_households_forecasts.three_plus_person_all_adult ));
      params( 8 ) := "+"( Float( a_households_forecasts.all_households ));
      params( 9 ) := "+"( Integer'Pos( a_households_forecasts.year ));
      params( 10 ) := "+"( aliased_rec_type'Access );
      params( 11 ) := "+"( aliased_variant'Access );
      params( 12 ) := "+"( aliased_country'Access );
      params( 13 ) := "+"( Year_Number'Pos( a_households_forecasts.edition ));
      
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

   procedure Save( a_households_forecasts : Ukds.Target_Data.Households_Forecasts; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_households_forecasts.rec_type );
      aliased_variant : aliased String := To_String( a_households_forecasts.variant );
      aliased_country : aliased String := To_String( a_households_forecasts.country );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_households_forecasts.year, a_households_forecasts.rec_type, a_households_forecasts.variant, a_households_forecasts.country, a_households_forecasts.edition ) then
         Update( a_households_forecasts, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_households_forecasts.year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( a_households_forecasts.edition ));
      params( 6 ) := "+"( Float( a_households_forecasts.one_adult_male ));
      params( 7 ) := "+"( Float( a_households_forecasts.one_adult_female ));
      params( 8 ) := "+"( Float( a_households_forecasts.two_adults ));
      params( 9 ) := "+"( Float( a_households_forecasts.one_adult_one_child ));
      params( 10 ) := "+"( Float( a_households_forecasts.one_adult_two_plus_children ));
      params( 11 ) := "+"( Float( a_households_forecasts.two_plus_adult_one_plus_children ));
      params( 12 ) := "+"( Float( a_households_forecasts.three_plus_person_all_adult ));
      params( 13 ) := "+"( Float( a_households_forecasts.all_households ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Households_Forecasts
   --

   procedure Delete( a_households_forecasts : in out Ukds.Target_Data.Households_Forecasts; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_year( c, a_households_forecasts.year );
      Add_rec_type( c, a_households_forecasts.rec_type );
      Add_variant( c, a_households_forecasts.variant );
      Add_country( c, a_households_forecasts.country );
      Add_edition( c, a_households_forecasts.edition );
      Delete( c, connection );
      a_households_forecasts := Ukds.Target_Data.Null_Households_Forecasts;
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

   --
   -- functions to add something to a criteria
   --
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, year );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, To_String( rec_type ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, rec_type );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_variant( c : in out d.Criteria; variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "variant", op, join, To_String( variant ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant;


   procedure Add_variant( c : in out d.Criteria; variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "variant", op, join, variant, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant;


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


   procedure Add_edition( c : in out d.Criteria; edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edition", op, join, Integer( edition ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition;


   procedure Add_one_adult_male( c : in out d.Criteria; one_adult_male : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_male", op, join, Long_Float( one_adult_male ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_male;


   procedure Add_one_adult_female( c : in out d.Criteria; one_adult_female : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_female", op, join, Long_Float( one_adult_female ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_female;


   procedure Add_two_adults( c : in out d.Criteria; two_adults : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "two_adults", op, join, Long_Float( two_adults ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adults;


   procedure Add_one_adult_one_child( c : in out d.Criteria; one_adult_one_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_one_child", op, join, Long_Float( one_adult_one_child ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_one_child;


   procedure Add_one_adult_two_plus_children( c : in out d.Criteria; one_adult_two_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "one_adult_two_plus_children", op, join, Long_Float( one_adult_two_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_two_plus_children;


   procedure Add_two_plus_adult_one_plus_children( c : in out d.Criteria; two_plus_adult_one_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "two_plus_adult_one_plus_children", op, join, Long_Float( two_plus_adult_one_plus_children ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_plus_adult_one_plus_children;


   procedure Add_three_plus_person_all_adult( c : in out d.Criteria; three_plus_person_all_adult : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "three_plus_person_all_adult", op, join, Long_Float( three_plus_person_all_adult ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_three_plus_person_all_adult;


   procedure Add_all_households( c : in out d.Criteria; all_households : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "all_households", op, join, Long_Float( all_households ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_all_households;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_year_To_Orderings;


   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rec_type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type_To_Orderings;


   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "variant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant_To_Orderings;


   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_To_Orderings;


   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition_To_Orderings;


   procedure Add_one_adult_male_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_male", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_male_To_Orderings;


   procedure Add_one_adult_female_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_female", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_female_To_Orderings;


   procedure Add_two_adults_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "two_adults", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_adults_To_Orderings;


   procedure Add_one_adult_one_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_one_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_one_child_To_Orderings;


   procedure Add_one_adult_two_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "one_adult_two_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_one_adult_two_plus_children_To_Orderings;


   procedure Add_two_plus_adult_one_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "two_plus_adult_one_plus_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_two_plus_adult_one_plus_children_To_Orderings;


   procedure Add_three_plus_person_all_adult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "three_plus_person_all_adult", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_three_plus_person_all_adult_To_Orderings;


   procedure Add_all_households_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "all_households", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_all_households_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Households_Forecasts_IO;
