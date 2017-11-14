--
-- Created by ada_generator.py on 2017-11-14 12:23:42.069901
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

package Ukds.Frs.Transact_IO is
  
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
   function Next_Free_rowid( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_transact match the defaults in Ukds.Frs.Null_Transact
   --
   function Is_Null( a_transact : Transact ) return Boolean;
   
   --
   -- returns the single a_transact matching the primary key fields, or the Ukds.Frs.Null_Transact record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; rowid : Integer; connection : Database_Connection := null ) return Ukds.Frs.Transact;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; rowid : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Transact matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Transact_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Transact retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Transact_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_transact : Ukds.Frs.Transact; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Transact
   --
   procedure Delete( a_transact : in out Ukds.Frs.Transact; connection : Database_Connection := null );
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
   procedure Add_key1( c : in out d.Criteria; key1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_key2( c : in out d.Criteria; key2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_key3( c : in out d.Criteria; key3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_key4( c : in out d.Criteria; key4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_key5( c : in out d.Criteria; key5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frstable( c : in out d.Criteria; frstable : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frstable( c : in out d.Criteria; frstable : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frsvar( c : in out d.Criteria; frsvar : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_frsvar( c : in out d.Criteria; frsvar : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_old_val( c : in out d.Criteria; old_val : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_new_val( c : in out d.Criteria; new_val : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_datetime( c : in out d.Criteria; datetime : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_appldate( c : in out d.Criteria; appldate : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_batch( c : in out d.Criteria; batch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trantype( c : in out d.Criteria; trantype : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_trantype( c : in out d.Criteria; trantype : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_reason( c : in out d.Criteria; reason : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rowid( c : in out d.Criteria; rowid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_key1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_key2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_key3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_key4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_key5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frstable_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_frsvar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_old_val_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_new_val_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_datetime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_appldate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_batch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_trantype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_reason_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rowid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Transact;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 19, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : key1                     : Parameter_Integer  : Integer              :        0 
   --    6 : key2                     : Parameter_Integer  : Integer              :        0 
   --    7 : key3                     : Parameter_Integer  : Integer              :        0 
   --    8 : key4                     : Parameter_Integer  : Integer              :        0 
   --    9 : key5                     : Parameter_Integer  : Integer              :        0 
   --   10 : frstable                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --   11 : frsvar                   : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --   12 : old_val                  : Parameter_Float    : Amount               :      0.0 
   --   13 : new_val                  : Parameter_Float    : Amount               :      0.0 
   --   14 : datetime                 : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   15 : appldate                 : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   16 : batch                    : Parameter_Integer  : Integer              :        0 
   --   17 : trantype                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --   18 : reason                   : Parameter_Integer  : Integer              :        0 
   --   19 : rowid                    : Parameter_Integer  : Integer              :        0 
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
   --    5 : rowid                    : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Transact_IO;
