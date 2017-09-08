--
-- Created by ada_generator.py on 2017-09-07 21:05:09.543493
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

package body Ukds.Frs.Penprov_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.PENPROV_IO" );
   
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
         "user_id, edition, year, counter, sernum, benunit, person, stemppay, provseq, eplong," &
         "eptype, keeppen, opgov, penamt, penamtpd, pencon, pendat, pengov, penhelp, penmort," &
         "spwho, month, stemppen, penreb, rebgov, issue, penamtdt, penchk " &
         " from frs.penprov " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.penprov (" &
         "user_id, edition, year, counter, sernum, benunit, person, stemppay, provseq, eplong," &
         "eptype, keeppen, opgov, penamt, penamtpd, pencon, pendat, pengov, penhelp, penmort," &
         "spwho, month, stemppen, penreb, rebgov, issue, penamtdt, penchk " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.penprov ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.penprov set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 28 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : stemppay (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : eplong (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : eptype (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : keeppen (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : opgov (Integer)
            6 => ( Parameter_Float, 0.0 ),   --  : penamt (Amount)
            7 => ( Parameter_Integer, 0 ),   --  : penamtpd (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : pencon (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : pendat (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : pengov (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : penhelp (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : penmort (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : spwho (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : stemppen (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : penreb (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : rebgov (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           19 => ( Parameter_Date, Clock ),   --  : penamtdt (Ada.Calendar.Time)
           20 => ( Parameter_Integer, 0 ),   --  : penchk (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
           25 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           26 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           28 => ( Parameter_Integer, 0 )   --  : provseq (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : stemppay (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : provseq (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : eplong (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : eptype (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : keeppen (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : opgov (Integer)
           14 => ( Parameter_Float, 0.0 ),   --  : penamt (Amount)
           15 => ( Parameter_Integer, 0 ),   --  : penamtpd (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : pencon (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : pendat (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : pengov (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : penhelp (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : penmort (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : spwho (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : stemppen (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : penreb (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : rebgov (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           27 => ( Parameter_Date, Clock ),   --  : penamtdt (Ada.Calendar.Time)
           28 => ( Parameter_Integer, 0 )   --  : penchk (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28 )"; 
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
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            8 => ( Parameter_Integer, 0 )   --  : provseq (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6 and person = $7 and provseq = $8"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " stemppay = $1, eplong = $2, eptype = $3, keeppen = $4, opgov = $5, penamt = $6, penamtpd = $7, pencon = $8, pendat = $9, pengov = $10, penhelp = $11, penmort = $12, spwho = $13, month = $14, stemppen = $15, penreb = $16, rebgov = $17, issue = $18, penamtdt = $19, penchk = $20 where user_id = $21 and edition = $22 and year = $23 and counter = $24 and sernum = $25 and benunit = $26 and person = $27 and provseq = $28"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( counter ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
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


   Next_Free_provseq_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( provseq ) + 1, 1 ) from frs.penprov", SCHEMA_NAME );
   Next_Free_provseq_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_provseq_query, On_Server => True );
   -- 
   -- Next highest avaiable value of provseq - useful for saving  
   --
   function Next_Free_provseq( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_provseq_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_provseq;



   --
   -- returns true if the primary key parts of Ukds.Frs.Penprov match the defaults in Ukds.Frs.Null_Penprov
   --
   --
   -- Does this Ukds.Frs.Penprov equal the default Ukds.Frs.Null_Penprov ?
   --
   function Is_Null( a_penprov : Penprov ) return Boolean is
   begin
      return a_penprov = Ukds.Frs.Null_Penprov;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Penprov matching the primary key fields, or the Ukds.Frs.Null_Penprov record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; provseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Penprov is
      l : Ukds.Frs.Penprov_List;
      a_penprov : Ukds.Frs.Penprov;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_counter( c, counter );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_provseq( c, provseq );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Penprov_List_Package.is_empty( l ) ) then
         a_penprov := Ukds.Frs.Penprov_List_Package.First_Element( l );
      else
         a_penprov := Ukds.Frs.Null_Penprov;
      end if;
      return a_penprov;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.penprov where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6 and person = $7 and provseq = $8", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; provseq : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 6 ) := "+"( Integer'Pos( benunit ));
      params( 7 ) := "+"( Integer'Pos( person ));
      params( 8 ) := "+"( Integer'Pos( provseq ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Penprov matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Penprov retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Penprov is
      a_penprov : Ukds.Frs.Penprov;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_penprov.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_penprov.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_penprov.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_penprov.counter := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_penprov.sernum := Sernum_Value'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_penprov.benunit := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_penprov.person := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_penprov.stemppay := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_penprov.provseq := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_penprov.eplong := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_penprov.eptype := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_penprov.keeppen := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_penprov.opgov := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_penprov.penamt:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_penprov.penamtpd := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_penprov.pencon := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_penprov.pendat := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_penprov.pengov := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_penprov.penhelp := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_penprov.penmort := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_penprov.spwho := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_penprov.month := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_penprov.stemppen := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_penprov.penreb := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_penprov.rebgov := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_penprov.issue := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_penprov.penamtdt := gse.Time_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_penprov.penchk := gse.Integer_Value( cursor, 27 );
      end if;
      return a_penprov;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List is
      l : Ukds.Frs.Penprov_List;
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
            a_penprov : Ukds.Frs.Penprov := Map_From_Cursor( cursor );
         begin
            l.append( a_penprov ); 
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
   
   procedure Update( a_penprov : Ukds.Frs.Penprov; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_penprov.stemppay ));
      params( 2 ) := "+"( Integer'Pos( a_penprov.eplong ));
      params( 3 ) := "+"( Integer'Pos( a_penprov.eptype ));
      params( 4 ) := "+"( Integer'Pos( a_penprov.keeppen ));
      params( 5 ) := "+"( Integer'Pos( a_penprov.opgov ));
      params( 6 ) := "+"( Float( a_penprov.penamt ));
      params( 7 ) := "+"( Integer'Pos( a_penprov.penamtpd ));
      params( 8 ) := "+"( Integer'Pos( a_penprov.pencon ));
      params( 9 ) := "+"( Integer'Pos( a_penprov.pendat ));
      params( 10 ) := "+"( Integer'Pos( a_penprov.pengov ));
      params( 11 ) := "+"( Integer'Pos( a_penprov.penhelp ));
      params( 12 ) := "+"( Integer'Pos( a_penprov.penmort ));
      params( 13 ) := "+"( Integer'Pos( a_penprov.spwho ));
      params( 14 ) := "+"( Integer'Pos( a_penprov.month ));
      params( 15 ) := "+"( Integer'Pos( a_penprov.stemppen ));
      params( 16 ) := "+"( Integer'Pos( a_penprov.penreb ));
      params( 17 ) := "+"( Integer'Pos( a_penprov.rebgov ));
      params( 18 ) := "+"( Integer'Pos( a_penprov.issue ));
      params( 19 ) := "+"( a_penprov.penamtdt );
      params( 20 ) := "+"( Integer'Pos( a_penprov.penchk ));
      params( 21 ) := "+"( Integer'Pos( a_penprov.user_id ));
      params( 22 ) := "+"( Integer'Pos( a_penprov.edition ));
      params( 23 ) := "+"( Integer'Pos( a_penprov.year ));
      params( 24 ) := "+"( Integer'Pos( a_penprov.counter ));
      params( 25 ) := As_Bigint( a_penprov.sernum );
      params( 26 ) := "+"( Integer'Pos( a_penprov.benunit ));
      params( 27 ) := "+"( Integer'Pos( a_penprov.person ));
      params( 28 ) := "+"( Integer'Pos( a_penprov.provseq ));
      
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

   procedure Save( a_penprov : Ukds.Frs.Penprov; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_penprov.user_id, a_penprov.edition, a_penprov.year, a_penprov.counter, a_penprov.sernum, a_penprov.benunit, a_penprov.person, a_penprov.provseq ) then
         Update( a_penprov, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_penprov.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_penprov.edition ));
      params( 3 ) := "+"( Integer'Pos( a_penprov.year ));
      params( 4 ) := "+"( Integer'Pos( a_penprov.counter ));
      params( 5 ) := As_Bigint( a_penprov.sernum );
      params( 6 ) := "+"( Integer'Pos( a_penprov.benunit ));
      params( 7 ) := "+"( Integer'Pos( a_penprov.person ));
      params( 8 ) := "+"( Integer'Pos( a_penprov.stemppay ));
      params( 9 ) := "+"( Integer'Pos( a_penprov.provseq ));
      params( 10 ) := "+"( Integer'Pos( a_penprov.eplong ));
      params( 11 ) := "+"( Integer'Pos( a_penprov.eptype ));
      params( 12 ) := "+"( Integer'Pos( a_penprov.keeppen ));
      params( 13 ) := "+"( Integer'Pos( a_penprov.opgov ));
      params( 14 ) := "+"( Float( a_penprov.penamt ));
      params( 15 ) := "+"( Integer'Pos( a_penprov.penamtpd ));
      params( 16 ) := "+"( Integer'Pos( a_penprov.pencon ));
      params( 17 ) := "+"( Integer'Pos( a_penprov.pendat ));
      params( 18 ) := "+"( Integer'Pos( a_penprov.pengov ));
      params( 19 ) := "+"( Integer'Pos( a_penprov.penhelp ));
      params( 20 ) := "+"( Integer'Pos( a_penprov.penmort ));
      params( 21 ) := "+"( Integer'Pos( a_penprov.spwho ));
      params( 22 ) := "+"( Integer'Pos( a_penprov.month ));
      params( 23 ) := "+"( Integer'Pos( a_penprov.stemppen ));
      params( 24 ) := "+"( Integer'Pos( a_penprov.penreb ));
      params( 25 ) := "+"( Integer'Pos( a_penprov.rebgov ));
      params( 26 ) := "+"( Integer'Pos( a_penprov.issue ));
      params( 27 ) := "+"( a_penprov.penamtdt );
      params( 28 ) := "+"( Integer'Pos( a_penprov.penchk ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Penprov
   --

   procedure Delete( a_penprov : in out Ukds.Frs.Penprov; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_penprov.user_id );
      Add_edition( c, a_penprov.edition );
      Add_year( c, a_penprov.year );
      Add_counter( c, a_penprov.counter );
      Add_sernum( c, a_penprov.sernum );
      Add_benunit( c, a_penprov.benunit );
      Add_person( c, a_penprov.person );
      Add_provseq( c, a_penprov.provseq );
      Delete( c, connection );
      a_penprov := Ukds.Frs.Null_Penprov;
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


   procedure Add_stemppay( c : in out d.Criteria; stemppay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stemppay", op, join, stemppay );
   begin
      d.add_to_criteria( c, elem );
   end Add_stemppay;


   procedure Add_provseq( c : in out d.Criteria; provseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "provseq", op, join, provseq );
   begin
      d.add_to_criteria( c, elem );
   end Add_provseq;


   procedure Add_eplong( c : in out d.Criteria; eplong : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eplong", op, join, eplong );
   begin
      d.add_to_criteria( c, elem );
   end Add_eplong;


   procedure Add_eptype( c : in out d.Criteria; eptype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eptype", op, join, eptype );
   begin
      d.add_to_criteria( c, elem );
   end Add_eptype;


   procedure Add_keeppen( c : in out d.Criteria; keeppen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "keeppen", op, join, keeppen );
   begin
      d.add_to_criteria( c, elem );
   end Add_keeppen;


   procedure Add_opgov( c : in out d.Criteria; opgov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "opgov", op, join, opgov );
   begin
      d.add_to_criteria( c, elem );
   end Add_opgov;


   procedure Add_penamt( c : in out d.Criteria; penamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penamt", op, join, Long_Float( penamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_penamt;


   procedure Add_penamtpd( c : in out d.Criteria; penamtpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penamtpd", op, join, penamtpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_penamtpd;


   procedure Add_pencon( c : in out d.Criteria; pencon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pencon", op, join, pencon );
   begin
      d.add_to_criteria( c, elem );
   end Add_pencon;


   procedure Add_pendat( c : in out d.Criteria; pendat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pendat", op, join, pendat );
   begin
      d.add_to_criteria( c, elem );
   end Add_pendat;


   procedure Add_pengov( c : in out d.Criteria; pengov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pengov", op, join, pengov );
   begin
      d.add_to_criteria( c, elem );
   end Add_pengov;


   procedure Add_penhelp( c : in out d.Criteria; penhelp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penhelp", op, join, penhelp );
   begin
      d.add_to_criteria( c, elem );
   end Add_penhelp;


   procedure Add_penmort( c : in out d.Criteria; penmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penmort", op, join, penmort );
   begin
      d.add_to_criteria( c, elem );
   end Add_penmort;


   procedure Add_spwho( c : in out d.Criteria; spwho : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spwho", op, join, spwho );
   begin
      d.add_to_criteria( c, elem );
   end Add_spwho;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_stemppen( c : in out d.Criteria; stemppen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stemppen", op, join, stemppen );
   begin
      d.add_to_criteria( c, elem );
   end Add_stemppen;


   procedure Add_penreb( c : in out d.Criteria; penreb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penreb", op, join, penreb );
   begin
      d.add_to_criteria( c, elem );
   end Add_penreb;


   procedure Add_rebgov( c : in out d.Criteria; rebgov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rebgov", op, join, rebgov );
   begin
      d.add_to_criteria( c, elem );
   end Add_rebgov;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_penamtdt( c : in out d.Criteria; penamtdt : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penamtdt", op, join, Ada.Calendar.Time( penamtdt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_penamtdt;


   procedure Add_penchk( c : in out d.Criteria; penchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penchk", op, join, penchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_penchk;


   
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


   procedure Add_stemppay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stemppay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stemppay_To_Orderings;


   procedure Add_provseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "provseq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_provseq_To_Orderings;


   procedure Add_eplong_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eplong", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eplong_To_Orderings;


   procedure Add_eptype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eptype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eptype_To_Orderings;


   procedure Add_keeppen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "keeppen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_keeppen_To_Orderings;


   procedure Add_opgov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "opgov", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_opgov_To_Orderings;


   procedure Add_penamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penamt_To_Orderings;


   procedure Add_penamtpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penamtpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penamtpd_To_Orderings;


   procedure Add_pencon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pencon", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pencon_To_Orderings;


   procedure Add_pendat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pendat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pendat_To_Orderings;


   procedure Add_pengov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pengov", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pengov_To_Orderings;


   procedure Add_penhelp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penhelp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penhelp_To_Orderings;


   procedure Add_penmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penmort", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penmort_To_Orderings;


   procedure Add_spwho_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spwho", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spwho_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_stemppen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stemppen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stemppen_To_Orderings;


   procedure Add_penreb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penreb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penreb_To_Orderings;


   procedure Add_rebgov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rebgov", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rebgov_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_penamtdt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penamtdt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penamtdt_To_Orderings;


   procedure Add_penchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penchk_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Penprov_IO;
