--
-- Created by ada_generator.py on 2017-09-14 11:23:39.997727
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

package body Ukds.Frs.Admin_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.ADMIN_IO" );
   
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
         "user_id, edition, year, sernum, findhh, hhsel, hout, ncr1, ncr2, ncr3," &
         "ncr4, ncr5, ncr6, ncr7, refr01, refr02, refr03, refr04, refr05, refr06," &
         "refr07, refr08, refr09, refr10, refr11, refr12, refr13, refr14, refr15, refr16," &
         "refr17, refr18, tnc, version, month, issue, lngdf01, lngdf02, lngdf03, lngdf04," &
         "lngdf05, lngdf06, lngdf07, lngdf08, lngdf09, lngdf10, nmtrans, noneng, whlang01, whlang02," &
         "whlang03, whlang04, whlang05, whlang06, whlang07, whlang08, whlang09, whlang10, whotran1, whotran2," &
         "whotran3, whotran4, whotran5, lngdf11, whlang11 " &
         " from frs.admin " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.admin (" &
         "user_id, edition, year, sernum, findhh, hhsel, hout, ncr1, ncr2, ncr3," &
         "ncr4, ncr5, ncr6, ncr7, refr01, refr02, refr03, refr04, refr05, refr06," &
         "refr07, refr08, refr09, refr10, refr11, refr12, refr13, refr14, refr15, refr16," &
         "refr17, refr18, tnc, version, month, issue, lngdf01, lngdf02, lngdf03, lngdf04," &
         "lngdf05, lngdf06, lngdf07, lngdf08, lngdf09, lngdf10, nmtrans, noneng, whlang01, whlang02," &
         "whlang03, whlang04, whlang05, whlang06, whlang07, whlang08, whlang09, whlang10, whotran1, whotran2," &
         "whotran3, whotran4, whotran5, lngdf11, whlang11 " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.admin ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.admin set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 65 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : findhh (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : hhsel (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : hout (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : ncr1 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : ncr2 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : ncr3 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : ncr4 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : ncr5 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : ncr6 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : ncr7 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : refr01 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : refr02 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : refr03 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : refr04 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : refr05 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : refr06 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : refr07 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : refr08 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : refr09 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : refr10 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : refr11 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : refr12 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : refr13 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : refr14 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : refr15 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : refr16 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : refr17 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : refr18 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : tnc (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : version (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : lngdf01 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : lngdf02 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : lngdf03 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : lngdf04 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : lngdf05 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : lngdf06 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : lngdf07 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : lngdf08 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : lngdf09 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : lngdf10 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : nmtrans (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : noneng (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : whlang01 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : whlang02 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : whlang03 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : whlang04 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : whlang05 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : whlang06 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : whlang07 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : whlang08 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : whlang09 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : whlang10 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : whotran1 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : whotran2 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : whotran3 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : whotran4 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : whotran5 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : lngdf11 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : whlang11 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           65 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : findhh (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : hhsel (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : hout (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : ncr1 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : ncr2 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : ncr3 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : ncr4 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : ncr5 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : ncr6 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : ncr7 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : refr01 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : refr02 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : refr03 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : refr04 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : refr05 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : refr06 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : refr07 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : refr08 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : refr09 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : refr10 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : refr11 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : refr12 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : refr13 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : refr14 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : refr15 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : refr16 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : refr17 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : refr18 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : tnc (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : version (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : lngdf01 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : lngdf02 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : lngdf03 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : lngdf04 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : lngdf05 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : lngdf06 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : lngdf07 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : lngdf08 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : lngdf09 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : lngdf10 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : nmtrans (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : noneng (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : whlang01 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : whlang02 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : whlang03 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : whlang04 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : whlang05 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : whlang06 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : whlang07 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : whlang08 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : whlang09 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : whlang10 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : whotran1 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : whotran2 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : whotran3 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : whotran4 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : whotran5 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : lngdf11 (Integer)
           65 => ( Parameter_Integer, 0 )   --  : whlang11 (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 4 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " findhh = $1, hhsel = $2, hout = $3, ncr1 = $4, ncr2 = $5, ncr3 = $6, ncr4 = $7, ncr5 = $8, ncr6 = $9, ncr7 = $10, refr01 = $11, refr02 = $12, refr03 = $13, refr04 = $14, refr05 = $15, refr06 = $16, refr07 = $17, refr08 = $18, refr09 = $19, refr10 = $20, refr11 = $21, refr12 = $22, refr13 = $23, refr14 = $24, refr15 = $25, refr16 = $26, refr17 = $27, refr18 = $28, tnc = $29, version = $30, month = $31, issue = $32, lngdf01 = $33, lngdf02 = $34, lngdf03 = $35, lngdf04 = $36, lngdf05 = $37, lngdf06 = $38, lngdf07 = $39, lngdf08 = $40, lngdf09 = $41, lngdf10 = $42, nmtrans = $43, noneng = $44, whlang01 = $45, whlang02 = $46, whlang03 = $47, whlang04 = $48, whlang05 = $49, whlang06 = $50, whlang07 = $51, whlang08 = $52, whlang09 = $53, whlang10 = $54, whotran1 = $55, whotran2 = $56, whotran3 = $57, whotran4 = $58, whotran5 = $59, lngdf11 = $60, whlang11 = $61 where user_id = $62 and edition = $63 and year = $64 and sernum = $65"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.admin", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.admin", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.admin", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.admin", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Frs.Admin match the defaults in Ukds.Frs.Null_Admin
   --
   --
   -- Does this Ukds.Frs.Admin equal the default Ukds.Frs.Null_Admin ?
   --
   function Is_Null( a_admin : Admin ) return Boolean is
   begin
      return a_admin = Ukds.Frs.Null_Admin;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Admin matching the primary key fields, or the Ukds.Frs.Null_Admin record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Admin is
      l : Ukds.Frs.Admin_List;
      a_admin : Ukds.Frs.Admin;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Admin_List_Package.is_empty( l ) ) then
         a_admin := Ukds.Frs.Admin_List_Package.First_Element( l );
      else
         a_admin := Ukds.Frs.Null_Admin;
      end if;
      return a_admin;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.admin where user_id = $1 and edition = $2 and year = $3 and sernum = $4", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean  is
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
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Admin matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Admin_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Admin retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Admin is
      a_admin : Ukds.Frs.Admin;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_admin.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_admin.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_admin.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_admin.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_admin.findhh := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_admin.hhsel := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_admin.hout := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_admin.ncr1 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_admin.ncr2 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_admin.ncr3 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_admin.ncr4 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_admin.ncr5 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_admin.ncr6 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_admin.ncr7 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_admin.refr01 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_admin.refr02 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_admin.refr03 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_admin.refr04 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_admin.refr05 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_admin.refr06 := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_admin.refr07 := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_admin.refr08 := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_admin.refr09 := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_admin.refr10 := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_admin.refr11 := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_admin.refr12 := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_admin.refr13 := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_admin.refr14 := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_admin.refr15 := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_admin.refr16 := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_admin.refr17 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_admin.refr18 := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_admin.tnc := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_admin.version := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_admin.month := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_admin.issue := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_admin.lngdf01 := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_admin.lngdf02 := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_admin.lngdf03 := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_admin.lngdf04 := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_admin.lngdf05 := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_admin.lngdf06 := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_admin.lngdf07 := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_admin.lngdf08 := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_admin.lngdf09 := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_admin.lngdf10 := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_admin.nmtrans := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_admin.noneng := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_admin.whlang01 := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_admin.whlang02 := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_admin.whlang03 := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_admin.whlang04 := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_admin.whlang05 := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_admin.whlang06 := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_admin.whlang07 := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_admin.whlang08 := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_admin.whlang09 := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_admin.whlang10 := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_admin.whotran1 := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_admin.whotran2 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_admin.whotran3 := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_admin.whotran4 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_admin.whotran5 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_admin.lngdf11 := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_admin.whlang11 := gse.Integer_Value( cursor, 64 );
      end if;
      return a_admin;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Admin_List is
      l : Ukds.Frs.Admin_List;
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
            a_admin : Ukds.Frs.Admin := Map_From_Cursor( cursor );
         begin
            l.append( a_admin ); 
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
   
   procedure Update( a_admin : Ukds.Frs.Admin; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_admin.findhh ));
      params( 2 ) := "+"( Integer'Pos( a_admin.hhsel ));
      params( 3 ) := "+"( Integer'Pos( a_admin.hout ));
      params( 4 ) := "+"( Integer'Pos( a_admin.ncr1 ));
      params( 5 ) := "+"( Integer'Pos( a_admin.ncr2 ));
      params( 6 ) := "+"( Integer'Pos( a_admin.ncr3 ));
      params( 7 ) := "+"( Integer'Pos( a_admin.ncr4 ));
      params( 8 ) := "+"( Integer'Pos( a_admin.ncr5 ));
      params( 9 ) := "+"( Integer'Pos( a_admin.ncr6 ));
      params( 10 ) := "+"( Integer'Pos( a_admin.ncr7 ));
      params( 11 ) := "+"( Integer'Pos( a_admin.refr01 ));
      params( 12 ) := "+"( Integer'Pos( a_admin.refr02 ));
      params( 13 ) := "+"( Integer'Pos( a_admin.refr03 ));
      params( 14 ) := "+"( Integer'Pos( a_admin.refr04 ));
      params( 15 ) := "+"( Integer'Pos( a_admin.refr05 ));
      params( 16 ) := "+"( Integer'Pos( a_admin.refr06 ));
      params( 17 ) := "+"( Integer'Pos( a_admin.refr07 ));
      params( 18 ) := "+"( Integer'Pos( a_admin.refr08 ));
      params( 19 ) := "+"( Integer'Pos( a_admin.refr09 ));
      params( 20 ) := "+"( Integer'Pos( a_admin.refr10 ));
      params( 21 ) := "+"( Integer'Pos( a_admin.refr11 ));
      params( 22 ) := "+"( Integer'Pos( a_admin.refr12 ));
      params( 23 ) := "+"( Integer'Pos( a_admin.refr13 ));
      params( 24 ) := "+"( Integer'Pos( a_admin.refr14 ));
      params( 25 ) := "+"( Integer'Pos( a_admin.refr15 ));
      params( 26 ) := "+"( Integer'Pos( a_admin.refr16 ));
      params( 27 ) := "+"( Integer'Pos( a_admin.refr17 ));
      params( 28 ) := "+"( Integer'Pos( a_admin.refr18 ));
      params( 29 ) := "+"( Integer'Pos( a_admin.tnc ));
      params( 30 ) := "+"( Integer'Pos( a_admin.version ));
      params( 31 ) := "+"( Integer'Pos( a_admin.month ));
      params( 32 ) := "+"( Integer'Pos( a_admin.issue ));
      params( 33 ) := "+"( Integer'Pos( a_admin.lngdf01 ));
      params( 34 ) := "+"( Integer'Pos( a_admin.lngdf02 ));
      params( 35 ) := "+"( Integer'Pos( a_admin.lngdf03 ));
      params( 36 ) := "+"( Integer'Pos( a_admin.lngdf04 ));
      params( 37 ) := "+"( Integer'Pos( a_admin.lngdf05 ));
      params( 38 ) := "+"( Integer'Pos( a_admin.lngdf06 ));
      params( 39 ) := "+"( Integer'Pos( a_admin.lngdf07 ));
      params( 40 ) := "+"( Integer'Pos( a_admin.lngdf08 ));
      params( 41 ) := "+"( Integer'Pos( a_admin.lngdf09 ));
      params( 42 ) := "+"( Integer'Pos( a_admin.lngdf10 ));
      params( 43 ) := "+"( Integer'Pos( a_admin.nmtrans ));
      params( 44 ) := "+"( Integer'Pos( a_admin.noneng ));
      params( 45 ) := "+"( Integer'Pos( a_admin.whlang01 ));
      params( 46 ) := "+"( Integer'Pos( a_admin.whlang02 ));
      params( 47 ) := "+"( Integer'Pos( a_admin.whlang03 ));
      params( 48 ) := "+"( Integer'Pos( a_admin.whlang04 ));
      params( 49 ) := "+"( Integer'Pos( a_admin.whlang05 ));
      params( 50 ) := "+"( Integer'Pos( a_admin.whlang06 ));
      params( 51 ) := "+"( Integer'Pos( a_admin.whlang07 ));
      params( 52 ) := "+"( Integer'Pos( a_admin.whlang08 ));
      params( 53 ) := "+"( Integer'Pos( a_admin.whlang09 ));
      params( 54 ) := "+"( Integer'Pos( a_admin.whlang10 ));
      params( 55 ) := "+"( Integer'Pos( a_admin.whotran1 ));
      params( 56 ) := "+"( Integer'Pos( a_admin.whotran2 ));
      params( 57 ) := "+"( Integer'Pos( a_admin.whotran3 ));
      params( 58 ) := "+"( Integer'Pos( a_admin.whotran4 ));
      params( 59 ) := "+"( Integer'Pos( a_admin.whotran5 ));
      params( 60 ) := "+"( Integer'Pos( a_admin.lngdf11 ));
      params( 61 ) := "+"( Integer'Pos( a_admin.whlang11 ));
      params( 62 ) := "+"( Integer'Pos( a_admin.user_id ));
      params( 63 ) := "+"( Integer'Pos( a_admin.edition ));
      params( 64 ) := "+"( Integer'Pos( a_admin.year ));
      params( 65 ) := As_Bigint( a_admin.sernum );
      
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

   procedure Save( a_admin : Ukds.Frs.Admin; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_admin.user_id, a_admin.edition, a_admin.year, a_admin.sernum ) then
         Update( a_admin, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_admin.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_admin.edition ));
      params( 3 ) := "+"( Integer'Pos( a_admin.year ));
      params( 4 ) := As_Bigint( a_admin.sernum );
      params( 5 ) := "+"( Integer'Pos( a_admin.findhh ));
      params( 6 ) := "+"( Integer'Pos( a_admin.hhsel ));
      params( 7 ) := "+"( Integer'Pos( a_admin.hout ));
      params( 8 ) := "+"( Integer'Pos( a_admin.ncr1 ));
      params( 9 ) := "+"( Integer'Pos( a_admin.ncr2 ));
      params( 10 ) := "+"( Integer'Pos( a_admin.ncr3 ));
      params( 11 ) := "+"( Integer'Pos( a_admin.ncr4 ));
      params( 12 ) := "+"( Integer'Pos( a_admin.ncr5 ));
      params( 13 ) := "+"( Integer'Pos( a_admin.ncr6 ));
      params( 14 ) := "+"( Integer'Pos( a_admin.ncr7 ));
      params( 15 ) := "+"( Integer'Pos( a_admin.refr01 ));
      params( 16 ) := "+"( Integer'Pos( a_admin.refr02 ));
      params( 17 ) := "+"( Integer'Pos( a_admin.refr03 ));
      params( 18 ) := "+"( Integer'Pos( a_admin.refr04 ));
      params( 19 ) := "+"( Integer'Pos( a_admin.refr05 ));
      params( 20 ) := "+"( Integer'Pos( a_admin.refr06 ));
      params( 21 ) := "+"( Integer'Pos( a_admin.refr07 ));
      params( 22 ) := "+"( Integer'Pos( a_admin.refr08 ));
      params( 23 ) := "+"( Integer'Pos( a_admin.refr09 ));
      params( 24 ) := "+"( Integer'Pos( a_admin.refr10 ));
      params( 25 ) := "+"( Integer'Pos( a_admin.refr11 ));
      params( 26 ) := "+"( Integer'Pos( a_admin.refr12 ));
      params( 27 ) := "+"( Integer'Pos( a_admin.refr13 ));
      params( 28 ) := "+"( Integer'Pos( a_admin.refr14 ));
      params( 29 ) := "+"( Integer'Pos( a_admin.refr15 ));
      params( 30 ) := "+"( Integer'Pos( a_admin.refr16 ));
      params( 31 ) := "+"( Integer'Pos( a_admin.refr17 ));
      params( 32 ) := "+"( Integer'Pos( a_admin.refr18 ));
      params( 33 ) := "+"( Integer'Pos( a_admin.tnc ));
      params( 34 ) := "+"( Integer'Pos( a_admin.version ));
      params( 35 ) := "+"( Integer'Pos( a_admin.month ));
      params( 36 ) := "+"( Integer'Pos( a_admin.issue ));
      params( 37 ) := "+"( Integer'Pos( a_admin.lngdf01 ));
      params( 38 ) := "+"( Integer'Pos( a_admin.lngdf02 ));
      params( 39 ) := "+"( Integer'Pos( a_admin.lngdf03 ));
      params( 40 ) := "+"( Integer'Pos( a_admin.lngdf04 ));
      params( 41 ) := "+"( Integer'Pos( a_admin.lngdf05 ));
      params( 42 ) := "+"( Integer'Pos( a_admin.lngdf06 ));
      params( 43 ) := "+"( Integer'Pos( a_admin.lngdf07 ));
      params( 44 ) := "+"( Integer'Pos( a_admin.lngdf08 ));
      params( 45 ) := "+"( Integer'Pos( a_admin.lngdf09 ));
      params( 46 ) := "+"( Integer'Pos( a_admin.lngdf10 ));
      params( 47 ) := "+"( Integer'Pos( a_admin.nmtrans ));
      params( 48 ) := "+"( Integer'Pos( a_admin.noneng ));
      params( 49 ) := "+"( Integer'Pos( a_admin.whlang01 ));
      params( 50 ) := "+"( Integer'Pos( a_admin.whlang02 ));
      params( 51 ) := "+"( Integer'Pos( a_admin.whlang03 ));
      params( 52 ) := "+"( Integer'Pos( a_admin.whlang04 ));
      params( 53 ) := "+"( Integer'Pos( a_admin.whlang05 ));
      params( 54 ) := "+"( Integer'Pos( a_admin.whlang06 ));
      params( 55 ) := "+"( Integer'Pos( a_admin.whlang07 ));
      params( 56 ) := "+"( Integer'Pos( a_admin.whlang08 ));
      params( 57 ) := "+"( Integer'Pos( a_admin.whlang09 ));
      params( 58 ) := "+"( Integer'Pos( a_admin.whlang10 ));
      params( 59 ) := "+"( Integer'Pos( a_admin.whotran1 ));
      params( 60 ) := "+"( Integer'Pos( a_admin.whotran2 ));
      params( 61 ) := "+"( Integer'Pos( a_admin.whotran3 ));
      params( 62 ) := "+"( Integer'Pos( a_admin.whotran4 ));
      params( 63 ) := "+"( Integer'Pos( a_admin.whotran5 ));
      params( 64 ) := "+"( Integer'Pos( a_admin.lngdf11 ));
      params( 65 ) := "+"( Integer'Pos( a_admin.whlang11 ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Admin
   --

   procedure Delete( a_admin : in out Ukds.Frs.Admin; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_admin.user_id );
      Add_edition( c, a_admin.edition );
      Add_year( c, a_admin.year );
      Add_sernum( c, a_admin.sernum );
      Delete( c, connection );
      a_admin := Ukds.Frs.Null_Admin;
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


   procedure Add_findhh( c : in out d.Criteria; findhh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "findhh", op, join, findhh );
   begin
      d.add_to_criteria( c, elem );
   end Add_findhh;


   procedure Add_hhsel( c : in out d.Criteria; hhsel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhsel", op, join, hhsel );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhsel;


   procedure Add_hout( c : in out d.Criteria; hout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hout", op, join, hout );
   begin
      d.add_to_criteria( c, elem );
   end Add_hout;


   procedure Add_ncr1( c : in out d.Criteria; ncr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr1", op, join, ncr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr1;


   procedure Add_ncr2( c : in out d.Criteria; ncr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr2", op, join, ncr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr2;


   procedure Add_ncr3( c : in out d.Criteria; ncr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr3", op, join, ncr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr3;


   procedure Add_ncr4( c : in out d.Criteria; ncr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr4", op, join, ncr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr4;


   procedure Add_ncr5( c : in out d.Criteria; ncr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr5", op, join, ncr5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr5;


   procedure Add_ncr6( c : in out d.Criteria; ncr6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr6", op, join, ncr6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr6;


   procedure Add_ncr7( c : in out d.Criteria; ncr7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ncr7", op, join, ncr7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr7;


   procedure Add_refr01( c : in out d.Criteria; refr01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr01", op, join, refr01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr01;


   procedure Add_refr02( c : in out d.Criteria; refr02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr02", op, join, refr02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr02;


   procedure Add_refr03( c : in out d.Criteria; refr03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr03", op, join, refr03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr03;


   procedure Add_refr04( c : in out d.Criteria; refr04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr04", op, join, refr04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr04;


   procedure Add_refr05( c : in out d.Criteria; refr05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr05", op, join, refr05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr05;


   procedure Add_refr06( c : in out d.Criteria; refr06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr06", op, join, refr06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr06;


   procedure Add_refr07( c : in out d.Criteria; refr07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr07", op, join, refr07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr07;


   procedure Add_refr08( c : in out d.Criteria; refr08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr08", op, join, refr08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr08;


   procedure Add_refr09( c : in out d.Criteria; refr09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr09", op, join, refr09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr09;


   procedure Add_refr10( c : in out d.Criteria; refr10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr10", op, join, refr10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr10;


   procedure Add_refr11( c : in out d.Criteria; refr11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr11", op, join, refr11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr11;


   procedure Add_refr12( c : in out d.Criteria; refr12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr12", op, join, refr12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr12;


   procedure Add_refr13( c : in out d.Criteria; refr13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr13", op, join, refr13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr13;


   procedure Add_refr14( c : in out d.Criteria; refr14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr14", op, join, refr14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr14;


   procedure Add_refr15( c : in out d.Criteria; refr15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr15", op, join, refr15 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr15;


   procedure Add_refr16( c : in out d.Criteria; refr16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr16", op, join, refr16 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr16;


   procedure Add_refr17( c : in out d.Criteria; refr17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr17", op, join, refr17 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr17;


   procedure Add_refr18( c : in out d.Criteria; refr18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "refr18", op, join, refr18 );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr18;


   procedure Add_tnc( c : in out d.Criteria; tnc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tnc", op, join, tnc );
   begin
      d.add_to_criteria( c, elem );
   end Add_tnc;


   procedure Add_version( c : in out d.Criteria; version : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "version", op, join, version );
   begin
      d.add_to_criteria( c, elem );
   end Add_version;


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


   procedure Add_lngdf01( c : in out d.Criteria; lngdf01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf01", op, join, lngdf01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf01;


   procedure Add_lngdf02( c : in out d.Criteria; lngdf02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf02", op, join, lngdf02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf02;


   procedure Add_lngdf03( c : in out d.Criteria; lngdf03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf03", op, join, lngdf03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf03;


   procedure Add_lngdf04( c : in out d.Criteria; lngdf04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf04", op, join, lngdf04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf04;


   procedure Add_lngdf05( c : in out d.Criteria; lngdf05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf05", op, join, lngdf05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf05;


   procedure Add_lngdf06( c : in out d.Criteria; lngdf06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf06", op, join, lngdf06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf06;


   procedure Add_lngdf07( c : in out d.Criteria; lngdf07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf07", op, join, lngdf07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf07;


   procedure Add_lngdf08( c : in out d.Criteria; lngdf08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf08", op, join, lngdf08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf08;


   procedure Add_lngdf09( c : in out d.Criteria; lngdf09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf09", op, join, lngdf09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf09;


   procedure Add_lngdf10( c : in out d.Criteria; lngdf10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf10", op, join, lngdf10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf10;


   procedure Add_nmtrans( c : in out d.Criteria; nmtrans : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nmtrans", op, join, nmtrans );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmtrans;


   procedure Add_noneng( c : in out d.Criteria; noneng : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "noneng", op, join, noneng );
   begin
      d.add_to_criteria( c, elem );
   end Add_noneng;


   procedure Add_whlang01( c : in out d.Criteria; whlang01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang01", op, join, whlang01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang01;


   procedure Add_whlang02( c : in out d.Criteria; whlang02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang02", op, join, whlang02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang02;


   procedure Add_whlang03( c : in out d.Criteria; whlang03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang03", op, join, whlang03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang03;


   procedure Add_whlang04( c : in out d.Criteria; whlang04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang04", op, join, whlang04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang04;


   procedure Add_whlang05( c : in out d.Criteria; whlang05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang05", op, join, whlang05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang05;


   procedure Add_whlang06( c : in out d.Criteria; whlang06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang06", op, join, whlang06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang06;


   procedure Add_whlang07( c : in out d.Criteria; whlang07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang07", op, join, whlang07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang07;


   procedure Add_whlang08( c : in out d.Criteria; whlang08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang08", op, join, whlang08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang08;


   procedure Add_whlang09( c : in out d.Criteria; whlang09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang09", op, join, whlang09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang09;


   procedure Add_whlang10( c : in out d.Criteria; whlang10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang10", op, join, whlang10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang10;


   procedure Add_whotran1( c : in out d.Criteria; whotran1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whotran1", op, join, whotran1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran1;


   procedure Add_whotran2( c : in out d.Criteria; whotran2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whotran2", op, join, whotran2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran2;


   procedure Add_whotran3( c : in out d.Criteria; whotran3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whotran3", op, join, whotran3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran3;


   procedure Add_whotran4( c : in out d.Criteria; whotran4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whotran4", op, join, whotran4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran4;


   procedure Add_whotran5( c : in out d.Criteria; whotran5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whotran5", op, join, whotran5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran5;


   procedure Add_lngdf11( c : in out d.Criteria; lngdf11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lngdf11", op, join, lngdf11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf11;


   procedure Add_whlang11( c : in out d.Criteria; whlang11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whlang11", op, join, whlang11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang11;


   
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


   procedure Add_findhh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "findhh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_findhh_To_Orderings;


   procedure Add_hhsel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhsel", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhsel_To_Orderings;


   procedure Add_hout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hout", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hout_To_Orderings;


   procedure Add_ncr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr1_To_Orderings;


   procedure Add_ncr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr2_To_Orderings;


   procedure Add_ncr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr3_To_Orderings;


   procedure Add_ncr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr4_To_Orderings;


   procedure Add_ncr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr5_To_Orderings;


   procedure Add_ncr6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr6_To_Orderings;


   procedure Add_ncr7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ncr7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ncr7_To_Orderings;


   procedure Add_refr01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr01_To_Orderings;


   procedure Add_refr02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr02_To_Orderings;


   procedure Add_refr03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr03_To_Orderings;


   procedure Add_refr04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr04_To_Orderings;


   procedure Add_refr05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr05_To_Orderings;


   procedure Add_refr06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr06_To_Orderings;


   procedure Add_refr07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr07_To_Orderings;


   procedure Add_refr08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr08_To_Orderings;


   procedure Add_refr09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr09_To_Orderings;


   procedure Add_refr10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr10_To_Orderings;


   procedure Add_refr11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr11_To_Orderings;


   procedure Add_refr12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr12_To_Orderings;


   procedure Add_refr13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr13_To_Orderings;


   procedure Add_refr14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr14_To_Orderings;


   procedure Add_refr15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr15_To_Orderings;


   procedure Add_refr16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr16_To_Orderings;


   procedure Add_refr17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr17_To_Orderings;


   procedure Add_refr18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "refr18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_refr18_To_Orderings;


   procedure Add_tnc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tnc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tnc_To_Orderings;


   procedure Add_version_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "version", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_version_To_Orderings;


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


   procedure Add_lngdf01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf01_To_Orderings;


   procedure Add_lngdf02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf02_To_Orderings;


   procedure Add_lngdf03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf03_To_Orderings;


   procedure Add_lngdf04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf04_To_Orderings;


   procedure Add_lngdf05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf05_To_Orderings;


   procedure Add_lngdf06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf06_To_Orderings;


   procedure Add_lngdf07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf07_To_Orderings;


   procedure Add_lngdf08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf08_To_Orderings;


   procedure Add_lngdf09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf09_To_Orderings;


   procedure Add_lngdf10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf10_To_Orderings;


   procedure Add_nmtrans_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nmtrans", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmtrans_To_Orderings;


   procedure Add_noneng_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "noneng", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_noneng_To_Orderings;


   procedure Add_whlang01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang01_To_Orderings;


   procedure Add_whlang02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang02_To_Orderings;


   procedure Add_whlang03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang03_To_Orderings;


   procedure Add_whlang04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang04_To_Orderings;


   procedure Add_whlang05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang05_To_Orderings;


   procedure Add_whlang06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang06_To_Orderings;


   procedure Add_whlang07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang07_To_Orderings;


   procedure Add_whlang08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang08_To_Orderings;


   procedure Add_whlang09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang09_To_Orderings;


   procedure Add_whlang10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang10_To_Orderings;


   procedure Add_whotran1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whotran1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran1_To_Orderings;


   procedure Add_whotran2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whotran2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran2_To_Orderings;


   procedure Add_whotran3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whotran3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran3_To_Orderings;


   procedure Add_whotran4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whotran4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran4_To_Orderings;


   procedure Add_whotran5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whotran5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whotran5_To_Orderings;


   procedure Add_lngdf11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lngdf11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lngdf11_To_Orderings;


   procedure Add_whlang11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whlang11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whlang11_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Admin_IO;
