--
-- Created by ada_generator.py on 2017-09-14 11:23:40.301555
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

package Ukds.Frs.Owner_IO is
  
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

   --
   -- returns true if the primary key parts of a_owner match the defaults in Ukds.Frs.Null_Owner
   --
   function Is_Null( a_owner : Owner ) return Boolean;
   
   --
   -- returns the single a_owner matching the primary key fields, or the Ukds.Frs.Null_Owner record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Owner;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Owner matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Owner_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Owner retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Owner_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_owner : Ukds.Frs.Owner; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Owner
   --
   procedure Delete( a_owner : in out Ukds.Frs.Owner; connection : Database_Connection := null );
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
   procedure Add_buyyear( c : in out d.Criteria; buyyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othmort1( c : in out d.Criteria; othmort1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othmort2( c : in out d.Criteria; othmort2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othmort3( c : in out d.Criteria; othmort3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur1( c : in out d.Criteria; othpur1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur2( c : in out d.Criteria; othpur2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur3( c : in out d.Criteria; othpur3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur31( c : in out d.Criteria; othpur31 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur32( c : in out d.Criteria; othpur32 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur33( c : in out d.Criteria; othpur33 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur34( c : in out d.Criteria; othpur34 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur35( c : in out d.Criteria; othpur35 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur36( c : in out d.Criteria; othpur36 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur37( c : in out d.Criteria; othpur37 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur4( c : in out d.Criteria; othpur4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur5( c : in out d.Criteria; othpur5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur6( c : in out d.Criteria; othpur6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_othpur7( c : in out d.Criteria; othpur7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_purcamt( c : in out d.Criteria; purcamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_purcloan( c : in out d.Criteria; purcloan : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_counter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_buyyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othmort1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othmort2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othmort3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_othpur7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_purcamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_purcloan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Owner;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 27, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : buyyear                  : Parameter_Integer  : Integer              :        0 
   --    7 : othmort1                 : Parameter_Integer  : Integer              :        0 
   --    8 : othmort2                 : Parameter_Integer  : Integer              :        0 
   --    9 : othmort3                 : Parameter_Integer  : Integer              :        0 
   --   10 : othpur1                  : Parameter_Integer  : Integer              :        0 
   --   11 : othpur2                  : Parameter_Integer  : Integer              :        0 
   --   12 : othpur3                  : Parameter_Integer  : Integer              :        0 
   --   13 : othpur31                 : Parameter_Integer  : Integer              :        0 
   --   14 : othpur32                 : Parameter_Integer  : Integer              :        0 
   --   15 : othpur33                 : Parameter_Integer  : Integer              :        0 
   --   16 : othpur34                 : Parameter_Integer  : Integer              :        0 
   --   17 : othpur35                 : Parameter_Integer  : Integer              :        0 
   --   18 : othpur36                 : Parameter_Integer  : Integer              :        0 
   --   19 : othpur37                 : Parameter_Integer  : Integer              :        0 
   --   20 : othpur4                  : Parameter_Integer  : Integer              :        0 
   --   21 : othpur5                  : Parameter_Integer  : Integer              :        0 
   --   22 : othpur6                  : Parameter_Integer  : Integer              :        0 
   --   23 : othpur7                  : Parameter_Integer  : Integer              :        0 
   --   24 : purcamt                  : Parameter_Float    : Amount               :      0.0 
   --   25 : purcloan                 : Parameter_Integer  : Integer              :        0 
   --   26 : month                    : Parameter_Integer  : Integer              :        0 
   --   27 : issue                    : Parameter_Integer  : Integer              :        0 
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
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Owner_IO;
