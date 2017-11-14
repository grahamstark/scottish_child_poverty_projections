--
-- Created by ada_generator.py on 2017-11-14 11:49:20.082718
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

package body Ukds.Frs.Owner_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.OWNER_IO" );
   
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
         "user_id, edition, year, counter, sernum, buyyear, othmort1, othmort2, othmort3, othpur1," &
         "othpur2, othpur3, othpur31, othpur32, othpur33, othpur34, othpur35, othpur36, othpur37, othpur4," &
         "othpur5, othpur6, othpur7, purcamt, purcloan, month, issue " &
         " from frs.owner " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.owner (" &
         "user_id, edition, year, counter, sernum, buyyear, othmort1, othmort2, othmort3, othpur1," &
         "othpur2, othpur3, othpur31, othpur32, othpur33, othpur34, othpur35, othpur36, othpur37, othpur4," &
         "othpur5, othpur6, othpur7, purcamt, purcloan, month, issue " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.owner ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.owner set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 27 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : buyyear (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : othmort1 (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : othmort2 (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : othmort3 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : othpur1 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : othpur2 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : othpur3 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : othpur31 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : othpur32 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : othpur33 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : othpur34 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : othpur35 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : othpur36 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : othpur37 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : othpur4 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : othpur5 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : othpur6 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : othpur7 (Integer)
           19 => ( Parameter_Float, 0.0 ),   --  : purcamt (Amount)
           20 => ( Parameter_Integer, 0 ),   --  : purcloan (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
           27 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : buyyear (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : othmort1 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : othmort2 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : othmort3 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : othpur1 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : othpur2 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : othpur3 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : othpur31 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : othpur32 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : othpur33 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : othpur34 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : othpur35 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : othpur36 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : othpur37 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : othpur4 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : othpur5 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : othpur6 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : othpur7 (Integer)
           24 => ( Parameter_Float, 0.0 ),   --  : purcamt (Amount)
           25 => ( Parameter_Integer, 0 ),   --  : purcloan (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           27 => ( Parameter_Integer, 0 )   --  : issue (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27 )"; 
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
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " buyyear = $1, othmort1 = $2, othmort2 = $3, othmort3 = $4, othpur1 = $5, othpur2 = $6, othpur3 = $7, othpur31 = $8, othpur32 = $9, othpur33 = $10, othpur34 = $11, othpur35 = $12, othpur36 = $13, othpur37 = $14, othpur4 = $15, othpur5 = $16, othpur6 = $17, othpur7 = $18, purcamt = $19, purcloan = $20, month = $21, issue = $22 where user_id = $23 and edition = $24 and year = $25 and counter = $26 and sernum = $27"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.owner", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.owner", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.owner", SCHEMA_NAME );
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


   Next_Free_counter_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( counter ) + 1, 1 ) from frs.owner", SCHEMA_NAME );
   Next_Free_counter_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_counter_query, On_Server => True );
   -- 
   -- Next highest avaiable value of counter - useful for saving  
   --
   function Next_Free_counter( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_counter_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_counter;


   Next_Free_sernum_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.owner", SCHEMA_NAME );
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



   --
   -- returns true if the primary key parts of Ukds.Frs.Owner match the defaults in Ukds.Frs.Null_Owner
   --
   --
   -- Does this Ukds.Frs.Owner equal the default Ukds.Frs.Null_Owner ?
   --
   function Is_Null( a_owner : Owner ) return Boolean is
   begin
      return a_owner = Ukds.Frs.Null_Owner;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Owner matching the primary key fields, or the Ukds.Frs.Null_Owner record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Owner is
      l : Ukds.Frs.Owner_List;
      a_owner : Ukds.Frs.Owner;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_counter( c, counter );
      Add_sernum( c, sernum );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Owner_List_Package.is_empty( l ) ) then
         a_owner := Ukds.Frs.Owner_List_Package.First_Element( l );
      else
         a_owner := Ukds.Frs.Null_Owner;
      end if;
      return a_owner;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.owner where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean  is
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
      params( 4 ) := "+"( Integer'Pos( counter ));
      params( 5 ) := As_Bigint( sernum );
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Owner matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Owner_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Owner retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Owner is
      a_owner : Ukds.Frs.Owner;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_owner.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_owner.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_owner.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_owner.counter := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_owner.sernum := Sernum_Value'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_owner.buyyear := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_owner.othmort1 := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_owner.othmort2 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_owner.othmort3 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_owner.othpur1 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_owner.othpur2 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_owner.othpur3 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_owner.othpur31 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_owner.othpur32 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_owner.othpur33 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_owner.othpur34 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_owner.othpur35 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_owner.othpur36 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_owner.othpur37 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_owner.othpur4 := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_owner.othpur5 := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_owner.othpur6 := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_owner.othpur7 := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_owner.purcamt:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_owner.purcloan := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_owner.month := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_owner.issue := gse.Integer_Value( cursor, 26 );
      end if;
      return a_owner;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Owner_List is
      l : Ukds.Frs.Owner_List;
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
            a_owner : Ukds.Frs.Owner := Map_From_Cursor( cursor );
         begin
            l.append( a_owner ); 
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
   
   procedure Update( a_owner : Ukds.Frs.Owner; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_owner.buyyear ));
      params( 2 ) := "+"( Integer'Pos( a_owner.othmort1 ));
      params( 3 ) := "+"( Integer'Pos( a_owner.othmort2 ));
      params( 4 ) := "+"( Integer'Pos( a_owner.othmort3 ));
      params( 5 ) := "+"( Integer'Pos( a_owner.othpur1 ));
      params( 6 ) := "+"( Integer'Pos( a_owner.othpur2 ));
      params( 7 ) := "+"( Integer'Pos( a_owner.othpur3 ));
      params( 8 ) := "+"( Integer'Pos( a_owner.othpur31 ));
      params( 9 ) := "+"( Integer'Pos( a_owner.othpur32 ));
      params( 10 ) := "+"( Integer'Pos( a_owner.othpur33 ));
      params( 11 ) := "+"( Integer'Pos( a_owner.othpur34 ));
      params( 12 ) := "+"( Integer'Pos( a_owner.othpur35 ));
      params( 13 ) := "+"( Integer'Pos( a_owner.othpur36 ));
      params( 14 ) := "+"( Integer'Pos( a_owner.othpur37 ));
      params( 15 ) := "+"( Integer'Pos( a_owner.othpur4 ));
      params( 16 ) := "+"( Integer'Pos( a_owner.othpur5 ));
      params( 17 ) := "+"( Integer'Pos( a_owner.othpur6 ));
      params( 18 ) := "+"( Integer'Pos( a_owner.othpur7 ));
      params( 19 ) := "+"( Float( a_owner.purcamt ));
      params( 20 ) := "+"( Integer'Pos( a_owner.purcloan ));
      params( 21 ) := "+"( Integer'Pos( a_owner.month ));
      params( 22 ) := "+"( Integer'Pos( a_owner.issue ));
      params( 23 ) := "+"( Integer'Pos( a_owner.user_id ));
      params( 24 ) := "+"( Integer'Pos( a_owner.edition ));
      params( 25 ) := "+"( Integer'Pos( a_owner.year ));
      params( 26 ) := "+"( Integer'Pos( a_owner.counter ));
      params( 27 ) := As_Bigint( a_owner.sernum );
      
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

   procedure Save( a_owner : Ukds.Frs.Owner; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_owner.user_id, a_owner.edition, a_owner.year, a_owner.counter, a_owner.sernum ) then
         Update( a_owner, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_owner.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_owner.edition ));
      params( 3 ) := "+"( Integer'Pos( a_owner.year ));
      params( 4 ) := "+"( Integer'Pos( a_owner.counter ));
      params( 5 ) := As_Bigint( a_owner.sernum );
      params( 6 ) := "+"( Integer'Pos( a_owner.buyyear ));
      params( 7 ) := "+"( Integer'Pos( a_owner.othmort1 ));
      params( 8 ) := "+"( Integer'Pos( a_owner.othmort2 ));
      params( 9 ) := "+"( Integer'Pos( a_owner.othmort3 ));
      params( 10 ) := "+"( Integer'Pos( a_owner.othpur1 ));
      params( 11 ) := "+"( Integer'Pos( a_owner.othpur2 ));
      params( 12 ) := "+"( Integer'Pos( a_owner.othpur3 ));
      params( 13 ) := "+"( Integer'Pos( a_owner.othpur31 ));
      params( 14 ) := "+"( Integer'Pos( a_owner.othpur32 ));
      params( 15 ) := "+"( Integer'Pos( a_owner.othpur33 ));
      params( 16 ) := "+"( Integer'Pos( a_owner.othpur34 ));
      params( 17 ) := "+"( Integer'Pos( a_owner.othpur35 ));
      params( 18 ) := "+"( Integer'Pos( a_owner.othpur36 ));
      params( 19 ) := "+"( Integer'Pos( a_owner.othpur37 ));
      params( 20 ) := "+"( Integer'Pos( a_owner.othpur4 ));
      params( 21 ) := "+"( Integer'Pos( a_owner.othpur5 ));
      params( 22 ) := "+"( Integer'Pos( a_owner.othpur6 ));
      params( 23 ) := "+"( Integer'Pos( a_owner.othpur7 ));
      params( 24 ) := "+"( Float( a_owner.purcamt ));
      params( 25 ) := "+"( Integer'Pos( a_owner.purcloan ));
      params( 26 ) := "+"( Integer'Pos( a_owner.month ));
      params( 27 ) := "+"( Integer'Pos( a_owner.issue ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Owner
   --

   procedure Delete( a_owner : in out Ukds.Frs.Owner; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_owner.user_id );
      Add_edition( c, a_owner.edition );
      Add_year( c, a_owner.year );
      Add_counter( c, a_owner.counter );
      Add_sernum( c, a_owner.sernum );
      Delete( c, connection );
      a_owner := Ukds.Frs.Null_Owner;
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


   procedure Add_counter( c : in out d.Criteria; counter : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "counter", op, join, counter );
   begin
      d.add_to_criteria( c, elem );
   end Add_counter;


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   procedure Add_buyyear( c : in out d.Criteria; buyyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buyyear", op, join, buyyear );
   begin
      d.add_to_criteria( c, elem );
   end Add_buyyear;


   procedure Add_othmort1( c : in out d.Criteria; othmort1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othmort1", op, join, othmort1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othmort1;


   procedure Add_othmort2( c : in out d.Criteria; othmort2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othmort2", op, join, othmort2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othmort2;


   procedure Add_othmort3( c : in out d.Criteria; othmort3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othmort3", op, join, othmort3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othmort3;


   procedure Add_othpur1( c : in out d.Criteria; othpur1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur1", op, join, othpur1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur1;


   procedure Add_othpur2( c : in out d.Criteria; othpur2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur2", op, join, othpur2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur2;


   procedure Add_othpur3( c : in out d.Criteria; othpur3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur3", op, join, othpur3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur3;


   procedure Add_othpur31( c : in out d.Criteria; othpur31 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur31", op, join, othpur31 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur31;


   procedure Add_othpur32( c : in out d.Criteria; othpur32 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur32", op, join, othpur32 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur32;


   procedure Add_othpur33( c : in out d.Criteria; othpur33 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur33", op, join, othpur33 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur33;


   procedure Add_othpur34( c : in out d.Criteria; othpur34 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur34", op, join, othpur34 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur34;


   procedure Add_othpur35( c : in out d.Criteria; othpur35 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur35", op, join, othpur35 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur35;


   procedure Add_othpur36( c : in out d.Criteria; othpur36 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur36", op, join, othpur36 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur36;


   procedure Add_othpur37( c : in out d.Criteria; othpur37 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur37", op, join, othpur37 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur37;


   procedure Add_othpur4( c : in out d.Criteria; othpur4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur4", op, join, othpur4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur4;


   procedure Add_othpur5( c : in out d.Criteria; othpur5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur5", op, join, othpur5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur5;


   procedure Add_othpur6( c : in out d.Criteria; othpur6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur6", op, join, othpur6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur6;


   procedure Add_othpur7( c : in out d.Criteria; othpur7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpur7", op, join, othpur7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur7;


   procedure Add_purcamt( c : in out d.Criteria; purcamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "purcamt", op, join, Long_Float( purcamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_purcamt;


   procedure Add_purcloan( c : in out d.Criteria; purcloan : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "purcloan", op, join, purcloan );
   begin
      d.add_to_criteria( c, elem );
   end Add_purcloan;


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


   procedure Add_counter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "counter", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_counter_To_Orderings;


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;


   procedure Add_buyyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buyyear", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buyyear_To_Orderings;


   procedure Add_othmort1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othmort1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othmort1_To_Orderings;


   procedure Add_othmort2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othmort2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othmort2_To_Orderings;


   procedure Add_othmort3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othmort3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othmort3_To_Orderings;


   procedure Add_othpur1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur1_To_Orderings;


   procedure Add_othpur2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur2_To_Orderings;


   procedure Add_othpur3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur3_To_Orderings;


   procedure Add_othpur31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur31", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur31_To_Orderings;


   procedure Add_othpur32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur32", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur32_To_Orderings;


   procedure Add_othpur33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur33", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur33_To_Orderings;


   procedure Add_othpur34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur34", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur34_To_Orderings;


   procedure Add_othpur35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur35", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur35_To_Orderings;


   procedure Add_othpur36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur36", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur36_To_Orderings;


   procedure Add_othpur37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur37", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur37_To_Orderings;


   procedure Add_othpur4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur4_To_Orderings;


   procedure Add_othpur5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur5_To_Orderings;


   procedure Add_othpur6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur6_To_Orderings;


   procedure Add_othpur7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpur7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpur7_To_Orderings;


   procedure Add_purcamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "purcamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_purcamt_To_Orderings;


   procedure Add_purcloan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "purcloan", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_purcloan_To_Orderings;


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

end Ukds.Frs.Owner_IO;
