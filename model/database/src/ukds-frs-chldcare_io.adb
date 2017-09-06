--
-- Created by ada_generator.py on 2017-09-06 17:20:41.924345
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

package body Ukds.Frs.Chldcare_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.CHLDCARE_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, chlook, benccdis, chamt, chfar," &
         "chhr, chinknd1, chinknd2, chinknd3, chinknd4, chinknd5, chpd, cost, ctrm, emplprov," &
         "registrd, month, pmchk, issue, hourly, freecc, freccty1, freccty2, freccty3, freccty4," &
         "freccty5, freccty6 " &
         " from frs.chldcare " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.chldcare (" &
         "user_id, edition, year, sernum, benunit, person, chlook, benccdis, chamt, chfar," &
         "chhr, chinknd1, chinknd2, chinknd3, chinknd4, chinknd5, chpd, cost, ctrm, emplprov," &
         "registrd, month, pmchk, issue, hourly, freecc, freccty1, freccty2, freccty3, freccty4," &
         "freccty5, freccty6 " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.chldcare ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.chldcare set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 32 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : benccdis (Integer)
            2 => ( Parameter_Float, 0.0 ),   --  : chamt (Amount)
            3 => ( Parameter_Integer, 0 ),   --  : chfar (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : chhr (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : chinknd1 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : chinknd2 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : chinknd3 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : chinknd4 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : chinknd5 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : chpd (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : cost (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : ctrm (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : emplprov (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : registrd (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : pmchk (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : hourly (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : freecc (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : freccty1 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : freccty2 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : freccty3 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : freccty4 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : freccty5 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : freccty6 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           29 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           30 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           32 => ( Parameter_Integer, 0 )   --  : chlook (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : chlook (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : benccdis (Integer)
            9 => ( Parameter_Float, 0.0 ),   --  : chamt (Amount)
           10 => ( Parameter_Integer, 0 ),   --  : chfar (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : chhr (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : chinknd1 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : chinknd2 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : chinknd3 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : chinknd4 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : chinknd5 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : chpd (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : cost (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : ctrm (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : emplprov (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : registrd (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : pmchk (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : hourly (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : freecc (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : freccty1 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : freccty2 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : freccty3 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : freccty4 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : freccty5 (Integer)
           32 => ( Parameter_Integer, 0 )   --  : freccty6 (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 7 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 )   --  : chlook (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and chlook = $7"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " benccdis = $1, chamt = $2, chfar = $3, chhr = $4, chinknd1 = $5, chinknd2 = $6, chinknd3 = $7, chinknd4 = $8, chinknd5 = $9, chpd = $10, cost = $11, ctrm = $12, emplprov = $13, registrd = $14, month = $15, pmchk = $16, issue = $17, hourly = $18, freecc = $19, freccty1 = $20, freccty2 = $21, freccty3 = $22, freccty4 = $23, freccty5 = $24, freccty6 = $25 where user_id = $26 and edition = $27 and year = $28 and sernum = $29 and benunit = $30 and person = $31 and chlook = $32"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
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


   Next_Free_chlook_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( chlook ) + 1, 1 ) from frs.chldcare", SCHEMA_NAME );
   Next_Free_chlook_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_chlook_query, On_Server => True );
   -- 
   -- Next highest avaiable value of chlook - useful for saving  
   --
   function Next_Free_chlook( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_chlook_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_chlook;



   --
   -- returns true if the primary key parts of Ukds.Frs.Chldcare match the defaults in Ukds.Frs.Null_Chldcare
   --
   --
   -- Does this Ukds.Frs.Chldcare equal the default Ukds.Frs.Null_Chldcare ?
   --
   function Is_Null( a_chldcare : Chldcare ) return Boolean is
   begin
      return a_chldcare = Ukds.Frs.Null_Chldcare;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Chldcare matching the primary key fields, or the Ukds.Frs.Null_Chldcare record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; chlook : Integer; connection : Database_Connection := null ) return Ukds.Frs.Chldcare is
      l : Ukds.Frs.Chldcare_List;
      a_chldcare : Ukds.Frs.Chldcare;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_chlook( c, chlook );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Chldcare_List_Package.is_empty( l ) ) then
         a_chldcare := Ukds.Frs.Chldcare_List_Package.First_Element( l );
      else
         a_chldcare := Ukds.Frs.Null_Chldcare;
      end if;
      return a_chldcare;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.chldcare where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and chlook = $7", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; chlook : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 7 ) := "+"( Integer'Pos( chlook ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Chldcare matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Chldcare retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Chldcare is
      a_chldcare : Ukds.Frs.Chldcare;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_chldcare.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_chldcare.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_chldcare.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_chldcare.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_chldcare.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_chldcare.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_chldcare.chlook := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_chldcare.benccdis := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_chldcare.chamt:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_chldcare.chfar := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_chldcare.chhr := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_chldcare.chinknd1 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_chldcare.chinknd2 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_chldcare.chinknd3 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_chldcare.chinknd4 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_chldcare.chinknd5 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_chldcare.chpd := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_chldcare.cost := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_chldcare.ctrm := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_chldcare.emplprov := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_chldcare.registrd := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_chldcare.month := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_chldcare.pmchk := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_chldcare.issue := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_chldcare.hourly := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_chldcare.freecc := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_chldcare.freccty1 := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_chldcare.freccty2 := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_chldcare.freccty3 := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_chldcare.freccty4 := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_chldcare.freccty5 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_chldcare.freccty6 := gse.Integer_Value( cursor, 31 );
      end if;
      return a_chldcare;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List is
      l : Ukds.Frs.Chldcare_List;
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
            a_chldcare : Ukds.Frs.Chldcare := Map_From_Cursor( cursor );
         begin
            l.append( a_chldcare ); 
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
   
   procedure Update( a_chldcare : Ukds.Frs.Chldcare; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_chldcare.benccdis ));
      params( 2 ) := "+"( Float( a_chldcare.chamt ));
      params( 3 ) := "+"( Integer'Pos( a_chldcare.chfar ));
      params( 4 ) := "+"( Integer'Pos( a_chldcare.chhr ));
      params( 5 ) := "+"( Integer'Pos( a_chldcare.chinknd1 ));
      params( 6 ) := "+"( Integer'Pos( a_chldcare.chinknd2 ));
      params( 7 ) := "+"( Integer'Pos( a_chldcare.chinknd3 ));
      params( 8 ) := "+"( Integer'Pos( a_chldcare.chinknd4 ));
      params( 9 ) := "+"( Integer'Pos( a_chldcare.chinknd5 ));
      params( 10 ) := "+"( Integer'Pos( a_chldcare.chpd ));
      params( 11 ) := "+"( Integer'Pos( a_chldcare.cost ));
      params( 12 ) := "+"( Integer'Pos( a_chldcare.ctrm ));
      params( 13 ) := "+"( Integer'Pos( a_chldcare.emplprov ));
      params( 14 ) := "+"( Integer'Pos( a_chldcare.registrd ));
      params( 15 ) := "+"( Integer'Pos( a_chldcare.month ));
      params( 16 ) := "+"( Integer'Pos( a_chldcare.pmchk ));
      params( 17 ) := "+"( Integer'Pos( a_chldcare.issue ));
      params( 18 ) := "+"( Integer'Pos( a_chldcare.hourly ));
      params( 19 ) := "+"( Integer'Pos( a_chldcare.freecc ));
      params( 20 ) := "+"( Integer'Pos( a_chldcare.freccty1 ));
      params( 21 ) := "+"( Integer'Pos( a_chldcare.freccty2 ));
      params( 22 ) := "+"( Integer'Pos( a_chldcare.freccty3 ));
      params( 23 ) := "+"( Integer'Pos( a_chldcare.freccty4 ));
      params( 24 ) := "+"( Integer'Pos( a_chldcare.freccty5 ));
      params( 25 ) := "+"( Integer'Pos( a_chldcare.freccty6 ));
      params( 26 ) := "+"( Integer'Pos( a_chldcare.user_id ));
      params( 27 ) := "+"( Integer'Pos( a_chldcare.edition ));
      params( 28 ) := "+"( Integer'Pos( a_chldcare.year ));
      params( 29 ) := As_Bigint( a_chldcare.sernum );
      params( 30 ) := "+"( Integer'Pos( a_chldcare.benunit ));
      params( 31 ) := "+"( Integer'Pos( a_chldcare.person ));
      params( 32 ) := "+"( Integer'Pos( a_chldcare.chlook ));
      
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

   procedure Save( a_chldcare : Ukds.Frs.Chldcare; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_chldcare.user_id, a_chldcare.edition, a_chldcare.year, a_chldcare.sernum, a_chldcare.benunit, a_chldcare.person, a_chldcare.chlook ) then
         Update( a_chldcare, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_chldcare.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_chldcare.edition ));
      params( 3 ) := "+"( Integer'Pos( a_chldcare.year ));
      params( 4 ) := As_Bigint( a_chldcare.sernum );
      params( 5 ) := "+"( Integer'Pos( a_chldcare.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_chldcare.person ));
      params( 7 ) := "+"( Integer'Pos( a_chldcare.chlook ));
      params( 8 ) := "+"( Integer'Pos( a_chldcare.benccdis ));
      params( 9 ) := "+"( Float( a_chldcare.chamt ));
      params( 10 ) := "+"( Integer'Pos( a_chldcare.chfar ));
      params( 11 ) := "+"( Integer'Pos( a_chldcare.chhr ));
      params( 12 ) := "+"( Integer'Pos( a_chldcare.chinknd1 ));
      params( 13 ) := "+"( Integer'Pos( a_chldcare.chinknd2 ));
      params( 14 ) := "+"( Integer'Pos( a_chldcare.chinknd3 ));
      params( 15 ) := "+"( Integer'Pos( a_chldcare.chinknd4 ));
      params( 16 ) := "+"( Integer'Pos( a_chldcare.chinknd5 ));
      params( 17 ) := "+"( Integer'Pos( a_chldcare.chpd ));
      params( 18 ) := "+"( Integer'Pos( a_chldcare.cost ));
      params( 19 ) := "+"( Integer'Pos( a_chldcare.ctrm ));
      params( 20 ) := "+"( Integer'Pos( a_chldcare.emplprov ));
      params( 21 ) := "+"( Integer'Pos( a_chldcare.registrd ));
      params( 22 ) := "+"( Integer'Pos( a_chldcare.month ));
      params( 23 ) := "+"( Integer'Pos( a_chldcare.pmchk ));
      params( 24 ) := "+"( Integer'Pos( a_chldcare.issue ));
      params( 25 ) := "+"( Integer'Pos( a_chldcare.hourly ));
      params( 26 ) := "+"( Integer'Pos( a_chldcare.freecc ));
      params( 27 ) := "+"( Integer'Pos( a_chldcare.freccty1 ));
      params( 28 ) := "+"( Integer'Pos( a_chldcare.freccty2 ));
      params( 29 ) := "+"( Integer'Pos( a_chldcare.freccty3 ));
      params( 30 ) := "+"( Integer'Pos( a_chldcare.freccty4 ));
      params( 31 ) := "+"( Integer'Pos( a_chldcare.freccty5 ));
      params( 32 ) := "+"( Integer'Pos( a_chldcare.freccty6 ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Chldcare
   --

   procedure Delete( a_chldcare : in out Ukds.Frs.Chldcare; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_chldcare.user_id );
      Add_edition( c, a_chldcare.edition );
      Add_year( c, a_chldcare.year );
      Add_sernum( c, a_chldcare.sernum );
      Add_benunit( c, a_chldcare.benunit );
      Add_person( c, a_chldcare.person );
      Add_chlook( c, a_chldcare.chlook );
      Delete( c, connection );
      a_chldcare := Ukds.Frs.Null_Chldcare;
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


   procedure Add_chlook( c : in out d.Criteria; chlook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook", op, join, chlook );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook;


   procedure Add_benccdis( c : in out d.Criteria; benccdis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benccdis", op, join, benccdis );
   begin
      d.add_to_criteria( c, elem );
   end Add_benccdis;


   procedure Add_chamt( c : in out d.Criteria; chamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamt", op, join, Long_Float( chamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt;


   procedure Add_chfar( c : in out d.Criteria; chfar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chfar", op, join, chfar );
   begin
      d.add_to_criteria( c, elem );
   end Add_chfar;


   procedure Add_chhr( c : in out d.Criteria; chhr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chhr", op, join, chhr );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr;


   procedure Add_chinknd1( c : in out d.Criteria; chinknd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chinknd1", op, join, chinknd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd1;


   procedure Add_chinknd2( c : in out d.Criteria; chinknd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chinknd2", op, join, chinknd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd2;


   procedure Add_chinknd3( c : in out d.Criteria; chinknd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chinknd3", op, join, chinknd3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd3;


   procedure Add_chinknd4( c : in out d.Criteria; chinknd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chinknd4", op, join, chinknd4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd4;


   procedure Add_chinknd5( c : in out d.Criteria; chinknd5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chinknd5", op, join, chinknd5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd5;


   procedure Add_chpd( c : in out d.Criteria; chpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chpd", op, join, chpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpd;


   procedure Add_cost( c : in out d.Criteria; cost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cost", op, join, cost );
   begin
      d.add_to_criteria( c, elem );
   end Add_cost;


   procedure Add_ctrm( c : in out d.Criteria; ctrm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctrm", op, join, ctrm );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctrm;


   procedure Add_emplprov( c : in out d.Criteria; emplprov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emplprov", op, join, emplprov );
   begin
      d.add_to_criteria( c, elem );
   end Add_emplprov;


   procedure Add_registrd( c : in out d.Criteria; registrd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "registrd", op, join, registrd );
   begin
      d.add_to_criteria( c, elem );
   end Add_registrd;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_pmchk( c : in out d.Criteria; pmchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pmchk", op, join, pmchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_pmchk;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_hourly( c : in out d.Criteria; hourly : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourly", op, join, hourly );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourly;


   procedure Add_freecc( c : in out d.Criteria; freecc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freecc", op, join, freecc );
   begin
      d.add_to_criteria( c, elem );
   end Add_freecc;


   procedure Add_freccty1( c : in out d.Criteria; freccty1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freccty1", op, join, freccty1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty1;


   procedure Add_freccty2( c : in out d.Criteria; freccty2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freccty2", op, join, freccty2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty2;


   procedure Add_freccty3( c : in out d.Criteria; freccty3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freccty3", op, join, freccty3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty3;


   procedure Add_freccty4( c : in out d.Criteria; freccty4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freccty4", op, join, freccty4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty4;


   procedure Add_freccty5( c : in out d.Criteria; freccty5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freccty5", op, join, freccty5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty5;


   procedure Add_freccty6( c : in out d.Criteria; freccty6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freccty6", op, join, freccty6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty6;


   
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


   procedure Add_chlook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook_To_Orderings;


   procedure Add_benccdis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benccdis", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benccdis_To_Orderings;


   procedure Add_chamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt_To_Orderings;


   procedure Add_chfar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chfar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chfar_To_Orderings;


   procedure Add_chhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chhr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr_To_Orderings;


   procedure Add_chinknd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chinknd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd1_To_Orderings;


   procedure Add_chinknd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chinknd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd2_To_Orderings;


   procedure Add_chinknd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chinknd3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd3_To_Orderings;


   procedure Add_chinknd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chinknd4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd4_To_Orderings;


   procedure Add_chinknd5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chinknd5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chinknd5_To_Orderings;


   procedure Add_chpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpd_To_Orderings;


   procedure Add_cost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cost", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cost_To_Orderings;


   procedure Add_ctrm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctrm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctrm_To_Orderings;


   procedure Add_emplprov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emplprov", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emplprov_To_Orderings;


   procedure Add_registrd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "registrd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_registrd_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_pmchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pmchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pmchk_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_hourly_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourly", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourly_To_Orderings;


   procedure Add_freecc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freecc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freecc_To_Orderings;


   procedure Add_freccty1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freccty1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty1_To_Orderings;


   procedure Add_freccty2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freccty2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty2_To_Orderings;


   procedure Add_freccty3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freccty3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty3_To_Orderings;


   procedure Add_freccty4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freccty4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty4_To_Orderings;


   procedure Add_freccty5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freccty5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty5_To_Orderings;


   procedure Add_freccty6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freccty6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freccty6_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Chldcare_IO;
