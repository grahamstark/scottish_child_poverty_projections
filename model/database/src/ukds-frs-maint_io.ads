--
-- Created by ada_generator.py on 2017-09-21 20:55:37.947133
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

package Ukds.Frs.Maint_IO is
  
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
   function Next_Free_person( connection : Database_Connection := null) return Integer;
   function Next_Free_maintseq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_maint match the defaults in Ukds.Frs.Null_Maint
   --
   function Is_Null( a_maint : Maint ) return Boolean;
   
   --
   -- returns the single a_maint matching the primary key fields, or the Ukds.Frs.Null_Maint record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; maintseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Maint;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; maintseq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Maint matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Maint_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Maint retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Maint_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_maint : Ukds.Frs.Maint; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Maint
   --
   procedure Delete( a_maint : in out Ukds.Frs.Maint; connection : Database_Connection := null );
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
   procedure Add_maintseq( c : in out d.Criteria; maintseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_m( c : in out d.Criteria; m : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrage( c : in out d.Criteria; mrage : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mramt( c : in out d.Criteria; mramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy1( c : in out d.Criteria; mrchwhy1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy2( c : in out d.Criteria; mrchwhy2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy3( c : in out d.Criteria; mrchwhy3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy4( c : in out d.Criteria; mrchwhy4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy5( c : in out d.Criteria; mrchwhy5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy6( c : in out d.Criteria; mrchwhy6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy7( c : in out d.Criteria; mrchwhy7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy8( c : in out d.Criteria; mrchwhy8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrchwhy9( c : in out d.Criteria; mrchwhy9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrct( c : in out d.Criteria; mrct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrkid( c : in out d.Criteria; mrkid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrpd( c : in out d.Criteria; mrpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrr( c : in out d.Criteria; mrr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mruamt( c : in out d.Criteria; mruamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrupd( c : in out d.Criteria; mrupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrus( c : in out d.Criteria; mrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrv( c : in out d.Criteria; mrv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrarr1( c : in out d.Criteria; mrarr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrarr2( c : in out d.Criteria; mrarr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrarr3( c : in out d.Criteria; mrarr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrarr4( c : in out d.Criteria; mrarr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mrarr5( c : in out d.Criteria; mrarr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_maintseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_m_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrchwhy9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrkid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mruamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrarr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrarr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrarr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrarr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mrarr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Maint;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 34, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : maintseq                 : Parameter_Integer  : Integer              :        0 
   --    8 : m                        : Parameter_Integer  : Integer              :        0 
   --    9 : mrage                    : Parameter_Integer  : Integer              :        0 
   --   10 : mramt                    : Parameter_Float    : Amount               :      0.0 
   --   11 : mrchwhy1                 : Parameter_Integer  : Integer              :        0 
   --   12 : mrchwhy2                 : Parameter_Integer  : Integer              :        0 
   --   13 : mrchwhy3                 : Parameter_Integer  : Integer              :        0 
   --   14 : mrchwhy4                 : Parameter_Integer  : Integer              :        0 
   --   15 : mrchwhy5                 : Parameter_Integer  : Integer              :        0 
   --   16 : mrchwhy6                 : Parameter_Integer  : Integer              :        0 
   --   17 : mrchwhy7                 : Parameter_Integer  : Integer              :        0 
   --   18 : mrchwhy8                 : Parameter_Integer  : Integer              :        0 
   --   19 : mrchwhy9                 : Parameter_Integer  : Integer              :        0 
   --   20 : mrct                     : Parameter_Integer  : Integer              :        0 
   --   21 : mrkid                    : Parameter_Integer  : Integer              :        0 
   --   22 : mrpd                     : Parameter_Integer  : Integer              :        0 
   --   23 : mrr                      : Parameter_Integer  : Integer              :        0 
   --   24 : mruamt                   : Parameter_Float    : Amount               :      0.0 
   --   25 : mrupd                    : Parameter_Integer  : Integer              :        0 
   --   26 : mrus                     : Parameter_Integer  : Integer              :        0 
   --   27 : mrv                      : Parameter_Integer  : Integer              :        0 
   --   28 : month                    : Parameter_Integer  : Integer              :        0 
   --   29 : issue                    : Parameter_Integer  : Integer              :        0 
   --   30 : mrarr1                   : Parameter_Integer  : Integer              :        0 
   --   31 : mrarr2                   : Parameter_Integer  : Integer              :        0 
   --   32 : mrarr3                   : Parameter_Integer  : Integer              :        0 
   --   33 : mrarr4                   : Parameter_Integer  : Integer              :        0 
   --   34 : mrarr5                   : Parameter_Integer  : Integer              :        0 
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
   --    7 : maintseq                 : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Maint_IO;
