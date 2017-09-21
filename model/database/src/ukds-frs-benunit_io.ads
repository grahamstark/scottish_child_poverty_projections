--
-- Created by ada_generator.py on 2017-09-21 13:28:53.261742
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
with SCP_Types;
with Weighting_Commons;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds.Frs.Benunit_IO is
  
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
   use SCP_Types;
   use Weighting_Commons;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_user_id( connection : Database_Connection := null) return Integer;
   function Next_Free_edition( connection : Database_Connection := null) return Integer;
   function Next_Free_year( connection : Database_Connection := null) return Integer;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;
   function Next_Free_benunit( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_benunit match the defaults in Ukds.Frs.Null_Benunit
   --
   function Is_Null( a_benunit : Benunit ) return Boolean;
   
   --
   -- returns the single a_benunit matching the primary key fields, or the Ukds.Frs.Null_Benunit record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Ukds.Frs.Benunit;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Benunit matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Benunit_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Benunit retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Benunit_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_benunit : Ukds.Frs.Benunit; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Benunit
   --
   procedure Delete( a_benunit : in out Ukds.Frs.Benunit; connection : Database_Connection := null );
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
   function Retrieve_Associated_Ukds_Frs_Govpays( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Govpay_List;
   function Retrieve_Associated_Ukds_Frs_Maints( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Maint_List;
   function Retrieve_Associated_Ukds_Frs_Accounts( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Accounts_List;
   function Retrieve_Child_Ukds_Frs_Pianon1516( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1516;
   function Retrieve_Child_Ukds_Frs_Pianon1415( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1415;
   function Retrieve_Child_Ukds_Frs_Pianon1314( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1314;
   function Retrieve_Associated_Ukds_Frs_Prscrptns( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List;
   function Retrieve_Associated_Ukds_Frs_Chldcares( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List;
   function Retrieve_Associated_Ukds_Frs_Accouts( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Accouts_List;
   function Retrieve_Associated_Ukds_Frs_Oddjobs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Oddjob_List;
   function Retrieve_Associated_Ukds_Frs_Penamts( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Penamt_List;
   function Retrieve_Associated_Ukds_Frs_Penprovs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List;
   function Retrieve_Associated_Ukds_Frs_Jobs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Job_List;
   function Retrieve_Child_Ukds_Frs_Pianon1213( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1213;
   function Retrieve_Associated_Ukds_Frs_Adults( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Adult_List;
   function Retrieve_Associated_Ukds_Frs_Childs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Child_List;
   function Retrieve_Associated_Ukds_Frs_Cares( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Care_List;
   function Retrieve_Child_Ukds_Frs_Pianon1011( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1011;
   function Retrieve_Associated_Ukds_Frs_Extchilds( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Extchild_List;
   function Retrieve_Associated_Ukds_Frs_Benefits( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List;
   function Retrieve_Associated_Ukds_Frs_Assets( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Assets_List;
   function Retrieve_Associated_Ukds_Frs_Pensions( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Pension_List;
   function Retrieve_Associated_Ukds_Frs_Childcares( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List;
   function Retrieve_Child_Ukds_Frs_Pianom0809( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianom0809;

   --
   -- functions to add something to a criteria
   --
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incchnge( c : in out d.Criteria; incchnge : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inchilow( c : in out d.Criteria; inchilow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidinc( c : in out d.Criteria; kidinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhhchild( c : in out d.Criteria; nhhchild : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totsav( c : in out d.Criteria; totsav : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_actaccb( c : in out d.Criteria; actaccb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adddabu( c : in out d.Criteria; adddabu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adultb( c : in out d.Criteria; adultb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_basactb( c : in out d.Criteria; basactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_boarder( c : in out d.Criteria; boarder : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bpeninc( c : in out d.Criteria; bpeninc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bseinc( c : in out d.Criteria; bseinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buagegr2( c : in out d.Criteria; buagegr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buagegrp( c : in out d.Criteria; buagegrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_budisben( c : in out d.Criteria; budisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buearns( c : in out d.Criteria; buearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buethgr2( c : in out d.Criteria; buethgr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buethgrp( c : in out d.Criteria; buethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buinc( c : in out d.Criteria; buinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buinv( c : in out d.Criteria; buinv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buirben( c : in out d.Criteria; buirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bukids( c : in out d.Criteria; bukids : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bunirben( c : in out d.Criteria; bunirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buothben( c : in out d.Criteria; buothben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_burent( c : in out d.Criteria; burent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_burinc( c : in out d.Criteria; burinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_burpinc( c : in out d.Criteria; burpinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_butvlic( c : in out d.Criteria; butvlic : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_butxcred( c : in out d.Criteria; butxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chddabu( c : in out d.Criteria; chddabu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curactb( c : in out d.Criteria; curactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_depchldb( c : in out d.Criteria; depchldb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_depdeds( c : in out d.Criteria; depdeds : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disindhb( c : in out d.Criteria; disindhb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ecotypbu( c : in out d.Criteria; ecotypbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ecstatbu( c : in out d.Criteria; ecstatbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_famthbai( c : in out d.Criteria; famthbai : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_famtypbs( c : in out d.Criteria; famtypbs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_famtypbu( c : in out d.Criteria; famtypbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_famtype( c : in out d.Criteria; famtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsbndctb( c : in out d.Criteria; fsbndctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsmbu( c : in out d.Criteria; fsmbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsmlkbu( c : in out d.Criteria; fsmlkbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fwmlkbu( c : in out d.Criteria; fwmlkbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gebactb( c : in out d.Criteria; gebactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_giltctb( c : in out d.Criteria; giltctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross2( c : in out d.Criteria; gross2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross3( c : in out d.Criteria; gross3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbindbu( c : in out d.Criteria; hbindbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_isactb( c : in out d.Criteria; isactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kid04( c : in out d.Criteria; kid04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kid1115( c : in out d.Criteria; kid1115 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kid1618( c : in out d.Criteria; kid1618 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kid510( c : in out d.Criteria; kid510 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu0( c : in out d.Criteria; kidsbu0 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu1( c : in out d.Criteria; kidsbu1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu10( c : in out d.Criteria; kidsbu10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu11( c : in out d.Criteria; kidsbu11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu12( c : in out d.Criteria; kidsbu12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu13( c : in out d.Criteria; kidsbu13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu14( c : in out d.Criteria; kidsbu14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu15( c : in out d.Criteria; kidsbu15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu16( c : in out d.Criteria; kidsbu16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu17( c : in out d.Criteria; kidsbu17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu18( c : in out d.Criteria; kidsbu18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu2( c : in out d.Criteria; kidsbu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu3( c : in out d.Criteria; kidsbu3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu4( c : in out d.Criteria; kidsbu4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu5( c : in out d.Criteria; kidsbu5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu6( c : in out d.Criteria; kidsbu6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu7( c : in out d.Criteria; kidsbu7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu8( c : in out d.Criteria; kidsbu8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidsbu9( c : in out d.Criteria; kidsbu9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lastwork( c : in out d.Criteria; lastwork : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lodger( c : in out d.Criteria; lodger : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nsboctb( c : in out d.Criteria; nsboctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otbsctb( c : in out d.Criteria; otbsctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pepsctb( c : in out d.Criteria; pepsctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_poacctb( c : in out d.Criteria; poacctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prboctb( c : in out d.Criteria; prboctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sayectb( c : in out d.Criteria; sayectb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sclbctb( c : in out d.Criteria; sclbctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ssctb( c : in out d.Criteria; ssctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stshctb( c : in out d.Criteria; stshctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_subltamt( c : in out d.Criteria; subltamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tessctb( c : in out d.Criteria; tessctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totcapbu( c : in out d.Criteria; totcapbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totsavbu( c : in out d.Criteria; totsavbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tuburent( c : in out d.Criteria; tuburent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_untrctb( c : in out d.Criteria; untrctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_youngch( c : in out d.Criteria; youngch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adddec( c : in out d.Criteria; adddec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addeples( c : in out d.Criteria; addeples : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addhol( c : in out d.Criteria; addhol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addins( c : in out d.Criteria; addins : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addmel( c : in out d.Criteria; addmel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addmon( c : in out d.Criteria; addmon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addshoe( c : in out d.Criteria; addshoe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adepfur( c : in out d.Criteria; adepfur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_af1( c : in out d.Criteria; af1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_afdep2( c : in out d.Criteria; afdep2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdelply( c : in out d.Criteria; cdelply : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdepbed( c : in out d.Criteria; cdepbed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdepcel( c : in out d.Criteria; cdepcel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdepeqp( c : in out d.Criteria; cdepeqp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdephol( c : in out d.Criteria; cdephol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdeples( c : in out d.Criteria; cdeples : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdepsum( c : in out d.Criteria; cdepsum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdeptea( c : in out d.Criteria; cdeptea : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdeptrp( c : in out d.Criteria; cdeptrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cplay( c : in out d.Criteria; cplay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt1( c : in out d.Criteria; debt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt2( c : in out d.Criteria; debt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt3( c : in out d.Criteria; debt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt4( c : in out d.Criteria; debt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt5( c : in out d.Criteria; debt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt6( c : in out d.Criteria; debt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt7( c : in out d.Criteria; debt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt8( c : in out d.Criteria; debt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt9( c : in out d.Criteria; debt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_houshe1( c : in out d.Criteria; houshe1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incold( c : in out d.Criteria; incold : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_crunacb( c : in out d.Criteria; crunacb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_enomortb( c : in out d.Criteria; enomortb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbindbu2( c : in out d.Criteria; hbindbu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pocardb( c : in out d.Criteria; pocardb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kid1619( c : in out d.Criteria; kid1619 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totcapb2( c : in out d.Criteria; totcapb2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt1( c : in out d.Criteria; billnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt2( c : in out d.Criteria; billnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt3( c : in out d.Criteria; billnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt4( c : in out d.Criteria; billnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt5( c : in out d.Criteria; billnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt6( c : in out d.Criteria; billnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt7( c : in out d.Criteria; billnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt8( c : in out d.Criteria; billnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt1( c : in out d.Criteria; coatnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt2( c : in out d.Criteria; coatnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt3( c : in out d.Criteria; coatnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt4( c : in out d.Criteria; coatnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt5( c : in out d.Criteria; coatnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt6( c : in out d.Criteria; coatnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt7( c : in out d.Criteria; coatnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt8( c : in out d.Criteria; coatnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt1( c : in out d.Criteria; cooknt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt2( c : in out d.Criteria; cooknt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt3( c : in out d.Criteria; cooknt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt4( c : in out d.Criteria; cooknt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt5( c : in out d.Criteria; cooknt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt6( c : in out d.Criteria; cooknt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt7( c : in out d.Criteria; cooknt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt8( c : in out d.Criteria; cooknt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt1( c : in out d.Criteria; dampnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt2( c : in out d.Criteria; dampnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt3( c : in out d.Criteria; dampnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt4( c : in out d.Criteria; dampnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt5( c : in out d.Criteria; dampnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt6( c : in out d.Criteria; dampnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt7( c : in out d.Criteria; dampnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt8( c : in out d.Criteria; dampnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt1( c : in out d.Criteria; frndnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt2( c : in out d.Criteria; frndnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt3( c : in out d.Criteria; frndnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt4( c : in out d.Criteria; frndnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt5( c : in out d.Criteria; frndnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt6( c : in out d.Criteria; frndnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt7( c : in out d.Criteria; frndnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt8( c : in out d.Criteria; frndnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt1( c : in out d.Criteria; hairnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt2( c : in out d.Criteria; hairnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt3( c : in out d.Criteria; hairnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt4( c : in out d.Criteria; hairnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt5( c : in out d.Criteria; hairnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt6( c : in out d.Criteria; hairnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt7( c : in out d.Criteria; hairnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt8( c : in out d.Criteria; hairnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt1( c : in out d.Criteria; heatnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt2( c : in out d.Criteria; heatnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt3( c : in out d.Criteria; heatnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt4( c : in out d.Criteria; heatnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt5( c : in out d.Criteria; heatnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt6( c : in out d.Criteria; heatnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt7( c : in out d.Criteria; heatnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt8( c : in out d.Criteria; heatnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt1( c : in out d.Criteria; holnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt2( c : in out d.Criteria; holnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt3( c : in out d.Criteria; holnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt4( c : in out d.Criteria; holnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt5( c : in out d.Criteria; holnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt6( c : in out d.Criteria; holnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt7( c : in out d.Criteria; holnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt8( c : in out d.Criteria; holnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent1( c : in out d.Criteria; homent1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent2( c : in out d.Criteria; homent2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent3( c : in out d.Criteria; homent3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent4( c : in out d.Criteria; homent4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent5( c : in out d.Criteria; homent5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent6( c : in out d.Criteria; homent6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent7( c : in out d.Criteria; homent7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent8( c : in out d.Criteria; homent8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt1( c : in out d.Criteria; mealnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt2( c : in out d.Criteria; mealnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt3( c : in out d.Criteria; mealnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt4( c : in out d.Criteria; mealnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt5( c : in out d.Criteria; mealnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt6( c : in out d.Criteria; mealnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt7( c : in out d.Criteria; mealnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt8( c : in out d.Criteria; mealnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oabill( c : in out d.Criteria; oabill : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacoat( c : in out d.Criteria; oacoat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacook( c : in out d.Criteria; oacook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadamp( c : in out d.Criteria; oadamp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaexpns( c : in out d.Criteria; oaexpns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oafrnd( c : in out d.Criteria; oafrnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahair( c : in out d.Criteria; oahair : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaheat( c : in out d.Criteria; oaheat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahol( c : in out d.Criteria; oahol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahome( c : in out d.Criteria; oahome : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahowpy1( c : in out d.Criteria; oahowpy1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahowpy2( c : in out d.Criteria; oahowpy2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahowpy3( c : in out d.Criteria; oahowpy3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahowpy4( c : in out d.Criteria; oahowpy4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahowpy5( c : in out d.Criteria; oahowpy5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahowpy6( c : in out d.Criteria; oahowpy6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oameal( c : in out d.Criteria; oameal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaout( c : in out d.Criteria; oaout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaphon( c : in out d.Criteria; oaphon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oataxi( c : in out d.Criteria; oataxi : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oawarm( c : in out d.Criteria; oawarm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt1( c : in out d.Criteria; outnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt2( c : in out d.Criteria; outnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt3( c : in out d.Criteria; outnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt4( c : in out d.Criteria; outnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt5( c : in out d.Criteria; outnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt6( c : in out d.Criteria; outnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt7( c : in out d.Criteria; outnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt8( c : in out d.Criteria; outnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt1( c : in out d.Criteria; phonnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt2( c : in out d.Criteria; phonnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt3( c : in out d.Criteria; phonnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt4( c : in out d.Criteria; phonnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt5( c : in out d.Criteria; phonnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt6( c : in out d.Criteria; phonnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt7( c : in out d.Criteria; phonnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt8( c : in out d.Criteria; phonnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint1( c : in out d.Criteria; taxint1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint2( c : in out d.Criteria; taxint2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint3( c : in out d.Criteria; taxint3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint4( c : in out d.Criteria; taxint4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint5( c : in out d.Criteria; taxint5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint6( c : in out d.Criteria; taxint6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint7( c : in out d.Criteria; taxint7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint8( c : in out d.Criteria; taxint8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt1( c : in out d.Criteria; warmnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt2( c : in out d.Criteria; warmnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt3( c : in out d.Criteria; warmnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt4( c : in out d.Criteria; warmnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt5( c : in out d.Criteria; warmnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt6( c : in out d.Criteria; warmnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt7( c : in out d.Criteria; warmnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt8( c : in out d.Criteria; warmnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buagegr3( c : in out d.Criteria; buagegr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buagegr4( c : in out d.Criteria; buagegr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heartbu( c : in out d.Criteria; heartbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_newfambu( c : in out d.Criteria; newfambu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_billnt9( c : in out d.Criteria; billnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbaamt1( c : in out d.Criteria; cbaamt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbaamt2( c : in out d.Criteria; cbaamt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coatnt9( c : in out d.Criteria; coatnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cooknt9( c : in out d.Criteria; cooknt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dampnt9( c : in out d.Criteria; dampnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frndnt9( c : in out d.Criteria; frndnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hairnt9( c : in out d.Criteria; hairnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbolng( c : in out d.Criteria; hbolng : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothamt( c : in out d.Criteria; hbothamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothbu( c : in out d.Criteria; hbothbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothmn( c : in out d.Criteria; hbothmn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothpd( c : in out d.Criteria; hbothpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothwk( c : in out d.Criteria; hbothwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothyr( c : in out d.Criteria; hbothyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbotwait( c : in out d.Criteria; hbotwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heatnt9( c : in out d.Criteria; heatnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv01( c : in out d.Criteria; helpgv01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv02( c : in out d.Criteria; helpgv02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv03( c : in out d.Criteria; helpgv03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv04( c : in out d.Criteria; helpgv04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv05( c : in out d.Criteria; helpgv05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv06( c : in out d.Criteria; helpgv06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv07( c : in out d.Criteria; helpgv07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv08( c : in out d.Criteria; helpgv08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv09( c : in out d.Criteria; helpgv09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv10( c : in out d.Criteria; helpgv10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helpgv11( c : in out d.Criteria; helpgv11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc01( c : in out d.Criteria; helprc01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc02( c : in out d.Criteria; helprc02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc03( c : in out d.Criteria; helprc03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc04( c : in out d.Criteria; helprc04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc05( c : in out d.Criteria; helprc05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc06( c : in out d.Criteria; helprc06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc07( c : in out d.Criteria; helprc07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc08( c : in out d.Criteria; helprc08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc09( c : in out d.Criteria; helprc09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc10( c : in out d.Criteria; helprc10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_helprc11( c : in out d.Criteria; helprc11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_holnt9( c : in out d.Criteria; holnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_homent9( c : in out d.Criteria; homent9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loangvn1( c : in out d.Criteria; loangvn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loangvn2( c : in out d.Criteria; loangvn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loangvn3( c : in out d.Criteria; loangvn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanrec1( c : in out d.Criteria; loanrec1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanrec2( c : in out d.Criteria; loanrec2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanrec3( c : in out d.Criteria; loanrec3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mealnt9( c : in out d.Criteria; mealnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outnt9( c : in out d.Criteria; outnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_phonnt9( c : in out d.Criteria; phonnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxint9( c : in out d.Criteria; taxint9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_warmnt9( c : in out d.Criteria; warmnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ecostabu( c : in out d.Criteria; ecostabu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_famtypb2( c : in out d.Criteria; famtypb2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross3_x( c : in out d.Criteria; gross3_x : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_newfamb2( c : in out d.Criteria; newfamb2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oabilimp( c : in out d.Criteria; oabilimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacoaimp( c : in out d.Criteria; oacoaimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacooimp( c : in out d.Criteria; oacooimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadamimp( c : in out d.Criteria; oadamimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaexpimp( c : in out d.Criteria; oaexpimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oafrnimp( c : in out d.Criteria; oafrnimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahaiimp( c : in out d.Criteria; oahaiimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaheaimp( c : in out d.Criteria; oaheaimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaholimp( c : in out d.Criteria; oaholimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahomimp( c : in out d.Criteria; oahomimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oameaimp( c : in out d.Criteria; oameaimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaoutimp( c : in out d.Criteria; oaoutimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaphoimp( c : in out d.Criteria; oaphoimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oataximp( c : in out d.Criteria; oataximp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oawarimp( c : in out d.Criteria; oawarimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totcapb3( c : in out d.Criteria; totcapb3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adbtbl( c : in out d.Criteria; adbtbl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdepact( c : in out d.Criteria; cdepact : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdepveg( c : in out d.Criteria; cdepveg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdpcoat( c : in out d.Criteria; cdpcoat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oapre( c : in out d.Criteria; oapre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_buethgr3( c : in out d.Criteria; buethgr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsbbu( c : in out d.Criteria; fsbbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addholr( c : in out d.Criteria; addholr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_computer( c : in out d.Criteria; computer : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_compuwhy( c : in out d.Criteria; compuwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_crime( c : in out d.Criteria; crime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_damp( c : in out d.Criteria; damp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dark( c : in out d.Criteria; dark : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt01( c : in out d.Criteria; debt01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt02( c : in out d.Criteria; debt02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt03( c : in out d.Criteria; debt03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt04( c : in out d.Criteria; debt04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt05( c : in out d.Criteria; debt05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt06( c : in out d.Criteria; debt06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt07( c : in out d.Criteria; debt07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt08( c : in out d.Criteria; debt08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt09( c : in out d.Criteria; debt09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt10( c : in out d.Criteria; debt10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt11( c : in out d.Criteria; debt11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt12( c : in out d.Criteria; debt12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar01( c : in out d.Criteria; debtar01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar02( c : in out d.Criteria; debtar02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar03( c : in out d.Criteria; debtar03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar04( c : in out d.Criteria; debtar04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar05( c : in out d.Criteria; debtar05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar06( c : in out d.Criteria; debtar06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar07( c : in out d.Criteria; debtar07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar08( c : in out d.Criteria; debtar08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar09( c : in out d.Criteria; debtar09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar10( c : in out d.Criteria; debtar10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar11( c : in out d.Criteria; debtar11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar12( c : in out d.Criteria; debtar12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtfre1( c : in out d.Criteria; debtfre1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtfre2( c : in out d.Criteria; debtfre2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtfre3( c : in out d.Criteria; debtfre3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endsmeet( c : in out d.Criteria; endsmeet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eucar( c : in out d.Criteria; eucar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eucarwhy( c : in out d.Criteria; eucarwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euexpns( c : in out d.Criteria; euexpns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eumeal( c : in out d.Criteria; eumeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eurepay( c : in out d.Criteria; eurepay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euteleph( c : in out d.Criteria; euteleph : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eutelwhy( c : in out d.Criteria; eutelwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expnsoa( c : in out d.Criteria; expnsoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_houshew( c : in out d.Criteria; houshew : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_noise( c : in out d.Criteria; noise : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu1( c : in out d.Criteria; oacareu1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu2( c : in out d.Criteria; oacareu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu3( c : in out d.Criteria; oacareu3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu4( c : in out d.Criteria; oacareu4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu5( c : in out d.Criteria; oacareu5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu6( c : in out d.Criteria; oacareu6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu7( c : in out d.Criteria; oacareu7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oacareu8( c : in out d.Criteria; oacareu8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oataxieu( c : in out d.Criteria; oataxieu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep1( c : in out d.Criteria; oatelep1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep2( c : in out d.Criteria; oatelep2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep3( c : in out d.Criteria; oatelep3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep4( c : in out d.Criteria; oatelep4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep5( c : in out d.Criteria; oatelep5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep6( c : in out d.Criteria; oatelep6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep7( c : in out d.Criteria; oatelep7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oatelep8( c : in out d.Criteria; oatelep8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oateleph( c : in out d.Criteria; oateleph : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outpay( c : in out d.Criteria; outpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outpyamt( c : in out d.Criteria; outpyamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pollute( c : in out d.Criteria; pollute : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_regpamt( c : in out d.Criteria; regpamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_regularp( c : in out d.Criteria; regularp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_repaybur( c : in out d.Criteria; repaybur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_washmach( c : in out d.Criteria; washmach : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_washwhy( c : in out d.Criteria; washwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whodepq( c : in out d.Criteria; whodepq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_discbua1( c : in out d.Criteria; discbua1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_discbuc1( c : in out d.Criteria; discbuc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_diswbua1( c : in out d.Criteria; diswbua1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_diswbuc1( c : in out d.Criteria; diswbuc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsfvbu( c : in out d.Criteria; fsfvbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross4( c : in out d.Criteria; gross4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adles( c : in out d.Criteria; adles : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt1( c : in out d.Criteria; adlesnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt2( c : in out d.Criteria; adlesnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt3( c : in out d.Criteria; adlesnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt4( c : in out d.Criteria; adlesnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt5( c : in out d.Criteria; adlesnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt6( c : in out d.Criteria; adlesnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt7( c : in out d.Criteria; adlesnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesnt8( c : in out d.Criteria; adlesnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adlesoa( c : in out d.Criteria; adlesoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothes( c : in out d.Criteria; clothes : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt1( c : in out d.Criteria; clothnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt2( c : in out d.Criteria; clothnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt3( c : in out d.Criteria; clothnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt4( c : in out d.Criteria; clothnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt5( c : in out d.Criteria; clothnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt6( c : in out d.Criteria; clothnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt7( c : in out d.Criteria; clothnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothnt8( c : in out d.Criteria; clothnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clothsoa( c : in out d.Criteria; clothsoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt1( c : in out d.Criteria; furnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt2( c : in out d.Criteria; furnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt3( c : in out d.Criteria; furnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt4( c : in out d.Criteria; furnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt5( c : in out d.Criteria; furnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt6( c : in out d.Criteria; furnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt7( c : in out d.Criteria; furnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_furnt8( c : in out d.Criteria; furnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt1( c : in out d.Criteria; intntnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt2( c : in out d.Criteria; intntnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt3( c : in out d.Criteria; intntnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt4( c : in out d.Criteria; intntnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt5( c : in out d.Criteria; intntnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt6( c : in out d.Criteria; intntnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt7( c : in out d.Criteria; intntnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intntnt8( c : in out d.Criteria; intntnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intrnet( c : in out d.Criteria; intrnet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_meal( c : in out d.Criteria; meal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadep2( c : in out d.Criteria; oadep2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt1( c : in out d.Criteria; oadp2nt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt2( c : in out d.Criteria; oadp2nt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt3( c : in out d.Criteria; oadp2nt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt4( c : in out d.Criteria; oadp2nt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt5( c : in out d.Criteria; oadp2nt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt6( c : in out d.Criteria; oadp2nt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt7( c : in out d.Criteria; oadp2nt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oadp2nt8( c : in out d.Criteria; oadp2nt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oafur( c : in out d.Criteria; oafur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaintern( c : in out d.Criteria; oaintern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoe( c : in out d.Criteria; shoe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent1( c : in out d.Criteria; shoent1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent2( c : in out d.Criteria; shoent2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent3( c : in out d.Criteria; shoent3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent4( c : in out d.Criteria; shoent4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent5( c : in out d.Criteria; shoent5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent6( c : in out d.Criteria; shoent6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent7( c : in out d.Criteria; shoent7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoent8( c : in out d.Criteria; shoent8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_shoeoa( c : in out d.Criteria; shoeoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nbunirbn( c : in out d.Criteria; nbunirbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nbuothbn( c : in out d.Criteria; nbuothbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debt13( c : in out d.Criteria; debt13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_debtar13( c : in out d.Criteria; debtar13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euchbook( c : in out d.Criteria; euchbook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euchclth( c : in out d.Criteria; euchclth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euchgame( c : in out d.Criteria; euchgame : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euchmeat( c : in out d.Criteria; euchmeat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euchshoe( c : in out d.Criteria; euchshoe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eupbtran( c : in out d.Criteria; eupbtran : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eupbtrn1( c : in out d.Criteria; eupbtrn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eupbtrn2( c : in out d.Criteria; eupbtrn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eupbtrn3( c : in out d.Criteria; eupbtrn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eupbtrn4( c : in out d.Criteria; eupbtrn4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eupbtrn5( c : in out d.Criteria; eupbtrn5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euroast( c : in out d.Criteria; euroast : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eusmeal( c : in out d.Criteria; eusmeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eustudy( c : in out d.Criteria; eustudy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bueth( c : in out d.Criteria; bueth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaeusmea( c : in out d.Criteria; oaeusmea : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaholb( c : in out d.Criteria; oaholb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oaroast( c : in out d.Criteria; oaroast : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ecostab2( c : in out d.Criteria; ecostab2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incchnge_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inchilow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhhchild_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totsav_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_actaccb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adddabu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adultb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_basactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_boarder_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bpeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bseinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buagegr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buagegrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_budisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buethgr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buinv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bukids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bunirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buothben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_burent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_burinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_burpinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_butvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_butxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chddabu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_depchldb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_depdeds_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disindhb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ecotypbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ecstatbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_famthbai_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_famtypbs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_famtypbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_famtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsbndctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsmbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsmlkbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fwmlkbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gebactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_giltctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbindbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_isactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kid04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kid1115_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kid1618_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kid510_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu0_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidsbu9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lastwork_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lodger_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nsboctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otbsctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pepsctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_poacctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prboctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sayectb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sclbctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ssctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stshctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_subltamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tessctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totcapbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totsavbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tuburent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_untrctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_youngch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adddec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addeples_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addhol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addmel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addmon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addshoe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adepfur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_af1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_afdep2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdelply_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdepbed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdepcel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdepeqp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdephol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdeples_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdepsum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdeptea_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdeptrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cplay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_houshe1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incold_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_crunacb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_enomortb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbindbu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pocardb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kid1619_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totcapb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oabill_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacoat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadamp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaexpns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oafrnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahair_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaheat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahome_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahowpy1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahowpy2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahowpy3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahowpy4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahowpy5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahowpy6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oameal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaphon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oataxi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oawarm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buagegr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buagegr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heartbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_newfambu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_billnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbaamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbaamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coatnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cooknt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dampnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frndnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hairnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbolng_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothmn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbotwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heatnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helpgv11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_helprc11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_holnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_homent9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loangvn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loangvn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loangvn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanrec1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanrec2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanrec3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mealnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_phonnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxint9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_warmnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ecostabu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_famtypb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross3_x_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_newfamb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oabilimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacoaimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacooimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadamimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaexpimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oafrnimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahaiimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaheaimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaholimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahomimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oameaimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaoutimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaphoimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oataximp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oawarimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totcapb3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adbtbl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdepact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdepveg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdpcoat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oapre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buethgr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsbbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addholr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_computer_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_compuwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_crime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_damp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dark_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtfre1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtfre2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtfre3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endsmeet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eucar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eucarwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euexpns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eumeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eurepay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euteleph_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eutelwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expnsoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_houshew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_noise_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oacareu8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oataxieu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oatelep8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oateleph_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outpyamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pollute_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_regpamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_regularp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_repaybur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_washmach_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_washwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whodepq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_discbua1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_discbuc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_diswbua1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_diswbuc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsfvbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adles_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adlesoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothes_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clothsoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_furnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intntnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intrnet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_meal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadep2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oadp2nt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oafur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaintern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoent8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_shoeoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nbunirbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nbuothbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debt13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_debtar13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euchbook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euchclth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euchgame_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euchmeat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euchshoe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eupbtran_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eupbtrn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eupbtrn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eupbtrn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eupbtrn4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eupbtrn5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euroast_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eusmeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eustudy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bueth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaeusmea_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaholb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oaroast_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ecostab2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Benunit;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 510, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : incchnge                 : Parameter_Integer  : Integer              :        0 
   --    7 : inchilow                 : Parameter_Integer  : Integer              :        0 
   --    8 : kidinc                   : Parameter_Integer  : Integer              :        0 
   --    9 : nhhchild                 : Parameter_Integer  : Integer              :        0 
   --   10 : totsav                   : Parameter_Integer  : Integer              :        0 
   --   11 : month                    : Parameter_Integer  : Integer              :        0 
   --   12 : actaccb                  : Parameter_Integer  : Integer              :        0 
   --   13 : adddabu                  : Parameter_Integer  : Integer              :        0 
   --   14 : adultb                   : Parameter_Integer  : Integer              :        0 
   --   15 : basactb                  : Parameter_Integer  : Integer              :        0 
   --   16 : boarder                  : Parameter_Float    : Amount               :      0.0 
   --   17 : bpeninc                  : Parameter_Float    : Amount               :      0.0 
   --   18 : bseinc                   : Parameter_Float    : Amount               :      0.0 
   --   19 : buagegr2                 : Parameter_Integer  : Integer              :        0 
   --   20 : buagegrp                 : Parameter_Integer  : Integer              :        0 
   --   21 : budisben                 : Parameter_Integer  : Integer              :        0 
   --   22 : buearns                  : Parameter_Float    : Amount               :      0.0 
   --   23 : buethgr2                 : Parameter_Integer  : Integer              :        0 
   --   24 : buethgrp                 : Parameter_Integer  : Integer              :        0 
   --   25 : buinc                    : Parameter_Integer  : Integer              :        0 
   --   26 : buinv                    : Parameter_Float    : Amount               :      0.0 
   --   27 : buirben                  : Parameter_Integer  : Integer              :        0 
   --   28 : bukids                   : Parameter_Integer  : Integer              :        0 
   --   29 : bunirben                 : Parameter_Integer  : Integer              :        0 
   --   30 : buothben                 : Parameter_Integer  : Integer              :        0 
   --   31 : burent                   : Parameter_Integer  : Integer              :        0 
   --   32 : burinc                   : Parameter_Float    : Amount               :      0.0 
   --   33 : burpinc                  : Parameter_Float    : Amount               :      0.0 
   --   34 : butvlic                  : Parameter_Float    : Amount               :      0.0 
   --   35 : butxcred                 : Parameter_Float    : Amount               :      0.0 
   --   36 : chddabu                  : Parameter_Integer  : Integer              :        0 
   --   37 : curactb                  : Parameter_Integer  : Integer              :        0 
   --   38 : depchldb                 : Parameter_Integer  : Integer              :        0 
   --   39 : depdeds                  : Parameter_Integer  : Integer              :        0 
   --   40 : disindhb                 : Parameter_Integer  : Integer              :        0 
   --   41 : ecotypbu                 : Parameter_Integer  : Integer              :        0 
   --   42 : ecstatbu                 : Parameter_Integer  : Integer              :        0 
   --   43 : famthbai                 : Parameter_Integer  : Integer              :        0 
   --   44 : famtypbs                 : Parameter_Integer  : Integer              :        0 
   --   45 : famtypbu                 : Parameter_Integer  : Integer              :        0 
   --   46 : famtype                  : Parameter_Integer  : Integer              :        0 
   --   47 : fsbndctb                 : Parameter_Integer  : Integer              :        0 
   --   48 : fsmbu                    : Parameter_Float    : Amount               :      0.0 
   --   49 : fsmlkbu                  : Parameter_Float    : Amount               :      0.0 
   --   50 : fwmlkbu                  : Parameter_Float    : Amount               :      0.0 
   --   51 : gebactb                  : Parameter_Integer  : Integer              :        0 
   --   52 : giltctb                  : Parameter_Integer  : Integer              :        0 
   --   53 : gross2                   : Parameter_Integer  : Integer              :        0 
   --   54 : gross3                   : Parameter_Integer  : Integer              :        0 
   --   55 : hbindbu                  : Parameter_Integer  : Integer              :        0 
   --   56 : isactb                   : Parameter_Integer  : Integer              :        0 
   --   57 : kid04                    : Parameter_Integer  : Integer              :        0 
   --   58 : kid1115                  : Parameter_Integer  : Integer              :        0 
   --   59 : kid1618                  : Parameter_Integer  : Integer              :        0 
   --   60 : kid510                   : Parameter_Integer  : Integer              :        0 
   --   61 : kidsbu0                  : Parameter_Integer  : Integer              :        0 
   --   62 : kidsbu1                  : Parameter_Integer  : Integer              :        0 
   --   63 : kidsbu10                 : Parameter_Integer  : Integer              :        0 
   --   64 : kidsbu11                 : Parameter_Integer  : Integer              :        0 
   --   65 : kidsbu12                 : Parameter_Integer  : Integer              :        0 
   --   66 : kidsbu13                 : Parameter_Integer  : Integer              :        0 
   --   67 : kidsbu14                 : Parameter_Integer  : Integer              :        0 
   --   68 : kidsbu15                 : Parameter_Integer  : Integer              :        0 
   --   69 : kidsbu16                 : Parameter_Integer  : Integer              :        0 
   --   70 : kidsbu17                 : Parameter_Integer  : Integer              :        0 
   --   71 : kidsbu18                 : Parameter_Integer  : Integer              :        0 
   --   72 : kidsbu2                  : Parameter_Integer  : Integer              :        0 
   --   73 : kidsbu3                  : Parameter_Integer  : Integer              :        0 
   --   74 : kidsbu4                  : Parameter_Integer  : Integer              :        0 
   --   75 : kidsbu5                  : Parameter_Integer  : Integer              :        0 
   --   76 : kidsbu6                  : Parameter_Integer  : Integer              :        0 
   --   77 : kidsbu7                  : Parameter_Integer  : Integer              :        0 
   --   78 : kidsbu8                  : Parameter_Integer  : Integer              :        0 
   --   79 : kidsbu9                  : Parameter_Integer  : Integer              :        0 
   --   80 : lastwork                 : Parameter_Integer  : Integer              :        0 
   --   81 : lodger                   : Parameter_Float    : Amount               :      0.0 
   --   82 : nsboctb                  : Parameter_Integer  : Integer              :        0 
   --   83 : otbsctb                  : Parameter_Integer  : Integer              :        0 
   --   84 : pepsctb                  : Parameter_Integer  : Integer              :        0 
   --   85 : poacctb                  : Parameter_Integer  : Integer              :        0 
   --   86 : prboctb                  : Parameter_Integer  : Integer              :        0 
   --   87 : sayectb                  : Parameter_Integer  : Integer              :        0 
   --   88 : sclbctb                  : Parameter_Integer  : Integer              :        0 
   --   89 : ssctb                    : Parameter_Integer  : Integer              :        0 
   --   90 : stshctb                  : Parameter_Integer  : Integer              :        0 
   --   91 : subltamt                 : Parameter_Float    : Amount               :      0.0 
   --   92 : tessctb                  : Parameter_Integer  : Integer              :        0 
   --   93 : totcapbu                 : Parameter_Float    : Amount               :      0.0 
   --   94 : totsavbu                 : Parameter_Integer  : Integer              :        0 
   --   95 : tuburent                 : Parameter_Float    : Amount               :      0.0 
   --   96 : untrctb                  : Parameter_Integer  : Integer              :        0 
   --   97 : youngch                  : Parameter_Integer  : Integer              :        0 
   --   98 : adddec                   : Parameter_Integer  : Integer              :        0 
   --   99 : addeples                 : Parameter_Integer  : Integer              :        0 
   --  100 : addhol                   : Parameter_Integer  : Integer              :        0 
   --  101 : addins                   : Parameter_Integer  : Integer              :        0 
   --  102 : addmel                   : Parameter_Integer  : Integer              :        0 
   --  103 : addmon                   : Parameter_Integer  : Integer              :        0 
   --  104 : addshoe                  : Parameter_Integer  : Integer              :        0 
   --  105 : adepfur                  : Parameter_Integer  : Integer              :        0 
   --  106 : af1                      : Parameter_Integer  : Integer              :        0 
   --  107 : afdep2                   : Parameter_Integer  : Integer              :        0 
   --  108 : cdelply                  : Parameter_Integer  : Integer              :        0 
   --  109 : cdepbed                  : Parameter_Integer  : Integer              :        0 
   --  110 : cdepcel                  : Parameter_Integer  : Integer              :        0 
   --  111 : cdepeqp                  : Parameter_Integer  : Integer              :        0 
   --  112 : cdephol                  : Parameter_Integer  : Integer              :        0 
   --  113 : cdeples                  : Parameter_Integer  : Integer              :        0 
   --  114 : cdepsum                  : Parameter_Integer  : Integer              :        0 
   --  115 : cdeptea                  : Parameter_Integer  : Integer              :        0 
   --  116 : cdeptrp                  : Parameter_Integer  : Integer              :        0 
   --  117 : cplay                    : Parameter_Integer  : Integer              :        0 
   --  118 : debt1                    : Parameter_Integer  : Integer              :        0 
   --  119 : debt2                    : Parameter_Integer  : Integer              :        0 
   --  120 : debt3                    : Parameter_Integer  : Integer              :        0 
   --  121 : debt4                    : Parameter_Integer  : Integer              :        0 
   --  122 : debt5                    : Parameter_Integer  : Integer              :        0 
   --  123 : debt6                    : Parameter_Integer  : Integer              :        0 
   --  124 : debt7                    : Parameter_Integer  : Integer              :        0 
   --  125 : debt8                    : Parameter_Integer  : Integer              :        0 
   --  126 : debt9                    : Parameter_Integer  : Integer              :        0 
   --  127 : houshe1                  : Parameter_Integer  : Integer              :        0 
   --  128 : incold                   : Parameter_Integer  : Integer              :        0 
   --  129 : crunacb                  : Parameter_Integer  : Integer              :        0 
   --  130 : enomortb                 : Parameter_Integer  : Integer              :        0 
   --  131 : hbindbu2                 : Parameter_Integer  : Integer              :        0 
   --  132 : pocardb                  : Parameter_Integer  : Integer              :        0 
   --  133 : kid1619                  : Parameter_Integer  : Integer              :        0 
   --  134 : totcapb2                 : Parameter_Float    : Amount               :      0.0 
   --  135 : billnt1                  : Parameter_Integer  : Integer              :        0 
   --  136 : billnt2                  : Parameter_Integer  : Integer              :        0 
   --  137 : billnt3                  : Parameter_Integer  : Integer              :        0 
   --  138 : billnt4                  : Parameter_Integer  : Integer              :        0 
   --  139 : billnt5                  : Parameter_Integer  : Integer              :        0 
   --  140 : billnt6                  : Parameter_Integer  : Integer              :        0 
   --  141 : billnt7                  : Parameter_Integer  : Integer              :        0 
   --  142 : billnt8                  : Parameter_Integer  : Integer              :        0 
   --  143 : coatnt1                  : Parameter_Integer  : Integer              :        0 
   --  144 : coatnt2                  : Parameter_Integer  : Integer              :        0 
   --  145 : coatnt3                  : Parameter_Integer  : Integer              :        0 
   --  146 : coatnt4                  : Parameter_Integer  : Integer              :        0 
   --  147 : coatnt5                  : Parameter_Integer  : Integer              :        0 
   --  148 : coatnt6                  : Parameter_Integer  : Integer              :        0 
   --  149 : coatnt7                  : Parameter_Integer  : Integer              :        0 
   --  150 : coatnt8                  : Parameter_Integer  : Integer              :        0 
   --  151 : cooknt1                  : Parameter_Integer  : Integer              :        0 
   --  152 : cooknt2                  : Parameter_Integer  : Integer              :        0 
   --  153 : cooknt3                  : Parameter_Integer  : Integer              :        0 
   --  154 : cooknt4                  : Parameter_Integer  : Integer              :        0 
   --  155 : cooknt5                  : Parameter_Integer  : Integer              :        0 
   --  156 : cooknt6                  : Parameter_Integer  : Integer              :        0 
   --  157 : cooknt7                  : Parameter_Integer  : Integer              :        0 
   --  158 : cooknt8                  : Parameter_Integer  : Integer              :        0 
   --  159 : dampnt1                  : Parameter_Integer  : Integer              :        0 
   --  160 : dampnt2                  : Parameter_Integer  : Integer              :        0 
   --  161 : dampnt3                  : Parameter_Integer  : Integer              :        0 
   --  162 : dampnt4                  : Parameter_Integer  : Integer              :        0 
   --  163 : dampnt5                  : Parameter_Integer  : Integer              :        0 
   --  164 : dampnt6                  : Parameter_Integer  : Integer              :        0 
   --  165 : dampnt7                  : Parameter_Integer  : Integer              :        0 
   --  166 : dampnt8                  : Parameter_Integer  : Integer              :        0 
   --  167 : frndnt1                  : Parameter_Integer  : Integer              :        0 
   --  168 : frndnt2                  : Parameter_Integer  : Integer              :        0 
   --  169 : frndnt3                  : Parameter_Integer  : Integer              :        0 
   --  170 : frndnt4                  : Parameter_Integer  : Integer              :        0 
   --  171 : frndnt5                  : Parameter_Integer  : Integer              :        0 
   --  172 : frndnt6                  : Parameter_Integer  : Integer              :        0 
   --  173 : frndnt7                  : Parameter_Integer  : Integer              :        0 
   --  174 : frndnt8                  : Parameter_Integer  : Integer              :        0 
   --  175 : hairnt1                  : Parameter_Integer  : Integer              :        0 
   --  176 : hairnt2                  : Parameter_Integer  : Integer              :        0 
   --  177 : hairnt3                  : Parameter_Integer  : Integer              :        0 
   --  178 : hairnt4                  : Parameter_Integer  : Integer              :        0 
   --  179 : hairnt5                  : Parameter_Integer  : Integer              :        0 
   --  180 : hairnt6                  : Parameter_Integer  : Integer              :        0 
   --  181 : hairnt7                  : Parameter_Integer  : Integer              :        0 
   --  182 : hairnt8                  : Parameter_Integer  : Integer              :        0 
   --  183 : heatnt1                  : Parameter_Integer  : Integer              :        0 
   --  184 : heatnt2                  : Parameter_Integer  : Integer              :        0 
   --  185 : heatnt3                  : Parameter_Integer  : Integer              :        0 
   --  186 : heatnt4                  : Parameter_Integer  : Integer              :        0 
   --  187 : heatnt5                  : Parameter_Integer  : Integer              :        0 
   --  188 : heatnt6                  : Parameter_Integer  : Integer              :        0 
   --  189 : heatnt7                  : Parameter_Integer  : Integer              :        0 
   --  190 : heatnt8                  : Parameter_Integer  : Integer              :        0 
   --  191 : holnt1                   : Parameter_Integer  : Integer              :        0 
   --  192 : holnt2                   : Parameter_Integer  : Integer              :        0 
   --  193 : holnt3                   : Parameter_Integer  : Integer              :        0 
   --  194 : holnt4                   : Parameter_Integer  : Integer              :        0 
   --  195 : holnt5                   : Parameter_Integer  : Integer              :        0 
   --  196 : holnt6                   : Parameter_Integer  : Integer              :        0 
   --  197 : holnt7                   : Parameter_Integer  : Integer              :        0 
   --  198 : holnt8                   : Parameter_Integer  : Integer              :        0 
   --  199 : homent1                  : Parameter_Integer  : Integer              :        0 
   --  200 : homent2                  : Parameter_Integer  : Integer              :        0 
   --  201 : homent3                  : Parameter_Integer  : Integer              :        0 
   --  202 : homent4                  : Parameter_Integer  : Integer              :        0 
   --  203 : homent5                  : Parameter_Integer  : Integer              :        0 
   --  204 : homent6                  : Parameter_Integer  : Integer              :        0 
   --  205 : homent7                  : Parameter_Integer  : Integer              :        0 
   --  206 : homent8                  : Parameter_Integer  : Integer              :        0 
   --  207 : issue                    : Parameter_Integer  : Integer              :        0 
   --  208 : mealnt1                  : Parameter_Integer  : Integer              :        0 
   --  209 : mealnt2                  : Parameter_Integer  : Integer              :        0 
   --  210 : mealnt3                  : Parameter_Integer  : Integer              :        0 
   --  211 : mealnt4                  : Parameter_Integer  : Integer              :        0 
   --  212 : mealnt5                  : Parameter_Integer  : Integer              :        0 
   --  213 : mealnt6                  : Parameter_Integer  : Integer              :        0 
   --  214 : mealnt7                  : Parameter_Integer  : Integer              :        0 
   --  215 : mealnt8                  : Parameter_Integer  : Integer              :        0 
   --  216 : oabill                   : Parameter_Integer  : Integer              :        0 
   --  217 : oacoat                   : Parameter_Integer  : Integer              :        0 
   --  218 : oacook                   : Parameter_Integer  : Integer              :        0 
   --  219 : oadamp                   : Parameter_Integer  : Integer              :        0 
   --  220 : oaexpns                  : Parameter_Integer  : Integer              :        0 
   --  221 : oafrnd                   : Parameter_Integer  : Integer              :        0 
   --  222 : oahair                   : Parameter_Integer  : Integer              :        0 
   --  223 : oaheat                   : Parameter_Integer  : Integer              :        0 
   --  224 : oahol                    : Parameter_Integer  : Integer              :        0 
   --  225 : oahome                   : Parameter_Integer  : Integer              :        0 
   --  226 : oahowpy1                 : Parameter_Integer  : Integer              :        0 
   --  227 : oahowpy2                 : Parameter_Integer  : Integer              :        0 
   --  228 : oahowpy3                 : Parameter_Integer  : Integer              :        0 
   --  229 : oahowpy4                 : Parameter_Integer  : Integer              :        0 
   --  230 : oahowpy5                 : Parameter_Integer  : Integer              :        0 
   --  231 : oahowpy6                 : Parameter_Integer  : Integer              :        0 
   --  232 : oameal                   : Parameter_Integer  : Integer              :        0 
   --  233 : oaout                    : Parameter_Integer  : Integer              :        0 
   --  234 : oaphon                   : Parameter_Integer  : Integer              :        0 
   --  235 : oataxi                   : Parameter_Integer  : Integer              :        0 
   --  236 : oawarm                   : Parameter_Integer  : Integer              :        0 
   --  237 : outnt1                   : Parameter_Integer  : Integer              :        0 
   --  238 : outnt2                   : Parameter_Integer  : Integer              :        0 
   --  239 : outnt3                   : Parameter_Integer  : Integer              :        0 
   --  240 : outnt4                   : Parameter_Integer  : Integer              :        0 
   --  241 : outnt5                   : Parameter_Integer  : Integer              :        0 
   --  242 : outnt6                   : Parameter_Integer  : Integer              :        0 
   --  243 : outnt7                   : Parameter_Integer  : Integer              :        0 
   --  244 : outnt8                   : Parameter_Integer  : Integer              :        0 
   --  245 : phonnt1                  : Parameter_Integer  : Integer              :        0 
   --  246 : phonnt2                  : Parameter_Integer  : Integer              :        0 
   --  247 : phonnt3                  : Parameter_Integer  : Integer              :        0 
   --  248 : phonnt4                  : Parameter_Integer  : Integer              :        0 
   --  249 : phonnt5                  : Parameter_Integer  : Integer              :        0 
   --  250 : phonnt6                  : Parameter_Integer  : Integer              :        0 
   --  251 : phonnt7                  : Parameter_Integer  : Integer              :        0 
   --  252 : phonnt8                  : Parameter_Integer  : Integer              :        0 
   --  253 : taxint1                  : Parameter_Integer  : Integer              :        0 
   --  254 : taxint2                  : Parameter_Integer  : Integer              :        0 
   --  255 : taxint3                  : Parameter_Integer  : Integer              :        0 
   --  256 : taxint4                  : Parameter_Integer  : Integer              :        0 
   --  257 : taxint5                  : Parameter_Integer  : Integer              :        0 
   --  258 : taxint6                  : Parameter_Integer  : Integer              :        0 
   --  259 : taxint7                  : Parameter_Integer  : Integer              :        0 
   --  260 : taxint8                  : Parameter_Integer  : Integer              :        0 
   --  261 : warmnt1                  : Parameter_Integer  : Integer              :        0 
   --  262 : warmnt2                  : Parameter_Integer  : Integer              :        0 
   --  263 : warmnt3                  : Parameter_Integer  : Integer              :        0 
   --  264 : warmnt4                  : Parameter_Integer  : Integer              :        0 
   --  265 : warmnt5                  : Parameter_Integer  : Integer              :        0 
   --  266 : warmnt6                  : Parameter_Integer  : Integer              :        0 
   --  267 : warmnt7                  : Parameter_Integer  : Integer              :        0 
   --  268 : warmnt8                  : Parameter_Integer  : Integer              :        0 
   --  269 : buagegr3                 : Parameter_Integer  : Integer              :        0 
   --  270 : buagegr4                 : Parameter_Integer  : Integer              :        0 
   --  271 : heartbu                  : Parameter_Float    : Amount               :      0.0 
   --  272 : newfambu                 : Parameter_Integer  : Integer              :        0 
   --  273 : billnt9                  : Parameter_Integer  : Integer              :        0 
   --  274 : cbaamt1                  : Parameter_Integer  : Integer              :        0 
   --  275 : cbaamt2                  : Parameter_Integer  : Integer              :        0 
   --  276 : coatnt9                  : Parameter_Integer  : Integer              :        0 
   --  277 : cooknt9                  : Parameter_Integer  : Integer              :        0 
   --  278 : dampnt9                  : Parameter_Integer  : Integer              :        0 
   --  279 : frndnt9                  : Parameter_Integer  : Integer              :        0 
   --  280 : hairnt9                  : Parameter_Integer  : Integer              :        0 
   --  281 : hbolng                   : Parameter_Integer  : Integer              :        0 
   --  282 : hbothamt                 : Parameter_Float    : Amount               :      0.0 
   --  283 : hbothbu                  : Parameter_Integer  : Integer              :        0 
   --  284 : hbothmn                  : Parameter_Integer  : Integer              :        0 
   --  285 : hbothpd                  : Parameter_Integer  : Integer              :        0 
   --  286 : hbothwk                  : Parameter_Integer  : Integer              :        0 
   --  287 : hbothyr                  : Parameter_Integer  : Integer              :        0 
   --  288 : hbotwait                 : Parameter_Integer  : Integer              :        0 
   --  289 : heatnt9                  : Parameter_Integer  : Integer              :        0 
   --  290 : helpgv01                 : Parameter_Integer  : Integer              :        0 
   --  291 : helpgv02                 : Parameter_Integer  : Integer              :        0 
   --  292 : helpgv03                 : Parameter_Integer  : Integer              :        0 
   --  293 : helpgv04                 : Parameter_Integer  : Integer              :        0 
   --  294 : helpgv05                 : Parameter_Integer  : Integer              :        0 
   --  295 : helpgv06                 : Parameter_Integer  : Integer              :        0 
   --  296 : helpgv07                 : Parameter_Integer  : Integer              :        0 
   --  297 : helpgv08                 : Parameter_Integer  : Integer              :        0 
   --  298 : helpgv09                 : Parameter_Integer  : Integer              :        0 
   --  299 : helpgv10                 : Parameter_Integer  : Integer              :        0 
   --  300 : helpgv11                 : Parameter_Integer  : Integer              :        0 
   --  301 : helprc01                 : Parameter_Integer  : Integer              :        0 
   --  302 : helprc02                 : Parameter_Integer  : Integer              :        0 
   --  303 : helprc03                 : Parameter_Integer  : Integer              :        0 
   --  304 : helprc04                 : Parameter_Integer  : Integer              :        0 
   --  305 : helprc05                 : Parameter_Integer  : Integer              :        0 
   --  306 : helprc06                 : Parameter_Integer  : Integer              :        0 
   --  307 : helprc07                 : Parameter_Integer  : Integer              :        0 
   --  308 : helprc08                 : Parameter_Integer  : Integer              :        0 
   --  309 : helprc09                 : Parameter_Integer  : Integer              :        0 
   --  310 : helprc10                 : Parameter_Integer  : Integer              :        0 
   --  311 : helprc11                 : Parameter_Integer  : Integer              :        0 
   --  312 : holnt9                   : Parameter_Integer  : Integer              :        0 
   --  313 : homent9                  : Parameter_Integer  : Integer              :        0 
   --  314 : loangvn1                 : Parameter_Integer  : Integer              :        0 
   --  315 : loangvn2                 : Parameter_Integer  : Integer              :        0 
   --  316 : loangvn3                 : Parameter_Integer  : Integer              :        0 
   --  317 : loanrec1                 : Parameter_Integer  : Integer              :        0 
   --  318 : loanrec2                 : Parameter_Integer  : Integer              :        0 
   --  319 : loanrec3                 : Parameter_Integer  : Integer              :        0 
   --  320 : mealnt9                  : Parameter_Integer  : Integer              :        0 
   --  321 : outnt9                   : Parameter_Integer  : Integer              :        0 
   --  322 : phonnt9                  : Parameter_Integer  : Integer              :        0 
   --  323 : taxint9                  : Parameter_Integer  : Integer              :        0 
   --  324 : warmnt9                  : Parameter_Integer  : Integer              :        0 
   --  325 : ecostabu                 : Parameter_Integer  : Integer              :        0 
   --  326 : famtypb2                 : Parameter_Integer  : Integer              :        0 
   --  327 : gross3_x                 : Parameter_Integer  : Integer              :        0 
   --  328 : newfamb2                 : Parameter_Integer  : Integer              :        0 
   --  329 : oabilimp                 : Parameter_Integer  : Integer              :        0 
   --  330 : oacoaimp                 : Parameter_Integer  : Integer              :        0 
   --  331 : oacooimp                 : Parameter_Integer  : Integer              :        0 
   --  332 : oadamimp                 : Parameter_Integer  : Integer              :        0 
   --  333 : oaexpimp                 : Parameter_Integer  : Integer              :        0 
   --  334 : oafrnimp                 : Parameter_Integer  : Integer              :        0 
   --  335 : oahaiimp                 : Parameter_Integer  : Integer              :        0 
   --  336 : oaheaimp                 : Parameter_Integer  : Integer              :        0 
   --  337 : oaholimp                 : Parameter_Integer  : Integer              :        0 
   --  338 : oahomimp                 : Parameter_Integer  : Integer              :        0 
   --  339 : oameaimp                 : Parameter_Integer  : Integer              :        0 
   --  340 : oaoutimp                 : Parameter_Integer  : Integer              :        0 
   --  341 : oaphoimp                 : Parameter_Integer  : Integer              :        0 
   --  342 : oataximp                 : Parameter_Integer  : Integer              :        0 
   --  343 : oawarimp                 : Parameter_Integer  : Integer              :        0 
   --  344 : totcapb3                 : Parameter_Float    : Amount               :      0.0 
   --  345 : adbtbl                   : Parameter_Integer  : Integer              :        0 
   --  346 : cdepact                  : Parameter_Integer  : Integer              :        0 
   --  347 : cdepveg                  : Parameter_Integer  : Integer              :        0 
   --  348 : cdpcoat                  : Parameter_Integer  : Integer              :        0 
   --  349 : oapre                    : Parameter_Integer  : Integer              :        0 
   --  350 : buethgr3                 : Parameter_Integer  : Integer              :        0 
   --  351 : fsbbu                    : Parameter_Float    : Amount               :      0.0 
   --  352 : addholr                  : Parameter_Integer  : Integer              :        0 
   --  353 : computer                 : Parameter_Integer  : Integer              :        0 
   --  354 : compuwhy                 : Parameter_Integer  : Integer              :        0 
   --  355 : crime                    : Parameter_Integer  : Integer              :        0 
   --  356 : damp                     : Parameter_Integer  : Integer              :        0 
   --  357 : dark                     : Parameter_Integer  : Integer              :        0 
   --  358 : debt01                   : Parameter_Integer  : Integer              :        0 
   --  359 : debt02                   : Parameter_Integer  : Integer              :        0 
   --  360 : debt03                   : Parameter_Integer  : Integer              :        0 
   --  361 : debt04                   : Parameter_Integer  : Integer              :        0 
   --  362 : debt05                   : Parameter_Integer  : Integer              :        0 
   --  363 : debt06                   : Parameter_Integer  : Integer              :        0 
   --  364 : debt07                   : Parameter_Integer  : Integer              :        0 
   --  365 : debt08                   : Parameter_Integer  : Integer              :        0 
   --  366 : debt09                   : Parameter_Integer  : Integer              :        0 
   --  367 : debt10                   : Parameter_Integer  : Integer              :        0 
   --  368 : debt11                   : Parameter_Integer  : Integer              :        0 
   --  369 : debt12                   : Parameter_Integer  : Integer              :        0 
   --  370 : debtar01                 : Parameter_Integer  : Integer              :        0 
   --  371 : debtar02                 : Parameter_Integer  : Integer              :        0 
   --  372 : debtar03                 : Parameter_Integer  : Integer              :        0 
   --  373 : debtar04                 : Parameter_Integer  : Integer              :        0 
   --  374 : debtar05                 : Parameter_Integer  : Integer              :        0 
   --  375 : debtar06                 : Parameter_Integer  : Integer              :        0 
   --  376 : debtar07                 : Parameter_Integer  : Integer              :        0 
   --  377 : debtar08                 : Parameter_Integer  : Integer              :        0 
   --  378 : debtar09                 : Parameter_Integer  : Integer              :        0 
   --  379 : debtar10                 : Parameter_Integer  : Integer              :        0 
   --  380 : debtar11                 : Parameter_Integer  : Integer              :        0 
   --  381 : debtar12                 : Parameter_Integer  : Integer              :        0 
   --  382 : debtfre1                 : Parameter_Integer  : Integer              :        0 
   --  383 : debtfre2                 : Parameter_Integer  : Integer              :        0 
   --  384 : debtfre3                 : Parameter_Integer  : Integer              :        0 
   --  385 : endsmeet                 : Parameter_Integer  : Integer              :        0 
   --  386 : eucar                    : Parameter_Integer  : Integer              :        0 
   --  387 : eucarwhy                 : Parameter_Integer  : Integer              :        0 
   --  388 : euexpns                  : Parameter_Integer  : Integer              :        0 
   --  389 : eumeal                   : Parameter_Integer  : Integer              :        0 
   --  390 : eurepay                  : Parameter_Integer  : Integer              :        0 
   --  391 : euteleph                 : Parameter_Integer  : Integer              :        0 
   --  392 : eutelwhy                 : Parameter_Integer  : Integer              :        0 
   --  393 : expnsoa                  : Parameter_Integer  : Integer              :        0 
   --  394 : houshew                  : Parameter_Integer  : Integer              :        0 
   --  395 : noise                    : Parameter_Integer  : Integer              :        0 
   --  396 : oacareu1                 : Parameter_Integer  : Integer              :        0 
   --  397 : oacareu2                 : Parameter_Integer  : Integer              :        0 
   --  398 : oacareu3                 : Parameter_Integer  : Integer              :        0 
   --  399 : oacareu4                 : Parameter_Integer  : Integer              :        0 
   --  400 : oacareu5                 : Parameter_Integer  : Integer              :        0 
   --  401 : oacareu6                 : Parameter_Integer  : Integer              :        0 
   --  402 : oacareu7                 : Parameter_Integer  : Integer              :        0 
   --  403 : oacareu8                 : Parameter_Integer  : Integer              :        0 
   --  404 : oataxieu                 : Parameter_Integer  : Integer              :        0 
   --  405 : oatelep1                 : Parameter_Integer  : Integer              :        0 
   --  406 : oatelep2                 : Parameter_Integer  : Integer              :        0 
   --  407 : oatelep3                 : Parameter_Integer  : Integer              :        0 
   --  408 : oatelep4                 : Parameter_Integer  : Integer              :        0 
   --  409 : oatelep5                 : Parameter_Integer  : Integer              :        0 
   --  410 : oatelep6                 : Parameter_Integer  : Integer              :        0 
   --  411 : oatelep7                 : Parameter_Integer  : Integer              :        0 
   --  412 : oatelep8                 : Parameter_Integer  : Integer              :        0 
   --  413 : oateleph                 : Parameter_Integer  : Integer              :        0 
   --  414 : outpay                   : Parameter_Integer  : Integer              :        0 
   --  415 : outpyamt                 : Parameter_Float    : Amount               :      0.0 
   --  416 : pollute                  : Parameter_Integer  : Integer              :        0 
   --  417 : regpamt                  : Parameter_Float    : Amount               :      0.0 
   --  418 : regularp                 : Parameter_Integer  : Integer              :        0 
   --  419 : repaybur                 : Parameter_Integer  : Integer              :        0 
   --  420 : washmach                 : Parameter_Integer  : Integer              :        0 
   --  421 : washwhy                  : Parameter_Integer  : Integer              :        0 
   --  422 : whodepq                  : Parameter_Integer  : Integer              :        0 
   --  423 : discbua1                 : Parameter_Integer  : Integer              :        0 
   --  424 : discbuc1                 : Parameter_Integer  : Integer              :        0 
   --  425 : diswbua1                 : Parameter_Integer  : Integer              :        0 
   --  426 : diswbuc1                 : Parameter_Integer  : Integer              :        0 
   --  427 : fsfvbu                   : Parameter_Float    : Amount               :      0.0 
   --  428 : gross4                   : Parameter_Integer  : Integer              :        0 
   --  429 : adles                    : Parameter_Integer  : Integer              :        0 
   --  430 : adlesnt1                 : Parameter_Integer  : Integer              :        0 
   --  431 : adlesnt2                 : Parameter_Integer  : Integer              :        0 
   --  432 : adlesnt3                 : Parameter_Integer  : Integer              :        0 
   --  433 : adlesnt4                 : Parameter_Integer  : Integer              :        0 
   --  434 : adlesnt5                 : Parameter_Integer  : Integer              :        0 
   --  435 : adlesnt6                 : Parameter_Integer  : Integer              :        0 
   --  436 : adlesnt7                 : Parameter_Integer  : Integer              :        0 
   --  437 : adlesnt8                 : Parameter_Integer  : Integer              :        0 
   --  438 : adlesoa                  : Parameter_Integer  : Integer              :        0 
   --  439 : clothes                  : Parameter_Integer  : Integer              :        0 
   --  440 : clothnt1                 : Parameter_Integer  : Integer              :        0 
   --  441 : clothnt2                 : Parameter_Integer  : Integer              :        0 
   --  442 : clothnt3                 : Parameter_Integer  : Integer              :        0 
   --  443 : clothnt4                 : Parameter_Integer  : Integer              :        0 
   --  444 : clothnt5                 : Parameter_Integer  : Integer              :        0 
   --  445 : clothnt6                 : Parameter_Integer  : Integer              :        0 
   --  446 : clothnt7                 : Parameter_Integer  : Integer              :        0 
   --  447 : clothnt8                 : Parameter_Integer  : Integer              :        0 
   --  448 : clothsoa                 : Parameter_Integer  : Integer              :        0 
   --  449 : furnt1                   : Parameter_Integer  : Integer              :        0 
   --  450 : furnt2                   : Parameter_Integer  : Integer              :        0 
   --  451 : furnt3                   : Parameter_Integer  : Integer              :        0 
   --  452 : furnt4                   : Parameter_Integer  : Integer              :        0 
   --  453 : furnt5                   : Parameter_Integer  : Integer              :        0 
   --  454 : furnt6                   : Parameter_Integer  : Integer              :        0 
   --  455 : furnt7                   : Parameter_Integer  : Integer              :        0 
   --  456 : furnt8                   : Parameter_Integer  : Integer              :        0 
   --  457 : intntnt1                 : Parameter_Integer  : Integer              :        0 
   --  458 : intntnt2                 : Parameter_Integer  : Integer              :        0 
   --  459 : intntnt3                 : Parameter_Integer  : Integer              :        0 
   --  460 : intntnt4                 : Parameter_Integer  : Integer              :        0 
   --  461 : intntnt5                 : Parameter_Integer  : Integer              :        0 
   --  462 : intntnt6                 : Parameter_Integer  : Integer              :        0 
   --  463 : intntnt7                 : Parameter_Integer  : Integer              :        0 
   --  464 : intntnt8                 : Parameter_Integer  : Integer              :        0 
   --  465 : intrnet                  : Parameter_Integer  : Integer              :        0 
   --  466 : meal                     : Parameter_Integer  : Integer              :        0 
   --  467 : oadep2                   : Parameter_Integer  : Integer              :        0 
   --  468 : oadp2nt1                 : Parameter_Integer  : Integer              :        0 
   --  469 : oadp2nt2                 : Parameter_Integer  : Integer              :        0 
   --  470 : oadp2nt3                 : Parameter_Integer  : Integer              :        0 
   --  471 : oadp2nt4                 : Parameter_Integer  : Integer              :        0 
   --  472 : oadp2nt5                 : Parameter_Integer  : Integer              :        0 
   --  473 : oadp2nt6                 : Parameter_Integer  : Integer              :        0 
   --  474 : oadp2nt7                 : Parameter_Integer  : Integer              :        0 
   --  475 : oadp2nt8                 : Parameter_Integer  : Integer              :        0 
   --  476 : oafur                    : Parameter_Integer  : Integer              :        0 
   --  477 : oaintern                 : Parameter_Integer  : Integer              :        0 
   --  478 : shoe                     : Parameter_Integer  : Integer              :        0 
   --  479 : shoent1                  : Parameter_Integer  : Integer              :        0 
   --  480 : shoent2                  : Parameter_Integer  : Integer              :        0 
   --  481 : shoent3                  : Parameter_Integer  : Integer              :        0 
   --  482 : shoent4                  : Parameter_Integer  : Integer              :        0 
   --  483 : shoent5                  : Parameter_Integer  : Integer              :        0 
   --  484 : shoent6                  : Parameter_Integer  : Integer              :        0 
   --  485 : shoent7                  : Parameter_Integer  : Integer              :        0 
   --  486 : shoent8                  : Parameter_Integer  : Integer              :        0 
   --  487 : shoeoa                   : Parameter_Integer  : Integer              :        0 
   --  488 : nbunirbn                 : Parameter_Integer  : Integer              :        0 
   --  489 : nbuothbn                 : Parameter_Integer  : Integer              :        0 
   --  490 : debt13                   : Parameter_Integer  : Integer              :        0 
   --  491 : debtar13                 : Parameter_Integer  : Integer              :        0 
   --  492 : euchbook                 : Parameter_Integer  : Integer              :        0 
   --  493 : euchclth                 : Parameter_Integer  : Integer              :        0 
   --  494 : euchgame                 : Parameter_Integer  : Integer              :        0 
   --  495 : euchmeat                 : Parameter_Integer  : Integer              :        0 
   --  496 : euchshoe                 : Parameter_Integer  : Integer              :        0 
   --  497 : eupbtran                 : Parameter_Integer  : Integer              :        0 
   --  498 : eupbtrn1                 : Parameter_Integer  : Integer              :        0 
   --  499 : eupbtrn2                 : Parameter_Integer  : Integer              :        0 
   --  500 : eupbtrn3                 : Parameter_Integer  : Integer              :        0 
   --  501 : eupbtrn4                 : Parameter_Integer  : Integer              :        0 
   --  502 : eupbtrn5                 : Parameter_Integer  : Integer              :        0 
   --  503 : euroast                  : Parameter_Integer  : Integer              :        0 
   --  504 : eusmeal                  : Parameter_Integer  : Integer              :        0 
   --  505 : eustudy                  : Parameter_Integer  : Integer              :        0 
   --  506 : bueth                    : Parameter_Integer  : Integer              :        0 
   --  507 : oaeusmea                 : Parameter_Integer  : Integer              :        0 
   --  508 : oaholb                   : Parameter_Integer  : Integer              :        0 
   --  509 : oaroast                  : Parameter_Integer  : Integer              :        0 
   --  510 : ecostab2                 : Parameter_Integer  : Integer              :        0 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 5, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Benunit_IO;
