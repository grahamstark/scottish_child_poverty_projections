--
-- Created by ada_generator.py on 2017-10-19 12:07:30.203199
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

package body Ukds.Frs.Pension_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.PENSION_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, penseq, another, penoth, penpay," &
         "penpd, pentax, pentype, poamt, poinc, posour, ptamt, ptinc, trights, month," &
         "issue, penpd1, penpd2 " &
         " from frs.pension " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.pension (" &
         "user_id, edition, year, sernum, benunit, person, penseq, another, penoth, penpay," &
         "penpd, pentax, pentype, poamt, poinc, posour, ptamt, ptinc, trights, month," &
         "issue, penpd1, penpd2 " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.pension ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.pension set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 23 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : another (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : penoth (Integer)
            3 => ( Parameter_Float, 0.0 ),   --  : penpay (Amount)
            4 => ( Parameter_Integer, 0 ),   --  : penpd (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : pentax (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : pentype (Integer)
            7 => ( Parameter_Float, 0.0 ),   --  : poamt (Amount)
            8 => ( Parameter_Integer, 0 ),   --  : poinc (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : posour (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : ptamt (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : ptinc (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : trights (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : penpd1 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : penpd2 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           20 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           21 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           23 => ( Parameter_Integer, 0 )   --  : penseq (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : penseq (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : another (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : penoth (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : penpay (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : penpd (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : pentax (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : pentype (Integer)
           14 => ( Parameter_Float, 0.0 ),   --  : poamt (Amount)
           15 => ( Parameter_Integer, 0 ),   --  : poinc (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : posour (Integer)
           17 => ( Parameter_Float, 0.0 ),   --  : ptamt (Amount)
           18 => ( Parameter_Integer, 0 ),   --  : ptinc (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : trights (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : penpd1 (Integer)
           23 => ( Parameter_Integer, 0 )   --  : penpd2 (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23 )"; 
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
            7 => ( Parameter_Integer, 0 )   --  : penseq (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and penseq = $7"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " another = $1, penoth = $2, penpay = $3, penpd = $4, pentax = $5, pentype = $6, poamt = $7, poinc = $8, posour = $9, ptamt = $10, ptinc = $11, trights = $12, month = $13, issue = $14, penpd1 = $15, penpd2 = $16 where user_id = $17 and edition = $18 and year = $19 and sernum = $20 and benunit = $21 and person = $22 and penseq = $23"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
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


   Next_Free_penseq_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( penseq ) + 1, 1 ) from frs.pension", SCHEMA_NAME );
   Next_Free_penseq_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_penseq_query, On_Server => True );
   -- 
   -- Next highest avaiable value of penseq - useful for saving  
   --
   function Next_Free_penseq( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_penseq_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_penseq;



   --
   -- returns true if the primary key parts of Ukds.Frs.Pension match the defaults in Ukds.Frs.Null_Pension
   --
   --
   -- Does this Ukds.Frs.Pension equal the default Ukds.Frs.Null_Pension ?
   --
   function Is_Null( a_pension : Pension ) return Boolean is
   begin
      return a_pension = Ukds.Frs.Null_Pension;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Pension matching the primary key fields, or the Ukds.Frs.Null_Pension record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; penseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Pension is
      l : Ukds.Frs.Pension_List;
      a_pension : Ukds.Frs.Pension;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_penseq( c, penseq );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Pension_List_Package.is_empty( l ) ) then
         a_pension := Ukds.Frs.Pension_List_Package.First_Element( l );
      else
         a_pension := Ukds.Frs.Null_Pension;
      end if;
      return a_pension;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.pension where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and penseq = $7", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; penseq : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 7 ) := "+"( Integer'Pos( penseq ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Pension matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Pension_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Pension retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Pension is
      a_pension : Ukds.Frs.Pension;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_pension.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_pension.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_pension.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_pension.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_pension.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_pension.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_pension.penseq := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_pension.another := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_pension.penoth := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_pension.penpay:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_pension.penpd := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_pension.pentax := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_pension.pentype := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_pension.poamt:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_pension.poinc := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_pension.posour := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_pension.ptamt:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_pension.ptinc := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_pension.trights := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_pension.month := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_pension.issue := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_pension.penpd1 := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_pension.penpd2 := gse.Integer_Value( cursor, 22 );
      end if;
      return a_pension;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Pension_List is
      l : Ukds.Frs.Pension_List;
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
            a_pension : Ukds.Frs.Pension := Map_From_Cursor( cursor );
         begin
            l.append( a_pension ); 
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
   
   procedure Update( a_pension : Ukds.Frs.Pension; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_pension.another ));
      params( 2 ) := "+"( Integer'Pos( a_pension.penoth ));
      params( 3 ) := "+"( Float( a_pension.penpay ));
      params( 4 ) := "+"( Integer'Pos( a_pension.penpd ));
      params( 5 ) := "+"( Integer'Pos( a_pension.pentax ));
      params( 6 ) := "+"( Integer'Pos( a_pension.pentype ));
      params( 7 ) := "+"( Float( a_pension.poamt ));
      params( 8 ) := "+"( Integer'Pos( a_pension.poinc ));
      params( 9 ) := "+"( Integer'Pos( a_pension.posour ));
      params( 10 ) := "+"( Float( a_pension.ptamt ));
      params( 11 ) := "+"( Integer'Pos( a_pension.ptinc ));
      params( 12 ) := "+"( Integer'Pos( a_pension.trights ));
      params( 13 ) := "+"( Integer'Pos( a_pension.month ));
      params( 14 ) := "+"( Integer'Pos( a_pension.issue ));
      params( 15 ) := "+"( Integer'Pos( a_pension.penpd1 ));
      params( 16 ) := "+"( Integer'Pos( a_pension.penpd2 ));
      params( 17 ) := "+"( Integer'Pos( a_pension.user_id ));
      params( 18 ) := "+"( Integer'Pos( a_pension.edition ));
      params( 19 ) := "+"( Integer'Pos( a_pension.year ));
      params( 20 ) := As_Bigint( a_pension.sernum );
      params( 21 ) := "+"( Integer'Pos( a_pension.benunit ));
      params( 22 ) := "+"( Integer'Pos( a_pension.person ));
      params( 23 ) := "+"( Integer'Pos( a_pension.penseq ));
      
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

   procedure Save( a_pension : Ukds.Frs.Pension; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_pension.user_id, a_pension.edition, a_pension.year, a_pension.sernum, a_pension.benunit, a_pension.person, a_pension.penseq ) then
         Update( a_pension, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_pension.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_pension.edition ));
      params( 3 ) := "+"( Integer'Pos( a_pension.year ));
      params( 4 ) := As_Bigint( a_pension.sernum );
      params( 5 ) := "+"( Integer'Pos( a_pension.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_pension.person ));
      params( 7 ) := "+"( Integer'Pos( a_pension.penseq ));
      params( 8 ) := "+"( Integer'Pos( a_pension.another ));
      params( 9 ) := "+"( Integer'Pos( a_pension.penoth ));
      params( 10 ) := "+"( Float( a_pension.penpay ));
      params( 11 ) := "+"( Integer'Pos( a_pension.penpd ));
      params( 12 ) := "+"( Integer'Pos( a_pension.pentax ));
      params( 13 ) := "+"( Integer'Pos( a_pension.pentype ));
      params( 14 ) := "+"( Float( a_pension.poamt ));
      params( 15 ) := "+"( Integer'Pos( a_pension.poinc ));
      params( 16 ) := "+"( Integer'Pos( a_pension.posour ));
      params( 17 ) := "+"( Float( a_pension.ptamt ));
      params( 18 ) := "+"( Integer'Pos( a_pension.ptinc ));
      params( 19 ) := "+"( Integer'Pos( a_pension.trights ));
      params( 20 ) := "+"( Integer'Pos( a_pension.month ));
      params( 21 ) := "+"( Integer'Pos( a_pension.issue ));
      params( 22 ) := "+"( Integer'Pos( a_pension.penpd1 ));
      params( 23 ) := "+"( Integer'Pos( a_pension.penpd2 ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Pension
   --

   procedure Delete( a_pension : in out Ukds.Frs.Pension; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_pension.user_id );
      Add_edition( c, a_pension.edition );
      Add_year( c, a_pension.year );
      Add_sernum( c, a_pension.sernum );
      Add_benunit( c, a_pension.benunit );
      Add_person( c, a_pension.person );
      Add_penseq( c, a_pension.penseq );
      Delete( c, connection );
      a_pension := Ukds.Frs.Null_Pension;
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


   procedure Add_penseq( c : in out d.Criteria; penseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penseq", op, join, penseq );
   begin
      d.add_to_criteria( c, elem );
   end Add_penseq;


   procedure Add_another( c : in out d.Criteria; another : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "another", op, join, another );
   begin
      d.add_to_criteria( c, elem );
   end Add_another;


   procedure Add_penoth( c : in out d.Criteria; penoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penoth", op, join, penoth );
   begin
      d.add_to_criteria( c, elem );
   end Add_penoth;


   procedure Add_penpay( c : in out d.Criteria; penpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penpay", op, join, Long_Float( penpay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpay;


   procedure Add_penpd( c : in out d.Criteria; penpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penpd", op, join, penpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpd;


   procedure Add_pentax( c : in out d.Criteria; pentax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pentax", op, join, pentax );
   begin
      d.add_to_criteria( c, elem );
   end Add_pentax;


   procedure Add_pentype( c : in out d.Criteria; pentype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pentype", op, join, pentype );
   begin
      d.add_to_criteria( c, elem );
   end Add_pentype;


   procedure Add_poamt( c : in out d.Criteria; poamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "poamt", op, join, Long_Float( poamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_poamt;


   procedure Add_poinc( c : in out d.Criteria; poinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "poinc", op, join, poinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_poinc;


   procedure Add_posour( c : in out d.Criteria; posour : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "posour", op, join, posour );
   begin
      d.add_to_criteria( c, elem );
   end Add_posour;


   procedure Add_ptamt( c : in out d.Criteria; ptamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ptamt", op, join, Long_Float( ptamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptamt;


   procedure Add_ptinc( c : in out d.Criteria; ptinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ptinc", op, join, ptinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptinc;


   procedure Add_trights( c : in out d.Criteria; trights : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trights", op, join, trights );
   begin
      d.add_to_criteria( c, elem );
   end Add_trights;


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


   procedure Add_penpd1( c : in out d.Criteria; penpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penpd1", op, join, penpd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpd1;


   procedure Add_penpd2( c : in out d.Criteria; penpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penpd2", op, join, penpd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpd2;


   
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


   procedure Add_penseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penseq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penseq_To_Orderings;


   procedure Add_another_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "another", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_another_To_Orderings;


   procedure Add_penoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penoth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penoth_To_Orderings;


   procedure Add_penpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpay_To_Orderings;


   procedure Add_penpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpd_To_Orderings;


   procedure Add_pentax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pentax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pentax_To_Orderings;


   procedure Add_pentype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pentype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pentype_To_Orderings;


   procedure Add_poamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "poamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_poamt_To_Orderings;


   procedure Add_poinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "poinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_poinc_To_Orderings;


   procedure Add_posour_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "posour", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_posour_To_Orderings;


   procedure Add_ptamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ptamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptamt_To_Orderings;


   procedure Add_ptinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ptinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptinc_To_Orderings;


   procedure Add_trights_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trights", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trights_To_Orderings;


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


   procedure Add_penpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penpd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpd1_To_Orderings;


   procedure Add_penpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penpd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penpd2_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Pension_IO;
