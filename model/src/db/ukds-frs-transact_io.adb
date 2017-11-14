--
-- Created by ada_generator.py on 2017-11-14 12:23:42.078658
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

package body Ukds.Frs.Transact_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.TRANSACT_IO" );
   
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
         "user_id, edition, year, sernum, key1, key2, key3, key4, key5, frstable," &
         "frsvar, old_val, new_val, datetime, appldate, batch, trantype, reason, rowid " &
         " from frs.transact " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.transact (" &
         "user_id, edition, year, sernum, key1, key2, key3, key4, key5, frstable," &
         "frsvar, old_val, new_val, datetime, appldate, batch, trantype, reason, rowid " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.transact ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.transact set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 19 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : key1 (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : key2 (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : key3 (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : key4 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : key5 (Integer)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : frstable (Unbounded_String)
            7 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : frsvar (Unbounded_String)
            8 => ( Parameter_Float, 0.0 ),   --  : old_val (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : new_val (Amount)
           10 => ( Parameter_Date, Clock ),   --  : datetime (Ada.Calendar.Time)
           11 => ( Parameter_Date, Clock ),   --  : appldate (Ada.Calendar.Time)
           12 => ( Parameter_Integer, 0 ),   --  : batch (Integer)
           13 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : trantype (Unbounded_String)
           14 => ( Parameter_Integer, 0 ),   --  : reason (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           18 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           19 => ( Parameter_Integer, 0 )   --  : rowid (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : key1 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : key2 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : key3 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : key4 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : key5 (Integer)
           10 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : frstable (Unbounded_String)
           11 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : frsvar (Unbounded_String)
           12 => ( Parameter_Float, 0.0 ),   --  : old_val (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : new_val (Amount)
           14 => ( Parameter_Date, Clock ),   --  : datetime (Ada.Calendar.Time)
           15 => ( Parameter_Date, Clock ),   --  : appldate (Ada.Calendar.Time)
           16 => ( Parameter_Integer, 0 ),   --  : batch (Integer)
           17 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : trantype (Unbounded_String)
           18 => ( Parameter_Integer, 0 ),   --  : reason (Integer)
           19 => ( Parameter_Integer, 0 )   --  : rowid (Integer)
      
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
      params : constant SQL_Parameters( 1 .. 5 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 )   --  : rowid (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and rowid = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " key1 = $1, key2 = $2, key3 = $3, key4 = $4, key5 = $5, frstable = $6, frsvar = $7, old_val = $8, new_val = $9, datetime = $10, appldate = $11, batch = $12, trantype = $13, reason = $14 where user_id = $15 and edition = $16 and year = $17 and sernum = $18 and rowid = $19"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.transact", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.transact", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.transact", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.transact", SCHEMA_NAME );
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


   Next_Free_rowid_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( rowid ) + 1, 1 ) from frs.transact", SCHEMA_NAME );
   Next_Free_rowid_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_rowid_query, On_Server => True );
   -- 
   -- Next highest avaiable value of rowid - useful for saving  
   --
   function Next_Free_rowid( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_rowid_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_rowid;



   --
   -- returns true if the primary key parts of Ukds.Frs.Transact match the defaults in Ukds.Frs.Null_Transact
   --
   --
   -- Does this Ukds.Frs.Transact equal the default Ukds.Frs.Null_Transact ?
   --
   function Is_Null( a_transact : Transact ) return Boolean is
   begin
      return a_transact = Ukds.Frs.Null_Transact;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Transact matching the primary key fields, or the Ukds.Frs.Null_Transact record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; rowid : Integer; connection : Database_Connection := null ) return Ukds.Frs.Transact is
      l : Ukds.Frs.Transact_List;
      a_transact : Ukds.Frs.Transact;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_rowid( c, rowid );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Transact_List_Package.is_empty( l ) ) then
         a_transact := Ukds.Frs.Transact_List_Package.First_Element( l );
      else
         a_transact := Ukds.Frs.Null_Transact;
      end if;
      return a_transact;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.transact where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and rowid = $5", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; rowid : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 5 ) := "+"( Integer'Pos( rowid ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Transact matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Transact_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Transact retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Transact is
      a_transact : Ukds.Frs.Transact;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_transact.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_transact.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_transact.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_transact.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_transact.key1 := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_transact.key2 := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_transact.key3 := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_transact.key4 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_transact.key5 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_transact.frstable:= To_Unbounded_String( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_transact.frsvar:= To_Unbounded_String( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_transact.old_val:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_transact.new_val:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_transact.datetime := gse.Time_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_transact.appldate := gse.Time_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_transact.batch := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_transact.trantype:= To_Unbounded_String( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_transact.reason := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_transact.rowid := gse.Integer_Value( cursor, 18 );
      end if;
      return a_transact;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Transact_List is
      l : Ukds.Frs.Transact_List;
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
            a_transact : Ukds.Frs.Transact := Map_From_Cursor( cursor );
         begin
            l.append( a_transact ); 
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
   
   procedure Update( a_transact : Ukds.Frs.Transact; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_frstable : aliased String := To_String( a_transact.frstable );
      aliased_frsvar : aliased String := To_String( a_transact.frsvar );
      aliased_trantype : aliased String := To_String( a_transact.trantype );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Integer'Pos( a_transact.key1 ));
      params( 2 ) := "+"( Integer'Pos( a_transact.key2 ));
      params( 3 ) := "+"( Integer'Pos( a_transact.key3 ));
      params( 4 ) := "+"( Integer'Pos( a_transact.key4 ));
      params( 5 ) := "+"( Integer'Pos( a_transact.key5 ));
      params( 6 ) := "+"( aliased_frstable'Access );
      params( 7 ) := "+"( aliased_frsvar'Access );
      params( 8 ) := "+"( Float( a_transact.old_val ));
      params( 9 ) := "+"( Float( a_transact.new_val ));
      params( 10 ) := "+"( a_transact.datetime );
      params( 11 ) := "+"( a_transact.appldate );
      params( 12 ) := "+"( Integer'Pos( a_transact.batch ));
      params( 13 ) := "+"( aliased_trantype'Access );
      params( 14 ) := "+"( Integer'Pos( a_transact.reason ));
      params( 15 ) := "+"( Integer'Pos( a_transact.user_id ));
      params( 16 ) := "+"( Integer'Pos( a_transact.edition ));
      params( 17 ) := "+"( Integer'Pos( a_transact.year ));
      params( 18 ) := As_Bigint( a_transact.sernum );
      params( 19 ) := "+"( Integer'Pos( a_transact.rowid ));
      
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

   procedure Save( a_transact : Ukds.Frs.Transact; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_frstable : aliased String := To_String( a_transact.frstable );
      aliased_frsvar : aliased String := To_String( a_transact.frsvar );
      aliased_trantype : aliased String := To_String( a_transact.trantype );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_transact.user_id, a_transact.edition, a_transact.year, a_transact.sernum, a_transact.rowid ) then
         Update( a_transact, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_transact.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_transact.edition ));
      params( 3 ) := "+"( Integer'Pos( a_transact.year ));
      params( 4 ) := As_Bigint( a_transact.sernum );
      params( 5 ) := "+"( Integer'Pos( a_transact.key1 ));
      params( 6 ) := "+"( Integer'Pos( a_transact.key2 ));
      params( 7 ) := "+"( Integer'Pos( a_transact.key3 ));
      params( 8 ) := "+"( Integer'Pos( a_transact.key4 ));
      params( 9 ) := "+"( Integer'Pos( a_transact.key5 ));
      params( 10 ) := "+"( aliased_frstable'Access );
      params( 11 ) := "+"( aliased_frsvar'Access );
      params( 12 ) := "+"( Float( a_transact.old_val ));
      params( 13 ) := "+"( Float( a_transact.new_val ));
      params( 14 ) := "+"( a_transact.datetime );
      params( 15 ) := "+"( a_transact.appldate );
      params( 16 ) := "+"( Integer'Pos( a_transact.batch ));
      params( 17 ) := "+"( aliased_trantype'Access );
      params( 18 ) := "+"( Integer'Pos( a_transact.reason ));
      params( 19 ) := "+"( Integer'Pos( a_transact.rowid ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Transact
   --

   procedure Delete( a_transact : in out Ukds.Frs.Transact; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_transact.user_id );
      Add_edition( c, a_transact.edition );
      Add_year( c, a_transact.year );
      Add_sernum( c, a_transact.sernum );
      Add_rowid( c, a_transact.rowid );
      Delete( c, connection );
      a_transact := Ukds.Frs.Null_Transact;
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


   procedure Add_key1( c : in out d.Criteria; key1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "key1", op, join, key1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_key1;


   procedure Add_key2( c : in out d.Criteria; key2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "key2", op, join, key2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_key2;


   procedure Add_key3( c : in out d.Criteria; key3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "key3", op, join, key3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_key3;


   procedure Add_key4( c : in out d.Criteria; key4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "key4", op, join, key4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_key4;


   procedure Add_key5( c : in out d.Criteria; key5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "key5", op, join, key5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_key5;


   procedure Add_frstable( c : in out d.Criteria; frstable : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frstable", op, join, To_String( frstable ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_frstable;


   procedure Add_frstable( c : in out d.Criteria; frstable : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frstable", op, join, frstable );
   begin
      d.add_to_criteria( c, elem );
   end Add_frstable;


   procedure Add_frsvar( c : in out d.Criteria; frsvar : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frsvar", op, join, To_String( frsvar ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_frsvar;


   procedure Add_frsvar( c : in out d.Criteria; frsvar : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frsvar", op, join, frsvar );
   begin
      d.add_to_criteria( c, elem );
   end Add_frsvar;


   procedure Add_old_val( c : in out d.Criteria; old_val : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "old_val", op, join, Long_Float( old_val ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_old_val;


   procedure Add_new_val( c : in out d.Criteria; new_val : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "new_val", op, join, Long_Float( new_val ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_new_val;


   procedure Add_datetime( c : in out d.Criteria; datetime : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "datetime", op, join, Ada.Calendar.Time( datetime ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_datetime;


   procedure Add_appldate( c : in out d.Criteria; appldate : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "appldate", op, join, Ada.Calendar.Time( appldate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_appldate;


   procedure Add_batch( c : in out d.Criteria; batch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "batch", op, join, batch );
   begin
      d.add_to_criteria( c, elem );
   end Add_batch;


   procedure Add_trantype( c : in out d.Criteria; trantype : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trantype", op, join, To_String( trantype ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_trantype;


   procedure Add_trantype( c : in out d.Criteria; trantype : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trantype", op, join, trantype );
   begin
      d.add_to_criteria( c, elem );
   end Add_trantype;


   procedure Add_reason( c : in out d.Criteria; reason : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "reason", op, join, reason );
   begin
      d.add_to_criteria( c, elem );
   end Add_reason;


   procedure Add_rowid( c : in out d.Criteria; rowid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rowid", op, join, rowid );
   begin
      d.add_to_criteria( c, elem );
   end Add_rowid;


   
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


   procedure Add_key1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "key1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_key1_To_Orderings;


   procedure Add_key2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "key2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_key2_To_Orderings;


   procedure Add_key3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "key3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_key3_To_Orderings;


   procedure Add_key4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "key4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_key4_To_Orderings;


   procedure Add_key5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "key5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_key5_To_Orderings;


   procedure Add_frstable_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frstable", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frstable_To_Orderings;


   procedure Add_frsvar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frsvar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frsvar_To_Orderings;


   procedure Add_old_val_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "old_val", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_old_val_To_Orderings;


   procedure Add_new_val_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "new_val", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_new_val_To_Orderings;


   procedure Add_datetime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "datetime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_datetime_To_Orderings;


   procedure Add_appldate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "appldate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_appldate_To_Orderings;


   procedure Add_batch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "batch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_batch_To_Orderings;


   procedure Add_trantype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trantype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trantype_To_Orderings;


   procedure Add_reason_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "reason", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_reason_To_Orderings;


   procedure Add_rowid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rowid", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rowid_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Transact_IO;
