--
-- Created by ada_generator.py on 2017-09-20 12:26:49.962876
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

package Ukds.Frs.Househol_IO is
  
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
   -- returns true if the primary key parts of a_househol match the defaults in Ukds.Frs.Null_Househol
   --
   function Is_Null( a_househol : Househol ) return Boolean;
   
   --
   -- returns the single a_househol matching the primary key fields, or the Ukds.Frs.Null_Househol record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Househol;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Househol matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Househol_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Househol retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Househol_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_househol : Ukds.Frs.Househol; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Househol
   --
   procedure Delete( a_househol : in out Ukds.Frs.Househol; connection : Database_Connection := null );
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
   function Retrieve_Associated_Ukds_Frs_Govpays( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Govpay_List;
   function Retrieve_Associated_Ukds_Frs_Maints( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Maint_List;
   function Retrieve_Associated_Ukds_Frs_Owners( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Owner_List;
   function Retrieve_Associated_Ukds_Frs_Accounts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Accounts_List;
   function Retrieve_Associated_Ukds_Frs_Nimigras( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Nimigra_List;
   function Retrieve_Associated_Ukds_Frs_Pianon1516s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1516_List;
   function Retrieve_Associated_Ukds_Frs_Pianon1415s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1415_List;
   function Retrieve_Associated_Ukds_Frs_Rentconts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Rentcont_List;
   function Retrieve_Associated_Ukds_Frs_Mortgages( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Mortgage_List;
   function Retrieve_Associated_Ukds_Frs_Transacts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Transact_List;
   function Retrieve_Associated_Ukds_Frs_Nimigrs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Nimigr_List;
   function Retrieve_Associated_Ukds_Frs_Pianon1314s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1314_List;
   function Retrieve_Associated_Ukds_Frs_Prscrptns( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List;
   function Retrieve_Associated_Ukds_Frs_Insurancs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Insuranc_List;
   function Retrieve_Child_Ukds_Frs_Renter( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null) return Ukds.Frs.Renter;
   function Retrieve_Associated_Ukds_Frs_Vehicles( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Vehicle_List;
   function Retrieve_Associated_Ukds_Frs_Oddjobs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Oddjob_List;
   function Retrieve_Associated_Ukds_Frs_Penamts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Penamt_List;
   function Retrieve_Associated_Ukds_Frs_Chldcares( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List;
   function Retrieve_Associated_Ukds_Frs_Endowmnts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Endowmnt_List;
   function Retrieve_Associated_Ukds_Frs_Penprovs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List;
   function Retrieve_Associated_Ukds_Frs_Jobs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Job_List;
   function Retrieve_Associated_Ukds_Frs_Pianon1213s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1213_List;
   function Retrieve_Associated_Ukds_Frs_Adults( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Adult_List;
   function Retrieve_Associated_Ukds_Frs_Childs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Child_List;
   function Retrieve_Associated_Ukds_Frs_Benunits( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Benunit_List;
   function Retrieve_Associated_Ukds_Frs_Cares( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Care_List;
   function Retrieve_Associated_Ukds_Frs_Pianon1011s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1011_List;
   function Retrieve_Associated_Ukds_Frs_Extchilds( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Extchild_List;
   function Retrieve_Associated_Ukds_Frs_Benefits( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List;
   function Retrieve_Associated_Ukds_Frs_Assets( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Assets_List;
   function Retrieve_Child_Ukds_Frs_Admin( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null) return Ukds.Frs.Admin;
   function Retrieve_Associated_Ukds_Frs_Accouts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Accouts_List;
   function Retrieve_Associated_Ukds_Frs_Mortconts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Mortcont_List;
   function Retrieve_Associated_Ukds_Frs_Pensions( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pension_List;
   function Retrieve_Associated_Ukds_Frs_Childcares( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List;
   function Retrieve_Associated_Ukds_Frs_Pianom0809s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianom0809_List;
   function Retrieve_Associated_Ukds_Frs_Pianon0910s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910_List;

   --
   -- functions to add something to a criteria
   --
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acorn( c : in out d.Criteria; acorn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bedroom( c : in out d.Criteria; bedroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benunits( c : in out d.Criteria; benunits : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billrate( c : in out d.Criteria; billrate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_busroom( c : in out d.Criteria; busroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_centfuel( c : in out d.Criteria; centfuel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_centheat( c : in out d.Criteria; centheat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge1( c : in out d.Criteria; charge1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge2( c : in out d.Criteria; charge2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge3( c : in out d.Criteria; charge3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge4( c : in out d.Criteria; charge4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge5( c : in out d.Criteria; charge5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge6( c : in out d.Criteria; charge6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge7( c : in out d.Criteria; charge7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge8( c : in out d.Criteria; charge8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_charge9( c : in out d.Criteria; charge9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chins( c : in out d.Criteria; chins : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt1( c : in out d.Criteria; chrgamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt2( c : in out d.Criteria; chrgamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt3( c : in out d.Criteria; chrgamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt4( c : in out d.Criteria; chrgamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt5( c : in out d.Criteria; chrgamt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt6( c : in out d.Criteria; chrgamt6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt7( c : in out d.Criteria; chrgamt7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt8( c : in out d.Criteria; chrgamt8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgamt9( c : in out d.Criteria; chrgamt9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd1( c : in out d.Criteria; chrgpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd2( c : in out d.Criteria; chrgpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd3( c : in out d.Criteria; chrgpd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd4( c : in out d.Criteria; chrgpd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd5( c : in out d.Criteria; chrgpd5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd6( c : in out d.Criteria; chrgpd6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd7( c : in out d.Criteria; chrgpd7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd8( c : in out d.Criteria; chrgpd8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrgpd9( c : in out d.Criteria; chrgpd9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_contv1( c : in out d.Criteria; contv1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_contv2( c : in out d.Criteria; contv2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_covoths( c : in out d.Criteria; covoths : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_csewamt( c : in out d.Criteria; csewamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_csewamt1( c : in out d.Criteria; csewamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ct25d50d( c : in out d.Criteria; ct25d50d : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctamt( c : in out d.Criteria; ctamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctannual( c : in out d.Criteria; ctannual : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctband( c : in out d.Criteria; ctband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctbwait( c : in out d.Criteria; ctbwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctcondoc( c : in out d.Criteria; ctcondoc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctdisc( c : in out d.Criteria; ctdisc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctinstal( c : in out d.Criteria; ctinstal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctlvband( c : in out d.Criteria; ctlvband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctlvchk( c : in out d.Criteria; ctlvchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctreb( c : in out d.Criteria; ctreb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctrebamt( c : in out d.Criteria; ctrebamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctrebpd( c : in out d.Criteria; ctrebpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cttime( c : in out d.Criteria; cttime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cwatamt( c : in out d.Criteria; cwatamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cwatamt1( c : in out d.Criteria; cwatamt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_datyrago( c : in out d.Criteria; datyrago : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_entry1( c : in out d.Criteria; entry1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_entry2( c : in out d.Criteria; entry2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_entry3( c : in out d.Criteria; entry3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_entry4( c : in out d.Criteria; entry4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_estrtann( c : in out d.Criteria; estrtann : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_floor( c : in out d.Criteria; floor : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givehelp( c : in out d.Criteria; givehelp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gor( c : in out d.Criteria; gor : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gvtregn( c : in out d.Criteria; gvtregn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr01( c : in out d.Criteria; hhldr01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr02( c : in out d.Criteria; hhldr02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr03( c : in out d.Criteria; hhldr03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr04( c : in out d.Criteria; hhldr04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr05( c : in out d.Criteria; hhldr05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr06( c : in out d.Criteria; hhldr06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr07( c : in out d.Criteria; hhldr07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr08( c : in out d.Criteria; hhldr08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr09( c : in out d.Criteria; hhldr09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr10( c : in out d.Criteria; hhldr10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr11( c : in out d.Criteria; hhldr11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr12( c : in out d.Criteria; hhldr12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr13( c : in out d.Criteria; hhldr13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr14( c : in out d.Criteria; hhldr14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhldr97( c : in out d.Criteria; hhldr97 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhstat( c : in out d.Criteria; hhstat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrpnum( c : in out d.Criteria; hrpnum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intdate( c : in out d.Criteria; intdate : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lac( c : in out d.Criteria; lac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mainacc( c : in out d.Criteria; mainacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mnthcode( c : in out d.Criteria; mnthcode : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon01( c : in out d.Criteria; modcon01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon02( c : in out d.Criteria; modcon02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon03( c : in out d.Criteria; modcon03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon04( c : in out d.Criteria; modcon04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon05( c : in out d.Criteria; modcon05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon06( c : in out d.Criteria; modcon06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon07( c : in out d.Criteria; modcon07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon08( c : in out d.Criteria; modcon08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon09( c : in out d.Criteria; modcon09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon10( c : in out d.Criteria; modcon10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon11( c : in out d.Criteria; modcon11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon12( c : in out d.Criteria; modcon12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon13( c : in out d.Criteria; modcon13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_modcon14( c : in out d.Criteria; modcon14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_monlive( c : in out d.Criteria; monlive : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_needhelp( c : in out d.Criteria; needhelp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nicoun( c : in out d.Criteria; nicoun : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninrv( c : in out d.Criteria; ninrv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nirate( c : in out d.Criteria; nirate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_norate( c : in out d.Criteria; norate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_onbsroom( c : in out d.Criteria; onbsroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_orgsewam( c : in out d.Criteria; orgsewam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_orgwatam( c : in out d.Criteria; orgwatam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_payrate( c : in out d.Criteria; payrate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_premium( c : in out d.Criteria; premium : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ptbsroom( c : in out d.Criteria; ptbsroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rooms( c : in out d.Criteria; rooms : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_roomshar( c : in out d.Criteria; roomshar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtannual( c : in out d.Criteria; rtannual : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtcheck( c : in out d.Criteria; rtcheck : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtcondoc( c : in out d.Criteria; rtcondoc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtdeduc( c : in out d.Criteria; rtdeduc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtinstal( c : in out d.Criteria; rtinstal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtreb( c : in out d.Criteria; rtreb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtrebamt( c : in out d.Criteria; rtrebamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtrebpd( c : in out d.Criteria; rtrebpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rttime( c : in out d.Criteria; rttime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sampqtr( c : in out d.Criteria; sampqtr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_schmeal( c : in out d.Criteria; schmeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_schmilk( c : in out d.Criteria; schmilk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sewamt( c : in out d.Criteria; sewamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sewanul( c : in out d.Criteria; sewanul : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sewerpay( c : in out d.Criteria; sewerpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sewsep( c : in out d.Criteria; sewsep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sewtime( c : in out d.Criteria; sewtime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shelter( c : in out d.Criteria; shelter : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sobuy( c : in out d.Criteria; sobuy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sstrtreg( c : in out d.Criteria; sstrtreg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stramt1( c : in out d.Criteria; stramt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stramt2( c : in out d.Criteria; stramt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_strcov( c : in out d.Criteria; strcov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_strmort( c : in out d.Criteria; strmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stroths( c : in out d.Criteria; stroths : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_strpd1( c : in out d.Criteria; strpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_strpd2( c : in out d.Criteria; strpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_suballow( c : in out d.Criteria; suballow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sublet( c : in out d.Criteria; sublet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sublety( c : in out d.Criteria; sublety : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_subrent( c : in out d.Criteria; subrent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tenure( c : in out d.Criteria; tenure : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totadult( c : in out d.Criteria; totadult : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totchild( c : in out d.Criteria; totchild : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totdepdk( c : in out d.Criteria; totdepdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tvlic( c : in out d.Criteria; tvlic : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_typeacc( c : in out d.Criteria; typeacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usevcl( c : in out d.Criteria; usevcl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watamt( c : in out d.Criteria; watamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watanul( c : in out d.Criteria; watanul : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watermet( c : in out d.Criteria; watermet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_waterpay( c : in out d.Criteria; waterpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watrb( c : in out d.Criteria; watrb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wattime( c : in out d.Criteria; wattime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_welfmilk( c : in out d.Criteria; welfmilk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb01( c : in out d.Criteria; whoctb01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb02( c : in out d.Criteria; whoctb02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb03( c : in out d.Criteria; whoctb03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb04( c : in out d.Criteria; whoctb04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb05( c : in out d.Criteria; whoctb05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb06( c : in out d.Criteria; whoctb06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb07( c : in out d.Criteria; whoctb07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb08( c : in out d.Criteria; whoctb08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb09( c : in out d.Criteria; whoctb09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb10( c : in out d.Criteria; whoctb10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb11( c : in out d.Criteria; whoctb11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb12( c : in out d.Criteria; whoctb12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb13( c : in out d.Criteria; whoctb13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctb14( c : in out d.Criteria; whoctb14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctbns( c : in out d.Criteria; whoctbns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoctbot( c : in out d.Criteria; whoctbot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp01( c : in out d.Criteria; whorsp01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp02( c : in out d.Criteria; whorsp02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp03( c : in out d.Criteria; whorsp03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp04( c : in out d.Criteria; whorsp04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp05( c : in out d.Criteria; whorsp05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp06( c : in out d.Criteria; whorsp06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp07( c : in out d.Criteria; whorsp07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp08( c : in out d.Criteria; whorsp08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp09( c : in out d.Criteria; whorsp09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp10( c : in out d.Criteria; whorsp10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp11( c : in out d.Criteria; whorsp11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp12( c : in out d.Criteria; whorsp12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp13( c : in out d.Criteria; whorsp13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whorsp14( c : in out d.Criteria; whorsp14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynoct( c : in out d.Criteria; whynoct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wmintro( c : in out d.Criteria; wmintro : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wsewamt( c : in out d.Criteria; wsewamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wsewanul( c : in out d.Criteria; wsewanul : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wsewtime( c : in out d.Criteria; wsewtime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_yearcode( c : in out d.Criteria; yearcode : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_yearlive( c : in out d.Criteria; yearlive : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_actacch( c : in out d.Criteria; actacch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adddahh( c : in out d.Criteria; adddahh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adulth( c : in out d.Criteria; adulth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_basacth( c : in out d.Criteria; basacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chddahh( c : in out d.Criteria; chddahh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curacth( c : in out d.Criteria; curacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cwatamtd( c : in out d.Criteria; cwatamtd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_depchldh( c : in out d.Criteria; depchldh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emp( c : in out d.Criteria; emp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emphrp( c : in out d.Criteria; emphrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endowpay( c : in out d.Criteria; endowpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_equivahc( c : in out d.Criteria; equivahc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_equivbhc( c : in out d.Criteria; equivbhc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsbndcth( c : in out d.Criteria; fsbndcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gbhscost( c : in out d.Criteria; gbhscost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gebacth( c : in out d.Criteria; gebacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_giltcth( c : in out d.Criteria; giltcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross2( c : in out d.Criteria; gross2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross3( c : in out d.Criteria; gross3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grossct( c : in out d.Criteria; grossct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbeninc( c : in out d.Criteria; hbeninc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbindhh( c : in out d.Criteria; hbindhh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hcband( c : in out d.Criteria; hcband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdhhinc( c : in out d.Criteria; hdhhinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdtax( c : in out d.Criteria; hdtax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hearns( c : in out d.Criteria; hearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhagegr2( c : in out d.Criteria; hhagegr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhagegrp( c : in out d.Criteria; hhagegrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhcomp( c : in out d.Criteria; hhcomp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhcomps( c : in out d.Criteria; hhcomps : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhdisben( c : in out d.Criteria; hhdisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhethgr2( c : in out d.Criteria; hhethgr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhethgrp( c : in out d.Criteria; hhethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhinc( c : in out d.Criteria; hhinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhincbnd( c : in out d.Criteria; hhincbnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhinv( c : in out d.Criteria; hhinv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhirben( c : in out d.Criteria; hhirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhkids( c : in out d.Criteria; hhkids : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhnirben( c : in out d.Criteria; hhnirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhothben( c : in out d.Criteria; hhothben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhrent( c : in out d.Criteria; hhrent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhrinc( c : in out d.Criteria; hhrinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhrpinc( c : in out d.Criteria; hhrpinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhsize( c : in out d.Criteria; hhsize : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhtvlic( c : in out d.Criteria; hhtvlic : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhtxcred( c : in out d.Criteria; hhtxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hothinc( c : in out d.Criteria; hothinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hpeninc( c : in out d.Criteria; hpeninc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrband( c : in out d.Criteria; hrband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hseinc( c : in out d.Criteria; hseinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_isacth( c : in out d.Criteria; isacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_london( c : in out d.Criteria; london : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortcost( c : in out d.Criteria; mortcost : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortint( c : in out d.Criteria; mortint : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortpay( c : in out d.Criteria; mortpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nddctb( c : in out d.Criteria; nddctb : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nddishc( c : in out d.Criteria; nddishc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nihscost( c : in out d.Criteria; nihscost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nsbocth( c : in out d.Criteria; nsbocth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otbscth( c : in out d.Criteria; otbscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pacctype( c : in out d.Criteria; pacctype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penage( c : in out d.Criteria; penage : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penhrp( c : in out d.Criteria; penhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pepscth( c : in out d.Criteria; pepscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_poaccth( c : in out d.Criteria; poaccth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prbocth( c : in out d.Criteria; prbocth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ptentyp2( c : in out d.Criteria; ptentyp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sayecth( c : in out d.Criteria; sayecth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sclbcth( c : in out d.Criteria; sclbcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_servpay( c : in out d.Criteria; servpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sick( c : in out d.Criteria; sick : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sickhrp( c : in out d.Criteria; sickhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sscth( c : in out d.Criteria; sscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_struins( c : in out d.Criteria; struins : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stshcth( c : in out d.Criteria; stshcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tentyp2( c : in out d.Criteria; tentyp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tesscth( c : in out d.Criteria; tesscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tuhhrent( c : in out d.Criteria; tuhhrent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tuwatsew( c : in out d.Criteria; tuwatsew : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_untrcth( c : in out d.Criteria; untrcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watsewrt( c : in out d.Criteria; watsewrt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acornew( c : in out d.Criteria; acornew : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_crunach( c : in out d.Criteria; crunach : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_enomorth( c : in out d.Criteria; enomorth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvadulth( c : in out d.Criteria; dvadulth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvtotad( c : in out d.Criteria; dvtotad : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_urindew( c : in out d.Criteria; urindew : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_urinds( c : in out d.Criteria; urinds : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vehnumb( c : in out d.Criteria; vehnumb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbindhh2( c : in out d.Criteria; hbindhh2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pocardh( c : in out d.Criteria; pocardh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_entry5( c : in out d.Criteria; entry5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_entry6( c : in out d.Criteria; entry6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_imd_e( c : in out d.Criteria; imd_e : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_imd_s( c : in out d.Criteria; imd_s : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_imd_w( c : in out d.Criteria; imd_w : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numtv1( c : in out d.Criteria; numtv1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numtv2( c : in out d.Criteria; numtv2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oac( c : in out d.Criteria; oac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bedroom6( c : in out d.Criteria; bedroom6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rooms10( c : in out d.Criteria; rooms10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_brma( c : in out d.Criteria; brma : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_migrq1( c : in out d.Criteria; migrq1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_migrq2( c : in out d.Criteria; migrq2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhagegr3( c : in out d.Criteria; hhagegr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhagegr4( c : in out d.Criteria; hhagegr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_capval( c : in out d.Criteria; capval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nidpnd( c : in out d.Criteria; nidpnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nochcr1( c : in out d.Criteria; nochcr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nochcr2( c : in out d.Criteria; nochcr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nochcr3( c : in out d.Criteria; nochcr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nochcr4( c : in out d.Criteria; nochcr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nochcr5( c : in out d.Criteria; nochcr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rt2rebam( c : in out d.Criteria; rt2rebam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rt2rebpd( c : in out d.Criteria; rt2rebpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtdpa( c : in out d.Criteria; rtdpa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtdpaamt( c : in out d.Criteria; rtdpaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtdpapd( c : in out d.Criteria; rtdpapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtlpa( c : in out d.Criteria; rtlpa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtlpaamt( c : in out d.Criteria; rtlpaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtlpapd( c : in out d.Criteria; rtlpapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtothamt( c : in out d.Criteria; rtothamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtother( c : in out d.Criteria; rtother : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtothpd( c : in out d.Criteria; rtothpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtrtr( c : in out d.Criteria; rtrtr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtrtramt( c : in out d.Criteria; rtrtramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtrtrpd( c : in out d.Criteria; rtrtrpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rttimepd( c : in out d.Criteria; rttimepd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_yrlvchk( c : in out d.Criteria; yrlvchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross3_x( c : in out d.Criteria; gross3_x : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlthst( c : in out d.Criteria; hlthst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medpay( c : in out d.Criteria; medpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho01( c : in out d.Criteria; medwho01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho02( c : in out d.Criteria; medwho02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho03( c : in out d.Criteria; medwho03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho04( c : in out d.Criteria; medwho04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho05( c : in out d.Criteria; medwho05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho06( c : in out d.Criteria; medwho06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho07( c : in out d.Criteria; medwho07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho08( c : in out d.Criteria; medwho08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho09( c : in out d.Criteria; medwho09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho10( c : in out d.Criteria; medwho10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho11( c : in out d.Criteria; medwho11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho12( c : in out d.Criteria; medwho12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho13( c : in out d.Criteria; medwho13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medwho14( c : in out d.Criteria; medwho14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nmrmshar( c : in out d.Criteria; nmrmshar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_roomshr( c : in out d.Criteria; roomshr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_imd_ni( c : in out d.Criteria; imd_ni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_multi( c : in out d.Criteria; multi : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nopay( c : in out d.Criteria; nopay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_orgid( c : in out d.Criteria; orgid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtene( c : in out d.Criteria; rtene : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rteneamt( c : in out d.Criteria; rteneamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rtgen( c : in out d.Criteria; rtgen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_schbrk( c : in out d.Criteria; schbrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_urb( c : in out d.Criteria; urb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_urbrur( c : in out d.Criteria; urbrur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhethgr3( c : in out d.Criteria; hhethgr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_niratlia( c : in out d.Criteria; niratlia : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bankse( c : in out d.Criteria; bankse : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bathshow( c : in out d.Criteria; bathshow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_burden( c : in out d.Criteria; burden : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_comco( c : in out d.Criteria; comco : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_comp1sc( c : in out d.Criteria; comp1sc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_compsc( c : in out d.Criteria; compsc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_comwa( c : in out d.Criteria; comwa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dwellno( c : in out d.Criteria; dwellno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_elecin( c : in out d.Criteria; elecin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_elecinw( c : in out d.Criteria; elecinw : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eulowest( c : in out d.Criteria; eulowest : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_flshtoil( c : in out d.Criteria; flshtoil : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grocse( c : in out d.Criteria; grocse : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gvtregno( c : in out d.Criteria; gvtregno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heat( c : in out d.Criteria; heat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatcen( c : in out d.Criteria; heatcen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatfire( c : in out d.Criteria; heatfire : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kitchen( c : in out d.Criteria; kitchen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_knsizeft( c : in out d.Criteria; knsizeft : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_knsizem( c : in out d.Criteria; knsizem : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_laua( c : in out d.Criteria; laua : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_movef( c : in out d.Criteria; movef : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_movenxt( c : in out d.Criteria; movenxt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_movereas( c : in out d.Criteria; movereas : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ovsat( c : in out d.Criteria; ovsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_plum1bin( c : in out d.Criteria; plum1bin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_plumin( c : in out d.Criteria; plumin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pluminw( c : in out d.Criteria; pluminw : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_postse( c : in out d.Criteria; postse : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_primh( c : in out d.Criteria; primh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pubtr( c : in out d.Criteria; pubtr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_samesc( c : in out d.Criteria; samesc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_schfrt( c : in out d.Criteria; schfrt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_selper( c : in out d.Criteria; selper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_short( c : in out d.Criteria; short : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sizeft( c : in out d.Criteria; sizeft : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sizem( c : in out d.Criteria; sizem : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tvwhy( c : in out d.Criteria; tvwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_yearwhc( c : in out d.Criteria; yearwhc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dischha1( c : in out d.Criteria; dischha1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dischhc1( c : in out d.Criteria; dischhc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_diswhha1( c : in out d.Criteria; diswhha1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_diswhhc1( c : in out d.Criteria; diswhhc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross4( c : in out d.Criteria; gross4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lldcare( c : in out d.Criteria; lldcare : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_urindni( c : in out d.Criteria; urindni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhbeninc( c : in out d.Criteria; nhbeninc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhhnirbn( c : in out d.Criteria; nhhnirbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhhothbn( c : in out d.Criteria; nhhothbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seramt1( c : in out d.Criteria; seramt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seramt2( c : in out d.Criteria; seramt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seramt3( c : in out d.Criteria; seramt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seramt4( c : in out d.Criteria; seramt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serpay1( c : in out d.Criteria; serpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serpay2( c : in out d.Criteria; serpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serpay3( c : in out d.Criteria; serpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serpay4( c : in out d.Criteria; serpay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serper1( c : in out d.Criteria; serper1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serper2( c : in out d.Criteria; serper2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serper3( c : in out d.Criteria; serper3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serper4( c : in out d.Criteria; serper4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_utility( c : in out d.Criteria; utility : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hheth( c : in out d.Criteria; hheth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seramt5( c : in out d.Criteria; seramt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sercomb( c : in out d.Criteria; sercomb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serpay5( c : in out d.Criteria; serpay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_serper5( c : in out d.Criteria; serper5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_urbni( c : in out d.Criteria; urbni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acorn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bedroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunits_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billrate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_busroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_centfuel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_centheat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_charge9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgamt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrgpd9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_contv1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_contv2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_covoths_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_csewamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_csewamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ct25d50d_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctannual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctbwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctcondoc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctdisc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctinstal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctlvband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctlvchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctreb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctrebamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctrebpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cttime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cwatamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cwatamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_datyrago_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_entry1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_entry2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_entry3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_entry4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_estrtann_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_floor_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givehelp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gor_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gvtregn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhldr97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhstat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrpnum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intdate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mainacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mnthcode_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_modcon14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_monlive_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_needhelp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nicoun_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninrv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nirate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_norate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_onbsroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_orgsewam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_orgwatam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_payrate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_premium_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ptbsroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_roomshar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtannual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtcheck_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtcondoc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtdeduc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtinstal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtreb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtrebamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtrebpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rttime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sampqtr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_schmeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_schmilk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sewamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sewanul_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sewerpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sewsep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sewtime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shelter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sobuy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sstrtreg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stramt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stramt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_strcov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_strmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stroths_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_strpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_strpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_suballow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sublet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sublety_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_subrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tenure_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totadult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totchild_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totdepdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_typeacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usevcl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watanul_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watermet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_waterpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watrb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wattime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_welfmilk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctb14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctbns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoctbot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whorsp14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynoct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wmintro_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wsewamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wsewanul_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wsewtime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_yearcode_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_yearlive_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_actacch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adddahh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adulth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_basacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chddahh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cwatamtd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_depchldh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emphrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endowpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_equivahc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_equivbhc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsbndcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gbhscost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gebacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_giltcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grossct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbindhh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hcband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdhhinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhagegr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhagegrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhcomp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhcomps_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhdisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhethgr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhincbnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhinv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhkids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhnirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhothben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhrpinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhsize_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhtvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhtxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hothinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hpeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hseinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_isacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_london_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortcost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nddctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nddishc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nihscost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nsbocth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otbscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pacctype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pepscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_poaccth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prbocth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ptentyp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sayecth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sclbcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_servpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sick_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sickhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_struins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stshcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tentyp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tesscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tuhhrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tuwatsew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_untrcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watsewrt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acornew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_crunach_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_enomorth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvadulth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvtotad_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_urindew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_urinds_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vehnumb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbindhh2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pocardh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_entry5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_entry6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_imd_e_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_imd_s_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_imd_w_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numtv1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numtv2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bedroom6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rooms10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_brma_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_migrq1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_migrq2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhagegr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhagegr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_capval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nidpnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nochcr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nochcr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nochcr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nochcr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nochcr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rt2rebam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rt2rebpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtdpa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtdpaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtdpapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtlpa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtlpaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtlpapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtothamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtother_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtothpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtrtr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtrtramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtrtrpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rttimepd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_yrlvchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross3_x_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlthst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medwho14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nmrmshar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_roomshr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_imd_ni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_multi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nopay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_orgid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtene_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rteneamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rtgen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_schbrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_urb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_urbrur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhethgr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_niratlia_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bankse_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bathshow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_burden_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_comco_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_comp1sc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_compsc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_comwa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dwellno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_elecin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_elecinw_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eulowest_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_flshtoil_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grocse_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gvtregno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatcen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatfire_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kitchen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_knsizeft_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_knsizem_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_laua_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_movef_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_movenxt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_movereas_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ovsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_plum1bin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_plumin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pluminw_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_postse_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_primh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pubtr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_samesc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_schfrt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_selper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_short_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sizeft_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sizem_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tvwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_yearwhc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dischha1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dischhc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_diswhha1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_diswhhc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lldcare_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_urindni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhbeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhhnirbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhhothbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seramt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seramt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seramt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seramt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serper1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serper2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serper3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serper4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_utility_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hheth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seramt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sercomb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serpay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_serper5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_urbni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Househol;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 432, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : acorn                    : Parameter_Integer  : Integer              :        0 
   --    6 : bedroom                  : Parameter_Integer  : Integer              :        0 
   --    7 : benunits                 : Parameter_Integer  : Integer              :        0 
   --    8 : billrate                 : Parameter_Integer  : Integer              :        0 
   --    9 : busroom                  : Parameter_Integer  : Integer              :        0 
   --   10 : centfuel                 : Parameter_Integer  : Integer              :        0 
   --   11 : centheat                 : Parameter_Integer  : Integer              :        0 
   --   12 : charge1                  : Parameter_Integer  : Integer              :        0 
   --   13 : charge2                  : Parameter_Integer  : Integer              :        0 
   --   14 : charge3                  : Parameter_Integer  : Integer              :        0 
   --   15 : charge4                  : Parameter_Integer  : Integer              :        0 
   --   16 : charge5                  : Parameter_Integer  : Integer              :        0 
   --   17 : charge6                  : Parameter_Integer  : Integer              :        0 
   --   18 : charge7                  : Parameter_Integer  : Integer              :        0 
   --   19 : charge8                  : Parameter_Integer  : Integer              :        0 
   --   20 : charge9                  : Parameter_Integer  : Integer              :        0 
   --   21 : chins                    : Parameter_Integer  : Integer              :        0 
   --   22 : chrgamt1                 : Parameter_Float    : Amount               :      0.0 
   --   23 : chrgamt2                 : Parameter_Float    : Amount               :      0.0 
   --   24 : chrgamt3                 : Parameter_Float    : Amount               :      0.0 
   --   25 : chrgamt4                 : Parameter_Float    : Amount               :      0.0 
   --   26 : chrgamt5                 : Parameter_Float    : Amount               :      0.0 
   --   27 : chrgamt6                 : Parameter_Float    : Amount               :      0.0 
   --   28 : chrgamt7                 : Parameter_Float    : Amount               :      0.0 
   --   29 : chrgamt8                 : Parameter_Float    : Amount               :      0.0 
   --   30 : chrgamt9                 : Parameter_Float    : Amount               :      0.0 
   --   31 : chrgpd1                  : Parameter_Integer  : Integer              :        0 
   --   32 : chrgpd2                  : Parameter_Integer  : Integer              :        0 
   --   33 : chrgpd3                  : Parameter_Integer  : Integer              :        0 
   --   34 : chrgpd4                  : Parameter_Integer  : Integer              :        0 
   --   35 : chrgpd5                  : Parameter_Integer  : Integer              :        0 
   --   36 : chrgpd6                  : Parameter_Integer  : Integer              :        0 
   --   37 : chrgpd7                  : Parameter_Integer  : Integer              :        0 
   --   38 : chrgpd8                  : Parameter_Integer  : Integer              :        0 
   --   39 : chrgpd9                  : Parameter_Integer  : Integer              :        0 
   --   40 : contv1                   : Parameter_Integer  : Integer              :        0 
   --   41 : contv2                   : Parameter_Integer  : Integer              :        0 
   --   42 : covoths                  : Parameter_Integer  : Integer              :        0 
   --   43 : csewamt                  : Parameter_Float    : Amount               :      0.0 
   --   44 : csewamt1                 : Parameter_Float    : Amount               :      0.0 
   --   45 : ct25d50d                 : Parameter_Integer  : Integer              :        0 
   --   46 : ctamt                    : Parameter_Integer  : Integer              :        0 
   --   47 : ctannual                 : Parameter_Float    : Amount               :      0.0 
   --   48 : ctband                   : Parameter_Integer  : Integer              :        0 
   --   49 : ctbwait                  : Parameter_Integer  : Integer              :        0 
   --   50 : ctcondoc                 : Parameter_Integer  : Integer              :        0 
   --   51 : ctdisc                   : Parameter_Integer  : Integer              :        0 
   --   52 : ctinstal                 : Parameter_Integer  : Integer              :        0 
   --   53 : ctlvband                 : Parameter_Integer  : Integer              :        0 
   --   54 : ctlvchk                  : Parameter_Integer  : Integer              :        0 
   --   55 : ctreb                    : Parameter_Integer  : Integer              :        0 
   --   56 : ctrebamt                 : Parameter_Integer  : Integer              :        0 
   --   57 : ctrebpd                  : Parameter_Integer  : Integer              :        0 
   --   58 : cttime                   : Parameter_Integer  : Integer              :        0 
   --   59 : cwatamt                  : Parameter_Integer  : Integer              :        0 
   --   60 : cwatamt1                 : Parameter_Integer  : Integer              :        0 
   --   61 : datyrago                 : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   62 : entry1                   : Parameter_Integer  : Integer              :        0 
   --   63 : entry2                   : Parameter_Integer  : Integer              :        0 
   --   64 : entry3                   : Parameter_Integer  : Integer              :        0 
   --   65 : entry4                   : Parameter_Integer  : Integer              :        0 
   --   66 : estrtann                 : Parameter_Float    : Amount               :      0.0 
   --   67 : floor                    : Parameter_Integer  : Integer              :        0 
   --   68 : givehelp                 : Parameter_Integer  : Integer              :        0 
   --   69 : gor                      : Parameter_Integer  : Integer              :        0 
   --   70 : gvtregn                  : Parameter_Integer  : Integer              :        0 
   --   71 : hhldr01                  : Parameter_Integer  : Integer              :        0 
   --   72 : hhldr02                  : Parameter_Integer  : Integer              :        0 
   --   73 : hhldr03                  : Parameter_Integer  : Integer              :        0 
   --   74 : hhldr04                  : Parameter_Integer  : Integer              :        0 
   --   75 : hhldr05                  : Parameter_Integer  : Integer              :        0 
   --   76 : hhldr06                  : Parameter_Integer  : Integer              :        0 
   --   77 : hhldr07                  : Parameter_Integer  : Integer              :        0 
   --   78 : hhldr08                  : Parameter_Integer  : Integer              :        0 
   --   79 : hhldr09                  : Parameter_Integer  : Integer              :        0 
   --   80 : hhldr10                  : Parameter_Integer  : Integer              :        0 
   --   81 : hhldr11                  : Parameter_Integer  : Integer              :        0 
   --   82 : hhldr12                  : Parameter_Integer  : Integer              :        0 
   --   83 : hhldr13                  : Parameter_Integer  : Integer              :        0 
   --   84 : hhldr14                  : Parameter_Integer  : Integer              :        0 
   --   85 : hhldr97                  : Parameter_Integer  : Integer              :        0 
   --   86 : hhstat                   : Parameter_Integer  : Integer              :        0 
   --   87 : hrpnum                   : Parameter_Integer  : Integer              :        0 
   --   88 : intdate                  : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   89 : lac                      : Parameter_Integer  : Integer              :        0 
   --   90 : mainacc                  : Parameter_Integer  : Integer              :        0 
   --   91 : mnthcode                 : Parameter_Integer  : Integer              :        0 
   --   92 : modcon01                 : Parameter_Integer  : Integer              :        0 
   --   93 : modcon02                 : Parameter_Integer  : Integer              :        0 
   --   94 : modcon03                 : Parameter_Integer  : Integer              :        0 
   --   95 : modcon04                 : Parameter_Integer  : Integer              :        0 
   --   96 : modcon05                 : Parameter_Integer  : Integer              :        0 
   --   97 : modcon06                 : Parameter_Integer  : Integer              :        0 
   --   98 : modcon07                 : Parameter_Integer  : Integer              :        0 
   --   99 : modcon08                 : Parameter_Integer  : Integer              :        0 
   --  100 : modcon09                 : Parameter_Integer  : Integer              :        0 
   --  101 : modcon10                 : Parameter_Integer  : Integer              :        0 
   --  102 : modcon11                 : Parameter_Integer  : Integer              :        0 
   --  103 : modcon12                 : Parameter_Integer  : Integer              :        0 
   --  104 : modcon13                 : Parameter_Integer  : Integer              :        0 
   --  105 : modcon14                 : Parameter_Integer  : Integer              :        0 
   --  106 : monlive                  : Parameter_Integer  : Integer              :        0 
   --  107 : needhelp                 : Parameter_Integer  : Integer              :        0 
   --  108 : nicoun                   : Parameter_Integer  : Integer              :        0 
   --  109 : ninrv                    : Parameter_Float    : Amount               :      0.0 
   --  110 : nirate                   : Parameter_Integer  : Integer              :        0 
   --  111 : norate                   : Parameter_Integer  : Integer              :        0 
   --  112 : onbsroom                 : Parameter_Integer  : Integer              :        0 
   --  113 : orgsewam                 : Parameter_Float    : Amount               :      0.0 
   --  114 : orgwatam                 : Parameter_Float    : Amount               :      0.0 
   --  115 : payrate                  : Parameter_Integer  : Integer              :        0 
   --  116 : premium                  : Parameter_Integer  : Integer              :        0 
   --  117 : ptbsroom                 : Parameter_Integer  : Integer              :        0 
   --  118 : rooms                    : Parameter_Integer  : Integer              :        0 
   --  119 : roomshar                 : Parameter_Integer  : Integer              :        0 
   --  120 : rtannual                 : Parameter_Float    : Amount               :      0.0 
   --  121 : rtcheck                  : Parameter_Float    : Amount               :      0.0 
   --  122 : rtcondoc                 : Parameter_Integer  : Integer              :        0 
   --  123 : rtdeduc                  : Parameter_Integer  : Integer              :        0 
   --  124 : rtinstal                 : Parameter_Integer  : Integer              :        0 
   --  125 : rtreb                    : Parameter_Integer  : Integer              :        0 
   --  126 : rtrebamt                 : Parameter_Float    : Amount               :      0.0 
   --  127 : rtrebpd                  : Parameter_Integer  : Integer              :        0 
   --  128 : rttime                   : Parameter_Integer  : Integer              :        0 
   --  129 : sampqtr                  : Parameter_Integer  : Integer              :        0 
   --  130 : schmeal                  : Parameter_Integer  : Integer              :        0 
   --  131 : schmilk                  : Parameter_Integer  : Integer              :        0 
   --  132 : sewamt                   : Parameter_Float    : Amount               :      0.0 
   --  133 : sewanul                  : Parameter_Float    : Amount               :      0.0 
   --  134 : sewerpay                 : Parameter_Integer  : Integer              :        0 
   --  135 : sewsep                   : Parameter_Integer  : Integer              :        0 
   --  136 : sewtime                  : Parameter_Integer  : Integer              :        0 
   --  137 : shelter                  : Parameter_Integer  : Integer              :        0 
   --  138 : sobuy                    : Parameter_Integer  : Integer              :        0 
   --  139 : sstrtreg                 : Parameter_Integer  : Integer              :        0 
   --  140 : stramt1                  : Parameter_Float    : Amount               :      0.0 
   --  141 : stramt2                  : Parameter_Float    : Amount               :      0.0 
   --  142 : strcov                   : Parameter_Integer  : Integer              :        0 
   --  143 : strmort                  : Parameter_Integer  : Integer              :        0 
   --  144 : stroths                  : Parameter_Integer  : Integer              :        0 
   --  145 : strpd1                   : Parameter_Integer  : Integer              :        0 
   --  146 : strpd2                   : Parameter_Integer  : Integer              :        0 
   --  147 : suballow                 : Parameter_Integer  : Integer              :        0 
   --  148 : sublet                   : Parameter_Integer  : Integer              :        0 
   --  149 : sublety                  : Parameter_Integer  : Integer              :        0 
   --  150 : subrent                  : Parameter_Float    : Amount               :      0.0 
   --  151 : tenure                   : Parameter_Integer  : Integer              :        0 
   --  152 : totadult                 : Parameter_Integer  : Integer              :        0 
   --  153 : totchild                 : Parameter_Integer  : Integer              :        0 
   --  154 : totdepdk                 : Parameter_Integer  : Integer              :        0 
   --  155 : tvlic                    : Parameter_Integer  : Integer              :        0 
   --  156 : typeacc                  : Parameter_Integer  : Integer              :        0 
   --  157 : usevcl                   : Parameter_Integer  : Integer              :        0 
   --  158 : watamt                   : Parameter_Float    : Amount               :      0.0 
   --  159 : watanul                  : Parameter_Float    : Amount               :      0.0 
   --  160 : watermet                 : Parameter_Integer  : Integer              :        0 
   --  161 : waterpay                 : Parameter_Integer  : Integer              :        0 
   --  162 : watrb                    : Parameter_Integer  : Integer              :        0 
   --  163 : wattime                  : Parameter_Integer  : Integer              :        0 
   --  164 : welfmilk                 : Parameter_Integer  : Integer              :        0 
   --  165 : whoctb01                 : Parameter_Integer  : Integer              :        0 
   --  166 : whoctb02                 : Parameter_Integer  : Integer              :        0 
   --  167 : whoctb03                 : Parameter_Integer  : Integer              :        0 
   --  168 : whoctb04                 : Parameter_Integer  : Integer              :        0 
   --  169 : whoctb05                 : Parameter_Integer  : Integer              :        0 
   --  170 : whoctb06                 : Parameter_Integer  : Integer              :        0 
   --  171 : whoctb07                 : Parameter_Integer  : Integer              :        0 
   --  172 : whoctb08                 : Parameter_Integer  : Integer              :        0 
   --  173 : whoctb09                 : Parameter_Integer  : Integer              :        0 
   --  174 : whoctb10                 : Parameter_Integer  : Integer              :        0 
   --  175 : whoctb11                 : Parameter_Integer  : Integer              :        0 
   --  176 : whoctb12                 : Parameter_Integer  : Integer              :        0 
   --  177 : whoctb13                 : Parameter_Integer  : Integer              :        0 
   --  178 : whoctb14                 : Parameter_Integer  : Integer              :        0 
   --  179 : whoctbns                 : Parameter_Integer  : Integer              :        0 
   --  180 : whoctbot                 : Parameter_Integer  : Integer              :        0 
   --  181 : whorsp01                 : Parameter_Integer  : Integer              :        0 
   --  182 : whorsp02                 : Parameter_Integer  : Integer              :        0 
   --  183 : whorsp03                 : Parameter_Integer  : Integer              :        0 
   --  184 : whorsp04                 : Parameter_Integer  : Integer              :        0 
   --  185 : whorsp05                 : Parameter_Integer  : Integer              :        0 
   --  186 : whorsp06                 : Parameter_Integer  : Integer              :        0 
   --  187 : whorsp07                 : Parameter_Integer  : Integer              :        0 
   --  188 : whorsp08                 : Parameter_Integer  : Integer              :        0 
   --  189 : whorsp09                 : Parameter_Integer  : Integer              :        0 
   --  190 : whorsp10                 : Parameter_Integer  : Integer              :        0 
   --  191 : whorsp11                 : Parameter_Integer  : Integer              :        0 
   --  192 : whorsp12                 : Parameter_Integer  : Integer              :        0 
   --  193 : whorsp13                 : Parameter_Integer  : Integer              :        0 
   --  194 : whorsp14                 : Parameter_Integer  : Integer              :        0 
   --  195 : whynoct                  : Parameter_Integer  : Integer              :        0 
   --  196 : wmintro                  : Parameter_Integer  : Integer              :        0 
   --  197 : wsewamt                  : Parameter_Float    : Amount               :      0.0 
   --  198 : wsewanul                 : Parameter_Float    : Amount               :      0.0 
   --  199 : wsewtime                 : Parameter_Integer  : Integer              :        0 
   --  200 : yearcode                 : Parameter_Integer  : Integer              :        0 
   --  201 : yearlive                 : Parameter_Integer  : Integer              :        0 
   --  202 : month                    : Parameter_Integer  : Integer              :        0 
   --  203 : actacch                  : Parameter_Integer  : Integer              :        0 
   --  204 : adddahh                  : Parameter_Integer  : Integer              :        0 
   --  205 : adulth                   : Parameter_Integer  : Integer              :        0 
   --  206 : basacth                  : Parameter_Integer  : Integer              :        0 
   --  207 : chddahh                  : Parameter_Integer  : Integer              :        0 
   --  208 : curacth                  : Parameter_Integer  : Integer              :        0 
   --  209 : cwatamtd                 : Parameter_Integer  : Integer              :        0 
   --  210 : depchldh                 : Parameter_Integer  : Integer              :        0 
   --  211 : emp                      : Parameter_Integer  : Integer              :        0 
   --  212 : emphrp                   : Parameter_Integer  : Integer              :        0 
   --  213 : endowpay                 : Parameter_Float    : Amount               :      0.0 
   --  214 : equivahc                 : Parameter_Float    : Amount               :      0.0 
   --  215 : equivbhc                 : Parameter_Float    : Amount               :      0.0 
   --  216 : fsbndcth                 : Parameter_Integer  : Integer              :        0 
   --  217 : gbhscost                 : Parameter_Integer  : Integer              :        0 
   --  218 : gebacth                  : Parameter_Integer  : Integer              :        0 
   --  219 : giltcth                  : Parameter_Integer  : Integer              :        0 
   --  220 : gross2                   : Parameter_Integer  : Integer              :        0 
   --  221 : gross3                   : Parameter_Integer  : Integer              :        0 
   --  222 : grossct                  : Parameter_Integer  : Integer              :        0 
   --  223 : hbeninc                  : Parameter_Integer  : Integer              :        0 
   --  224 : hbindhh                  : Parameter_Integer  : Integer              :        0 
   --  225 : hcband                   : Parameter_Integer  : Integer              :        0 
   --  226 : hdhhinc                  : Parameter_Integer  : Integer              :        0 
   --  227 : hdtax                    : Parameter_Integer  : Integer              :        0 
   --  228 : hearns                   : Parameter_Float    : Amount               :      0.0 
   --  229 : hhagegr2                 : Parameter_Integer  : Integer              :        0 
   --  230 : hhagegrp                 : Parameter_Integer  : Integer              :        0 
   --  231 : hhcomp                   : Parameter_Integer  : Integer              :        0 
   --  232 : hhcomps                  : Parameter_Integer  : Integer              :        0 
   --  233 : hhdisben                 : Parameter_Integer  : Integer              :        0 
   --  234 : hhethgr2                 : Parameter_Integer  : Integer              :        0 
   --  235 : hhethgrp                 : Parameter_Integer  : Integer              :        0 
   --  236 : hhinc                    : Parameter_Integer  : Integer              :        0 
   --  237 : hhincbnd                 : Parameter_Integer  : Integer              :        0 
   --  238 : hhinv                    : Parameter_Float    : Amount               :      0.0 
   --  239 : hhirben                  : Parameter_Integer  : Integer              :        0 
   --  240 : hhkids                   : Parameter_Integer  : Integer              :        0 
   --  241 : hhnirben                 : Parameter_Integer  : Integer              :        0 
   --  242 : hhothben                 : Parameter_Integer  : Integer              :        0 
   --  243 : hhrent                   : Parameter_Integer  : Integer              :        0 
   --  244 : hhrinc                   : Parameter_Float    : Amount               :      0.0 
   --  245 : hhrpinc                  : Parameter_Float    : Amount               :      0.0 
   --  246 : hhsize                   : Parameter_Integer  : Integer              :        0 
   --  247 : hhtvlic                  : Parameter_Float    : Amount               :      0.0 
   --  248 : hhtxcred                 : Parameter_Float    : Amount               :      0.0 
   --  249 : hothinc                  : Parameter_Float    : Amount               :      0.0 
   --  250 : hpeninc                  : Parameter_Float    : Amount               :      0.0 
   --  251 : hrband                   : Parameter_Integer  : Integer              :        0 
   --  252 : hseinc                   : Parameter_Float    : Amount               :      0.0 
   --  253 : isacth                   : Parameter_Integer  : Integer              :        0 
   --  254 : london                   : Parameter_Integer  : Integer              :        0 
   --  255 : mortcost                 : Parameter_Float    : Amount               :      0.0 
   --  256 : mortint                  : Parameter_Float    : Amount               :      0.0 
   --  257 : mortpay                  : Parameter_Float    : Amount               :      0.0 
   --  258 : nddctb                   : Parameter_Float    : Amount               :      0.0 
   --  259 : nddishc                  : Parameter_Float    : Amount               :      0.0 
   --  260 : nihscost                 : Parameter_Integer  : Integer              :        0 
   --  261 : nsbocth                  : Parameter_Integer  : Integer              :        0 
   --  262 : otbscth                  : Parameter_Integer  : Integer              :        0 
   --  263 : pacctype                 : Parameter_Integer  : Integer              :        0 
   --  264 : penage                   : Parameter_Integer  : Integer              :        0 
   --  265 : penhrp                   : Parameter_Integer  : Integer              :        0 
   --  266 : pepscth                  : Parameter_Integer  : Integer              :        0 
   --  267 : poaccth                  : Parameter_Integer  : Integer              :        0 
   --  268 : prbocth                  : Parameter_Integer  : Integer              :        0 
   --  269 : ptentyp2                 : Parameter_Integer  : Integer              :        0 
   --  270 : sayecth                  : Parameter_Integer  : Integer              :        0 
   --  271 : sclbcth                  : Parameter_Integer  : Integer              :        0 
   --  272 : servpay                  : Parameter_Float    : Amount               :      0.0 
   --  273 : sick                     : Parameter_Integer  : Integer              :        0 
   --  274 : sickhrp                  : Parameter_Integer  : Integer              :        0 
   --  275 : sscth                    : Parameter_Integer  : Integer              :        0 
   --  276 : struins                  : Parameter_Float    : Amount               :      0.0 
   --  277 : stshcth                  : Parameter_Integer  : Integer              :        0 
   --  278 : tentyp2                  : Parameter_Integer  : Integer              :        0 
   --  279 : tesscth                  : Parameter_Integer  : Integer              :        0 
   --  280 : tuhhrent                 : Parameter_Float    : Amount               :      0.0 
   --  281 : tuwatsew                 : Parameter_Float    : Amount               :      0.0 
   --  282 : untrcth                  : Parameter_Integer  : Integer              :        0 
   --  283 : watsewrt                 : Parameter_Float    : Amount               :      0.0 
   --  284 : acornew                  : Parameter_Integer  : Integer              :        0 
   --  285 : crunach                  : Parameter_Integer  : Integer              :        0 
   --  286 : enomorth                 : Parameter_Integer  : Integer              :        0 
   --  287 : dvadulth                 : Parameter_Integer  : Integer              :        0 
   --  288 : dvtotad                  : Parameter_Integer  : Integer              :        0 
   --  289 : urindew                  : Parameter_Integer  : Integer              :        0 
   --  290 : urinds                   : Parameter_Integer  : Integer              :        0 
   --  291 : vehnumb                  : Parameter_Integer  : Integer              :        0 
   --  292 : country                  : Parameter_Integer  : Integer              :        0 
   --  293 : hbindhh2                 : Parameter_Integer  : Integer              :        0 
   --  294 : pocardh                  : Parameter_Integer  : Integer              :        0 
   --  295 : entry5                   : Parameter_Integer  : Integer              :        0 
   --  296 : entry6                   : Parameter_Integer  : Integer              :        0 
   --  297 : imd_e                    : Parameter_Integer  : Integer              :        0 
   --  298 : imd_s                    : Parameter_Integer  : Integer              :        0 
   --  299 : imd_w                    : Parameter_Integer  : Integer              :        0 
   --  300 : numtv1                   : Parameter_Integer  : Integer              :        0 
   --  301 : numtv2                   : Parameter_Integer  : Integer              :        0 
   --  302 : oac                      : Parameter_Integer  : Integer              :        0 
   --  303 : bedroom6                 : Parameter_Integer  : Integer              :        0 
   --  304 : rooms10                  : Parameter_Integer  : Integer              :        0 
   --  305 : brma                     : Parameter_Integer  : Integer              :        0 
   --  306 : issue                    : Parameter_Integer  : Integer              :        0 
   --  307 : migrq1                   : Parameter_Integer  : Integer              :        0 
   --  308 : migrq2                   : Parameter_Integer  : Integer              :        0 
   --  309 : hhagegr3                 : Parameter_Integer  : Integer              :        0 
   --  310 : hhagegr4                 : Parameter_Integer  : Integer              :        0 
   --  311 : capval                   : Parameter_Integer  : Integer              :        0 
   --  312 : nidpnd                   : Parameter_Integer  : Integer              :        0 
   --  313 : nochcr1                  : Parameter_Integer  : Integer              :        0 
   --  314 : nochcr2                  : Parameter_Integer  : Integer              :        0 
   --  315 : nochcr3                  : Parameter_Integer  : Integer              :        0 
   --  316 : nochcr4                  : Parameter_Integer  : Integer              :        0 
   --  317 : nochcr5                  : Parameter_Integer  : Integer              :        0 
   --  318 : rt2rebam                 : Parameter_Float    : Amount               :      0.0 
   --  319 : rt2rebpd                 : Parameter_Integer  : Integer              :        0 
   --  320 : rtdpa                    : Parameter_Integer  : Integer              :        0 
   --  321 : rtdpaamt                 : Parameter_Float    : Amount               :      0.0 
   --  322 : rtdpapd                  : Parameter_Integer  : Integer              :        0 
   --  323 : rtlpa                    : Parameter_Integer  : Integer              :        0 
   --  324 : rtlpaamt                 : Parameter_Float    : Amount               :      0.0 
   --  325 : rtlpapd                  : Parameter_Integer  : Integer              :        0 
   --  326 : rtothamt                 : Parameter_Float    : Amount               :      0.0 
   --  327 : rtother                  : Parameter_Integer  : Integer              :        0 
   --  328 : rtothpd                  : Parameter_Integer  : Integer              :        0 
   --  329 : rtrtr                    : Parameter_Integer  : Integer              :        0 
   --  330 : rtrtramt                 : Parameter_Float    : Amount               :      0.0 
   --  331 : rtrtrpd                  : Parameter_Integer  : Integer              :        0 
   --  332 : rttimepd                 : Parameter_Integer  : Integer              :        0 
   --  333 : yrlvchk                  : Parameter_Integer  : Integer              :        0 
   --  334 : gross3_x                 : Parameter_Integer  : Integer              :        0 
   --  335 : hlthst                   : Parameter_Integer  : Integer              :        0 
   --  336 : medpay                   : Parameter_Integer  : Integer              :        0 
   --  337 : medwho01                 : Parameter_Integer  : Integer              :        0 
   --  338 : medwho02                 : Parameter_Integer  : Integer              :        0 
   --  339 : medwho03                 : Parameter_Integer  : Integer              :        0 
   --  340 : medwho04                 : Parameter_Integer  : Integer              :        0 
   --  341 : medwho05                 : Parameter_Integer  : Integer              :        0 
   --  342 : medwho06                 : Parameter_Integer  : Integer              :        0 
   --  343 : medwho07                 : Parameter_Integer  : Integer              :        0 
   --  344 : medwho08                 : Parameter_Integer  : Integer              :        0 
   --  345 : medwho09                 : Parameter_Integer  : Integer              :        0 
   --  346 : medwho10                 : Parameter_Integer  : Integer              :        0 
   --  347 : medwho11                 : Parameter_Integer  : Integer              :        0 
   --  348 : medwho12                 : Parameter_Integer  : Integer              :        0 
   --  349 : medwho13                 : Parameter_Integer  : Integer              :        0 
   --  350 : medwho14                 : Parameter_Integer  : Integer              :        0 
   --  351 : nmrmshar                 : Parameter_Integer  : Integer              :        0 
   --  352 : roomshr                  : Parameter_Integer  : Integer              :        0 
   --  353 : imd_ni                   : Parameter_Integer  : Integer              :        0 
   --  354 : multi                    : Parameter_Integer  : Integer              :        0 
   --  355 : nopay                    : Parameter_Integer  : Integer              :        0 
   --  356 : orgid                    : Parameter_Integer  : Integer              :        0 
   --  357 : rtene                    : Parameter_Integer  : Integer              :        0 
   --  358 : rteneamt                 : Parameter_Integer  : Integer              :        0 
   --  359 : rtgen                    : Parameter_Integer  : Integer              :        0 
   --  360 : schbrk                   : Parameter_Integer  : Integer              :        0 
   --  361 : urb                      : Parameter_Integer  : Integer              :        0 
   --  362 : urbrur                   : Parameter_Integer  : Integer              :        0 
   --  363 : hhethgr3                 : Parameter_Integer  : Integer              :        0 
   --  364 : niratlia                 : Parameter_Float    : Amount               :      0.0 
   --  365 : bankse                   : Parameter_Integer  : Integer              :        0 
   --  366 : bathshow                 : Parameter_Integer  : Integer              :        0 
   --  367 : burden                   : Parameter_Integer  : Integer              :        0 
   --  368 : comco                    : Parameter_Integer  : Integer              :        0 
   --  369 : comp1sc                  : Parameter_Integer  : Integer              :        0 
   --  370 : compsc                   : Parameter_Integer  : Integer              :        0 
   --  371 : comwa                    : Parameter_Integer  : Integer              :        0 
   --  372 : dwellno                  : Parameter_Integer  : Integer              :        0 
   --  373 : elecin                   : Parameter_Integer  : Integer              :        0 
   --  374 : elecinw                  : Parameter_Integer  : Integer              :        0 
   --  375 : eulowest                 : Parameter_Float    : Amount               :      0.0 
   --  376 : flshtoil                 : Parameter_Integer  : Integer              :        0 
   --  377 : grocse                   : Parameter_Integer  : Integer              :        0 
   --  378 : gvtregno                 : Parameter_Integer  : Integer              :        0 
   --  379 : heat                     : Parameter_Integer  : Integer              :        0 
   --  380 : heatcen                  : Parameter_Integer  : Integer              :        0 
   --  381 : heatfire                 : Parameter_Integer  : Integer              :        0 
   --  382 : kitchen                  : Parameter_Integer  : Integer              :        0 
   --  383 : knsizeft                 : Parameter_Integer  : Integer              :        0 
   --  384 : knsizem                  : Parameter_Integer  : Integer              :        0 
   --  385 : laua                     : Parameter_Integer  : Integer              :        0 
   --  386 : movef                    : Parameter_Integer  : Integer              :        0 
   --  387 : movenxt                  : Parameter_Integer  : Integer              :        0 
   --  388 : movereas                 : Parameter_Integer  : Integer              :        0 
   --  389 : ovsat                    : Parameter_Integer  : Integer              :        0 
   --  390 : plum1bin                 : Parameter_Integer  : Integer              :        0 
   --  391 : plumin                   : Parameter_Integer  : Integer              :        0 
   --  392 : pluminw                  : Parameter_Integer  : Integer              :        0 
   --  393 : postse                   : Parameter_Integer  : Integer              :        0 
   --  394 : primh                    : Parameter_Integer  : Integer              :        0 
   --  395 : pubtr                    : Parameter_Integer  : Integer              :        0 
   --  396 : samesc                   : Parameter_Integer  : Integer              :        0 
   --  397 : schfrt                   : Parameter_Integer  : Integer              :        0 
   --  398 : selper                   : Parameter_Integer  : Integer              :        0 
   --  399 : short                    : Parameter_Integer  : Integer              :        0 
   --  400 : sizeft                   : Parameter_Integer  : Integer              :        0 
   --  401 : sizem                    : Parameter_Integer  : Integer              :        0 
   --  402 : tvwhy                    : Parameter_Integer  : Integer              :        0 
   --  403 : yearwhc                  : Parameter_Integer  : Integer              :        0 
   --  404 : dischha1                 : Parameter_Integer  : Integer              :        0 
   --  405 : dischhc1                 : Parameter_Integer  : Integer              :        0 
   --  406 : diswhha1                 : Parameter_Integer  : Integer              :        0 
   --  407 : diswhhc1                 : Parameter_Integer  : Integer              :        0 
   --  408 : gross4                   : Parameter_Integer  : Integer              :        0 
   --  409 : lldcare                  : Parameter_Integer  : Integer              :        0 
   --  410 : urindni                  : Parameter_Integer  : Integer              :        0 
   --  411 : nhbeninc                 : Parameter_Integer  : Integer              :        0 
   --  412 : nhhnirbn                 : Parameter_Integer  : Integer              :        0 
   --  413 : nhhothbn                 : Parameter_Integer  : Integer              :        0 
   --  414 : seramt1                  : Parameter_Float    : Amount               :      0.0 
   --  415 : seramt2                  : Parameter_Float    : Amount               :      0.0 
   --  416 : seramt3                  : Parameter_Float    : Amount               :      0.0 
   --  417 : seramt4                  : Parameter_Float    : Amount               :      0.0 
   --  418 : serpay1                  : Parameter_Integer  : Integer              :        0 
   --  419 : serpay2                  : Parameter_Integer  : Integer              :        0 
   --  420 : serpay3                  : Parameter_Integer  : Integer              :        0 
   --  421 : serpay4                  : Parameter_Integer  : Integer              :        0 
   --  422 : serper1                  : Parameter_Integer  : Integer              :        0 
   --  423 : serper2                  : Parameter_Integer  : Integer              :        0 
   --  424 : serper3                  : Parameter_Integer  : Integer              :        0 
   --  425 : serper4                  : Parameter_Integer  : Integer              :        0 
   --  426 : utility                  : Parameter_Integer  : Integer              :        0 
   --  427 : hheth                    : Parameter_Integer  : Integer              :        0 
   --  428 : seramt5                  : Parameter_Float    : Amount               :      0.0 
   --  429 : sercomb                  : Parameter_Integer  : Integer              :        0 
   --  430 : serpay5                  : Parameter_Integer  : Integer              :        0 
   --  431 : serper5                  : Parameter_Integer  : Integer              :        0 
   --  432 : urbni                    : Parameter_Integer  : Integer              :        0 
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

  
end Ukds.Frs.Househol_IO;
