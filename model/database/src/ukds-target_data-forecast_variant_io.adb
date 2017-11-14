--
-- Created by Ada Mill (https://github.com/grahamstark/ada_mill)
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

with Ukds.Target_Data.Obr_Participation_Rates_IO;
with Ukds.Target_Data.Nireland_Households_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.England_Households_IO;
with Ukds.Target_Data.Wales_Households_IO;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Forecast_Variant_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.FORECAST_VARIANT_IO" );
   
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
         "rec_type, variant, country, edition, source, description, url, filename " &
         " from target_data.forecast_variant " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.forecast_variant (" &
         "rec_type, variant, country, edition, source, description, url, filename " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.forecast_variant ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.forecast_variant set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 8 ) := ( if update_order then (
            1 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : source (Unbounded_String)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : description (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : url (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : filename (Unbounded_String)
            5 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            7 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            8 => ( Parameter_Integer, 0 )   --  : edition (Year_Number)
      ) else (
            1 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            4 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            5 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : source (Unbounded_String)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : description (Unbounded_String)
            7 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : url (Unbounded_String)
            8 => ( Parameter_Text, null, Null_Unbounded_String )   --  : filename (Unbounded_String)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 4 ) := (
            1 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            4 => ( Parameter_Integer, 0 )   --  : edition (Year_Number)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where rec_type = $1 and variant = $2 and country = $3 and edition = $4"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " source = $1, description = $2, url = $3, filename = $4 where rec_type = $5 and variant = $6 and country = $7 and edition = $8"; 
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


   
   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from target_data.forecast_variant", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Target_Data.Forecast_Variant match the defaults in Ukds.Target_Data.Null_Forecast_Variant
   --
   --
   -- Does this Ukds.Target_Data.Forecast_Variant equal the default Ukds.Target_Data.Null_Forecast_Variant ?
   --
   function Is_Null( a_forecast_variant : Forecast_Variant ) return Boolean is
   begin
      return a_forecast_variant = Ukds.Target_Data.Null_Forecast_Variant;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Forecast_Variant matching the primary key fields, or the Ukds.Target_Data.Null_Forecast_Variant record
   -- if no such record exists
   --
   function Retrieve_By_PK( rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant is
      l : Ukds.Target_Data.Forecast_Variant_List;
      a_forecast_variant : Ukds.Target_Data.Forecast_Variant;
      c : d.Criteria;
   begin      
      Add_rec_type( c, rec_type );
      Add_variant( c, variant );
      Add_country( c, country );
      Add_edition( c, edition );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Forecast_Variant_List_Package.is_empty( l ) ) then
         a_forecast_variant := Ukds.Target_Data.Forecast_Variant_List_Package.First_Element( l );
      else
         a_forecast_variant := Ukds.Target_Data.Null_Forecast_Variant;
      end if;
      return a_forecast_variant;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.forecast_variant where rec_type = $1 and variant = $2 and country = $3 and edition = $4", 
        On_Server => True );
        
   function Exists( rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Boolean  is
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
      params( 1 ) := "+"( aliased_rec_type'Access );
      params( 2 ) := "+"( aliased_variant'Access );
      params( 3 ) := "+"( aliased_country'Access );
      params( 4 ) := "+"( Year_Number'Pos( edition ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Forecast_Variant matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Forecast_Variant retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Forecast_Variant is
      a_forecast_variant : Ukds.Target_Data.Forecast_Variant;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_forecast_variant.rec_type:= To_Unbounded_String( gse.Value( cursor, 0 ));
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_forecast_variant.variant:= To_Unbounded_String( gse.Value( cursor, 1 ));
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_forecast_variant.country:= To_Unbounded_String( gse.Value( cursor, 2 ));
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_forecast_variant.edition := Year_Number'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_forecast_variant.source:= To_Unbounded_String( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_forecast_variant.description:= To_Unbounded_String( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_forecast_variant.url:= To_Unbounded_String( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_forecast_variant.filename:= To_Unbounded_String( gse.Value( cursor, 7 ));
      end if;
      return a_forecast_variant;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Forecast_Variant_List is
      l : Ukds.Target_Data.Forecast_Variant_List;
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
            a_forecast_variant : Ukds.Target_Data.Forecast_Variant := Map_From_Cursor( cursor );
         begin
            l.append( a_forecast_variant ); 
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
   
   procedure Update( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_forecast_variant.rec_type );
      aliased_variant : aliased String := To_String( a_forecast_variant.variant );
      aliased_country : aliased String := To_String( a_forecast_variant.country );
      aliased_source : aliased String := To_String( a_forecast_variant.source );
      aliased_description : aliased String := To_String( a_forecast_variant.description );
      aliased_url : aliased String := To_String( a_forecast_variant.url );
      aliased_filename : aliased String := To_String( a_forecast_variant.filename );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( aliased_source'Access );
      params( 2 ) := "+"( aliased_description'Access );
      params( 3 ) := "+"( aliased_url'Access );
      params( 4 ) := "+"( aliased_filename'Access );
      params( 5 ) := "+"( aliased_rec_type'Access );
      params( 6 ) := "+"( aliased_variant'Access );
      params( 7 ) := "+"( aliased_country'Access );
      params( 8 ) := "+"( Year_Number'Pos( a_forecast_variant.edition ));
      
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

   procedure Save( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_forecast_variant.rec_type );
      aliased_variant : aliased String := To_String( a_forecast_variant.variant );
      aliased_country : aliased String := To_String( a_forecast_variant.country );
      aliased_source : aliased String := To_String( a_forecast_variant.source );
      aliased_description : aliased String := To_String( a_forecast_variant.description );
      aliased_url : aliased String := To_String( a_forecast_variant.url );
      aliased_filename : aliased String := To_String( a_forecast_variant.filename );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_forecast_variant.rec_type, a_forecast_variant.variant, a_forecast_variant.country, a_forecast_variant.edition ) then
         Update( a_forecast_variant, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( aliased_rec_type'Access );
      params( 2 ) := "+"( aliased_variant'Access );
      params( 3 ) := "+"( aliased_country'Access );
      params( 4 ) := "+"( Year_Number'Pos( a_forecast_variant.edition ));
      params( 5 ) := "+"( aliased_source'Access );
      params( 6 ) := "+"( aliased_description'Access );
      params( 7 ) := "+"( aliased_url'Access );
      params( 8 ) := "+"( aliased_filename'Access );
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Forecast_Variant
   --

   procedure Delete( a_forecast_variant : in out Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_rec_type( c, a_forecast_variant.rec_type );
      Add_variant( c, a_forecast_variant.variant );
      Add_country( c, a_forecast_variant.country );
      Add_edition( c, a_forecast_variant.edition );
      Delete( c, connection );
      a_forecast_variant := Ukds.Target_Data.Null_Forecast_Variant;
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
   function Retrieve_Associated_Ukds_Target_Data_Obr_Participation_Rates( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Obr_Participation_Rates_IO.Add_Rec_Type( c, a_forecast_variant.Rec_Type );
      Ukds.Target_Data.Obr_Participation_Rates_IO.Add_Variant( c, a_forecast_variant.Variant );
      Ukds.Target_Data.Obr_Participation_Rates_IO.Add_Country( c, a_forecast_variant.Country );
      Ukds.Target_Data.Obr_Participation_Rates_IO.Add_Edition( c, a_forecast_variant.Edition );
      return Ukds.Target_Data.Obr_Participation_Rates_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Obr_Participation_Rates;


   function Retrieve_Associated_Ukds_Target_Data_Nireland_Households( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Nireland_Households_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Nireland_Households_IO.Add_Rec_Type( c, a_forecast_variant.Rec_Type );
      Ukds.Target_Data.Nireland_Households_IO.Add_Variant( c, a_forecast_variant.Variant );
      Ukds.Target_Data.Nireland_Households_IO.Add_Country( c, a_forecast_variant.Country );
      Ukds.Target_Data.Nireland_Households_IO.Add_Edition( c, a_forecast_variant.Edition );
      return Ukds.Target_Data.Nireland_Households_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Nireland_Households;


   function Retrieve_Associated_Ukds_Target_Data_Households_Forecasts( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Households_Forecasts_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Households_Forecasts_IO.Add_Rec_Type( c, a_forecast_variant.Rec_Type );
      Ukds.Target_Data.Households_Forecasts_IO.Add_Variant( c, a_forecast_variant.Variant );
      Ukds.Target_Data.Households_Forecasts_IO.Add_Country( c, a_forecast_variant.Country );
      Ukds.Target_Data.Households_Forecasts_IO.Add_Edition( c, a_forecast_variant.Edition );
      return Ukds.Target_Data.Households_Forecasts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Households_Forecasts;


   function Retrieve_Associated_Ukds_Target_Data_Population_Forecasts( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Population_Forecasts_IO.Add_Rec_Type( c, a_forecast_variant.Rec_Type );
      Ukds.Target_Data.Population_Forecasts_IO.Add_Variant( c, a_forecast_variant.Variant );
      Ukds.Target_Data.Population_Forecasts_IO.Add_Country( c, a_forecast_variant.Country );
      Ukds.Target_Data.Population_Forecasts_IO.Add_Edition( c, a_forecast_variant.Edition );
      return Ukds.Target_Data.Population_Forecasts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Population_Forecasts;


   function Retrieve_Associated_Ukds_Target_Data_England_Households( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.England_Households_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.England_Households_IO.Add_Rec_Type( c, a_forecast_variant.Rec_Type );
      Ukds.Target_Data.England_Households_IO.Add_Variant( c, a_forecast_variant.Variant );
      Ukds.Target_Data.England_Households_IO.Add_Country( c, a_forecast_variant.Country );
      Ukds.Target_Data.England_Households_IO.Add_Edition( c, a_forecast_variant.Edition );
      return Ukds.Target_Data.England_Households_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_England_Households;


   function Retrieve_Associated_Ukds_Target_Data_Wales_Households( a_forecast_variant : Ukds.Target_Data.Forecast_Variant; connection : Database_Connection := null ) return Ukds.Target_Data.Wales_Households_List is
      c : d.Criteria;
   begin
      Ukds.Target_Data.Wales_Households_IO.Add_Rec_Type( c, a_forecast_variant.Rec_Type );
      Ukds.Target_Data.Wales_Households_IO.Add_Variant( c, a_forecast_variant.Variant );
      Ukds.Target_Data.Wales_Households_IO.Add_Country( c, a_forecast_variant.Country );
      Ukds.Target_Data.Wales_Households_IO.Add_Edition( c, a_forecast_variant.Edition );
      return Ukds.Target_Data.Wales_Households_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Target_Data_Wales_Households;



   --
   -- functions to add something to a criteria
   --
   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, To_String( rec_type ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, rec_type, 20 );
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


   procedure Add_source( c : in out d.Criteria; source : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "source", op, join, To_String( source ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_source;


   procedure Add_source( c : in out d.Criteria; source : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "source", op, join, source, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_source;


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


   procedure Add_url( c : in out d.Criteria; url : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "url", op, join, To_String( url ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_url;


   procedure Add_url( c : in out d.Criteria; url : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "url", op, join, url );
   begin
      d.add_to_criteria( c, elem );
   end Add_url;


   procedure Add_filename( c : in out d.Criteria; filename : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "filename", op, join, To_String( filename ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_filename;


   procedure Add_filename( c : in out d.Criteria; filename : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "filename", op, join, filename );
   begin
      d.add_to_criteria( c, elem );
   end Add_filename;


   
   --
   -- functions to add an ordering to a criteria
   --
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


   procedure Add_source_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "source", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_source_To_Orderings;


   procedure Add_description_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "description", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_description_To_Orderings;


   procedure Add_url_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "url", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_url_To_Orderings;


   procedure Add_filename_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "filename", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_filename_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Forecast_Variant_IO;
