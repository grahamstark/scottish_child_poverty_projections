--
-- Created by ada_generator.py on 2017-09-14 11:23:40.135361
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

package Ukds.Frs.Job_IO is
  
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
   function Next_Free_jobtype( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_job match the defaults in Ukds.Frs.Null_Job
   --
   function Is_Null( a_job : Job ) return Boolean;
   
   --
   -- returns the single a_job matching the primary key fields, or the Ukds.Frs.Null_Job record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; jobtype : Integer; connection : Database_Connection := null ) return Ukds.Frs.Job;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; jobtype : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Job matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Job_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Job retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Job_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_job : Ukds.Frs.Job; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Job
   --
   procedure Delete( a_job : in out Ukds.Frs.Job; connection : Database_Connection := null );
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
   procedure Add_jobtype( c : in out d.Criteria; jobtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_agreehrs( c : in out d.Criteria; agreehrs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonamt1( c : in out d.Criteria; bonamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonamt2( c : in out d.Criteria; bonamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonamt3( c : in out d.Criteria; bonamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonamt4( c : in out d.Criteria; bonamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonamt5( c : in out d.Criteria; bonamt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonamt6( c : in out d.Criteria; bonamt6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontax1( c : in out d.Criteria; bontax1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontax2( c : in out d.Criteria; bontax2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontax3( c : in out d.Criteria; bontax3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontax4( c : in out d.Criteria; bontax4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontax5( c : in out d.Criteria; bontax5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontax6( c : in out d.Criteria; bontax6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bonus( c : in out d.Criteria; bonus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_busaccts( c : in out d.Criteria; busaccts : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_checktax( c : in out d.Criteria; checktax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkincom( c : in out d.Criteria; chkincom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dedoth( c : in out d.Criteria; dedoth : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc1( c : in out d.Criteria; deduc1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc2( c : in out d.Criteria; deduc2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc3( c : in out d.Criteria; deduc3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc4( c : in out d.Criteria; deduc4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc5( c : in out d.Criteria; deduc5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc6( c : in out d.Criteria; deduc6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc7( c : in out d.Criteria; deduc7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc8( c : in out d.Criteria; deduc8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dirctr( c : in out d.Criteria; dirctr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dirni( c : in out d.Criteria; dirni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvtothru( c : in out d.Criteria; dvtothru : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvushr( c : in out d.Criteria; dvushr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empany( c : in out d.Criteria; empany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empown( c : in out d.Criteria; empown : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_etype( c : in out d.Criteria; etype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_everot( c : in out d.Criteria; everot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ftpt( c : in out d.Criteria; ftpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grsofar( c : in out d.Criteria; grsofar : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grwage( c : in out d.Criteria; grwage : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grwagpd( c : in out d.Criteria; grwagpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hha1( c : in out d.Criteria; hha1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hha2( c : in out d.Criteria; hha2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hha3( c : in out d.Criteria; hha3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhc1( c : in out d.Criteria; hhc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhc2( c : in out d.Criteria; hhc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hhc3( c : in out d.Criteria; hhc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hohinc( c : in out d.Criteria; hohinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay1( c : in out d.Criteria; inclpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay2( c : in out d.Criteria; inclpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay3( c : in out d.Criteria; inclpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay4( c : in out d.Criteria; inclpay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay5( c : in out d.Criteria; inclpay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay6( c : in out d.Criteria; inclpay6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind01( c : in out d.Criteria; inkind01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind02( c : in out d.Criteria; inkind02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind03( c : in out d.Criteria; inkind03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind04( c : in out d.Criteria; inkind04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind05( c : in out d.Criteria; inkind05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind06( c : in out d.Criteria; inkind06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind07( c : in out d.Criteria; inkind07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind08( c : in out d.Criteria; inkind08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind09( c : in out d.Criteria; inkind09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind10( c : in out d.Criteria; inkind10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind11( c : in out d.Criteria; inkind11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_instype1( c : in out d.Criteria; instype1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_instype2( c : in out d.Criteria; instype2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jobbus( c : in out d.Criteria; jobbus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_likehr( c : in out d.Criteria; likehr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mademp( c : in out d.Criteria; mademp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_matemp( c : in out d.Criteria; matemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_matstp( c : in out d.Criteria; matstp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mileamt( c : in out d.Criteria; mileamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_motamt( c : in out d.Criteria; motamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natins( c : in out d.Criteria; natins : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nature( c : in out d.Criteria; nature : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nidamt( c : in out d.Criteria; nidamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nidpd( c : in out d.Criteria; nidpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nmchc( c : in out d.Criteria; nmchc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nmper( c : in out d.Criteria; nmper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nomor1( c : in out d.Criteria; nomor1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nomor2( c : in out d.Criteria; nomor2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nomor3( c : in out d.Criteria; nomor3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numemp( c : in out d.Criteria; numemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded1( c : in out d.Criteria; othded1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded2( c : in out d.Criteria; othded2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded3( c : in out d.Criteria; othded3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded4( c : in out d.Criteria; othded4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded5( c : in out d.Criteria; othded5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded6( c : in out d.Criteria; othded6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded7( c : in out d.Criteria; othded7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded8( c : in out d.Criteria; othded8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded9( c : in out d.Criteria; othded9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ownamt( c : in out d.Criteria; ownamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ownotamt( c : in out d.Criteria; ownotamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ownother( c : in out d.Criteria; ownother : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ownsum( c : in out d.Criteria; ownsum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_payamt( c : in out d.Criteria; payamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_paydat( c : in out d.Criteria; paydat : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_paye( c : in out d.Criteria; paye : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_paypd( c : in out d.Criteria; paypd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_payslip( c : in out d.Criteria; payslip : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_payusl( c : in out d.Criteria; payusl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pothr( c : in out d.Criteria; pothr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prbefore( c : in out d.Criteria; prbefore : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_profdocs( c : in out d.Criteria; profdocs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_profit1( c : in out d.Criteria; profit1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_profit2( c : in out d.Criteria; profit2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_profni( c : in out d.Criteria; profni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_proftax( c : in out d.Criteria; proftax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rspoth( c : in out d.Criteria; rspoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_se1( c : in out d.Criteria; se1 : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_se2( c : in out d.Criteria; se2 : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seend( c : in out d.Criteria; seend : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seincamt( c : in out d.Criteria; seincamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seincwm( c : in out d.Criteria; seincwm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_selwks( c : in out d.Criteria; selwks : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seniiamt( c : in out d.Criteria; seniiamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seniinc( c : in out d.Criteria; seniinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_senilamt( c : in out d.Criteria; senilamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_senilump( c : in out d.Criteria; senilump : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seniramt( c : in out d.Criteria; seniramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_senireg( c : in out d.Criteria; senireg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_senirpd( c : in out d.Criteria; senirpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_setax( c : in out d.Criteria; setax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_setaxamt( c : in out d.Criteria; setaxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_smpamt( c : in out d.Criteria; smpamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_smprate( c : in out d.Criteria; smprate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sole( c : in out d.Criteria; sole : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sspamt( c : in out d.Criteria; sspamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxamt( c : in out d.Criteria; taxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxdamt( c : in out d.Criteria; taxdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxdpd( c : in out d.Criteria; taxdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totus1( c : in out d.Criteria; totus1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ubonamt( c : in out d.Criteria; ubonamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uboninc( c : in out d.Criteria; uboninc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc1( c : in out d.Criteria; udeduc1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc2( c : in out d.Criteria; udeduc2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc3( c : in out d.Criteria; udeduc3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc4( c : in out d.Criteria; udeduc4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc5( c : in out d.Criteria; udeduc5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc6( c : in out d.Criteria; udeduc6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc7( c : in out d.Criteria; udeduc7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc8( c : in out d.Criteria; udeduc8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ugross( c : in out d.Criteria; ugross : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay1( c : in out d.Criteria; uincpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay2( c : in out d.Criteria; uincpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay3( c : in out d.Criteria; uincpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay4( c : in out d.Criteria; uincpay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay5( c : in out d.Criteria; uincpay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay6( c : in out d.Criteria; uincpay6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_umileamt( c : in out d.Criteria; umileamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_umotamt( c : in out d.Criteria; umotamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_unett( c : in out d.Criteria; unett : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded1( c : in out d.Criteria; uothded1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded2( c : in out d.Criteria; uothded2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded3( c : in out d.Criteria; uothded3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded4( c : in out d.Criteria; uothded4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded5( c : in out d.Criteria; uothded5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded6( c : in out d.Criteria; uothded6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded7( c : in out d.Criteria; uothded7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded8( c : in out d.Criteria; uothded8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothded9( c : in out d.Criteria; uothded9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothdtot( c : in out d.Criteria; uothdtot : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothr( c : in out d.Criteria; uothr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_upd( c : in out d.Criteria; upd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usmpamt( c : in out d.Criteria; usmpamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usmprate( c : in out d.Criteria; usmprate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usspamt( c : in out d.Criteria; usspamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usuhr( c : in out d.Criteria; usuhr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_utaxamt( c : in out d.Criteria; utaxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watdid( c : in out d.Criteria; watdid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_watprev( c : in out d.Criteria; watprev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_x_where( c : in out d.Criteria; x_where : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynopro( c : in out d.Criteria; whynopro : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou01( c : in out d.Criteria; whynou01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou02( c : in out d.Criteria; whynou02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou03( c : in out d.Criteria; whynou03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou04( c : in out d.Criteria; whynou04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou05( c : in out d.Criteria; whynou05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou06( c : in out d.Criteria; whynou06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou07( c : in out d.Criteria; whynou07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou08( c : in out d.Criteria; whynou08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou09( c : in out d.Criteria; whynou09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou10( c : in out d.Criteria; whynou10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou11( c : in out d.Criteria; whynou11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_workacc( c : in out d.Criteria; workacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_workmth( c : in out d.Criteria; workmth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_workyr( c : in out d.Criteria; workyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdqhrs( c : in out d.Criteria; hdqhrs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jobhours( c : in out d.Criteria; jobhours : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sspsmpfg( c : in out d.Criteria; sspsmpfg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ugrspay( c : in out d.Criteria; ugrspay : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ugrspay( c : in out d.Criteria; ugrspay : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay7( c : in out d.Criteria; inclpay7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inclpay8( c : in out d.Criteria; inclpay8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_paperiod( c : in out d.Criteria; paperiod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ppperiod( c : in out d.Criteria; ppperiod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sapamt( c : in out d.Criteria; sapamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sppamt( c : in out d.Criteria; sppamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay7( c : in out d.Criteria; uincpay7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uincpay8( c : in out d.Criteria; uincpay8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usapamt( c : in out d.Criteria; usapamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_usppamt( c : in out d.Criteria; usppamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind12( c : in out d.Criteria; inkind12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inkind13( c : in out d.Criteria; inkind13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_salsac( c : in out d.Criteria; salsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chvamt( c : in out d.Criteria; chvamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chvpd( c : in out d.Criteria; chvpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chvsac( c : in out d.Criteria; chvsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chvuamt( c : in out d.Criteria; chvuamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chvupd( c : in out d.Criteria; chvupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chvusu( c : in out d.Criteria; chvusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben01( c : in out d.Criteria; expben01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben02( c : in out d.Criteria; expben02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben03( c : in out d.Criteria; expben03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben04( c : in out d.Criteria; expben04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben05( c : in out d.Criteria; expben05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben06( c : in out d.Criteria; expben06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben07( c : in out d.Criteria; expben07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben08( c : in out d.Criteria; expben08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben09( c : in out d.Criteria; expben09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben10( c : in out d.Criteria; expben10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben11( c : in out d.Criteria; expben11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_expben12( c : in out d.Criteria; expben12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fuelamt( c : in out d.Criteria; fuelamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fuelbn( c : in out d.Criteria; fuelbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fuelpd( c : in out d.Criteria; fuelpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fueluamt( c : in out d.Criteria; fueluamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fuelupd( c : in out d.Criteria; fuelupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fuelusu( c : in out d.Criteria; fuelusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prevmth( c : in out d.Criteria; prevmth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prevyr( c : in out d.Criteria; prevyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnamt( c : in out d.Criteria; spnamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnpd( c : in out d.Criteria; spnpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnsac( c : in out d.Criteria; spnsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnuamt( c : in out d.Criteria; spnuamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnupd( c : in out d.Criteria; spnupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnusu( c : in out d.Criteria; spnusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vchamt( c : in out d.Criteria; vchamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vchpd( c : in out d.Criteria; vchpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vchsac( c : in out d.Criteria; vchsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vchuamt( c : in out d.Criteria; vchuamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vchupd( c : in out d.Criteria; vchupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_vchusu( c : in out d.Criteria; vchusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wrkprev( c : in out d.Criteria; wrkprev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_caramt( c : in out d.Criteria; caramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carcon( c : in out d.Criteria; carcon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carval( c : in out d.Criteria; carval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fueltyp( c : in out d.Criteria; fueltyp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_orgemp( c : in out d.Criteria; orgemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sector( c : in out d.Criteria; sector : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sectrnp( c : in out d.Criteria; sectrnp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou12( c : in out d.Criteria; whynou12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou13( c : in out d.Criteria; whynou13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whynou14( c : in out d.Criteria; whynou14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jobsect( c : in out d.Criteria; jobsect : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oremp( c : in out d.Criteria; oremp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontxam1( c : in out d.Criteria; bontxam1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontxam2( c : in out d.Criteria; bontxam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontxam3( c : in out d.Criteria; bontxam3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontxam4( c : in out d.Criteria; bontxam4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontxam5( c : in out d.Criteria; bontxam5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bontxam6( c : in out d.Criteria; bontxam6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_deduc9( c : in out d.Criteria; deduc9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emplany( c : in out d.Criteria; emplany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empten( c : in out d.Criteria; empten : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lthan30( c : in out d.Criteria; lthan30 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numeten( c : in out d.Criteria; numeten : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded01( c : in out d.Criteria; othded01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded02( c : in out d.Criteria; othded02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded03( c : in out d.Criteria; othded03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded04( c : in out d.Criteria; othded04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded05( c : in out d.Criteria; othded05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded06( c : in out d.Criteria; othded06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded07( c : in out d.Criteria; othded07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded08( c : in out d.Criteria; othded08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded09( c : in out d.Criteria; othded09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othded10( c : in out d.Criteria; othded10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_udeduc9( c : in out d.Criteria; udeduc9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde01( c : in out d.Criteria; uothde01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde02( c : in out d.Criteria; uothde02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde03( c : in out d.Criteria; uothde03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde04( c : in out d.Criteria; uothde04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde05( c : in out d.Criteria; uothde05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde06( c : in out d.Criteria; uothde06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde07( c : in out d.Criteria; uothde07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde08( c : in out d.Criteria; uothde08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde09( c : in out d.Criteria; uothde09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uothde10( c : in out d.Criteria; uothde10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_yjbchang( c : in out d.Criteria; yjbchang : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jbchnge( c : in out d.Criteria; jbchnge : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourly( c : in out d.Criteria; hourly : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexa( c : in out d.Criteria; hrexa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexb( c : in out d.Criteria; hrexb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc1( c : in out d.Criteria; hrexc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc2( c : in out d.Criteria; hrexc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc3( c : in out d.Criteria; hrexc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc4( c : in out d.Criteria; hrexc4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc5( c : in out d.Criteria; hrexc5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc6( c : in out d.Criteria; hrexc6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc7( c : in out d.Criteria; hrexc7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrexc8( c : in out d.Criteria; hrexc8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrrate( c : in out d.Criteria; hrrate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
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
   procedure Add_jobtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_agreehrs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonamt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonamt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontax1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontax2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontax3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontax4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontax5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontax6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bonus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_busaccts_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_checktax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkincom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dedoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dirctr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dirni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvtothru_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvushr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empown_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_etype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_everot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ftpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grsofar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grwage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grwagpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hha1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hha2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hha3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hhc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hohinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_instype1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_instype2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jobbus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_likehr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mademp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_matemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_matstp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mileamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_motamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nature_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nidamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nidpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nmchc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nmper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nomor1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nomor2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nomor3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ownamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ownotamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ownother_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ownsum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_payamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_paydat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_paye_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_paypd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_payslip_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_payusl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pothr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prbefore_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_profdocs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_profit1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_profit2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_profni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_proftax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rspoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_se1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_se2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seincamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seincwm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_selwks_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seniiamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seniinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_senilamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_senilump_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seniramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_senireg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_senirpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_setax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_setaxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_smpamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_smprate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sole_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sspamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totus1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ubonamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uboninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ugross_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_umileamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_umotamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_unett_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothded9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothdtot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_upd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usmpamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usmprate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usspamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usuhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_utaxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watdid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_watprev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_x_where_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynopro_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_workacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_workmth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_workyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdqhrs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jobhours_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sspsmpfg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ugrspay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inclpay8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_paperiod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ppperiod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sapamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sppamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uincpay8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usapamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_usppamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inkind13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_salsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chvamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chvpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chvsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chvuamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chvupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chvusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_expben12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fuelamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fuelbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fuelpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fueluamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fuelupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fuelusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prevmth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prevyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnuamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vchamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vchpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vchsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vchuamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vchupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_vchusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wrkprev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_caramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carcon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fueltyp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_orgemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sector_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sectrnp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whynou14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jobsect_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oremp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontxam1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontxam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontxam3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontxam4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontxam5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bontxam6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_deduc9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emplany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empten_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lthan30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numeten_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othded10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_udeduc9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uothde10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_yjbchang_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jbchnge_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourly_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrexc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrrate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Job;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 310, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    7 : person                   : Parameter_Integer  : Integer              :        0 
   --    8 : jobtype                  : Parameter_Integer  : Integer              :        0 
   --    9 : agreehrs                 : Parameter_Integer  : Integer              :        0 
   --   10 : bonamt1                  : Parameter_Float    : Amount               :      0.0 
   --   11 : bonamt2                  : Parameter_Float    : Amount               :      0.0 
   --   12 : bonamt3                  : Parameter_Float    : Amount               :      0.0 
   --   13 : bonamt4                  : Parameter_Float    : Amount               :      0.0 
   --   14 : bonamt5                  : Parameter_Float    : Amount               :      0.0 
   --   15 : bonamt6                  : Parameter_Float    : Amount               :      0.0 
   --   16 : bontax1                  : Parameter_Integer  : Integer              :        0 
   --   17 : bontax2                  : Parameter_Integer  : Integer              :        0 
   --   18 : bontax3                  : Parameter_Integer  : Integer              :        0 
   --   19 : bontax4                  : Parameter_Integer  : Integer              :        0 
   --   20 : bontax5                  : Parameter_Integer  : Integer              :        0 
   --   21 : bontax6                  : Parameter_Integer  : Integer              :        0 
   --   22 : bonus                    : Parameter_Integer  : Integer              :        0 
   --   23 : busaccts                 : Parameter_Integer  : Integer              :        0 
   --   24 : checktax                 : Parameter_Integer  : Integer              :        0 
   --   25 : chkincom                 : Parameter_Integer  : Integer              :        0 
   --   26 : dedoth                   : Parameter_Float    : Amount               :      0.0 
   --   27 : deduc1                   : Parameter_Float    : Amount               :      0.0 
   --   28 : deduc2                   : Parameter_Float    : Amount               :      0.0 
   --   29 : deduc3                   : Parameter_Float    : Amount               :      0.0 
   --   30 : deduc4                   : Parameter_Float    : Amount               :      0.0 
   --   31 : deduc5                   : Parameter_Float    : Amount               :      0.0 
   --   32 : deduc6                   : Parameter_Float    : Amount               :      0.0 
   --   33 : deduc7                   : Parameter_Float    : Amount               :      0.0 
   --   34 : deduc8                   : Parameter_Float    : Amount               :      0.0 
   --   35 : dirctr                   : Parameter_Integer  : Integer              :        0 
   --   36 : dirni                    : Parameter_Integer  : Integer              :        0 
   --   37 : dvtothru                 : Parameter_Integer  : Integer              :        0 
   --   38 : dvushr                   : Parameter_Float    : Amount               :      0.0 
   --   39 : empany                   : Parameter_Integer  : Integer              :        0 
   --   40 : empown                   : Parameter_Integer  : Integer              :        0 
   --   41 : etype                    : Parameter_Integer  : Integer              :        0 
   --   42 : everot                   : Parameter_Integer  : Integer              :        0 
   --   43 : ftpt                     : Parameter_Integer  : Integer              :        0 
   --   44 : grsofar                  : Parameter_Float    : Amount               :      0.0 
   --   45 : grwage                   : Parameter_Float    : Amount               :      0.0 
   --   46 : grwagpd                  : Parameter_Integer  : Integer              :        0 
   --   47 : hha1                     : Parameter_Float    : Amount               :      0.0 
   --   48 : hha2                     : Parameter_Float    : Amount               :      0.0 
   --   49 : hha3                     : Parameter_Float    : Amount               :      0.0 
   --   50 : hhc1                     : Parameter_Integer  : Integer              :        0 
   --   51 : hhc2                     : Parameter_Integer  : Integer              :        0 
   --   52 : hhc3                     : Parameter_Integer  : Integer              :        0 
   --   53 : hohinc                   : Parameter_Integer  : Integer              :        0 
   --   54 : inclpay1                 : Parameter_Integer  : Integer              :        0 
   --   55 : inclpay2                 : Parameter_Integer  : Integer              :        0 
   --   56 : inclpay3                 : Parameter_Integer  : Integer              :        0 
   --   57 : inclpay4                 : Parameter_Integer  : Integer              :        0 
   --   58 : inclpay5                 : Parameter_Integer  : Integer              :        0 
   --   59 : inclpay6                 : Parameter_Integer  : Integer              :        0 
   --   60 : inkind01                 : Parameter_Integer  : Integer              :        0 
   --   61 : inkind02                 : Parameter_Integer  : Integer              :        0 
   --   62 : inkind03                 : Parameter_Integer  : Integer              :        0 
   --   63 : inkind04                 : Parameter_Integer  : Integer              :        0 
   --   64 : inkind05                 : Parameter_Integer  : Integer              :        0 
   --   65 : inkind06                 : Parameter_Integer  : Integer              :        0 
   --   66 : inkind07                 : Parameter_Integer  : Integer              :        0 
   --   67 : inkind08                 : Parameter_Integer  : Integer              :        0 
   --   68 : inkind09                 : Parameter_Integer  : Integer              :        0 
   --   69 : inkind10                 : Parameter_Integer  : Integer              :        0 
   --   70 : inkind11                 : Parameter_Integer  : Integer              :        0 
   --   71 : instype1                 : Parameter_Integer  : Integer              :        0 
   --   72 : instype2                 : Parameter_Integer  : Integer              :        0 
   --   73 : jobbus                   : Parameter_Integer  : Integer              :        0 
   --   74 : likehr                   : Parameter_Integer  : Integer              :        0 
   --   75 : mademp                   : Parameter_Integer  : Integer              :        0 
   --   76 : matemp                   : Parameter_Integer  : Integer              :        0 
   --   77 : matstp                   : Parameter_Integer  : Integer              :        0 
   --   78 : mileamt                  : Parameter_Float    : Amount               :      0.0 
   --   79 : motamt                   : Parameter_Float    : Amount               :      0.0 
   --   80 : natins                   : Parameter_Float    : Amount               :      0.0 
   --   81 : nature                   : Parameter_Integer  : Integer              :        0 
   --   82 : nidamt                   : Parameter_Float    : Amount               :      0.0 
   --   83 : nidpd                    : Parameter_Integer  : Integer              :        0 
   --   84 : nmchc                    : Parameter_Integer  : Integer              :        0 
   --   85 : nmper                    : Parameter_Integer  : Integer              :        0 
   --   86 : nomor1                   : Parameter_Integer  : Integer              :        0 
   --   87 : nomor2                   : Parameter_Integer  : Integer              :        0 
   --   88 : nomor3                   : Parameter_Integer  : Integer              :        0 
   --   89 : numemp                   : Parameter_Integer  : Integer              :        0 
   --   90 : othded1                  : Parameter_Integer  : Integer              :        0 
   --   91 : othded2                  : Parameter_Integer  : Integer              :        0 
   --   92 : othded3                  : Parameter_Integer  : Integer              :        0 
   --   93 : othded4                  : Parameter_Integer  : Integer              :        0 
   --   94 : othded5                  : Parameter_Integer  : Integer              :        0 
   --   95 : othded6                  : Parameter_Integer  : Integer              :        0 
   --   96 : othded7                  : Parameter_Integer  : Integer              :        0 
   --   97 : othded8                  : Parameter_Integer  : Integer              :        0 
   --   98 : othded9                  : Parameter_Integer  : Integer              :        0 
   --   99 : ownamt                   : Parameter_Float    : Amount               :      0.0 
   --  100 : ownotamt                 : Parameter_Float    : Amount               :      0.0 
   --  101 : ownother                 : Parameter_Integer  : Integer              :        0 
   --  102 : ownsum                   : Parameter_Integer  : Integer              :        0 
   --  103 : payamt                   : Parameter_Float    : Amount               :      0.0 
   --  104 : paydat                   : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  105 : paye                     : Parameter_Float    : Amount               :      0.0 
   --  106 : paypd                    : Parameter_Integer  : Integer              :        0 
   --  107 : payslip                  : Parameter_Integer  : Integer              :        0 
   --  108 : payusl                   : Parameter_Integer  : Integer              :        0 
   --  109 : pothr                    : Parameter_Float    : Amount               :      0.0 
   --  110 : prbefore                 : Parameter_Float    : Amount               :      0.0 
   --  111 : profdocs                 : Parameter_Integer  : Integer              :        0 
   --  112 : profit1                  : Parameter_Float    : Amount               :      0.0 
   --  113 : profit2                  : Parameter_Integer  : Integer              :        0 
   --  114 : profni                   : Parameter_Integer  : Integer              :        0 
   --  115 : proftax                  : Parameter_Integer  : Integer              :        0 
   --  116 : rspoth                   : Parameter_Integer  : Integer              :        0 
   --  117 : se1                      : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  118 : se2                      : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  119 : seend                    : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  120 : seincamt                 : Parameter_Float    : Amount               :      0.0 
   --  121 : seincwm                  : Parameter_Integer  : Integer              :        0 
   --  122 : selwks                   : Parameter_Integer  : Integer              :        0 
   --  123 : seniiamt                 : Parameter_Float    : Amount               :      0.0 
   --  124 : seniinc                  : Parameter_Integer  : Integer              :        0 
   --  125 : senilamt                 : Parameter_Float    : Amount               :      0.0 
   --  126 : senilump                 : Parameter_Integer  : Integer              :        0 
   --  127 : seniramt                 : Parameter_Float    : Amount               :      0.0 
   --  128 : senireg                  : Parameter_Integer  : Integer              :        0 
   --  129 : senirpd                  : Parameter_Integer  : Integer              :        0 
   --  130 : setax                    : Parameter_Integer  : Integer              :        0 
   --  131 : setaxamt                 : Parameter_Float    : Amount               :      0.0 
   --  132 : smpamt                   : Parameter_Float    : Amount               :      0.0 
   --  133 : smprate                  : Parameter_Integer  : Integer              :        0 
   --  134 : sole                     : Parameter_Integer  : Integer              :        0 
   --  135 : sspamt                   : Parameter_Float    : Amount               :      0.0 
   --  136 : taxamt                   : Parameter_Float    : Amount               :      0.0 
   --  137 : taxdamt                  : Parameter_Float    : Amount               :      0.0 
   --  138 : taxdpd                   : Parameter_Integer  : Integer              :        0 
   --  139 : totus1                   : Parameter_Float    : Amount               :      0.0 
   --  140 : ubonamt                  : Parameter_Float    : Amount               :      0.0 
   --  141 : uboninc                  : Parameter_Integer  : Integer              :        0 
   --  142 : udeduc1                  : Parameter_Float    : Amount               :      0.0 
   --  143 : udeduc2                  : Parameter_Float    : Amount               :      0.0 
   --  144 : udeduc3                  : Parameter_Float    : Amount               :      0.0 
   --  145 : udeduc4                  : Parameter_Float    : Amount               :      0.0 
   --  146 : udeduc5                  : Parameter_Float    : Amount               :      0.0 
   --  147 : udeduc6                  : Parameter_Float    : Amount               :      0.0 
   --  148 : udeduc7                  : Parameter_Float    : Amount               :      0.0 
   --  149 : udeduc8                  : Parameter_Float    : Amount               :      0.0 
   --  150 : ugross                   : Parameter_Float    : Amount               :      0.0 
   --  151 : uincpay1                 : Parameter_Integer  : Integer              :        0 
   --  152 : uincpay2                 : Parameter_Integer  : Integer              :        0 
   --  153 : uincpay3                 : Parameter_Integer  : Integer              :        0 
   --  154 : uincpay4                 : Parameter_Integer  : Integer              :        0 
   --  155 : uincpay5                 : Parameter_Integer  : Integer              :        0 
   --  156 : uincpay6                 : Parameter_Integer  : Integer              :        0 
   --  157 : umileamt                 : Parameter_Float    : Amount               :      0.0 
   --  158 : umotamt                  : Parameter_Float    : Amount               :      0.0 
   --  159 : unett                    : Parameter_Float    : Amount               :      0.0 
   --  160 : uothded1                 : Parameter_Integer  : Integer              :        0 
   --  161 : uothded2                 : Parameter_Integer  : Integer              :        0 
   --  162 : uothded3                 : Parameter_Integer  : Integer              :        0 
   --  163 : uothded4                 : Parameter_Integer  : Integer              :        0 
   --  164 : uothded5                 : Parameter_Integer  : Integer              :        0 
   --  165 : uothded6                 : Parameter_Integer  : Integer              :        0 
   --  166 : uothded7                 : Parameter_Integer  : Integer              :        0 
   --  167 : uothded8                 : Parameter_Integer  : Integer              :        0 
   --  168 : uothded9                 : Parameter_Integer  : Integer              :        0 
   --  169 : uothdtot                 : Parameter_Float    : Amount               :      0.0 
   --  170 : uothr                    : Parameter_Float    : Amount               :      0.0 
   --  171 : upd                      : Parameter_Integer  : Integer              :        0 
   --  172 : usmpamt                  : Parameter_Float    : Amount               :      0.0 
   --  173 : usmprate                 : Parameter_Integer  : Integer              :        0 
   --  174 : usspamt                  : Parameter_Float    : Amount               :      0.0 
   --  175 : usuhr                    : Parameter_Float    : Amount               :      0.0 
   --  176 : utaxamt                  : Parameter_Float    : Amount               :      0.0 
   --  177 : watdid                   : Parameter_Integer  : Integer              :        0 
   --  178 : watprev                  : Parameter_Integer  : Integer              :        0 
   --  179 : x_where                  : Parameter_Integer  : Integer              :        0 
   --  180 : whynopro                 : Parameter_Integer  : Integer              :        0 
   --  181 : whynou01                 : Parameter_Integer  : Integer              :        0 
   --  182 : whynou02                 : Parameter_Integer  : Integer              :        0 
   --  183 : whynou03                 : Parameter_Integer  : Integer              :        0 
   --  184 : whynou04                 : Parameter_Integer  : Integer              :        0 
   --  185 : whynou05                 : Parameter_Integer  : Integer              :        0 
   --  186 : whynou06                 : Parameter_Integer  : Integer              :        0 
   --  187 : whynou07                 : Parameter_Integer  : Integer              :        0 
   --  188 : whynou08                 : Parameter_Integer  : Integer              :        0 
   --  189 : whynou09                 : Parameter_Integer  : Integer              :        0 
   --  190 : whynou10                 : Parameter_Integer  : Integer              :        0 
   --  191 : whynou11                 : Parameter_Integer  : Integer              :        0 
   --  192 : workacc                  : Parameter_Integer  : Integer              :        0 
   --  193 : workmth                  : Parameter_Integer  : Integer              :        0 
   --  194 : workyr                   : Parameter_Integer  : Integer              :        0 
   --  195 : month                    : Parameter_Integer  : Integer              :        0 
   --  196 : hdqhrs                   : Parameter_Integer  : Integer              :        0 
   --  197 : jobhours                 : Parameter_Float    : Amount               :      0.0 
   --  198 : sspsmpfg                 : Parameter_Integer  : Integer              :        0 
   --  199 : ugrspay                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --  200 : inclpay7                 : Parameter_Integer  : Integer              :        0 
   --  201 : inclpay8                 : Parameter_Integer  : Integer              :        0 
   --  202 : paperiod                 : Parameter_Integer  : Integer              :        0 
   --  203 : ppperiod                 : Parameter_Integer  : Integer              :        0 
   --  204 : sapamt                   : Parameter_Float    : Amount               :      0.0 
   --  205 : sppamt                   : Parameter_Float    : Amount               :      0.0 
   --  206 : uincpay7                 : Parameter_Integer  : Integer              :        0 
   --  207 : uincpay8                 : Parameter_Integer  : Integer              :        0 
   --  208 : usapamt                  : Parameter_Integer  : Integer              :        0 
   --  209 : usppamt                  : Parameter_Float    : Amount               :      0.0 
   --  210 : inkind12                 : Parameter_Integer  : Integer              :        0 
   --  211 : inkind13                 : Parameter_Integer  : Integer              :        0 
   --  212 : salsac                   : Parameter_Integer  : Integer              :        0 
   --  213 : chvamt                   : Parameter_Float    : Amount               :      0.0 
   --  214 : chvpd                    : Parameter_Integer  : Integer              :        0 
   --  215 : chvsac                   : Parameter_Integer  : Integer              :        0 
   --  216 : chvuamt                  : Parameter_Float    : Amount               :      0.0 
   --  217 : chvupd                   : Parameter_Integer  : Integer              :        0 
   --  218 : chvusu                   : Parameter_Integer  : Integer              :        0 
   --  219 : expben01                 : Parameter_Integer  : Integer              :        0 
   --  220 : expben02                 : Parameter_Integer  : Integer              :        0 
   --  221 : expben03                 : Parameter_Integer  : Integer              :        0 
   --  222 : expben04                 : Parameter_Integer  : Integer              :        0 
   --  223 : expben05                 : Parameter_Integer  : Integer              :        0 
   --  224 : expben06                 : Parameter_Integer  : Integer              :        0 
   --  225 : expben07                 : Parameter_Integer  : Integer              :        0 
   --  226 : expben08                 : Parameter_Integer  : Integer              :        0 
   --  227 : expben09                 : Parameter_Integer  : Integer              :        0 
   --  228 : expben10                 : Parameter_Integer  : Integer              :        0 
   --  229 : expben11                 : Parameter_Integer  : Integer              :        0 
   --  230 : expben12                 : Parameter_Integer  : Integer              :        0 
   --  231 : fuelamt                  : Parameter_Float    : Amount               :      0.0 
   --  232 : fuelbn                   : Parameter_Integer  : Integer              :        0 
   --  233 : fuelpd                   : Parameter_Integer  : Integer              :        0 
   --  234 : fueluamt                 : Parameter_Float    : Amount               :      0.0 
   --  235 : fuelupd                  : Parameter_Integer  : Integer              :        0 
   --  236 : fuelusu                  : Parameter_Integer  : Integer              :        0 
   --  237 : issue                    : Parameter_Integer  : Integer              :        0 
   --  238 : prevmth                  : Parameter_Integer  : Integer              :        0 
   --  239 : prevyr                   : Parameter_Integer  : Integer              :        0 
   --  240 : spnamt                   : Parameter_Float    : Amount               :      0.0 
   --  241 : spnpd                    : Parameter_Integer  : Integer              :        0 
   --  242 : spnsac                   : Parameter_Integer  : Integer              :        0 
   --  243 : spnuamt                  : Parameter_Float    : Amount               :      0.0 
   --  244 : spnupd                   : Parameter_Integer  : Integer              :        0 
   --  245 : spnusu                   : Parameter_Integer  : Integer              :        0 
   --  246 : vchamt                   : Parameter_Float    : Amount               :      0.0 
   --  247 : vchpd                    : Parameter_Integer  : Integer              :        0 
   --  248 : vchsac                   : Parameter_Integer  : Integer              :        0 
   --  249 : vchuamt                  : Parameter_Integer  : Integer              :        0 
   --  250 : vchupd                   : Parameter_Integer  : Integer              :        0 
   --  251 : vchusu                   : Parameter_Integer  : Integer              :        0 
   --  252 : wrkprev                  : Parameter_Integer  : Integer              :        0 
   --  253 : caramt                   : Parameter_Float    : Amount               :      0.0 
   --  254 : carcon                   : Parameter_Integer  : Integer              :        0 
   --  255 : carval                   : Parameter_Integer  : Integer              :        0 
   --  256 : fueltyp                  : Parameter_Integer  : Integer              :        0 
   --  257 : orgemp                   : Parameter_Integer  : Integer              :        0 
   --  258 : sector                   : Parameter_Integer  : Integer              :        0 
   --  259 : sectrnp                  : Parameter_Integer  : Integer              :        0 
   --  260 : whynou12                 : Parameter_Integer  : Integer              :        0 
   --  261 : whynou13                 : Parameter_Integer  : Integer              :        0 
   --  262 : whynou14                 : Parameter_Integer  : Integer              :        0 
   --  263 : jobsect                  : Parameter_Integer  : Integer              :        0 
   --  264 : oremp                    : Parameter_Integer  : Integer              :        0 
   --  265 : bontxam1                 : Parameter_Float    : Amount               :      0.0 
   --  266 : bontxam2                 : Parameter_Float    : Amount               :      0.0 
   --  267 : bontxam3                 : Parameter_Float    : Amount               :      0.0 
   --  268 : bontxam4                 : Parameter_Float    : Amount               :      0.0 
   --  269 : bontxam5                 : Parameter_Float    : Amount               :      0.0 
   --  270 : bontxam6                 : Parameter_Float    : Amount               :      0.0 
   --  271 : deduc9                   : Parameter_Float    : Amount               :      0.0 
   --  272 : emplany                  : Parameter_Integer  : Integer              :        0 
   --  273 : empten                   : Parameter_Integer  : Integer              :        0 
   --  274 : lthan30                  : Parameter_Integer  : Integer              :        0 
   --  275 : numeten                  : Parameter_Integer  : Integer              :        0 
   --  276 : othded01                 : Parameter_Integer  : Integer              :        0 
   --  277 : othded02                 : Parameter_Integer  : Integer              :        0 
   --  278 : othded03                 : Parameter_Integer  : Integer              :        0 
   --  279 : othded04                 : Parameter_Integer  : Integer              :        0 
   --  280 : othded05                 : Parameter_Integer  : Integer              :        0 
   --  281 : othded06                 : Parameter_Integer  : Integer              :        0 
   --  282 : othded07                 : Parameter_Integer  : Integer              :        0 
   --  283 : othded08                 : Parameter_Integer  : Integer              :        0 
   --  284 : othded09                 : Parameter_Integer  : Integer              :        0 
   --  285 : othded10                 : Parameter_Integer  : Integer              :        0 
   --  286 : udeduc9                  : Parameter_Float    : Amount               :      0.0 
   --  287 : uothde01                 : Parameter_Integer  : Integer              :        0 
   --  288 : uothde02                 : Parameter_Integer  : Integer              :        0 
   --  289 : uothde03                 : Parameter_Integer  : Integer              :        0 
   --  290 : uothde04                 : Parameter_Integer  : Integer              :        0 
   --  291 : uothde05                 : Parameter_Integer  : Integer              :        0 
   --  292 : uothde06                 : Parameter_Integer  : Integer              :        0 
   --  293 : uothde07                 : Parameter_Integer  : Integer              :        0 
   --  294 : uothde08                 : Parameter_Integer  : Integer              :        0 
   --  295 : uothde09                 : Parameter_Integer  : Integer              :        0 
   --  296 : uothde10                 : Parameter_Integer  : Integer              :        0 
   --  297 : yjbchang                 : Parameter_Integer  : Integer              :        0 
   --  298 : jbchnge                  : Parameter_Integer  : Integer              :        0 
   --  299 : hourly                   : Parameter_Integer  : Integer              :        0 
   --  300 : hrexa                    : Parameter_Integer  : Integer              :        0 
   --  301 : hrexb                    : Parameter_Integer  : Integer              :        0 
   --  302 : hrexc1                   : Parameter_Integer  : Integer              :        0 
   --  303 : hrexc2                   : Parameter_Integer  : Integer              :        0 
   --  304 : hrexc3                   : Parameter_Integer  : Integer              :        0 
   --  305 : hrexc4                   : Parameter_Integer  : Integer              :        0 
   --  306 : hrexc5                   : Parameter_Integer  : Integer              :        0 
   --  307 : hrexc6                   : Parameter_Integer  : Integer              :        0 
   --  308 : hrexc7                   : Parameter_Integer  : Integer              :        0 
   --  309 : hrexc8                   : Parameter_Integer  : Integer              :        0 
   --  310 : hrrate                   : Parameter_Float    : Amount               :      0.0 
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
   --    8 : jobtype                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Job_IO;
