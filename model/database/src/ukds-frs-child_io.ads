--
-- Created by ada_generator.py on 2017-09-13 23:07:57.609389
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

package Ukds.Frs.Child_IO is
  
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
   -- returns true if the primary key parts of a_child match the defaults in Ukds.Frs.Null_Child
   --
   function Is_Null( a_child : Child ) return Boolean;
   
   --
   -- returns the single a_child matching the primary key fields, or the Ukds.Frs.Null_Child record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Ukds.Frs.Child;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Child matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Child_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Child retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Child_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_child : Ukds.Frs.Child; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Child
   --
   procedure Delete( a_child : in out Ukds.Frs.Child; connection : Database_Connection := null );
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
   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adeduc( c : in out d.Criteria; adeduc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age( c : in out d.Criteria; age : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benccdis( c : in out d.Criteria; benccdis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_care( c : in out d.Criteria; care : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif1( c : in out d.Criteria; cdisdif1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif2( c : in out d.Criteria; cdisdif2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif3( c : in out d.Criteria; cdisdif3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif4( c : in out d.Criteria; cdisdif4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif5( c : in out d.Criteria; cdisdif5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif6( c : in out d.Criteria; cdisdif6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif7( c : in out d.Criteria; cdisdif7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif8( c : in out d.Criteria; cdisdif8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamt1( c : in out d.Criteria; chamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamt2( c : in out d.Criteria; chamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamt3( c : in out d.Criteria; chamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamt4( c : in out d.Criteria; chamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamtern( c : in out d.Criteria; chamtern : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamttst( c : in out d.Criteria; chamttst : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chdla1( c : in out d.Criteria; chdla1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chdla2( c : in out d.Criteria; chdla2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chealth( c : in out d.Criteria; chealth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chearns1( c : in out d.Criteria; chearns1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chearns2( c : in out d.Criteria; chearns2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chema( c : in out d.Criteria; chema : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chemaamt( c : in out d.Criteria; chemaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chemapd( c : in out d.Criteria; chemapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chfar( c : in out d.Criteria; chfar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chhr1( c : in out d.Criteria; chhr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chhr2( c : in out d.Criteria; chhr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook01( c : in out d.Criteria; chlook01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook02( c : in out d.Criteria; chlook02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook03( c : in out d.Criteria; chlook03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook04( c : in out d.Criteria; chlook04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook05( c : in out d.Criteria; chlook05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook06( c : in out d.Criteria; chlook06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook07( c : in out d.Criteria; chlook07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook08( c : in out d.Criteria; chlook08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook09( c : in out d.Criteria; chlook09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlook10( c : in out d.Criteria; chlook10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chpay1( c : in out d.Criteria; chpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chpay2( c : in out d.Criteria; chpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chpay3( c : in out d.Criteria; chpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chpdern( c : in out d.Criteria; chpdern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chpdtst( c : in out d.Criteria; chpdtst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chprob( c : in out d.Criteria; chprob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chsave( c : in out d.Criteria; chsave : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chwkern( c : in out d.Criteria; chwkern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chwktst( c : in out d.Criteria; chwktst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chyrern( c : in out d.Criteria; chyrern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chyrtst( c : in out d.Criteria; chyrtst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clone( c : in out d.Criteria; clone : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cohabit( c : in out d.Criteria; cohabit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_convbl( c : in out d.Criteria; convbl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cost( c : in out d.Criteria; cost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cvht( c : in out d.Criteria; cvht : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cvpay( c : in out d.Criteria; cvpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cvpd( c : in out d.Criteria; cvpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dentist( c : in out d.Criteria; dentist : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_depend( c : in out d.Criteria; depend : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dob( c : in out d.Criteria; dob : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligadlt( c : in out d.Criteria; eligadlt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eligchld( c : in out d.Criteria; eligchld : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endyr( c : in out d.Criteria; endyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eyetest( c : in out d.Criteria; eyetest : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fted( c : in out d.Criteria; fted : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
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
   procedure Add_hholder( c : in out d.Criteria; hholder : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hosp( c : in out d.Criteria; hosp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lareg( c : in out d.Criteria; lareg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_legdep( c : in out d.Criteria; legdep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ms( c : in out d.Criteria; ms : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhs1( c : in out d.Criteria; nhs1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhs2( c : in out d.Criteria; nhs2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nhs3( c : in out d.Criteria; nhs3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_parent1( c : in out d.Criteria; parent1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_parent2( c : in out d.Criteria; parent2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prit( c : in out d.Criteria; prit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prscrpt( c : in out d.Criteria; prscrpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
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
   procedure Add_registr1( c : in out d.Criteria; registr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_registr2( c : in out d.Criteria; registr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_registr3( c : in out d.Criteria; registr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_registr4( c : in out d.Criteria; registr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_registr5( c : in out d.Criteria; registr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sex( c : in out d.Criteria; sex : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_smkit( c : in out d.Criteria; smkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_smlit( c : in out d.Criteria; smlit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spcreg1( c : in out d.Criteria; spcreg1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spcreg2( c : in out d.Criteria; spcreg2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spcreg3( c : in out d.Criteria; spcreg3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_specs( c : in out d.Criteria; specs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spout( c : in out d.Criteria; spout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_srentamt( c : in out d.Criteria; srentamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_srentpd( c : in out d.Criteria; srentpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_startyr( c : in out d.Criteria; startyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totsave( c : in out d.Criteria; totsave : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trav( c : in out d.Criteria; trav : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_typeed( c : in out d.Criteria; typeed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_voucher( c : in out d.Criteria; voucher : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav1( c : in out d.Criteria; whytrav1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav2( c : in out d.Criteria; whytrav2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav3( c : in out d.Criteria; whytrav3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav4( c : in out d.Criteria; whytrav4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav5( c : in out d.Criteria; whytrav5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_whytrav6( c : in out d.Criteria; whytrav6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wmkit( c : in out d.Criteria; wmkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_careab( c : in out d.Criteria; careab : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_careah( c : in out d.Criteria; careah : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carecb( c : in out d.Criteria; carecb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carech( c : in out d.Criteria; carech : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carecl( c : in out d.Criteria; carecl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carefl( c : in out d.Criteria; carefl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carefr( c : in out d.Criteria; carefr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_careot( c : in out d.Criteria; careot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_carere( c : in out d.Criteria; carere : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chdda( c : in out d.Criteria; chdda : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chearns( c : in out d.Criteria; chearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chincdv( c : in out d.Criteria; chincdv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chrinc( c : in out d.Criteria; chrinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsmlkval( c : in out d.Criteria; fsmlkval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsmval( c : in out d.Criteria; fsmval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fwmlkval( c : in out d.Criteria; fwmlkval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hdagech( c : in out d.Criteria; hdagech : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourab( c : in out d.Criteria; hourab : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourah( c : in out d.Criteria; hourah : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
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
   procedure Add_relhrp( c : in out d.Criteria; relhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_totgntch( c : in out d.Criteria; totgntch : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_uperson( c : in out d.Criteria; uperson : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cddatre( c : in out d.Criteria; cddatre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdif9( c : in out d.Criteria; cdisdif9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cddatrep( c : in out d.Criteria; cddatrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisdifp( c : in out d.Criteria; cdisdifp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cfund( c : in out d.Criteria; cfund : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cfundh( c : in out d.Criteria; cfundh : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cfundtp( c : in out d.Criteria; cfundtp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fundamt1( c : in out d.Criteria; fundamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fundamt2( c : in out d.Criteria; fundamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fundamt3( c : in out d.Criteria; fundamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fundamt4( c : in out d.Criteria; fundamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fundamt5( c : in out d.Criteria; fundamt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fundamt6( c : in out d.Criteria; fundamt6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givcfnd1( c : in out d.Criteria; givcfnd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givcfnd2( c : in out d.Criteria; givcfnd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givcfnd3( c : in out d.Criteria; givcfnd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givcfnd4( c : in out d.Criteria; givcfnd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givcfnd5( c : in out d.Criteria; givcfnd5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_givcfnd6( c : in out d.Criteria; givcfnd6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_tuacam( c : in out d.Criteria; tuacam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_schchk( c : in out d.Criteria; schchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trainee( c : in out d.Criteria; trainee : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cddaprg( c : in out d.Criteria; cddaprg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heartval( c : in out d.Criteria; heartval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_xbonflag( c : in out d.Criteria; xbonflag : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chca( c : in out d.Criteria; chca : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disdifch( c : in out d.Criteria; disdifch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chearns3( c : in out d.Criteria; chearns3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chtrnamt( c : in out d.Criteria; chtrnamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chtrnpd( c : in out d.Criteria; chtrnpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hsvper( c : in out d.Criteria; hsvper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mednum( c : in out d.Criteria; mednum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medprpd( c : in out d.Criteria; medprpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medprpy( c : in out d.Criteria; medprpy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sbkit( c : in out d.Criteria; sbkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dobmonth( c : in out d.Criteria; dobmonth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dobyear( c : in out d.Criteria; dobyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsbval( c : in out d.Criteria; fsbval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_btecnow( c : in out d.Criteria; btecnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cameyr( c : in out d.Criteria; cameyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdaprog1( c : in out d.Criteria; cdaprog1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdatre1( c : in out d.Criteria; cdatre1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdatrep1( c : in out d.Criteria; cdatrep1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd01( c : in out d.Criteria; cdisd01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd02( c : in out d.Criteria; cdisd02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd03( c : in out d.Criteria; cdisd03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd04( c : in out d.Criteria; cdisd04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd05( c : in out d.Criteria; cdisd05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd06( c : in out d.Criteria; cdisd06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd07( c : in out d.Criteria; cdisd07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd08( c : in out d.Criteria; cdisd08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd09( c : in out d.Criteria; cdisd09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cdisd10( c : in out d.Criteria; cdisd10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chbfd( c : in out d.Criteria; chbfd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chbfdamt( c : in out d.Criteria; chbfdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chbfdpd( c : in out d.Criteria; chbfdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chbfdval( c : in out d.Criteria; chbfdval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chcond( c : in out d.Criteria; chcond : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chealth1( c : in out d.Criteria; chealth1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chlimitl( c : in out d.Criteria; chlimitl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_citizen( c : in out d.Criteria; citizen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_citizen2( c : in out d.Criteria; citizen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_contuk( c : in out d.Criteria; contuk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_corign( c : in out d.Criteria; corign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_corigoth( c : in out d.Criteria; corigoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curqual( c : in out d.Criteria; curqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_degrenow( c : in out d.Criteria; degrenow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_denrec( c : in out d.Criteria; denrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dvmardf( c : in out d.Criteria; dvmardf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_heathch( c : in out d.Criteria; heathch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_highonow( c : in out d.Criteria; highonow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hrsed( c : in out d.Criteria; hrsed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medrec( c : in out d.Criteria; medrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nvqlenow( c : in out d.Criteria; nvqlenow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpass( c : in out d.Criteria; othpass : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reasden( c : in out d.Criteria; reasden : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reasmed( c : in out d.Criteria; reasmed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reasnhs( c : in out d.Criteria; reasnhs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rsanow( c : in out d.Criteria; rsanow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sctvnow( c : in out d.Criteria; sctvnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sfvit( c : in out d.Criteria; sfvit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_disactc1( c : in out d.Criteria; disactc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_discorc1( c : in out d.Criteria; discorc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fsfvval( c : in out d.Criteria; fsfvval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_marital( c : in out d.Criteria; marital : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_typeed2( c : in out d.Criteria; typeed2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_c2orign( c : in out d.Criteria; c2orign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_prox1619( c : in out d.Criteria; prox1619 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_candgnow( c : in out d.Criteria; candgnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curothf( c : in out d.Criteria; curothf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curothp( c : in out d.Criteria; curothp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_curothwv( c : in out d.Criteria; curothwv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gnvqnow( c : in out d.Criteria; gnvqnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ndeplnow( c : in out d.Criteria; ndeplnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oqualc1( c : in out d.Criteria; oqualc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oqualc2( c : in out d.Criteria; oqualc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oqualc3( c : in out d.Criteria; oqualc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_webacnow( c : in out d.Criteria; webacnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ntsctnow( c : in out d.Criteria; ntsctnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_skiwknow( c : in out d.Criteria; skiwknow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adeduc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benccdis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_care_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamtern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamttst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chdla1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chdla2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chealth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chearns1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chearns2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chema_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chemaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chemapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chfar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chhr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chhr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chpdern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chpdtst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chprob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chsave_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chwkern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chwktst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chyrern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chyrtst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clone_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cohabit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_convbl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cvht_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cvpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cvpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dentist_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_depend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligadlt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eligchld_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eyetest_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fted_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
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
   procedure Add_hholder_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hosp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lareg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_legdep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhs1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhs2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nhs3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_parent1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_parent2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prscrpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
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
   procedure Add_registr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_registr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_registr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_registr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_registr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sex_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_smkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_smlit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spcreg1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spcreg2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spcreg3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_specs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_srentamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_srentpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_startyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totsave_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trav_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_typeed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_voucher_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_whytrav6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wmkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_careab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_careah_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carecb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carech_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carecl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carefl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carefr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_careot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_carere_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chdda_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chincdv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsmlkval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsmval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fwmlkval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hdagech_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourah_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
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
   procedure Add_relhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_totgntch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_uperson_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cddatre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdif9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cddatrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisdifp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cfund_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cfundh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cfundtp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fundamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fundamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fundamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fundamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fundamt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fundamt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givcfnd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givcfnd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givcfnd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givcfnd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givcfnd5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_givcfnd6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_tuacam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_schchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trainee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cddaprg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heartval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_xbonflag_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chca_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disdifch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chearns3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chtrnamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chtrnpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hsvper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mednum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medprpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medprpy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sbkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dobmonth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dobyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsbval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_btecnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cameyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdaprog1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdatre1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdatrep1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cdisd10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chbfd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chbfdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chbfdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chbfdval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chcond_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chealth1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlimitl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_citizen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_citizen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_contuk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_corign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_corigoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_degrenow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_denrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dvmardf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_heathch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_highonow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hrsed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nvqlenow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpass_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reasden_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reasmed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reasnhs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rsanow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sctvnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sfvit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_disactc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_discorc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fsfvval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_marital_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_typeed2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_c2orign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_prox1619_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_candgnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curothf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curothp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_curothwv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gnvqnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ndeplnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oqualc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oqualc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oqualc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_webacnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ntsctnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_skiwknow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Child;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 268, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : adeduc                   : Parameter_Integer  : Integer              :        0 
   --    8 : age                      : Parameter_Integer  : Integer              :        0 
   --    9 : benccdis                 : Parameter_Integer  : Integer              :        0 
   --   10 : care                     : Parameter_Integer  : Integer              :        0 
   --   11 : cdisdif1                 : Parameter_Integer  : Integer              :        0 
   --   12 : cdisdif2                 : Parameter_Integer  : Integer              :        0 
   --   13 : cdisdif3                 : Parameter_Integer  : Integer              :        0 
   --   14 : cdisdif4                 : Parameter_Integer  : Integer              :        0 
   --   15 : cdisdif5                 : Parameter_Integer  : Integer              :        0 
   --   16 : cdisdif6                 : Parameter_Integer  : Integer              :        0 
   --   17 : cdisdif7                 : Parameter_Integer  : Integer              :        0 
   --   18 : cdisdif8                 : Parameter_Integer  : Integer              :        0 
   --   19 : chamt1                   : Parameter_Float    : Amount               :      0.0 
   --   20 : chamt2                   : Parameter_Float    : Amount               :      0.0 
   --   21 : chamt3                   : Parameter_Float    : Amount               :      0.0 
   --   22 : chamt4                   : Parameter_Float    : Amount               :      0.0 
   --   23 : chamtern                 : Parameter_Float    : Amount               :      0.0 
   --   24 : chamttst                 : Parameter_Float    : Amount               :      0.0 
   --   25 : chdla1                   : Parameter_Integer  : Integer              :        0 
   --   26 : chdla2                   : Parameter_Integer  : Integer              :        0 
   --   27 : chealth                  : Parameter_Integer  : Integer              :        0 
   --   28 : chearns1                 : Parameter_Integer  : Integer              :        0 
   --   29 : chearns2                 : Parameter_Integer  : Integer              :        0 
   --   30 : chema                    : Parameter_Integer  : Integer              :        0 
   --   31 : chemaamt                 : Parameter_Float    : Amount               :      0.0 
   --   32 : chemapd                  : Parameter_Integer  : Integer              :        0 
   --   33 : chfar                    : Parameter_Integer  : Integer              :        0 
   --   34 : chhr1                    : Parameter_Integer  : Integer              :        0 
   --   35 : chhr2                    : Parameter_Integer  : Integer              :        0 
   --   36 : chlook01                 : Parameter_Integer  : Integer              :        0 
   --   37 : chlook02                 : Parameter_Integer  : Integer              :        0 
   --   38 : chlook03                 : Parameter_Integer  : Integer              :        0 
   --   39 : chlook04                 : Parameter_Integer  : Integer              :        0 
   --   40 : chlook05                 : Parameter_Integer  : Integer              :        0 
   --   41 : chlook06                 : Parameter_Integer  : Integer              :        0 
   --   42 : chlook07                 : Parameter_Integer  : Integer              :        0 
   --   43 : chlook08                 : Parameter_Integer  : Integer              :        0 
   --   44 : chlook09                 : Parameter_Integer  : Integer              :        0 
   --   45 : chlook10                 : Parameter_Integer  : Integer              :        0 
   --   46 : chpay1                   : Parameter_Integer  : Integer              :        0 
   --   47 : chpay2                   : Parameter_Integer  : Integer              :        0 
   --   48 : chpay3                   : Parameter_Integer  : Integer              :        0 
   --   49 : chpdern                  : Parameter_Integer  : Integer              :        0 
   --   50 : chpdtst                  : Parameter_Integer  : Integer              :        0 
   --   51 : chprob                   : Parameter_Integer  : Integer              :        0 
   --   52 : chsave                   : Parameter_Integer  : Integer              :        0 
   --   53 : chwkern                  : Parameter_Integer  : Integer              :        0 
   --   54 : chwktst                  : Parameter_Integer  : Integer              :        0 
   --   55 : chyrern                  : Parameter_Integer  : Integer              :        0 
   --   56 : chyrtst                  : Parameter_Integer  : Integer              :        0 
   --   57 : clone                    : Parameter_Integer  : Integer              :        0 
   --   58 : cohabit                  : Parameter_Integer  : Integer              :        0 
   --   59 : convbl                   : Parameter_Integer  : Integer              :        0 
   --   60 : cost                     : Parameter_Integer  : Integer              :        0 
   --   61 : cvht                     : Parameter_Integer  : Integer              :        0 
   --   62 : cvpay                    : Parameter_Integer  : Integer              :        0 
   --   63 : cvpd                     : Parameter_Integer  : Integer              :        0 
   --   64 : dentist                  : Parameter_Integer  : Integer              :        0 
   --   65 : depend                   : Parameter_Integer  : Integer              :        0 
   --   66 : dob                      : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   67 : eligadlt                 : Parameter_Integer  : Integer              :        0 
   --   68 : eligchld                 : Parameter_Integer  : Integer              :        0 
   --   69 : endyr                    : Parameter_Integer  : Integer              :        0 
   --   70 : eyetest                  : Parameter_Integer  : Integer              :        0 
   --   71 : fted                     : Parameter_Integer  : Integer              :        0 
   --   72 : x_grant                  : Parameter_Integer  : Integer              :        0 
   --   73 : grtamt1                  : Parameter_Float    : Amount               :      0.0 
   --   74 : grtamt2                  : Parameter_Float    : Amount               :      0.0 
   --   75 : grtdir1                  : Parameter_Float    : Amount               :      0.0 
   --   76 : grtdir2                  : Parameter_Float    : Amount               :      0.0 
   --   77 : grtnum                   : Parameter_Integer  : Integer              :        0 
   --   78 : grtsce1                  : Parameter_Integer  : Integer              :        0 
   --   79 : grtsce2                  : Parameter_Integer  : Integer              :        0 
   --   80 : grtval1                  : Parameter_Float    : Amount               :      0.0 
   --   81 : grtval2                  : Parameter_Float    : Amount               :      0.0 
   --   82 : hholder                  : Parameter_Integer  : Integer              :        0 
   --   83 : hosp                     : Parameter_Integer  : Integer              :        0 
   --   84 : lareg                    : Parameter_Integer  : Integer              :        0 
   --   85 : legdep                   : Parameter_Integer  : Integer              :        0 
   --   86 : ms                       : Parameter_Integer  : Integer              :        0 
   --   87 : nhs1                     : Parameter_Integer  : Integer              :        0 
   --   88 : nhs2                     : Parameter_Integer  : Integer              :        0 
   --   89 : nhs3                     : Parameter_Integer  : Integer              :        0 
   --   90 : parent1                  : Parameter_Integer  : Integer              :        0 
   --   91 : parent2                  : Parameter_Integer  : Integer              :        0 
   --   92 : prit                     : Parameter_Integer  : Integer              :        0 
   --   93 : prscrpt                  : Parameter_Integer  : Integer              :        0 
   --   94 : r01                      : Parameter_Integer  : Integer              :        0 
   --   95 : r02                      : Parameter_Integer  : Integer              :        0 
   --   96 : r03                      : Parameter_Integer  : Integer              :        0 
   --   97 : r04                      : Parameter_Integer  : Integer              :        0 
   --   98 : r05                      : Parameter_Integer  : Integer              :        0 
   --   99 : r06                      : Parameter_Integer  : Integer              :        0 
   --  100 : r07                      : Parameter_Integer  : Integer              :        0 
   --  101 : r08                      : Parameter_Integer  : Integer              :        0 
   --  102 : r09                      : Parameter_Integer  : Integer              :        0 
   --  103 : r10                      : Parameter_Integer  : Integer              :        0 
   --  104 : r11                      : Parameter_Integer  : Integer              :        0 
   --  105 : r12                      : Parameter_Integer  : Integer              :        0 
   --  106 : r13                      : Parameter_Integer  : Integer              :        0 
   --  107 : r14                      : Parameter_Integer  : Integer              :        0 
   --  108 : registr1                 : Parameter_Integer  : Integer              :        0 
   --  109 : registr2                 : Parameter_Integer  : Integer              :        0 
   --  110 : registr3                 : Parameter_Integer  : Integer              :        0 
   --  111 : registr4                 : Parameter_Integer  : Integer              :        0 
   --  112 : registr5                 : Parameter_Integer  : Integer              :        0 
   --  113 : sex                      : Parameter_Integer  : Integer              :        0 
   --  114 : smkit                    : Parameter_Integer  : Integer              :        0 
   --  115 : smlit                    : Parameter_Integer  : Integer              :        0 
   --  116 : spcreg1                  : Parameter_Integer  : Integer              :        0 
   --  117 : spcreg2                  : Parameter_Integer  : Integer              :        0 
   --  118 : spcreg3                  : Parameter_Integer  : Integer              :        0 
   --  119 : specs                    : Parameter_Integer  : Integer              :        0 
   --  120 : spout                    : Parameter_Integer  : Integer              :        0 
   --  121 : srentamt                 : Parameter_Integer  : Integer              :        0 
   --  122 : srentpd                  : Parameter_Integer  : Integer              :        0 
   --  123 : startyr                  : Parameter_Integer  : Integer              :        0 
   --  124 : totsave                  : Parameter_Integer  : Integer              :        0 
   --  125 : trav                     : Parameter_Integer  : Integer              :        0 
   --  126 : typeed                   : Parameter_Integer  : Integer              :        0 
   --  127 : voucher                  : Parameter_Integer  : Integer              :        0 
   --  128 : whytrav1                 : Parameter_Integer  : Integer              :        0 
   --  129 : whytrav2                 : Parameter_Integer  : Integer              :        0 
   --  130 : whytrav3                 : Parameter_Integer  : Integer              :        0 
   --  131 : whytrav4                 : Parameter_Integer  : Integer              :        0 
   --  132 : whytrav5                 : Parameter_Integer  : Integer              :        0 
   --  133 : whytrav6                 : Parameter_Integer  : Integer              :        0 
   --  134 : wmkit                    : Parameter_Integer  : Integer              :        0 
   --  135 : month                    : Parameter_Integer  : Integer              :        0 
   --  136 : careab                   : Parameter_Integer  : Integer              :        0 
   --  137 : careah                   : Parameter_Integer  : Integer              :        0 
   --  138 : carecb                   : Parameter_Integer  : Integer              :        0 
   --  139 : carech                   : Parameter_Integer  : Integer              :        0 
   --  140 : carecl                   : Parameter_Integer  : Integer              :        0 
   --  141 : carefl                   : Parameter_Integer  : Integer              :        0 
   --  142 : carefr                   : Parameter_Integer  : Integer              :        0 
   --  143 : careot                   : Parameter_Integer  : Integer              :        0 
   --  144 : carere                   : Parameter_Integer  : Integer              :        0 
   --  145 : chdda                    : Parameter_Integer  : Integer              :        0 
   --  146 : chearns                  : Parameter_Float    : Amount               :      0.0 
   --  147 : chincdv                  : Parameter_Float    : Amount               :      0.0 
   --  148 : chrinc                   : Parameter_Float    : Amount               :      0.0 
   --  149 : fsmlkval                 : Parameter_Float    : Amount               :      0.0 
   --  150 : fsmval                   : Parameter_Float    : Amount               :      0.0 
   --  151 : fwmlkval                 : Parameter_Float    : Amount               :      0.0 
   --  152 : hdagech                  : Parameter_Integer  : Integer              :        0 
   --  153 : hourab                   : Parameter_Integer  : Integer              :        0 
   --  154 : hourah                   : Parameter_Integer  : Integer              :        0 
   --  155 : hourcb                   : Parameter_Integer  : Integer              :        0 
   --  156 : hourch                   : Parameter_Integer  : Integer              :        0 
   --  157 : hourcl                   : Parameter_Integer  : Integer              :        0 
   --  158 : hourfr                   : Parameter_Integer  : Integer              :        0 
   --  159 : hourot                   : Parameter_Integer  : Integer              :        0 
   --  160 : hourre                   : Parameter_Integer  : Integer              :        0 
   --  161 : hourtot                  : Parameter_Integer  : Integer              :        0 
   --  162 : hperson                  : Parameter_Integer  : Integer              :        0 
   --  163 : iagegr2                  : Parameter_Integer  : Integer              :        0 
   --  164 : iagegrp                  : Parameter_Integer  : Integer              :        0 
   --  165 : relhrp                   : Parameter_Integer  : Integer              :        0 
   --  166 : totgntch                 : Parameter_Float    : Amount               :      0.0 
   --  167 : uperson                  : Parameter_Integer  : Integer              :        0 
   --  168 : cddatre                  : Parameter_Integer  : Integer              :        0 
   --  169 : cdisdif9                 : Parameter_Integer  : Integer              :        0 
   --  170 : cddatrep                 : Parameter_Integer  : Integer              :        0 
   --  171 : cdisdifp                 : Parameter_Integer  : Integer              :        0 
   --  172 : cfund                    : Parameter_Integer  : Integer              :        0 
   --  173 : cfundh                   : Parameter_Float    : Amount               :      0.0 
   --  174 : cfundtp                  : Parameter_Integer  : Integer              :        0 
   --  175 : fundamt1                 : Parameter_Float    : Amount               :      0.0 
   --  176 : fundamt2                 : Parameter_Float    : Amount               :      0.0 
   --  177 : fundamt3                 : Parameter_Float    : Amount               :      0.0 
   --  178 : fundamt4                 : Parameter_Float    : Amount               :      0.0 
   --  179 : fundamt5                 : Parameter_Float    : Amount               :      0.0 
   --  180 : fundamt6                 : Parameter_Float    : Amount               :      0.0 
   --  181 : givcfnd1                 : Parameter_Integer  : Integer              :        0 
   --  182 : givcfnd2                 : Parameter_Integer  : Integer              :        0 
   --  183 : givcfnd3                 : Parameter_Integer  : Integer              :        0 
   --  184 : givcfnd4                 : Parameter_Integer  : Integer              :        0 
   --  185 : givcfnd5                 : Parameter_Integer  : Integer              :        0 
   --  186 : givcfnd6                 : Parameter_Integer  : Integer              :        0 
   --  187 : tuacam                   : Parameter_Float    : Amount               :      0.0 
   --  188 : schchk                   : Parameter_Integer  : Integer              :        0 
   --  189 : trainee                  : Parameter_Integer  : Integer              :        0 
   --  190 : cddaprg                  : Parameter_Integer  : Integer              :        0 
   --  191 : issue                    : Parameter_Integer  : Integer              :        0 
   --  192 : heartval                 : Parameter_Float    : Amount               :      0.0 
   --  193 : xbonflag                 : Parameter_Integer  : Integer              :        0 
   --  194 : chca                     : Parameter_Integer  : Integer              :        0 
   --  195 : disdifch                 : Parameter_Integer  : Integer              :        0 
   --  196 : chearns3                 : Parameter_Integer  : Integer              :        0 
   --  197 : chtrnamt                 : Parameter_Float    : Amount               :      0.0 
   --  198 : chtrnpd                  : Parameter_Integer  : Integer              :        0 
   --  199 : hsvper                   : Parameter_Integer  : Integer              :        0 
   --  200 : mednum                   : Parameter_Integer  : Integer              :        0 
   --  201 : medprpd                  : Parameter_Integer  : Integer              :        0 
   --  202 : medprpy                  : Parameter_Integer  : Integer              :        0 
   --  203 : sbkit                    : Parameter_Integer  : Integer              :        0 
   --  204 : dobmonth                 : Parameter_Integer  : Integer              :        0 
   --  205 : dobyear                  : Parameter_Integer  : Integer              :        0 
   --  206 : fsbval                   : Parameter_Float    : Amount               :      0.0 
   --  207 : btecnow                  : Parameter_Integer  : Integer              :        0 
   --  208 : cameyr                   : Parameter_Integer  : Integer              :        0 
   --  209 : cdaprog1                 : Parameter_Integer  : Integer              :        0 
   --  210 : cdatre1                  : Parameter_Integer  : Integer              :        0 
   --  211 : cdatrep1                 : Parameter_Integer  : Integer              :        0 
   --  212 : cdisd01                  : Parameter_Integer  : Integer              :        0 
   --  213 : cdisd02                  : Parameter_Integer  : Integer              :        0 
   --  214 : cdisd03                  : Parameter_Integer  : Integer              :        0 
   --  215 : cdisd04                  : Parameter_Integer  : Integer              :        0 
   --  216 : cdisd05                  : Parameter_Integer  : Integer              :        0 
   --  217 : cdisd06                  : Parameter_Integer  : Integer              :        0 
   --  218 : cdisd07                  : Parameter_Integer  : Integer              :        0 
   --  219 : cdisd08                  : Parameter_Integer  : Integer              :        0 
   --  220 : cdisd09                  : Parameter_Integer  : Integer              :        0 
   --  221 : cdisd10                  : Parameter_Integer  : Integer              :        0 
   --  222 : chbfd                    : Parameter_Integer  : Integer              :        0 
   --  223 : chbfdamt                 : Parameter_Float    : Amount               :      0.0 
   --  224 : chbfdpd                  : Parameter_Integer  : Integer              :        0 
   --  225 : chbfdval                 : Parameter_Integer  : Integer              :        0 
   --  226 : chcond                   : Parameter_Integer  : Integer              :        0 
   --  227 : chealth1                 : Parameter_Integer  : Integer              :        0 
   --  228 : chlimitl                 : Parameter_Integer  : Integer              :        0 
   --  229 : citizen                  : Parameter_Integer  : Integer              :        0 
   --  230 : citizen2                 : Parameter_Integer  : Integer              :        0 
   --  231 : contuk                   : Parameter_Integer  : Integer              :        0 
   --  232 : corign                   : Parameter_Integer  : Integer              :        0 
   --  233 : corigoth                 : Parameter_Integer  : Integer              :        0 
   --  234 : curqual                  : Parameter_Integer  : Integer              :        0 
   --  235 : degrenow                 : Parameter_Integer  : Integer              :        0 
   --  236 : denrec                   : Parameter_Integer  : Integer              :        0 
   --  237 : dvmardf                  : Parameter_Integer  : Integer              :        0 
   --  238 : heathch                  : Parameter_Integer  : Integer              :        0 
   --  239 : highonow                 : Parameter_Integer  : Integer              :        0 
   --  240 : hrsed                    : Parameter_Integer  : Integer              :        0 
   --  241 : medrec                   : Parameter_Integer  : Integer              :        0 
   --  242 : nvqlenow                 : Parameter_Integer  : Integer              :        0 
   --  243 : othpass                  : Parameter_Integer  : Integer              :        0 
   --  244 : reasden                  : Parameter_Integer  : Integer              :        0 
   --  245 : reasmed                  : Parameter_Integer  : Integer              :        0 
   --  246 : reasnhs                  : Parameter_Integer  : Integer              :        0 
   --  247 : rsanow                   : Parameter_Integer  : Integer              :        0 
   --  248 : sctvnow                  : Parameter_Integer  : Integer              :        0 
   --  249 : sfvit                    : Parameter_Integer  : Integer              :        0 
   --  250 : disactc1                 : Parameter_Integer  : Integer              :        0 
   --  251 : discorc1                 : Parameter_Integer  : Integer              :        0 
   --  252 : fsfvval                  : Parameter_Float    : Amount               :      0.0 
   --  253 : marital                  : Parameter_Integer  : Integer              :        0 
   --  254 : typeed2                  : Parameter_Integer  : Integer              :        0 
   --  255 : c2orign                  : Parameter_Integer  : Integer              :        0 
   --  256 : prox1619                 : Parameter_Integer  : Integer              :        0 
   --  257 : candgnow                 : Parameter_Integer  : Integer              :        0 
   --  258 : curothf                  : Parameter_Integer  : Integer              :        0 
   --  259 : curothp                  : Parameter_Integer  : Integer              :        0 
   --  260 : curothwv                 : Parameter_Integer  : Integer              :        0 
   --  261 : gnvqnow                  : Parameter_Integer  : Integer              :        0 
   --  262 : ndeplnow                 : Parameter_Integer  : Integer              :        0 
   --  263 : oqualc1                  : Parameter_Integer  : Integer              :        0 
   --  264 : oqualc2                  : Parameter_Integer  : Integer              :        0 
   --  265 : oqualc3                  : Parameter_Integer  : Integer              :        0 
   --  266 : webacnow                 : Parameter_Integer  : Integer              :        0 
   --  267 : ntsctnow                 : Parameter_Integer  : Integer              :        0 
   --  268 : skiwknow                 : Parameter_Integer  : Integer              :        0 
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

  
end Ukds.Frs.Child_IO;
