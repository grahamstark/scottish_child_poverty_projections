--
-- Created by ada_generator.py on 2017-09-20 23:36:53.503334
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

package Ukds.Frs.Insuranc_IO is
  
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
   function Next_Free_insseq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_insuranc match the defaults in Ukds.Frs.Null_Insuranc
   --
   function Is_Null( a_insuranc : Insuranc ) return Boolean;
   
   --
   -- returns the single a_insuranc matching the primary key fields, or the Ukds.Frs.Null_Insuranc record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; insseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Insuranc;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; insseq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Insuranc matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Insuranc_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Insuranc retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Insuranc_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_insuranc : Ukds.Frs.Insuranc; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Insuranc
   --
   procedure Delete( a_insuranc : in out Ukds.Frs.Insuranc; connection : Database_Connection := null );
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
   procedure Add_insseq( c : in out d.Criteria; insseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols1( c : in out d.Criteria; numpols1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols2( c : in out d.Criteria; numpols2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols3( c : in out d.Criteria; numpols3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols4( c : in out d.Criteria; numpols4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols5( c : in out d.Criteria; numpols5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols6( c : in out d.Criteria; numpols6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols7( c : in out d.Criteria; numpols7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols8( c : in out d.Criteria; numpols8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_numpols9( c : in out d.Criteria; numpols9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_polamt( c : in out d.Criteria; polamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_polmore( c : in out d.Criteria; polmore : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_polpay( c : in out d.Criteria; polpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_polpd( c : in out d.Criteria; polpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_insseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_numpols9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_polamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_polmore_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_polpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_polpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Insuranc;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 19, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : insseq                   : Parameter_Integer  : Integer              :        0 
   --    6 : numpols1                 : Parameter_Integer  : Integer              :        0 
   --    7 : numpols2                 : Parameter_Integer  : Integer              :        0 
   --    8 : numpols3                 : Parameter_Integer  : Integer              :        0 
   --    9 : numpols4                 : Parameter_Integer  : Integer              :        0 
   --   10 : numpols5                 : Parameter_Integer  : Integer              :        0 
   --   11 : numpols6                 : Parameter_Integer  : Integer              :        0 
   --   12 : numpols7                 : Parameter_Integer  : Integer              :        0 
   --   13 : numpols8                 : Parameter_Integer  : Integer              :        0 
   --   14 : numpols9                 : Parameter_Integer  : Integer              :        0 
   --   15 : polamt                   : Parameter_Float    : Amount               :      0.0 
   --   16 : polmore                  : Parameter_Integer  : Integer              :        0 
   --   17 : polpay                   : Parameter_Integer  : Integer              :        0 
   --   18 : polpd                    : Parameter_Integer  : Integer              :        0 
   --   19 : month                    : Parameter_Integer  : Integer              :        0 
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
   --    5 : insseq                   : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Insuranc_IO;
