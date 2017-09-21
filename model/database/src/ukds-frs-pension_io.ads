--
-- Created by ada_generator.py on 2017-09-21 13:28:54.074351
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

package Ukds.Frs.Pension_IO is
  
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
   function Next_Free_penseq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_pension match the defaults in Ukds.Frs.Null_Pension
   --
   function Is_Null( a_pension : Pension ) return Boolean;
   
   --
   -- returns the single a_pension matching the primary key fields, or the Ukds.Frs.Null_Pension record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; penseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Pension;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; penseq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Pension matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Pension_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Pension retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Pension_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_pension : Ukds.Frs.Pension; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Pension
   --
   procedure Delete( a_pension : in out Ukds.Frs.Pension; connection : Database_Connection := null );
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
   procedure Add_penseq( c : in out d.Criteria; penseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_another( c : in out d.Criteria; another : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penoth( c : in out d.Criteria; penoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penpay( c : in out d.Criteria; penpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penpd( c : in out d.Criteria; penpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pentax( c : in out d.Criteria; pentax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pentype( c : in out d.Criteria; pentype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_poamt( c : in out d.Criteria; poamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_poinc( c : in out d.Criteria; poinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_posour( c : in out d.Criteria; posour : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ptamt( c : in out d.Criteria; ptamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ptinc( c : in out d.Criteria; ptinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trights( c : in out d.Criteria; trights : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penpd1( c : in out d.Criteria; penpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penpd2( c : in out d.Criteria; penpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_another_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pentax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pentype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_poamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_poinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_posour_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ptamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ptinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trights_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Pension;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 23, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : penseq                   : Parameter_Integer  : Integer              :        0 
   --    8 : another                  : Parameter_Integer  : Integer              :        0 
   --    9 : penoth                   : Parameter_Integer  : Integer              :        0 
   --   10 : penpay                   : Parameter_Float    : Amount               :      0.0 
   --   11 : penpd                    : Parameter_Integer  : Integer              :        0 
   --   12 : pentax                   : Parameter_Integer  : Integer              :        0 
   --   13 : pentype                  : Parameter_Integer  : Integer              :        0 
   --   14 : poamt                    : Parameter_Float    : Amount               :      0.0 
   --   15 : poinc                    : Parameter_Integer  : Integer              :        0 
   --   16 : posour                   : Parameter_Integer  : Integer              :        0 
   --   17 : ptamt                    : Parameter_Float    : Amount               :      0.0 
   --   18 : ptinc                    : Parameter_Integer  : Integer              :        0 
   --   19 : trights                  : Parameter_Integer  : Integer              :        0 
   --   20 : month                    : Parameter_Integer  : Integer              :        0 
   --   21 : issue                    : Parameter_Integer  : Integer              :        0 
   --   22 : penpd1                   : Parameter_Integer  : Integer              :        0 
   --   23 : penpd2                   : Parameter_Integer  : Integer              :        0 
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
   --    7 : penseq                   : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Pension_IO;
