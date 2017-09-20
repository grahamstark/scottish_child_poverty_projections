--
-- Created by ada_generator.py on 2017-09-20 15:06:43.364658
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

package body Ukds.Frs.Mortgage_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.MORTGAGE_IO" );
   
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
         "user_id, edition, year, sernum, mortseq, boramtdk, borramt, endwpri1, endwpri2, endwpri3," &
         "endwpri4, exrent, incminc1, incminc2, incminc3, incmp1, incmp2, incmp3, incmpam1, incmpam2," &
         "incmpam3, incmppd1, incmppd2, incmppd3, incmsty1, incmsty2, incmsty3, intprpay, intprpd, intru," &
         "intrupd, intrus, loan2y, loanyear, menpol, morall, morflc, morinpay, morinpd, morinus," &
         "mortend, mortleft, mortprot, morttype, morupd, morus, mpcover1, mpcover2, mpcover3, mpolno," &
         "outsmort, rentfrom, rmamt, rmort, rmortyr, rmpur001, rmpur002, rmpur003, rmpur004, rmpur005," &
         "rmpur006, rmpur007, rmpur008, month, endwpri5, issue " &
         " from frs.mortgage " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.mortgage (" &
         "user_id, edition, year, sernum, mortseq, boramtdk, borramt, endwpri1, endwpri2, endwpri3," &
         "endwpri4, exrent, incminc1, incminc2, incminc3, incmp1, incmp2, incmp3, incmpam1, incmpam2," &
         "incmpam3, incmppd1, incmppd2, incmppd3, incmsty1, incmsty2, incmsty3, intprpay, intprpd, intru," &
         "intrupd, intrus, loan2y, loanyear, menpol, morall, morflc, morinpay, morinpd, morinus," &
         "mortend, mortleft, mortprot, morttype, morupd, morus, mpcover1, mpcover2, mpcover3, mpolno," &
         "outsmort, rentfrom, rmamt, rmort, rmortyr, rmpur001, rmpur002, rmpur003, rmpur004, rmpur005," &
         "rmpur006, rmpur007, rmpur008, month, endwpri5, issue " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.mortgage ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.mortgage set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 66 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : boramtdk (Integer)
            2 => ( Parameter_Float, 0.0 ),   --  : borramt (Amount)
            3 => ( Parameter_Integer, 0 ),   --  : endwpri1 (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : endwpri2 (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : endwpri3 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : endwpri4 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : exrent (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : incminc1 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : incminc2 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : incminc3 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : incmp1 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : incmp2 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : incmp3 (Integer)
           14 => ( Parameter_Float, 0.0 ),   --  : incmpam1 (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : incmpam2 (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : incmpam3 (Amount)
           17 => ( Parameter_Integer, 0 ),   --  : incmppd1 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : incmppd2 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : incmppd3 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : incmsty1 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : incmsty2 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : incmsty3 (Integer)
           23 => ( Parameter_Float, 0.0 ),   --  : intprpay (Amount)
           24 => ( Parameter_Integer, 0 ),   --  : intprpd (Integer)
           25 => ( Parameter_Float, 0.0 ),   --  : intru (Amount)
           26 => ( Parameter_Integer, 0 ),   --  : intrupd (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : intrus (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : loan2y (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : loanyear (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : menpol (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : morall (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : morflc (Integer)
           33 => ( Parameter_Float, 0.0 ),   --  : morinpay (Amount)
           34 => ( Parameter_Integer, 0 ),   --  : morinpd (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : morinus (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : mortend (Integer)
           37 => ( Parameter_Float, 0.0 ),   --  : mortleft (Amount)
           38 => ( Parameter_Integer, 0 ),   --  : mortprot (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : morttype (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : morupd (Integer)
           41 => ( Parameter_Float, 0.0 ),   --  : morus (Amount)
           42 => ( Parameter_Integer, 0 ),   --  : mpcover1 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : mpcover2 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : mpcover3 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : mpolno (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : outsmort (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : rentfrom (Integer)
           48 => ( Parameter_Float, 0.0 ),   --  : rmamt (Amount)
           49 => ( Parameter_Integer, 0 ),   --  : rmort (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : rmortyr (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : rmpur001 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : rmpur002 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : rmpur003 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : rmpur004 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : rmpur005 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : rmpur006 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : rmpur007 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : rmpur008 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : endwpri5 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           65 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           66 => ( Parameter_Integer, 0 )   --  : mortseq (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : mortseq (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : boramtdk (Integer)
            7 => ( Parameter_Float, 0.0 ),   --  : borramt (Amount)
            8 => ( Parameter_Integer, 0 ),   --  : endwpri1 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : endwpri2 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : endwpri3 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : endwpri4 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : exrent (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : incminc1 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : incminc2 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : incminc3 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : incmp1 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : incmp2 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : incmp3 (Integer)
           19 => ( Parameter_Float, 0.0 ),   --  : incmpam1 (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : incmpam2 (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : incmpam3 (Amount)
           22 => ( Parameter_Integer, 0 ),   --  : incmppd1 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : incmppd2 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : incmppd3 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : incmsty1 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : incmsty2 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : incmsty3 (Integer)
           28 => ( Parameter_Float, 0.0 ),   --  : intprpay (Amount)
           29 => ( Parameter_Integer, 0 ),   --  : intprpd (Integer)
           30 => ( Parameter_Float, 0.0 ),   --  : intru (Amount)
           31 => ( Parameter_Integer, 0 ),   --  : intrupd (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : intrus (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : loan2y (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : loanyear (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : menpol (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : morall (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : morflc (Integer)
           38 => ( Parameter_Float, 0.0 ),   --  : morinpay (Amount)
           39 => ( Parameter_Integer, 0 ),   --  : morinpd (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : morinus (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : mortend (Integer)
           42 => ( Parameter_Float, 0.0 ),   --  : mortleft (Amount)
           43 => ( Parameter_Integer, 0 ),   --  : mortprot (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : morttype (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : morupd (Integer)
           46 => ( Parameter_Float, 0.0 ),   --  : morus (Amount)
           47 => ( Parameter_Integer, 0 ),   --  : mpcover1 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : mpcover2 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : mpcover3 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : mpolno (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : outsmort (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : rentfrom (Integer)
           53 => ( Parameter_Float, 0.0 ),   --  : rmamt (Amount)
           54 => ( Parameter_Integer, 0 ),   --  : rmort (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : rmortyr (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : rmpur001 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : rmpur002 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : rmpur003 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : rmpur004 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : rmpur005 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : rmpur006 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : rmpur007 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : rmpur008 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : endwpri5 (Integer)
           66 => ( Parameter_Integer, 0 )   --  : issue (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66 )"; 
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
            5 => ( Parameter_Integer, 0 )   --  : mortseq (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and mortseq = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " boramtdk = $1, borramt = $2, endwpri1 = $3, endwpri2 = $4, endwpri3 = $5, endwpri4 = $6, exrent = $7, incminc1 = $8, incminc2 = $9, incminc3 = $10, incmp1 = $11, incmp2 = $12, incmp3 = $13, incmpam1 = $14, incmpam2 = $15, incmpam3 = $16, incmppd1 = $17, incmppd2 = $18, incmppd3 = $19, incmsty1 = $20, incmsty2 = $21, incmsty3 = $22, intprpay = $23, intprpd = $24, intru = $25, intrupd = $26, intrus = $27, loan2y = $28, loanyear = $29, menpol = $30, morall = $31, morflc = $32, morinpay = $33, morinpd = $34, morinus = $35, mortend = $36, mortleft = $37, mortprot = $38, morttype = $39, morupd = $40, morus = $41, mpcover1 = $42, mpcover2 = $43, mpcover3 = $44, mpolno = $45, outsmort = $46, rentfrom = $47, rmamt = $48, rmort = $49, rmortyr = $50, rmpur001 = $51, rmpur002 = $52, rmpur003 = $53, rmpur004 = $54, rmpur005 = $55, rmpur006 = $56, rmpur007 = $57, rmpur008 = $58, month = $59, endwpri5 = $60, issue = $61 where user_id = $62 and edition = $63 and year = $64 and sernum = $65 and mortseq = $66"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.mortgage", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.mortgage", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.mortgage", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.mortgage", SCHEMA_NAME );
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


   Next_Free_mortseq_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( mortseq ) + 1, 1 ) from frs.mortgage", SCHEMA_NAME );
   Next_Free_mortseq_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_mortseq_query, On_Server => True );
   -- 
   -- Next highest avaiable value of mortseq - useful for saving  
   --
   function Next_Free_mortseq( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_mortseq_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_mortseq;



   --
   -- returns true if the primary key parts of Ukds.Frs.Mortgage match the defaults in Ukds.Frs.Null_Mortgage
   --
   --
   -- Does this Ukds.Frs.Mortgage equal the default Ukds.Frs.Null_Mortgage ?
   --
   function Is_Null( a_mortgage : Mortgage ) return Boolean is
   begin
      return a_mortgage = Ukds.Frs.Null_Mortgage;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Mortgage matching the primary key fields, or the Ukds.Frs.Null_Mortgage record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; mortseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Mortgage is
      l : Ukds.Frs.Mortgage_List;
      a_mortgage : Ukds.Frs.Mortgage;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_mortseq( c, mortseq );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Mortgage_List_Package.is_empty( l ) ) then
         a_mortgage := Ukds.Frs.Mortgage_List_Package.First_Element( l );
      else
         a_mortgage := Ukds.Frs.Null_Mortgage;
      end if;
      return a_mortgage;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.mortgage where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and mortseq = $5", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; mortseq : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 5 ) := "+"( Integer'Pos( mortseq ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Mortgage matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Mortgage_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Mortgage retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Mortgage is
      a_mortgage : Ukds.Frs.Mortgage;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_mortgage.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_mortgage.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_mortgage.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_mortgage.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_mortgage.mortseq := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_mortgage.boramtdk := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_mortgage.borramt:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_mortgage.endwpri1 := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_mortgage.endwpri2 := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_mortgage.endwpri3 := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_mortgage.endwpri4 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_mortgage.exrent := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_mortgage.incminc1 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_mortgage.incminc2 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_mortgage.incminc3 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_mortgage.incmp1 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_mortgage.incmp2 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_mortgage.incmp3 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_mortgage.incmpam1:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_mortgage.incmpam2:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_mortgage.incmpam3:= Amount'Value( gse.Value( cursor, 20 ));
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_mortgage.incmppd1 := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_mortgage.incmppd2 := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_mortgage.incmppd3 := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_mortgage.incmsty1 := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_mortgage.incmsty2 := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_mortgage.incmsty3 := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_mortgage.intprpay:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_mortgage.intprpd := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_mortgage.intru:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_mortgage.intrupd := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_mortgage.intrus := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_mortgage.loan2y := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_mortgage.loanyear := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_mortgage.menpol := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_mortgage.morall := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_mortgage.morflc := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_mortgage.morinpay:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_mortgage.morinpd := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_mortgage.morinus := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_mortgage.mortend := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_mortgage.mortleft:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_mortgage.mortprot := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_mortgage.morttype := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_mortgage.morupd := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_mortgage.morus:= Amount'Value( gse.Value( cursor, 45 ));
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_mortgage.mpcover1 := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_mortgage.mpcover2 := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_mortgage.mpcover3 := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_mortgage.mpolno := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_mortgage.outsmort := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_mortgage.rentfrom := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_mortgage.rmamt:= Amount'Value( gse.Value( cursor, 52 ));
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_mortgage.rmort := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_mortgage.rmortyr := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_mortgage.rmpur001 := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_mortgage.rmpur002 := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_mortgage.rmpur003 := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_mortgage.rmpur004 := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_mortgage.rmpur005 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_mortgage.rmpur006 := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_mortgage.rmpur007 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_mortgage.rmpur008 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_mortgage.month := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_mortgage.endwpri5 := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_mortgage.issue := gse.Integer_Value( cursor, 65 );
      end if;
      return a_mortgage;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Mortgage_List is
      l : Ukds.Frs.Mortgage_List;
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
            a_mortgage : Ukds.Frs.Mortgage := Map_From_Cursor( cursor );
         begin
            l.append( a_mortgage ); 
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
   
   procedure Update( a_mortgage : Ukds.Frs.Mortgage; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_mortgage.boramtdk ));
      params( 2 ) := "+"( Float( a_mortgage.borramt ));
      params( 3 ) := "+"( Integer'Pos( a_mortgage.endwpri1 ));
      params( 4 ) := "+"( Integer'Pos( a_mortgage.endwpri2 ));
      params( 5 ) := "+"( Integer'Pos( a_mortgage.endwpri3 ));
      params( 6 ) := "+"( Integer'Pos( a_mortgage.endwpri4 ));
      params( 7 ) := "+"( Integer'Pos( a_mortgage.exrent ));
      params( 8 ) := "+"( Integer'Pos( a_mortgage.incminc1 ));
      params( 9 ) := "+"( Integer'Pos( a_mortgage.incminc2 ));
      params( 10 ) := "+"( Integer'Pos( a_mortgage.incminc3 ));
      params( 11 ) := "+"( Integer'Pos( a_mortgage.incmp1 ));
      params( 12 ) := "+"( Integer'Pos( a_mortgage.incmp2 ));
      params( 13 ) := "+"( Integer'Pos( a_mortgage.incmp3 ));
      params( 14 ) := "+"( Float( a_mortgage.incmpam1 ));
      params( 15 ) := "+"( Float( a_mortgage.incmpam2 ));
      params( 16 ) := "+"( Float( a_mortgage.incmpam3 ));
      params( 17 ) := "+"( Integer'Pos( a_mortgage.incmppd1 ));
      params( 18 ) := "+"( Integer'Pos( a_mortgage.incmppd2 ));
      params( 19 ) := "+"( Integer'Pos( a_mortgage.incmppd3 ));
      params( 20 ) := "+"( Integer'Pos( a_mortgage.incmsty1 ));
      params( 21 ) := "+"( Integer'Pos( a_mortgage.incmsty2 ));
      params( 22 ) := "+"( Integer'Pos( a_mortgage.incmsty3 ));
      params( 23 ) := "+"( Float( a_mortgage.intprpay ));
      params( 24 ) := "+"( Integer'Pos( a_mortgage.intprpd ));
      params( 25 ) := "+"( Float( a_mortgage.intru ));
      params( 26 ) := "+"( Integer'Pos( a_mortgage.intrupd ));
      params( 27 ) := "+"( Integer'Pos( a_mortgage.intrus ));
      params( 28 ) := "+"( Integer'Pos( a_mortgage.loan2y ));
      params( 29 ) := "+"( Integer'Pos( a_mortgage.loanyear ));
      params( 30 ) := "+"( Integer'Pos( a_mortgage.menpol ));
      params( 31 ) := "+"( Integer'Pos( a_mortgage.morall ));
      params( 32 ) := "+"( Integer'Pos( a_mortgage.morflc ));
      params( 33 ) := "+"( Float( a_mortgage.morinpay ));
      params( 34 ) := "+"( Integer'Pos( a_mortgage.morinpd ));
      params( 35 ) := "+"( Integer'Pos( a_mortgage.morinus ));
      params( 36 ) := "+"( Integer'Pos( a_mortgage.mortend ));
      params( 37 ) := "+"( Float( a_mortgage.mortleft ));
      params( 38 ) := "+"( Integer'Pos( a_mortgage.mortprot ));
      params( 39 ) := "+"( Integer'Pos( a_mortgage.morttype ));
      params( 40 ) := "+"( Integer'Pos( a_mortgage.morupd ));
      params( 41 ) := "+"( Float( a_mortgage.morus ));
      params( 42 ) := "+"( Integer'Pos( a_mortgage.mpcover1 ));
      params( 43 ) := "+"( Integer'Pos( a_mortgage.mpcover2 ));
      params( 44 ) := "+"( Integer'Pos( a_mortgage.mpcover3 ));
      params( 45 ) := "+"( Integer'Pos( a_mortgage.mpolno ));
      params( 46 ) := "+"( Integer'Pos( a_mortgage.outsmort ));
      params( 47 ) := "+"( Integer'Pos( a_mortgage.rentfrom ));
      params( 48 ) := "+"( Float( a_mortgage.rmamt ));
      params( 49 ) := "+"( Integer'Pos( a_mortgage.rmort ));
      params( 50 ) := "+"( Integer'Pos( a_mortgage.rmortyr ));
      params( 51 ) := "+"( Integer'Pos( a_mortgage.rmpur001 ));
      params( 52 ) := "+"( Integer'Pos( a_mortgage.rmpur002 ));
      params( 53 ) := "+"( Integer'Pos( a_mortgage.rmpur003 ));
      params( 54 ) := "+"( Integer'Pos( a_mortgage.rmpur004 ));
      params( 55 ) := "+"( Integer'Pos( a_mortgage.rmpur005 ));
      params( 56 ) := "+"( Integer'Pos( a_mortgage.rmpur006 ));
      params( 57 ) := "+"( Integer'Pos( a_mortgage.rmpur007 ));
      params( 58 ) := "+"( Integer'Pos( a_mortgage.rmpur008 ));
      params( 59 ) := "+"( Integer'Pos( a_mortgage.month ));
      params( 60 ) := "+"( Integer'Pos( a_mortgage.endwpri5 ));
      params( 61 ) := "+"( Integer'Pos( a_mortgage.issue ));
      params( 62 ) := "+"( Integer'Pos( a_mortgage.user_id ));
      params( 63 ) := "+"( Integer'Pos( a_mortgage.edition ));
      params( 64 ) := "+"( Integer'Pos( a_mortgage.year ));
      params( 65 ) := As_Bigint( a_mortgage.sernum );
      params( 66 ) := "+"( Integer'Pos( a_mortgage.mortseq ));
      
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

   procedure Save( a_mortgage : Ukds.Frs.Mortgage; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_mortgage.user_id, a_mortgage.edition, a_mortgage.year, a_mortgage.sernum, a_mortgage.mortseq ) then
         Update( a_mortgage, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_mortgage.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_mortgage.edition ));
      params( 3 ) := "+"( Integer'Pos( a_mortgage.year ));
      params( 4 ) := As_Bigint( a_mortgage.sernum );
      params( 5 ) := "+"( Integer'Pos( a_mortgage.mortseq ));
      params( 6 ) := "+"( Integer'Pos( a_mortgage.boramtdk ));
      params( 7 ) := "+"( Float( a_mortgage.borramt ));
      params( 8 ) := "+"( Integer'Pos( a_mortgage.endwpri1 ));
      params( 9 ) := "+"( Integer'Pos( a_mortgage.endwpri2 ));
      params( 10 ) := "+"( Integer'Pos( a_mortgage.endwpri3 ));
      params( 11 ) := "+"( Integer'Pos( a_mortgage.endwpri4 ));
      params( 12 ) := "+"( Integer'Pos( a_mortgage.exrent ));
      params( 13 ) := "+"( Integer'Pos( a_mortgage.incminc1 ));
      params( 14 ) := "+"( Integer'Pos( a_mortgage.incminc2 ));
      params( 15 ) := "+"( Integer'Pos( a_mortgage.incminc3 ));
      params( 16 ) := "+"( Integer'Pos( a_mortgage.incmp1 ));
      params( 17 ) := "+"( Integer'Pos( a_mortgage.incmp2 ));
      params( 18 ) := "+"( Integer'Pos( a_mortgage.incmp3 ));
      params( 19 ) := "+"( Float( a_mortgage.incmpam1 ));
      params( 20 ) := "+"( Float( a_mortgage.incmpam2 ));
      params( 21 ) := "+"( Float( a_mortgage.incmpam3 ));
      params( 22 ) := "+"( Integer'Pos( a_mortgage.incmppd1 ));
      params( 23 ) := "+"( Integer'Pos( a_mortgage.incmppd2 ));
      params( 24 ) := "+"( Integer'Pos( a_mortgage.incmppd3 ));
      params( 25 ) := "+"( Integer'Pos( a_mortgage.incmsty1 ));
      params( 26 ) := "+"( Integer'Pos( a_mortgage.incmsty2 ));
      params( 27 ) := "+"( Integer'Pos( a_mortgage.incmsty3 ));
      params( 28 ) := "+"( Float( a_mortgage.intprpay ));
      params( 29 ) := "+"( Integer'Pos( a_mortgage.intprpd ));
      params( 30 ) := "+"( Float( a_mortgage.intru ));
      params( 31 ) := "+"( Integer'Pos( a_mortgage.intrupd ));
      params( 32 ) := "+"( Integer'Pos( a_mortgage.intrus ));
      params( 33 ) := "+"( Integer'Pos( a_mortgage.loan2y ));
      params( 34 ) := "+"( Integer'Pos( a_mortgage.loanyear ));
      params( 35 ) := "+"( Integer'Pos( a_mortgage.menpol ));
      params( 36 ) := "+"( Integer'Pos( a_mortgage.morall ));
      params( 37 ) := "+"( Integer'Pos( a_mortgage.morflc ));
      params( 38 ) := "+"( Float( a_mortgage.morinpay ));
      params( 39 ) := "+"( Integer'Pos( a_mortgage.morinpd ));
      params( 40 ) := "+"( Integer'Pos( a_mortgage.morinus ));
      params( 41 ) := "+"( Integer'Pos( a_mortgage.mortend ));
      params( 42 ) := "+"( Float( a_mortgage.mortleft ));
      params( 43 ) := "+"( Integer'Pos( a_mortgage.mortprot ));
      params( 44 ) := "+"( Integer'Pos( a_mortgage.morttype ));
      params( 45 ) := "+"( Integer'Pos( a_mortgage.morupd ));
      params( 46 ) := "+"( Float( a_mortgage.morus ));
      params( 47 ) := "+"( Integer'Pos( a_mortgage.mpcover1 ));
      params( 48 ) := "+"( Integer'Pos( a_mortgage.mpcover2 ));
      params( 49 ) := "+"( Integer'Pos( a_mortgage.mpcover3 ));
      params( 50 ) := "+"( Integer'Pos( a_mortgage.mpolno ));
      params( 51 ) := "+"( Integer'Pos( a_mortgage.outsmort ));
      params( 52 ) := "+"( Integer'Pos( a_mortgage.rentfrom ));
      params( 53 ) := "+"( Float( a_mortgage.rmamt ));
      params( 54 ) := "+"( Integer'Pos( a_mortgage.rmort ));
      params( 55 ) := "+"( Integer'Pos( a_mortgage.rmortyr ));
      params( 56 ) := "+"( Integer'Pos( a_mortgage.rmpur001 ));
      params( 57 ) := "+"( Integer'Pos( a_mortgage.rmpur002 ));
      params( 58 ) := "+"( Integer'Pos( a_mortgage.rmpur003 ));
      params( 59 ) := "+"( Integer'Pos( a_mortgage.rmpur004 ));
      params( 60 ) := "+"( Integer'Pos( a_mortgage.rmpur005 ));
      params( 61 ) := "+"( Integer'Pos( a_mortgage.rmpur006 ));
      params( 62 ) := "+"( Integer'Pos( a_mortgage.rmpur007 ));
      params( 63 ) := "+"( Integer'Pos( a_mortgage.rmpur008 ));
      params( 64 ) := "+"( Integer'Pos( a_mortgage.month ));
      params( 65 ) := "+"( Integer'Pos( a_mortgage.endwpri5 ));
      params( 66 ) := "+"( Integer'Pos( a_mortgage.issue ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Mortgage
   --

   procedure Delete( a_mortgage : in out Ukds.Frs.Mortgage; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_mortgage.user_id );
      Add_edition( c, a_mortgage.edition );
      Add_year( c, a_mortgage.year );
      Add_sernum( c, a_mortgage.sernum );
      Add_mortseq( c, a_mortgage.mortseq );
      Delete( c, connection );
      a_mortgage := Ukds.Frs.Null_Mortgage;
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


   procedure Add_mortseq( c : in out d.Criteria; mortseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortseq", op, join, mortseq );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortseq;


   procedure Add_boramtdk( c : in out d.Criteria; boramtdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "boramtdk", op, join, boramtdk );
   begin
      d.add_to_criteria( c, elem );
   end Add_boramtdk;


   procedure Add_borramt( c : in out d.Criteria; borramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "borramt", op, join, Long_Float( borramt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_borramt;


   procedure Add_endwpri1( c : in out d.Criteria; endwpri1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endwpri1", op, join, endwpri1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri1;


   procedure Add_endwpri2( c : in out d.Criteria; endwpri2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endwpri2", op, join, endwpri2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri2;


   procedure Add_endwpri3( c : in out d.Criteria; endwpri3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endwpri3", op, join, endwpri3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri3;


   procedure Add_endwpri4( c : in out d.Criteria; endwpri4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endwpri4", op, join, endwpri4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri4;


   procedure Add_exrent( c : in out d.Criteria; exrent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "exrent", op, join, exrent );
   begin
      d.add_to_criteria( c, elem );
   end Add_exrent;


   procedure Add_incminc1( c : in out d.Criteria; incminc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incminc1", op, join, incminc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incminc1;


   procedure Add_incminc2( c : in out d.Criteria; incminc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incminc2", op, join, incminc2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incminc2;


   procedure Add_incminc3( c : in out d.Criteria; incminc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incminc3", op, join, incminc3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incminc3;


   procedure Add_incmp1( c : in out d.Criteria; incmp1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmp1", op, join, incmp1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmp1;


   procedure Add_incmp2( c : in out d.Criteria; incmp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmp2", op, join, incmp2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmp2;


   procedure Add_incmp3( c : in out d.Criteria; incmp3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmp3", op, join, incmp3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmp3;


   procedure Add_incmpam1( c : in out d.Criteria; incmpam1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmpam1", op, join, Long_Float( incmpam1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmpam1;


   procedure Add_incmpam2( c : in out d.Criteria; incmpam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmpam2", op, join, Long_Float( incmpam2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmpam2;


   procedure Add_incmpam3( c : in out d.Criteria; incmpam3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmpam3", op, join, Long_Float( incmpam3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmpam3;


   procedure Add_incmppd1( c : in out d.Criteria; incmppd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmppd1", op, join, incmppd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmppd1;


   procedure Add_incmppd2( c : in out d.Criteria; incmppd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmppd2", op, join, incmppd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmppd2;


   procedure Add_incmppd3( c : in out d.Criteria; incmppd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmppd3", op, join, incmppd3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmppd3;


   procedure Add_incmsty1( c : in out d.Criteria; incmsty1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmsty1", op, join, incmsty1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmsty1;


   procedure Add_incmsty2( c : in out d.Criteria; incmsty2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmsty2", op, join, incmsty2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmsty2;


   procedure Add_incmsty3( c : in out d.Criteria; incmsty3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incmsty3", op, join, incmsty3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmsty3;


   procedure Add_intprpay( c : in out d.Criteria; intprpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intprpay", op, join, Long_Float( intprpay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_intprpay;


   procedure Add_intprpd( c : in out d.Criteria; intprpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intprpd", op, join, intprpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_intprpd;


   procedure Add_intru( c : in out d.Criteria; intru : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intru", op, join, Long_Float( intru ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_intru;


   procedure Add_intrupd( c : in out d.Criteria; intrupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intrupd", op, join, intrupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_intrupd;


   procedure Add_intrus( c : in out d.Criteria; intrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intrus", op, join, intrus );
   begin
      d.add_to_criteria( c, elem );
   end Add_intrus;


   procedure Add_loan2y( c : in out d.Criteria; loan2y : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loan2y", op, join, loan2y );
   begin
      d.add_to_criteria( c, elem );
   end Add_loan2y;


   procedure Add_loanyear( c : in out d.Criteria; loanyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loanyear", op, join, loanyear );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanyear;


   procedure Add_menpol( c : in out d.Criteria; menpol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "menpol", op, join, menpol );
   begin
      d.add_to_criteria( c, elem );
   end Add_menpol;


   procedure Add_morall( c : in out d.Criteria; morall : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morall", op, join, morall );
   begin
      d.add_to_criteria( c, elem );
   end Add_morall;


   procedure Add_morflc( c : in out d.Criteria; morflc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morflc", op, join, morflc );
   begin
      d.add_to_criteria( c, elem );
   end Add_morflc;


   procedure Add_morinpay( c : in out d.Criteria; morinpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morinpay", op, join, Long_Float( morinpay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_morinpay;


   procedure Add_morinpd( c : in out d.Criteria; morinpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morinpd", op, join, morinpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_morinpd;


   procedure Add_morinus( c : in out d.Criteria; morinus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morinus", op, join, morinus );
   begin
      d.add_to_criteria( c, elem );
   end Add_morinus;


   procedure Add_mortend( c : in out d.Criteria; mortend : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortend", op, join, mortend );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortend;


   procedure Add_mortleft( c : in out d.Criteria; mortleft : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortleft", op, join, Long_Float( mortleft ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortleft;


   procedure Add_mortprot( c : in out d.Criteria; mortprot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortprot", op, join, mortprot );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortprot;


   procedure Add_morttype( c : in out d.Criteria; morttype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morttype", op, join, morttype );
   begin
      d.add_to_criteria( c, elem );
   end Add_morttype;


   procedure Add_morupd( c : in out d.Criteria; morupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morupd", op, join, morupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_morupd;


   procedure Add_morus( c : in out d.Criteria; morus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "morus", op, join, Long_Float( morus ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_morus;


   procedure Add_mpcover1( c : in out d.Criteria; mpcover1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mpcover1", op, join, mpcover1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpcover1;


   procedure Add_mpcover2( c : in out d.Criteria; mpcover2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mpcover2", op, join, mpcover2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpcover2;


   procedure Add_mpcover3( c : in out d.Criteria; mpcover3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mpcover3", op, join, mpcover3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpcover3;


   procedure Add_mpolno( c : in out d.Criteria; mpolno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mpolno", op, join, mpolno );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpolno;


   procedure Add_outsmort( c : in out d.Criteria; outsmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outsmort", op, join, outsmort );
   begin
      d.add_to_criteria( c, elem );
   end Add_outsmort;


   procedure Add_rentfrom( c : in out d.Criteria; rentfrom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentfrom", op, join, rentfrom );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentfrom;


   procedure Add_rmamt( c : in out d.Criteria; rmamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmamt", op, join, Long_Float( rmamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmamt;


   procedure Add_rmort( c : in out d.Criteria; rmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmort", op, join, rmort );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmort;


   procedure Add_rmortyr( c : in out d.Criteria; rmortyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmortyr", op, join, rmortyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmortyr;


   procedure Add_rmpur001( c : in out d.Criteria; rmpur001 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur001", op, join, rmpur001 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur001;


   procedure Add_rmpur002( c : in out d.Criteria; rmpur002 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur002", op, join, rmpur002 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur002;


   procedure Add_rmpur003( c : in out d.Criteria; rmpur003 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur003", op, join, rmpur003 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur003;


   procedure Add_rmpur004( c : in out d.Criteria; rmpur004 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur004", op, join, rmpur004 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur004;


   procedure Add_rmpur005( c : in out d.Criteria; rmpur005 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur005", op, join, rmpur005 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur005;


   procedure Add_rmpur006( c : in out d.Criteria; rmpur006 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur006", op, join, rmpur006 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur006;


   procedure Add_rmpur007( c : in out d.Criteria; rmpur007 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur007", op, join, rmpur007 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur007;


   procedure Add_rmpur008( c : in out d.Criteria; rmpur008 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rmpur008", op, join, rmpur008 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur008;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_endwpri5( c : in out d.Criteria; endwpri5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endwpri5", op, join, endwpri5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri5;


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


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;


   procedure Add_mortseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortseq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortseq_To_Orderings;


   procedure Add_boramtdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "boramtdk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_boramtdk_To_Orderings;


   procedure Add_borramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "borramt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_borramt_To_Orderings;


   procedure Add_endwpri1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endwpri1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri1_To_Orderings;


   procedure Add_endwpri2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endwpri2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri2_To_Orderings;


   procedure Add_endwpri3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endwpri3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri3_To_Orderings;


   procedure Add_endwpri4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endwpri4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri4_To_Orderings;


   procedure Add_exrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "exrent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_exrent_To_Orderings;


   procedure Add_incminc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incminc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incminc1_To_Orderings;


   procedure Add_incminc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incminc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incminc2_To_Orderings;


   procedure Add_incminc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incminc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incminc3_To_Orderings;


   procedure Add_incmp1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmp1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmp1_To_Orderings;


   procedure Add_incmp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmp2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmp2_To_Orderings;


   procedure Add_incmp3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmp3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmp3_To_Orderings;


   procedure Add_incmpam1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmpam1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmpam1_To_Orderings;


   procedure Add_incmpam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmpam2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmpam2_To_Orderings;


   procedure Add_incmpam3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmpam3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmpam3_To_Orderings;


   procedure Add_incmppd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmppd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmppd1_To_Orderings;


   procedure Add_incmppd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmppd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmppd2_To_Orderings;


   procedure Add_incmppd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmppd3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmppd3_To_Orderings;


   procedure Add_incmsty1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmsty1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmsty1_To_Orderings;


   procedure Add_incmsty2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmsty2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmsty2_To_Orderings;


   procedure Add_incmsty3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incmsty3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incmsty3_To_Orderings;


   procedure Add_intprpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intprpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intprpay_To_Orderings;


   procedure Add_intprpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intprpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intprpd_To_Orderings;


   procedure Add_intru_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intru", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intru_To_Orderings;


   procedure Add_intrupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intrupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intrupd_To_Orderings;


   procedure Add_intrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intrus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intrus_To_Orderings;


   procedure Add_loan2y_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loan2y", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loan2y_To_Orderings;


   procedure Add_loanyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loanyear", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanyear_To_Orderings;


   procedure Add_menpol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "menpol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_menpol_To_Orderings;


   procedure Add_morall_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morall", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morall_To_Orderings;


   procedure Add_morflc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morflc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morflc_To_Orderings;


   procedure Add_morinpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morinpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morinpay_To_Orderings;


   procedure Add_morinpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morinpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morinpd_To_Orderings;


   procedure Add_morinus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morinus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morinus_To_Orderings;


   procedure Add_mortend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortend", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortend_To_Orderings;


   procedure Add_mortleft_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortleft", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortleft_To_Orderings;


   procedure Add_mortprot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortprot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortprot_To_Orderings;


   procedure Add_morttype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morttype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morttype_To_Orderings;


   procedure Add_morupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morupd_To_Orderings;


   procedure Add_morus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "morus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_morus_To_Orderings;


   procedure Add_mpcover1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mpcover1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpcover1_To_Orderings;


   procedure Add_mpcover2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mpcover2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpcover2_To_Orderings;


   procedure Add_mpcover3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mpcover3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpcover3_To_Orderings;


   procedure Add_mpolno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mpolno", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mpolno_To_Orderings;


   procedure Add_outsmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outsmort", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outsmort_To_Orderings;


   procedure Add_rentfrom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentfrom", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentfrom_To_Orderings;


   procedure Add_rmamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmamt_To_Orderings;


   procedure Add_rmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmort", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmort_To_Orderings;


   procedure Add_rmortyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmortyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmortyr_To_Orderings;


   procedure Add_rmpur001_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur001", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur001_To_Orderings;


   procedure Add_rmpur002_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur002", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur002_To_Orderings;


   procedure Add_rmpur003_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur003", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur003_To_Orderings;


   procedure Add_rmpur004_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur004", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur004_To_Orderings;


   procedure Add_rmpur005_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur005", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur005_To_Orderings;


   procedure Add_rmpur006_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur006", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur006_To_Orderings;


   procedure Add_rmpur007_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur007", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur007_To_Orderings;


   procedure Add_rmpur008_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rmpur008", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rmpur008_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_endwpri5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endwpri5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endwpri5_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Mortgage_IO;
