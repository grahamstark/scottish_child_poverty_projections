--
-- Created by ada_generator.py on 2017-09-20 15:06:43.122325
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

package body Ukds.Frs.Assets_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.ASSETS_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, assetype, seq, accname, x_amount," &
         "anymon, howmany, howmuch, howmuche, intro, issdate, issval, pd, month, issue" &
         " from frs.assets " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.assets (" &
         "user_id, edition, year, sernum, benunit, person, assetype, seq, accname, x_amount," &
         "anymon, howmany, howmuch, howmuche, intro, issdate, issval, pd, month, issue" &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.assets ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.assets set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 20 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : accname (Integer)
            2 => ( Parameter_Float, 0.0 ),   --  : x_amount (Amount)
            3 => ( Parameter_Integer, 0 ),   --  : anymon (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : howmany (Integer)
            5 => ( Parameter_Float, 0.0 ),   --  : howmuch (Amount)
            6 => ( Parameter_Integer, 0 ),   --  : howmuche (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : intro (Integer)
            8 => ( Parameter_Date, Clock ),   --  : issdate (Ada.Calendar.Time)
            9 => ( Parameter_Float, 0.0 ),   --  : issval (Amount)
           10 => ( Parameter_Integer, 0 ),   --  : pd (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           16 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           17 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : assetype (Integer)
           20 => ( Parameter_Integer, 0 )   --  : seq (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : assetype (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : seq (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : accname (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : x_amount (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : anymon (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : howmany (Integer)
           13 => ( Parameter_Float, 0.0 ),   --  : howmuch (Amount)
           14 => ( Parameter_Integer, 0 ),   --  : howmuche (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : intro (Integer)
           16 => ( Parameter_Date, Clock ),   --  : issdate (Ada.Calendar.Time)
           17 => ( Parameter_Float, 0.0 ),   --  : issval (Amount)
           18 => ( Parameter_Integer, 0 ),   --  : pd (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           20 => ( Parameter_Integer, 0 )   --  : issue (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 8 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : assetype (Integer)
            8 => ( Parameter_Integer, 0 )   --  : seq (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and assetype = $7 and seq = $8"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " accname = $1, x_amount = $2, anymon = $3, howmany = $4, howmuch = $5, howmuche = $6, intro = $7, issdate = $8, issval = $9, pd = $10, month = $11, issue = $12 where user_id = $13 and edition = $14 and year = $15 and sernum = $16 and benunit = $17 and person = $18 and assetype = $19 and seq = $20"; 
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


   
   Next_Free_user_id_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
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


   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
   Next_Free_edition_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_edition_query, On_Server => True );
   -- 
   -- Next highest avaiable value of edition - useful for saving  
   --
   function Next_Free_edition( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_edition_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_edition;


   Next_Free_year_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
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


   Next_Free_sernum_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
   Next_Free_sernum_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_sernum_query, On_Server => True );
   -- 
   -- Next highest avaiable value of sernum - useful for saving  
   --
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value is
      cursor              : gse.Forward_Cursor;
      ai                  : Sernum_Value;
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
      
      cursor.Fetch( local_connection, Next_Free_sernum_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Sernum_Value'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_sernum;


   Next_Free_benunit_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
   Next_Free_benunit_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_benunit_query, On_Server => True );
   -- 
   -- Next highest avaiable value of benunit - useful for saving  
   --
   function Next_Free_benunit( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_benunit_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_benunit;


   Next_Free_person_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
   Next_Free_person_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_person_query, On_Server => True );
   -- 
   -- Next highest avaiable value of person - useful for saving  
   --
   function Next_Free_person( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_person_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_person;


   Next_Free_assetype_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( assetype ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
   Next_Free_assetype_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_assetype_query, On_Server => True );
   -- 
   -- Next highest avaiable value of assetype - useful for saving  
   --
   function Next_Free_assetype( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_assetype_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_assetype;


   Next_Free_seq_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( seq ) + 1, 1 ) from frs.assets", SCHEMA_NAME );
   Next_Free_seq_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_seq_query, On_Server => True );
   -- 
   -- Next highest avaiable value of seq - useful for saving  
   --
   function Next_Free_seq( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_seq_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_seq;



   --
   -- returns true if the primary key parts of Ukds.Frs.Assets match the defaults in Ukds.Frs.Null_Assets
   --
   --
   -- Does this Ukds.Frs.Assets equal the default Ukds.Frs.Null_Assets ?
   --
   function Is_Null( a_assets : Assets ) return Boolean is
   begin
      return a_assets = Ukds.Frs.Null_Assets;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Assets matching the primary key fields, or the Ukds.Frs.Null_Assets record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; assetype : Integer; seq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Assets is
      l : Ukds.Frs.Assets_List;
      a_assets : Ukds.Frs.Assets;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_assetype( c, assetype );
      Add_seq( c, seq );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Assets_List_Package.is_empty( l ) ) then
         a_assets := Ukds.Frs.Assets_List_Package.First_Element( l );
      else
         a_assets := Ukds.Frs.Null_Assets;
      end if;
      return a_assets;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.assets where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and assetype = $7 and seq = $8", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; assetype : Integer; seq : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 1 ) := "+"( Integer'Pos( user_id ));
      params( 2 ) := "+"( Integer'Pos( edition ));
      params( 3 ) := "+"( Integer'Pos( year ));
      params( 4 ) := As_Bigint( sernum );
      params( 5 ) := "+"( Integer'Pos( benunit ));
      params( 6 ) := "+"( Integer'Pos( person ));
      params( 7 ) := "+"( Integer'Pos( assetype ));
      params( 8 ) := "+"( Integer'Pos( seq ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Assets matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Assets_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Assets retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Assets is
      a_assets : Ukds.Frs.Assets;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_assets.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_assets.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_assets.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_assets.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_assets.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_assets.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_assets.assetype := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_assets.seq := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_assets.accname := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_assets.x_amount:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_assets.anymon := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_assets.howmany := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_assets.howmuch:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_assets.howmuche := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_assets.intro := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_assets.issdate := gse.Time_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_assets.issval:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_assets.pd := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_assets.month := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_assets.issue := gse.Integer_Value( cursor, 19 );
      end if;
      return a_assets;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Assets_List is
      l : Ukds.Frs.Assets_List;
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
            a_assets : Ukds.Frs.Assets := Map_From_Cursor( cursor );
         begin
            l.append( a_assets ); 
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
   
   procedure Update( a_assets : Ukds.Frs.Assets; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
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

      params( 1 ) := "+"( Integer'Pos( a_assets.accname ));
      params( 2 ) := "+"( Float( a_assets.x_amount ));
      params( 3 ) := "+"( Integer'Pos( a_assets.anymon ));
      params( 4 ) := "+"( Integer'Pos( a_assets.howmany ));
      params( 5 ) := "+"( Float( a_assets.howmuch ));
      params( 6 ) := "+"( Integer'Pos( a_assets.howmuche ));
      params( 7 ) := "+"( Integer'Pos( a_assets.intro ));
      params( 8 ) := "+"( a_assets.issdate );
      params( 9 ) := "+"( Float( a_assets.issval ));
      params( 10 ) := "+"( Integer'Pos( a_assets.pd ));
      params( 11 ) := "+"( Integer'Pos( a_assets.month ));
      params( 12 ) := "+"( Integer'Pos( a_assets.issue ));
      params( 13 ) := "+"( Integer'Pos( a_assets.user_id ));
      params( 14 ) := "+"( Integer'Pos( a_assets.edition ));
      params( 15 ) := "+"( Integer'Pos( a_assets.year ));
      params( 16 ) := As_Bigint( a_assets.sernum );
      params( 17 ) := "+"( Integer'Pos( a_assets.benunit ));
      params( 18 ) := "+"( Integer'Pos( a_assets.person ));
      params( 19 ) := "+"( Integer'Pos( a_assets.assetype ));
      params( 20 ) := "+"( Integer'Pos( a_assets.seq ));
      
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

   procedure Save( a_assets : Ukds.Frs.Assets; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
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
      if overwrite and Exists( a_assets.user_id, a_assets.edition, a_assets.year, a_assets.sernum, a_assets.benunit, a_assets.person, a_assets.assetype, a_assets.seq ) then
         Update( a_assets, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_assets.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_assets.edition ));
      params( 3 ) := "+"( Integer'Pos( a_assets.year ));
      params( 4 ) := As_Bigint( a_assets.sernum );
      params( 5 ) := "+"( Integer'Pos( a_assets.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_assets.person ));
      params( 7 ) := "+"( Integer'Pos( a_assets.assetype ));
      params( 8 ) := "+"( Integer'Pos( a_assets.seq ));
      params( 9 ) := "+"( Integer'Pos( a_assets.accname ));
      params( 10 ) := "+"( Float( a_assets.x_amount ));
      params( 11 ) := "+"( Integer'Pos( a_assets.anymon ));
      params( 12 ) := "+"( Integer'Pos( a_assets.howmany ));
      params( 13 ) := "+"( Float( a_assets.howmuch ));
      params( 14 ) := "+"( Integer'Pos( a_assets.howmuche ));
      params( 15 ) := "+"( Integer'Pos( a_assets.intro ));
      params( 16 ) := "+"( a_assets.issdate );
      params( 17 ) := "+"( Float( a_assets.issval ));
      params( 18 ) := "+"( Integer'Pos( a_assets.pd ));
      params( 19 ) := "+"( Integer'Pos( a_assets.month ));
      params( 20 ) := "+"( Integer'Pos( a_assets.issue ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Assets
   --

   procedure Delete( a_assets : in out Ukds.Frs.Assets; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_assets.user_id );
      Add_edition( c, a_assets.edition );
      Add_year( c, a_assets.year );
      Add_sernum( c, a_assets.sernum );
      Add_benunit( c, a_assets.benunit );
      Add_person( c, a_assets.person );
      Add_assetype( c, a_assets.assetype );
      Add_seq( c, a_assets.seq );
      Delete( c, connection );
      a_assets := Ukds.Frs.Null_Assets;
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
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "user_id", op, join, user_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id;


   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edition", op, join, edition );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition;


   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, year );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benunit", op, join, benunit );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit;


   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "person", op, join, person );
   begin
      d.add_to_criteria( c, elem );
   end Add_person;


   procedure Add_assetype( c : in out d.Criteria; assetype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "assetype", op, join, assetype );
   begin
      d.add_to_criteria( c, elem );
   end Add_assetype;


   procedure Add_seq( c : in out d.Criteria; seq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seq", op, join, seq );
   begin
      d.add_to_criteria( c, elem );
   end Add_seq;


   procedure Add_accname( c : in out d.Criteria; accname : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accname", op, join, accname );
   begin
      d.add_to_criteria( c, elem );
   end Add_accname;


   procedure Add_x_amount( c : in out d.Criteria; x_amount : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "x_amount", op, join, Long_Float( x_amount ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_amount;


   procedure Add_anymon( c : in out d.Criteria; anymon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anymon", op, join, anymon );
   begin
      d.add_to_criteria( c, elem );
   end Add_anymon;


   procedure Add_howmany( c : in out d.Criteria; howmany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howmany", op, join, howmany );
   begin
      d.add_to_criteria( c, elem );
   end Add_howmany;


   procedure Add_howmuch( c : in out d.Criteria; howmuch : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howmuch", op, join, Long_Float( howmuch ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_howmuch;


   procedure Add_howmuche( c : in out d.Criteria; howmuche : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howmuche", op, join, howmuche );
   begin
      d.add_to_criteria( c, elem );
   end Add_howmuche;


   procedure Add_intro( c : in out d.Criteria; intro : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intro", op, join, intro );
   begin
      d.add_to_criteria( c, elem );
   end Add_intro;


   procedure Add_issdate( c : in out d.Criteria; issdate : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issdate", op, join, Ada.Calendar.Time( issdate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_issdate;


   procedure Add_issval( c : in out d.Criteria; issval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issval", op, join, Long_Float( issval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_issval;


   procedure Add_pd( c : in out d.Criteria; pd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pd", op, join, pd );
   begin
      d.add_to_criteria( c, elem );
   end Add_pd;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "user_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id_To_Orderings;


   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition_To_Orderings;


   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_year_To_Orderings;


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;


   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benunit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit_To_Orderings;


   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "person", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_person_To_Orderings;


   procedure Add_assetype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "assetype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_assetype_To_Orderings;


   procedure Add_seq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seq_To_Orderings;


   procedure Add_accname_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accname", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accname_To_Orderings;


   procedure Add_x_amount_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "x_amount", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_amount_To_Orderings;


   procedure Add_anymon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anymon", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anymon_To_Orderings;


   procedure Add_howmany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howmany", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howmany_To_Orderings;


   procedure Add_howmuch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howmuch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howmuch_To_Orderings;


   procedure Add_howmuche_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howmuche", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howmuche_To_Orderings;


   procedure Add_intro_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intro", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intro_To_Orderings;


   procedure Add_issdate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issdate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issdate_To_Orderings;


   procedure Add_issval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issval_To_Orderings;


   procedure Add_pd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pd_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Assets_IO;
