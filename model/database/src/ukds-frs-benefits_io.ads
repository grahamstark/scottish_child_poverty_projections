--
-- Created by ada_generator.py on 2017-09-20 20:40:54.971929
-- 
with Ukds;
with DB_Commons;
with Base_Types;
with ADA.Calendar;
with Ada.Strings.Unbounded;

with GNATCOLL.SQL.Exec;

with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds.Frs.Benefits_IO is
  
   package d renames DB_Commons;   
   use Base_Types;
   use Ada.Strings.Unbounded;
   use Ada.Calendar;
   
   SCHEMA_NAME : constant String := "frs";
   
   use GNATCOLL.SQL.Exec;
   
   use Ukds;
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_user_id( connection : Database_Connection := null) return Integer;
   function Next_Free_edition( connection : Database_Connection := null) return Integer;
   function Next_Free_year( connection : Database_Connection := null) return Integer;
   function Next_Free_counter( connection : Database_Connection := null) return Integer;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;
   function Next_Free_benunit( connection : Database_Connection := null) return Integer;
   function Next_Free_person( connection : Database_Connection := null) return Integer;
   function Next_Free_benefit( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_benefits match the defaults in Ukds.Frs.Null_Benefits
   --
   function Is_Null( a_benefits : Benefits ) return Boolean;
   
   --
   -- returns the single a_benefits matching the primary key fields, or the Ukds.Frs.Null_Benefits record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; benefit : Integer; connection : Database_Connection := null ) return Ukds.Frs.Benefits;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; benefit : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Benefits matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Benefits retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_benefits : Ukds.Frs.Benefits; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Benefits
   --
   procedure Delete( a_benefits : in out Ukds.Frs.Benefits; connection : Database_Connection := null );
   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null );
   --
   -- delete all the records identified by the where SQL clause 
   --
   procedure Delete( where_Clause : String; connection : Database_Connection := null );
   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_counter( c : in out d.Criteria; counter : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benefit( c : in out d.Criteria; benefit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bankstmt( c : in out d.Criteria; bankstmt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benamt( c : in out d.Criteria; benamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benamtdk( c : in out d.Criteria; benamtdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benlettr( c : in out d.Criteria; benlettr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benpd( c : in out d.Criteria; benpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bookcard( c : in out d.Criteria; bookcard : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cctc( c : in out d.Criteria; cctc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_combamt( c : in out d.Criteria; combamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_combbk( c : in out d.Criteria; combbk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_combpd( c : in out d.Criteria; combpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howben( c : in out d.Criteria; howben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_notusamt( c : in out d.Criteria; notusamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_notuspd( c : in out d.Criteria; notuspd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numweeks( c : in out d.Criteria; numweeks : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ordbkno( c : in out d.Criteria; ordbkno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_payslipb( c : in out d.Criteria; payslipb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pres( c : in out d.Criteria; pres : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usual( c : in out d.Criteria; usual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_var1( c : in out d.Criteria; var1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_var2( c : in out d.Criteria; var2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_var3( c : in out d.Criteria; var3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorec1( c : in out d.Criteria; whorec1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorec2( c : in out d.Criteria; whorec2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorec3( c : in out d.Criteria; whorec3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorec4( c : in out d.Criteria; whorec4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorec5( c : in out d.Criteria; whorec5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numyears( c : in out d.Criteria; numyears : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttbprx( c : in out d.Criteria; ttbprx : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_var4( c : in out d.Criteria; var4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_var5( c : in out d.Criteria; var5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gtanet( c : in out d.Criteria; gtanet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gtatax( c : in out d.Criteria; gtatax : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbpaye( c : in out d.Criteria; cbpaye : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbtax( c : in out d.Criteria; cbtax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbtaxamt( c : in out d.Criteria; cbtaxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbtaxpd( c : in out d.Criteria; cbtaxpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_counter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benefit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bankstmt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benamtdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benlettr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bookcard_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cctc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_combamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_combbk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_combpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_notusamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_notuspd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numweeks_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ordbkno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_payslipb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pres_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_var1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_var2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_var3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorec1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorec2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorec3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorec4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorec5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numyears_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttbprx_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_var4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_var5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gtanet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gtatax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbpaye_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbtaxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbtaxpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Benefits;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 46, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    7 : person                   : Parameter_Integer  : Integer              :        0 
   --    8 : benefit                  : Parameter_Integer  : Integer              :        0 
   --    9 : bankstmt                 : Parameter_Integer  : Integer              :        0 
   --   10 : benamt                   : Parameter_Float    : Amount               :      0.0 
   --   11 : benamtdk                 : Parameter_Integer  : Integer              :        0 
   --   12 : benlettr                 : Parameter_Integer  : Integer              :        0 
   --   13 : benpd                    : Parameter_Integer  : Integer              :        0 
   --   14 : bookcard                 : Parameter_Integer  : Integer              :        0 
   --   15 : cctc                     : Parameter_Integer  : Integer              :        0 
   --   16 : combamt                  : Parameter_Float    : Amount               :      0.0 
   --   17 : combbk                   : Parameter_Integer  : Integer              :        0 
   --   18 : combpd                   : Parameter_Integer  : Integer              :        0 
   --   19 : howben                   : Parameter_Integer  : Integer              :        0 
   --   20 : notusamt                 : Parameter_Float    : Amount               :      0.0 
   --   21 : notuspd                  : Parameter_Integer  : Integer              :        0 
   --   22 : numweeks                 : Parameter_Integer  : Integer              :        0 
   --   23 : ordbkno                  : Parameter_Integer  : Integer              :        0 
   --   24 : payslipb                 : Parameter_Integer  : Integer              :        0 
   --   25 : pres                     : Parameter_Integer  : Integer              :        0 
   --   26 : usual                    : Parameter_Integer  : Integer              :        0 
   --   27 : var1                     : Parameter_Integer  : Integer              :        0 
   --   28 : var2                     : Parameter_Integer  : Integer              :        0 
   --   29 : var3                     : Parameter_Integer  : Integer              :        0 
   --   30 : whorec1                  : Parameter_Integer  : Integer              :        0 
   --   31 : whorec2                  : Parameter_Integer  : Integer              :        0 
   --   32 : whorec3                  : Parameter_Integer  : Integer              :        0 
   --   33 : whorec4                  : Parameter_Integer  : Integer              :        0 
   --   34 : whorec5                  : Parameter_Integer  : Integer              :        0 
   --   35 : month                    : Parameter_Integer  : Integer              :        0 
   --   36 : issue                    : Parameter_Integer  : Integer              :        0 
   --   37 : numyears                 : Parameter_Integer  : Integer              :        0 
   --   38 : ttbprx                   : Parameter_Float    : Amount               :      0.0 
   --   39 : var4                     : Parameter_Integer  : Integer              :        0 
   --   40 : var5                     : Parameter_Integer  : Integer              :        0 
   --   41 : gtanet                   : Parameter_Integer  : Integer              :        0 
   --   42 : gtatax                   : Parameter_Float    : Amount               :      0.0 
   --   43 : cbpaye                   : Parameter_Integer  : Integer              :        0 
   --   44 : cbtax                    : Parameter_Integer  : Integer              :        0 
   --   45 : cbtaxamt                 : Parameter_Float    : Amount               :      0.0 
   --   46 : cbtaxpd                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Insert_Params( update_order : Boolean := False ) return GNATCOLL.SQL.Exec.SQL_Parameters;


--
-- a prepared statement of the form insert into xx values ( [ everything, including pk fields ] )
--
   function Get_Prepared_Insert_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;

--
-- a prepared statement of the form update xx set [ everything except pk fields ] where [pk fields ] 
-- 
   function Get_Prepared_Update_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 8, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    7 : person                   : Parameter_Integer  : Integer              :        0 
   --    8 : benefit                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Benefits_IO;
