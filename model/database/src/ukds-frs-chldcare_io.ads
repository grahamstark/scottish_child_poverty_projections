--
-- Created by ada_generator.py on 2017-09-20 22:07:22.378790
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

package Ukds.Frs.Chldcare_IO is
  
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
   function Next_Free_chlook( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_chldcare match the defaults in Ukds.Frs.Null_Chldcare
   --
   function Is_Null( a_chldcare : Chldcare ) return Boolean;
   
   --
   -- returns the single a_chldcare matching the primary key fields, or the Ukds.Frs.Null_Chldcare record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; chlook : Integer; connection : Database_Connection := null ) return Ukds.Frs.Chldcare;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; chlook : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Chldcare matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Chldcare retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_chldcare : Ukds.Frs.Chldcare; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Chldcare
   --
   procedure Delete( a_chldcare : in out Ukds.Frs.Chldcare; connection : Database_Connection := null );
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
   procedure Add_chlook( c : in out d.Criteria; chlook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_benccdis( c : in out d.Criteria; benccdis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chamt( c : in out d.Criteria; chamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chfar( c : in out d.Criteria; chfar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chhr( c : in out d.Criteria; chhr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chinknd1( c : in out d.Criteria; chinknd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chinknd2( c : in out d.Criteria; chinknd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chinknd3( c : in out d.Criteria; chinknd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chinknd4( c : in out d.Criteria; chinknd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chinknd5( c : in out d.Criteria; chinknd5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_chpd( c : in out d.Criteria; chpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cost( c : in out d.Criteria; cost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ctrm( c : in out d.Criteria; ctrm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_emplprov( c : in out d.Criteria; emplprov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_registrd( c : in out d.Criteria; registrd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pmchk( c : in out d.Criteria; pmchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hourly( c : in out d.Criteria; hourly : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freecc( c : in out d.Criteria; freecc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freccty1( c : in out d.Criteria; freccty1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freccty2( c : in out d.Criteria; freccty2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freccty3( c : in out d.Criteria; freccty3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freccty4( c : in out d.Criteria; freccty4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freccty5( c : in out d.Criteria; freccty5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freccty6( c : in out d.Criteria; freccty6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chlook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benccdis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chfar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chinknd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chinknd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chinknd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chinknd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chinknd5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_chpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ctrm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_emplprov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_registrd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pmchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hourly_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freecc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freccty1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freccty2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freccty3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freccty4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freccty5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freccty6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Chldcare;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 32, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : chlook                   : Parameter_Integer  : Integer              :        0 
   --    8 : benccdis                 : Parameter_Integer  : Integer              :        0 
   --    9 : chamt                    : Parameter_Float    : Amount               :      0.0 
   --   10 : chfar                    : Parameter_Integer  : Integer              :        0 
   --   11 : chhr                     : Parameter_Integer  : Integer              :        0 
   --   12 : chinknd1                 : Parameter_Integer  : Integer              :        0 
   --   13 : chinknd2                 : Parameter_Integer  : Integer              :        0 
   --   14 : chinknd3                 : Parameter_Integer  : Integer              :        0 
   --   15 : chinknd4                 : Parameter_Integer  : Integer              :        0 
   --   16 : chinknd5                 : Parameter_Integer  : Integer              :        0 
   --   17 : chpd                     : Parameter_Integer  : Integer              :        0 
   --   18 : cost                     : Parameter_Integer  : Integer              :        0 
   --   19 : ctrm                     : Parameter_Integer  : Integer              :        0 
   --   20 : emplprov                 : Parameter_Integer  : Integer              :        0 
   --   21 : registrd                 : Parameter_Integer  : Integer              :        0 
   --   22 : month                    : Parameter_Integer  : Integer              :        0 
   --   23 : pmchk                    : Parameter_Integer  : Integer              :        0 
   --   24 : issue                    : Parameter_Integer  : Integer              :        0 
   --   25 : hourly                   : Parameter_Integer  : Integer              :        0 
   --   26 : freecc                   : Parameter_Integer  : Integer              :        0 
   --   27 : freccty1                 : Parameter_Integer  : Integer              :        0 
   --   28 : freccty2                 : Parameter_Integer  : Integer              :        0 
   --   29 : freccty3                 : Parameter_Integer  : Integer              :        0 
   --   30 : freccty4                 : Parameter_Integer  : Integer              :        0 
   --   31 : freccty5                 : Parameter_Integer  : Integer              :        0 
   --   32 : freccty6                 : Parameter_Integer  : Integer              :        0 
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
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 7, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : chlook                   : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Chldcare_IO;
