--
-- Created by ada_generator.py on 2017-11-13 10:51:14.435213
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

package body Ukds.Frs.Insuranc_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.INSURANC_IO" );
   
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
         "user_id, edition, year, sernum, insseq, numpols1, numpols2, numpols3, numpols4, numpols5," &
         "numpols6, numpols7, numpols8, numpols9, polamt, polmore, polpay, polpd, month " &
         " from frs.insuranc " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.insuranc (" &
         "user_id, edition, year, sernum, insseq, numpols1, numpols2, numpols3, numpols4, numpols5," &
         "numpols6, numpols7, numpols8, numpols9, polamt, polmore, polpay, polpd, month " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.insuranc ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.insuranc set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 19 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : numpols1 (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : numpols2 (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : numpols3 (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : numpols4 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : numpols5 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : numpols6 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : numpols7 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : numpols8 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : numpols9 (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : polamt (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : polmore (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : polpay (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : polpd (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           18 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           19 => ( Parameter_Integer, 0 )   --  : insseq (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : insseq (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : numpols1 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : numpols2 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : numpols3 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : numpols4 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : numpols5 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : numpols6 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : numpols7 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : numpols8 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : numpols9 (Integer)
           15 => ( Parameter_Float, 0.0 ),   --  : polamt (Amount)
           16 => ( Parameter_Integer, 0 ),   --  : polmore (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : polpay (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : polpd (Integer)
           19 => ( Parameter_Integer, 0 )   --  : month (Integer)
      
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
            5 => ( Parameter_Integer, 0 )   --  : insseq (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and insseq = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " numpols1 = $1, numpols2 = $2, numpols3 = $3, numpols4 = $4, numpols5 = $5, numpols6 = $6, numpols7 = $7, numpols8 = $8, numpols9 = $9, polamt = $10, polmore = $11, polpay = $12, polpd = $13, month = $14 where user_id = $15 and edition = $16 and year = $17 and sernum = $18 and insseq = $19"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.insuranc", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.insuranc", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.insuranc", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.insuranc", SCHEMA_NAME );
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


   Next_Free_insseq_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( insseq ) + 1, 1 ) from frs.insuranc", SCHEMA_NAME );
   Next_Free_insseq_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_insseq_query, On_Server => True );
   -- 
   -- Next highest avaiable value of insseq - useful for saving  
   --
   function Next_Free_insseq( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_insseq_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_insseq;



   --
   -- returns true if the primary key parts of Ukds.Frs.Insuranc match the defaults in Ukds.Frs.Null_Insuranc
   --
   --
   -- Does this Ukds.Frs.Insuranc equal the default Ukds.Frs.Null_Insuranc ?
   --
   function Is_Null( a_insuranc : Insuranc ) return Boolean is
   begin
      return a_insuranc = Ukds.Frs.Null_Insuranc;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Insuranc matching the primary key fields, or the Ukds.Frs.Null_Insuranc record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; insseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Insuranc is
      l : Ukds.Frs.Insuranc_List;
      a_insuranc : Ukds.Frs.Insuranc;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_insseq( c, insseq );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Insuranc_List_Package.is_empty( l ) ) then
         a_insuranc := Ukds.Frs.Insuranc_List_Package.First_Element( l );
      else
         a_insuranc := Ukds.Frs.Null_Insuranc;
      end if;
      return a_insuranc;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.insuranc where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and insseq = $5", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; insseq : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 5 ) := "+"( Integer'Pos( insseq ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Insuranc matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Insuranc_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Insuranc retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Insuranc is
      a_insuranc : Ukds.Frs.Insuranc;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_insuranc.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_insuranc.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_insuranc.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_insuranc.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_insuranc.insseq := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_insuranc.numpols1 := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_insuranc.numpols2 := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_insuranc.numpols3 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_insuranc.numpols4 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_insuranc.numpols5 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_insuranc.numpols6 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_insuranc.numpols7 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_insuranc.numpols8 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_insuranc.numpols9 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_insuranc.polamt:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_insuranc.polmore := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_insuranc.polpay := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_insuranc.polpd := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_insuranc.month := gse.Integer_Value( cursor, 18 );
      end if;
      return a_insuranc;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Insuranc_List is
      l : Ukds.Frs.Insuranc_List;
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
            a_insuranc : Ukds.Frs.Insuranc := Map_From_Cursor( cursor );
         begin
            l.append( a_insuranc ); 
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
   
   procedure Update( a_insuranc : Ukds.Frs.Insuranc; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_insuranc.numpols1 ));
      params( 2 ) := "+"( Integer'Pos( a_insuranc.numpols2 ));
      params( 3 ) := "+"( Integer'Pos( a_insuranc.numpols3 ));
      params( 4 ) := "+"( Integer'Pos( a_insuranc.numpols4 ));
      params( 5 ) := "+"( Integer'Pos( a_insuranc.numpols5 ));
      params( 6 ) := "+"( Integer'Pos( a_insuranc.numpols6 ));
      params( 7 ) := "+"( Integer'Pos( a_insuranc.numpols7 ));
      params( 8 ) := "+"( Integer'Pos( a_insuranc.numpols8 ));
      params( 9 ) := "+"( Integer'Pos( a_insuranc.numpols9 ));
      params( 10 ) := "+"( Float( a_insuranc.polamt ));
      params( 11 ) := "+"( Integer'Pos( a_insuranc.polmore ));
      params( 12 ) := "+"( Integer'Pos( a_insuranc.polpay ));
      params( 13 ) := "+"( Integer'Pos( a_insuranc.polpd ));
      params( 14 ) := "+"( Integer'Pos( a_insuranc.month ));
      params( 15 ) := "+"( Integer'Pos( a_insuranc.user_id ));
      params( 16 ) := "+"( Integer'Pos( a_insuranc.edition ));
      params( 17 ) := "+"( Integer'Pos( a_insuranc.year ));
      params( 18 ) := As_Bigint( a_insuranc.sernum );
      params( 19 ) := "+"( Integer'Pos( a_insuranc.insseq ));
      
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

   procedure Save( a_insuranc : Ukds.Frs.Insuranc; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_insuranc.user_id, a_insuranc.edition, a_insuranc.year, a_insuranc.sernum, a_insuranc.insseq ) then
         Update( a_insuranc, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_insuranc.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_insuranc.edition ));
      params( 3 ) := "+"( Integer'Pos( a_insuranc.year ));
      params( 4 ) := As_Bigint( a_insuranc.sernum );
      params( 5 ) := "+"( Integer'Pos( a_insuranc.insseq ));
      params( 6 ) := "+"( Integer'Pos( a_insuranc.numpols1 ));
      params( 7 ) := "+"( Integer'Pos( a_insuranc.numpols2 ));
      params( 8 ) := "+"( Integer'Pos( a_insuranc.numpols3 ));
      params( 9 ) := "+"( Integer'Pos( a_insuranc.numpols4 ));
      params( 10 ) := "+"( Integer'Pos( a_insuranc.numpols5 ));
      params( 11 ) := "+"( Integer'Pos( a_insuranc.numpols6 ));
      params( 12 ) := "+"( Integer'Pos( a_insuranc.numpols7 ));
      params( 13 ) := "+"( Integer'Pos( a_insuranc.numpols8 ));
      params( 14 ) := "+"( Integer'Pos( a_insuranc.numpols9 ));
      params( 15 ) := "+"( Float( a_insuranc.polamt ));
      params( 16 ) := "+"( Integer'Pos( a_insuranc.polmore ));
      params( 17 ) := "+"( Integer'Pos( a_insuranc.polpay ));
      params( 18 ) := "+"( Integer'Pos( a_insuranc.polpd ));
      params( 19 ) := "+"( Integer'Pos( a_insuranc.month ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Insuranc
   --

   procedure Delete( a_insuranc : in out Ukds.Frs.Insuranc; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_insuranc.user_id );
      Add_edition( c, a_insuranc.edition );
      Add_year( c, a_insuranc.year );
      Add_sernum( c, a_insuranc.sernum );
      Add_insseq( c, a_insuranc.insseq );
      Delete( c, connection );
      a_insuranc := Ukds.Frs.Null_Insuranc;
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


   procedure Add_insseq( c : in out d.Criteria; insseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "insseq", op, join, insseq );
   begin
      d.add_to_criteria( c, elem );
   end Add_insseq;


   procedure Add_numpols1( c : in out d.Criteria; numpols1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols1", op, join, numpols1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols1;


   procedure Add_numpols2( c : in out d.Criteria; numpols2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols2", op, join, numpols2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols2;


   procedure Add_numpols3( c : in out d.Criteria; numpols3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols3", op, join, numpols3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols3;


   procedure Add_numpols4( c : in out d.Criteria; numpols4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols4", op, join, numpols4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols4;


   procedure Add_numpols5( c : in out d.Criteria; numpols5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols5", op, join, numpols5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols5;


   procedure Add_numpols6( c : in out d.Criteria; numpols6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols6", op, join, numpols6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols6;


   procedure Add_numpols7( c : in out d.Criteria; numpols7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols7", op, join, numpols7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols7;


   procedure Add_numpols8( c : in out d.Criteria; numpols8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols8", op, join, numpols8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols8;


   procedure Add_numpols9( c : in out d.Criteria; numpols9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numpols9", op, join, numpols9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols9;


   procedure Add_polamt( c : in out d.Criteria; polamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "polamt", op, join, Long_Float( polamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_polamt;


   procedure Add_polmore( c : in out d.Criteria; polmore : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "polmore", op, join, polmore );
   begin
      d.add_to_criteria( c, elem );
   end Add_polmore;


   procedure Add_polpay( c : in out d.Criteria; polpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "polpay", op, join, polpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_polpay;


   procedure Add_polpd( c : in out d.Criteria; polpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "polpd", op, join, polpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_polpd;


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


   procedure Add_insseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "insseq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_insseq_To_Orderings;


   procedure Add_numpols1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols1_To_Orderings;


   procedure Add_numpols2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols2_To_Orderings;


   procedure Add_numpols3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols3_To_Orderings;


   procedure Add_numpols4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols4_To_Orderings;


   procedure Add_numpols5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols5_To_Orderings;


   procedure Add_numpols6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols6_To_Orderings;


   procedure Add_numpols7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols7_To_Orderings;


   procedure Add_numpols8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols8_To_Orderings;


   procedure Add_numpols9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numpols9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numpols9_To_Orderings;


   procedure Add_polamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "polamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_polamt_To_Orderings;


   procedure Add_polmore_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "polmore", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_polmore_To_Orderings;


   procedure Add_polpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "polpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_polpay_To_Orderings;


   procedure Add_polpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "polpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_polpd_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Insuranc_IO;
