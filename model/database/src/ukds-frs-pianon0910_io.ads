--
-- Created by ada_generator.py on 2017-09-21 15:55:24.223040
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

package Ukds.Frs.Pianon0910_IO is
  
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
   function Next_Free_benunit( connection : Database_Connection := null) return Integer;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;

   --
   -- returns true if the primary key parts of a_pianon0910 match the defaults in Ukds.Frs.Null_Pianon0910
   --
   function Is_Null( a_pianon0910 : Pianon0910 ) return Boolean;
   
   --
   -- returns the single a_pianon0910 matching the primary key fields, or the Ukds.Frs.Null_Pianon0910 record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; benunit : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; benunit : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Pianon0910 matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Pianon0910 retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_pianon0910 : Ukds.Frs.Pianon0910; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Pianon0910
   --
   procedure Delete( a_pianon0910 : in out Ukds.Frs.Pianon0910; connection : Database_Connection := null );
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
   procedure Add_gvtregn( c : in out d.Criteria; gvtregn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_fambu( c : in out d.Criteria; fambu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_newfambu( c : in out d.Criteria; newfambu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sexhd( c : in out d.Criteria; sexhd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_adultb( c : in out d.Criteria; adultb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ethgrphh( c : in out d.Criteria; ethgrphh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gs_newbu( c : in out d.Criteria; gs_newbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gs_newpp( c : in out d.Criteria; gs_newpp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mbhcdec( c : in out d.Criteria; mbhcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_obhcdec( c : in out d.Criteria; obhcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mahcdec( c : in out d.Criteria; mahcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_oahcdec( c : in out d.Criteria; oahcdec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sexsp( c : in out d.Criteria; sexsp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pidefbhc( c : in out d.Criteria; pidefbhc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pidefahc( c : in out d.Criteria; pidefahc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pigrosbu( c : in out d.Criteria; pigrosbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pinincbu( c : in out d.Criteria; pinincbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pigoccbu( c : in out d.Criteria; pigoccbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pippenbu( c : in out d.Criteria; pippenbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_piginvbu( c : in out d.Criteria; piginvbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pigernbu( c : in out d.Criteria; pigernbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pibenibu( c : in out d.Criteria; pibenibu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_piothibu( c : in out d.Criteria; piothibu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pinahcbu( c : in out d.Criteria; pinahcbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_piirbbu( c : in out d.Criteria; piirbbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pidisben( c : in out d.Criteria; pidisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_piretben( c : in out d.Criteria; piretben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pripenbu( c : in out d.Criteria; pripenbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_nonben2bu( c : in out d.Criteria; nonben2bu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_perbenbu( c : in out d.Criteria; perbenbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_perbenbu2( c : in out d.Criteria; perbenbu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rrpen( c : in out d.Criteria; rrpen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_newfambu2( c : in out d.Criteria; newfambu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_newfamb2( c : in out d.Criteria; newfamb2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_dummy( c : in out d.Criteria; dummy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coup_q1( c : in out d.Criteria; coup_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coup_q2( c : in out d.Criteria; coup_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coup_q3( c : in out d.Criteria; coup_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coup_q4( c : in out d.Criteria; coup_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_coup_q5( c : in out d.Criteria; coup_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acou_q1( c : in out d.Criteria; acou_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acou_q2( c : in out d.Criteria; acou_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acou_q3( c : in out d.Criteria; acou_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acou_q4( c : in out d.Criteria; acou_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_acou_q5( c : in out d.Criteria; acou_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sing_q1( c : in out d.Criteria; sing_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sing_q2( c : in out d.Criteria; sing_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sing_q3( c : in out d.Criteria; sing_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sing_q4( c : in out d.Criteria; sing_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sing_q5( c : in out d.Criteria; sing_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_asin_q1( c : in out d.Criteria; asin_q1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_asin_q2( c : in out d.Criteria; asin_q2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_asin_q3( c : in out d.Criteria; asin_q3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_asin_q4( c : in out d.Criteria; asin_q4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_asin_q5( c : in out d.Criteria; asin_q5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_clust( c : in out d.Criteria; clust : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_strat( c : in out d.Criteria; strat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_agehd80( c : in out d.Criteria; agehd80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_agesp80( c : in out d.Criteria; agesp80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gvtregn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_fambu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_newfambu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sexhd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_adultb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ethgrphh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gs_newbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gs_newpp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mbhcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_obhcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mahcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_oahcdec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sexsp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pidefbhc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pidefahc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pigrosbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pinincbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pigoccbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pippenbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_piginvbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pigernbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pibenibu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_piothibu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pinahcbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_piirbbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pidisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_piretben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pripenbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_nonben2bu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_perbenbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_perbenbu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rrpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_newfambu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_newfamb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_dummy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coup_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coup_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coup_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coup_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_coup_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acou_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acou_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acou_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acou_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_acou_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sing_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sing_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sing_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sing_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sing_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_asin_q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_asin_q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_asin_q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_asin_q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_asin_q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_clust_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_strat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_agehd80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_agesp80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Pianon0910;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 64, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : gvtregn                  : Parameter_Integer  : Integer              :        0 
   --    5 : fambu                    : Parameter_Integer  : Integer              :        0 
   --    6 : newfambu                 : Parameter_Integer  : Integer              :        0 
   --    7 : sexhd                    : Parameter_Integer  : Integer              :        0 
   --    8 : adultb                   : Parameter_Integer  : Integer              :        0 
   --    9 : ethgrphh                 : Parameter_Integer  : Integer              :        0 
   --   10 : benunit                  : Parameter_Integer  : Integer              :        0 
   --   11 : gs_newbu                 : Parameter_Integer  : Integer              :        0 
   --   12 : gs_newpp                 : Parameter_Integer  : Integer              :        0 
   --   13 : mbhcdec                  : Parameter_Integer  : Integer              :        0 
   --   14 : obhcdec                  : Parameter_Integer  : Integer              :        0 
   --   15 : mahcdec                  : Parameter_Integer  : Integer              :        0 
   --   16 : oahcdec                  : Parameter_Integer  : Integer              :        0 
   --   17 : sexsp                    : Parameter_Integer  : Integer              :        0 
   --   18 : pidefbhc                 : Parameter_Float    : Amount               :      0.0 
   --   19 : pidefahc                 : Parameter_Float    : Amount               :      0.0 
   --   20 : pigrosbu                 : Parameter_Integer  : Integer              :        0 
   --   21 : pinincbu                 : Parameter_Integer  : Integer              :        0 
   --   22 : pigoccbu                 : Parameter_Integer  : Integer              :        0 
   --   23 : pippenbu                 : Parameter_Integer  : Integer              :        0 
   --   24 : piginvbu                 : Parameter_Integer  : Integer              :        0 
   --   25 : pigernbu                 : Parameter_Integer  : Integer              :        0 
   --   26 : pibenibu                 : Parameter_Integer  : Integer              :        0 
   --   27 : piothibu                 : Parameter_Integer  : Integer              :        0 
   --   28 : pinahcbu                 : Parameter_Integer  : Integer              :        0 
   --   29 : piirbbu                  : Parameter_Integer  : Integer              :        0 
   --   30 : pidisben                 : Parameter_Integer  : Integer              :        0 
   --   31 : piretben                 : Parameter_Integer  : Integer              :        0 
   --   32 : pripenbu                 : Parameter_Integer  : Integer              :        0 
   --   33 : nonben2bu                : Parameter_Integer  : Integer              :        0 
   --   34 : perbenbu                 : Parameter_Integer  : Integer              :        0 
   --   35 : perbenbu2                : Parameter_Integer  : Integer              :        0 
   --   36 : rrpen                    : Parameter_Integer  : Integer              :        0 
   --   37 : newfambu2                : Parameter_Integer  : Integer              :        0 
   --   38 : newfamb2                 : Parameter_Integer  : Integer              :        0 
   --   39 : dummy                    : Parameter_Integer  : Integer              :        0 
   --   40 : coup_q1                  : Parameter_Float    : Amount               :      0.0 
   --   41 : coup_q2                  : Parameter_Float    : Amount               :      0.0 
   --   42 : coup_q3                  : Parameter_Float    : Amount               :      0.0 
   --   43 : coup_q4                  : Parameter_Float    : Amount               :      0.0 
   --   44 : coup_q5                  : Parameter_Float    : Amount               :      0.0 
   --   45 : acou_q1                  : Parameter_Float    : Amount               :      0.0 
   --   46 : acou_q2                  : Parameter_Float    : Amount               :      0.0 
   --   47 : acou_q3                  : Parameter_Float    : Amount               :      0.0 
   --   48 : acou_q4                  : Parameter_Float    : Amount               :      0.0 
   --   49 : acou_q5                  : Parameter_Float    : Amount               :      0.0 
   --   50 : sing_q1                  : Parameter_Float    : Amount               :      0.0 
   --   51 : sing_q2                  : Parameter_Float    : Amount               :      0.0 
   --   52 : sing_q3                  : Parameter_Float    : Amount               :      0.0 
   --   53 : sing_q4                  : Parameter_Float    : Amount               :      0.0 
   --   54 : sing_q5                  : Parameter_Float    : Amount               :      0.0 
   --   55 : asin_q1                  : Parameter_Float    : Amount               :      0.0 
   --   56 : asin_q2                  : Parameter_Float    : Amount               :      0.0 
   --   57 : asin_q3                  : Parameter_Float    : Amount               :      0.0 
   --   58 : asin_q4                  : Parameter_Float    : Amount               :      0.0 
   --   59 : asin_q5                  : Parameter_Float    : Amount               :      0.0 
   --   60 : clust                    : Parameter_Integer  : Integer              :        0 
   --   61 : strat                    : Parameter_Integer  : Integer              :        0 
   --   62 : agehd80                  : Parameter_Integer  : Integer              :        0 
   --   63 : agesp80                  : Parameter_Integer  : Integer              :        0 
   --   64 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
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
   --    4 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Pianon0910_IO;
