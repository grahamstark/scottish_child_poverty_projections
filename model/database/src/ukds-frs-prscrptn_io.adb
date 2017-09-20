--
-- Created by ada_generator.py on 2017-09-20 20:40:55.477324
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

package body Ukds.Frs.Prscrptn_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.PRSCRPTN_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, issue, med12m01, med12m02, med12m03," &
         "med12m04, med12m05, med12m06, med12m07, med12m08, med12m09, med12m10, med12m11, med12m12, med12m13," &
         "medrep, medrpnm, month " &
         " from frs.prscrptn " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.prscrptn (" &
         "user_id, edition, year, sernum, benunit, person, issue, med12m01, med12m02, med12m03," &
         "med12m04, med12m05, med12m06, med12m07, med12m08, med12m09, med12m10, med12m11, med12m12, med12m13," &
         "medrep, medrpnm, month " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.prscrptn ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.prscrptn set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 23 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : med12m01 (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : med12m02 (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : med12m03 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : med12m04 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : med12m05 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : med12m06 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : med12m07 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : med12m08 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : med12m09 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : med12m10 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : med12m11 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : med12m12 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : med12m13 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : medrep (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : medrpnm (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           21 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           22 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           23 => ( Parameter_Integer, 0 )   --  : person (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : med12m01 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : med12m02 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : med12m03 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : med12m04 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : med12m05 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : med12m06 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : med12m07 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : med12m08 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : med12m09 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : med12m10 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : med12m11 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : med12m12 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : med12m13 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : medrep (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : medrpnm (Integer)
           23 => ( Parameter_Integer, 0 )   --  : month (Integer)
      
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
      params : constant SQL_Parameters( 1 .. 6 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 )   --  : person (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " issue = $1, med12m01 = $2, med12m02 = $3, med12m03 = $4, med12m04 = $5, med12m05 = $6, med12m06 = $7, med12m07 = $8, med12m08 = $9, med12m09 = $10, med12m10 = $11, med12m11 = $12, med12m12 = $13, med12m13 = $14, medrep = $15, medrpnm = $16, month = $17 where user_id = $18 and edition = $19 and year = $20 and sernum = $21 and benunit = $22 and person = $23"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.prscrptn", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.prscrptn", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.prscrptn", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.prscrptn", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.prscrptn", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.prscrptn", SCHEMA_NAME );
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



   --
   -- returns true if the primary key parts of Ukds.Frs.Prscrptn match the defaults in Ukds.Frs.Null_Prscrptn
   --
   --
   -- Does this Ukds.Frs.Prscrptn equal the default Ukds.Frs.Null_Prscrptn ?
   --
   function Is_Null( a_prscrptn : Prscrptn ) return Boolean is
   begin
      return a_prscrptn = Ukds.Frs.Null_Prscrptn;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Prscrptn matching the primary key fields, or the Ukds.Frs.Null_Prscrptn record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn is
      l : Ukds.Frs.Prscrptn_List;
      a_prscrptn : Ukds.Frs.Prscrptn;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Prscrptn_List_Package.is_empty( l ) ) then
         a_prscrptn := Ukds.Frs.Prscrptn_List_Package.First_Element( l );
      else
         a_prscrptn := Ukds.Frs.Null_Prscrptn;
      end if;
      return a_prscrptn;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.prscrptn where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Boolean  is
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
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Prscrptn matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Prscrptn retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Prscrptn is
      a_prscrptn : Ukds.Frs.Prscrptn;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_prscrptn.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_prscrptn.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_prscrptn.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_prscrptn.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_prscrptn.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_prscrptn.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_prscrptn.issue := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_prscrptn.med12m01 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_prscrptn.med12m02 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_prscrptn.med12m03 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_prscrptn.med12m04 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_prscrptn.med12m05 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_prscrptn.med12m06 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_prscrptn.med12m07 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_prscrptn.med12m08 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_prscrptn.med12m09 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_prscrptn.med12m10 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_prscrptn.med12m11 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_prscrptn.med12m12 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_prscrptn.med12m13 := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_prscrptn.medrep := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_prscrptn.medrpnm := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_prscrptn.month := gse.Integer_Value( cursor, 22 );
      end if;
      return a_prscrptn;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List is
      l : Ukds.Frs.Prscrptn_List;
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
            a_prscrptn : Ukds.Frs.Prscrptn := Map_From_Cursor( cursor );
         begin
            l.append( a_prscrptn ); 
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
   
   procedure Update( a_prscrptn : Ukds.Frs.Prscrptn; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_prscrptn.issue ));
      params( 2 ) := "+"( Integer'Pos( a_prscrptn.med12m01 ));
      params( 3 ) := "+"( Integer'Pos( a_prscrptn.med12m02 ));
      params( 4 ) := "+"( Integer'Pos( a_prscrptn.med12m03 ));
      params( 5 ) := "+"( Integer'Pos( a_prscrptn.med12m04 ));
      params( 6 ) := "+"( Integer'Pos( a_prscrptn.med12m05 ));
      params( 7 ) := "+"( Integer'Pos( a_prscrptn.med12m06 ));
      params( 8 ) := "+"( Integer'Pos( a_prscrptn.med12m07 ));
      params( 9 ) := "+"( Integer'Pos( a_prscrptn.med12m08 ));
      params( 10 ) := "+"( Integer'Pos( a_prscrptn.med12m09 ));
      params( 11 ) := "+"( Integer'Pos( a_prscrptn.med12m10 ));
      params( 12 ) := "+"( Integer'Pos( a_prscrptn.med12m11 ));
      params( 13 ) := "+"( Integer'Pos( a_prscrptn.med12m12 ));
      params( 14 ) := "+"( Integer'Pos( a_prscrptn.med12m13 ));
      params( 15 ) := "+"( Integer'Pos( a_prscrptn.medrep ));
      params( 16 ) := "+"( Integer'Pos( a_prscrptn.medrpnm ));
      params( 17 ) := "+"( Integer'Pos( a_prscrptn.month ));
      params( 18 ) := "+"( Integer'Pos( a_prscrptn.user_id ));
      params( 19 ) := "+"( Integer'Pos( a_prscrptn.edition ));
      params( 20 ) := "+"( Integer'Pos( a_prscrptn.year ));
      params( 21 ) := As_Bigint( a_prscrptn.sernum );
      params( 22 ) := "+"( Integer'Pos( a_prscrptn.benunit ));
      params( 23 ) := "+"( Integer'Pos( a_prscrptn.person ));
      
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

   procedure Save( a_prscrptn : Ukds.Frs.Prscrptn; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_prscrptn.user_id, a_prscrptn.edition, a_prscrptn.year, a_prscrptn.sernum, a_prscrptn.benunit, a_prscrptn.person ) then
         Update( a_prscrptn, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_prscrptn.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_prscrptn.edition ));
      params( 3 ) := "+"( Integer'Pos( a_prscrptn.year ));
      params( 4 ) := As_Bigint( a_prscrptn.sernum );
      params( 5 ) := "+"( Integer'Pos( a_prscrptn.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_prscrptn.person ));
      params( 7 ) := "+"( Integer'Pos( a_prscrptn.issue ));
      params( 8 ) := "+"( Integer'Pos( a_prscrptn.med12m01 ));
      params( 9 ) := "+"( Integer'Pos( a_prscrptn.med12m02 ));
      params( 10 ) := "+"( Integer'Pos( a_prscrptn.med12m03 ));
      params( 11 ) := "+"( Integer'Pos( a_prscrptn.med12m04 ));
      params( 12 ) := "+"( Integer'Pos( a_prscrptn.med12m05 ));
      params( 13 ) := "+"( Integer'Pos( a_prscrptn.med12m06 ));
      params( 14 ) := "+"( Integer'Pos( a_prscrptn.med12m07 ));
      params( 15 ) := "+"( Integer'Pos( a_prscrptn.med12m08 ));
      params( 16 ) := "+"( Integer'Pos( a_prscrptn.med12m09 ));
      params( 17 ) := "+"( Integer'Pos( a_prscrptn.med12m10 ));
      params( 18 ) := "+"( Integer'Pos( a_prscrptn.med12m11 ));
      params( 19 ) := "+"( Integer'Pos( a_prscrptn.med12m12 ));
      params( 20 ) := "+"( Integer'Pos( a_prscrptn.med12m13 ));
      params( 21 ) := "+"( Integer'Pos( a_prscrptn.medrep ));
      params( 22 ) := "+"( Integer'Pos( a_prscrptn.medrpnm ));
      params( 23 ) := "+"( Integer'Pos( a_prscrptn.month ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Prscrptn
   --

   procedure Delete( a_prscrptn : in out Ukds.Frs.Prscrptn; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_prscrptn.user_id );
      Add_edition( c, a_prscrptn.edition );
      Add_year( c, a_prscrptn.year );
      Add_sernum( c, a_prscrptn.sernum );
      Add_benunit( c, a_prscrptn.benunit );
      Add_person( c, a_prscrptn.person );
      Delete( c, connection );
      a_prscrptn := Ukds.Frs.Null_Prscrptn;
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


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_med12m01( c : in out d.Criteria; med12m01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m01", op, join, med12m01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m01;


   procedure Add_med12m02( c : in out d.Criteria; med12m02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m02", op, join, med12m02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m02;


   procedure Add_med12m03( c : in out d.Criteria; med12m03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m03", op, join, med12m03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m03;


   procedure Add_med12m04( c : in out d.Criteria; med12m04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m04", op, join, med12m04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m04;


   procedure Add_med12m05( c : in out d.Criteria; med12m05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m05", op, join, med12m05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m05;


   procedure Add_med12m06( c : in out d.Criteria; med12m06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m06", op, join, med12m06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m06;


   procedure Add_med12m07( c : in out d.Criteria; med12m07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m07", op, join, med12m07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m07;


   procedure Add_med12m08( c : in out d.Criteria; med12m08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m08", op, join, med12m08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m08;


   procedure Add_med12m09( c : in out d.Criteria; med12m09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m09", op, join, med12m09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m09;


   procedure Add_med12m10( c : in out d.Criteria; med12m10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m10", op, join, med12m10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m10;


   procedure Add_med12m11( c : in out d.Criteria; med12m11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m11", op, join, med12m11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m11;


   procedure Add_med12m12( c : in out d.Criteria; med12m12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m12", op, join, med12m12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m12;


   procedure Add_med12m13( c : in out d.Criteria; med12m13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "med12m13", op, join, med12m13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m13;


   procedure Add_medrep( c : in out d.Criteria; medrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medrep", op, join, medrep );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrep;


   procedure Add_medrpnm( c : in out d.Criteria; medrpnm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medrpnm", op, join, medrpnm );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrpnm;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   
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


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_med12m01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m01_To_Orderings;


   procedure Add_med12m02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m02_To_Orderings;


   procedure Add_med12m03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m03_To_Orderings;


   procedure Add_med12m04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m04_To_Orderings;


   procedure Add_med12m05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m05_To_Orderings;


   procedure Add_med12m06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m06_To_Orderings;


   procedure Add_med12m07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m07_To_Orderings;


   procedure Add_med12m08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m08_To_Orderings;


   procedure Add_med12m09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m09_To_Orderings;


   procedure Add_med12m10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m10_To_Orderings;


   procedure Add_med12m11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m11_To_Orderings;


   procedure Add_med12m12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m12_To_Orderings;


   procedure Add_med12m13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "med12m13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_med12m13_To_Orderings;


   procedure Add_medrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medrep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrep_To_Orderings;


   procedure Add_medrpnm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medrpnm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrpnm_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Prscrptn_IO;
