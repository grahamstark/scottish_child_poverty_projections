--
-- Created by ada_generator.py on 2017-10-25 13:04:27.752896
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

package body Ukds.Frs.Pianon0910_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.PIANON0910_IO" );
   
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
         "user_id, edition, year, gvtregn, fambu, newfambu, sexhd, adultb, ethgrphh, benunit," &
         "gs_newbu, gs_newpp, mbhcdec, obhcdec, mahcdec, oahcdec, sexsp, pidefbhc, pidefahc, pigrosbu," &
         "pinincbu, pigoccbu, pippenbu, piginvbu, pigernbu, pibenibu, piothibu, pinahcbu, piirbbu, pidisben," &
         "piretben, pripenbu, nonben2bu, perbenbu, perbenbu2, rrpen, newfambu2, newfamb2, dummy, coup_q1," &
         "coup_q2, coup_q3, coup_q4, coup_q5, acou_q1, acou_q2, acou_q3, acou_q4, acou_q5, sing_q1," &
         "sing_q2, sing_q3, sing_q4, sing_q5, asin_q1, asin_q2, asin_q3, asin_q4, asin_q5, clust," &
         "strat, agehd80, agesp80, sernum " &
         " from frs.pianon0910 " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.pianon0910 (" &
         "user_id, edition, year, gvtregn, fambu, newfambu, sexhd, adultb, ethgrphh, benunit," &
         "gs_newbu, gs_newpp, mbhcdec, obhcdec, mahcdec, oahcdec, sexsp, pidefbhc, pidefahc, pigrosbu," &
         "pinincbu, pigoccbu, pippenbu, piginvbu, pigernbu, pibenibu, piothibu, pinahcbu, piirbbu, pidisben," &
         "piretben, pripenbu, nonben2bu, perbenbu, perbenbu2, rrpen, newfambu2, newfamb2, dummy, coup_q1," &
         "coup_q2, coup_q3, coup_q4, coup_q5, acou_q1, acou_q2, acou_q3, acou_q4, acou_q5, sing_q1," &
         "sing_q2, sing_q3, sing_q4, sing_q5, asin_q1, asin_q2, asin_q3, asin_q4, asin_q5, clust," &
         "strat, agehd80, agesp80, sernum " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.pianon0910 ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.pianon0910 set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 64 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : gvtregn (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : fambu (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : newfambu (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : sexhd (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : adultb (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : ethgrphh (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : gs_newbu (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : gs_newpp (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : mbhcdec (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : obhcdec (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : mahcdec (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : oahcdec (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : sexsp (Integer)
           14 => ( Parameter_Float, 0.0 ),   --  : pidefbhc (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : pidefahc (Amount)
           16 => ( Parameter_Integer, 0 ),   --  : pigrosbu (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : pinincbu (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : pigoccbu (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : pippenbu (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : piginvbu (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : pigernbu (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : pibenibu (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : piothibu (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : pinahcbu (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : piirbbu (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : pidisben (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : piretben (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : pripenbu (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : nonben2bu (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : perbenbu (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : perbenbu2 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : rrpen (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : newfambu2 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : newfamb2 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : dummy (Integer)
           36 => ( Parameter_Float, 0.0 ),   --  : coup_q1 (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : coup_q2 (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : coup_q3 (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : coup_q4 (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : coup_q5 (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : acou_q1 (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : acou_q2 (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : acou_q3 (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : acou_q4 (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : acou_q5 (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : sing_q1 (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : sing_q2 (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : sing_q3 (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : sing_q4 (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : sing_q5 (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : asin_q1 (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : asin_q2 (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : asin_q3 (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : asin_q4 (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : asin_q5 (Amount)
           56 => ( Parameter_Integer, 0 ),   --  : clust (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : strat (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : agehd80 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : agesp80 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           64 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : gvtregn (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : fambu (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : newfambu (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : sexhd (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : adultb (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : ethgrphh (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : gs_newbu (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : gs_newpp (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : mbhcdec (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : obhcdec (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : mahcdec (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : oahcdec (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : sexsp (Integer)
           18 => ( Parameter_Float, 0.0 ),   --  : pidefbhc (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : pidefahc (Amount)
           20 => ( Parameter_Integer, 0 ),   --  : pigrosbu (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : pinincbu (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : pigoccbu (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : pippenbu (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : piginvbu (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : pigernbu (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : pibenibu (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : piothibu (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : pinahcbu (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : piirbbu (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : pidisben (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : piretben (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : pripenbu (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : nonben2bu (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : perbenbu (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : perbenbu2 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : rrpen (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : newfambu2 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : newfamb2 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : dummy (Integer)
           40 => ( Parameter_Float, 0.0 ),   --  : coup_q1 (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : coup_q2 (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : coup_q3 (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : coup_q4 (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : coup_q5 (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : acou_q1 (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : acou_q2 (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : acou_q3 (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : acou_q4 (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : acou_q5 (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : sing_q1 (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : sing_q2 (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : sing_q3 (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : sing_q4 (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : sing_q5 (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : asin_q1 (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : asin_q2 (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : asin_q3 (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : asin_q4 (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : asin_q5 (Amount)
           60 => ( Parameter_Integer, 0 ),   --  : clust (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : strat (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : agehd80 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : agesp80 (Integer)
           64 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64 )"; 
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
            4 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            5 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and benunit = $4 and sernum = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " gvtregn = $1, fambu = $2, newfambu = $3, sexhd = $4, adultb = $5, ethgrphh = $6, gs_newbu = $7, gs_newpp = $8, mbhcdec = $9, obhcdec = $10, mahcdec = $11, oahcdec = $12, sexsp = $13, pidefbhc = $14, pidefahc = $15, pigrosbu = $16, pinincbu = $17, pigoccbu = $18, pippenbu = $19, piginvbu = $20, pigernbu = $21, pibenibu = $22, piothibu = $23, pinahcbu = $24, piirbbu = $25, pidisben = $26, piretben = $27, pripenbu = $28, nonben2bu = $29, perbenbu = $30, perbenbu2 = $31, rrpen = $32, newfambu2 = $33, newfamb2 = $34, dummy = $35, coup_q1 = $36, coup_q2 = $37, coup_q3 = $38, coup_q4 = $39, coup_q5 = $40, acou_q1 = $41, acou_q2 = $42, acou_q3 = $43, acou_q4 = $44, acou_q5 = $45, sing_q1 = $46, sing_q2 = $47, sing_q3 = $48, sing_q4 = $49, sing_q5 = $50, asin_q1 = $51, asin_q2 = $52, asin_q3 = $53, asin_q4 = $54, asin_q5 = $55, clust = $56, strat = $57, agehd80 = $58, agesp80 = $59 where user_id = $60 and edition = $61 and year = $62 and benunit = $63 and sernum = $64"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.pianon0910", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.pianon0910", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.pianon0910", SCHEMA_NAME );
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


   Next_Free_benunit_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.pianon0910", SCHEMA_NAME );
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


   Next_Free_sernum_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.pianon0910", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Frs.Pianon0910 match the defaults in Ukds.Frs.Null_Pianon0910
   --
   --
   -- Does this Ukds.Frs.Pianon0910 equal the default Ukds.Frs.Null_Pianon0910 ?
   --
   function Is_Null( a_pianon0910 : Pianon0910 ) return Boolean is
   begin
      return a_pianon0910 = Ukds.Frs.Null_Pianon0910;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Pianon0910 matching the primary key fields, or the Ukds.Frs.Null_Pianon0910 record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; benunit : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910 is
      l : Ukds.Frs.Pianon0910_List;
      a_pianon0910 : Ukds.Frs.Pianon0910;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_benunit( c, benunit );
      Add_sernum( c, sernum );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Pianon0910_List_Package.is_empty( l ) ) then
         a_pianon0910 := Ukds.Frs.Pianon0910_List_Package.First_Element( l );
      else
         a_pianon0910 := Ukds.Frs.Null_Pianon0910;
      end if;
      return a_pianon0910;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.pianon0910 where user_id = $1 and edition = $2 and year = $3 and benunit = $4 and sernum = $5", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; benunit : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean  is
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
      params( 4 ) := "+"( Integer'Pos( benunit ));
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
   -- Retrieves a list of Pianon0910 matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Pianon0910 retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Pianon0910 is
      a_pianon0910 : Ukds.Frs.Pianon0910;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_pianon0910.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_pianon0910.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_pianon0910.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_pianon0910.gvtregn := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_pianon0910.fambu := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_pianon0910.newfambu := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_pianon0910.sexhd := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_pianon0910.adultb := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_pianon0910.ethgrphh := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_pianon0910.benunit := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_pianon0910.gs_newbu := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_pianon0910.gs_newpp := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_pianon0910.mbhcdec := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_pianon0910.obhcdec := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_pianon0910.mahcdec := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_pianon0910.oahcdec := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_pianon0910.sexsp := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_pianon0910.pidefbhc:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_pianon0910.pidefahc:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_pianon0910.pigrosbu := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_pianon0910.pinincbu := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_pianon0910.pigoccbu := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_pianon0910.pippenbu := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_pianon0910.piginvbu := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_pianon0910.pigernbu := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_pianon0910.pibenibu := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_pianon0910.piothibu := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_pianon0910.pinahcbu := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_pianon0910.piirbbu := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_pianon0910.pidisben := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_pianon0910.piretben := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_pianon0910.pripenbu := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_pianon0910.nonben2bu := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_pianon0910.perbenbu := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_pianon0910.perbenbu2 := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_pianon0910.rrpen := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_pianon0910.newfambu2 := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_pianon0910.newfamb2 := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_pianon0910.dummy := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_pianon0910.coup_q1:= Amount'Value( gse.Value( cursor, 39 ));
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_pianon0910.coup_q2:= Amount'Value( gse.Value( cursor, 40 ));
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_pianon0910.coup_q3:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_pianon0910.coup_q4:= Amount'Value( gse.Value( cursor, 42 ));
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_pianon0910.coup_q5:= Amount'Value( gse.Value( cursor, 43 ));
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_pianon0910.acou_q1:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_pianon0910.acou_q2:= Amount'Value( gse.Value( cursor, 45 ));
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_pianon0910.acou_q3:= Amount'Value( gse.Value( cursor, 46 ));
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_pianon0910.acou_q4:= Amount'Value( gse.Value( cursor, 47 ));
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_pianon0910.acou_q5:= Amount'Value( gse.Value( cursor, 48 ));
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_pianon0910.sing_q1:= Amount'Value( gse.Value( cursor, 49 ));
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_pianon0910.sing_q2:= Amount'Value( gse.Value( cursor, 50 ));
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_pianon0910.sing_q3:= Amount'Value( gse.Value( cursor, 51 ));
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_pianon0910.sing_q4:= Amount'Value( gse.Value( cursor, 52 ));
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_pianon0910.sing_q5:= Amount'Value( gse.Value( cursor, 53 ));
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_pianon0910.asin_q1:= Amount'Value( gse.Value( cursor, 54 ));
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_pianon0910.asin_q2:= Amount'Value( gse.Value( cursor, 55 ));
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_pianon0910.asin_q3:= Amount'Value( gse.Value( cursor, 56 ));
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_pianon0910.asin_q4:= Amount'Value( gse.Value( cursor, 57 ));
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_pianon0910.asin_q5:= Amount'Value( gse.Value( cursor, 58 ));
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_pianon0910.clust := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_pianon0910.strat := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_pianon0910.agehd80 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_pianon0910.agesp80 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_pianon0910.sernum := Sernum_Value'Value( gse.Value( cursor, 63 ));
      end if;
      return a_pianon0910;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910_List is
      l : Ukds.Frs.Pianon0910_List;
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
            a_pianon0910 : Ukds.Frs.Pianon0910 := Map_From_Cursor( cursor );
         begin
            l.append( a_pianon0910 ); 
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
   
   procedure Update( a_pianon0910 : Ukds.Frs.Pianon0910; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_pianon0910.gvtregn ));
      params( 2 ) := "+"( Integer'Pos( a_pianon0910.fambu ));
      params( 3 ) := "+"( Integer'Pos( a_pianon0910.newfambu ));
      params( 4 ) := "+"( Integer'Pos( a_pianon0910.sexhd ));
      params( 5 ) := "+"( Integer'Pos( a_pianon0910.adultb ));
      params( 6 ) := "+"( Integer'Pos( a_pianon0910.ethgrphh ));
      params( 7 ) := "+"( Integer'Pos( a_pianon0910.gs_newbu ));
      params( 8 ) := "+"( Integer'Pos( a_pianon0910.gs_newpp ));
      params( 9 ) := "+"( Integer'Pos( a_pianon0910.mbhcdec ));
      params( 10 ) := "+"( Integer'Pos( a_pianon0910.obhcdec ));
      params( 11 ) := "+"( Integer'Pos( a_pianon0910.mahcdec ));
      params( 12 ) := "+"( Integer'Pos( a_pianon0910.oahcdec ));
      params( 13 ) := "+"( Integer'Pos( a_pianon0910.sexsp ));
      params( 14 ) := "+"( Float( a_pianon0910.pidefbhc ));
      params( 15 ) := "+"( Float( a_pianon0910.pidefahc ));
      params( 16 ) := "+"( Integer'Pos( a_pianon0910.pigrosbu ));
      params( 17 ) := "+"( Integer'Pos( a_pianon0910.pinincbu ));
      params( 18 ) := "+"( Integer'Pos( a_pianon0910.pigoccbu ));
      params( 19 ) := "+"( Integer'Pos( a_pianon0910.pippenbu ));
      params( 20 ) := "+"( Integer'Pos( a_pianon0910.piginvbu ));
      params( 21 ) := "+"( Integer'Pos( a_pianon0910.pigernbu ));
      params( 22 ) := "+"( Integer'Pos( a_pianon0910.pibenibu ));
      params( 23 ) := "+"( Integer'Pos( a_pianon0910.piothibu ));
      params( 24 ) := "+"( Integer'Pos( a_pianon0910.pinahcbu ));
      params( 25 ) := "+"( Integer'Pos( a_pianon0910.piirbbu ));
      params( 26 ) := "+"( Integer'Pos( a_pianon0910.pidisben ));
      params( 27 ) := "+"( Integer'Pos( a_pianon0910.piretben ));
      params( 28 ) := "+"( Integer'Pos( a_pianon0910.pripenbu ));
      params( 29 ) := "+"( Integer'Pos( a_pianon0910.nonben2bu ));
      params( 30 ) := "+"( Integer'Pos( a_pianon0910.perbenbu ));
      params( 31 ) := "+"( Integer'Pos( a_pianon0910.perbenbu2 ));
      params( 32 ) := "+"( Integer'Pos( a_pianon0910.rrpen ));
      params( 33 ) := "+"( Integer'Pos( a_pianon0910.newfambu2 ));
      params( 34 ) := "+"( Integer'Pos( a_pianon0910.newfamb2 ));
      params( 35 ) := "+"( Integer'Pos( a_pianon0910.dummy ));
      params( 36 ) := "+"( Float( a_pianon0910.coup_q1 ));
      params( 37 ) := "+"( Float( a_pianon0910.coup_q2 ));
      params( 38 ) := "+"( Float( a_pianon0910.coup_q3 ));
      params( 39 ) := "+"( Float( a_pianon0910.coup_q4 ));
      params( 40 ) := "+"( Float( a_pianon0910.coup_q5 ));
      params( 41 ) := "+"( Float( a_pianon0910.acou_q1 ));
      params( 42 ) := "+"( Float( a_pianon0910.acou_q2 ));
      params( 43 ) := "+"( Float( a_pianon0910.acou_q3 ));
      params( 44 ) := "+"( Float( a_pianon0910.acou_q4 ));
      params( 45 ) := "+"( Float( a_pianon0910.acou_q5 ));
      params( 46 ) := "+"( Float( a_pianon0910.sing_q1 ));
      params( 47 ) := "+"( Float( a_pianon0910.sing_q2 ));
      params( 48 ) := "+"( Float( a_pianon0910.sing_q3 ));
      params( 49 ) := "+"( Float( a_pianon0910.sing_q4 ));
      params( 50 ) := "+"( Float( a_pianon0910.sing_q5 ));
      params( 51 ) := "+"( Float( a_pianon0910.asin_q1 ));
      params( 52 ) := "+"( Float( a_pianon0910.asin_q2 ));
      params( 53 ) := "+"( Float( a_pianon0910.asin_q3 ));
      params( 54 ) := "+"( Float( a_pianon0910.asin_q4 ));
      params( 55 ) := "+"( Float( a_pianon0910.asin_q5 ));
      params( 56 ) := "+"( Integer'Pos( a_pianon0910.clust ));
      params( 57 ) := "+"( Integer'Pos( a_pianon0910.strat ));
      params( 58 ) := "+"( Integer'Pos( a_pianon0910.agehd80 ));
      params( 59 ) := "+"( Integer'Pos( a_pianon0910.agesp80 ));
      params( 60 ) := "+"( Integer'Pos( a_pianon0910.user_id ));
      params( 61 ) := "+"( Integer'Pos( a_pianon0910.edition ));
      params( 62 ) := "+"( Integer'Pos( a_pianon0910.year ));
      params( 63 ) := "+"( Integer'Pos( a_pianon0910.benunit ));
      params( 64 ) := As_Bigint( a_pianon0910.sernum );
      
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

   procedure Save( a_pianon0910 : Ukds.Frs.Pianon0910; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_pianon0910.user_id, a_pianon0910.edition, a_pianon0910.year, a_pianon0910.benunit, a_pianon0910.sernum ) then
         Update( a_pianon0910, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_pianon0910.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_pianon0910.edition ));
      params( 3 ) := "+"( Integer'Pos( a_pianon0910.year ));
      params( 4 ) := "+"( Integer'Pos( a_pianon0910.gvtregn ));
      params( 5 ) := "+"( Integer'Pos( a_pianon0910.fambu ));
      params( 6 ) := "+"( Integer'Pos( a_pianon0910.newfambu ));
      params( 7 ) := "+"( Integer'Pos( a_pianon0910.sexhd ));
      params( 8 ) := "+"( Integer'Pos( a_pianon0910.adultb ));
      params( 9 ) := "+"( Integer'Pos( a_pianon0910.ethgrphh ));
      params( 10 ) := "+"( Integer'Pos( a_pianon0910.benunit ));
      params( 11 ) := "+"( Integer'Pos( a_pianon0910.gs_newbu ));
      params( 12 ) := "+"( Integer'Pos( a_pianon0910.gs_newpp ));
      params( 13 ) := "+"( Integer'Pos( a_pianon0910.mbhcdec ));
      params( 14 ) := "+"( Integer'Pos( a_pianon0910.obhcdec ));
      params( 15 ) := "+"( Integer'Pos( a_pianon0910.mahcdec ));
      params( 16 ) := "+"( Integer'Pos( a_pianon0910.oahcdec ));
      params( 17 ) := "+"( Integer'Pos( a_pianon0910.sexsp ));
      params( 18 ) := "+"( Float( a_pianon0910.pidefbhc ));
      params( 19 ) := "+"( Float( a_pianon0910.pidefahc ));
      params( 20 ) := "+"( Integer'Pos( a_pianon0910.pigrosbu ));
      params( 21 ) := "+"( Integer'Pos( a_pianon0910.pinincbu ));
      params( 22 ) := "+"( Integer'Pos( a_pianon0910.pigoccbu ));
      params( 23 ) := "+"( Integer'Pos( a_pianon0910.pippenbu ));
      params( 24 ) := "+"( Integer'Pos( a_pianon0910.piginvbu ));
      params( 25 ) := "+"( Integer'Pos( a_pianon0910.pigernbu ));
      params( 26 ) := "+"( Integer'Pos( a_pianon0910.pibenibu ));
      params( 27 ) := "+"( Integer'Pos( a_pianon0910.piothibu ));
      params( 28 ) := "+"( Integer'Pos( a_pianon0910.pinahcbu ));
      params( 29 ) := "+"( Integer'Pos( a_pianon0910.piirbbu ));
      params( 30 ) := "+"( Integer'Pos( a_pianon0910.pidisben ));
      params( 31 ) := "+"( Integer'Pos( a_pianon0910.piretben ));
      params( 32 ) := "+"( Integer'Pos( a_pianon0910.pripenbu ));
      params( 33 ) := "+"( Integer'Pos( a_pianon0910.nonben2bu ));
      params( 34 ) := "+"( Integer'Pos( a_pianon0910.perbenbu ));
      params( 35 ) := "+"( Integer'Pos( a_pianon0910.perbenbu2 ));
      params( 36 ) := "+"( Integer'Pos( a_pianon0910.rrpen ));
      params( 37 ) := "+"( Integer'Pos( a_pianon0910.newfambu2 ));
      params( 38 ) := "+"( Integer'Pos( a_pianon0910.newfamb2 ));
      params( 39 ) := "+"( Integer'Pos( a_pianon0910.dummy ));
      params( 40 ) := "+"( Float( a_pianon0910.coup_q1 ));
      params( 41 ) := "+"( Float( a_pianon0910.coup_q2 ));
      params( 42 ) := "+"( Float( a_pianon0910.coup_q3 ));
      params( 43 ) := "+"( Float( a_pianon0910.coup_q4 ));
      params( 44 ) := "+"( Float( a_pianon0910.coup_q5 ));
      params( 45 ) := "+"( Float( a_pianon0910.acou_q1 ));
      params( 46 ) := "+"( Float( a_pianon0910.acou_q2 ));
      params( 47 ) := "+"( Float( a_pianon0910.acou_q3 ));
      params( 48 ) := "+"( Float( a_pianon0910.acou_q4 ));
      params( 49 ) := "+"( Float( a_pianon0910.acou_q5 ));
      params( 50 ) := "+"( Float( a_pianon0910.sing_q1 ));
      params( 51 ) := "+"( Float( a_pianon0910.sing_q2 ));
      params( 52 ) := "+"( Float( a_pianon0910.sing_q3 ));
      params( 53 ) := "+"( Float( a_pianon0910.sing_q4 ));
      params( 54 ) := "+"( Float( a_pianon0910.sing_q5 ));
      params( 55 ) := "+"( Float( a_pianon0910.asin_q1 ));
      params( 56 ) := "+"( Float( a_pianon0910.asin_q2 ));
      params( 57 ) := "+"( Float( a_pianon0910.asin_q3 ));
      params( 58 ) := "+"( Float( a_pianon0910.asin_q4 ));
      params( 59 ) := "+"( Float( a_pianon0910.asin_q5 ));
      params( 60 ) := "+"( Integer'Pos( a_pianon0910.clust ));
      params( 61 ) := "+"( Integer'Pos( a_pianon0910.strat ));
      params( 62 ) := "+"( Integer'Pos( a_pianon0910.agehd80 ));
      params( 63 ) := "+"( Integer'Pos( a_pianon0910.agesp80 ));
      params( 64 ) := As_Bigint( a_pianon0910.sernum );
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Pianon0910
   --

   procedure Delete( a_pianon0910 : in out Ukds.Frs.Pianon0910; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_pianon0910.user_id );
      Add_edition( c, a_pianon0910.edition );
      Add_year( c, a_pianon0910.year );
      Add_benunit( c, a_pianon0910.benunit );
      Add_sernum( c, a_pianon0910.sernum );
      Delete( c, connection );
      a_pianon0910 := Ukds.Frs.Null_Pianon0910;
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


   procedure Add_gvtregn( c : in out d.Criteria; gvtregn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gvtregn", op, join, gvtregn );
   begin
      d.add_to_criteria( c, elem );
   end Add_gvtregn;


   procedure Add_fambu( c : in out d.Criteria; fambu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fambu", op, join, fambu );
   begin
      d.add_to_criteria( c, elem );
   end Add_fambu;


   procedure Add_newfambu( c : in out d.Criteria; newfambu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "newfambu", op, join, newfambu );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfambu;


   procedure Add_sexhd( c : in out d.Criteria; sexhd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sexhd", op, join, sexhd );
   begin
      d.add_to_criteria( c, elem );
   end Add_sexhd;


   procedure Add_adultb( c : in out d.Criteria; adultb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adultb", op, join, adultb );
   begin
      d.add_to_criteria( c, elem );
   end Add_adultb;


   procedure Add_ethgrphh( c : in out d.Criteria; ethgrphh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ethgrphh", op, join, ethgrphh );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgrphh;


   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benunit", op, join, benunit );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit;


   procedure Add_gs_newbu( c : in out d.Criteria; gs_newbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gs_newbu", op, join, gs_newbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_gs_newbu;


   procedure Add_gs_newpp( c : in out d.Criteria; gs_newpp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gs_newpp", op, join, gs_newpp );
   begin
      d.add_to_criteria( c, elem );
   end Add_gs_newpp;


   procedure Add_mbhcdec( c : in out d.Criteria; mbhcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mbhcdec", op, join, mbhcdec );
   begin
      d.add_to_criteria( c, elem );
   end Add_mbhcdec;


   procedure Add_obhcdec( c : in out d.Criteria; obhcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "obhcdec", op, join, obhcdec );
   begin
      d.add_to_criteria( c, elem );
   end Add_obhcdec;


   procedure Add_mahcdec( c : in out d.Criteria; mahcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mahcdec", op, join, mahcdec );
   begin
      d.add_to_criteria( c, elem );
   end Add_mahcdec;


   procedure Add_oahcdec( c : in out d.Criteria; oahcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahcdec", op, join, oahcdec );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahcdec;


   procedure Add_sexsp( c : in out d.Criteria; sexsp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sexsp", op, join, sexsp );
   begin
      d.add_to_criteria( c, elem );
   end Add_sexsp;


   procedure Add_pidefbhc( c : in out d.Criteria; pidefbhc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pidefbhc", op, join, Long_Float( pidefbhc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_pidefbhc;


   procedure Add_pidefahc( c : in out d.Criteria; pidefahc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pidefahc", op, join, Long_Float( pidefahc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_pidefahc;


   procedure Add_pigrosbu( c : in out d.Criteria; pigrosbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pigrosbu", op, join, pigrosbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pigrosbu;


   procedure Add_pinincbu( c : in out d.Criteria; pinincbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pinincbu", op, join, pinincbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pinincbu;


   procedure Add_pigoccbu( c : in out d.Criteria; pigoccbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pigoccbu", op, join, pigoccbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pigoccbu;


   procedure Add_pippenbu( c : in out d.Criteria; pippenbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pippenbu", op, join, pippenbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pippenbu;


   procedure Add_piginvbu( c : in out d.Criteria; piginvbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "piginvbu", op, join, piginvbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_piginvbu;


   procedure Add_pigernbu( c : in out d.Criteria; pigernbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pigernbu", op, join, pigernbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pigernbu;


   procedure Add_pibenibu( c : in out d.Criteria; pibenibu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pibenibu", op, join, pibenibu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pibenibu;


   procedure Add_piothibu( c : in out d.Criteria; piothibu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "piothibu", op, join, piothibu );
   begin
      d.add_to_criteria( c, elem );
   end Add_piothibu;


   procedure Add_pinahcbu( c : in out d.Criteria; pinahcbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pinahcbu", op, join, pinahcbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pinahcbu;


   procedure Add_piirbbu( c : in out d.Criteria; piirbbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "piirbbu", op, join, piirbbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_piirbbu;


   procedure Add_pidisben( c : in out d.Criteria; pidisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pidisben", op, join, pidisben );
   begin
      d.add_to_criteria( c, elem );
   end Add_pidisben;


   procedure Add_piretben( c : in out d.Criteria; piretben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "piretben", op, join, piretben );
   begin
      d.add_to_criteria( c, elem );
   end Add_piretben;


   procedure Add_pripenbu( c : in out d.Criteria; pripenbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pripenbu", op, join, pripenbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_pripenbu;


   procedure Add_nonben2bu( c : in out d.Criteria; nonben2bu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nonben2bu", op, join, nonben2bu );
   begin
      d.add_to_criteria( c, elem );
   end Add_nonben2bu;


   procedure Add_perbenbu( c : in out d.Criteria; perbenbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "perbenbu", op, join, perbenbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_perbenbu;


   procedure Add_perbenbu2( c : in out d.Criteria; perbenbu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "perbenbu2", op, join, perbenbu2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_perbenbu2;


   procedure Add_rrpen( c : in out d.Criteria; rrpen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rrpen", op, join, rrpen );
   begin
      d.add_to_criteria( c, elem );
   end Add_rrpen;


   procedure Add_newfambu2( c : in out d.Criteria; newfambu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "newfambu2", op, join, newfambu2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfambu2;


   procedure Add_newfamb2( c : in out d.Criteria; newfamb2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "newfamb2", op, join, newfamb2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfamb2;


   procedure Add_dummy( c : in out d.Criteria; dummy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dummy", op, join, dummy );
   begin
      d.add_to_criteria( c, elem );
   end Add_dummy;


   procedure Add_coup_q1( c : in out d.Criteria; coup_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coup_q1", op, join, Long_Float( coup_q1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q1;


   procedure Add_coup_q2( c : in out d.Criteria; coup_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coup_q2", op, join, Long_Float( coup_q2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q2;


   procedure Add_coup_q3( c : in out d.Criteria; coup_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coup_q3", op, join, Long_Float( coup_q3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q3;


   procedure Add_coup_q4( c : in out d.Criteria; coup_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coup_q4", op, join, Long_Float( coup_q4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q4;


   procedure Add_coup_q5( c : in out d.Criteria; coup_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coup_q5", op, join, Long_Float( coup_q5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q5;


   procedure Add_acou_q1( c : in out d.Criteria; acou_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acou_q1", op, join, Long_Float( acou_q1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q1;


   procedure Add_acou_q2( c : in out d.Criteria; acou_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acou_q2", op, join, Long_Float( acou_q2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q2;


   procedure Add_acou_q3( c : in out d.Criteria; acou_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acou_q3", op, join, Long_Float( acou_q3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q3;


   procedure Add_acou_q4( c : in out d.Criteria; acou_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acou_q4", op, join, Long_Float( acou_q4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q4;


   procedure Add_acou_q5( c : in out d.Criteria; acou_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acou_q5", op, join, Long_Float( acou_q5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q5;


   procedure Add_sing_q1( c : in out d.Criteria; sing_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sing_q1", op, join, Long_Float( sing_q1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q1;


   procedure Add_sing_q2( c : in out d.Criteria; sing_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sing_q2", op, join, Long_Float( sing_q2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q2;


   procedure Add_sing_q3( c : in out d.Criteria; sing_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sing_q3", op, join, Long_Float( sing_q3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q3;


   procedure Add_sing_q4( c : in out d.Criteria; sing_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sing_q4", op, join, Long_Float( sing_q4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q4;


   procedure Add_sing_q5( c : in out d.Criteria; sing_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sing_q5", op, join, Long_Float( sing_q5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q5;


   procedure Add_asin_q1( c : in out d.Criteria; asin_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "asin_q1", op, join, Long_Float( asin_q1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q1;


   procedure Add_asin_q2( c : in out d.Criteria; asin_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "asin_q2", op, join, Long_Float( asin_q2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q2;


   procedure Add_asin_q3( c : in out d.Criteria; asin_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "asin_q3", op, join, Long_Float( asin_q3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q3;


   procedure Add_asin_q4( c : in out d.Criteria; asin_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "asin_q4", op, join, Long_Float( asin_q4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q4;


   procedure Add_asin_q5( c : in out d.Criteria; asin_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "asin_q5", op, join, Long_Float( asin_q5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q5;


   procedure Add_clust( c : in out d.Criteria; clust : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clust", op, join, clust );
   begin
      d.add_to_criteria( c, elem );
   end Add_clust;


   procedure Add_strat( c : in out d.Criteria; strat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "strat", op, join, strat );
   begin
      d.add_to_criteria( c, elem );
   end Add_strat;


   procedure Add_agehd80( c : in out d.Criteria; agehd80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "agehd80", op, join, agehd80 );
   begin
      d.add_to_criteria( c, elem );
   end Add_agehd80;


   procedure Add_agesp80( c : in out d.Criteria; agesp80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "agesp80", op, join, agesp80 );
   begin
      d.add_to_criteria( c, elem );
   end Add_agesp80;


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   
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


   procedure Add_gvtregn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gvtregn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gvtregn_To_Orderings;


   procedure Add_fambu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fambu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fambu_To_Orderings;


   procedure Add_newfambu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "newfambu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfambu_To_Orderings;


   procedure Add_sexhd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sexhd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sexhd_To_Orderings;


   procedure Add_adultb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adultb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adultb_To_Orderings;


   procedure Add_ethgrphh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrphh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgrphh_To_Orderings;


   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benunit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit_To_Orderings;


   procedure Add_gs_newbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gs_newbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gs_newbu_To_Orderings;


   procedure Add_gs_newpp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gs_newpp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gs_newpp_To_Orderings;


   procedure Add_mbhcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mbhcdec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mbhcdec_To_Orderings;


   procedure Add_obhcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "obhcdec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_obhcdec_To_Orderings;


   procedure Add_mahcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mahcdec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mahcdec_To_Orderings;


   procedure Add_oahcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahcdec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahcdec_To_Orderings;


   procedure Add_sexsp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sexsp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sexsp_To_Orderings;


   procedure Add_pidefbhc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pidefbhc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pidefbhc_To_Orderings;


   procedure Add_pidefahc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pidefahc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pidefahc_To_Orderings;


   procedure Add_pigrosbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pigrosbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pigrosbu_To_Orderings;


   procedure Add_pinincbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pinincbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pinincbu_To_Orderings;


   procedure Add_pigoccbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pigoccbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pigoccbu_To_Orderings;


   procedure Add_pippenbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pippenbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pippenbu_To_Orderings;


   procedure Add_piginvbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "piginvbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_piginvbu_To_Orderings;


   procedure Add_pigernbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pigernbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pigernbu_To_Orderings;


   procedure Add_pibenibu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pibenibu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pibenibu_To_Orderings;


   procedure Add_piothibu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "piothibu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_piothibu_To_Orderings;


   procedure Add_pinahcbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pinahcbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pinahcbu_To_Orderings;


   procedure Add_piirbbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "piirbbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_piirbbu_To_Orderings;


   procedure Add_pidisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pidisben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pidisben_To_Orderings;


   procedure Add_piretben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "piretben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_piretben_To_Orderings;


   procedure Add_pripenbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pripenbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pripenbu_To_Orderings;


   procedure Add_nonben2bu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nonben2bu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nonben2bu_To_Orderings;


   procedure Add_perbenbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "perbenbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_perbenbu_To_Orderings;


   procedure Add_perbenbu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "perbenbu2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_perbenbu2_To_Orderings;


   procedure Add_rrpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rrpen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rrpen_To_Orderings;


   procedure Add_newfambu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "newfambu2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfambu2_To_Orderings;


   procedure Add_newfamb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "newfamb2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfamb2_To_Orderings;


   procedure Add_dummy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dummy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dummy_To_Orderings;


   procedure Add_coup_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coup_q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q1_To_Orderings;


   procedure Add_coup_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coup_q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q2_To_Orderings;


   procedure Add_coup_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coup_q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q3_To_Orderings;


   procedure Add_coup_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coup_q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q4_To_Orderings;


   procedure Add_coup_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coup_q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coup_q5_To_Orderings;


   procedure Add_acou_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acou_q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q1_To_Orderings;


   procedure Add_acou_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acou_q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q2_To_Orderings;


   procedure Add_acou_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acou_q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q3_To_Orderings;


   procedure Add_acou_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acou_q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q4_To_Orderings;


   procedure Add_acou_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acou_q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acou_q5_To_Orderings;


   procedure Add_sing_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sing_q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q1_To_Orderings;


   procedure Add_sing_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sing_q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q2_To_Orderings;


   procedure Add_sing_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sing_q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q3_To_Orderings;


   procedure Add_sing_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sing_q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q4_To_Orderings;


   procedure Add_sing_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sing_q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sing_q5_To_Orderings;


   procedure Add_asin_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "asin_q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q1_To_Orderings;


   procedure Add_asin_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "asin_q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q2_To_Orderings;


   procedure Add_asin_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "asin_q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q3_To_Orderings;


   procedure Add_asin_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "asin_q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q4_To_Orderings;


   procedure Add_asin_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "asin_q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_asin_q5_To_Orderings;


   procedure Add_clust_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clust", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clust_To_Orderings;


   procedure Add_strat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "strat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_strat_To_Orderings;


   procedure Add_agehd80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "agehd80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_agehd80_To_Orderings;


   procedure Add_agesp80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "agesp80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_agesp80_To_Orderings;


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Pianon0910_IO;
