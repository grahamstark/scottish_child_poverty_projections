--
-- Created by ada_generator.py on 2017-09-20 22:07:22.855357
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

package Ukds.Frs.Renter_IO is
  
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
   -- returns true if the primary key parts of a_renter match the defaults in Ukds.Frs.Null_Renter
   --
   function Is_Null( a_renter : Renter ) return Boolean;
   
   --
   -- returns the single a_renter matching the primary key fields, or the Ukds.Frs.Null_Renter record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Renter;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Renter matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Renter_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Renter retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Renter_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_renter : Ukds.Frs.Renter; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Renter
   --
   procedure Delete( a_renter : in out Ukds.Frs.Renter; connection : Database_Connection := null );
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
   procedure Add_accjbp01( c : in out d.Criteria; accjbp01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp02( c : in out d.Criteria; accjbp02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp03( c : in out d.Criteria; accjbp03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp04( c : in out d.Criteria; accjbp04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp05( c : in out d.Criteria; accjbp05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp06( c : in out d.Criteria; accjbp06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp07( c : in out d.Criteria; accjbp07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp08( c : in out d.Criteria; accjbp08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp09( c : in out d.Criteria; accjbp09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp10( c : in out d.Criteria; accjbp10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp11( c : in out d.Criteria; accjbp11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp12( c : in out d.Criteria; accjbp12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp13( c : in out d.Criteria; accjbp13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjbp14( c : in out d.Criteria; accjbp14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjob( c : in out d.Criteria; accjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accnonhh( c : in out d.Criteria; accnonhh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctract( c : in out d.Criteria; ctract : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligamt( c : in out d.Criteria; eligamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligpd( c : in out d.Criteria; eligpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fairrent( c : in out d.Criteria; fairrent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnish( c : in out d.Criteria; furnish : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbenamt( c : in out d.Criteria; hbenamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbenchk( c : in out d.Criteria; hbenchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbenefit( c : in out d.Criteria; hbenefit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbenpd( c : in out d.Criteria; hbenpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbenwait( c : in out d.Criteria; hbenwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbweeks( c : in out d.Criteria; hbweeks : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_landlord( c : in out d.Criteria; landlord : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_niystart( c : in out d.Criteria; niystart : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othway( c : in out d.Criteria; othway : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rebate( c : in out d.Criteria; rebate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rent( c : in out d.Criteria; rent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentdk( c : in out d.Criteria; rentdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentdoc( c : in out d.Criteria; rentdoc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentfull( c : in out d.Criteria; rentfull : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_renthol( c : in out d.Criteria; renthol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentpd( c : in out d.Criteria; rentpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_resll( c : in out d.Criteria; resll : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_resll2( c : in out d.Criteria; resll2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc1( c : in out d.Criteria; serinc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc2( c : in out d.Criteria; serinc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc3( c : in out d.Criteria; serinc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc4( c : in out d.Criteria; serinc4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc5( c : in out d.Criteria; serinc5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_short1( c : in out d.Criteria; short1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_short2( c : in out d.Criteria; short2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_weekhol( c : in out d.Criteria; weekhol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wsinc( c : in out d.Criteria; wsinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wsincamt( c : in out d.Criteria; wsincamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ystartr( c : in out d.Criteria; ystartr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbyears( c : in out d.Criteria; hbyears : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lowshort( c : in out d.Criteria; lowshort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othtype( c : in out d.Criteria; othtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tentype( c : in out d.Criteria; tentype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbmnth( c : in out d.Criteria; hbmnth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbyear( c : in out d.Criteria; hbyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbrecp( c : in out d.Criteria; hbrecp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lhaexs( c : in out d.Criteria; lhaexs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lhalss( c : in out d.Criteria; lhalss : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentpd1( c : in out d.Criteria; rentpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentpd2( c : in out d.Criteria; rentpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc6( c : in out d.Criteria; serinc6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc7( c : in out d.Criteria; serinc7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serinc8( c : in out d.Criteria; serinc8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serincam( c : in out d.Criteria; serincam : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjbp14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accnonhh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctract_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fairrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnish_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbenamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbenchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbenefit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbenpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbenwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbweeks_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_landlord_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_niystart_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othway_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rebate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentdoc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentfull_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_renthol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_resll_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_resll2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_short1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_short2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_weekhol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wsinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wsincamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ystartr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbyears_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lowshort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tentype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbmnth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbrecp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lhaexs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lhalss_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serinc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serincam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Renter;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 71, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : accjbp01                 : Parameter_Integer  : Integer              :        0 
   --    6 : accjbp02                 : Parameter_Integer  : Integer              :        0 
   --    7 : accjbp03                 : Parameter_Integer  : Integer              :        0 
   --    8 : accjbp04                 : Parameter_Integer  : Integer              :        0 
   --    9 : accjbp05                 : Parameter_Integer  : Integer              :        0 
   --   10 : accjbp06                 : Parameter_Integer  : Integer              :        0 
   --   11 : accjbp07                 : Parameter_Integer  : Integer              :        0 
   --   12 : accjbp08                 : Parameter_Integer  : Integer              :        0 
   --   13 : accjbp09                 : Parameter_Integer  : Integer              :        0 
   --   14 : accjbp10                 : Parameter_Integer  : Integer              :        0 
   --   15 : accjbp11                 : Parameter_Integer  : Integer              :        0 
   --   16 : accjbp12                 : Parameter_Integer  : Integer              :        0 
   --   17 : accjbp13                 : Parameter_Integer  : Integer              :        0 
   --   18 : accjbp14                 : Parameter_Integer  : Integer              :        0 
   --   19 : accjob                   : Parameter_Integer  : Integer              :        0 
   --   20 : accnonhh                 : Parameter_Integer  : Integer              :        0 
   --   21 : ctract                   : Parameter_Integer  : Integer              :        0 
   --   22 : eligamt                  : Parameter_Float    : Amount               :      0.0 
   --   23 : eligpd                   : Parameter_Integer  : Integer              :        0 
   --   24 : fairrent                 : Parameter_Integer  : Integer              :        0 
   --   25 : furnish                  : Parameter_Integer  : Integer              :        0 
   --   26 : hbenamt                  : Parameter_Float    : Amount               :      0.0 
   --   27 : hbenchk                  : Parameter_Integer  : Integer              :        0 
   --   28 : hbenefit                 : Parameter_Integer  : Integer              :        0 
   --   29 : hbenpd                   : Parameter_Integer  : Integer              :        0 
   --   30 : hbenwait                 : Parameter_Integer  : Integer              :        0 
   --   31 : hbweeks                  : Parameter_Integer  : Integer              :        0 
   --   32 : landlord                 : Parameter_Integer  : Integer              :        0 
   --   33 : niystart                 : Parameter_Integer  : Integer              :        0 
   --   34 : othway                   : Parameter_Integer  : Integer              :        0 
   --   35 : rebate                   : Parameter_Integer  : Integer              :        0 
   --   36 : rent                     : Parameter_Float    : Amount               :      0.0 
   --   37 : rentdk                   : Parameter_Integer  : Integer              :        0 
   --   38 : rentdoc                  : Parameter_Integer  : Integer              :        0 
   --   39 : rentfull                 : Parameter_Float    : Amount               :      0.0 
   --   40 : renthol                  : Parameter_Integer  : Integer              :        0 
   --   41 : rentpd                   : Parameter_Integer  : Integer              :        0 
   --   42 : resll                    : Parameter_Integer  : Integer              :        0 
   --   43 : resll2                   : Parameter_Integer  : Integer              :        0 
   --   44 : serinc1                  : Parameter_Integer  : Integer              :        0 
   --   45 : serinc2                  : Parameter_Integer  : Integer              :        0 
   --   46 : serinc3                  : Parameter_Integer  : Integer              :        0 
   --   47 : serinc4                  : Parameter_Integer  : Integer              :        0 
   --   48 : serinc5                  : Parameter_Integer  : Integer              :        0 
   --   49 : short1                   : Parameter_Integer  : Integer              :        0 
   --   50 : short2                   : Parameter_Integer  : Integer              :        0 
   --   51 : weekhol                  : Parameter_Integer  : Integer              :        0 
   --   52 : wsinc                    : Parameter_Integer  : Integer              :        0 
   --   53 : wsincamt                 : Parameter_Float    : Amount               :      0.0 
   --   54 : ystartr                  : Parameter_Integer  : Integer              :        0 
   --   55 : month                    : Parameter_Integer  : Integer              :        0 
   --   56 : hbyears                  : Parameter_Integer  : Integer              :        0 
   --   57 : lowshort                 : Parameter_Integer  : Integer              :        0 
   --   58 : othtype                  : Parameter_Integer  : Integer              :        0 
   --   59 : tentype                  : Parameter_Integer  : Integer              :        0 
   --   60 : hbmnth                   : Parameter_Integer  : Integer              :        0 
   --   61 : hbyear                   : Parameter_Integer  : Integer              :        0 
   --   62 : issue                    : Parameter_Integer  : Integer              :        0 
   --   63 : hbrecp                   : Parameter_Integer  : Integer              :        0 
   --   64 : lhaexs                   : Parameter_Integer  : Integer              :        0 
   --   65 : lhalss                   : Parameter_Integer  : Integer              :        0 
   --   66 : rentpd1                  : Parameter_Integer  : Integer              :        0 
   --   67 : rentpd2                  : Parameter_Integer  : Integer              :        0 
   --   68 : serinc6                  : Parameter_Integer  : Integer              :        0 
   --   69 : serinc7                  : Parameter_Integer  : Integer              :        0 
   --   70 : serinc8                  : Parameter_Integer  : Integer              :        0 
   --   71 : serincam                 : Parameter_Integer  : Integer              :        0 
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

  
end Ukds.Frs.Renter_IO;
