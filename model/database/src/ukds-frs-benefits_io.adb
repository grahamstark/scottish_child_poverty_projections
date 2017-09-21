--
-- Created by ada_generator.py on 2017-09-21 21:49:52.421496
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

package body Ukds.Frs.Benefits_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.BENEFITS_IO" );
   
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
         "user_id, edition, year, counter, sernum, benunit, person, benefit, bankstmt, benamt," &
         "benamtdk, benlettr, benpd, bookcard, cctc, combamt, combbk, combpd, howben, notusamt," &
         "notuspd, numweeks, ordbkno, payslipb, pres, usual, var1, var2, var3, whorec1," &
         "whorec2, whorec3, whorec4, whorec5, month, issue, numyears, ttbprx, var4, var5," &
         "gtanet, gtatax, cbpaye, cbtax, cbtaxamt, cbtaxpd " &
         " from frs.benefits " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.benefits (" &
         "user_id, edition, year, counter, sernum, benunit, person, benefit, bankstmt, benamt," &
         "benamtdk, benlettr, benpd, bookcard, cctc, combamt, combbk, combpd, howben, notusamt," &
         "notuspd, numweeks, ordbkno, payslipb, pres, usual, var1, var2, var3, whorec1," &
         "whorec2, whorec3, whorec4, whorec5, month, issue, numyears, ttbprx, var4, var5," &
         "gtanet, gtatax, cbpaye, cbtax, cbtaxamt, cbtaxpd " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.benefits ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.benefits set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 46 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : bankstmt (Integer)
            2 => ( Parameter_Float, 0.0 ),   --  : benamt (Amount)
            3 => ( Parameter_Integer, 0 ),   --  : benamtdk (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : benlettr (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : benpd (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : bookcard (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : cctc (Integer)
            8 => ( Parameter_Float, 0.0 ),   --  : combamt (Amount)
            9 => ( Parameter_Integer, 0 ),   --  : combbk (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : combpd (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : howben (Integer)
           12 => ( Parameter_Float, 0.0 ),   --  : notusamt (Amount)
           13 => ( Parameter_Integer, 0 ),   --  : notuspd (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : numweeks (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : ordbkno (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : payslipb (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : pres (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : usual (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : var1 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : var2 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : var3 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : whorec1 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : whorec2 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : whorec3 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : whorec4 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : whorec5 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : numyears (Integer)
           30 => ( Parameter_Float, 0.0 ),   --  : ttbprx (Amount)
           31 => ( Parameter_Integer, 0 ),   --  : var4 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : var5 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : gtanet (Integer)
           34 => ( Parameter_Float, 0.0 ),   --  : gtatax (Amount)
           35 => ( Parameter_Integer, 0 ),   --  : cbpaye (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : cbtax (Integer)
           37 => ( Parameter_Float, 0.0 ),   --  : cbtaxamt (Amount)
           38 => ( Parameter_Integer, 0 ),   --  : cbtaxpd (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
           43 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           44 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           46 => ( Parameter_Integer, 0 )   --  : benefit (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : benefit (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : bankstmt (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : benamt (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : benamtdk (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : benlettr (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : benpd (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : bookcard (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : cctc (Integer)
           16 => ( Parameter_Float, 0.0 ),   --  : combamt (Amount)
           17 => ( Parameter_Integer, 0 ),   --  : combbk (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : combpd (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : howben (Integer)
           20 => ( Parameter_Float, 0.0 ),   --  : notusamt (Amount)
           21 => ( Parameter_Integer, 0 ),   --  : notuspd (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : numweeks (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : ordbkno (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : payslipb (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : pres (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : usual (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : var1 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : var2 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : var3 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : whorec1 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : whorec2 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : whorec3 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : whorec4 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : whorec5 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : numyears (Integer)
           38 => ( Parameter_Float, 0.0 ),   --  : ttbprx (Amount)
           39 => ( Parameter_Integer, 0 ),   --  : var4 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : var5 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : gtanet (Integer)
           42 => ( Parameter_Float, 0.0 ),   --  : gtatax (Amount)
           43 => ( Parameter_Integer, 0 ),   --  : cbpaye (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : cbtax (Integer)
           45 => ( Parameter_Float, 0.0 ),   --  : cbtaxamt (Amount)
           46 => ( Parameter_Integer, 0 )   --  : cbtaxpd (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 8 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            8 => ( Parameter_Integer, 0 )   --  : benefit (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6 and person = $7 and benefit = $8"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " bankstmt = $1, benamt = $2, benamtdk = $3, benlettr = $4, benpd = $5, bookcard = $6, cctc = $7, combamt = $8, combbk = $9, combpd = $10, howben = $11, notusamt = $12, notuspd = $13, numweeks = $14, ordbkno = $15, payslipb = $16, pres = $17, usual = $18, var1 = $19, var2 = $20, var3 = $21, whorec1 = $22, whorec2 = $23, whorec3 = $24, whorec4 = $25, whorec5 = $26, month = $27, issue = $28, numyears = $29, ttbprx = $30, var4 = $31, var5 = $32, gtanet = $33, gtatax = $34, cbpaye = $35, cbtax = $36, cbtaxamt = $37, cbtaxpd = $38 where user_id = $39 and edition = $40 and year = $41 and counter = $42 and sernum = $43 and benunit = $44 and person = $45 and benefit = $46"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( counter ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
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


   Next_Free_benefit_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benefit ) + 1, 1 ) from frs.benefits", SCHEMA_NAME );
   Next_Free_benefit_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_benefit_query, On_Server => True );
   -- 
   -- Next highest avaiable value of benefit - useful for saving  
   --
   function Next_Free_benefit( connection : Database_Connection := null) return Integer is
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
      
      cursor.Fetch( local_connection, Next_Free_benefit_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_benefit;



   --
   -- returns true if the primary key parts of Ukds.Frs.Benefits match the defaults in Ukds.Frs.Null_Benefits
   --
   --
   -- Does this Ukds.Frs.Benefits equal the default Ukds.Frs.Null_Benefits ?
   --
   function Is_Null( a_benefits : Benefits ) return Boolean is
   begin
      return a_benefits = Ukds.Frs.Null_Benefits;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Benefits matching the primary key fields, or the Ukds.Frs.Null_Benefits record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; benefit : Integer; connection : Database_Connection := null ) return Ukds.Frs.Benefits is
      l : Ukds.Frs.Benefits_List;
      a_benefits : Ukds.Frs.Benefits;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_counter( c, counter );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_benefit( c, benefit );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Benefits_List_Package.is_empty( l ) ) then
         a_benefits := Ukds.Frs.Benefits_List_Package.First_Element( l );
      else
         a_benefits := Ukds.Frs.Null_Benefits;
      end if;
      return a_benefits;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.benefits where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6 and person = $7 and benefit = $8", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; benefit : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 7 ) := "+"( Integer'Pos( person ));
      params( 8 ) := "+"( Integer'Pos( benefit ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Benefits matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Benefits retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Benefits is
      a_benefits : Ukds.Frs.Benefits;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_benefits.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_benefits.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_benefits.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_benefits.counter := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_benefits.sernum := Sernum_Value'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_benefits.benunit := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_benefits.person := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_benefits.benefit := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_benefits.bankstmt := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_benefits.benamt:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_benefits.benamtdk := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_benefits.benlettr := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_benefits.benpd := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_benefits.bookcard := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_benefits.cctc := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_benefits.combamt:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_benefits.combbk := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_benefits.combpd := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_benefits.howben := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_benefits.notusamt:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_benefits.notuspd := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_benefits.numweeks := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_benefits.ordbkno := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_benefits.payslipb := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_benefits.pres := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_benefits.usual := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_benefits.var1 := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_benefits.var2 := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_benefits.var3 := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_benefits.whorec1 := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_benefits.whorec2 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_benefits.whorec3 := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_benefits.whorec4 := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_benefits.whorec5 := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_benefits.month := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_benefits.issue := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_benefits.numyears := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_benefits.ttbprx:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_benefits.var4 := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_benefits.var5 := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_benefits.gtanet := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_benefits.gtatax:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_benefits.cbpaye := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_benefits.cbtax := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_benefits.cbtaxamt:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_benefits.cbtaxpd := gse.Integer_Value( cursor, 45 );
      end if;
      return a_benefits;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List is
      l : Ukds.Frs.Benefits_List;
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
            a_benefits : Ukds.Frs.Benefits := Map_From_Cursor( cursor );
         begin
            l.append( a_benefits ); 
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
   
   procedure Update( a_benefits : Ukds.Frs.Benefits; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_benefits.bankstmt ));
      params( 2 ) := "+"( Float( a_benefits.benamt ));
      params( 3 ) := "+"( Integer'Pos( a_benefits.benamtdk ));
      params( 4 ) := "+"( Integer'Pos( a_benefits.benlettr ));
      params( 5 ) := "+"( Integer'Pos( a_benefits.benpd ));
      params( 6 ) := "+"( Integer'Pos( a_benefits.bookcard ));
      params( 7 ) := "+"( Integer'Pos( a_benefits.cctc ));
      params( 8 ) := "+"( Float( a_benefits.combamt ));
      params( 9 ) := "+"( Integer'Pos( a_benefits.combbk ));
      params( 10 ) := "+"( Integer'Pos( a_benefits.combpd ));
      params( 11 ) := "+"( Integer'Pos( a_benefits.howben ));
      params( 12 ) := "+"( Float( a_benefits.notusamt ));
      params( 13 ) := "+"( Integer'Pos( a_benefits.notuspd ));
      params( 14 ) := "+"( Integer'Pos( a_benefits.numweeks ));
      params( 15 ) := "+"( Integer'Pos( a_benefits.ordbkno ));
      params( 16 ) := "+"( Integer'Pos( a_benefits.payslipb ));
      params( 17 ) := "+"( Integer'Pos( a_benefits.pres ));
      params( 18 ) := "+"( Integer'Pos( a_benefits.usual ));
      params( 19 ) := "+"( Integer'Pos( a_benefits.var1 ));
      params( 20 ) := "+"( Integer'Pos( a_benefits.var2 ));
      params( 21 ) := "+"( Integer'Pos( a_benefits.var3 ));
      params( 22 ) := "+"( Integer'Pos( a_benefits.whorec1 ));
      params( 23 ) := "+"( Integer'Pos( a_benefits.whorec2 ));
      params( 24 ) := "+"( Integer'Pos( a_benefits.whorec3 ));
      params( 25 ) := "+"( Integer'Pos( a_benefits.whorec4 ));
      params( 26 ) := "+"( Integer'Pos( a_benefits.whorec5 ));
      params( 27 ) := "+"( Integer'Pos( a_benefits.month ));
      params( 28 ) := "+"( Integer'Pos( a_benefits.issue ));
      params( 29 ) := "+"( Integer'Pos( a_benefits.numyears ));
      params( 30 ) := "+"( Float( a_benefits.ttbprx ));
      params( 31 ) := "+"( Integer'Pos( a_benefits.var4 ));
      params( 32 ) := "+"( Integer'Pos( a_benefits.var5 ));
      params( 33 ) := "+"( Integer'Pos( a_benefits.gtanet ));
      params( 34 ) := "+"( Float( a_benefits.gtatax ));
      params( 35 ) := "+"( Integer'Pos( a_benefits.cbpaye ));
      params( 36 ) := "+"( Integer'Pos( a_benefits.cbtax ));
      params( 37 ) := "+"( Float( a_benefits.cbtaxamt ));
      params( 38 ) := "+"( Integer'Pos( a_benefits.cbtaxpd ));
      params( 39 ) := "+"( Integer'Pos( a_benefits.user_id ));
      params( 40 ) := "+"( Integer'Pos( a_benefits.edition ));
      params( 41 ) := "+"( Integer'Pos( a_benefits.year ));
      params( 42 ) := "+"( Integer'Pos( a_benefits.counter ));
      params( 43 ) := As_Bigint( a_benefits.sernum );
      params( 44 ) := "+"( Integer'Pos( a_benefits.benunit ));
      params( 45 ) := "+"( Integer'Pos( a_benefits.person ));
      params( 46 ) := "+"( Integer'Pos( a_benefits.benefit ));
      
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

   procedure Save( a_benefits : Ukds.Frs.Benefits; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_benefits.user_id, a_benefits.edition, a_benefits.year, a_benefits.counter, a_benefits.sernum, a_benefits.benunit, a_benefits.person, a_benefits.benefit ) then
         Update( a_benefits, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_benefits.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_benefits.edition ));
      params( 3 ) := "+"( Integer'Pos( a_benefits.year ));
      params( 4 ) := "+"( Integer'Pos( a_benefits.counter ));
      params( 5 ) := As_Bigint( a_benefits.sernum );
      params( 6 ) := "+"( Integer'Pos( a_benefits.benunit ));
      params( 7 ) := "+"( Integer'Pos( a_benefits.person ));
      params( 8 ) := "+"( Integer'Pos( a_benefits.benefit ));
      params( 9 ) := "+"( Integer'Pos( a_benefits.bankstmt ));
      params( 10 ) := "+"( Float( a_benefits.benamt ));
      params( 11 ) := "+"( Integer'Pos( a_benefits.benamtdk ));
      params( 12 ) := "+"( Integer'Pos( a_benefits.benlettr ));
      params( 13 ) := "+"( Integer'Pos( a_benefits.benpd ));
      params( 14 ) := "+"( Integer'Pos( a_benefits.bookcard ));
      params( 15 ) := "+"( Integer'Pos( a_benefits.cctc ));
      params( 16 ) := "+"( Float( a_benefits.combamt ));
      params( 17 ) := "+"( Integer'Pos( a_benefits.combbk ));
      params( 18 ) := "+"( Integer'Pos( a_benefits.combpd ));
      params( 19 ) := "+"( Integer'Pos( a_benefits.howben ));
      params( 20 ) := "+"( Float( a_benefits.notusamt ));
      params( 21 ) := "+"( Integer'Pos( a_benefits.notuspd ));
      params( 22 ) := "+"( Integer'Pos( a_benefits.numweeks ));
      params( 23 ) := "+"( Integer'Pos( a_benefits.ordbkno ));
      params( 24 ) := "+"( Integer'Pos( a_benefits.payslipb ));
      params( 25 ) := "+"( Integer'Pos( a_benefits.pres ));
      params( 26 ) := "+"( Integer'Pos( a_benefits.usual ));
      params( 27 ) := "+"( Integer'Pos( a_benefits.var1 ));
      params( 28 ) := "+"( Integer'Pos( a_benefits.var2 ));
      params( 29 ) := "+"( Integer'Pos( a_benefits.var3 ));
      params( 30 ) := "+"( Integer'Pos( a_benefits.whorec1 ));
      params( 31 ) := "+"( Integer'Pos( a_benefits.whorec2 ));
      params( 32 ) := "+"( Integer'Pos( a_benefits.whorec3 ));
      params( 33 ) := "+"( Integer'Pos( a_benefits.whorec4 ));
      params( 34 ) := "+"( Integer'Pos( a_benefits.whorec5 ));
      params( 35 ) := "+"( Integer'Pos( a_benefits.month ));
      params( 36 ) := "+"( Integer'Pos( a_benefits.issue ));
      params( 37 ) := "+"( Integer'Pos( a_benefits.numyears ));
      params( 38 ) := "+"( Float( a_benefits.ttbprx ));
      params( 39 ) := "+"( Integer'Pos( a_benefits.var4 ));
      params( 40 ) := "+"( Integer'Pos( a_benefits.var5 ));
      params( 41 ) := "+"( Integer'Pos( a_benefits.gtanet ));
      params( 42 ) := "+"( Float( a_benefits.gtatax ));
      params( 43 ) := "+"( Integer'Pos( a_benefits.cbpaye ));
      params( 44 ) := "+"( Integer'Pos( a_benefits.cbtax ));
      params( 45 ) := "+"( Float( a_benefits.cbtaxamt ));
      params( 46 ) := "+"( Integer'Pos( a_benefits.cbtaxpd ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Benefits
   --

   procedure Delete( a_benefits : in out Ukds.Frs.Benefits; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_benefits.user_id );
      Add_edition( c, a_benefits.edition );
      Add_year( c, a_benefits.year );
      Add_counter( c, a_benefits.counter );
      Add_sernum( c, a_benefits.sernum );
      Add_benunit( c, a_benefits.benunit );
      Add_person( c, a_benefits.person );
      Add_benefit( c, a_benefits.benefit );
      Delete( c, connection );
      a_benefits := Ukds.Frs.Null_Benefits;
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


   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "person", op, join, person );
   begin
      d.add_to_criteria( c, elem );
   end Add_person;


   procedure Add_benefit( c : in out d.Criteria; benefit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benefit", op, join, benefit );
   begin
      d.add_to_criteria( c, elem );
   end Add_benefit;


   procedure Add_bankstmt( c : in out d.Criteria; bankstmt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bankstmt", op, join, bankstmt );
   begin
      d.add_to_criteria( c, elem );
   end Add_bankstmt;


   procedure Add_benamt( c : in out d.Criteria; benamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benamt", op, join, Long_Float( benamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_benamt;


   procedure Add_benamtdk( c : in out d.Criteria; benamtdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benamtdk", op, join, benamtdk );
   begin
      d.add_to_criteria( c, elem );
   end Add_benamtdk;


   procedure Add_benlettr( c : in out d.Criteria; benlettr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benlettr", op, join, benlettr );
   begin
      d.add_to_criteria( c, elem );
   end Add_benlettr;


   procedure Add_benpd( c : in out d.Criteria; benpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benpd", op, join, benpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_benpd;


   procedure Add_bookcard( c : in out d.Criteria; bookcard : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bookcard", op, join, bookcard );
   begin
      d.add_to_criteria( c, elem );
   end Add_bookcard;


   procedure Add_cctc( c : in out d.Criteria; cctc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cctc", op, join, cctc );
   begin
      d.add_to_criteria( c, elem );
   end Add_cctc;


   procedure Add_combamt( c : in out d.Criteria; combamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "combamt", op, join, Long_Float( combamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_combamt;


   procedure Add_combbk( c : in out d.Criteria; combbk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "combbk", op, join, combbk );
   begin
      d.add_to_criteria( c, elem );
   end Add_combbk;


   procedure Add_combpd( c : in out d.Criteria; combpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "combpd", op, join, combpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_combpd;


   procedure Add_howben( c : in out d.Criteria; howben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "howben", op, join, howben );
   begin
      d.add_to_criteria( c, elem );
   end Add_howben;


   procedure Add_notusamt( c : in out d.Criteria; notusamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "notusamt", op, join, Long_Float( notusamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_notusamt;


   procedure Add_notuspd( c : in out d.Criteria; notuspd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "notuspd", op, join, notuspd );
   begin
      d.add_to_criteria( c, elem );
   end Add_notuspd;


   procedure Add_numweeks( c : in out d.Criteria; numweeks : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numweeks", op, join, numweeks );
   begin
      d.add_to_criteria( c, elem );
   end Add_numweeks;


   procedure Add_ordbkno( c : in out d.Criteria; ordbkno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ordbkno", op, join, ordbkno );
   begin
      d.add_to_criteria( c, elem );
   end Add_ordbkno;


   procedure Add_payslipb( c : in out d.Criteria; payslipb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "payslipb", op, join, payslipb );
   begin
      d.add_to_criteria( c, elem );
   end Add_payslipb;


   procedure Add_pres( c : in out d.Criteria; pres : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pres", op, join, pres );
   begin
      d.add_to_criteria( c, elem );
   end Add_pres;


   procedure Add_usual( c : in out d.Criteria; usual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usual", op, join, usual );
   begin
      d.add_to_criteria( c, elem );
   end Add_usual;


   procedure Add_var1( c : in out d.Criteria; var1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "var1", op, join, var1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_var1;


   procedure Add_var2( c : in out d.Criteria; var2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "var2", op, join, var2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_var2;


   procedure Add_var3( c : in out d.Criteria; var3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "var3", op, join, var3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_var3;


   procedure Add_whorec1( c : in out d.Criteria; whorec1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorec1", op, join, whorec1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec1;


   procedure Add_whorec2( c : in out d.Criteria; whorec2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorec2", op, join, whorec2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec2;


   procedure Add_whorec3( c : in out d.Criteria; whorec3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorec3", op, join, whorec3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec3;


   procedure Add_whorec4( c : in out d.Criteria; whorec4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorec4", op, join, whorec4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec4;


   procedure Add_whorec5( c : in out d.Criteria; whorec5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorec5", op, join, whorec5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec5;


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


   procedure Add_numyears( c : in out d.Criteria; numyears : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numyears", op, join, numyears );
   begin
      d.add_to_criteria( c, elem );
   end Add_numyears;


   procedure Add_ttbprx( c : in out d.Criteria; ttbprx : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttbprx", op, join, Long_Float( ttbprx ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttbprx;


   procedure Add_var4( c : in out d.Criteria; var4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "var4", op, join, var4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_var4;


   procedure Add_var5( c : in out d.Criteria; var5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "var5", op, join, var5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_var5;


   procedure Add_gtanet( c : in out d.Criteria; gtanet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gtanet", op, join, gtanet );
   begin
      d.add_to_criteria( c, elem );
   end Add_gtanet;


   procedure Add_gtatax( c : in out d.Criteria; gtatax : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gtatax", op, join, Long_Float( gtatax ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_gtatax;


   procedure Add_cbpaye( c : in out d.Criteria; cbpaye : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbpaye", op, join, cbpaye );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbpaye;


   procedure Add_cbtax( c : in out d.Criteria; cbtax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbtax", op, join, cbtax );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbtax;


   procedure Add_cbtaxamt( c : in out d.Criteria; cbtaxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbtaxamt", op, join, Long_Float( cbtaxamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbtaxamt;


   procedure Add_cbtaxpd( c : in out d.Criteria; cbtaxpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbtaxpd", op, join, cbtaxpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbtaxpd;


   
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


   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "person", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_person_To_Orderings;


   procedure Add_benefit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benefit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benefit_To_Orderings;


   procedure Add_bankstmt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bankstmt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bankstmt_To_Orderings;


   procedure Add_benamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benamt_To_Orderings;


   procedure Add_benamtdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benamtdk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benamtdk_To_Orderings;


   procedure Add_benlettr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benlettr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benlettr_To_Orderings;


   procedure Add_benpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benpd_To_Orderings;


   procedure Add_bookcard_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bookcard", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bookcard_To_Orderings;


   procedure Add_cctc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cctc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cctc_To_Orderings;


   procedure Add_combamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "combamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_combamt_To_Orderings;


   procedure Add_combbk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "combbk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_combbk_To_Orderings;


   procedure Add_combpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "combpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_combpd_To_Orderings;


   procedure Add_howben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "howben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_howben_To_Orderings;


   procedure Add_notusamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "notusamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_notusamt_To_Orderings;


   procedure Add_notuspd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "notuspd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_notuspd_To_Orderings;


   procedure Add_numweeks_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numweeks", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numweeks_To_Orderings;


   procedure Add_ordbkno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ordbkno", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ordbkno_To_Orderings;


   procedure Add_payslipb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "payslipb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_payslipb_To_Orderings;


   procedure Add_pres_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pres", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pres_To_Orderings;


   procedure Add_usual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usual_To_Orderings;


   procedure Add_var1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "var1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_var1_To_Orderings;


   procedure Add_var2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "var2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_var2_To_Orderings;


   procedure Add_var3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "var3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_var3_To_Orderings;


   procedure Add_whorec1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorec1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec1_To_Orderings;


   procedure Add_whorec2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorec2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec2_To_Orderings;


   procedure Add_whorec3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorec3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec3_To_Orderings;


   procedure Add_whorec4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorec4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec4_To_Orderings;


   procedure Add_whorec5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorec5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorec5_To_Orderings;


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


   procedure Add_numyears_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numyears", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numyears_To_Orderings;


   procedure Add_ttbprx_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttbprx", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttbprx_To_Orderings;


   procedure Add_var4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "var4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_var4_To_Orderings;


   procedure Add_var5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "var5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_var5_To_Orderings;


   procedure Add_gtanet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gtanet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gtanet_To_Orderings;


   procedure Add_gtatax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gtatax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gtatax_To_Orderings;


   procedure Add_cbpaye_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbpaye", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbpaye_To_Orderings;


   procedure Add_cbtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbtax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbtax_To_Orderings;


   procedure Add_cbtaxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbtaxamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbtaxamt_To_Orderings;


   procedure Add_cbtaxpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbtaxpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbtaxpd_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Benefits_IO;
