--
-- Created by ada_generator.py on 2017-11-13 10:51:14.347222
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

package body Ukds.Frs.Care_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.CARE_IO" );
   
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
         "user_id, edition, year, counter, sernum, benunit, needper, daynight, freq, hour01," &
         "hour02, hour03, hour04, hour05, hour06, hour07, hour08, hour09, hour10, hour11," &
         "hour12, hour13, hour14, hour15, hour16, hour17, hour18, hour19, hour20, wholoo01," &
         "wholoo02, wholoo03, wholoo04, wholoo05, wholoo06, wholoo07, wholoo08, wholoo09, wholoo10, wholoo11," &
         "wholoo12, wholoo13, wholoo14, wholoo15, wholoo16, wholoo17, wholoo18, wholoo19, wholoo20, month," &
         "howlng01, howlng02, howlng03, howlng04, howlng05, howlng06, howlng07, howlng08, howlng09, howlng10," &
         "howlng11, howlng12, howlng13, howlng14, howlng15, howlng16, howlng17, howlng18, howlng19, howlng20," &
         "issue " &
         " from frs.care " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.care (" &
         "user_id, edition, year, counter, sernum, benunit, needper, daynight, freq, hour01," &
         "hour02, hour03, hour04, hour05, hour06, hour07, hour08, hour09, hour10, hour11," &
         "hour12, hour13, hour14, hour15, hour16, hour17, hour18, hour19, hour20, wholoo01," &
         "wholoo02, wholoo03, wholoo04, wholoo05, wholoo06, wholoo07, wholoo08, wholoo09, wholoo10, wholoo11," &
         "wholoo12, wholoo13, wholoo14, wholoo15, wholoo16, wholoo17, wholoo18, wholoo19, wholoo20, month," &
         "howlng01, howlng02, howlng03, howlng04, howlng05, howlng06, howlng07, howlng08, howlng09, howlng10," &
         "howlng11, howlng12, howlng13, howlng14, howlng15, howlng16, howlng17, howlng18, howlng19, howlng20," &
         "issue " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.care ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.care set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 71 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : needper (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : daynight (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : freq (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : hour01 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : hour02 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : hour03 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : hour04 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : hour05 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : hour06 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : hour07 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : hour08 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : hour09 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : hour10 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : hour11 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : hour12 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : hour13 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : hour14 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : hour15 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : hour16 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : hour17 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : hour18 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : hour19 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : hour20 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : wholoo01 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : wholoo02 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : wholoo03 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : wholoo04 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : wholoo05 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : wholoo06 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : wholoo07 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : wholoo08 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : wholoo09 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : wholoo10 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : wholoo11 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : wholoo12 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : wholoo13 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : wholoo14 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : wholoo15 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : wholoo16 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : wholoo17 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : wholoo18 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : wholoo19 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : wholoo20 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : howlng01 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : howlng02 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : howlng03 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : howlng04 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : howlng05 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : howlng06 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : howlng07 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : howlng08 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : howlng09 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : howlng10 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : howlng11 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : howlng12 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : howlng13 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : howlng14 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : howlng15 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : howlng16 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : howlng17 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : howlng18 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : howlng19 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : howlng20 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
           70 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           71 => ( Parameter_Integer, 0 )   --  : benunit (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : needper (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : daynight (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : freq (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : hour01 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : hour02 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : hour03 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : hour04 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : hour05 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : hour06 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : hour07 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : hour08 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : hour09 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : hour10 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : hour11 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : hour12 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : hour13 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : hour14 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : hour15 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : hour16 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : hour17 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : hour18 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : hour19 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : hour20 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : wholoo01 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : wholoo02 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : wholoo03 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : wholoo04 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : wholoo05 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : wholoo06 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : wholoo07 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : wholoo08 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : wholoo09 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : wholoo10 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : wholoo11 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : wholoo12 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : wholoo13 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : wholoo14 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : wholoo15 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : wholoo16 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : wholoo17 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : wholoo18 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : wholoo19 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : wholoo20 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : howlng01 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : howlng02 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : howlng03 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : howlng04 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : howlng05 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : howlng06 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : howlng07 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : howlng08 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : howlng09 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : howlng10 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : howlng11 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : howlng12 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : howlng13 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : howlng14 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : howlng15 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : howlng16 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : howlng17 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : howlng18 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : howlng19 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : howlng20 (Integer)
           71 => ( Parameter_Integer, 0 )   --  : issue (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71 )"; 
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
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 )   --  : benunit (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " needper = $1, daynight = $2, freq = $3, hour01 = $4, hour02 = $5, hour03 = $6, hour04 = $7, hour05 = $8, hour06 = $9, hour07 = $10, hour08 = $11, hour09 = $12, hour10 = $13, hour11 = $14, hour12 = $15, hour13 = $16, hour14 = $17, hour15 = $18, hour16 = $19, hour17 = $20, hour18 = $21, hour19 = $22, hour20 = $23, wholoo01 = $24, wholoo02 = $25, wholoo03 = $26, wholoo04 = $27, wholoo05 = $28, wholoo06 = $29, wholoo07 = $30, wholoo08 = $31, wholoo09 = $32, wholoo10 = $33, wholoo11 = $34, wholoo12 = $35, wholoo13 = $36, wholoo14 = $37, wholoo15 = $38, wholoo16 = $39, wholoo17 = $40, wholoo18 = $41, wholoo19 = $42, wholoo20 = $43, month = $44, howlng01 = $45, howlng02 = $46, howlng03 = $47, howlng04 = $48, howlng05 = $49, howlng06 = $50, howlng07 = $51, howlng08 = $52, howlng09 = $53, howlng10 = $54, howlng11 = $55, howlng12 = $56, howlng13 = $57, howlng14 = $58, howlng15 = $59, howlng16 = $60, howlng17 = $61, howlng18 = $62, howlng19 = $63, howlng20 = $64, issue = $65 where user_id = $66 and edition = $67 and year = $68 and counter = $69 and sernum = $70 and benunit = $71"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.care", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.care", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.care", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( counter ) + 1, 1 ) from frs.care", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.care", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.care", SCHEMA_NAME );
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



   --
   -- returns true if the primary key parts of Ukds.Frs.Care match the defaults in Ukds.Frs.Null_Care
   --
   --
   -- Does this Ukds.Frs.Care equal the default Ukds.Frs.Null_Care ?
   --
   function Is_Null( a_care : Care ) return Boolean is
   begin
      return a_care = Ukds.Frs.Null_Care;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Care matching the primary key fields, or the Ukds.Frs.Null_Care record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Ukds.Frs.Care is
      l : Ukds.Frs.Care_List;
      a_care : Ukds.Frs.Care;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_counter( c, counter );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Care_List_Package.is_empty( l ) ) then
         a_care := Ukds.Frs.Care_List_Package.First_Element( l );
      else
         a_care := Ukds.Frs.Null_Care;
      end if;
      return a_care;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.care where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Boolean  is
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
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Care matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Care_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Care retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Care is
      a_care : Ukds.Frs.Care;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_care.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_care.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_care.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_care.counter := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_care.sernum := Sernum_Value'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_care.benunit := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_care.needper := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_care.daynight := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_care.freq := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_care.hour01 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_care.hour02 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_care.hour03 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_care.hour04 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_care.hour05 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_care.hour06 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_care.hour07 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_care.hour08 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_care.hour09 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_care.hour10 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_care.hour11 := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_care.hour12 := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_care.hour13 := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_care.hour14 := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_care.hour15 := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_care.hour16 := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_care.hour17 := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_care.hour18 := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_care.hour19 := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_care.hour20 := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_care.wholoo01 := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_care.wholoo02 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_care.wholoo03 := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_care.wholoo04 := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_care.wholoo05 := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_care.wholoo06 := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_care.wholoo07 := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_care.wholoo08 := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_care.wholoo09 := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_care.wholoo10 := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_care.wholoo11 := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_care.wholoo12 := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_care.wholoo13 := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_care.wholoo14 := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_care.wholoo15 := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_care.wholoo16 := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_care.wholoo17 := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_care.wholoo18 := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_care.wholoo19 := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_care.wholoo20 := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_care.month := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_care.howlng01 := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_care.howlng02 := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_care.howlng03 := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_care.howlng04 := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_care.howlng05 := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_care.howlng06 := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_care.howlng07 := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_care.howlng08 := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_care.howlng09 := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_care.howlng10 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_care.howlng11 := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_care.howlng12 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_care.howlng13 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_care.howlng14 := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_care.howlng15 := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_care.howlng16 := gse.Integer_Value( cursor, 65 );
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_care.howlng17 := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_care.howlng18 := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_care.howlng19 := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_care.howlng20 := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_care.issue := gse.Integer_Value( cursor, 70 );
      end if;
      return a_care;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Care_List is
      l : Ukds.Frs.Care_List;
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
            a_care : Ukds.Frs.Care := Map_From_Cursor( cursor );
         begin
            l.append( a_care ); 
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
   
   procedure Update( a_care : Ukds.Frs.Care; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_care.needper ));
      params( 2 ) := "+"( Integer'Pos( a_care.daynight ));
      params( 3 ) := "+"( Integer'Pos( a_care.freq ));
      params( 4 ) := "+"( Integer'Pos( a_care.hour01 ));
      params( 5 ) := "+"( Integer'Pos( a_care.hour02 ));
      params( 6 ) := "+"( Integer'Pos( a_care.hour03 ));
      params( 7 ) := "+"( Integer'Pos( a_care.hour04 ));
      params( 8 ) := "+"( Integer'Pos( a_care.hour05 ));
      params( 9 ) := "+"( Integer'Pos( a_care.hour06 ));
      params( 10 ) := "+"( Integer'Pos( a_care.hour07 ));
      params( 11 ) := "+"( Integer'Pos( a_care.hour08 ));
      params( 12 ) := "+"( Integer'Pos( a_care.hour09 ));
      params( 13 ) := "+"( Integer'Pos( a_care.hour10 ));
      params( 14 ) := "+"( Integer'Pos( a_care.hour11 ));
      params( 15 ) := "+"( Integer'Pos( a_care.hour12 ));
      params( 16 ) := "+"( Integer'Pos( a_care.hour13 ));
      params( 17 ) := "+"( Integer'Pos( a_care.hour14 ));
      params( 18 ) := "+"( Integer'Pos( a_care.hour15 ));
      params( 19 ) := "+"( Integer'Pos( a_care.hour16 ));
      params( 20 ) := "+"( Integer'Pos( a_care.hour17 ));
      params( 21 ) := "+"( Integer'Pos( a_care.hour18 ));
      params( 22 ) := "+"( Integer'Pos( a_care.hour19 ));
      params( 23 ) := "+"( Integer'Pos( a_care.hour20 ));
      params( 24 ) := "+"( Integer'Pos( a_care.wholoo01 ));
      params( 25 ) := "+"( Integer'Pos( a_care.wholoo02 ));
      params( 26 ) := "+"( Integer'Pos( a_care.wholoo03 ));
      params( 27 ) := "+"( Integer'Pos( a_care.wholoo04 ));
      params( 28 ) := "+"( Integer'Pos( a_care.wholoo05 ));
      params( 29 ) := "+"( Integer'Pos( a_care.wholoo06 ));
      params( 30 ) := "+"( Integer'Pos( a_care.wholoo07 ));
      params( 31 ) := "+"( Integer'Pos( a_care.wholoo08 ));
      params( 32 ) := "+"( Integer'Pos( a_care.wholoo09 ));
      params( 33 ) := "+"( Integer'Pos( a_care.wholoo10 ));
      params( 34 ) := "+"( Integer'Pos( a_care.wholoo11 ));
      params( 35 ) := "+"( Integer'Pos( a_care.wholoo12 ));
      params( 36 ) := "+"( Integer'Pos( a_care.wholoo13 ));
      params( 37 ) := "+"( Integer'Pos( a_care.wholoo14 ));
      params( 38 ) := "+"( Integer'Pos( a_care.wholoo15 ));
      params( 39 ) := "+"( Integer'Pos( a_care.wholoo16 ));
      params( 40 ) := "+"( Integer'Pos( a_care.wholoo17 ));
      params( 41 ) := "+"( Integer'Pos( a_care.wholoo18 ));
      params( 42 ) := "+"( Integer'Pos( a_care.wholoo19 ));
      params( 43 ) := "+"( Integer'Pos( a_care.wholoo20 ));
      params( 44 ) := "+"( Integer'Pos( a_care.month ));
      params( 45 ) := "+"( Integer'Pos( a_care.howlng01 ));
      params( 46 ) := "+"( Integer'Pos( a_care.howlng02 ));
      params( 47 ) := "+"( Integer'Pos( a_care.howlng03 ));
      params( 48 ) := "+"( Integer'Pos( a_care.howlng04 ));
      params( 49 ) := "+"( Integer'Pos( a_care.howlng05 ));
      params( 50 ) := "+"( Integer'Pos( a_care.howlng06 ));
      params( 51 ) := "+"( Integer'Pos( a_care.howlng07 ));
      params( 52 ) := "+"( Integer'Pos( a_care.howlng08 ));
      params( 53 ) := "+"( Integer'Pos( a_care.howlng09 ));
      params( 54 ) := "+"( Integer'Pos( a_care.howlng10 ));
      params( 55 ) := "+"( Integer'Pos( a_care.howlng11 ));
      params( 56 ) := "+"( Integer'Pos( a_care.howlng12 ));
      params( 57 ) := "+"( Integer'Pos( a_care.howlng13 ));
      params( 58 ) := "+"( Integer'Pos( a_care.howlng14 ));
      params( 59 ) := "+"( Integer'Pos( a_care.howlng15 ));
      params( 60 ) := "+"( Integer'Pos( a_care.howlng16 ));
      params( 61 ) := "+"( Integer'Pos( a_care.howlng17 ));
      params( 62 ) := "+"( Integer'Pos( a_care.howlng18 ));
      params( 63 ) := "+"( Integer'Pos( a_care.howlng19 ));
      params( 64 ) := "+"( Integer'Pos( a_care.howlng20 ));
      params( 65 ) := "+"( Integer'Pos( a_care.issue ));
      params( 66 ) := "+"( Integer'Pos( a_care.user_id ));
      params( 67 ) := "+"( Integer'Pos( a_care.edition ));
      params( 68 ) := "+"( Integer'Pos( a_care.year ));
      params( 69 ) := "+"( Integer'Pos( a_care.counter ));
      params( 70 ) := As_Bigint( a_care.sernum );
      params( 71 ) := "+"( Integer'Pos( a_care.benunit ));
      
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

   procedure Save( a_care : Ukds.Frs.Care; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_care.user_id, a_care.edition, a_care.year, a_care.counter, a_care.sernum, a_care.benunit ) then
         Update( a_care, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_care.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_care.edition ));
      params( 3 ) := "+"( Integer'Pos( a_care.year ));
      params( 4 ) := "+"( Integer'Pos( a_care.counter ));
      params( 5 ) := As_Bigint( a_care.sernum );
      params( 6 ) := "+"( Integer'Pos( a_care.benunit ));
      params( 7 ) := "+"( Integer'Pos( a_care.needper ));
      params( 8 ) := "+"( Integer'Pos( a_care.daynight ));
      params( 9 ) := "+"( Integer'Pos( a_care.freq ));
      params( 10 ) := "+"( Integer'Pos( a_care.hour01 ));
      params( 11 ) := "+"( Integer'Pos( a_care.hour02 ));
      params( 12 ) := "+"( Integer'Pos( a_care.hour03 ));
      params( 13 ) := "+"( Integer'Pos( a_care.hour04 ));
      params( 14 ) := "+"( Integer'Pos( a_care.hour05 ));
      params( 15 ) := "+"( Integer'Pos( a_care.hour06 ));
      params( 16 ) := "+"( Integer'Pos( a_care.hour07 ));
      params( 17 ) := "+"( Integer'Pos( a_care.hour08 ));
      params( 18 ) := "+"( Integer'Pos( a_care.hour09 ));
      params( 19 ) := "+"( Integer'Pos( a_care.hour10 ));
      params( 20 ) := "+"( Integer'Pos( a_care.hour11 ));
      params( 21 ) := "+"( Integer'Pos( a_care.hour12 ));
      params( 22 ) := "+"( Integer'Pos( a_care.hour13 ));
      params( 23 ) := "+"( Integer'Pos( a_care.hour14 ));
      params( 24 ) := "+"( Integer'Pos( a_care.hour15 ));
      params( 25 ) := "+"( Integer'Pos( a_care.hour16 ));
      params( 26 ) := "+"( Integer'Pos( a_care.hour17 ));
      params( 27 ) := "+"( Integer'Pos( a_care.hour18 ));
      params( 28 ) := "+"( Integer'Pos( a_care.hour19 ));
      params( 29 ) := "+"( Integer'Pos( a_care.hour20 ));
      params( 30 ) := "+"( Integer'Pos( a_care.wholoo01 ));
      params( 31 ) := "+"( Integer'Pos( a_care.wholoo02 ));
      params( 32 ) := "+"( Integer'Pos( a_care.wholoo03 ));
      params( 33 ) := "+"( Integer'Pos( a_care.wholoo04 ));
      params( 34 ) := "+"( Integer'Pos( a_care.wholoo05 ));
      params( 35 ) := "+"( Integer'Pos( a_care.wholoo06 ));
      params( 36 ) := "+"( Integer'Pos( a_care.wholoo07 ));
      params( 37 ) := "+"( Integer'Pos( a_care.wholoo08 ));
      params( 38 ) := "+"( Integer'Pos( a_care.wholoo09 ));
      params( 39 ) := "+"( Integer'Pos( a_care.wholoo10 ));
      params( 40 ) := "+"( Integer'Pos( a_care.wholoo11 ));
      params( 41 ) := "+"( Integer'Pos( a_care.wholoo12 ));
      params( 42 ) := "+"( Integer'Pos( a_care.wholoo13 ));
      params( 43 ) := "+"( Integer'Pos( a_care.wholoo14 ));
      params( 44 ) := "+"( Integer'Pos( a_care.wholoo15 ));
      params( 45 ) := "+"( Integer'Pos( a_care.wholoo16 ));
      params( 46 ) := "+"( Integer'Pos( a_care.wholoo17 ));
      params( 47 ) := "+"( Integer'Pos( a_care.wholoo18 ));
      params( 48 ) := "+"( Integer'Pos( a_care.wholoo19 ));
      params( 49 ) := "+"( Integer'Pos( a_care.wholoo20 ));
      params( 50 ) := "+"( Integer'Pos( a_care.month ));
      params( 51 ) := "+"( Integer'Pos( a_care.howlng01 ));
      params( 52 ) := "+"( Integer'Pos( a_care.howlng02 ));
      params( 53 ) := "+"( Integer'Pos( a_care.howlng03 ));
      params( 54 ) := "+"( Integer'Pos( a_care.howlng04 ));
      params( 55 ) := "+"( Integer'Pos( a_care.howlng05 ));
      params( 56 ) := "+"( Integer'Pos( a_care.howlng06 ));
      params( 57 ) := "+"( Integer'Pos( a_care.howlng07 ));
      params( 58 ) := "+"( Integer'Pos( a_care.howlng08 ));
      params( 59 ) := "+"( Integer'Pos( a_care.howlng09 ));
      params( 60 ) := "+"( Integer'Pos( a_care.howlng10 ));
      params( 61 ) := "+"( Integer'Pos( a_care.howlng11 ));
      params( 62 ) := "+"( Integer'Pos( a_care.howlng12 ));
      params( 63 ) := "+"( Integer'Pos( a_care.howlng13 ));
      params( 64 ) := "+"( Integer'Pos( a_care.howlng14 ));
      params( 65 ) := "+"( Integer'Pos( a_care.howlng15 ));
      params( 66 ) := "+"( Integer'Pos( a_care.howlng16 ));
      params( 67 ) := "+"( Integer'Pos( a_care.howlng17 ));
      params( 68 ) := "+"( Integer'Pos( a_care.howlng18 ));
      params( 69 ) := "+"( Integer'Pos( a_care.howlng19 ));
      params( 70 ) := "+"( Integer'Pos( a_care.howlng20 ));
      params( 71 ) := "+"( Integer'Pos( a_care.issue ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Care
   --

   procedure Delete( a_care : in out Ukds.Frs.Care; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_care.user_id );
      Add_edition( c, a_care.edition );
      Add_year( c, a_care.year );
      Add_counter( c, a_care.counter );
      Add_sernum( c, a_care.sernum );
      Add_benunit( c, a_care.benunit );
      Delete( c, connection );
      a_care := Ukds.Frs.Null_Care;
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


   procedure Add_needper( c : in out d.Criteria; needper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "needper", op, join, needper );
   begin
      d.add_to_criteria( c, elem );
   end Add_needper;


   procedure Add_daynight( c : in out d.Criteria; daynight : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "daynight", op, join, daynight );
   begin
      d.add_to_criteria( c, elem );
   end Add_daynight;


   procedure Add_freq( c : in out d.Criteria; freq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "freq", op, join, freq );
   begin
      d.add_to_criteria( c, elem );
   end Add_freq;


   procedure Add_hour01( c : in out d.Criteria; hour01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour01", op, join, hour01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour01;


   procedure Add_hour02( c : in out d.Criteria; hour02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour02", op, join, hour02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour02;


   procedure Add_hour03( c : in out d.Criteria; hour03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour03", op, join, hour03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour03;


   procedure Add_hour04( c : in out d.Criteria; hour04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour04", op, join, hour04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour04;


   procedure Add_hour05( c : in out d.Criteria; hour05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour05", op, join, hour05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour05;


   procedure Add_hour06( c : in out d.Criteria; hour06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour06", op, join, hour06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour06;


   procedure Add_hour07( c : in out d.Criteria; hour07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour07", op, join, hour07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour07;


   procedure Add_hour08( c : in out d.Criteria; hour08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour08", op, join, hour08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour08;


   procedure Add_hour09( c : in out d.Criteria; hour09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour09", op, join, hour09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour09;


   procedure Add_hour10( c : in out d.Criteria; hour10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour10", op, join, hour10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour10;


   procedure Add_hour11( c : in out d.Criteria; hour11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour11", op, join, hour11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour11;


   procedure Add_hour12( c : in out d.Criteria; hour12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour12", op, join, hour12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour12;


   procedure Add_hour13( c : in out d.Criteria; hour13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour13", op, join, hour13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour13;


   procedure Add_hour14( c : in out d.Criteria; hour14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour14", op, join, hour14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour14;


   procedure Add_hour15( c : in out d.Criteria; hour15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour15", op, join, hour15 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour15;


   procedure Add_hour16( c : in out d.Criteria; hour16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour16", op, join, hour16 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour16;


   procedure Add_hour17( c : in out d.Criteria; hour17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour17", op, join, hour17 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour17;


   procedure Add_hour18( c : in out d.Criteria; hour18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour18", op, join, hour18 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour18;


   procedure Add_hour19( c : in out d.Criteria; hour19 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour19", op, join, hour19 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour19;


   procedure Add_hour20( c : in out d.Criteria; hour20 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hour20", op, join, hour20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour20;


   procedure Add_wholoo01( c : in out d.Criteria; wholoo01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo01", op, join, wholoo01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo01;


   procedure Add_wholoo02( c : in out d.Criteria; wholoo02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo02", op, join, wholoo02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo02;


   procedure Add_wholoo03( c : in out d.Criteria; wholoo03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo03", op, join, wholoo03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo03;


   procedure Add_wholoo04( c : in out d.Criteria; wholoo04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo04", op, join, wholoo04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo04;


   procedure Add_wholoo05( c : in out d.Criteria; wholoo05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo05", op, join, wholoo05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo05;


   procedure Add_wholoo06( c : in out d.Criteria; wholoo06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo06", op, join, wholoo06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo06;


   procedure Add_wholoo07( c : in out d.Criteria; wholoo07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo07", op, join, wholoo07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo07;


   procedure Add_wholoo08( c : in out d.Criteria; wholoo08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo08", op, join, wholoo08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo08;


   procedure Add_wholoo09( c : in out d.Criteria; wholoo09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo09", op, join, wholoo09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo09;


   procedure Add_wholoo10( c : in out d.Criteria; wholoo10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo10", op, join, wholoo10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo10;


   procedure Add_wholoo11( c : in out d.Criteria; wholoo11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo11", op, join, wholoo11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo11;


   procedure Add_wholoo12( c : in out d.Criteria; wholoo12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo12", op, join, wholoo12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo12;


   procedure Add_wholoo13( c : in out d.Criteria; wholoo13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo13", op, join, wholoo13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo13;


   procedure Add_wholoo14( c : in out d.Criteria; wholoo14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo14", op, join, wholoo14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo14;


   procedure Add_wholoo15( c : in out d.Criteria; wholoo15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo15", op, join, wholoo15 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo15;


   procedure Add_wholoo16( c : in out d.Criteria; wholoo16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo16", op, join, wholoo16 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo16;


   procedure Add_wholoo17( c : in out d.Criteria; wholoo17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo17", op, join, wholoo17 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo17;


   procedure Add_wholoo18( c : in out d.Criteria; wholoo18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo18", op, join, wholoo18 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo18;


   procedure Add_wholoo19( c : in out d.Criteria; wholoo19 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo19", op, join, wholoo19 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo19;


   procedure Add_wholoo20( c : in out d.Criteria; wholoo20 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wholoo20", op, join, wholoo20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo20;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_howlng01( c : in out d.Criteria; howlng01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng01", op, join, howlng01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng01;


   procedure Add_howlng02( c : in out d.Criteria; howlng02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng02", op, join, howlng02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng02;


   procedure Add_howlng03( c : in out d.Criteria; howlng03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng03", op, join, howlng03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng03;


   procedure Add_howlng04( c : in out d.Criteria; howlng04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng04", op, join, howlng04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng04;


   procedure Add_howlng05( c : in out d.Criteria; howlng05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng05", op, join, howlng05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng05;


   procedure Add_howlng06( c : in out d.Criteria; howlng06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng06", op, join, howlng06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng06;


   procedure Add_howlng07( c : in out d.Criteria; howlng07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng07", op, join, howlng07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng07;


   procedure Add_howlng08( c : in out d.Criteria; howlng08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng08", op, join, howlng08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng08;


   procedure Add_howlng09( c : in out d.Criteria; howlng09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng09", op, join, howlng09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng09;


   procedure Add_howlng10( c : in out d.Criteria; howlng10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng10", op, join, howlng10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng10;


   procedure Add_howlng11( c : in out d.Criteria; howlng11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng11", op, join, howlng11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng11;


   procedure Add_howlng12( c : in out d.Criteria; howlng12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng12", op, join, howlng12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng12;


   procedure Add_howlng13( c : in out d.Criteria; howlng13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng13", op, join, howlng13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng13;


   procedure Add_howlng14( c : in out d.Criteria; howlng14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng14", op, join, howlng14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng14;


   procedure Add_howlng15( c : in out d.Criteria; howlng15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng15", op, join, howlng15 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng15;


   procedure Add_howlng16( c : in out d.Criteria; howlng16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng16", op, join, howlng16 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng16;


   procedure Add_howlng17( c : in out d.Criteria; howlng17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng17", op, join, howlng17 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng17;


   procedure Add_howlng18( c : in out d.Criteria; howlng18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng18", op, join, howlng18 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng18;


   procedure Add_howlng19( c : in out d.Criteria; howlng19 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng19", op, join, howlng19 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng19;


   procedure Add_howlng20( c : in out d.Criteria; howlng20 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howlng20", op, join, howlng20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng20;


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


   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benunit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit_To_Orderings;


   procedure Add_needper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "needper", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_needper_To_Orderings;


   procedure Add_daynight_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "daynight", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_daynight_To_Orderings;


   procedure Add_freq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "freq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_freq_To_Orderings;


   procedure Add_hour01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour01_To_Orderings;


   procedure Add_hour02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour02_To_Orderings;


   procedure Add_hour03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour03_To_Orderings;


   procedure Add_hour04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour04_To_Orderings;


   procedure Add_hour05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour05_To_Orderings;


   procedure Add_hour06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour06_To_Orderings;


   procedure Add_hour07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour07_To_Orderings;


   procedure Add_hour08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour08_To_Orderings;


   procedure Add_hour09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour09_To_Orderings;


   procedure Add_hour10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour10_To_Orderings;


   procedure Add_hour11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour11_To_Orderings;


   procedure Add_hour12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour12_To_Orderings;


   procedure Add_hour13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour13_To_Orderings;


   procedure Add_hour14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour14_To_Orderings;


   procedure Add_hour15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour15_To_Orderings;


   procedure Add_hour16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour16_To_Orderings;


   procedure Add_hour17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour17_To_Orderings;


   procedure Add_hour18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour18_To_Orderings;


   procedure Add_hour19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour19_To_Orderings;


   procedure Add_hour20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hour20", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hour20_To_Orderings;


   procedure Add_wholoo01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo01_To_Orderings;


   procedure Add_wholoo02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo02_To_Orderings;


   procedure Add_wholoo03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo03_To_Orderings;


   procedure Add_wholoo04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo04_To_Orderings;


   procedure Add_wholoo05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo05_To_Orderings;


   procedure Add_wholoo06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo06_To_Orderings;


   procedure Add_wholoo07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo07_To_Orderings;


   procedure Add_wholoo08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo08_To_Orderings;


   procedure Add_wholoo09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo09_To_Orderings;


   procedure Add_wholoo10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo10_To_Orderings;


   procedure Add_wholoo11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo11_To_Orderings;


   procedure Add_wholoo12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo12_To_Orderings;


   procedure Add_wholoo13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo13_To_Orderings;


   procedure Add_wholoo14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo14_To_Orderings;


   procedure Add_wholoo15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo15_To_Orderings;


   procedure Add_wholoo16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo16_To_Orderings;


   procedure Add_wholoo17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo17_To_Orderings;


   procedure Add_wholoo18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo18_To_Orderings;


   procedure Add_wholoo19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo19_To_Orderings;


   procedure Add_wholoo20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wholoo20", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wholoo20_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_howlng01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng01_To_Orderings;


   procedure Add_howlng02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng02_To_Orderings;


   procedure Add_howlng03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng03_To_Orderings;


   procedure Add_howlng04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng04_To_Orderings;


   procedure Add_howlng05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng05_To_Orderings;


   procedure Add_howlng06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng06_To_Orderings;


   procedure Add_howlng07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng07_To_Orderings;


   procedure Add_howlng08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng08_To_Orderings;


   procedure Add_howlng09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng09_To_Orderings;


   procedure Add_howlng10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng10_To_Orderings;


   procedure Add_howlng11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng11_To_Orderings;


   procedure Add_howlng12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng12_To_Orderings;


   procedure Add_howlng13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng13_To_Orderings;


   procedure Add_howlng14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng14_To_Orderings;


   procedure Add_howlng15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng15_To_Orderings;


   procedure Add_howlng16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng16_To_Orderings;


   procedure Add_howlng17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng17_To_Orderings;


   procedure Add_howlng18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng18_To_Orderings;


   procedure Add_howlng19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng19_To_Orderings;


   procedure Add_howlng20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howlng20", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howlng20_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Care_IO;
