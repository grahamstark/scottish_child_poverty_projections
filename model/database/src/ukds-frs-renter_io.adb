--
-- Created by ada_generator.py on 2017-09-05 20:57:19.599736
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

package body Ukds.Frs.Renter_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.RENTER_IO" );
   
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
         "user_id, edition, year, sernum, accjbp01, accjbp02, accjbp03, accjbp04, accjbp05, accjbp06," &
         "accjbp07, accjbp08, accjbp09, accjbp10, accjbp11, accjbp12, accjbp13, accjbp14, accjob, accnonhh," &
         "ctract, eligamt, eligpd, fairrent, furnish, hbenamt, hbenchk, hbenefit, hbenpd, hbenwait," &
         "hbweeks, landlord, niystart, othway, rebate, rent, rentdk, rentdoc, rentfull, renthol," &
         "rentpd, resll, resll2, serinc1, serinc2, serinc3, serinc4, serinc5, short1, short2," &
         "weekhol, wsinc, wsincamt, ystartr, month, hbyears, lowshort, othtype, tentype, hbmnth," &
         "hbyear, issue, hbrecp, lhaexs, lhalss, rentpd1, rentpd2, serinc6, serinc7, serinc8," &
         "serincam " &
         " from frs.renter " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.renter (" &
         "user_id, edition, year, sernum, accjbp01, accjbp02, accjbp03, accjbp04, accjbp05, accjbp06," &
         "accjbp07, accjbp08, accjbp09, accjbp10, accjbp11, accjbp12, accjbp13, accjbp14, accjob, accnonhh," &
         "ctract, eligamt, eligpd, fairrent, furnish, hbenamt, hbenchk, hbenefit, hbenpd, hbenwait," &
         "hbweeks, landlord, niystart, othway, rebate, rent, rentdk, rentdoc, rentfull, renthol," &
         "rentpd, resll, resll2, serinc1, serinc2, serinc3, serinc4, serinc5, short1, short2," &
         "weekhol, wsinc, wsincamt, ystartr, month, hbyears, lowshort, othtype, tentype, hbmnth," &
         "hbyear, issue, hbrecp, lhaexs, lhalss, rentpd1, rentpd2, serinc6, serinc7, serinc8," &
         "serincam " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.renter ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.renter set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 71 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : accjbp01 (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : accjbp02 (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : accjbp03 (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : accjbp04 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : accjbp05 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : accjbp06 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : accjbp07 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : accjbp08 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : accjbp09 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : accjbp10 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : accjbp11 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : accjbp12 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : accjbp13 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : accjbp14 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : accjob (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : accnonhh (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : ctract (Integer)
           18 => ( Parameter_Float, 0.0 ),   --  : eligamt (Amount)
           19 => ( Parameter_Integer, 0 ),   --  : eligpd (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : fairrent (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : furnish (Integer)
           22 => ( Parameter_Float, 0.0 ),   --  : hbenamt (Amount)
           23 => ( Parameter_Integer, 0 ),   --  : hbenchk (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : hbenefit (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : hbenpd (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : hbenwait (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : hbweeks (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : landlord (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : niystart (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : othway (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : rebate (Integer)
           32 => ( Parameter_Float, 0.0 ),   --  : rent (Amount)
           33 => ( Parameter_Integer, 0 ),   --  : rentdk (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : rentdoc (Integer)
           35 => ( Parameter_Float, 0.0 ),   --  : rentfull (Amount)
           36 => ( Parameter_Integer, 0 ),   --  : renthol (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : rentpd (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : resll (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : resll2 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : serinc1 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : serinc2 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : serinc3 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : serinc4 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : serinc5 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : short1 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : short2 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : weekhol (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : wsinc (Integer)
           49 => ( Parameter_Float, 0.0 ),   --  : wsincamt (Amount)
           50 => ( Parameter_Integer, 0 ),   --  : ystartr (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : hbyears (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : lowshort (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : othtype (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : tentype (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : hbmnth (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : hbyear (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : hbrecp (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : lhaexs (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : lhalss (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : rentpd1 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : rentpd2 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : serinc6 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : serinc7 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : serinc8 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : serincam (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           71 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : accjbp01 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : accjbp02 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : accjbp03 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : accjbp04 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : accjbp05 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : accjbp06 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : accjbp07 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : accjbp08 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : accjbp09 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : accjbp10 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : accjbp11 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : accjbp12 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : accjbp13 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : accjbp14 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : accjob (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : accnonhh (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : ctract (Integer)
           22 => ( Parameter_Float, 0.0 ),   --  : eligamt (Amount)
           23 => ( Parameter_Integer, 0 ),   --  : eligpd (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : fairrent (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : furnish (Integer)
           26 => ( Parameter_Float, 0.0 ),   --  : hbenamt (Amount)
           27 => ( Parameter_Integer, 0 ),   --  : hbenchk (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : hbenefit (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : hbenpd (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : hbenwait (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : hbweeks (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : landlord (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : niystart (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : othway (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : rebate (Integer)
           36 => ( Parameter_Float, 0.0 ),   --  : rent (Amount)
           37 => ( Parameter_Integer, 0 ),   --  : rentdk (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : rentdoc (Integer)
           39 => ( Parameter_Float, 0.0 ),   --  : rentfull (Amount)
           40 => ( Parameter_Integer, 0 ),   --  : renthol (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : rentpd (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : resll (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : resll2 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : serinc1 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : serinc2 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : serinc3 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : serinc4 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : serinc5 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : short1 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : short2 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : weekhol (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : wsinc (Integer)
           53 => ( Parameter_Float, 0.0 ),   --  : wsincamt (Amount)
           54 => ( Parameter_Integer, 0 ),   --  : ystartr (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : hbyears (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : lowshort (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : othtype (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : tentype (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : hbmnth (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : hbyear (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : hbrecp (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : lhaexs (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : lhalss (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : rentpd1 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : rentpd2 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : serinc6 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : serinc7 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : serinc8 (Integer)
           71 => ( Parameter_Integer, 0 )   --  : serincam (Integer)
      
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " accjbp01 = $1, accjbp02 = $2, accjbp03 = $3, accjbp04 = $4, accjbp05 = $5, accjbp06 = $6, accjbp07 = $7, accjbp08 = $8, accjbp09 = $9, accjbp10 = $10, accjbp11 = $11, accjbp12 = $12, accjbp13 = $13, accjbp14 = $14, accjob = $15, accnonhh = $16, ctract = $17, eligamt = $18, eligpd = $19, fairrent = $20, furnish = $21, hbenamt = $22, hbenchk = $23, hbenefit = $24, hbenpd = $25, hbenwait = $26, hbweeks = $27, landlord = $28, niystart = $29, othway = $30, rebate = $31, rent = $32, rentdk = $33, rentdoc = $34, rentfull = $35, renthol = $36, rentpd = $37, resll = $38, resll2 = $39, serinc1 = $40, serinc2 = $41, serinc3 = $42, serinc4 = $43, serinc5 = $44, short1 = $45, short2 = $46, weekhol = $47, wsinc = $48, wsincamt = $49, ystartr = $50, month = $51, hbyears = $52, lowshort = $53, othtype = $54, tentype = $55, hbmnth = $56, hbyear = $57, issue = $58, hbrecp = $59, lhaexs = $60, lhalss = $61, rentpd1 = $62, rentpd2 = $63, serinc6 = $64, serinc7 = $65, serinc8 = $66, serincam = $67 where user_id = $68 and edition = $69 and year = $70 and sernum = $71"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.renter", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.renter", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.renter", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.renter", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Frs.Renter match the defaults in Ukds.Frs.Null_Renter
   --
   --
   -- Does this Ukds.Frs.Renter equal the default Ukds.Frs.Null_Renter ?
   --
   function Is_Null( a_renter : Renter ) return Boolean is
   begin
      return a_renter = Ukds.Frs.Null_Renter;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Renter matching the primary key fields, or the Ukds.Frs.Null_Renter record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Renter is
      l : Ukds.Frs.Renter_List;
      a_renter : Ukds.Frs.Renter;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Renter_List_Package.is_empty( l ) ) then
         a_renter := Ukds.Frs.Renter_List_Package.First_Element( l );
      else
         a_renter := Ukds.Frs.Null_Renter;
      end if;
      return a_renter;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.renter where user_id = $1 and edition = $2 and year = $3 and sernum = $4", 
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
   -- Retrieves a list of Renter matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Renter_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Renter retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Renter is
      a_renter : Ukds.Frs.Renter;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_renter.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_renter.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_renter.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_renter.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_renter.accjbp01 := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_renter.accjbp02 := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_renter.accjbp03 := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_renter.accjbp04 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_renter.accjbp05 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_renter.accjbp06 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_renter.accjbp07 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_renter.accjbp08 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_renter.accjbp09 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_renter.accjbp10 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_renter.accjbp11 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_renter.accjbp12 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_renter.accjbp13 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_renter.accjbp14 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_renter.accjob := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_renter.accnonhh := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_renter.ctract := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_renter.eligamt:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_renter.eligpd := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_renter.fairrent := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_renter.furnish := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_renter.hbenamt:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_renter.hbenchk := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_renter.hbenefit := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_renter.hbenpd := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_renter.hbenwait := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_renter.hbweeks := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_renter.landlord := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_renter.niystart := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_renter.othway := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_renter.rebate := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_renter.rent:= Amount'Value( gse.Value( cursor, 35 ));
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_renter.rentdk := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_renter.rentdoc := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_renter.rentfull:= Amount'Value( gse.Value( cursor, 38 ));
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_renter.renthol := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_renter.rentpd := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_renter.resll := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_renter.resll2 := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_renter.serinc1 := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_renter.serinc2 := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_renter.serinc3 := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_renter.serinc4 := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_renter.serinc5 := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_renter.short1 := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_renter.short2 := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_renter.weekhol := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_renter.wsinc := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_renter.wsincamt:= Amount'Value( gse.Value( cursor, 52 ));
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_renter.ystartr := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_renter.month := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_renter.hbyears := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_renter.lowshort := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_renter.othtype := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_renter.tentype := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_renter.hbmnth := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_renter.hbyear := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_renter.issue := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_renter.hbrecp := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_renter.lhaexs := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_renter.lhalss := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_renter.rentpd1 := gse.Integer_Value( cursor, 65 );
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_renter.rentpd2 := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_renter.serinc6 := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_renter.serinc7 := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_renter.serinc8 := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_renter.serincam := gse.Integer_Value( cursor, 70 );
      end if;
      return a_renter;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Renter_List is
      l : Ukds.Frs.Renter_List;
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
            a_renter : Ukds.Frs.Renter := Map_From_Cursor( cursor );
         begin
            l.append( a_renter ); 
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
   
   procedure Update( a_renter : Ukds.Frs.Renter; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_renter.accjbp01 ));
      params( 2 ) := "+"( Integer'Pos( a_renter.accjbp02 ));
      params( 3 ) := "+"( Integer'Pos( a_renter.accjbp03 ));
      params( 4 ) := "+"( Integer'Pos( a_renter.accjbp04 ));
      params( 5 ) := "+"( Integer'Pos( a_renter.accjbp05 ));
      params( 6 ) := "+"( Integer'Pos( a_renter.accjbp06 ));
      params( 7 ) := "+"( Integer'Pos( a_renter.accjbp07 ));
      params( 8 ) := "+"( Integer'Pos( a_renter.accjbp08 ));
      params( 9 ) := "+"( Integer'Pos( a_renter.accjbp09 ));
      params( 10 ) := "+"( Integer'Pos( a_renter.accjbp10 ));
      params( 11 ) := "+"( Integer'Pos( a_renter.accjbp11 ));
      params( 12 ) := "+"( Integer'Pos( a_renter.accjbp12 ));
      params( 13 ) := "+"( Integer'Pos( a_renter.accjbp13 ));
      params( 14 ) := "+"( Integer'Pos( a_renter.accjbp14 ));
      params( 15 ) := "+"( Integer'Pos( a_renter.accjob ));
      params( 16 ) := "+"( Integer'Pos( a_renter.accnonhh ));
      params( 17 ) := "+"( Integer'Pos( a_renter.ctract ));
      params( 18 ) := "+"( Float( a_renter.eligamt ));
      params( 19 ) := "+"( Integer'Pos( a_renter.eligpd ));
      params( 20 ) := "+"( Integer'Pos( a_renter.fairrent ));
      params( 21 ) := "+"( Integer'Pos( a_renter.furnish ));
      params( 22 ) := "+"( Float( a_renter.hbenamt ));
      params( 23 ) := "+"( Integer'Pos( a_renter.hbenchk ));
      params( 24 ) := "+"( Integer'Pos( a_renter.hbenefit ));
      params( 25 ) := "+"( Integer'Pos( a_renter.hbenpd ));
      params( 26 ) := "+"( Integer'Pos( a_renter.hbenwait ));
      params( 27 ) := "+"( Integer'Pos( a_renter.hbweeks ));
      params( 28 ) := "+"( Integer'Pos( a_renter.landlord ));
      params( 29 ) := "+"( Integer'Pos( a_renter.niystart ));
      params( 30 ) := "+"( Integer'Pos( a_renter.othway ));
      params( 31 ) := "+"( Integer'Pos( a_renter.rebate ));
      params( 32 ) := "+"( Float( a_renter.rent ));
      params( 33 ) := "+"( Integer'Pos( a_renter.rentdk ));
      params( 34 ) := "+"( Integer'Pos( a_renter.rentdoc ));
      params( 35 ) := "+"( Float( a_renter.rentfull ));
      params( 36 ) := "+"( Integer'Pos( a_renter.renthol ));
      params( 37 ) := "+"( Integer'Pos( a_renter.rentpd ));
      params( 38 ) := "+"( Integer'Pos( a_renter.resll ));
      params( 39 ) := "+"( Integer'Pos( a_renter.resll2 ));
      params( 40 ) := "+"( Integer'Pos( a_renter.serinc1 ));
      params( 41 ) := "+"( Integer'Pos( a_renter.serinc2 ));
      params( 42 ) := "+"( Integer'Pos( a_renter.serinc3 ));
      params( 43 ) := "+"( Integer'Pos( a_renter.serinc4 ));
      params( 44 ) := "+"( Integer'Pos( a_renter.serinc5 ));
      params( 45 ) := "+"( Integer'Pos( a_renter.short1 ));
      params( 46 ) := "+"( Integer'Pos( a_renter.short2 ));
      params( 47 ) := "+"( Integer'Pos( a_renter.weekhol ));
      params( 48 ) := "+"( Integer'Pos( a_renter.wsinc ));
      params( 49 ) := "+"( Float( a_renter.wsincamt ));
      params( 50 ) := "+"( Integer'Pos( a_renter.ystartr ));
      params( 51 ) := "+"( Integer'Pos( a_renter.month ));
      params( 52 ) := "+"( Integer'Pos( a_renter.hbyears ));
      params( 53 ) := "+"( Integer'Pos( a_renter.lowshort ));
      params( 54 ) := "+"( Integer'Pos( a_renter.othtype ));
      params( 55 ) := "+"( Integer'Pos( a_renter.tentype ));
      params( 56 ) := "+"( Integer'Pos( a_renter.hbmnth ));
      params( 57 ) := "+"( Integer'Pos( a_renter.hbyear ));
      params( 58 ) := "+"( Integer'Pos( a_renter.issue ));
      params( 59 ) := "+"( Integer'Pos( a_renter.hbrecp ));
      params( 60 ) := "+"( Integer'Pos( a_renter.lhaexs ));
      params( 61 ) := "+"( Integer'Pos( a_renter.lhalss ));
      params( 62 ) := "+"( Integer'Pos( a_renter.rentpd1 ));
      params( 63 ) := "+"( Integer'Pos( a_renter.rentpd2 ));
      params( 64 ) := "+"( Integer'Pos( a_renter.serinc6 ));
      params( 65 ) := "+"( Integer'Pos( a_renter.serinc7 ));
      params( 66 ) := "+"( Integer'Pos( a_renter.serinc8 ));
      params( 67 ) := "+"( Integer'Pos( a_renter.serincam ));
      params( 68 ) := "+"( Integer'Pos( a_renter.user_id ));
      params( 69 ) := "+"( Integer'Pos( a_renter.edition ));
      params( 70 ) := "+"( Integer'Pos( a_renter.year ));
      params( 71 ) := As_Bigint( a_renter.sernum );
      
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

   procedure Save( a_renter : Ukds.Frs.Renter; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_renter.user_id, a_renter.edition, a_renter.year, a_renter.sernum ) then
         Update( a_renter, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_renter.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_renter.edition ));
      params( 3 ) := "+"( Integer'Pos( a_renter.year ));
      params( 4 ) := As_Bigint( a_renter.sernum );
      params( 5 ) := "+"( Integer'Pos( a_renter.accjbp01 ));
      params( 6 ) := "+"( Integer'Pos( a_renter.accjbp02 ));
      params( 7 ) := "+"( Integer'Pos( a_renter.accjbp03 ));
      params( 8 ) := "+"( Integer'Pos( a_renter.accjbp04 ));
      params( 9 ) := "+"( Integer'Pos( a_renter.accjbp05 ));
      params( 10 ) := "+"( Integer'Pos( a_renter.accjbp06 ));
      params( 11 ) := "+"( Integer'Pos( a_renter.accjbp07 ));
      params( 12 ) := "+"( Integer'Pos( a_renter.accjbp08 ));
      params( 13 ) := "+"( Integer'Pos( a_renter.accjbp09 ));
      params( 14 ) := "+"( Integer'Pos( a_renter.accjbp10 ));
      params( 15 ) := "+"( Integer'Pos( a_renter.accjbp11 ));
      params( 16 ) := "+"( Integer'Pos( a_renter.accjbp12 ));
      params( 17 ) := "+"( Integer'Pos( a_renter.accjbp13 ));
      params( 18 ) := "+"( Integer'Pos( a_renter.accjbp14 ));
      params( 19 ) := "+"( Integer'Pos( a_renter.accjob ));
      params( 20 ) := "+"( Integer'Pos( a_renter.accnonhh ));
      params( 21 ) := "+"( Integer'Pos( a_renter.ctract ));
      params( 22 ) := "+"( Float( a_renter.eligamt ));
      params( 23 ) := "+"( Integer'Pos( a_renter.eligpd ));
      params( 24 ) := "+"( Integer'Pos( a_renter.fairrent ));
      params( 25 ) := "+"( Integer'Pos( a_renter.furnish ));
      params( 26 ) := "+"( Float( a_renter.hbenamt ));
      params( 27 ) := "+"( Integer'Pos( a_renter.hbenchk ));
      params( 28 ) := "+"( Integer'Pos( a_renter.hbenefit ));
      params( 29 ) := "+"( Integer'Pos( a_renter.hbenpd ));
      params( 30 ) := "+"( Integer'Pos( a_renter.hbenwait ));
      params( 31 ) := "+"( Integer'Pos( a_renter.hbweeks ));
      params( 32 ) := "+"( Integer'Pos( a_renter.landlord ));
      params( 33 ) := "+"( Integer'Pos( a_renter.niystart ));
      params( 34 ) := "+"( Integer'Pos( a_renter.othway ));
      params( 35 ) := "+"( Integer'Pos( a_renter.rebate ));
      params( 36 ) := "+"( Float( a_renter.rent ));
      params( 37 ) := "+"( Integer'Pos( a_renter.rentdk ));
      params( 38 ) := "+"( Integer'Pos( a_renter.rentdoc ));
      params( 39 ) := "+"( Float( a_renter.rentfull ));
      params( 40 ) := "+"( Integer'Pos( a_renter.renthol ));
      params( 41 ) := "+"( Integer'Pos( a_renter.rentpd ));
      params( 42 ) := "+"( Integer'Pos( a_renter.resll ));
      params( 43 ) := "+"( Integer'Pos( a_renter.resll2 ));
      params( 44 ) := "+"( Integer'Pos( a_renter.serinc1 ));
      params( 45 ) := "+"( Integer'Pos( a_renter.serinc2 ));
      params( 46 ) := "+"( Integer'Pos( a_renter.serinc3 ));
      params( 47 ) := "+"( Integer'Pos( a_renter.serinc4 ));
      params( 48 ) := "+"( Integer'Pos( a_renter.serinc5 ));
      params( 49 ) := "+"( Integer'Pos( a_renter.short1 ));
      params( 50 ) := "+"( Integer'Pos( a_renter.short2 ));
      params( 51 ) := "+"( Integer'Pos( a_renter.weekhol ));
      params( 52 ) := "+"( Integer'Pos( a_renter.wsinc ));
      params( 53 ) := "+"( Float( a_renter.wsincamt ));
      params( 54 ) := "+"( Integer'Pos( a_renter.ystartr ));
      params( 55 ) := "+"( Integer'Pos( a_renter.month ));
      params( 56 ) := "+"( Integer'Pos( a_renter.hbyears ));
      params( 57 ) := "+"( Integer'Pos( a_renter.lowshort ));
      params( 58 ) := "+"( Integer'Pos( a_renter.othtype ));
      params( 59 ) := "+"( Integer'Pos( a_renter.tentype ));
      params( 60 ) := "+"( Integer'Pos( a_renter.hbmnth ));
      params( 61 ) := "+"( Integer'Pos( a_renter.hbyear ));
      params( 62 ) := "+"( Integer'Pos( a_renter.issue ));
      params( 63 ) := "+"( Integer'Pos( a_renter.hbrecp ));
      params( 64 ) := "+"( Integer'Pos( a_renter.lhaexs ));
      params( 65 ) := "+"( Integer'Pos( a_renter.lhalss ));
      params( 66 ) := "+"( Integer'Pos( a_renter.rentpd1 ));
      params( 67 ) := "+"( Integer'Pos( a_renter.rentpd2 ));
      params( 68 ) := "+"( Integer'Pos( a_renter.serinc6 ));
      params( 69 ) := "+"( Integer'Pos( a_renter.serinc7 ));
      params( 70 ) := "+"( Integer'Pos( a_renter.serinc8 ));
      params( 71 ) := "+"( Integer'Pos( a_renter.serincam ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Renter
   --

   procedure Delete( a_renter : in out Ukds.Frs.Renter; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_renter.user_id );
      Add_edition( c, a_renter.edition );
      Add_year( c, a_renter.year );
      Add_sernum( c, a_renter.sernum );
      Delete( c, connection );
      a_renter := Ukds.Frs.Null_Renter;
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


   procedure Add_accjbp01( c : in out d.Criteria; accjbp01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp01", op, join, accjbp01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp01;


   procedure Add_accjbp02( c : in out d.Criteria; accjbp02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp02", op, join, accjbp02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp02;


   procedure Add_accjbp03( c : in out d.Criteria; accjbp03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp03", op, join, accjbp03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp03;


   procedure Add_accjbp04( c : in out d.Criteria; accjbp04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp04", op, join, accjbp04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp04;


   procedure Add_accjbp05( c : in out d.Criteria; accjbp05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp05", op, join, accjbp05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp05;


   procedure Add_accjbp06( c : in out d.Criteria; accjbp06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp06", op, join, accjbp06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp06;


   procedure Add_accjbp07( c : in out d.Criteria; accjbp07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp07", op, join, accjbp07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp07;


   procedure Add_accjbp08( c : in out d.Criteria; accjbp08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp08", op, join, accjbp08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp08;


   procedure Add_accjbp09( c : in out d.Criteria; accjbp09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp09", op, join, accjbp09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp09;


   procedure Add_accjbp10( c : in out d.Criteria; accjbp10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp10", op, join, accjbp10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp10;


   procedure Add_accjbp11( c : in out d.Criteria; accjbp11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp11", op, join, accjbp11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp11;


   procedure Add_accjbp12( c : in out d.Criteria; accjbp12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp12", op, join, accjbp12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp12;


   procedure Add_accjbp13( c : in out d.Criteria; accjbp13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp13", op, join, accjbp13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp13;


   procedure Add_accjbp14( c : in out d.Criteria; accjbp14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjbp14", op, join, accjbp14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp14;


   procedure Add_accjob( c : in out d.Criteria; accjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjob", op, join, accjob );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjob;


   procedure Add_accnonhh( c : in out d.Criteria; accnonhh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accnonhh", op, join, accnonhh );
   begin
      d.add_to_criteria( c, elem );
   end Add_accnonhh;


   procedure Add_ctract( c : in out d.Criteria; ctract : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctract", op, join, ctract );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctract;


   procedure Add_eligamt( c : in out d.Criteria; eligamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eligamt", op, join, Long_Float( eligamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligamt;


   procedure Add_eligpd( c : in out d.Criteria; eligpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eligpd", op, join, eligpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligpd;


   procedure Add_fairrent( c : in out d.Criteria; fairrent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fairrent", op, join, fairrent );
   begin
      d.add_to_criteria( c, elem );
   end Add_fairrent;


   procedure Add_furnish( c : in out d.Criteria; furnish : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnish", op, join, furnish );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnish;


   procedure Add_hbenamt( c : in out d.Criteria; hbenamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbenamt", op, join, Long_Float( hbenamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenamt;


   procedure Add_hbenchk( c : in out d.Criteria; hbenchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbenchk", op, join, hbenchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenchk;


   procedure Add_hbenefit( c : in out d.Criteria; hbenefit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbenefit", op, join, hbenefit );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenefit;


   procedure Add_hbenpd( c : in out d.Criteria; hbenpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbenpd", op, join, hbenpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenpd;


   procedure Add_hbenwait( c : in out d.Criteria; hbenwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbenwait", op, join, hbenwait );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenwait;


   procedure Add_hbweeks( c : in out d.Criteria; hbweeks : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbweeks", op, join, hbweeks );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbweeks;


   procedure Add_landlord( c : in out d.Criteria; landlord : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "landlord", op, join, landlord );
   begin
      d.add_to_criteria( c, elem );
   end Add_landlord;


   procedure Add_niystart( c : in out d.Criteria; niystart : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "niystart", op, join, niystart );
   begin
      d.add_to_criteria( c, elem );
   end Add_niystart;


   procedure Add_othway( c : in out d.Criteria; othway : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othway", op, join, othway );
   begin
      d.add_to_criteria( c, elem );
   end Add_othway;


   procedure Add_rebate( c : in out d.Criteria; rebate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rebate", op, join, rebate );
   begin
      d.add_to_criteria( c, elem );
   end Add_rebate;


   procedure Add_rent( c : in out d.Criteria; rent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rent", op, join, Long_Float( rent ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rent;


   procedure Add_rentdk( c : in out d.Criteria; rentdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentdk", op, join, rentdk );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentdk;


   procedure Add_rentdoc( c : in out d.Criteria; rentdoc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentdoc", op, join, rentdoc );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentdoc;


   procedure Add_rentfull( c : in out d.Criteria; rentfull : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentfull", op, join, Long_Float( rentfull ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentfull;


   procedure Add_renthol( c : in out d.Criteria; renthol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "renthol", op, join, renthol );
   begin
      d.add_to_criteria( c, elem );
   end Add_renthol;


   procedure Add_rentpd( c : in out d.Criteria; rentpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentpd", op, join, rentpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentpd;


   procedure Add_resll( c : in out d.Criteria; resll : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "resll", op, join, resll );
   begin
      d.add_to_criteria( c, elem );
   end Add_resll;


   procedure Add_resll2( c : in out d.Criteria; resll2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "resll2", op, join, resll2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_resll2;


   procedure Add_serinc1( c : in out d.Criteria; serinc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc1", op, join, serinc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc1;


   procedure Add_serinc2( c : in out d.Criteria; serinc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc2", op, join, serinc2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc2;


   procedure Add_serinc3( c : in out d.Criteria; serinc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc3", op, join, serinc3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc3;


   procedure Add_serinc4( c : in out d.Criteria; serinc4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc4", op, join, serinc4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc4;


   procedure Add_serinc5( c : in out d.Criteria; serinc5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc5", op, join, serinc5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc5;


   procedure Add_short1( c : in out d.Criteria; short1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "short1", op, join, short1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_short1;


   procedure Add_short2( c : in out d.Criteria; short2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "short2", op, join, short2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_short2;


   procedure Add_weekhol( c : in out d.Criteria; weekhol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "weekhol", op, join, weekhol );
   begin
      d.add_to_criteria( c, elem );
   end Add_weekhol;


   procedure Add_wsinc( c : in out d.Criteria; wsinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wsinc", op, join, wsinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsinc;


   procedure Add_wsincamt( c : in out d.Criteria; wsincamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wsincamt", op, join, Long_Float( wsincamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsincamt;


   procedure Add_ystartr( c : in out d.Criteria; ystartr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ystartr", op, join, ystartr );
   begin
      d.add_to_criteria( c, elem );
   end Add_ystartr;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_hbyears( c : in out d.Criteria; hbyears : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbyears", op, join, hbyears );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbyears;


   procedure Add_lowshort( c : in out d.Criteria; lowshort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lowshort", op, join, lowshort );
   begin
      d.add_to_criteria( c, elem );
   end Add_lowshort;


   procedure Add_othtype( c : in out d.Criteria; othtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othtype", op, join, othtype );
   begin
      d.add_to_criteria( c, elem );
   end Add_othtype;


   procedure Add_tentype( c : in out d.Criteria; tentype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tentype", op, join, tentype );
   begin
      d.add_to_criteria( c, elem );
   end Add_tentype;


   procedure Add_hbmnth( c : in out d.Criteria; hbmnth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbmnth", op, join, hbmnth );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbmnth;


   procedure Add_hbyear( c : in out d.Criteria; hbyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbyear", op, join, hbyear );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbyear;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_hbrecp( c : in out d.Criteria; hbrecp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbrecp", op, join, hbrecp );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbrecp;


   procedure Add_lhaexs( c : in out d.Criteria; lhaexs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lhaexs", op, join, lhaexs );
   begin
      d.add_to_criteria( c, elem );
   end Add_lhaexs;


   procedure Add_lhalss( c : in out d.Criteria; lhalss : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lhalss", op, join, lhalss );
   begin
      d.add_to_criteria( c, elem );
   end Add_lhalss;


   procedure Add_rentpd1( c : in out d.Criteria; rentpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentpd1", op, join, rentpd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentpd1;


   procedure Add_rentpd2( c : in out d.Criteria; rentpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentpd2", op, join, rentpd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentpd2;


   procedure Add_serinc6( c : in out d.Criteria; serinc6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc6", op, join, serinc6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc6;


   procedure Add_serinc7( c : in out d.Criteria; serinc7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc7", op, join, serinc7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc7;


   procedure Add_serinc8( c : in out d.Criteria; serinc8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serinc8", op, join, serinc8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc8;


   procedure Add_serincam( c : in out d.Criteria; serincam : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serincam", op, join, serincam );
   begin
      d.add_to_criteria( c, elem );
   end Add_serincam;


   
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


   procedure Add_accjbp01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp01_To_Orderings;


   procedure Add_accjbp02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp02_To_Orderings;


   procedure Add_accjbp03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp03_To_Orderings;


   procedure Add_accjbp04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp04_To_Orderings;


   procedure Add_accjbp05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp05_To_Orderings;


   procedure Add_accjbp06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp06_To_Orderings;


   procedure Add_accjbp07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp07_To_Orderings;


   procedure Add_accjbp08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp08_To_Orderings;


   procedure Add_accjbp09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp09_To_Orderings;


   procedure Add_accjbp10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp10_To_Orderings;


   procedure Add_accjbp11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp11_To_Orderings;


   procedure Add_accjbp12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp12_To_Orderings;


   procedure Add_accjbp13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp13_To_Orderings;


   procedure Add_accjbp14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjbp14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjbp14_To_Orderings;


   procedure Add_accjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjob_To_Orderings;


   procedure Add_accnonhh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accnonhh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accnonhh_To_Orderings;


   procedure Add_ctract_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctract", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctract_To_Orderings;


   procedure Add_eligamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eligamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligamt_To_Orderings;


   procedure Add_eligpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eligpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligpd_To_Orderings;


   procedure Add_fairrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fairrent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fairrent_To_Orderings;


   procedure Add_furnish_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnish", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnish_To_Orderings;


   procedure Add_hbenamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbenamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenamt_To_Orderings;


   procedure Add_hbenchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbenchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenchk_To_Orderings;


   procedure Add_hbenefit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbenefit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenefit_To_Orderings;


   procedure Add_hbenpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbenpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenpd_To_Orderings;


   procedure Add_hbenwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbenwait", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbenwait_To_Orderings;


   procedure Add_hbweeks_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbweeks", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbweeks_To_Orderings;


   procedure Add_landlord_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "landlord", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_landlord_To_Orderings;


   procedure Add_niystart_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "niystart", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_niystart_To_Orderings;


   procedure Add_othway_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othway", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othway_To_Orderings;


   procedure Add_rebate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rebate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rebate_To_Orderings;


   procedure Add_rent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rent_To_Orderings;


   procedure Add_rentdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentdk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentdk_To_Orderings;


   procedure Add_rentdoc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentdoc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentdoc_To_Orderings;


   procedure Add_rentfull_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentfull", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentfull_To_Orderings;


   procedure Add_renthol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "renthol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_renthol_To_Orderings;


   procedure Add_rentpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentpd_To_Orderings;


   procedure Add_resll_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "resll", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_resll_To_Orderings;


   procedure Add_resll2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "resll2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_resll2_To_Orderings;


   procedure Add_serinc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc1_To_Orderings;


   procedure Add_serinc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc2_To_Orderings;


   procedure Add_serinc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc3_To_Orderings;


   procedure Add_serinc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc4_To_Orderings;


   procedure Add_serinc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc5_To_Orderings;


   procedure Add_short1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "short1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_short1_To_Orderings;


   procedure Add_short2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "short2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_short2_To_Orderings;


   procedure Add_weekhol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "weekhol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_weekhol_To_Orderings;


   procedure Add_wsinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wsinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsinc_To_Orderings;


   procedure Add_wsincamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wsincamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsincamt_To_Orderings;


   procedure Add_ystartr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ystartr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ystartr_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_hbyears_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbyears", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbyears_To_Orderings;


   procedure Add_lowshort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lowshort", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lowshort_To_Orderings;


   procedure Add_othtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othtype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othtype_To_Orderings;


   procedure Add_tentype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tentype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tentype_To_Orderings;


   procedure Add_hbmnth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbmnth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbmnth_To_Orderings;


   procedure Add_hbyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbyear", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbyear_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_hbrecp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbrecp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbrecp_To_Orderings;


   procedure Add_lhaexs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lhaexs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lhaexs_To_Orderings;


   procedure Add_lhalss_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lhalss", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lhalss_To_Orderings;


   procedure Add_rentpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentpd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentpd1_To_Orderings;


   procedure Add_rentpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentpd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentpd2_To_Orderings;


   procedure Add_serinc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc6_To_Orderings;


   procedure Add_serinc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc7_To_Orderings;


   procedure Add_serinc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serinc8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serinc8_To_Orderings;


   procedure Add_serincam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serincam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serincam_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Renter_IO;
