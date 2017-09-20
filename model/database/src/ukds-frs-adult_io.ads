--
-- Created by ada_generator.py on 2017-09-20 14:37:19.399417
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

package Ukds.Frs.Adult_IO is
  
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
   function Next_Free_benunit( connection : Database_Connection := null) return Integer;
   function Next_Free_person( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_adult match the defaults in Ukds.Frs.Null_Adult
   --
   function Is_Null( a_adult : Adult ) return Boolean;
   
   --
   -- returns the single a_adult matching the primary key fields, or the Ukds.Frs.Null_Adult record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Ukds.Frs.Adult;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Adult matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Adult_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Adult retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Adult_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_adult : Ukds.Frs.Adult; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Adult
   --
   procedure Delete( a_adult : in out Ukds.Frs.Adult; connection : Database_Connection := null );
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
   function Retrieve_Associated_Ukds_Frs_Penamts( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Penamt_List;
   function Retrieve_Associated_Ukds_Frs_Govpays( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Govpay_List;
   function Retrieve_Associated_Ukds_Frs_Assets( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Assets_List;
   function Retrieve_Associated_Ukds_Frs_Penprovs( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List;
   function Retrieve_Associated_Ukds_Frs_Maints( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Maint_List;
   function Retrieve_Associated_Ukds_Frs_Jobs( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Job_List;
   function Retrieve_Associated_Ukds_Frs_Childcares( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List;
   function Retrieve_Associated_Ukds_Frs_Pensions( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Pension_List;
   function Retrieve_Associated_Ukds_Frs_Accouts( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Accouts_List;
   function Retrieve_Associated_Ukds_Frs_Accounts( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Accounts_List;
   function Retrieve_Associated_Ukds_Frs_Oddjobs( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Oddjob_List;

   --
   -- functions to add something to a criteria
   --
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_abs1no( c : in out d.Criteria; abs1no : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_abs2no( c : in out d.Criteria; abs2no : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_abspar( c : in out d.Criteria; abspar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_abspay( c : in out d.Criteria; abspay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_abswhy( c : in out d.Criteria; abswhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_abswk( c : in out d.Criteria; abswk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_x_access( c : in out d.Criteria; x_access : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accftpt( c : in out d.Criteria; accftpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accjb( c : in out d.Criteria; accjb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accssamt( c : in out d.Criteria; accssamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accsspd( c : in out d.Criteria; accsspd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adeduc( c : in out d.Criteria; adeduc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adema( c : in out d.Criteria; adema : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ademaamt( c : in out d.Criteria; ademaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ademapd( c : in out d.Criteria; ademapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age( c : in out d.Criteria; age : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allow1( c : in out d.Criteria; allow1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allow2( c : in out d.Criteria; allow2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allow3( c : in out d.Criteria; allow3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allow4( c : in out d.Criteria; allow4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpay1( c : in out d.Criteria; allpay1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpay2( c : in out d.Criteria; allpay2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpay3( c : in out d.Criteria; allpay3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpay4( c : in out d.Criteria; allpay4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpd1( c : in out d.Criteria; allpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpd2( c : in out d.Criteria; allpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpd3( c : in out d.Criteria; allpd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_allpd4( c : in out d.Criteria; allpd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anyacc( c : in out d.Criteria; anyacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anyed( c : in out d.Criteria; anyed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anymon( c : in out d.Criteria; anymon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen1( c : in out d.Criteria; anypen1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen2( c : in out d.Criteria; anypen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen3( c : in out d.Criteria; anypen3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen4( c : in out d.Criteria; anypen4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen5( c : in out d.Criteria; anypen5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen6( c : in out d.Criteria; anypen6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anypen7( c : in out d.Criteria; anypen7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_apamt( c : in out d.Criteria; apamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_apdamt( c : in out d.Criteria; apdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_apdir( c : in out d.Criteria; apdir : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_apdpd( c : in out d.Criteria; apdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_appd( c : in out d.Criteria; appd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b2qfut1( c : in out d.Criteria; b2qfut1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b2qfut2( c : in out d.Criteria; b2qfut2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b2qfut3( c : in out d.Criteria; b2qfut3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut1( c : in out d.Criteria; b3qfut1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut2( c : in out d.Criteria; b3qfut2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut3( c : in out d.Criteria; b3qfut3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut4( c : in out d.Criteria; b3qfut4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut5( c : in out d.Criteria; b3qfut5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut6( c : in out d.Criteria; b3qfut6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q1( c : in out d.Criteria; ben1q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q2( c : in out d.Criteria; ben1q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q3( c : in out d.Criteria; ben1q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q4( c : in out d.Criteria; ben1q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q5( c : in out d.Criteria; ben1q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q6( c : in out d.Criteria; ben1q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben1q7( c : in out d.Criteria; ben1q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben2q1( c : in out d.Criteria; ben2q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben2q2( c : in out d.Criteria; ben2q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben2q3( c : in out d.Criteria; ben2q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q1( c : in out d.Criteria; ben3q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q2( c : in out d.Criteria; ben3q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q3( c : in out d.Criteria; ben3q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q4( c : in out d.Criteria; ben3q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q5( c : in out d.Criteria; ben3q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q6( c : in out d.Criteria; ben3q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben4q1( c : in out d.Criteria; ben4q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben4q2( c : in out d.Criteria; ben4q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben4q3( c : in out d.Criteria; ben4q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q1( c : in out d.Criteria; ben5q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q2( c : in out d.Criteria; ben5q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q3( c : in out d.Criteria; ben5q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q4( c : in out d.Criteria; ben5q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q5( c : in out d.Criteria; ben5q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q6( c : in out d.Criteria; ben5q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q1( c : in out d.Criteria; ben7q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q2( c : in out d.Criteria; ben7q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q3( c : in out d.Criteria; ben7q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q4( c : in out d.Criteria; ben7q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q5( c : in out d.Criteria; ben7q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q6( c : in out d.Criteria; ben7q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q7( c : in out d.Criteria; ben7q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q8( c : in out d.Criteria; ben7q8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben7q9( c : in out d.Criteria; ben7q9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_btwacc( c : in out d.Criteria; btwacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claimant( c : in out d.Criteria; claimant : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cohabit( c : in out d.Criteria; cohabit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_combid( c : in out d.Criteria; combid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_convbl( c : in out d.Criteria; convbl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctclum1( c : in out d.Criteria; ctclum1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctclum2( c : in out d.Criteria; ctclum2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cupchk( c : in out d.Criteria; cupchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cvht( c : in out d.Criteria; cvht : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cvpay( c : in out d.Criteria; cvpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cvpd( c : in out d.Criteria; cvpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dentist( c : in out d.Criteria; dentist : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_depend( c : in out d.Criteria; depend : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif1( c : in out d.Criteria; disdif1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif2( c : in out d.Criteria; disdif2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif3( c : in out d.Criteria; disdif3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif4( c : in out d.Criteria; disdif4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif5( c : in out d.Criteria; disdif5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif6( c : in out d.Criteria; disdif6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif7( c : in out d.Criteria; disdif7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif8( c : in out d.Criteria; disdif8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dob( c : in out d.Criteria; dob : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dptcboth( c : in out d.Criteria; dptcboth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dptclum( c : in out d.Criteria; dptclum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvil03a( c : in out d.Criteria; dvil03a : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvil04a( c : in out d.Criteria; dvil04a : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvjb12ml( c : in out d.Criteria; dvjb12ml : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvmardf( c : in out d.Criteria; dvmardf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed1amt( c : in out d.Criteria; ed1amt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed1borr( c : in out d.Criteria; ed1borr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed1int( c : in out d.Criteria; ed1int : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed1monyr( c : in out d.Criteria; ed1monyr : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed1pd( c : in out d.Criteria; ed1pd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed1sum( c : in out d.Criteria; ed1sum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed2amt( c : in out d.Criteria; ed2amt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed2borr( c : in out d.Criteria; ed2borr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed2int( c : in out d.Criteria; ed2int : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed2monyr( c : in out d.Criteria; ed2monyr : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed2pd( c : in out d.Criteria; ed2pd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ed2sum( c : in out d.Criteria; ed2sum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edatt( c : in out d.Criteria; edatt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edattn1( c : in out d.Criteria; edattn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edattn2( c : in out d.Criteria; edattn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edattn3( c : in out d.Criteria; edattn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edhr( c : in out d.Criteria; edhr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edtime( c : in out d.Criteria; edtime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edtyp( c : in out d.Criteria; edtyp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligadlt( c : in out d.Criteria; eligadlt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligchld( c : in out d.Criteria; eligchld : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emppay1( c : in out d.Criteria; emppay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emppay2( c : in out d.Criteria; emppay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emppay3( c : in out d.Criteria; emppay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empstat( c : in out d.Criteria; empstat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endyr( c : in out d.Criteria; endyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_epcur( c : in out d.Criteria; epcur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_es2000( c : in out d.Criteria; es2000 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ethgrp( c : in out d.Criteria; ethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_everwrk( c : in out d.Criteria; everwrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_exthbct1( c : in out d.Criteria; exthbct1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_exthbct2( c : in out d.Criteria; exthbct2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_exthbct3( c : in out d.Criteria; exthbct3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eyetest( c : in out d.Criteria; eyetest : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_follow( c : in out d.Criteria; follow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fted( c : in out d.Criteria; fted : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ftwk( c : in out d.Criteria; ftwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_future( c : in out d.Criteria; future : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_govpis( c : in out d.Criteria; govpis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_govpjsa( c : in out d.Criteria; govpjsa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_x_grant( c : in out d.Criteria; x_grant : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtamt1( c : in out d.Criteria; grtamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtamt2( c : in out d.Criteria; grtamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtdir1( c : in out d.Criteria; grtdir1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtdir2( c : in out d.Criteria; grtdir2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtnum( c : in out d.Criteria; grtnum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtsce1( c : in out d.Criteria; grtsce1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtsce2( c : in out d.Criteria; grtsce2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtval1( c : in out d.Criteria; grtval1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_grtval2( c : in out d.Criteria; grtval2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gta( c : in out d.Criteria; gta : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothamt( c : in out d.Criteria; hbothamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothbu( c : in out d.Criteria; hbothbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothpd( c : in out d.Criteria; hbothpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbothwk( c : in out d.Criteria; hbothwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbotwait( c : in out d.Criteria; hbotwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_health( c : in out d.Criteria; health : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hholder( c : in out d.Criteria; hholder : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hosp( c : in out d.Criteria; hosp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hprob( c : in out d.Criteria; hprob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrpid( c : in out d.Criteria; hrpid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incdur( c : in out d.Criteria; incdur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_injlong( c : in out d.Criteria; injlong : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_injwk( c : in out d.Criteria; injwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_invests( c : in out d.Criteria; invests : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iout( c : in out d.Criteria; iout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_isa1type( c : in out d.Criteria; isa1type : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_isa2type( c : in out d.Criteria; isa2type : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_isa3type( c : in out d.Criteria; isa3type : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jobaway( c : in out d.Criteria; jobaway : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lareg( c : in out d.Criteria; lareg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_likewk( c : in out d.Criteria; likewk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lktime( c : in out d.Criteria; lktime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ln1rpint( c : in out d.Criteria; ln1rpint : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ln2rpint( c : in out d.Criteria; ln2rpint : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loan( c : in out d.Criteria; loan : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loannum( c : in out d.Criteria; loannum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_look( c : in out d.Criteria; look : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lookwk( c : in out d.Criteria; lookwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lstwrk1( c : in out d.Criteria; lstwrk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lstwrk2( c : in out d.Criteria; lstwrk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lstyr( c : in out d.Criteria; lstyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntamt1( c : in out d.Criteria; mntamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntamt2( c : in out d.Criteria; mntamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntct( c : in out d.Criteria; mntct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntfor1( c : in out d.Criteria; mntfor1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntfor2( c : in out d.Criteria; mntfor2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntgov1( c : in out d.Criteria; mntgov1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntgov2( c : in out d.Criteria; mntgov2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntpay( c : in out d.Criteria; mntpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntpd1( c : in out d.Criteria; mntpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntpd2( c : in out d.Criteria; mntpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntrec( c : in out d.Criteria; mntrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mnttota1( c : in out d.Criteria; mnttota1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mnttota2( c : in out d.Criteria; mnttota2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntus1( c : in out d.Criteria; mntus1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntus2( c : in out d.Criteria; mntus2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntusam1( c : in out d.Criteria; mntusam1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntusam2( c : in out d.Criteria; mntusam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntuspd1( c : in out d.Criteria; mntuspd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntuspd2( c : in out d.Criteria; mntuspd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ms( c : in out d.Criteria; ms : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natid1( c : in out d.Criteria; natid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natid2( c : in out d.Criteria; natid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natid3( c : in out d.Criteria; natid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natid4( c : in out d.Criteria; natid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natid5( c : in out d.Criteria; natid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natid6( c : in out d.Criteria; natid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ndeal( c : in out d.Criteria; ndeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_newdtype( c : in out d.Criteria; newdtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhs1( c : in out d.Criteria; nhs1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhs2( c : in out d.Criteria; nhs2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhs3( c : in out d.Criteria; nhs3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_niamt( c : in out d.Criteria; niamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_niethgrp( c : in out d.Criteria; niethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_niexthbb( c : in out d.Criteria; niexthbb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid1( c : in out d.Criteria; ninatid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid2( c : in out d.Criteria; ninatid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid3( c : in out d.Criteria; ninatid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid4( c : in out d.Criteria; ninatid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid5( c : in out d.Criteria; ninatid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid6( c : in out d.Criteria; ninatid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid7( c : in out d.Criteria; ninatid7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninatid8( c : in out d.Criteria; ninatid8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nipd( c : in out d.Criteria; nipd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nireg( c : in out d.Criteria; nireg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nirel( c : in out d.Criteria; nirel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nitrain( c : in out d.Criteria; nitrain : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nlper( c : in out d.Criteria; nlper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nolk1( c : in out d.Criteria; nolk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nolk2( c : in out d.Criteria; nolk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nolk3( c : in out d.Criteria; nolk3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nolook( c : in out d.Criteria; nolook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nowant( c : in out d.Criteria; nowant : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nssec( c : in out d.Criteria; nssec : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcapp( c : in out d.Criteria; ntcapp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcdat( c : in out d.Criteria; ntcdat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcinc( c : in out d.Criteria; ntcinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcorig1( c : in out d.Criteria; ntcorig1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcorig2( c : in out d.Criteria; ntcorig2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcorig3( c : in out d.Criteria; ntcorig3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcorig4( c : in out d.Criteria; ntcorig4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntcorig5( c : in out d.Criteria; ntcorig5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numjob( c : in out d.Criteria; numjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numjob2( c : in out d.Criteria; numjob2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oddjob( c : in out d.Criteria; oddjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oldstud( c : in out d.Criteria; oldstud : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otabspar( c : in out d.Criteria; otabspar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otamt( c : in out d.Criteria; otamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otapamt( c : in out d.Criteria; otapamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otappd( c : in out d.Criteria; otappd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othtax( c : in out d.Criteria; othtax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otinva( c : in out d.Criteria; otinva : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pareamt( c : in out d.Criteria; pareamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_parepd( c : in out d.Criteria; parepd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penlump( c : in out d.Criteria; penlump : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ppnumc( c : in out d.Criteria; ppnumc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prit( c : in out d.Criteria; prit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prscrpt( c : in out d.Criteria; prscrpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ptwk( c : in out d.Criteria; ptwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r01( c : in out d.Criteria; r01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r02( c : in out d.Criteria; r02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r03( c : in out d.Criteria; r03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r04( c : in out d.Criteria; r04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r05( c : in out d.Criteria; r05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r06( c : in out d.Criteria; r06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r07( c : in out d.Criteria; r07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r08( c : in out d.Criteria; r08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r09( c : in out d.Criteria; r09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r10( c : in out d.Criteria; r10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r11( c : in out d.Criteria; r11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r12( c : in out d.Criteria; r12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r13( c : in out d.Criteria; r13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_r14( c : in out d.Criteria; r14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_redamt( c : in out d.Criteria; redamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_redany( c : in out d.Criteria; redany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentprof( c : in out d.Criteria; rentprof : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_retire( c : in out d.Criteria; retire : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_retire1( c : in out d.Criteria; retire1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_retreas( c : in out d.Criteria; retreas : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royal1( c : in out d.Criteria; royal1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royal2( c : in out d.Criteria; royal2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royal3( c : in out d.Criteria; royal3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royal4( c : in out d.Criteria; royal4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royyr1( c : in out d.Criteria; royyr1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royyr2( c : in out d.Criteria; royyr2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royyr3( c : in out d.Criteria; royyr3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_royyr4( c : in out d.Criteria; royyr4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rstrct( c : in out d.Criteria; rstrct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sex( c : in out d.Criteria; sex : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sflntyp1( c : in out d.Criteria; sflntyp1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sflntyp2( c : in out d.Criteria; sflntyp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sftype1( c : in out d.Criteria; sftype1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sftype2( c : in out d.Criteria; sftype2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sic( c : in out d.Criteria; sic : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_slrepamt( c : in out d.Criteria; slrepamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_slrepay( c : in out d.Criteria; slrepay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_slreppd( c : in out d.Criteria; slreppd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_soc2000( c : in out d.Criteria; soc2000 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spcreg1( c : in out d.Criteria; spcreg1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spcreg2( c : in out d.Criteria; spcreg2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spcreg3( c : in out d.Criteria; spcreg3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_specs( c : in out d.Criteria; specs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spout( c : in out d.Criteria; spout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_srentamt( c : in out d.Criteria; srentamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_srentpd( c : in out d.Criteria; srentpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_start( c : in out d.Criteria; start : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_startyr( c : in out d.Criteria; startyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxcred1( c : in out d.Criteria; taxcred1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxcred2( c : in out d.Criteria; taxcred2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxcred3( c : in out d.Criteria; taxcred3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxcred4( c : in out d.Criteria; taxcred4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxcred5( c : in out d.Criteria; taxcred5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxfut( c : in out d.Criteria; taxfut : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tdaywrk( c : in out d.Criteria; tdaywrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tea( c : in out d.Criteria; tea : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_topupl( c : in out d.Criteria; topupl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totint( c : in out d.Criteria; totint : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_train( c : in out d.Criteria; train : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trav( c : in out d.Criteria; trav : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tuborr( c : in out d.Criteria; tuborr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_typeed( c : in out d.Criteria; typeed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_unpaid1( c : in out d.Criteria; unpaid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_unpaid2( c : in out d.Criteria; unpaid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_voucher( c : in out d.Criteria; voucher : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_w1( c : in out d.Criteria; w1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_w2( c : in out d.Criteria; w2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wait( c : in out d.Criteria; wait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_war1( c : in out d.Criteria; war1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_war2( c : in out d.Criteria; war2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wftcboth( c : in out d.Criteria; wftcboth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wftclum( c : in out d.Criteria; wftclum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whoresp( c : in out d.Criteria; whoresp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whosectb( c : in out d.Criteria; whosectb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrde1( c : in out d.Criteria; whyfrde1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrde2( c : in out d.Criteria; whyfrde2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrde3( c : in out d.Criteria; whyfrde3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrde4( c : in out d.Criteria; whyfrde4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrde5( c : in out d.Criteria; whyfrde5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrde6( c : in out d.Criteria; whyfrde6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrey1( c : in out d.Criteria; whyfrey1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrey2( c : in out d.Criteria; whyfrey2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrey3( c : in out d.Criteria; whyfrey3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrey4( c : in out d.Criteria; whyfrey4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrey5( c : in out d.Criteria; whyfrey5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrey6( c : in out d.Criteria; whyfrey6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrpr1( c : in out d.Criteria; whyfrpr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrpr2( c : in out d.Criteria; whyfrpr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrpr3( c : in out d.Criteria; whyfrpr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrpr4( c : in out d.Criteria; whyfrpr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrpr5( c : in out d.Criteria; whyfrpr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whyfrpr6( c : in out d.Criteria; whyfrpr6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav1( c : in out d.Criteria; whytrav1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav2( c : in out d.Criteria; whytrav2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav3( c : in out d.Criteria; whytrav3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav4( c : in out d.Criteria; whytrav4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav5( c : in out d.Criteria; whytrav5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav6( c : in out d.Criteria; whytrav6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wintfuel( c : in out d.Criteria; wintfuel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wmkit( c : in out d.Criteria; wmkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_working( c : in out d.Criteria; working : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wpa( c : in out d.Criteria; wpa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wpba( c : in out d.Criteria; wpba : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wtclum1( c : in out d.Criteria; wtclum1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wtclum2( c : in out d.Criteria; wtclum2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wtclum3( c : in out d.Criteria; wtclum3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ystrtwk( c : in out d.Criteria; ystrtwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_able( c : in out d.Criteria; able : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_actacci( c : in out d.Criteria; actacci : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_addda( c : in out d.Criteria; addda : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_basacti( c : in out d.Criteria; basacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bntxcred( c : in out d.Criteria; bntxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_careab( c : in out d.Criteria; careab : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_careah( c : in out d.Criteria; careah : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carecb( c : in out d.Criteria; carecb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carech( c : in out d.Criteria; carech : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carecl( c : in out d.Criteria; carecl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carefl( c : in out d.Criteria; carefl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carefr( c : in out d.Criteria; carefr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_careot( c : in out d.Criteria; careot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carere( c : in out d.Criteria; carere : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curacti( c : in out d.Criteria; curacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empoccp( c : in out d.Criteria; empoccp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empstatb( c : in out d.Criteria; empstatb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empstatc( c : in out d.Criteria; empstatc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empstati( c : in out d.Criteria; empstati : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsbndcti( c : in out d.Criteria; fsbndcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fwmlkval( c : in out d.Criteria; fwmlkval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gebacti( c : in out d.Criteria; gebacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_giltcti( c : in out d.Criteria; giltcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross2( c : in out d.Criteria; gross2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross3( c : in out d.Criteria; gross3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbsupran( c : in out d.Criteria; hbsupran : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdage( c : in out d.Criteria; hdage : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdben( c : in out d.Criteria; hdben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdindinc( c : in out d.Criteria; hdindinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourab( c : in out d.Criteria; hourab : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourah( c : in out d.Criteria; hourah : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourcare( c : in out d.Criteria; hourcare : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourcb( c : in out d.Criteria; hourcb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourch( c : in out d.Criteria; hourch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourcl( c : in out d.Criteria; hourcl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourfr( c : in out d.Criteria; hourfr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourot( c : in out d.Criteria; hourot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourre( c : in out d.Criteria; hourre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourtot( c : in out d.Criteria; hourtot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hperson( c : in out d.Criteria; hperson : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iagegr2( c : in out d.Criteria; iagegr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iagegrp( c : in out d.Criteria; iagegrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incseo2( c : in out d.Criteria; incseo2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_indinc( c : in out d.Criteria; indinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_indisben( c : in out d.Criteria; indisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inearns( c : in out d.Criteria; inearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ininv( c : in out d.Criteria; ininv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inirben( c : in out d.Criteria; inirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_innirben( c : in out d.Criteria; innirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inothben( c : in out d.Criteria; inothben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inpeninc( c : in out d.Criteria; inpeninc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inrinc( c : in out d.Criteria; inrinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_inrpinc( c : in out d.Criteria; inrpinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intvlic( c : in out d.Criteria; intvlic : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intxcred( c : in out d.Criteria; intxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_isacti( c : in out d.Criteria; isacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_marital( c : in out d.Criteria; marital : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_netocpen( c : in out d.Criteria; netocpen : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nincseo2( c : in out d.Criteria; nincseo2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nindinc( c : in out d.Criteria; nindinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninearns( c : in out d.Criteria; ninearns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nininv( c : in out d.Criteria; nininv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninpenin( c : in out d.Criteria; ninpenin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninsein2( c : in out d.Criteria; ninsein2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nsbocti( c : in out d.Criteria; nsbocti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_occupnum( c : in out d.Criteria; occupnum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_otbscti( c : in out d.Criteria; otbscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pepscti( c : in out d.Criteria; pepscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_poaccti( c : in out d.Criteria; poaccti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prbocti( c : in out d.Criteria; prbocti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_relhrp( c : in out d.Criteria; relhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sayecti( c : in out d.Criteria; sayecti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sclbcti( c : in out d.Criteria; sclbcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seincam2( c : in out d.Criteria; seincam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_smpadj( c : in out d.Criteria; smpadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sscti( c : in out d.Criteria; sscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sspadj( c : in out d.Criteria; sspadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stshcti( c : in out d.Criteria; stshcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_superan( c : in out d.Criteria; superan : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_taxpayer( c : in out d.Criteria; taxpayer : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tesscti( c : in out d.Criteria; tesscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totgrant( c : in out d.Criteria; totgrant : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tothours( c : in out d.Criteria; tothours : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totoccp( c : in out d.Criteria; totoccp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwcosts( c : in out d.Criteria; ttwcosts : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_untrcti( c : in out d.Criteria; untrcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uperson( c : in out d.Criteria; uperson : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_widoccp( c : in out d.Criteria; widoccp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accountq( c : in out d.Criteria; accountq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q7( c : in out d.Criteria; ben5q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q8( c : in out d.Criteria; ben5q8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben5q9( c : in out d.Criteria; ben5q9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ddatre( c : in out d.Criteria; ddatre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdif9( c : in out d.Criteria; disdif9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fare( c : in out d.Criteria; fare : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nittwmod( c : in out d.Criteria; nittwmod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oneway( c : in out d.Criteria; oneway : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pssamt( c : in out d.Criteria; pssamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pssdate( c : in out d.Criteria; pssdate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwcode1( c : in out d.Criteria; ttwcode1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwcode2( c : in out d.Criteria; ttwcode2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwcode3( c : in out d.Criteria; ttwcode3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwcost( c : in out d.Criteria; ttwcost : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwfar( c : in out d.Criteria; ttwfar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwfrq( c : in out d.Criteria; ttwfrq : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwmod( c : in out d.Criteria; ttwmod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwpay( c : in out d.Criteria; ttwpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwpss( c : in out d.Criteria; ttwpss : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwrec( c : in out d.Criteria; ttwrec : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chbflg( c : in out d.Criteria; chbflg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_crunaci( c : in out d.Criteria; crunaci : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_enomorti( c : in out d.Criteria; enomorti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sapadj( c : in out d.Criteria; sapadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sppadj( c : in out d.Criteria; sppadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttwmode( c : in out d.Criteria; ttwmode : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ddatrep( c : in out d.Criteria; ddatrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_defrpen( c : in out d.Criteria; defrpen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdifp( c : in out d.Criteria; disdifp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_followup( c : in out d.Criteria; followup : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_practice( c : in out d.Criteria; practice : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sfrpis( c : in out d.Criteria; sfrpis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sfrpjsa( c : in out d.Criteria; sfrpjsa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age80( c : in out d.Criteria; age80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ethgr2( c : in out d.Criteria; ethgr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pocardi( c : in out d.Criteria; pocardi : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdpn( c : in out d.Criteria; chkdpn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chknop( c : in out d.Criteria; chknop : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_consent( c : in out d.Criteria; consent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvpens( c : in out d.Criteria; dvpens : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligschm( c : in out d.Criteria; eligschm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emparr( c : in out d.Criteria; emparr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emppen( c : in out d.Criteria; emppen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empschm( c : in out d.Criteria; empschm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref1( c : in out d.Criteria; lnkref1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref2( c : in out d.Criteria; lnkref2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref21( c : in out d.Criteria; lnkref21 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref22( c : in out d.Criteria; lnkref22 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref23( c : in out d.Criteria; lnkref23 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref24( c : in out d.Criteria; lnkref24 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref25( c : in out d.Criteria; lnkref25 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref3( c : in out d.Criteria; lnkref3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref4( c : in out d.Criteria; lnkref4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref5( c : in out d.Criteria; lnkref5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_memschm( c : in out d.Criteria; memschm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pconsent( c : in out d.Criteria; pconsent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_perspen1( c : in out d.Criteria; perspen1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_perspen2( c : in out d.Criteria; perspen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_privpen( c : in out d.Criteria; privpen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_schchk( c : in out d.Criteria; schchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spnumc( c : in out d.Criteria; spnumc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stakep( c : in out d.Criteria; stakep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trainee( c : in out d.Criteria; trainee : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkdwp( c : in out d.Criteria; lnkdwp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkons( c : in out d.Criteria; lnkons : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref6( c : in out d.Criteria; lnkref6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref7( c : in out d.Criteria; lnkref7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref8( c : in out d.Criteria; lnkref8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref9( c : in out d.Criteria; lnkref9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcever1( c : in out d.Criteria; tcever1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcever2( c : in out d.Criteria; tcever2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcrepay1( c : in out d.Criteria; tcrepay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcrepay2( c : in out d.Criteria; tcrepay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcrepay3( c : in out d.Criteria; tcrepay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcrepay4( c : in out d.Criteria; tcrepay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcrepay5( c : in out d.Criteria; tcrepay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcrepay6( c : in out d.Criteria; tcrepay6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcthsyr1( c : in out d.Criteria; tcthsyr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tcthsyr2( c : in out d.Criteria; tcthsyr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_currjobm( c : in out d.Criteria; currjobm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prevjobm( c : in out d.Criteria; prevjobm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_b3qfut7( c : in out d.Criteria; b3qfut7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben3q7( c : in out d.Criteria; ben3q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_camemt( c : in out d.Criteria; camemt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cameyr( c : in out d.Criteria; cameyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cameyr2( c : in out d.Criteria; cameyr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_contuk( c : in out d.Criteria; contuk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_corign( c : in out d.Criteria; corign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ddaprog( c : in out d.Criteria; ddaprog : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hbolng( c : in out d.Criteria; hbolng : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual1( c : in out d.Criteria; hi1qual1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual2( c : in out d.Criteria; hi1qual2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual3( c : in out d.Criteria; hi1qual3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual4( c : in out d.Criteria; hi1qual4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual5( c : in out d.Criteria; hi1qual5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual6( c : in out d.Criteria; hi1qual6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi2qual( c : in out d.Criteria; hi2qual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn01( c : in out d.Criteria; hlpgvn01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn02( c : in out d.Criteria; hlpgvn02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn03( c : in out d.Criteria; hlpgvn03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn04( c : in out d.Criteria; hlpgvn04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn05( c : in out d.Criteria; hlpgvn05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn06( c : in out d.Criteria; hlpgvn06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn07( c : in out d.Criteria; hlpgvn07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn08( c : in out d.Criteria; hlpgvn08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn09( c : in out d.Criteria; hlpgvn09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn10( c : in out d.Criteria; hlpgvn10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlpgvn11( c : in out d.Criteria; hlpgvn11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec01( c : in out d.Criteria; hlprec01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec02( c : in out d.Criteria; hlprec02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec03( c : in out d.Criteria; hlprec03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec04( c : in out d.Criteria; hlprec04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec05( c : in out d.Criteria; hlprec05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec06( c : in out d.Criteria; hlprec06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec07( c : in out d.Criteria; hlprec07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec08( c : in out d.Criteria; hlprec08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec09( c : in out d.Criteria; hlprec09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec10( c : in out d.Criteria; hlprec10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hlprec11( c : in out d.Criteria; hlprec11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loangvn1( c : in out d.Criteria; loangvn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loangvn2( c : in out d.Criteria; loangvn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loangvn3( c : in out d.Criteria; loangvn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanrec1( c : in out d.Criteria; loanrec1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanrec2( c : in out d.Criteria; loanrec2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanrec3( c : in out d.Criteria; loanrec3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntarr1( c : in out d.Criteria; mntarr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntarr2( c : in out d.Criteria; mntarr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntarr3( c : in out d.Criteria; mntarr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntarr4( c : in out d.Criteria; mntarr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntnrp( c : in out d.Criteria; mntnrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othqual1( c : in out d.Criteria; othqual1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othqual2( c : in out d.Criteria; othqual2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othqual3( c : in out d.Criteria; othqual3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tea9697( c : in out d.Criteria; tea9697 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heartval( c : in out d.Criteria; heartval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iagegr3( c : in out d.Criteria; iagegr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iagegr4( c : in out d.Criteria; iagegr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nirel2( c : in out d.Criteria; nirel2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_xbonflag( c : in out d.Criteria; xbonflag : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_alg( c : in out d.Criteria; alg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_algamt( c : in out d.Criteria; algamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_algpd( c : in out d.Criteria; algpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ben4q4( c : in out d.Criteria; ben4q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkctc( c : in out d.Criteria; chkctc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdpco1( c : in out d.Criteria; chkdpco1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdpco2( c : in out d.Criteria; chkdpco2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdpco3( c : in out d.Criteria; chkdpco3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdsco1( c : in out d.Criteria; chkdsco1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdsco2( c : in out d.Criteria; chkdsco2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chkdsco3( c : in out d.Criteria; chkdsco3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dv09pens( c : in out d.Criteria; dv09pens : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref01( c : in out d.Criteria; lnkref01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref02( c : in out d.Criteria; lnkref02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref03( c : in out d.Criteria; lnkref03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref04( c : in out d.Criteria; lnkref04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref05( c : in out d.Criteria; lnkref05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref06( c : in out d.Criteria; lnkref06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref07( c : in out d.Criteria; lnkref07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref08( c : in out d.Criteria; lnkref08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref09( c : in out d.Criteria; lnkref09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref10( c : in out d.Criteria; lnkref10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lnkref11( c : in out d.Criteria; lnkref11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spyrot( c : in out d.Criteria; spyrot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdifad( c : in out d.Criteria; disdifad : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross3_x( c : in out d.Criteria; gross3_x : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_aliamt( c : in out d.Criteria; aliamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_alimny( c : in out d.Criteria; alimny : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_alipd( c : in out d.Criteria; alipd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_alius( c : in out d.Criteria; alius : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_aluamt( c : in out d.Criteria; aluamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_alupd( c : in out d.Criteria; alupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbaamt( c : in out d.Criteria; cbaamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hsvper( c : in out d.Criteria; hsvper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mednum( c : in out d.Criteria; mednum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medprpd( c : in out d.Criteria; medprpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medprpy( c : in out d.Criteria; medprpy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penflag( c : in out d.Criteria; penflag : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ppchk1( c : in out d.Criteria; ppchk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ppchk2( c : in out d.Criteria; ppchk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ppchk3( c : in out d.Criteria; ppchk3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ttbprx( c : in out d.Criteria; ttbprx : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mjobsect( c : in out d.Criteria; mjobsect : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_etngrp( c : in out d.Criteria; etngrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medpay( c : in out d.Criteria; medpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medrep( c : in out d.Criteria; medrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medrpnm( c : in out d.Criteria; medrpnm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nanid1( c : in out d.Criteria; nanid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nanid2( c : in out d.Criteria; nanid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nanid3( c : in out d.Criteria; nanid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nanid4( c : in out d.Criteria; nanid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nanid5( c : in out d.Criteria; nanid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nanid6( c : in out d.Criteria; nanid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nietngrp( c : in out d.Criteria; nietngrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid1( c : in out d.Criteria; ninanid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid2( c : in out d.Criteria; ninanid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid3( c : in out d.Criteria; ninanid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid4( c : in out d.Criteria; ninanid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid5( c : in out d.Criteria; ninanid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid6( c : in out d.Criteria; ninanid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanid7( c : in out d.Criteria; ninanid7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nirelig( c : in out d.Criteria; nirelig : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pollopin( c : in out d.Criteria; pollopin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_religenw( c : in out d.Criteria; religenw : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_religsc( c : in out d.Criteria; religsc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sidqn( c : in out d.Criteria; sidqn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_soc2010( c : in out d.Criteria; soc2010 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_corignan( c : in out d.Criteria; corignan : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dobmonth( c : in out d.Criteria; dobmonth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dobyear( c : in out d.Criteria; dobyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ethgr3( c : in out d.Criteria; ethgr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninanida( c : in out d.Criteria; ninanida : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_agehqual( c : in out d.Criteria; agehqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bfd( c : in out d.Criteria; bfd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bfdamt( c : in out d.Criteria; bfdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bfdpd( c : in out d.Criteria; bfdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_bfdval( c : in out d.Criteria; bfdval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_btec( c : in out d.Criteria; btec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_btecnow( c : in out d.Criteria; btecnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbaamt2( c : in out d.Criteria; cbaamt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_change( c : in out d.Criteria; change : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_citizen( c : in out d.Criteria; citizen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_citizen2( c : in out d.Criteria; citizen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_condit( c : in out d.Criteria; condit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_corigoth( c : in out d.Criteria; corigoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curqual( c : in out d.Criteria; curqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ddaprog1( c : in out d.Criteria; ddaprog1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ddatre1( c : in out d.Criteria; ddatre1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ddatrep1( c : in out d.Criteria; ddatrep1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_degree( c : in out d.Criteria; degree : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_degrenow( c : in out d.Criteria; degrenow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_denrec( c : in out d.Criteria; denrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd01( c : in out d.Criteria; disd01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd02( c : in out d.Criteria; disd02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd03( c : in out d.Criteria; disd03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd04( c : in out d.Criteria; disd04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd05( c : in out d.Criteria; disd05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd06( c : in out d.Criteria; disd06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd07( c : in out d.Criteria; disd07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd08( c : in out d.Criteria; disd08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd09( c : in out d.Criteria; disd09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disd10( c : in out d.Criteria; disd10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdifp1( c : in out d.Criteria; disdifp1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_empcontr( c : in out d.Criteria; empcontr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ethgrps( c : in out d.Criteria; ethgrps : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eualiamt( c : in out d.Criteria; eualiamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eualimny( c : in out d.Criteria; eualimny : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eualipd( c : in out d.Criteria; eualipd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euetype( c : in out d.Criteria; euetype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_followsc( c : in out d.Criteria; followsc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_health1( c : in out d.Criteria; health1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heathad( c : in out d.Criteria; heathad : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi3qual( c : in out d.Criteria; hi3qual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_higho( c : in out d.Criteria; higho : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_highonow( c : in out d.Criteria; highonow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jobbyr( c : in out d.Criteria; jobbyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_limitl( c : in out d.Criteria; limitl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lktrain( c : in out d.Criteria; lktrain : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lkwork( c : in out d.Criteria; lkwork : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medrec( c : in out d.Criteria; medrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nvqlenow( c : in out d.Criteria; nvqlenow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nvqlev( c : in out d.Criteria; nvqlev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpass( c : in out d.Criteria; othpass : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ppper( c : in out d.Criteria; ppper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_proptax( c : in out d.Criteria; proptax : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reasden( c : in out d.Criteria; reasden : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reasmed( c : in out d.Criteria; reasmed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reasnhs( c : in out d.Criteria; reasnhs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reason( c : in out d.Criteria; reason : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rednet( c : in out d.Criteria; rednet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_redtax( c : in out d.Criteria; redtax : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rsa( c : in out d.Criteria; rsa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rsanow( c : in out d.Criteria; rsanow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_samesit( c : in out d.Criteria; samesit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_scotvec( c : in out d.Criteria; scotvec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sctvnow( c : in out d.Criteria; sctvnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp01( c : in out d.Criteria; sdemp01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp02( c : in out d.Criteria; sdemp02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp03( c : in out d.Criteria; sdemp03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp04( c : in out d.Criteria; sdemp04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp05( c : in out d.Criteria; sdemp05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp06( c : in out d.Criteria; sdemp06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp07( c : in out d.Criteria; sdemp07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp08( c : in out d.Criteria; sdemp08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp09( c : in out d.Criteria; sdemp09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp10( c : in out d.Criteria; sdemp10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp11( c : in out d.Criteria; sdemp11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sdemp12( c : in out d.Criteria; sdemp12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_selfdemp( c : in out d.Criteria; selfdemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tempjob( c : in out d.Criteria; tempjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_agehq80( c : in out d.Criteria; agehq80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disacta1( c : in out d.Criteria; disacta1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_discora1( c : in out d.Criteria; discora1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gross4( c : in out d.Criteria; gross4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninrinc( c : in out d.Criteria; ninrinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_typeed2( c : in out d.Criteria; typeed2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_w45( c : in out d.Criteria; w45 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accmsat( c : in out d.Criteria; accmsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_c2orign( c : in out d.Criteria; c2orign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_calm( c : in out d.Criteria; calm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cbchk( c : in out d.Criteria; cbchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut1( c : in out d.Criteria; claifut1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut2( c : in out d.Criteria; claifut2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut3( c : in out d.Criteria; claifut3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut4( c : in out d.Criteria; claifut4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut5( c : in out d.Criteria; claifut5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut6( c : in out d.Criteria; claifut6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut7( c : in out d.Criteria; claifut7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claifut8( c : in out d.Criteria; claifut8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_commusat( c : in out d.Criteria; commusat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coptrust( c : in out d.Criteria; coptrust : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_depress( c : in out d.Criteria; depress : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disben1( c : in out d.Criteria; disben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disben2( c : in out d.Criteria; disben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disben3( c : in out d.Criteria; disben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disben4( c : in out d.Criteria; disben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disben5( c : in out d.Criteria; disben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disben6( c : in out d.Criteria; disben6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_discuss( c : in out d.Criteria; discuss : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dla1( c : in out d.Criteria; dla1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dla2( c : in out d.Criteria; dla2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dls( c : in out d.Criteria; dls : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dlsamt( c : in out d.Criteria; dlsamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dlspd( c : in out d.Criteria; dlspd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dlsval( c : in out d.Criteria; dlsval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_down( c : in out d.Criteria; down : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_envirsat( c : in out d.Criteria; envirsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gpispc( c : in out d.Criteria; gpispc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gpjsaesa( c : in out d.Criteria; gpjsaesa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_happy( c : in out d.Criteria; happy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_help( c : in out d.Criteria; help : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim1( c : in out d.Criteria; iclaim1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim2( c : in out d.Criteria; iclaim2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim3( c : in out d.Criteria; iclaim3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim4( c : in out d.Criteria; iclaim4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim5( c : in out d.Criteria; iclaim5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim6( c : in out d.Criteria; iclaim6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim7( c : in out d.Criteria; iclaim7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim8( c : in out d.Criteria; iclaim8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_iclaim9( c : in out d.Criteria; iclaim9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_jobsat( c : in out d.Criteria; jobsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidben1( c : in out d.Criteria; kidben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidben2( c : in out d.Criteria; kidben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_kidben3( c : in out d.Criteria; kidben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_legltrus( c : in out d.Criteria; legltrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lifesat( c : in out d.Criteria; lifesat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_meaning( c : in out d.Criteria; meaning : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_moneysat( c : in out d.Criteria; moneysat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nervous( c : in out d.Criteria; nervous : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ni2train( c : in out d.Criteria; ni2train : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othben1( c : in out d.Criteria; othben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othben2( c : in out d.Criteria; othben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othben3( c : in out d.Criteria; othben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othben4( c : in out d.Criteria; othben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othben5( c : in out d.Criteria; othben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othben6( c : in out d.Criteria; othben6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othtrust( c : in out d.Criteria; othtrust : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penben1( c : in out d.Criteria; penben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penben2( c : in out d.Criteria; penben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penben3( c : in out d.Criteria; penben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penben4( c : in out d.Criteria; penben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penben5( c : in out d.Criteria; penben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pip1( c : in out d.Criteria; pip1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pip2( c : in out d.Criteria; pip2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_polttrus( c : in out d.Criteria; polttrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_recsat( c : in out d.Criteria; recsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_relasat( c : in out d.Criteria; relasat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_safe( c : in out d.Criteria; safe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_socfund1( c : in out d.Criteria; socfund1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_socfund2( c : in out d.Criteria; socfund2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_socfund3( c : in out d.Criteria; socfund3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_socfund4( c : in out d.Criteria; socfund4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_srispc( c : in out d.Criteria; srispc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_srjsaesa( c : in out d.Criteria; srjsaesa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_timesat( c : in out d.Criteria; timesat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_train2( c : in out d.Criteria; train2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trnallow( c : in out d.Criteria; trnallow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben1( c : in out d.Criteria; wageben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben2( c : in out d.Criteria; wageben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben3( c : in out d.Criteria; wageben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben4( c : in out d.Criteria; wageben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben5( c : in out d.Criteria; wageben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben6( c : in out d.Criteria; wageben6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben7( c : in out d.Criteria; wageben7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wageben8( c : in out d.Criteria; wageben8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninnirbn( c : in out d.Criteria; ninnirbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ninothbn( c : in out d.Criteria; ninothbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anxious( c : in out d.Criteria; anxious : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_candgnow( c : in out d.Criteria; candgnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curothf( c : in out d.Criteria; curothf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curothp( c : in out d.Criteria; curothp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curothwv( c : in out d.Criteria; curothwv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvhiqual( c : in out d.Criteria; dvhiqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gnvqnow( c : in out d.Criteria; gnvqnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gpuc( c : in out d.Criteria; gpuc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_happywb( c : in out d.Criteria; happywb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual7( c : in out d.Criteria; hi1qual7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hi1qual8( c : in out d.Criteria; hi1qual8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntarr5( c : in out d.Criteria; mntarr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntnoch1( c : in out d.Criteria; mntnoch1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntnoch2( c : in out d.Criteria; mntnoch2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntnoch3( c : in out d.Criteria; mntnoch3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntnoch4( c : in out d.Criteria; mntnoch4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntnoch5( c : in out d.Criteria; mntnoch5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntpro1( c : in out d.Criteria; mntpro1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntpro2( c : in out d.Criteria; mntpro2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntpro3( c : in out d.Criteria; mntpro3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mnttim1( c : in out d.Criteria; mnttim1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mnttim2( c : in out d.Criteria; mnttim2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mnttim3( c : in out d.Criteria; mnttim3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntwrk1( c : in out d.Criteria; mntwrk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntwrk2( c : in out d.Criteria; mntwrk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntwrk3( c : in out d.Criteria; mntwrk3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntwrk4( c : in out d.Criteria; mntwrk4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mntwrk5( c : in out d.Criteria; mntwrk5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ndeplnow( c : in out d.Criteria; ndeplnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oqualc1( c : in out d.Criteria; oqualc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oqualc2( c : in out d.Criteria; oqualc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oqualc3( c : in out d.Criteria; oqualc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sruc( c : in out d.Criteria; sruc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_webacnow( c : in out d.Criteria; webacnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_indeth( c : in out d.Criteria; indeth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euactive( c : in out d.Criteria; euactive : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euactno( c : in out d.Criteria; euactno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euartact( c : in out d.Criteria; euartact : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euaskhlp( c : in out d.Criteria; euaskhlp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eucinema( c : in out d.Criteria; eucinema : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eucultur( c : in out d.Criteria; eucultur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euinvol( c : in out d.Criteria; euinvol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eulivpe( c : in out d.Criteria; eulivpe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eumtfam( c : in out d.Criteria; eumtfam : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eumtfrnd( c : in out d.Criteria; eumtfrnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eusocnet( c : in out d.Criteria; eusocnet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eusport( c : in out d.Criteria; eusport : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eutkfam( c : in out d.Criteria; eutkfam : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eutkfrnd( c : in out d.Criteria; eutkfrnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eutkmat( c : in out d.Criteria; eutkmat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_euvol( c : in out d.Criteria; euvol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_natscot( c : in out d.Criteria; natscot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntsctnow( c : in out d.Criteria; ntsctnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penwel1( c : in out d.Criteria; penwel1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penwel2( c : in out d.Criteria; penwel2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penwel3( c : in out d.Criteria; penwel3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penwel4( c : in out d.Criteria; penwel4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penwel5( c : in out d.Criteria; penwel5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penwel6( c : in out d.Criteria; penwel6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_skiwknow( c : in out d.Criteria; skiwknow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_skiwrk( c : in out d.Criteria; skiwrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_slos( c : in out d.Criteria; slos : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_yjblev( c : in out d.Criteria; yjblev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_abs1no_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_abs2no_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_abspar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_abspay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_abswhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_abswk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_x_access_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accftpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accjb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accssamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accsspd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adeduc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adema_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ademaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ademapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allow1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allow2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allow3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allow4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_allpd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anyacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anyed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anymon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anypen7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_apamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_apdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_apdir_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_apdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_appd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b2qfut1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b2qfut2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b2qfut3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben1q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben2q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben2q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben2q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben4q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben4q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben4q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben7q9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_btwacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claimant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cohabit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_combid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_convbl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctclum1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctclum2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cupchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cvht_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cvpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cvpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dentist_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_depend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dptcboth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dptclum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvil03a_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvil04a_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvjb12ml_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvmardf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed1amt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed1borr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed1int_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed1monyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed1pd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed1sum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed2amt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed2borr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed2int_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed2monyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed2pd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ed2sum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edatt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edattn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edattn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edattn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edtime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edtyp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligadlt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligchld_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emppay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emppay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emppay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empstat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_epcur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_es2000_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_everwrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_exthbct1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_exthbct2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_exthbct3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eyetest_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_follow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fted_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ftwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_future_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_govpis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_govpjsa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_x_grant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtdir1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtdir2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtnum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtsce1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtsce2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtval1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_grtval2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gta_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbothwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbotwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_health_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hholder_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hosp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hprob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrpid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incdur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_injlong_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_injwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_invests_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_isa1type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_isa2type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_isa3type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jobaway_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lareg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_likewk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lktime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ln1rpint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ln2rpint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loannum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_look_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lookwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lstwrk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lstwrk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lstyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntfor1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntfor2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntgov1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntgov2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mnttota1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mnttota2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntus1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntus2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntusam1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntusam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntuspd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntuspd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ndeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_newdtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhs1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhs2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhs3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_niamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_niethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_niexthbb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninatid8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nipd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nireg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nirel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nitrain_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nlper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nolk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nolk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nolk3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nolook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nowant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nssec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcapp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcdat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcorig1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcorig2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcorig3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcorig4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntcorig5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numjob2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oddjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oldstud_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otabspar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otapamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otappd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otinva_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pareamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_parepd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penlump_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ppnumc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prscrpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ptwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_r14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_redamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_redany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentprof_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_retire_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_retire1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_retreas_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royal1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royal2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royal3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royal4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royyr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royyr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royyr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_royyr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rstrct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sex_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sflntyp1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sflntyp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sftype1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sftype2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_slrepamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_slrepay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_slreppd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_soc2000_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spcreg1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spcreg2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spcreg3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_specs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_srentamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_srentpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_start_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_startyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxcred1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxcred2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxcred3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxcred4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxcred5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxfut_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tdaywrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tea_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_topupl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_train_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trav_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tuborr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_typeed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_unpaid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_unpaid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_voucher_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_w1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_w2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_war1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_war2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wftcboth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wftclum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whoresp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whosectb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrde1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrde2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrde3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrde4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrde5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrde6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrey1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrey2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrey3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrey4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrey5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrey6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrpr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrpr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrpr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrpr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrpr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whyfrpr6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wintfuel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wmkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_working_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wpa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wpba_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wtclum1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wtclum2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wtclum3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ystrtwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_able_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_actacci_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_addda_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_basacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bntxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_careab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_careah_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carecb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carech_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carecl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carefl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carefr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_careot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carere_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empoccp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empstatb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empstatc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empstati_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsbndcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fwmlkval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gebacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_giltcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbsupran_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdindinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourah_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourcare_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourcb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourcl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourfr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourtot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hperson_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iagegr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iagegrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incseo2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_indinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_indisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ininv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_innirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inothben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inpeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_inrpinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_isacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_marital_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_netocpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nincseo2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nindinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nininv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninpenin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninsein2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nsbocti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_occupnum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_otbscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pepscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_poaccti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prbocti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_relhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sayecti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sclbcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seincam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_smpadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sspadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stshcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_superan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_taxpayer_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tesscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totgrant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tothours_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totoccp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwcosts_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_untrcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uperson_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_widoccp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accountq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben5q9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ddatre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdif9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fare_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nittwmod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oneway_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pssamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pssdate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwcode1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwcode2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwcode3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwcost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwfar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwfrq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwmod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwpss_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chbflg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_crunaci_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_enomorti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sapadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sppadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttwmode_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ddatrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_defrpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdifp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_followup_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_practice_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sfrpis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sfrpjsa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ethgr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pocardi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdpn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chknop_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_consent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvpens_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligschm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emparr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emppen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empschm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_memschm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pconsent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_perspen1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_perspen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_privpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_schchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spnumc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stakep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trainee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkdwp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkons_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcever1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcever2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcrepay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcrepay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcrepay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcrepay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcrepay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcrepay6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcthsyr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tcthsyr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_currjobm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prevjobm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_b3qfut7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben3q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_camemt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cameyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cameyr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_contuk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_corign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ddaprog_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hbolng_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi2qual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlpgvn11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hlprec11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loangvn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loangvn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loangvn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanrec1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanrec2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanrec3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntarr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntarr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntarr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntarr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntnrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othqual1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othqual2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othqual3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tea9697_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heartval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iagegr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iagegr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nirel2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_xbonflag_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_alg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_algamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_algpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ben4q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkctc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdpco1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdpco2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdpco3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdsco1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdsco2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chkdsco3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dv09pens_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lnkref11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spyrot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdifad_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross3_x_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_aliamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_alimny_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_alipd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_alius_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_aluamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_alupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hsvper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mednum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medprpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medprpy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penflag_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ppchk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ppchk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ppchk3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ttbprx_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mjobsect_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_etngrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medrpnm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nanid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nanid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nanid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nanid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nanid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nanid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nietngrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanid7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nirelig_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pollopin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_religenw_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_religsc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sidqn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_soc2010_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_corignan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dobmonth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dobyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ethgr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninanida_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_agehqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bfd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bfdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bfdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_bfdval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_btec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_btecnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbaamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_change_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_citizen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_citizen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_condit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_corigoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ddaprog1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ddatre1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ddatrep1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_degree_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_degrenow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_denrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disd10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdifp1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_empcontr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ethgrps_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eualiamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eualimny_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eualipd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euetype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_followsc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_health1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heathad_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi3qual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_higho_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_highonow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jobbyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_limitl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lktrain_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lkwork_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nvqlenow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nvqlev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpass_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ppper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_proptax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reasden_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reasmed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reasnhs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reason_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rednet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_redtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rsa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rsanow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_samesit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_scotvec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sctvnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sdemp12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_selfdemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tempjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_agehq80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disacta1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_discora1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gross4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_typeed2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_w45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accmsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_c2orign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_calm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cbchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claifut8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_commusat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coptrust_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_depress_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disben6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_discuss_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dla1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dla2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dls_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dlsamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dlspd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dlsval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_down_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_envirsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gpispc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gpjsaesa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_happy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_help_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_iclaim9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_jobsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_kidben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_legltrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lifesat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_meaning_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_moneysat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nervous_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ni2train_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othben6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othtrust_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pip1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pip2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_polttrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_recsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_relasat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_safe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_socfund1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_socfund2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_socfund3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_socfund4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_srispc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_srjsaesa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_timesat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_train2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trnallow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wageben8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninnirbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ninothbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anxious_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_candgnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curothf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curothp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curothwv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvhiqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gnvqnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gpuc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_happywb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hi1qual8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntarr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntnoch1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntnoch2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntnoch3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntnoch4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntnoch5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntpro1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntpro2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntpro3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mnttim1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mnttim2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mnttim3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntwrk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntwrk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntwrk3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntwrk4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mntwrk5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ndeplnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oqualc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oqualc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oqualc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sruc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_webacnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_indeth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euactive_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euactno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euartact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euaskhlp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eucinema_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eucultur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euinvol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eulivpe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eumtfam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eumtfrnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eusocnet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eusport_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eutkfam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eutkfrnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eutkmat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_euvol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_natscot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntsctnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penwel1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penwel2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penwel3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penwel4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penwel5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penwel6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_skiwknow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_skiwrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_slos_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_yjblev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Adult;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 927, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : abs1no                   : Parameter_Integer  : Integer              :        0 
   --    8 : abs2no                   : Parameter_Integer  : Integer              :        0 
   --    9 : abspar                   : Parameter_Integer  : Integer              :        0 
   --   10 : abspay                   : Parameter_Integer  : Integer              :        0 
   --   11 : abswhy                   : Parameter_Integer  : Integer              :        0 
   --   12 : abswk                    : Parameter_Integer  : Integer              :        0 
   --   13 : x_access                 : Parameter_Integer  : Integer              :        0 
   --   14 : accftpt                  : Parameter_Integer  : Integer              :        0 
   --   15 : accjb                    : Parameter_Integer  : Integer              :        0 
   --   16 : accssamt                 : Parameter_Float    : Amount               :      0.0 
   --   17 : accsspd                  : Parameter_Integer  : Integer              :        0 
   --   18 : adeduc                   : Parameter_Integer  : Integer              :        0 
   --   19 : adema                    : Parameter_Integer  : Integer              :        0 
   --   20 : ademaamt                 : Parameter_Float    : Amount               :      0.0 
   --   21 : ademapd                  : Parameter_Integer  : Integer              :        0 
   --   22 : age                      : Parameter_Integer  : Integer              :        0 
   --   23 : allow1                   : Parameter_Integer  : Integer              :        0 
   --   24 : allow2                   : Parameter_Integer  : Integer              :        0 
   --   25 : allow3                   : Parameter_Integer  : Integer              :        0 
   --   26 : allow4                   : Parameter_Integer  : Integer              :        0 
   --   27 : allpay1                  : Parameter_Float    : Amount               :      0.0 
   --   28 : allpay2                  : Parameter_Float    : Amount               :      0.0 
   --   29 : allpay3                  : Parameter_Float    : Amount               :      0.0 
   --   30 : allpay4                  : Parameter_Float    : Amount               :      0.0 
   --   31 : allpd1                   : Parameter_Integer  : Integer              :        0 
   --   32 : allpd2                   : Parameter_Integer  : Integer              :        0 
   --   33 : allpd3                   : Parameter_Integer  : Integer              :        0 
   --   34 : allpd4                   : Parameter_Integer  : Integer              :        0 
   --   35 : anyacc                   : Parameter_Integer  : Integer              :        0 
   --   36 : anyed                    : Parameter_Integer  : Integer              :        0 
   --   37 : anymon                   : Parameter_Integer  : Integer              :        0 
   --   38 : anypen1                  : Parameter_Integer  : Integer              :        0 
   --   39 : anypen2                  : Parameter_Integer  : Integer              :        0 
   --   40 : anypen3                  : Parameter_Integer  : Integer              :        0 
   --   41 : anypen4                  : Parameter_Integer  : Integer              :        0 
   --   42 : anypen5                  : Parameter_Integer  : Integer              :        0 
   --   43 : anypen6                  : Parameter_Integer  : Integer              :        0 
   --   44 : anypen7                  : Parameter_Integer  : Integer              :        0 
   --   45 : apamt                    : Parameter_Float    : Amount               :      0.0 
   --   46 : apdamt                   : Parameter_Float    : Amount               :      0.0 
   --   47 : apdir                    : Parameter_Integer  : Integer              :        0 
   --   48 : apdpd                    : Parameter_Integer  : Integer              :        0 
   --   49 : appd                     : Parameter_Integer  : Integer              :        0 
   --   50 : b2qfut1                  : Parameter_Integer  : Integer              :        0 
   --   51 : b2qfut2                  : Parameter_Integer  : Integer              :        0 
   --   52 : b2qfut3                  : Parameter_Integer  : Integer              :        0 
   --   53 : b3qfut1                  : Parameter_Integer  : Integer              :        0 
   --   54 : b3qfut2                  : Parameter_Integer  : Integer              :        0 
   --   55 : b3qfut3                  : Parameter_Integer  : Integer              :        0 
   --   56 : b3qfut4                  : Parameter_Integer  : Integer              :        0 
   --   57 : b3qfut5                  : Parameter_Integer  : Integer              :        0 
   --   58 : b3qfut6                  : Parameter_Integer  : Integer              :        0 
   --   59 : ben1q1                   : Parameter_Integer  : Integer              :        0 
   --   60 : ben1q2                   : Parameter_Integer  : Integer              :        0 
   --   61 : ben1q3                   : Parameter_Integer  : Integer              :        0 
   --   62 : ben1q4                   : Parameter_Integer  : Integer              :        0 
   --   63 : ben1q5                   : Parameter_Integer  : Integer              :        0 
   --   64 : ben1q6                   : Parameter_Integer  : Integer              :        0 
   --   65 : ben1q7                   : Parameter_Integer  : Integer              :        0 
   --   66 : ben2q1                   : Parameter_Integer  : Integer              :        0 
   --   67 : ben2q2                   : Parameter_Integer  : Integer              :        0 
   --   68 : ben2q3                   : Parameter_Integer  : Integer              :        0 
   --   69 : ben3q1                   : Parameter_Integer  : Integer              :        0 
   --   70 : ben3q2                   : Parameter_Integer  : Integer              :        0 
   --   71 : ben3q3                   : Parameter_Integer  : Integer              :        0 
   --   72 : ben3q4                   : Parameter_Integer  : Integer              :        0 
   --   73 : ben3q5                   : Parameter_Integer  : Integer              :        0 
   --   74 : ben3q6                   : Parameter_Integer  : Integer              :        0 
   --   75 : ben4q1                   : Parameter_Integer  : Integer              :        0 
   --   76 : ben4q2                   : Parameter_Integer  : Integer              :        0 
   --   77 : ben4q3                   : Parameter_Integer  : Integer              :        0 
   --   78 : ben5q1                   : Parameter_Integer  : Integer              :        0 
   --   79 : ben5q2                   : Parameter_Integer  : Integer              :        0 
   --   80 : ben5q3                   : Parameter_Integer  : Integer              :        0 
   --   81 : ben5q4                   : Parameter_Integer  : Integer              :        0 
   --   82 : ben5q5                   : Parameter_Integer  : Integer              :        0 
   --   83 : ben5q6                   : Parameter_Integer  : Integer              :        0 
   --   84 : ben7q1                   : Parameter_Integer  : Integer              :        0 
   --   85 : ben7q2                   : Parameter_Integer  : Integer              :        0 
   --   86 : ben7q3                   : Parameter_Integer  : Integer              :        0 
   --   87 : ben7q4                   : Parameter_Integer  : Integer              :        0 
   --   88 : ben7q5                   : Parameter_Integer  : Integer              :        0 
   --   89 : ben7q6                   : Parameter_Integer  : Integer              :        0 
   --   90 : ben7q7                   : Parameter_Integer  : Integer              :        0 
   --   91 : ben7q8                   : Parameter_Integer  : Integer              :        0 
   --   92 : ben7q9                   : Parameter_Integer  : Integer              :        0 
   --   93 : btwacc                   : Parameter_Integer  : Integer              :        0 
   --   94 : claimant                 : Parameter_Integer  : Integer              :        0 
   --   95 : cohabit                  : Parameter_Integer  : Integer              :        0 
   --   96 : combid                   : Parameter_Integer  : Integer              :        0 
   --   97 : convbl                   : Parameter_Integer  : Integer              :        0 
   --   98 : ctclum1                  : Parameter_Integer  : Integer              :        0 
   --   99 : ctclum2                  : Parameter_Integer  : Integer              :        0 
   --  100 : cupchk                   : Parameter_Integer  : Integer              :        0 
   --  101 : cvht                     : Parameter_Integer  : Integer              :        0 
   --  102 : cvpay                    : Parameter_Float    : Amount               :      0.0 
   --  103 : cvpd                     : Parameter_Integer  : Integer              :        0 
   --  104 : dentist                  : Parameter_Integer  : Integer              :        0 
   --  105 : depend                   : Parameter_Integer  : Integer              :        0 
   --  106 : disdif1                  : Parameter_Integer  : Integer              :        0 
   --  107 : disdif2                  : Parameter_Integer  : Integer              :        0 
   --  108 : disdif3                  : Parameter_Integer  : Integer              :        0 
   --  109 : disdif4                  : Parameter_Integer  : Integer              :        0 
   --  110 : disdif5                  : Parameter_Integer  : Integer              :        0 
   --  111 : disdif6                  : Parameter_Integer  : Integer              :        0 
   --  112 : disdif7                  : Parameter_Integer  : Integer              :        0 
   --  113 : disdif8                  : Parameter_Integer  : Integer              :        0 
   --  114 : dob                      : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  115 : dptcboth                 : Parameter_Integer  : Integer              :        0 
   --  116 : dptclum                  : Parameter_Integer  : Integer              :        0 
   --  117 : dvil03a                  : Parameter_Integer  : Integer              :        0 
   --  118 : dvil04a                  : Parameter_Integer  : Integer              :        0 
   --  119 : dvjb12ml                 : Parameter_Integer  : Integer              :        0 
   --  120 : dvmardf                  : Parameter_Integer  : Integer              :        0 
   --  121 : ed1amt                   : Parameter_Float    : Amount               :      0.0 
   --  122 : ed1borr                  : Parameter_Integer  : Integer              :        0 
   --  123 : ed1int                   : Parameter_Integer  : Integer              :        0 
   --  124 : ed1monyr                 : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  125 : ed1pd                    : Parameter_Integer  : Integer              :        0 
   --  126 : ed1sum                   : Parameter_Integer  : Integer              :        0 
   --  127 : ed2amt                   : Parameter_Float    : Amount               :      0.0 
   --  128 : ed2borr                  : Parameter_Integer  : Integer              :        0 
   --  129 : ed2int                   : Parameter_Integer  : Integer              :        0 
   --  130 : ed2monyr                 : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --  131 : ed2pd                    : Parameter_Integer  : Integer              :        0 
   --  132 : ed2sum                   : Parameter_Integer  : Integer              :        0 
   --  133 : edatt                    : Parameter_Integer  : Integer              :        0 
   --  134 : edattn1                  : Parameter_Integer  : Integer              :        0 
   --  135 : edattn2                  : Parameter_Integer  : Integer              :        0 
   --  136 : edattn3                  : Parameter_Integer  : Integer              :        0 
   --  137 : edhr                     : Parameter_Integer  : Integer              :        0 
   --  138 : edtime                   : Parameter_Integer  : Integer              :        0 
   --  139 : edtyp                    : Parameter_Integer  : Integer              :        0 
   --  140 : eligadlt                 : Parameter_Integer  : Integer              :        0 
   --  141 : eligchld                 : Parameter_Integer  : Integer              :        0 
   --  142 : emppay1                  : Parameter_Integer  : Integer              :        0 
   --  143 : emppay2                  : Parameter_Integer  : Integer              :        0 
   --  144 : emppay3                  : Parameter_Integer  : Integer              :        0 
   --  145 : empstat                  : Parameter_Integer  : Integer              :        0 
   --  146 : endyr                    : Parameter_Integer  : Integer              :        0 
   --  147 : epcur                    : Parameter_Integer  : Integer              :        0 
   --  148 : es2000                   : Parameter_Integer  : Integer              :        0 
   --  149 : ethgrp                   : Parameter_Integer  : Integer              :        0 
   --  150 : everwrk                  : Parameter_Integer  : Integer              :        0 
   --  151 : exthbct1                 : Parameter_Integer  : Integer              :        0 
   --  152 : exthbct2                 : Parameter_Integer  : Integer              :        0 
   --  153 : exthbct3                 : Parameter_Integer  : Integer              :        0 
   --  154 : eyetest                  : Parameter_Integer  : Integer              :        0 
   --  155 : follow                   : Parameter_Integer  : Integer              :        0 
   --  156 : fted                     : Parameter_Integer  : Integer              :        0 
   --  157 : ftwk                     : Parameter_Integer  : Integer              :        0 
   --  158 : future                   : Parameter_Integer  : Integer              :        0 
   --  159 : govpis                   : Parameter_Integer  : Integer              :        0 
   --  160 : govpjsa                  : Parameter_Integer  : Integer              :        0 
   --  161 : x_grant                  : Parameter_Integer  : Integer              :        0 
   --  162 : grtamt1                  : Parameter_Float    : Amount               :      0.0 
   --  163 : grtamt2                  : Parameter_Float    : Amount               :      0.0 
   --  164 : grtdir1                  : Parameter_Float    : Amount               :      0.0 
   --  165 : grtdir2                  : Parameter_Float    : Amount               :      0.0 
   --  166 : grtnum                   : Parameter_Integer  : Integer              :        0 
   --  167 : grtsce1                  : Parameter_Integer  : Integer              :        0 
   --  168 : grtsce2                  : Parameter_Integer  : Integer              :        0 
   --  169 : grtval1                  : Parameter_Float    : Amount               :      0.0 
   --  170 : grtval2                  : Parameter_Float    : Amount               :      0.0 
   --  171 : gta                      : Parameter_Integer  : Integer              :        0 
   --  172 : hbothamt                 : Parameter_Float    : Amount               :      0.0 
   --  173 : hbothbu                  : Parameter_Integer  : Integer              :        0 
   --  174 : hbothpd                  : Parameter_Integer  : Integer              :        0 
   --  175 : hbothwk                  : Parameter_Integer  : Integer              :        0 
   --  176 : hbotwait                 : Parameter_Integer  : Integer              :        0 
   --  177 : health                   : Parameter_Integer  : Integer              :        0 
   --  178 : hholder                  : Parameter_Integer  : Integer              :        0 
   --  179 : hosp                     : Parameter_Integer  : Integer              :        0 
   --  180 : hprob                    : Parameter_Integer  : Integer              :        0 
   --  181 : hrpid                    : Parameter_Integer  : Integer              :        0 
   --  182 : incdur                   : Parameter_Integer  : Integer              :        0 
   --  183 : injlong                  : Parameter_Integer  : Integer              :        0 
   --  184 : injwk                    : Parameter_Integer  : Integer              :        0 
   --  185 : invests                  : Parameter_Integer  : Integer              :        0 
   --  186 : iout                     : Parameter_Integer  : Integer              :        0 
   --  187 : isa1type                 : Parameter_Integer  : Integer              :        0 
   --  188 : isa2type                 : Parameter_Integer  : Integer              :        0 
   --  189 : isa3type                 : Parameter_Integer  : Integer              :        0 
   --  190 : jobaway                  : Parameter_Integer  : Integer              :        0 
   --  191 : lareg                    : Parameter_Integer  : Integer              :        0 
   --  192 : likewk                   : Parameter_Integer  : Integer              :        0 
   --  193 : lktime                   : Parameter_Integer  : Integer              :        0 
   --  194 : ln1rpint                 : Parameter_Integer  : Integer              :        0 
   --  195 : ln2rpint                 : Parameter_Integer  : Integer              :        0 
   --  196 : loan                     : Parameter_Integer  : Integer              :        0 
   --  197 : loannum                  : Parameter_Integer  : Integer              :        0 
   --  198 : look                     : Parameter_Integer  : Integer              :        0 
   --  199 : lookwk                   : Parameter_Integer  : Integer              :        0 
   --  200 : lstwrk1                  : Parameter_Integer  : Integer              :        0 
   --  201 : lstwrk2                  : Parameter_Integer  : Integer              :        0 
   --  202 : lstyr                    : Parameter_Integer  : Integer              :        0 
   --  203 : mntamt1                  : Parameter_Float    : Amount               :      0.0 
   --  204 : mntamt2                  : Parameter_Float    : Amount               :      0.0 
   --  205 : mntct                    : Parameter_Integer  : Integer              :        0 
   --  206 : mntfor1                  : Parameter_Integer  : Integer              :        0 
   --  207 : mntfor2                  : Parameter_Integer  : Integer              :        0 
   --  208 : mntgov1                  : Parameter_Integer  : Integer              :        0 
   --  209 : mntgov2                  : Parameter_Integer  : Integer              :        0 
   --  210 : mntpay                   : Parameter_Integer  : Integer              :        0 
   --  211 : mntpd1                   : Parameter_Integer  : Integer              :        0 
   --  212 : mntpd2                   : Parameter_Integer  : Integer              :        0 
   --  213 : mntrec                   : Parameter_Integer  : Integer              :        0 
   --  214 : mnttota1                 : Parameter_Integer  : Integer              :        0 
   --  215 : mnttota2                 : Parameter_Integer  : Integer              :        0 
   --  216 : mntus1                   : Parameter_Integer  : Integer              :        0 
   --  217 : mntus2                   : Parameter_Integer  : Integer              :        0 
   --  218 : mntusam1                 : Parameter_Float    : Amount               :      0.0 
   --  219 : mntusam2                 : Parameter_Float    : Amount               :      0.0 
   --  220 : mntuspd1                 : Parameter_Integer  : Integer              :        0 
   --  221 : mntuspd2                 : Parameter_Integer  : Integer              :        0 
   --  222 : ms                       : Parameter_Integer  : Integer              :        0 
   --  223 : natid1                   : Parameter_Integer  : Integer              :        0 
   --  224 : natid2                   : Parameter_Integer  : Integer              :        0 
   --  225 : natid3                   : Parameter_Integer  : Integer              :        0 
   --  226 : natid4                   : Parameter_Integer  : Integer              :        0 
   --  227 : natid5                   : Parameter_Integer  : Integer              :        0 
   --  228 : natid6                   : Parameter_Integer  : Integer              :        0 
   --  229 : ndeal                    : Parameter_Integer  : Integer              :        0 
   --  230 : newdtype                 : Parameter_Integer  : Integer              :        0 
   --  231 : nhs1                     : Parameter_Integer  : Integer              :        0 
   --  232 : nhs2                     : Parameter_Integer  : Integer              :        0 
   --  233 : nhs3                     : Parameter_Integer  : Integer              :        0 
   --  234 : niamt                    : Parameter_Float    : Amount               :      0.0 
   --  235 : niethgrp                 : Parameter_Integer  : Integer              :        0 
   --  236 : niexthbb                 : Parameter_Integer  : Integer              :        0 
   --  237 : ninatid1                 : Parameter_Integer  : Integer              :        0 
   --  238 : ninatid2                 : Parameter_Integer  : Integer              :        0 
   --  239 : ninatid3                 : Parameter_Integer  : Integer              :        0 
   --  240 : ninatid4                 : Parameter_Integer  : Integer              :        0 
   --  241 : ninatid5                 : Parameter_Integer  : Integer              :        0 
   --  242 : ninatid6                 : Parameter_Integer  : Integer              :        0 
   --  243 : ninatid7                 : Parameter_Integer  : Integer              :        0 
   --  244 : ninatid8                 : Parameter_Integer  : Integer              :        0 
   --  245 : nipd                     : Parameter_Integer  : Integer              :        0 
   --  246 : nireg                    : Parameter_Integer  : Integer              :        0 
   --  247 : nirel                    : Parameter_Integer  : Integer              :        0 
   --  248 : nitrain                  : Parameter_Integer  : Integer              :        0 
   --  249 : nlper                    : Parameter_Integer  : Integer              :        0 
   --  250 : nolk1                    : Parameter_Integer  : Integer              :        0 
   --  251 : nolk2                    : Parameter_Integer  : Integer              :        0 
   --  252 : nolk3                    : Parameter_Integer  : Integer              :        0 
   --  253 : nolook                   : Parameter_Integer  : Integer              :        0 
   --  254 : nowant                   : Parameter_Integer  : Integer              :        0 
   --  255 : nssec                    : Parameter_Float    : Amount               :      0.0 
   --  256 : ntcapp                   : Parameter_Integer  : Integer              :        0 
   --  257 : ntcdat                   : Parameter_Integer  : Integer              :        0 
   --  258 : ntcinc                   : Parameter_Float    : Amount               :      0.0 
   --  259 : ntcorig1                 : Parameter_Integer  : Integer              :        0 
   --  260 : ntcorig2                 : Parameter_Integer  : Integer              :        0 
   --  261 : ntcorig3                 : Parameter_Integer  : Integer              :        0 
   --  262 : ntcorig4                 : Parameter_Integer  : Integer              :        0 
   --  263 : ntcorig5                 : Parameter_Integer  : Integer              :        0 
   --  264 : numjob                   : Parameter_Integer  : Integer              :        0 
   --  265 : numjob2                  : Parameter_Integer  : Integer              :        0 
   --  266 : oddjob                   : Parameter_Integer  : Integer              :        0 
   --  267 : oldstud                  : Parameter_Integer  : Integer              :        0 
   --  268 : otabspar                 : Parameter_Integer  : Integer              :        0 
   --  269 : otamt                    : Parameter_Float    : Amount               :      0.0 
   --  270 : otapamt                  : Parameter_Float    : Amount               :      0.0 
   --  271 : otappd                   : Parameter_Integer  : Integer              :        0 
   --  272 : othtax                   : Parameter_Integer  : Integer              :        0 
   --  273 : otinva                   : Parameter_Integer  : Integer              :        0 
   --  274 : pareamt                  : Parameter_Float    : Amount               :      0.0 
   --  275 : parepd                   : Parameter_Integer  : Integer              :        0 
   --  276 : penlump                  : Parameter_Integer  : Integer              :        0 
   --  277 : ppnumc                   : Parameter_Integer  : Integer              :        0 
   --  278 : prit                     : Parameter_Integer  : Integer              :        0 
   --  279 : prscrpt                  : Parameter_Integer  : Integer              :        0 
   --  280 : ptwk                     : Parameter_Integer  : Integer              :        0 
   --  281 : r01                      : Parameter_Integer  : Integer              :        0 
   --  282 : r02                      : Parameter_Integer  : Integer              :        0 
   --  283 : r03                      : Parameter_Integer  : Integer              :        0 
   --  284 : r04                      : Parameter_Integer  : Integer              :        0 
   --  285 : r05                      : Parameter_Integer  : Integer              :        0 
   --  286 : r06                      : Parameter_Integer  : Integer              :        0 
   --  287 : r07                      : Parameter_Integer  : Integer              :        0 
   --  288 : r08                      : Parameter_Integer  : Integer              :        0 
   --  289 : r09                      : Parameter_Integer  : Integer              :        0 
   --  290 : r10                      : Parameter_Integer  : Integer              :        0 
   --  291 : r11                      : Parameter_Integer  : Integer              :        0 
   --  292 : r12                      : Parameter_Integer  : Integer              :        0 
   --  293 : r13                      : Parameter_Integer  : Integer              :        0 
   --  294 : r14                      : Parameter_Integer  : Integer              :        0 
   --  295 : redamt                   : Parameter_Float    : Amount               :      0.0 
   --  296 : redany                   : Parameter_Integer  : Integer              :        0 
   --  297 : rentprof                 : Parameter_Integer  : Integer              :        0 
   --  298 : retire                   : Parameter_Integer  : Integer              :        0 
   --  299 : retire1                  : Parameter_Integer  : Integer              :        0 
   --  300 : retreas                  : Parameter_Integer  : Integer              :        0 
   --  301 : royal1                   : Parameter_Integer  : Integer              :        0 
   --  302 : royal2                   : Parameter_Integer  : Integer              :        0 
   --  303 : royal3                   : Parameter_Integer  : Integer              :        0 
   --  304 : royal4                   : Parameter_Integer  : Integer              :        0 
   --  305 : royyr1                   : Parameter_Float    : Amount               :      0.0 
   --  306 : royyr2                   : Parameter_Float    : Amount               :      0.0 
   --  307 : royyr3                   : Parameter_Float    : Amount               :      0.0 
   --  308 : royyr4                   : Parameter_Float    : Amount               :      0.0 
   --  309 : rstrct                   : Parameter_Integer  : Integer              :        0 
   --  310 : sex                      : Parameter_Integer  : Integer              :        0 
   --  311 : sflntyp1                 : Parameter_Integer  : Integer              :        0 
   --  312 : sflntyp2                 : Parameter_Integer  : Integer              :        0 
   --  313 : sftype1                  : Parameter_Integer  : Integer              :        0 
   --  314 : sftype2                  : Parameter_Integer  : Integer              :        0 
   --  315 : sic                      : Parameter_Integer  : Integer              :        0 
   --  316 : slrepamt                 : Parameter_Float    : Amount               :      0.0 
   --  317 : slrepay                  : Parameter_Integer  : Integer              :        0 
   --  318 : slreppd                  : Parameter_Integer  : Integer              :        0 
   --  319 : soc2000                  : Parameter_Integer  : Integer              :        0 
   --  320 : spcreg1                  : Parameter_Integer  : Integer              :        0 
   --  321 : spcreg2                  : Parameter_Integer  : Integer              :        0 
   --  322 : spcreg3                  : Parameter_Integer  : Integer              :        0 
   --  323 : specs                    : Parameter_Integer  : Integer              :        0 
   --  324 : spout                    : Parameter_Integer  : Integer              :        0 
   --  325 : srentamt                 : Parameter_Float    : Amount               :      0.0 
   --  326 : srentpd                  : Parameter_Integer  : Integer              :        0 
   --  327 : start                    : Parameter_Integer  : Integer              :        0 
   --  328 : startyr                  : Parameter_Integer  : Integer              :        0 
   --  329 : taxcred1                 : Parameter_Integer  : Integer              :        0 
   --  330 : taxcred2                 : Parameter_Integer  : Integer              :        0 
   --  331 : taxcred3                 : Parameter_Integer  : Integer              :        0 
   --  332 : taxcred4                 : Parameter_Integer  : Integer              :        0 
   --  333 : taxcred5                 : Parameter_Integer  : Integer              :        0 
   --  334 : taxfut                   : Parameter_Integer  : Integer              :        0 
   --  335 : tdaywrk                  : Parameter_Integer  : Integer              :        0 
   --  336 : tea                      : Parameter_Integer  : Integer              :        0 
   --  337 : topupl                   : Parameter_Integer  : Integer              :        0 
   --  338 : totint                   : Parameter_Float    : Amount               :      0.0 
   --  339 : train                    : Parameter_Integer  : Integer              :        0 
   --  340 : trav                     : Parameter_Integer  : Integer              :        0 
   --  341 : tuborr                   : Parameter_Integer  : Integer              :        0 
   --  342 : typeed                   : Parameter_Integer  : Integer              :        0 
   --  343 : unpaid1                  : Parameter_Integer  : Integer              :        0 
   --  344 : unpaid2                  : Parameter_Integer  : Integer              :        0 
   --  345 : voucher                  : Parameter_Integer  : Integer              :        0 
   --  346 : w1                       : Parameter_Integer  : Integer              :        0 
   --  347 : w2                       : Parameter_Integer  : Integer              :        0 
   --  348 : wait                     : Parameter_Integer  : Integer              :        0 
   --  349 : war1                     : Parameter_Integer  : Integer              :        0 
   --  350 : war2                     : Parameter_Integer  : Integer              :        0 
   --  351 : wftcboth                 : Parameter_Integer  : Integer              :        0 
   --  352 : wftclum                  : Parameter_Integer  : Integer              :        0 
   --  353 : whoresp                  : Parameter_Integer  : Integer              :        0 
   --  354 : whosectb                 : Parameter_Integer  : Integer              :        0 
   --  355 : whyfrde1                 : Parameter_Integer  : Integer              :        0 
   --  356 : whyfrde2                 : Parameter_Integer  : Integer              :        0 
   --  357 : whyfrde3                 : Parameter_Integer  : Integer              :        0 
   --  358 : whyfrde4                 : Parameter_Integer  : Integer              :        0 
   --  359 : whyfrde5                 : Parameter_Integer  : Integer              :        0 
   --  360 : whyfrde6                 : Parameter_Integer  : Integer              :        0 
   --  361 : whyfrey1                 : Parameter_Integer  : Integer              :        0 
   --  362 : whyfrey2                 : Parameter_Integer  : Integer              :        0 
   --  363 : whyfrey3                 : Parameter_Integer  : Integer              :        0 
   --  364 : whyfrey4                 : Parameter_Integer  : Integer              :        0 
   --  365 : whyfrey5                 : Parameter_Integer  : Integer              :        0 
   --  366 : whyfrey6                 : Parameter_Integer  : Integer              :        0 
   --  367 : whyfrpr1                 : Parameter_Integer  : Integer              :        0 
   --  368 : whyfrpr2                 : Parameter_Integer  : Integer              :        0 
   --  369 : whyfrpr3                 : Parameter_Integer  : Integer              :        0 
   --  370 : whyfrpr4                 : Parameter_Integer  : Integer              :        0 
   --  371 : whyfrpr5                 : Parameter_Integer  : Integer              :        0 
   --  372 : whyfrpr6                 : Parameter_Integer  : Integer              :        0 
   --  373 : whytrav1                 : Parameter_Integer  : Integer              :        0 
   --  374 : whytrav2                 : Parameter_Integer  : Integer              :        0 
   --  375 : whytrav3                 : Parameter_Integer  : Integer              :        0 
   --  376 : whytrav4                 : Parameter_Integer  : Integer              :        0 
   --  377 : whytrav5                 : Parameter_Integer  : Integer              :        0 
   --  378 : whytrav6                 : Parameter_Integer  : Integer              :        0 
   --  379 : wintfuel                 : Parameter_Integer  : Integer              :        0 
   --  380 : wmkit                    : Parameter_Integer  : Integer              :        0 
   --  381 : working                  : Parameter_Integer  : Integer              :        0 
   --  382 : wpa                      : Parameter_Integer  : Integer              :        0 
   --  383 : wpba                     : Parameter_Integer  : Integer              :        0 
   --  384 : wtclum1                  : Parameter_Integer  : Integer              :        0 
   --  385 : wtclum2                  : Parameter_Integer  : Integer              :        0 
   --  386 : wtclum3                  : Parameter_Integer  : Integer              :        0 
   --  387 : ystrtwk                  : Parameter_Integer  : Integer              :        0 
   --  388 : month                    : Parameter_Integer  : Integer              :        0 
   --  389 : able                     : Parameter_Integer  : Integer              :        0 
   --  390 : actacci                  : Parameter_Integer  : Integer              :        0 
   --  391 : addda                    : Parameter_Integer  : Integer              :        0 
   --  392 : basacti                  : Parameter_Integer  : Integer              :        0 
   --  393 : bntxcred                 : Parameter_Float    : Amount               :      0.0 
   --  394 : careab                   : Parameter_Integer  : Integer              :        0 
   --  395 : careah                   : Parameter_Integer  : Integer              :        0 
   --  396 : carecb                   : Parameter_Integer  : Integer              :        0 
   --  397 : carech                   : Parameter_Integer  : Integer              :        0 
   --  398 : carecl                   : Parameter_Integer  : Integer              :        0 
   --  399 : carefl                   : Parameter_Integer  : Integer              :        0 
   --  400 : carefr                   : Parameter_Integer  : Integer              :        0 
   --  401 : careot                   : Parameter_Integer  : Integer              :        0 
   --  402 : carere                   : Parameter_Integer  : Integer              :        0 
   --  403 : curacti                  : Parameter_Integer  : Integer              :        0 
   --  404 : empoccp                  : Parameter_Float    : Amount               :      0.0 
   --  405 : empstatb                 : Parameter_Integer  : Integer              :        0 
   --  406 : empstatc                 : Parameter_Integer  : Integer              :        0 
   --  407 : empstati                 : Parameter_Integer  : Integer              :        0 
   --  408 : fsbndcti                 : Parameter_Integer  : Integer              :        0 
   --  409 : fwmlkval                 : Parameter_Float    : Amount               :      0.0 
   --  410 : gebacti                  : Parameter_Integer  : Integer              :        0 
   --  411 : giltcti                  : Parameter_Integer  : Integer              :        0 
   --  412 : gross2                   : Parameter_Integer  : Integer              :        0 
   --  413 : gross3                   : Parameter_Integer  : Integer              :        0 
   --  414 : hbsupran                 : Parameter_Float    : Amount               :      0.0 
   --  415 : hdage                    : Parameter_Integer  : Integer              :        0 
   --  416 : hdben                    : Parameter_Integer  : Integer              :        0 
   --  417 : hdindinc                 : Parameter_Integer  : Integer              :        0 
   --  418 : hourab                   : Parameter_Integer  : Integer              :        0 
   --  419 : hourah                   : Parameter_Integer  : Integer              :        0 
   --  420 : hourcare                 : Parameter_Float    : Amount               :      0.0 
   --  421 : hourcb                   : Parameter_Integer  : Integer              :        0 
   --  422 : hourch                   : Parameter_Integer  : Integer              :        0 
   --  423 : hourcl                   : Parameter_Integer  : Integer              :        0 
   --  424 : hourfr                   : Parameter_Integer  : Integer              :        0 
   --  425 : hourot                   : Parameter_Integer  : Integer              :        0 
   --  426 : hourre                   : Parameter_Integer  : Integer              :        0 
   --  427 : hourtot                  : Parameter_Integer  : Integer              :        0 
   --  428 : hperson                  : Parameter_Integer  : Integer              :        0 
   --  429 : iagegr2                  : Parameter_Integer  : Integer              :        0 
   --  430 : iagegrp                  : Parameter_Integer  : Integer              :        0 
   --  431 : incseo2                  : Parameter_Float    : Amount               :      0.0 
   --  432 : indinc                   : Parameter_Integer  : Integer              :        0 
   --  433 : indisben                 : Parameter_Integer  : Integer              :        0 
   --  434 : inearns                  : Parameter_Float    : Amount               :      0.0 
   --  435 : ininv                    : Parameter_Float    : Amount               :      0.0 
   --  436 : inirben                  : Parameter_Integer  : Integer              :        0 
   --  437 : innirben                 : Parameter_Integer  : Integer              :        0 
   --  438 : inothben                 : Parameter_Integer  : Integer              :        0 
   --  439 : inpeninc                 : Parameter_Float    : Amount               :      0.0 
   --  440 : inrinc                   : Parameter_Float    : Amount               :      0.0 
   --  441 : inrpinc                  : Parameter_Float    : Amount               :      0.0 
   --  442 : intvlic                  : Parameter_Float    : Amount               :      0.0 
   --  443 : intxcred                 : Parameter_Float    : Amount               :      0.0 
   --  444 : isacti                   : Parameter_Integer  : Integer              :        0 
   --  445 : marital                  : Parameter_Integer  : Integer              :        0 
   --  446 : netocpen                 : Parameter_Float    : Amount               :      0.0 
   --  447 : nincseo2                 : Parameter_Float    : Amount               :      0.0 
   --  448 : nindinc                  : Parameter_Integer  : Integer              :        0 
   --  449 : ninearns                 : Parameter_Integer  : Integer              :        0 
   --  450 : nininv                   : Parameter_Integer  : Integer              :        0 
   --  451 : ninpenin                 : Parameter_Integer  : Integer              :        0 
   --  452 : ninsein2                 : Parameter_Float    : Amount               :      0.0 
   --  453 : nsbocti                  : Parameter_Integer  : Integer              :        0 
   --  454 : occupnum                 : Parameter_Integer  : Integer              :        0 
   --  455 : otbscti                  : Parameter_Integer  : Integer              :        0 
   --  456 : pepscti                  : Parameter_Integer  : Integer              :        0 
   --  457 : poaccti                  : Parameter_Integer  : Integer              :        0 
   --  458 : prbocti                  : Parameter_Integer  : Integer              :        0 
   --  459 : relhrp                   : Parameter_Integer  : Integer              :        0 
   --  460 : sayecti                  : Parameter_Integer  : Integer              :        0 
   --  461 : sclbcti                  : Parameter_Integer  : Integer              :        0 
   --  462 : seincam2                 : Parameter_Float    : Amount               :      0.0 
   --  463 : smpadj                   : Parameter_Float    : Amount               :      0.0 
   --  464 : sscti                    : Parameter_Integer  : Integer              :        0 
   --  465 : sspadj                   : Parameter_Float    : Amount               :      0.0 
   --  466 : stshcti                  : Parameter_Integer  : Integer              :        0 
   --  467 : superan                  : Parameter_Float    : Amount               :      0.0 
   --  468 : taxpayer                 : Parameter_Integer  : Integer              :        0 
   --  469 : tesscti                  : Parameter_Integer  : Integer              :        0 
   --  470 : totgrant                 : Parameter_Float    : Amount               :      0.0 
   --  471 : tothours                 : Parameter_Float    : Amount               :      0.0 
   --  472 : totoccp                  : Parameter_Float    : Amount               :      0.0 
   --  473 : ttwcosts                 : Parameter_Float    : Amount               :      0.0 
   --  474 : untrcti                  : Parameter_Integer  : Integer              :        0 
   --  475 : uperson                  : Parameter_Integer  : Integer              :        0 
   --  476 : widoccp                  : Parameter_Float    : Amount               :      0.0 
   --  477 : accountq                 : Parameter_Integer  : Integer              :        0 
   --  478 : ben5q7                   : Parameter_Integer  : Integer              :        0 
   --  479 : ben5q8                   : Parameter_Integer  : Integer              :        0 
   --  480 : ben5q9                   : Parameter_Integer  : Integer              :        0 
   --  481 : ddatre                   : Parameter_Integer  : Integer              :        0 
   --  482 : disdif9                  : Parameter_Integer  : Integer              :        0 
   --  483 : fare                     : Parameter_Float    : Amount               :      0.0 
   --  484 : nittwmod                 : Parameter_Integer  : Integer              :        0 
   --  485 : oneway                   : Parameter_Integer  : Integer              :        0 
   --  486 : pssamt                   : Parameter_Float    : Amount               :      0.0 
   --  487 : pssdate                  : Parameter_Integer  : Integer              :        0 
   --  488 : ttwcode1                 : Parameter_Integer  : Integer              :        0 
   --  489 : ttwcode2                 : Parameter_Integer  : Integer              :        0 
   --  490 : ttwcode3                 : Parameter_Integer  : Integer              :        0 
   --  491 : ttwcost                  : Parameter_Float    : Amount               :      0.0 
   --  492 : ttwfar                   : Parameter_Integer  : Integer              :        0 
   --  493 : ttwfrq                   : Parameter_Float    : Amount               :      0.0 
   --  494 : ttwmod                   : Parameter_Integer  : Integer              :        0 
   --  495 : ttwpay                   : Parameter_Integer  : Integer              :        0 
   --  496 : ttwpss                   : Parameter_Integer  : Integer              :        0 
   --  497 : ttwrec                   : Parameter_Float    : Amount               :      0.0 
   --  498 : chbflg                   : Parameter_Integer  : Integer              :        0 
   --  499 : crunaci                  : Parameter_Integer  : Integer              :        0 
   --  500 : enomorti                 : Parameter_Integer  : Integer              :        0 
   --  501 : sapadj                   : Parameter_Float    : Amount               :      0.0 
   --  502 : sppadj                   : Parameter_Float    : Amount               :      0.0 
   --  503 : ttwmode                  : Parameter_Integer  : Integer              :        0 
   --  504 : ddatrep                  : Parameter_Integer  : Integer              :        0 
   --  505 : defrpen                  : Parameter_Integer  : Integer              :        0 
   --  506 : disdifp                  : Parameter_Integer  : Integer              :        0 
   --  507 : followup                 : Parameter_Integer  : Integer              :        0 
   --  508 : practice                 : Parameter_Integer  : Integer              :        0 
   --  509 : sfrpis                   : Parameter_Integer  : Integer              :        0 
   --  510 : sfrpjsa                  : Parameter_Integer  : Integer              :        0 
   --  511 : age80                    : Parameter_Integer  : Integer              :        0 
   --  512 : ethgr2                   : Parameter_Integer  : Integer              :        0 
   --  513 : pocardi                  : Parameter_Integer  : Integer              :        0 
   --  514 : chkdpn                   : Parameter_Integer  : Integer              :        0 
   --  515 : chknop                   : Parameter_Integer  : Integer              :        0 
   --  516 : consent                  : Parameter_Integer  : Integer              :        0 
   --  517 : dvpens                   : Parameter_Integer  : Integer              :        0 
   --  518 : eligschm                 : Parameter_Integer  : Integer              :        0 
   --  519 : emparr                   : Parameter_Integer  : Integer              :        0 
   --  520 : emppen                   : Parameter_Integer  : Integer              :        0 
   --  521 : empschm                  : Parameter_Integer  : Integer              :        0 
   --  522 : lnkref1                  : Parameter_Integer  : Integer              :        0 
   --  523 : lnkref2                  : Parameter_Integer  : Integer              :        0 
   --  524 : lnkref21                 : Parameter_Integer  : Integer              :        0 
   --  525 : lnkref22                 : Parameter_Integer  : Integer              :        0 
   --  526 : lnkref23                 : Parameter_Integer  : Integer              :        0 
   --  527 : lnkref24                 : Parameter_Integer  : Integer              :        0 
   --  528 : lnkref25                 : Parameter_Integer  : Integer              :        0 
   --  529 : lnkref3                  : Parameter_Integer  : Integer              :        0 
   --  530 : lnkref4                  : Parameter_Integer  : Integer              :        0 
   --  531 : lnkref5                  : Parameter_Integer  : Integer              :        0 
   --  532 : memschm                  : Parameter_Integer  : Integer              :        0 
   --  533 : pconsent                 : Parameter_Integer  : Integer              :        0 
   --  534 : perspen1                 : Parameter_Integer  : Integer              :        0 
   --  535 : perspen2                 : Parameter_Integer  : Integer              :        0 
   --  536 : privpen                  : Parameter_Integer  : Integer              :        0 
   --  537 : schchk                   : Parameter_Integer  : Integer              :        0 
   --  538 : spnumc                   : Parameter_Integer  : Integer              :        0 
   --  539 : stakep                   : Parameter_Integer  : Integer              :        0 
   --  540 : trainee                  : Parameter_Integer  : Integer              :        0 
   --  541 : lnkdwp                   : Parameter_Integer  : Integer              :        0 
   --  542 : lnkons                   : Parameter_Integer  : Integer              :        0 
   --  543 : lnkref6                  : Parameter_Integer  : Integer              :        0 
   --  544 : lnkref7                  : Parameter_Integer  : Integer              :        0 
   --  545 : lnkref8                  : Parameter_Integer  : Integer              :        0 
   --  546 : lnkref9                  : Parameter_Integer  : Integer              :        0 
   --  547 : tcever1                  : Parameter_Integer  : Integer              :        0 
   --  548 : tcever2                  : Parameter_Integer  : Integer              :        0 
   --  549 : tcrepay1                 : Parameter_Integer  : Integer              :        0 
   --  550 : tcrepay2                 : Parameter_Integer  : Integer              :        0 
   --  551 : tcrepay3                 : Parameter_Integer  : Integer              :        0 
   --  552 : tcrepay4                 : Parameter_Integer  : Integer              :        0 
   --  553 : tcrepay5                 : Parameter_Integer  : Integer              :        0 
   --  554 : tcrepay6                 : Parameter_Integer  : Integer              :        0 
   --  555 : tcthsyr1                 : Parameter_Integer  : Integer              :        0 
   --  556 : tcthsyr2                 : Parameter_Integer  : Integer              :        0 
   --  557 : currjobm                 : Parameter_Integer  : Integer              :        0 
   --  558 : prevjobm                 : Parameter_Integer  : Integer              :        0 
   --  559 : b3qfut7                  : Parameter_Integer  : Integer              :        0 
   --  560 : ben3q7                   : Parameter_Integer  : Integer              :        0 
   --  561 : camemt                   : Parameter_Integer  : Integer              :        0 
   --  562 : cameyr                   : Parameter_Integer  : Integer              :        0 
   --  563 : cameyr2                  : Parameter_Integer  : Integer              :        0 
   --  564 : contuk                   : Parameter_Integer  : Integer              :        0 
   --  565 : corign                   : Parameter_Integer  : Integer              :        0 
   --  566 : ddaprog                  : Parameter_Integer  : Integer              :        0 
   --  567 : hbolng                   : Parameter_Integer  : Integer              :        0 
   --  568 : hi1qual1                 : Parameter_Integer  : Integer              :        0 
   --  569 : hi1qual2                 : Parameter_Integer  : Integer              :        0 
   --  570 : hi1qual3                 : Parameter_Integer  : Integer              :        0 
   --  571 : hi1qual4                 : Parameter_Integer  : Integer              :        0 
   --  572 : hi1qual5                 : Parameter_Integer  : Integer              :        0 
   --  573 : hi1qual6                 : Parameter_Integer  : Integer              :        0 
   --  574 : hi2qual                  : Parameter_Integer  : Integer              :        0 
   --  575 : hlpgvn01                 : Parameter_Integer  : Integer              :        0 
   --  576 : hlpgvn02                 : Parameter_Integer  : Integer              :        0 
   --  577 : hlpgvn03                 : Parameter_Integer  : Integer              :        0 
   --  578 : hlpgvn04                 : Parameter_Integer  : Integer              :        0 
   --  579 : hlpgvn05                 : Parameter_Integer  : Integer              :        0 
   --  580 : hlpgvn06                 : Parameter_Integer  : Integer              :        0 
   --  581 : hlpgvn07                 : Parameter_Integer  : Integer              :        0 
   --  582 : hlpgvn08                 : Parameter_Integer  : Integer              :        0 
   --  583 : hlpgvn09                 : Parameter_Integer  : Integer              :        0 
   --  584 : hlpgvn10                 : Parameter_Integer  : Integer              :        0 
   --  585 : hlpgvn11                 : Parameter_Integer  : Integer              :        0 
   --  586 : hlprec01                 : Parameter_Integer  : Integer              :        0 
   --  587 : hlprec02                 : Parameter_Integer  : Integer              :        0 
   --  588 : hlprec03                 : Parameter_Integer  : Integer              :        0 
   --  589 : hlprec04                 : Parameter_Integer  : Integer              :        0 
   --  590 : hlprec05                 : Parameter_Integer  : Integer              :        0 
   --  591 : hlprec06                 : Parameter_Integer  : Integer              :        0 
   --  592 : hlprec07                 : Parameter_Integer  : Integer              :        0 
   --  593 : hlprec08                 : Parameter_Integer  : Integer              :        0 
   --  594 : hlprec09                 : Parameter_Integer  : Integer              :        0 
   --  595 : hlprec10                 : Parameter_Integer  : Integer              :        0 
   --  596 : hlprec11                 : Parameter_Integer  : Integer              :        0 
   --  597 : issue                    : Parameter_Integer  : Integer              :        0 
   --  598 : loangvn1                 : Parameter_Integer  : Integer              :        0 
   --  599 : loangvn2                 : Parameter_Integer  : Integer              :        0 
   --  600 : loangvn3                 : Parameter_Integer  : Integer              :        0 
   --  601 : loanrec1                 : Parameter_Integer  : Integer              :        0 
   --  602 : loanrec2                 : Parameter_Integer  : Integer              :        0 
   --  603 : loanrec3                 : Parameter_Integer  : Integer              :        0 
   --  604 : mntarr1                  : Parameter_Integer  : Integer              :        0 
   --  605 : mntarr2                  : Parameter_Integer  : Integer              :        0 
   --  606 : mntarr3                  : Parameter_Integer  : Integer              :        0 
   --  607 : mntarr4                  : Parameter_Integer  : Integer              :        0 
   --  608 : mntnrp                   : Parameter_Integer  : Integer              :        0 
   --  609 : othqual1                 : Parameter_Integer  : Integer              :        0 
   --  610 : othqual2                 : Parameter_Integer  : Integer              :        0 
   --  611 : othqual3                 : Parameter_Integer  : Integer              :        0 
   --  612 : tea9697                  : Parameter_Integer  : Integer              :        0 
   --  613 : heartval                 : Parameter_Float    : Amount               :      0.0 
   --  614 : iagegr3                  : Parameter_Integer  : Integer              :        0 
   --  615 : iagegr4                  : Parameter_Integer  : Integer              :        0 
   --  616 : nirel2                   : Parameter_Integer  : Integer              :        0 
   --  617 : xbonflag                 : Parameter_Integer  : Integer              :        0 
   --  618 : alg                      : Parameter_Integer  : Integer              :        0 
   --  619 : algamt                   : Parameter_Float    : Amount               :      0.0 
   --  620 : algpd                    : Parameter_Integer  : Integer              :        0 
   --  621 : ben4q4                   : Parameter_Integer  : Integer              :        0 
   --  622 : chkctc                   : Parameter_Integer  : Integer              :        0 
   --  623 : chkdpco1                 : Parameter_Integer  : Integer              :        0 
   --  624 : chkdpco2                 : Parameter_Integer  : Integer              :        0 
   --  625 : chkdpco3                 : Parameter_Integer  : Integer              :        0 
   --  626 : chkdsco1                 : Parameter_Integer  : Integer              :        0 
   --  627 : chkdsco2                 : Parameter_Integer  : Integer              :        0 
   --  628 : chkdsco3                 : Parameter_Integer  : Integer              :        0 
   --  629 : dv09pens                 : Parameter_Integer  : Integer              :        0 
   --  630 : lnkref01                 : Parameter_Integer  : Integer              :        0 
   --  631 : lnkref02                 : Parameter_Integer  : Integer              :        0 
   --  632 : lnkref03                 : Parameter_Integer  : Integer              :        0 
   --  633 : lnkref04                 : Parameter_Integer  : Integer              :        0 
   --  634 : lnkref05                 : Parameter_Integer  : Integer              :        0 
   --  635 : lnkref06                 : Parameter_Integer  : Integer              :        0 
   --  636 : lnkref07                 : Parameter_Integer  : Integer              :        0 
   --  637 : lnkref08                 : Parameter_Integer  : Integer              :        0 
   --  638 : lnkref09                 : Parameter_Integer  : Integer              :        0 
   --  639 : lnkref10                 : Parameter_Integer  : Integer              :        0 
   --  640 : lnkref11                 : Parameter_Integer  : Integer              :        0 
   --  641 : spyrot                   : Parameter_Integer  : Integer              :        0 
   --  642 : disdifad                 : Parameter_Integer  : Integer              :        0 
   --  643 : gross3_x                 : Parameter_Integer  : Integer              :        0 
   --  644 : aliamt                   : Parameter_Float    : Amount               :      0.0 
   --  645 : alimny                   : Parameter_Integer  : Integer              :        0 
   --  646 : alipd                    : Parameter_Integer  : Integer              :        0 
   --  647 : alius                    : Parameter_Integer  : Integer              :        0 
   --  648 : aluamt                   : Parameter_Float    : Amount               :      0.0 
   --  649 : alupd                    : Parameter_Integer  : Integer              :        0 
   --  650 : cbaamt                   : Parameter_Integer  : Integer              :        0 
   --  651 : hsvper                   : Parameter_Integer  : Integer              :        0 
   --  652 : mednum                   : Parameter_Integer  : Integer              :        0 
   --  653 : medprpd                  : Parameter_Integer  : Integer              :        0 
   --  654 : medprpy                  : Parameter_Integer  : Integer              :        0 
   --  655 : penflag                  : Parameter_Integer  : Integer              :        0 
   --  656 : ppchk1                   : Parameter_Integer  : Integer              :        0 
   --  657 : ppchk2                   : Parameter_Integer  : Integer              :        0 
   --  658 : ppchk3                   : Parameter_Integer  : Integer              :        0 
   --  659 : ttbprx                   : Parameter_Float    : Amount               :      0.0 
   --  660 : mjobsect                 : Parameter_Integer  : Integer              :        0 
   --  661 : etngrp                   : Parameter_Integer  : Integer              :        0 
   --  662 : medpay                   : Parameter_Integer  : Integer              :        0 
   --  663 : medrep                   : Parameter_Integer  : Integer              :        0 
   --  664 : medrpnm                  : Parameter_Integer  : Integer              :        0 
   --  665 : nanid1                   : Parameter_Integer  : Integer              :        0 
   --  666 : nanid2                   : Parameter_Integer  : Integer              :        0 
   --  667 : nanid3                   : Parameter_Integer  : Integer              :        0 
   --  668 : nanid4                   : Parameter_Integer  : Integer              :        0 
   --  669 : nanid5                   : Parameter_Integer  : Integer              :        0 
   --  670 : nanid6                   : Parameter_Integer  : Integer              :        0 
   --  671 : nietngrp                 : Parameter_Integer  : Integer              :        0 
   --  672 : ninanid1                 : Parameter_Integer  : Integer              :        0 
   --  673 : ninanid2                 : Parameter_Integer  : Integer              :        0 
   --  674 : ninanid3                 : Parameter_Integer  : Integer              :        0 
   --  675 : ninanid4                 : Parameter_Integer  : Integer              :        0 
   --  676 : ninanid5                 : Parameter_Integer  : Integer              :        0 
   --  677 : ninanid6                 : Parameter_Integer  : Integer              :        0 
   --  678 : ninanid7                 : Parameter_Integer  : Integer              :        0 
   --  679 : nirelig                  : Parameter_Integer  : Integer              :        0 
   --  680 : pollopin                 : Parameter_Integer  : Integer              :        0 
   --  681 : religenw                 : Parameter_Integer  : Integer              :        0 
   --  682 : religsc                  : Parameter_Integer  : Integer              :        0 
   --  683 : sidqn                    : Parameter_Integer  : Integer              :        0 
   --  684 : soc2010                  : Parameter_Integer  : Integer              :        0 
   --  685 : corignan                 : Parameter_Integer  : Integer              :        0 
   --  686 : dobmonth                 : Parameter_Integer  : Integer              :        0 
   --  687 : dobyear                  : Parameter_Integer  : Integer              :        0 
   --  688 : ethgr3                   : Parameter_Integer  : Integer              :        0 
   --  689 : ninanida                 : Parameter_Integer  : Integer              :        0 
   --  690 : agehqual                 : Parameter_Integer  : Integer              :        0 
   --  691 : bfd                      : Parameter_Integer  : Integer              :        0 
   --  692 : bfdamt                   : Parameter_Float    : Amount               :      0.0 
   --  693 : bfdpd                    : Parameter_Integer  : Integer              :        0 
   --  694 : bfdval                   : Parameter_Integer  : Integer              :        0 
   --  695 : btec                     : Parameter_Integer  : Integer              :        0 
   --  696 : btecnow                  : Parameter_Integer  : Integer              :        0 
   --  697 : cbaamt2                  : Parameter_Integer  : Integer              :        0 
   --  698 : change                   : Parameter_Integer  : Integer              :        0 
   --  699 : citizen                  : Parameter_Integer  : Integer              :        0 
   --  700 : citizen2                 : Parameter_Integer  : Integer              :        0 
   --  701 : condit                   : Parameter_Integer  : Integer              :        0 
   --  702 : corigoth                 : Parameter_Integer  : Integer              :        0 
   --  703 : curqual                  : Parameter_Integer  : Integer              :        0 
   --  704 : ddaprog1                 : Parameter_Integer  : Integer              :        0 
   --  705 : ddatre1                  : Parameter_Integer  : Integer              :        0 
   --  706 : ddatrep1                 : Parameter_Integer  : Integer              :        0 
   --  707 : degree                   : Parameter_Integer  : Integer              :        0 
   --  708 : degrenow                 : Parameter_Integer  : Integer              :        0 
   --  709 : denrec                   : Parameter_Integer  : Integer              :        0 
   --  710 : disd01                   : Parameter_Integer  : Integer              :        0 
   --  711 : disd02                   : Parameter_Integer  : Integer              :        0 
   --  712 : disd03                   : Parameter_Integer  : Integer              :        0 
   --  713 : disd04                   : Parameter_Integer  : Integer              :        0 
   --  714 : disd05                   : Parameter_Integer  : Integer              :        0 
   --  715 : disd06                   : Parameter_Integer  : Integer              :        0 
   --  716 : disd07                   : Parameter_Integer  : Integer              :        0 
   --  717 : disd08                   : Parameter_Integer  : Integer              :        0 
   --  718 : disd09                   : Parameter_Integer  : Integer              :        0 
   --  719 : disd10                   : Parameter_Integer  : Integer              :        0 
   --  720 : disdifp1                 : Parameter_Integer  : Integer              :        0 
   --  721 : empcontr                 : Parameter_Integer  : Integer              :        0 
   --  722 : ethgrps                  : Parameter_Integer  : Integer              :        0 
   --  723 : eualiamt                 : Parameter_Float    : Amount               :      0.0 
   --  724 : eualimny                 : Parameter_Integer  : Integer              :        0 
   --  725 : eualipd                  : Parameter_Integer  : Integer              :        0 
   --  726 : euetype                  : Parameter_Integer  : Integer              :        0 
   --  727 : followsc                 : Parameter_Integer  : Integer              :        0 
   --  728 : health1                  : Parameter_Integer  : Integer              :        0 
   --  729 : heathad                  : Parameter_Integer  : Integer              :        0 
   --  730 : hi3qual                  : Parameter_Integer  : Integer              :        0 
   --  731 : higho                    : Parameter_Integer  : Integer              :        0 
   --  732 : highonow                 : Parameter_Integer  : Integer              :        0 
   --  733 : jobbyr                   : Parameter_Integer  : Integer              :        0 
   --  734 : limitl                   : Parameter_Integer  : Integer              :        0 
   --  735 : lktrain                  : Parameter_Integer  : Integer              :        0 
   --  736 : lkwork                   : Parameter_Integer  : Integer              :        0 
   --  737 : medrec                   : Parameter_Integer  : Integer              :        0 
   --  738 : nvqlenow                 : Parameter_Integer  : Integer              :        0 
   --  739 : nvqlev                   : Parameter_Integer  : Integer              :        0 
   --  740 : othpass                  : Parameter_Integer  : Integer              :        0 
   --  741 : ppper                    : Parameter_Integer  : Integer              :        0 
   --  742 : proptax                  : Parameter_Float    : Amount               :      0.0 
   --  743 : reasden                  : Parameter_Integer  : Integer              :        0 
   --  744 : reasmed                  : Parameter_Integer  : Integer              :        0 
   --  745 : reasnhs                  : Parameter_Integer  : Integer              :        0 
   --  746 : reason                   : Parameter_Integer  : Integer              :        0 
   --  747 : rednet                   : Parameter_Integer  : Integer              :        0 
   --  748 : redtax                   : Parameter_Float    : Amount               :      0.0 
   --  749 : rsa                      : Parameter_Integer  : Integer              :        0 
   --  750 : rsanow                   : Parameter_Integer  : Integer              :        0 
   --  751 : samesit                  : Parameter_Integer  : Integer              :        0 
   --  752 : scotvec                  : Parameter_Integer  : Integer              :        0 
   --  753 : sctvnow                  : Parameter_Integer  : Integer              :        0 
   --  754 : sdemp01                  : Parameter_Integer  : Integer              :        0 
   --  755 : sdemp02                  : Parameter_Integer  : Integer              :        0 
   --  756 : sdemp03                  : Parameter_Integer  : Integer              :        0 
   --  757 : sdemp04                  : Parameter_Integer  : Integer              :        0 
   --  758 : sdemp05                  : Parameter_Integer  : Integer              :        0 
   --  759 : sdemp06                  : Parameter_Integer  : Integer              :        0 
   --  760 : sdemp07                  : Parameter_Integer  : Integer              :        0 
   --  761 : sdemp08                  : Parameter_Integer  : Integer              :        0 
   --  762 : sdemp09                  : Parameter_Integer  : Integer              :        0 
   --  763 : sdemp10                  : Parameter_Integer  : Integer              :        0 
   --  764 : sdemp11                  : Parameter_Integer  : Integer              :        0 
   --  765 : sdemp12                  : Parameter_Integer  : Integer              :        0 
   --  766 : selfdemp                 : Parameter_Integer  : Integer              :        0 
   --  767 : tempjob                  : Parameter_Integer  : Integer              :        0 
   --  768 : agehq80                  : Parameter_Integer  : Integer              :        0 
   --  769 : disacta1                 : Parameter_Integer  : Integer              :        0 
   --  770 : discora1                 : Parameter_Integer  : Integer              :        0 
   --  771 : gross4                   : Parameter_Integer  : Integer              :        0 
   --  772 : ninrinc                  : Parameter_Integer  : Integer              :        0 
   --  773 : typeed2                  : Parameter_Integer  : Integer              :        0 
   --  774 : w45                      : Parameter_Integer  : Integer              :        0 
   --  775 : accmsat                  : Parameter_Integer  : Integer              :        0 
   --  776 : c2orign                  : Parameter_Integer  : Integer              :        0 
   --  777 : calm                     : Parameter_Integer  : Integer              :        0 
   --  778 : cbchk                    : Parameter_Integer  : Integer              :        0 
   --  779 : claifut1                 : Parameter_Integer  : Integer              :        0 
   --  780 : claifut2                 : Parameter_Integer  : Integer              :        0 
   --  781 : claifut3                 : Parameter_Integer  : Integer              :        0 
   --  782 : claifut4                 : Parameter_Integer  : Integer              :        0 
   --  783 : claifut5                 : Parameter_Integer  : Integer              :        0 
   --  784 : claifut6                 : Parameter_Integer  : Integer              :        0 
   --  785 : claifut7                 : Parameter_Integer  : Integer              :        0 
   --  786 : claifut8                 : Parameter_Integer  : Integer              :        0 
   --  787 : commusat                 : Parameter_Integer  : Integer              :        0 
   --  788 : coptrust                 : Parameter_Integer  : Integer              :        0 
   --  789 : depress                  : Parameter_Integer  : Integer              :        0 
   --  790 : disben1                  : Parameter_Integer  : Integer              :        0 
   --  791 : disben2                  : Parameter_Integer  : Integer              :        0 
   --  792 : disben3                  : Parameter_Integer  : Integer              :        0 
   --  793 : disben4                  : Parameter_Integer  : Integer              :        0 
   --  794 : disben5                  : Parameter_Integer  : Integer              :        0 
   --  795 : disben6                  : Parameter_Integer  : Integer              :        0 
   --  796 : discuss                  : Parameter_Integer  : Integer              :        0 
   --  797 : dla1                     : Parameter_Integer  : Integer              :        0 
   --  798 : dla2                     : Parameter_Integer  : Integer              :        0 
   --  799 : dls                      : Parameter_Integer  : Integer              :        0 
   --  800 : dlsamt                   : Parameter_Float    : Amount               :      0.0 
   --  801 : dlspd                    : Parameter_Integer  : Integer              :        0 
   --  802 : dlsval                   : Parameter_Integer  : Integer              :        0 
   --  803 : down                     : Parameter_Integer  : Integer              :        0 
   --  804 : envirsat                 : Parameter_Integer  : Integer              :        0 
   --  805 : gpispc                   : Parameter_Integer  : Integer              :        0 
   --  806 : gpjsaesa                 : Parameter_Integer  : Integer              :        0 
   --  807 : happy                    : Parameter_Integer  : Integer              :        0 
   --  808 : help                     : Parameter_Integer  : Integer              :        0 
   --  809 : iclaim1                  : Parameter_Integer  : Integer              :        0 
   --  810 : iclaim2                  : Parameter_Integer  : Integer              :        0 
   --  811 : iclaim3                  : Parameter_Integer  : Integer              :        0 
   --  812 : iclaim4                  : Parameter_Integer  : Integer              :        0 
   --  813 : iclaim5                  : Parameter_Integer  : Integer              :        0 
   --  814 : iclaim6                  : Parameter_Integer  : Integer              :        0 
   --  815 : iclaim7                  : Parameter_Integer  : Integer              :        0 
   --  816 : iclaim8                  : Parameter_Integer  : Integer              :        0 
   --  817 : iclaim9                  : Parameter_Integer  : Integer              :        0 
   --  818 : jobsat                   : Parameter_Integer  : Integer              :        0 
   --  819 : kidben1                  : Parameter_Integer  : Integer              :        0 
   --  820 : kidben2                  : Parameter_Integer  : Integer              :        0 
   --  821 : kidben3                  : Parameter_Integer  : Integer              :        0 
   --  822 : legltrus                 : Parameter_Integer  : Integer              :        0 
   --  823 : lifesat                  : Parameter_Integer  : Integer              :        0 
   --  824 : meaning                  : Parameter_Integer  : Integer              :        0 
   --  825 : moneysat                 : Parameter_Integer  : Integer              :        0 
   --  826 : nervous                  : Parameter_Integer  : Integer              :        0 
   --  827 : ni2train                 : Parameter_Integer  : Integer              :        0 
   --  828 : othben1                  : Parameter_Integer  : Integer              :        0 
   --  829 : othben2                  : Parameter_Integer  : Integer              :        0 
   --  830 : othben3                  : Parameter_Integer  : Integer              :        0 
   --  831 : othben4                  : Parameter_Integer  : Integer              :        0 
   --  832 : othben5                  : Parameter_Integer  : Integer              :        0 
   --  833 : othben6                  : Parameter_Integer  : Integer              :        0 
   --  834 : othtrust                 : Parameter_Integer  : Integer              :        0 
   --  835 : penben1                  : Parameter_Integer  : Integer              :        0 
   --  836 : penben2                  : Parameter_Integer  : Integer              :        0 
   --  837 : penben3                  : Parameter_Integer  : Integer              :        0 
   --  838 : penben4                  : Parameter_Integer  : Integer              :        0 
   --  839 : penben5                  : Parameter_Integer  : Integer              :        0 
   --  840 : pip1                     : Parameter_Integer  : Integer              :        0 
   --  841 : pip2                     : Parameter_Integer  : Integer              :        0 
   --  842 : polttrus                 : Parameter_Integer  : Integer              :        0 
   --  843 : recsat                   : Parameter_Integer  : Integer              :        0 
   --  844 : relasat                  : Parameter_Integer  : Integer              :        0 
   --  845 : safe                     : Parameter_Integer  : Integer              :        0 
   --  846 : socfund1                 : Parameter_Integer  : Integer              :        0 
   --  847 : socfund2                 : Parameter_Integer  : Integer              :        0 
   --  848 : socfund3                 : Parameter_Integer  : Integer              :        0 
   --  849 : socfund4                 : Parameter_Integer  : Integer              :        0 
   --  850 : srispc                   : Parameter_Integer  : Integer              :        0 
   --  851 : srjsaesa                 : Parameter_Integer  : Integer              :        0 
   --  852 : timesat                  : Parameter_Integer  : Integer              :        0 
   --  853 : train2                   : Parameter_Integer  : Integer              :        0 
   --  854 : trnallow                 : Parameter_Integer  : Integer              :        0 
   --  855 : wageben1                 : Parameter_Integer  : Integer              :        0 
   --  856 : wageben2                 : Parameter_Integer  : Integer              :        0 
   --  857 : wageben3                 : Parameter_Integer  : Integer              :        0 
   --  858 : wageben4                 : Parameter_Integer  : Integer              :        0 
   --  859 : wageben5                 : Parameter_Integer  : Integer              :        0 
   --  860 : wageben6                 : Parameter_Integer  : Integer              :        0 
   --  861 : wageben7                 : Parameter_Integer  : Integer              :        0 
   --  862 : wageben8                 : Parameter_Integer  : Integer              :        0 
   --  863 : ninnirbn                 : Parameter_Integer  : Integer              :        0 
   --  864 : ninothbn                 : Parameter_Integer  : Integer              :        0 
   --  865 : anxious                  : Parameter_Integer  : Integer              :        0 
   --  866 : candgnow                 : Parameter_Integer  : Integer              :        0 
   --  867 : curothf                  : Parameter_Integer  : Integer              :        0 
   --  868 : curothp                  : Parameter_Integer  : Integer              :        0 
   --  869 : curothwv                 : Parameter_Integer  : Integer              :        0 
   --  870 : dvhiqual                 : Parameter_Integer  : Integer              :        0 
   --  871 : gnvqnow                  : Parameter_Integer  : Integer              :        0 
   --  872 : gpuc                     : Parameter_Integer  : Integer              :        0 
   --  873 : happywb                  : Parameter_Integer  : Integer              :        0 
   --  874 : hi1qual7                 : Parameter_Integer  : Integer              :        0 
   --  875 : hi1qual8                 : Parameter_Integer  : Integer              :        0 
   --  876 : mntarr5                  : Parameter_Integer  : Integer              :        0 
   --  877 : mntnoch1                 : Parameter_Integer  : Integer              :        0 
   --  878 : mntnoch2                 : Parameter_Integer  : Integer              :        0 
   --  879 : mntnoch3                 : Parameter_Integer  : Integer              :        0 
   --  880 : mntnoch4                 : Parameter_Integer  : Integer              :        0 
   --  881 : mntnoch5                 : Parameter_Integer  : Integer              :        0 
   --  882 : mntpro1                  : Parameter_Integer  : Integer              :        0 
   --  883 : mntpro2                  : Parameter_Integer  : Integer              :        0 
   --  884 : mntpro3                  : Parameter_Integer  : Integer              :        0 
   --  885 : mnttim1                  : Parameter_Integer  : Integer              :        0 
   --  886 : mnttim2                  : Parameter_Integer  : Integer              :        0 
   --  887 : mnttim3                  : Parameter_Integer  : Integer              :        0 
   --  888 : mntwrk1                  : Parameter_Integer  : Integer              :        0 
   --  889 : mntwrk2                  : Parameter_Integer  : Integer              :        0 
   --  890 : mntwrk3                  : Parameter_Integer  : Integer              :        0 
   --  891 : mntwrk4                  : Parameter_Integer  : Integer              :        0 
   --  892 : mntwrk5                  : Parameter_Integer  : Integer              :        0 
   --  893 : ndeplnow                 : Parameter_Integer  : Integer              :        0 
   --  894 : oqualc1                  : Parameter_Integer  : Integer              :        0 
   --  895 : oqualc2                  : Parameter_Integer  : Integer              :        0 
   --  896 : oqualc3                  : Parameter_Integer  : Integer              :        0 
   --  897 : sruc                     : Parameter_Integer  : Integer              :        0 
   --  898 : webacnow                 : Parameter_Integer  : Integer              :        0 
   --  899 : indeth                   : Parameter_Integer  : Integer              :        0 
   --  900 : euactive                 : Parameter_Integer  : Integer              :        0 
   --  901 : euactno                  : Parameter_Integer  : Integer              :        0 
   --  902 : euartact                 : Parameter_Integer  : Integer              :        0 
   --  903 : euaskhlp                 : Parameter_Integer  : Integer              :        0 
   --  904 : eucinema                 : Parameter_Integer  : Integer              :        0 
   --  905 : eucultur                 : Parameter_Integer  : Integer              :        0 
   --  906 : euinvol                  : Parameter_Integer  : Integer              :        0 
   --  907 : eulivpe                  : Parameter_Integer  : Integer              :        0 
   --  908 : eumtfam                  : Parameter_Integer  : Integer              :        0 
   --  909 : eumtfrnd                 : Parameter_Integer  : Integer              :        0 
   --  910 : eusocnet                 : Parameter_Integer  : Integer              :        0 
   --  911 : eusport                  : Parameter_Integer  : Integer              :        0 
   --  912 : eutkfam                  : Parameter_Integer  : Integer              :        0 
   --  913 : eutkfrnd                 : Parameter_Integer  : Integer              :        0 
   --  914 : eutkmat                  : Parameter_Integer  : Integer              :        0 
   --  915 : euvol                    : Parameter_Integer  : Integer              :        0 
   --  916 : natscot                  : Parameter_Integer  : Integer              :        0 
   --  917 : ntsctnow                 : Parameter_Integer  : Integer              :        0 
   --  918 : penwel1                  : Parameter_Integer  : Integer              :        0 
   --  919 : penwel2                  : Parameter_Integer  : Integer              :        0 
   --  920 : penwel3                  : Parameter_Integer  : Integer              :        0 
   --  921 : penwel4                  : Parameter_Integer  : Integer              :        0 
   --  922 : penwel5                  : Parameter_Integer  : Integer              :        0 
   --  923 : penwel6                  : Parameter_Integer  : Integer              :        0 
   --  924 : skiwknow                 : Parameter_Integer  : Integer              :        0 
   --  925 : skiwrk                   : Parameter_Integer  : Integer              :        0 
   --  926 : slos                     : Parameter_Integer  : Integer              :        0 
   --  927 : yjblev                   : Parameter_Integer  : Integer              :        0 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 6, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Adult_IO;
