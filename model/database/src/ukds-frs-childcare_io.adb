--
-- Created by ada_generator.py on 2017-09-05 20:57:18.499843
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

package body Ukds.Frs.Childcare_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.CHILDCARE_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, chlook, chamt, chhr, chpd," &
         "cost, emplprov, issue, registrd, month " &
         " from frs.childcare " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.childcare (" &
         "user_id, edition, year, sernum, benunit, person, chlook, chamt, chhr, chpd," &
         "cost, emplprov, issue, registrd, month " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.childcare ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.childcare set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 15 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : chamt (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : chhr (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : chpd (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : cost (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : emplprov (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : registrd (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : month (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : sernum (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           15 => ( Parameter_Integer, 0 )   --  : chlook (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : sernum (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : chlook (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : chamt (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : chhr (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : chpd (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : cost (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : emplprov (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : registrd (Integer)
           15 => ( Parameter_Integer, 0 )   --  : month (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15 )"; 
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
            4 => ( Parameter_Integer, 0 ),   --  : sernum (Integer)
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " chamt = $1, chhr = $2, chpd = $3, cost = $4, emplprov = $5, issue = $6, registrd = $7, month = $8 where user_id = $9 and edition = $10 and year = $11 and sernum = $12 and benunit = $13 and person = $14 and chlook = $15"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
   Next_Free_sernum_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_sernum_query, On_Server => True );
   -- 
   -- Next highest avaiable value of sernum - useful for saving  
   --
   function Next_Free_sernum( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_sernum_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_sernum;


   Next_Free_benunit_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( chlook ) + 1, 1 ) from frs.childcare", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Frs.Childcare match the defaults in Ukds.Frs.Null_Childcare
   --
   --
   -- Does this Ukds.Frs.Childcare equal the default Ukds.Frs.Null_Childcare ?
   --
   function Is_Null( a_childcare : Childcare ) return Boolean is
   begin
      return a_childcare = Ukds.Frs.Null_Childcare;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Childcare matching the primary key fields, or the Ukds.Frs.Null_Childcare record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Integer; benunit : Integer; person : Integer; chlook : Integer; connection : Database_Connection := null ) return Ukds.Frs.Childcare is
      l : Ukds.Frs.Childcare_List;
      a_childcare : Ukds.Frs.Childcare;
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
      if( not Ukds.Frs.Childcare_List_Package.is_empty( l ) ) then
         a_childcare := Ukds.Frs.Childcare_List_Package.First_Element( l );
      else
         a_childcare := Ukds.Frs.Null_Childcare;
      end if;
      return a_childcare;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.childcare where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6 and chlook = $7", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Integer; benunit : Integer; person : Integer; chlook : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 4 ) := "+"( Integer'Pos( sernum ));
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
   -- Retrieves a list of Childcare matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Childcare retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Childcare is
      a_childcare : Ukds.Frs.Childcare;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_childcare.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_childcare.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_childcare.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_childcare.sernum := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_childcare.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_childcare.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_childcare.chlook := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_childcare.chamt := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_childcare.chhr := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_childcare.chpd := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_childcare.cost := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_childcare.emplprov := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_childcare.issue := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_childcare.registrd := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_childcare.month := gse.Integer_Value( cursor, 14 );
      end if;
      return a_childcare;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List is
      l : Ukds.Frs.Childcare_List;
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
            a_childcare : Ukds.Frs.Childcare := Map_From_Cursor( cursor );
         begin
            l.append( a_childcare ); 
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
   
   procedure Update( a_childcare : Ukds.Frs.Childcare; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_childcare.chamt ));
      params( 2 ) := "+"( Integer'Pos( a_childcare.chhr ));
      params( 3 ) := "+"( Integer'Pos( a_childcare.chpd ));
      params( 4 ) := "+"( Integer'Pos( a_childcare.cost ));
      params( 5 ) := "+"( Integer'Pos( a_childcare.emplprov ));
      params( 6 ) := "+"( Integer'Pos( a_childcare.issue ));
      params( 7 ) := "+"( Integer'Pos( a_childcare.registrd ));
      params( 8 ) := "+"( Integer'Pos( a_childcare.month ));
      params( 9 ) := "+"( Integer'Pos( a_childcare.user_id ));
      params( 10 ) := "+"( Integer'Pos( a_childcare.edition ));
      params( 11 ) := "+"( Integer'Pos( a_childcare.year ));
      params( 12 ) := "+"( Integer'Pos( a_childcare.sernum ));
      params( 13 ) := "+"( Integer'Pos( a_childcare.benunit ));
      params( 14 ) := "+"( Integer'Pos( a_childcare.person ));
      params( 15 ) := "+"( Integer'Pos( a_childcare.chlook ));
      
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

   procedure Save( a_childcare : Ukds.Frs.Childcare; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_childcare.user_id, a_childcare.edition, a_childcare.year, a_childcare.sernum, a_childcare.benunit, a_childcare.person, a_childcare.chlook ) then
         Update( a_childcare, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_childcare.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_childcare.edition ));
      params( 3 ) := "+"( Integer'Pos( a_childcare.year ));
      params( 4 ) := "+"( Integer'Pos( a_childcare.sernum ));
      params( 5 ) := "+"( Integer'Pos( a_childcare.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_childcare.person ));
      params( 7 ) := "+"( Integer'Pos( a_childcare.chlook ));
      params( 8 ) := "+"( Integer'Pos( a_childcare.chamt ));
      params( 9 ) := "+"( Integer'Pos( a_childcare.chhr ));
      params( 10 ) := "+"( Integer'Pos( a_childcare.chpd ));
      params( 11 ) := "+"( Integer'Pos( a_childcare.cost ));
      params( 12 ) := "+"( Integer'Pos( a_childcare.emplprov ));
      params( 13 ) := "+"( Integer'Pos( a_childcare.issue ));
      params( 14 ) := "+"( Integer'Pos( a_childcare.registrd ));
      params( 15 ) := "+"( Integer'Pos( a_childcare.month ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Childcare
   --

   procedure Delete( a_childcare : in out Ukds.Frs.Childcare; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_childcare.user_id );
      Add_edition( c, a_childcare.edition );
      Add_year( c, a_childcare.year );
      Add_sernum( c, a_childcare.sernum );
      Add_benunit( c, a_childcare.benunit );
      Add_person( c, a_childcare.person );
      Add_chlook( c, a_childcare.chlook );
      Delete( c, connection );
      a_childcare := Ukds.Frs.Null_Childcare;
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


   procedure Add_sernum( c : in out d.Criteria; sernum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, sernum );
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


   procedure Add_chamt( c : in out d.Criteria; chamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamt", op, join, chamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt;


   procedure Add_chhr( c : in out d.Criteria; chhr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chhr", op, join, chhr );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr;


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


   procedure Add_emplprov( c : in out d.Criteria; emplprov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emplprov", op, join, emplprov );
   begin
      d.add_to_criteria( c, elem );
   end Add_emplprov;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


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


   procedure Add_chamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt_To_Orderings;


   procedure Add_chhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chhr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr_To_Orderings;


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


   procedure Add_emplprov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emplprov", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emplprov_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


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



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Childcare_IO;
