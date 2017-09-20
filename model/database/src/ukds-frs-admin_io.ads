--
-- Created by ada_generator.py on 2017-09-20 22:07:22.285616
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

package Ukds.Frs.Admin_IO is
  
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
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;

   --
   -- returns true if the primary key parts of a_admin match the defaults in Ukds.Frs.Null_Admin
   --
   function Is_Null( a_admin : Admin ) return Boolean;
   
   --
   -- returns the single a_admin matching the primary key fields, or the Ukds.Frs.Null_Admin record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Admin;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Admin matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Admin_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Admin retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Admin_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_admin : Ukds.Frs.Admin; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Admin
   --
   procedure Delete( a_admin : in out Ukds.Frs.Admin; connection : Database_Connection := null );
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
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_findhh( c : in out d.Criteria; findhh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhsel( c : in out d.Criteria; hhsel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hout( c : in out d.Criteria; hout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr1( c : in out d.Criteria; ncr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr2( c : in out d.Criteria; ncr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr3( c : in out d.Criteria; ncr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr4( c : in out d.Criteria; ncr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr5( c : in out d.Criteria; ncr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr6( c : in out d.Criteria; ncr6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ncr7( c : in out d.Criteria; ncr7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr01( c : in out d.Criteria; refr01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr02( c : in out d.Criteria; refr02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr03( c : in out d.Criteria; refr03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr04( c : in out d.Criteria; refr04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr05( c : in out d.Criteria; refr05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr06( c : in out d.Criteria; refr06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr07( c : in out d.Criteria; refr07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr08( c : in out d.Criteria; refr08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr09( c : in out d.Criteria; refr09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr10( c : in out d.Criteria; refr10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr11( c : in out d.Criteria; refr11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr12( c : in out d.Criteria; refr12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr13( c : in out d.Criteria; refr13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr14( c : in out d.Criteria; refr14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr15( c : in out d.Criteria; refr15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr16( c : in out d.Criteria; refr16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr17( c : in out d.Criteria; refr17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_refr18( c : in out d.Criteria; refr18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tnc( c : in out d.Criteria; tnc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_version( c : in out d.Criteria; version : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf01( c : in out d.Criteria; lngdf01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf02( c : in out d.Criteria; lngdf02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf03( c : in out d.Criteria; lngdf03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf04( c : in out d.Criteria; lngdf04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf05( c : in out d.Criteria; lngdf05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf06( c : in out d.Criteria; lngdf06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf07( c : in out d.Criteria; lngdf07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf08( c : in out d.Criteria; lngdf08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf09( c : in out d.Criteria; lngdf09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf10( c : in out d.Criteria; lngdf10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nmtrans( c : in out d.Criteria; nmtrans : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_noneng( c : in out d.Criteria; noneng : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang01( c : in out d.Criteria; whlang01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang02( c : in out d.Criteria; whlang02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang03( c : in out d.Criteria; whlang03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang04( c : in out d.Criteria; whlang04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang05( c : in out d.Criteria; whlang05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang06( c : in out d.Criteria; whlang06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang07( c : in out d.Criteria; whlang07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang08( c : in out d.Criteria; whlang08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang09( c : in out d.Criteria; whlang09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang10( c : in out d.Criteria; whlang10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whotran1( c : in out d.Criteria; whotran1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whotran2( c : in out d.Criteria; whotran2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whotran3( c : in out d.Criteria; whotran3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whotran4( c : in out d.Criteria; whotran4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whotran5( c : in out d.Criteria; whotran5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lngdf11( c : in out d.Criteria; lngdf11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whlang11( c : in out d.Criteria; whlang11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_findhh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhsel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ncr7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_refr18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tnc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_version_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nmtrans_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_noneng_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whotran1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whotran2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whotran3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whotran4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whotran5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lngdf11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whlang11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Admin;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 65, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : findhh                   : Parameter_Integer  : Integer              :        0 
   --    6 : hhsel                    : Parameter_Integer  : Integer              :        0 
   --    7 : hout                     : Parameter_Integer  : Integer              :        0 
   --    8 : ncr1                     : Parameter_Integer  : Integer              :        0 
   --    9 : ncr2                     : Parameter_Integer  : Integer              :        0 
   --   10 : ncr3                     : Parameter_Integer  : Integer              :        0 
   --   11 : ncr4                     : Parameter_Integer  : Integer              :        0 
   --   12 : ncr5                     : Parameter_Integer  : Integer              :        0 
   --   13 : ncr6                     : Parameter_Integer  : Integer              :        0 
   --   14 : ncr7                     : Parameter_Integer  : Integer              :        0 
   --   15 : refr01                   : Parameter_Integer  : Integer              :        0 
   --   16 : refr02                   : Parameter_Integer  : Integer              :        0 
   --   17 : refr03                   : Parameter_Integer  : Integer              :        0 
   --   18 : refr04                   : Parameter_Integer  : Integer              :        0 
   --   19 : refr05                   : Parameter_Integer  : Integer              :        0 
   --   20 : refr06                   : Parameter_Integer  : Integer              :        0 
   --   21 : refr07                   : Parameter_Integer  : Integer              :        0 
   --   22 : refr08                   : Parameter_Integer  : Integer              :        0 
   --   23 : refr09                   : Parameter_Integer  : Integer              :        0 
   --   24 : refr10                   : Parameter_Integer  : Integer              :        0 
   --   25 : refr11                   : Parameter_Integer  : Integer              :        0 
   --   26 : refr12                   : Parameter_Integer  : Integer              :        0 
   --   27 : refr13                   : Parameter_Integer  : Integer              :        0 
   --   28 : refr14                   : Parameter_Integer  : Integer              :        0 
   --   29 : refr15                   : Parameter_Integer  : Integer              :        0 
   --   30 : refr16                   : Parameter_Integer  : Integer              :        0 
   --   31 : refr17                   : Parameter_Integer  : Integer              :        0 
   --   32 : refr18                   : Parameter_Integer  : Integer              :        0 
   --   33 : tnc                      : Parameter_Integer  : Integer              :        0 
   --   34 : version                  : Parameter_Integer  : Integer              :        0 
   --   35 : month                    : Parameter_Integer  : Integer              :        0 
   --   36 : issue                    : Parameter_Integer  : Integer              :        0 
   --   37 : lngdf01                  : Parameter_Integer  : Integer              :        0 
   --   38 : lngdf02                  : Parameter_Integer  : Integer              :        0 
   --   39 : lngdf03                  : Parameter_Integer  : Integer              :        0 
   --   40 : lngdf04                  : Parameter_Integer  : Integer              :        0 
   --   41 : lngdf05                  : Parameter_Integer  : Integer              :        0 
   --   42 : lngdf06                  : Parameter_Integer  : Integer              :        0 
   --   43 : lngdf07                  : Parameter_Integer  : Integer              :        0 
   --   44 : lngdf08                  : Parameter_Integer  : Integer              :        0 
   --   45 : lngdf09                  : Parameter_Integer  : Integer              :        0 
   --   46 : lngdf10                  : Parameter_Integer  : Integer              :        0 
   --   47 : nmtrans                  : Parameter_Integer  : Integer              :        0 
   --   48 : noneng                   : Parameter_Integer  : Integer              :        0 
   --   49 : whlang01                 : Parameter_Integer  : Integer              :        0 
   --   50 : whlang02                 : Parameter_Integer  : Integer              :        0 
   --   51 : whlang03                 : Parameter_Integer  : Integer              :        0 
   --   52 : whlang04                 : Parameter_Integer  : Integer              :        0 
   --   53 : whlang05                 : Parameter_Integer  : Integer              :        0 
   --   54 : whlang06                 : Parameter_Integer  : Integer              :        0 
   --   55 : whlang07                 : Parameter_Integer  : Integer              :        0 
   --   56 : whlang08                 : Parameter_Integer  : Integer              :        0 
   --   57 : whlang09                 : Parameter_Integer  : Integer              :        0 
   --   58 : whlang10                 : Parameter_Integer  : Integer              :        0 
   --   59 : whotran1                 : Parameter_Integer  : Integer              :        0 
   --   60 : whotran2                 : Parameter_Integer  : Integer              :        0 
   --   61 : whotran3                 : Parameter_Integer  : Integer              :        0 
   --   62 : whotran4                 : Parameter_Integer  : Integer              :        0 
   --   63 : whotran5                 : Parameter_Integer  : Integer              :        0 
   --   64 : lngdf11                  : Parameter_Integer  : Integer              :        0 
   --   65 : whlang11                 : Parameter_Integer  : Integer              :        0 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 4, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Admin_IO;
