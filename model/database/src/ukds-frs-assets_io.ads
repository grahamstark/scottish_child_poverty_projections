--
-- Created by ada_generator.py on 2017-09-20 12:26:50.586534
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

package Ukds.Frs.Assets_IO is
  
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
   function Next_Free_assetype( connection : Database_Connection := null) return Integer;
   function Next_Free_seq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_assets match the defaults in Ukds.Frs.Null_Assets
   --
   function Is_Null( a_assets : Assets ) return Boolean;
   
   --
   -- returns the single a_assets matching the primary key fields, or the Ukds.Frs.Null_Assets record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; assetype : Integer; seq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Assets;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; assetype : Integer; seq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Assets matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Assets_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Assets retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Assets_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_assets : Ukds.Frs.Assets; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Assets
   --
   procedure Delete( a_assets : in out Ukds.Frs.Assets; connection : Database_Connection := null );
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
   procedure Add_assetype( c : in out d.Criteria; assetype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_seq( c : in out d.Criteria; seq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_accname( c : in out d.Criteria; accname : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_x_amount( c : in out d.Criteria; x_amount : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_anymon( c : in out d.Criteria; anymon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howmany( c : in out d.Criteria; howmany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howmuch( c : in out d.Criteria; howmuch : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howmuche( c : in out d.Criteria; howmuche : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intro( c : in out d.Criteria; intro : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issdate( c : in out d.Criteria; issdate : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issval( c : in out d.Criteria; issval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pd( c : in out d.Criteria; pd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_assetype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_seq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_accname_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_x_amount_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_anymon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howmany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howmuch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howmuche_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intro_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issdate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Assets;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 20, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : assetype                 : Parameter_Integer  : Integer              :        0 
   --    8 : seq                      : Parameter_Integer  : Integer              :        0 
   --    9 : accname                  : Parameter_Integer  : Integer              :        0 
   --   10 : x_amount                 : Parameter_Float    : Amount               :      0.0 
   --   11 : anymon                   : Parameter_Integer  : Integer              :        0 
   --   12 : howmany                  : Parameter_Integer  : Integer              :        0 
   --   13 : howmuch                  : Parameter_Float    : Amount               :      0.0 
   --   14 : howmuche                 : Parameter_Integer  : Integer              :        0 
   --   15 : intro                    : Parameter_Integer  : Integer              :        0 
   --   16 : issdate                  : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   17 : issval                   : Parameter_Float    : Amount               :      0.0 
   --   18 : pd                       : Parameter_Integer  : Integer              :        0 
   --   19 : month                    : Parameter_Integer  : Integer              :        0 
   --   20 : issue                    : Parameter_Integer  : Integer              :        0 
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
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    6 : person                   : Parameter_Integer  : Integer              :        0 
   --    7 : assetype                 : Parameter_Integer  : Integer              :        0 
   --    8 : seq                      : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Assets_IO;
