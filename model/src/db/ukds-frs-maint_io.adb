--
-- Created by ada_generator.py on 2017-11-13 10:51:14.544150
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

package body Ukds.Frs.Maint_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.MAINT_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, maintseq, m, mrage, mramt," &
         "mrchwhy1, mrchwhy2, mrchwhy3, mrchwhy4, mrchwhy5, mrchwhy6, mrchwhy7, mrchwhy8, mrchwhy9, mrct," &
         "mrkid, mrpd, mrr, mruamt, mrupd, mrus, mrv, month, issue, mrarr1," &
         "mrarr2, mrarr3, mrarr4, mrarr5 " &
         " from frs.maint " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.maint (" &
         "user_id, edition, year, sernum, benunit, person, maintseq, m, mrage, mramt," &
         "mrchwhy1, mrchwhy2, mrchwhy3, mrchwhy4, mrchwhy5, mrchwhy6, mrchwhy7, mrchwhy8, mrchwhy9, mrct," &
         "mrkid, mrpd, mrr, mruamt, mrupd, mrus, mrv, month, issue, mrarr1," &
         "mrarr2, mrarr3, mrarr4, mrarr5 " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.maint ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.maint set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 34 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : m (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : mrage (Integer)
            3 => ( Parameter_Float, 0.0 ),   --  : mramt (Amount)
            4 => ( Parameter_Integer, 0 ),   --  : mrchwhy1 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : mrchwhy2 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : mrchwhy3 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : mrchwhy4 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : mrchwhy5 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : mrchwhy6 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : mrchwhy7 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : mrchwhy8 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : mrchwhy9 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : mrct (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : mrkid (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : mrpd (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : mrr (Integer)
           17 => ( Parameter_Float, 0.0 ),   --  : mruamt (Amount)
           18 => ( Parameter_Integer, 0 ),   --  : mrupd (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : mrus (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : mrv (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : mrarr1 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : mrarr2 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : mrarr3 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : mrarr4 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : mrarr5 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           31 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           32 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           34 => ( Parameter_Integer, 0 )   --  : maintseq (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : maintseq (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : m (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : mrage (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : mramt (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : mrchwhy1 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : mrchwhy2 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : mrchwhy3 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : mrchwhy4 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : mrchwhy5 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : mrchwhy6 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : mrchwhy7 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : mrchwhy8 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : mrchwhy9 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : mrct (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : mrkid (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : mrpd (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : mrr (Integer)
           24 => ( Parameter_Float, 0.0 ),   --  : mruamt (Amount)
           25 => ( Parameter_Integer, 0 ),   --  : mrupd (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : mrus (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : mrv (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : mrarr1 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : mrarr2 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : mrarr3 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : mrarr4 (Integer)
           34 => ( Parameter_Integer, 0 )   --  : mrarr5 (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34 )"; 
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
            7 => ( Parameter_Integer, 0 )   --  : maintseq (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and maintseq = $7"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " m = $1, mrage = $2, mramt = $3, mrchwhy1 = $4, mrchwhy2 = $5, mrchwhy3 = $6, mrchwhy4 = $7, mrchwhy5 = $8, mrchwhy6 = $9, mrchwhy7 = $10, mrchwhy8 = $11, mrchwhy9 = $12, mrct = $13, mrkid = $14, mrpd = $15, mrr = $16, mruamt = $17, mrupd = $18, mrus = $19, mrv = $20, month = $21, issue = $22, mrarr1 = $23, mrarr2 = $24, mrarr3 = $25, mrarr4 = $26, mrarr5 = $27 where user_id = $28 and edition = $29 and year = $30 and sernum = $31 and benunit = $32 and person = $33 and maintseq = $34"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
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


   Next_Free_maintseq_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( maintseq ) + 1, 1 ) from frs.maint", SCHEMA_NAME );
   Next_Free_maintseq_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_maintseq_query, On_Server => True );
   -- 
   -- Next highest avaiable value of maintseq - useful for saving  
   --
   function Next_Free_maintseq( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_maintseq_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_maintseq;



   --
   -- returns true if the primary key parts of Ukds.Frs.Maint match the defaults in Ukds.Frs.Null_Maint
   --
   --
   -- Does this Ukds.Frs.Maint equal the default Ukds.Frs.Null_Maint ?
   --
   function Is_Null( a_maint : Maint ) return Boolean is
   begin
      return a_maint = Ukds.Frs.Null_Maint;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Maint matching the primary key fields, or the Ukds.Frs.Null_Maint record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; maintseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Maint is
      l : Ukds.Frs.Maint_List;
      a_maint : Ukds.Frs.Maint;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_maintseq( c, maintseq );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Maint_List_Package.is_empty( l ) ) then
         a_maint := Ukds.Frs.Maint_List_Package.First_Element( l );
      else
         a_maint := Ukds.Frs.Null_Maint;
      end if;
      return a_maint;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.maint where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and maintseq = $7", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; maintseq : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 7 ) := "+"( Integer'Pos( maintseq ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Maint matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Maint_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Maint retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Maint is
      a_maint : Ukds.Frs.Maint;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_maint.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_maint.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_maint.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_maint.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_maint.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_maint.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_maint.maintseq := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_maint.m := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_maint.mrage := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_maint.mramt:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_maint.mrchwhy1 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_maint.mrchwhy2 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_maint.mrchwhy3 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_maint.mrchwhy4 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_maint.mrchwhy5 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_maint.mrchwhy6 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_maint.mrchwhy7 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_maint.mrchwhy8 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_maint.mrchwhy9 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_maint.mrct := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_maint.mrkid := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_maint.mrpd := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_maint.mrr := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_maint.mruamt:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_maint.mrupd := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_maint.mrus := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_maint.mrv := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_maint.month := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_maint.issue := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_maint.mrarr1 := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_maint.mrarr2 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_maint.mrarr3 := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_maint.mrarr4 := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_maint.mrarr5 := gse.Integer_Value( cursor, 33 );
      end if;
      return a_maint;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Maint_List is
      l : Ukds.Frs.Maint_List;
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
            a_maint : Ukds.Frs.Maint := Map_From_Cursor( cursor );
         begin
            l.append( a_maint ); 
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
   
   procedure Update( a_maint : Ukds.Frs.Maint; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_maint.m ));
      params( 2 ) := "+"( Integer'Pos( a_maint.mrage ));
      params( 3 ) := "+"( Float( a_maint.mramt ));
      params( 4 ) := "+"( Integer'Pos( a_maint.mrchwhy1 ));
      params( 5 ) := "+"( Integer'Pos( a_maint.mrchwhy2 ));
      params( 6 ) := "+"( Integer'Pos( a_maint.mrchwhy3 ));
      params( 7 ) := "+"( Integer'Pos( a_maint.mrchwhy4 ));
      params( 8 ) := "+"( Integer'Pos( a_maint.mrchwhy5 ));
      params( 9 ) := "+"( Integer'Pos( a_maint.mrchwhy6 ));
      params( 10 ) := "+"( Integer'Pos( a_maint.mrchwhy7 ));
      params( 11 ) := "+"( Integer'Pos( a_maint.mrchwhy8 ));
      params( 12 ) := "+"( Integer'Pos( a_maint.mrchwhy9 ));
      params( 13 ) := "+"( Integer'Pos( a_maint.mrct ));
      params( 14 ) := "+"( Integer'Pos( a_maint.mrkid ));
      params( 15 ) := "+"( Integer'Pos( a_maint.mrpd ));
      params( 16 ) := "+"( Integer'Pos( a_maint.mrr ));
      params( 17 ) := "+"( Float( a_maint.mruamt ));
      params( 18 ) := "+"( Integer'Pos( a_maint.mrupd ));
      params( 19 ) := "+"( Integer'Pos( a_maint.mrus ));
      params( 20 ) := "+"( Integer'Pos( a_maint.mrv ));
      params( 21 ) := "+"( Integer'Pos( a_maint.month ));
      params( 22 ) := "+"( Integer'Pos( a_maint.issue ));
      params( 23 ) := "+"( Integer'Pos( a_maint.mrarr1 ));
      params( 24 ) := "+"( Integer'Pos( a_maint.mrarr2 ));
      params( 25 ) := "+"( Integer'Pos( a_maint.mrarr3 ));
      params( 26 ) := "+"( Integer'Pos( a_maint.mrarr4 ));
      params( 27 ) := "+"( Integer'Pos( a_maint.mrarr5 ));
      params( 28 ) := "+"( Integer'Pos( a_maint.user_id ));
      params( 29 ) := "+"( Integer'Pos( a_maint.edition ));
      params( 30 ) := "+"( Integer'Pos( a_maint.year ));
      params( 31 ) := As_Bigint( a_maint.sernum );
      params( 32 ) := "+"( Integer'Pos( a_maint.benunit ));
      params( 33 ) := "+"( Integer'Pos( a_maint.person ));
      params( 34 ) := "+"( Integer'Pos( a_maint.maintseq ));
      
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

   procedure Save( a_maint : Ukds.Frs.Maint; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_maint.user_id, a_maint.edition, a_maint.year, a_maint.sernum, a_maint.benunit, a_maint.person, a_maint.maintseq ) then
         Update( a_maint, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_maint.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_maint.edition ));
      params( 3 ) := "+"( Integer'Pos( a_maint.year ));
      params( 4 ) := As_Bigint( a_maint.sernum );
      params( 5 ) := "+"( Integer'Pos( a_maint.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_maint.person ));
      params( 7 ) := "+"( Integer'Pos( a_maint.maintseq ));
      params( 8 ) := "+"( Integer'Pos( a_maint.m ));
      params( 9 ) := "+"( Integer'Pos( a_maint.mrage ));
      params( 10 ) := "+"( Float( a_maint.mramt ));
      params( 11 ) := "+"( Integer'Pos( a_maint.mrchwhy1 ));
      params( 12 ) := "+"( Integer'Pos( a_maint.mrchwhy2 ));
      params( 13 ) := "+"( Integer'Pos( a_maint.mrchwhy3 ));
      params( 14 ) := "+"( Integer'Pos( a_maint.mrchwhy4 ));
      params( 15 ) := "+"( Integer'Pos( a_maint.mrchwhy5 ));
      params( 16 ) := "+"( Integer'Pos( a_maint.mrchwhy6 ));
      params( 17 ) := "+"( Integer'Pos( a_maint.mrchwhy7 ));
      params( 18 ) := "+"( Integer'Pos( a_maint.mrchwhy8 ));
      params( 19 ) := "+"( Integer'Pos( a_maint.mrchwhy9 ));
      params( 20 ) := "+"( Integer'Pos( a_maint.mrct ));
      params( 21 ) := "+"( Integer'Pos( a_maint.mrkid ));
      params( 22 ) := "+"( Integer'Pos( a_maint.mrpd ));
      params( 23 ) := "+"( Integer'Pos( a_maint.mrr ));
      params( 24 ) := "+"( Float( a_maint.mruamt ));
      params( 25 ) := "+"( Integer'Pos( a_maint.mrupd ));
      params( 26 ) := "+"( Integer'Pos( a_maint.mrus ));
      params( 27 ) := "+"( Integer'Pos( a_maint.mrv ));
      params( 28 ) := "+"( Integer'Pos( a_maint.month ));
      params( 29 ) := "+"( Integer'Pos( a_maint.issue ));
      params( 30 ) := "+"( Integer'Pos( a_maint.mrarr1 ));
      params( 31 ) := "+"( Integer'Pos( a_maint.mrarr2 ));
      params( 32 ) := "+"( Integer'Pos( a_maint.mrarr3 ));
      params( 33 ) := "+"( Integer'Pos( a_maint.mrarr4 ));
      params( 34 ) := "+"( Integer'Pos( a_maint.mrarr5 ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Maint
   --

   procedure Delete( a_maint : in out Ukds.Frs.Maint; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_maint.user_id );
      Add_edition( c, a_maint.edition );
      Add_year( c, a_maint.year );
      Add_sernum( c, a_maint.sernum );
      Add_benunit( c, a_maint.benunit );
      Add_person( c, a_maint.person );
      Add_maintseq( c, a_maint.maintseq );
      Delete( c, connection );
      a_maint := Ukds.Frs.Null_Maint;
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


   procedure Add_maintseq( c : in out d.Criteria; maintseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "maintseq", op, join, maintseq );
   begin
      d.add_to_criteria( c, elem );
   end Add_maintseq;


   procedure Add_m( c : in out d.Criteria; m : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "m", op, join, m );
   begin
      d.add_to_criteria( c, elem );
   end Add_m;


   procedure Add_mrage( c : in out d.Criteria; mrage : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrage", op, join, mrage );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrage;


   procedure Add_mramt( c : in out d.Criteria; mramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mramt", op, join, Long_Float( mramt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mramt;


   procedure Add_mrchwhy1( c : in out d.Criteria; mrchwhy1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy1", op, join, mrchwhy1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy1;


   procedure Add_mrchwhy2( c : in out d.Criteria; mrchwhy2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy2", op, join, mrchwhy2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy2;


   procedure Add_mrchwhy3( c : in out d.Criteria; mrchwhy3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy3", op, join, mrchwhy3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy3;


   procedure Add_mrchwhy4( c : in out d.Criteria; mrchwhy4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy4", op, join, mrchwhy4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy4;


   procedure Add_mrchwhy5( c : in out d.Criteria; mrchwhy5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy5", op, join, mrchwhy5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy5;


   procedure Add_mrchwhy6( c : in out d.Criteria; mrchwhy6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy6", op, join, mrchwhy6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy6;


   procedure Add_mrchwhy7( c : in out d.Criteria; mrchwhy7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy7", op, join, mrchwhy7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy7;


   procedure Add_mrchwhy8( c : in out d.Criteria; mrchwhy8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy8", op, join, mrchwhy8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy8;


   procedure Add_mrchwhy9( c : in out d.Criteria; mrchwhy9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrchwhy9", op, join, mrchwhy9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy9;


   procedure Add_mrct( c : in out d.Criteria; mrct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrct", op, join, mrct );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrct;


   procedure Add_mrkid( c : in out d.Criteria; mrkid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrkid", op, join, mrkid );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrkid;


   procedure Add_mrpd( c : in out d.Criteria; mrpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrpd", op, join, mrpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrpd;


   procedure Add_mrr( c : in out d.Criteria; mrr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrr", op, join, mrr );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrr;


   procedure Add_mruamt( c : in out d.Criteria; mruamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mruamt", op, join, Long_Float( mruamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mruamt;


   procedure Add_mrupd( c : in out d.Criteria; mrupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrupd", op, join, mrupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrupd;


   procedure Add_mrus( c : in out d.Criteria; mrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrus", op, join, mrus );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrus;


   procedure Add_mrv( c : in out d.Criteria; mrv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrv", op, join, mrv );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrv;


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


   procedure Add_mrarr1( c : in out d.Criteria; mrarr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrarr1", op, join, mrarr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr1;


   procedure Add_mrarr2( c : in out d.Criteria; mrarr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrarr2", op, join, mrarr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr2;


   procedure Add_mrarr3( c : in out d.Criteria; mrarr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrarr3", op, join, mrarr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr3;


   procedure Add_mrarr4( c : in out d.Criteria; mrarr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrarr4", op, join, mrarr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr4;


   procedure Add_mrarr5( c : in out d.Criteria; mrarr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mrarr5", op, join, mrarr5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr5;


   
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


   procedure Add_maintseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "maintseq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_maintseq_To_Orderings;


   procedure Add_m_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "m", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_m_To_Orderings;


   procedure Add_mrage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrage_To_Orderings;


   procedure Add_mramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mramt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mramt_To_Orderings;


   procedure Add_mrchwhy1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy1_To_Orderings;


   procedure Add_mrchwhy2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy2_To_Orderings;


   procedure Add_mrchwhy3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy3_To_Orderings;


   procedure Add_mrchwhy4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy4_To_Orderings;


   procedure Add_mrchwhy5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy5_To_Orderings;


   procedure Add_mrchwhy6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy6_To_Orderings;


   procedure Add_mrchwhy7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy7_To_Orderings;


   procedure Add_mrchwhy8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy8_To_Orderings;


   procedure Add_mrchwhy9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrchwhy9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrchwhy9_To_Orderings;


   procedure Add_mrct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrct", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrct_To_Orderings;


   procedure Add_mrkid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrkid", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrkid_To_Orderings;


   procedure Add_mrpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrpd_To_Orderings;


   procedure Add_mrr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrr_To_Orderings;


   procedure Add_mruamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mruamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mruamt_To_Orderings;


   procedure Add_mrupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrupd_To_Orderings;


   procedure Add_mrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrus_To_Orderings;


   procedure Add_mrv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrv_To_Orderings;


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


   procedure Add_mrarr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrarr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr1_To_Orderings;


   procedure Add_mrarr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrarr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr2_To_Orderings;


   procedure Add_mrarr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrarr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr3_To_Orderings;


   procedure Add_mrarr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrarr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr4_To_Orderings;


   procedure Add_mrarr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mrarr5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mrarr5_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Maint_IO;
