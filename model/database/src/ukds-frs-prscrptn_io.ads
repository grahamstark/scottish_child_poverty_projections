--
-- Created by ada_generator.py on 2017-09-07 21:05:09.750594
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

package Ukds.Frs.Prscrptn_IO is
  
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
   -- returns true if the primary key parts of a_prscrptn match the defaults in Ukds.Frs.Null_Prscrptn
   --
   function Is_Null( a_prscrptn : Prscrptn ) return Boolean;
   
   --
   -- returns the single a_prscrptn matching the primary key fields, or the Ukds.Frs.Null_Prscrptn record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Prscrptn matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Prscrptn retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_prscrptn : Ukds.Frs.Prscrptn; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Prscrptn
   --
   procedure Delete( a_prscrptn : in out Ukds.Frs.Prscrptn; connection : Database_Connection := null );
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
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m01( c : in out d.Criteria; med12m01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m02( c : in out d.Criteria; med12m02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m03( c : in out d.Criteria; med12m03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m04( c : in out d.Criteria; med12m04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m05( c : in out d.Criteria; med12m05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m06( c : in out d.Criteria; med12m06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m07( c : in out d.Criteria; med12m07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m08( c : in out d.Criteria; med12m08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m09( c : in out d.Criteria; med12m09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m10( c : in out d.Criteria; med12m10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m11( c : in out d.Criteria; med12m11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m12( c : in out d.Criteria; med12m12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_med12m13( c : in out d.Criteria; med12m13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medrep( c : in out d.Criteria; medrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_medrpnm( c : in out d.Criteria; medrpnm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_med12m13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_medrpnm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Prscrptn;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 23, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : issue                    : Parameter_Integer  : Integer              :        0 
   --    8 : med12m01                 : Parameter_Integer  : Integer              :        0 
   --    9 : med12m02                 : Parameter_Integer  : Integer              :        0 
   --   10 : med12m03                 : Parameter_Integer  : Integer              :        0 
   --   11 : med12m04                 : Parameter_Integer  : Integer              :        0 
   --   12 : med12m05                 : Parameter_Integer  : Integer              :        0 
   --   13 : med12m06                 : Parameter_Integer  : Integer              :        0 
   --   14 : med12m07                 : Parameter_Integer  : Integer              :        0 
   --   15 : med12m08                 : Parameter_Integer  : Integer              :        0 
   --   16 : med12m09                 : Parameter_Integer  : Integer              :        0 
   --   17 : med12m10                 : Parameter_Integer  : Integer              :        0 
   --   18 : med12m11                 : Parameter_Integer  : Integer              :        0 
   --   19 : med12m12                 : Parameter_Integer  : Integer              :        0 
   --   20 : med12m13                 : Parameter_Integer  : Integer              :        0 
   --   21 : medrep                   : Parameter_Integer  : Integer              :        0 
   --   22 : medrpnm                  : Parameter_Integer  : Integer              :        0 
   --   23 : month                    : Parameter_Integer  : Integer              :        0 
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

  
end Ukds.Frs.Prscrptn_IO;
