--
-- Created by ada_generator.py on 2017-11-14 11:49:19.023211
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

package body Ukds.Target_Data.Obr_Participation_Rates_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.OBR_PARTICIPATION_RATES_IO" );
   
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
         "year, rec_type, variant, country, edition, target_group, age_16_19, age_20_24, age_25_29, age_30_34," &
         "age_35_39, age_40_44, age_45_49, age_50_54, age_55_59, age_60_64, age_65_69, age_70_74, age_75_plus " &
         " from target_data.obr_participation_rates " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.obr_participation_rates (" &
         "year, rec_type, variant, country, edition, target_group, age_16_19, age_20_24, age_25_29, age_30_34," &
         "age_35_39, age_40_44, age_45_49, age_50_54, age_55_59, age_60_64, age_65_69, age_70_74, age_75_plus " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.obr_participation_rates ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.obr_participation_rates set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 19 ) := ( if update_order then (
            1 => ( Parameter_Float, 0.0 ),   --  : age_16_19 (Amount)
            2 => ( Parameter_Float, 0.0 ),   --  : age_20_24 (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : age_25_29 (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : age_30_34 (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : age_35_39 (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : age_40_44 (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : age_45_49 (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : age_50_54 (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : age_55_59 (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : age_60_64 (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : age_65_69 (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : age_70_74 (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : age_75_plus (Amount)
           14 => ( Parameter_Integer, 0 ),   --  : year (Year_Number)
           15 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
           16 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
           17 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
           18 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
           19 => ( Parameter_Text, null, Null_Unbounded_String )   --  : target_group (Unbounded_String)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : year (Year_Number)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : target_group (Unbounded_String)
            7 => ( Parameter_Float, 0.0 ),   --  : age_16_19 (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : age_20_24 (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : age_25_29 (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : age_30_34 (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : age_35_39 (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : age_40_44 (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : age_45_49 (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : age_50_54 (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : age_55_59 (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : age_60_64 (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : age_65_69 (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : age_70_74 (Amount)
           19 => ( Parameter_Float, 0.0 )   --  : age_75_plus (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 6 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : year (Year_Number)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            6 => ( Parameter_Text, null, Null_Unbounded_String )   --  : target_group (Unbounded_String)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5 and target_group = $6"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " age_16_19 = $1, age_20_24 = $2, age_25_29 = $3, age_30_34 = $4, age_35_39 = $5, age_40_44 = $6, age_45_49 = $7, age_50_54 = $8, age_55_59 = $9, age_60_64 = $10, age_65_69 = $11, age_70_74 = $12, age_75_plus = $13 where year = $14 and rec_type = $15 and variant = $16 and country = $17 and edition = $18 and target_group = $19"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from target_data.obr_participation_rates", SCHEMA_NAME );
   Next_Free_year_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_year_query, On_Server => True );
   -- 
   -- Next highest avaiable value of year - useful for saving  
   --
   function Next_Free_year( connection : Database_Connection := null) return Year_Number is
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
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Year_Number'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_year;


   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from target_data.obr_participation_rates", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Target_Data.Obr_Participation_Rates match the defaults in Ukds.Target_Data.Null_Obr_Participation_Rates
   --
   --
   -- Does this Ukds.Target_Data.Obr_Participation_Rates equal the default Ukds.Target_Data.Null_Obr_Participation_Rates ?
   --
   function Is_Null( a_obr_participation_rates : Obr_Participation_Rates ) return Boolean is
   begin
      return a_obr_participation_rates = Ukds.Target_Data.Null_Obr_Participation_Rates;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Obr_Participation_Rates matching the primary key fields, or the Ukds.Target_Data.Null_Obr_Participation_Rates record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates is
      l : Ukds.Target_Data.Obr_Participation_Rates_List;
      a_obr_participation_rates : Ukds.Target_Data.Obr_Participation_Rates;
      c : d.Criteria;
   begin      
      Add_year( c, year );
      Add_rec_type( c, rec_type );
      Add_variant( c, variant );
      Add_country( c, country );
      Add_edition( c, edition );
      Add_target_group( c, target_group );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Obr_Participation_Rates_List_Package.is_empty( l ) ) then
         a_obr_participation_rates := Ukds.Target_Data.Obr_Participation_Rates_List_Package.First_Element( l );
      else
         a_obr_participation_rates := Ukds.Target_Data.Null_Obr_Participation_Rates;
      end if;
      return a_obr_participation_rates;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.obr_participation_rates where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5 and target_group = $6", 
        On_Server => True );
        
   function Exists( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      aliased_rec_type : aliased String := To_String( rec_type );
      aliased_variant : aliased String := To_String( variant );
      aliased_country : aliased String := To_String( country );
      aliased_target_group : aliased String := To_String( target_group );
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
      params( 1 ) := "+"( Year_Number'Pos( year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( edition ));
      params( 6 ) := "+"( aliased_target_group'Access );
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Obr_Participation_Rates matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Obr_Participation_Rates retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Obr_Participation_Rates is
      a_obr_participation_rates : Ukds.Target_Data.Obr_Participation_Rates;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_obr_participation_rates.year := Year_Number'Value( gse.Value( cursor, 0 ));
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_obr_participation_rates.rec_type:= To_Unbounded_String( gse.Value( cursor, 1 ));
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_obr_participation_rates.variant:= To_Unbounded_String( gse.Value( cursor, 2 ));
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_obr_participation_rates.country:= To_Unbounded_String( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_obr_participation_rates.edition := Year_Number'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_obr_participation_rates.target_group:= To_Unbounded_String( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_obr_participation_rates.age_16_19:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_obr_participation_rates.age_20_24:= Amount'Value( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_obr_participation_rates.age_25_29:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_obr_participation_rates.age_30_34:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_obr_participation_rates.age_35_39:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_obr_participation_rates.age_40_44:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_obr_participation_rates.age_45_49:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_obr_participation_rates.age_50_54:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_obr_participation_rates.age_55_59:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_obr_participation_rates.age_60_64:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_obr_participation_rates.age_65_69:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_obr_participation_rates.age_70_74:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_obr_participation_rates.age_75_plus:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      return a_obr_participation_rates;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates_List is
      l : Ukds.Target_Data.Obr_Participation_Rates_List;
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
            a_obr_participation_rates : Ukds.Target_Data.Obr_Participation_Rates := Map_From_Cursor( cursor );
         begin
            l.append( a_obr_participation_rates ); 
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
   
   procedure Update( a_obr_participation_rates : Ukds.Target_Data.Obr_Participation_Rates; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_obr_participation_rates.rec_type );
      aliased_variant : aliased String := To_String( a_obr_participation_rates.variant );
      aliased_country : aliased String := To_String( a_obr_participation_rates.country );
      aliased_target_group : aliased String := To_String( a_obr_participation_rates.target_group );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Float( a_obr_participation_rates.age_16_19 ));
      params( 2 ) := "+"( Float( a_obr_participation_rates.age_20_24 ));
      params( 3 ) := "+"( Float( a_obr_participation_rates.age_25_29 ));
      params( 4 ) := "+"( Float( a_obr_participation_rates.age_30_34 ));
      params( 5 ) := "+"( Float( a_obr_participation_rates.age_35_39 ));
      params( 6 ) := "+"( Float( a_obr_participation_rates.age_40_44 ));
      params( 7 ) := "+"( Float( a_obr_participation_rates.age_45_49 ));
      params( 8 ) := "+"( Float( a_obr_participation_rates.age_50_54 ));
      params( 9 ) := "+"( Float( a_obr_participation_rates.age_55_59 ));
      params( 10 ) := "+"( Float( a_obr_participation_rates.age_60_64 ));
      params( 11 ) := "+"( Float( a_obr_participation_rates.age_65_69 ));
      params( 12 ) := "+"( Float( a_obr_participation_rates.age_70_74 ));
      params( 13 ) := "+"( Float( a_obr_participation_rates.age_75_plus ));
      params( 14 ) := "+"( Year_Number'Pos( a_obr_participation_rates.year ));
      params( 15 ) := "+"( aliased_rec_type'Access );
      params( 16 ) := "+"( aliased_variant'Access );
      params( 17 ) := "+"( aliased_country'Access );
      params( 18 ) := "+"( Year_Number'Pos( a_obr_participation_rates.edition ));
      params( 19 ) := "+"( aliased_target_group'Access );
      
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

   procedure Save( a_obr_participation_rates : Ukds.Target_Data.Obr_Participation_Rates; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_obr_participation_rates.rec_type );
      aliased_variant : aliased String := To_String( a_obr_participation_rates.variant );
      aliased_country : aliased String := To_String( a_obr_participation_rates.country );
      aliased_target_group : aliased String := To_String( a_obr_participation_rates.target_group );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_obr_participation_rates.year, a_obr_participation_rates.rec_type, a_obr_participation_rates.variant, a_obr_participation_rates.country, a_obr_participation_rates.edition, a_obr_participation_rates.target_group ) then
         Update( a_obr_participation_rates, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Year_Number'Pos( a_obr_participation_rates.year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( a_obr_participation_rates.edition ));
      params( 6 ) := "+"( aliased_target_group'Access );
      params( 7 ) := "+"( Float( a_obr_participation_rates.age_16_19 ));
      params( 8 ) := "+"( Float( a_obr_participation_rates.age_20_24 ));
      params( 9 ) := "+"( Float( a_obr_participation_rates.age_25_29 ));
      params( 10 ) := "+"( Float( a_obr_participation_rates.age_30_34 ));
      params( 11 ) := "+"( Float( a_obr_participation_rates.age_35_39 ));
      params( 12 ) := "+"( Float( a_obr_participation_rates.age_40_44 ));
      params( 13 ) := "+"( Float( a_obr_participation_rates.age_45_49 ));
      params( 14 ) := "+"( Float( a_obr_participation_rates.age_50_54 ));
      params( 15 ) := "+"( Float( a_obr_participation_rates.age_55_59 ));
      params( 16 ) := "+"( Float( a_obr_participation_rates.age_60_64 ));
      params( 17 ) := "+"( Float( a_obr_participation_rates.age_65_69 ));
      params( 18 ) := "+"( Float( a_obr_participation_rates.age_70_74 ));
      params( 19 ) := "+"( Float( a_obr_participation_rates.age_75_plus ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Obr_Participation_Rates
   --

   procedure Delete( a_obr_participation_rates : in out Ukds.Target_Data.Obr_Participation_Rates; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_year( c, a_obr_participation_rates.year );
      Add_rec_type( c, a_obr_participation_rates.rec_type );
      Add_variant( c, a_obr_participation_rates.variant );
      Add_country( c, a_obr_participation_rates.country );
      Add_edition( c, a_obr_participation_rates.edition );
      Add_target_group( c, a_obr_participation_rates.target_group );
      Delete( c, connection );
      a_obr_participation_rates := Ukds.Target_Data.Null_Obr_Participation_Rates;
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
   procedure Add_year( c : in out d.Criteria; year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, Integer( year ) );
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


   procedure Add_target_group( c : in out d.Criteria; target_group : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "target_group", op, join, To_String( target_group ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_target_group;


   procedure Add_target_group( c : in out d.Criteria; target_group : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "target_group", op, join, target_group, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_target_group;


   procedure Add_age_16_19( c : in out d.Criteria; age_16_19 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_16_19", op, join, Long_Float( age_16_19 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_19;


   procedure Add_age_20_24( c : in out d.Criteria; age_20_24 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_20_24", op, join, Long_Float( age_20_24 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_24;


   procedure Add_age_25_29( c : in out d.Criteria; age_25_29 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_25_29", op, join, Long_Float( age_25_29 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_29;


   procedure Add_age_30_34( c : in out d.Criteria; age_30_34 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_30_34", op, join, Long_Float( age_30_34 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_34;


   procedure Add_age_35_39( c : in out d.Criteria; age_35_39 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_35_39", op, join, Long_Float( age_35_39 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_39;


   procedure Add_age_40_44( c : in out d.Criteria; age_40_44 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_40_44", op, join, Long_Float( age_40_44 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_44;


   procedure Add_age_45_49( c : in out d.Criteria; age_45_49 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_45_49", op, join, Long_Float( age_45_49 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_49;


   procedure Add_age_50_54( c : in out d.Criteria; age_50_54 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_50_54", op, join, Long_Float( age_50_54 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_54;


   procedure Add_age_55_59( c : in out d.Criteria; age_55_59 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_55_59", op, join, Long_Float( age_55_59 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_59;


   procedure Add_age_60_64( c : in out d.Criteria; age_60_64 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_60_64", op, join, Long_Float( age_60_64 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_64;


   procedure Add_age_65_69( c : in out d.Criteria; age_65_69 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_65_69", op, join, Long_Float( age_65_69 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_69;


   procedure Add_age_70_74( c : in out d.Criteria; age_70_74 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_70_74", op, join, Long_Float( age_70_74 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_74;


   procedure Add_age_75_plus( c : in out d.Criteria; age_75_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_75_plus", op, join, Long_Float( age_75_plus ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_plus;


   
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


   procedure Add_target_group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "target_group", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_target_group_To_Orderings;


   procedure Add_age_16_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_16_19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_19_To_Orderings;


   procedure Add_age_20_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_20_24", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_24_To_Orderings;


   procedure Add_age_25_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_25_29", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_29_To_Orderings;


   procedure Add_age_30_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_30_34", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_34_To_Orderings;


   procedure Add_age_35_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_35_39", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_39_To_Orderings;


   procedure Add_age_40_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_40_44", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_44_To_Orderings;


   procedure Add_age_45_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_45_49", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_49_To_Orderings;


   procedure Add_age_50_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_50_54", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_54_To_Orderings;


   procedure Add_age_55_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_55_59", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_59_To_Orderings;


   procedure Add_age_60_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_60_64", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_64_To_Orderings;


   procedure Add_age_65_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_65_69", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_69_To_Orderings;


   procedure Add_age_70_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_70_74", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_74_To_Orderings;


   procedure Add_age_75_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_75_plus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_plus_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Obr_Participation_Rates_IO;
