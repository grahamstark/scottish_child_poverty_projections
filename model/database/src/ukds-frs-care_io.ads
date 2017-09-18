--
-- Created by ada_generator.py on 2017-09-18 17:36:25.396856
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

package Ukds.Frs.Care_IO is
  
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
   function Next_Free_benunit( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_care match the defaults in Ukds.Frs.Null_Care
   --
   function Is_Null( a_care : Care ) return Boolean;
   
   --
   -- returns the single a_care matching the primary key fields, or the Ukds.Frs.Null_Care record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Ukds.Frs.Care;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Care matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Care_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Care retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Care_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_care : Ukds.Frs.Care; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Care
   --
   procedure Delete( a_care : in out Ukds.Frs.Care; connection : Database_Connection := null );
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
   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_needper( c : in out d.Criteria; needper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_daynight( c : in out d.Criteria; daynight : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_freq( c : in out d.Criteria; freq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour01( c : in out d.Criteria; hour01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour02( c : in out d.Criteria; hour02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour03( c : in out d.Criteria; hour03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour04( c : in out d.Criteria; hour04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour05( c : in out d.Criteria; hour05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour06( c : in out d.Criteria; hour06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour07( c : in out d.Criteria; hour07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour08( c : in out d.Criteria; hour08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour09( c : in out d.Criteria; hour09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour10( c : in out d.Criteria; hour10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour11( c : in out d.Criteria; hour11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour12( c : in out d.Criteria; hour12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour13( c : in out d.Criteria; hour13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour14( c : in out d.Criteria; hour14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour15( c : in out d.Criteria; hour15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour16( c : in out d.Criteria; hour16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour17( c : in out d.Criteria; hour17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour18( c : in out d.Criteria; hour18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour19( c : in out d.Criteria; hour19 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_hour20( c : in out d.Criteria; hour20 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo01( c : in out d.Criteria; wholoo01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo02( c : in out d.Criteria; wholoo02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo03( c : in out d.Criteria; wholoo03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo04( c : in out d.Criteria; wholoo04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo05( c : in out d.Criteria; wholoo05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo06( c : in out d.Criteria; wholoo06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo07( c : in out d.Criteria; wholoo07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo08( c : in out d.Criteria; wholoo08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo09( c : in out d.Criteria; wholoo09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo10( c : in out d.Criteria; wholoo10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo11( c : in out d.Criteria; wholoo11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo12( c : in out d.Criteria; wholoo12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo13( c : in out d.Criteria; wholoo13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo14( c : in out d.Criteria; wholoo14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo15( c : in out d.Criteria; wholoo15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo16( c : in out d.Criteria; wholoo16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo17( c : in out d.Criteria; wholoo17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo18( c : in out d.Criteria; wholoo18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo19( c : in out d.Criteria; wholoo19 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wholoo20( c : in out d.Criteria; wholoo20 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng01( c : in out d.Criteria; howlng01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng02( c : in out d.Criteria; howlng02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng03( c : in out d.Criteria; howlng03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng04( c : in out d.Criteria; howlng04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng05( c : in out d.Criteria; howlng05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng06( c : in out d.Criteria; howlng06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng07( c : in out d.Criteria; howlng07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng08( c : in out d.Criteria; howlng08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng09( c : in out d.Criteria; howlng09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng10( c : in out d.Criteria; howlng10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng11( c : in out d.Criteria; howlng11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng12( c : in out d.Criteria; howlng12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng13( c : in out d.Criteria; howlng13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng14( c : in out d.Criteria; howlng14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng15( c : in out d.Criteria; howlng15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng16( c : in out d.Criteria; howlng16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng17( c : in out d.Criteria; howlng17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng18( c : in out d.Criteria; howlng18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng19( c : in out d.Criteria; howlng19 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_howlng20( c : in out d.Criteria; howlng20 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_counter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_needper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_daynight_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_freq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_hour20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wholoo20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_howlng20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Care;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 71, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    7 : needper                  : Parameter_Integer  : Integer              :        0 
   --    8 : daynight                 : Parameter_Integer  : Integer              :        0 
   --    9 : freq                     : Parameter_Integer  : Integer              :        0 
   --   10 : hour01                   : Parameter_Integer  : Integer              :        0 
   --   11 : hour02                   : Parameter_Integer  : Integer              :        0 
   --   12 : hour03                   : Parameter_Integer  : Integer              :        0 
   --   13 : hour04                   : Parameter_Integer  : Integer              :        0 
   --   14 : hour05                   : Parameter_Integer  : Integer              :        0 
   --   15 : hour06                   : Parameter_Integer  : Integer              :        0 
   --   16 : hour07                   : Parameter_Integer  : Integer              :        0 
   --   17 : hour08                   : Parameter_Integer  : Integer              :        0 
   --   18 : hour09                   : Parameter_Integer  : Integer              :        0 
   --   19 : hour10                   : Parameter_Integer  : Integer              :        0 
   --   20 : hour11                   : Parameter_Integer  : Integer              :        0 
   --   21 : hour12                   : Parameter_Integer  : Integer              :        0 
   --   22 : hour13                   : Parameter_Integer  : Integer              :        0 
   --   23 : hour14                   : Parameter_Integer  : Integer              :        0 
   --   24 : hour15                   : Parameter_Integer  : Integer              :        0 
   --   25 : hour16                   : Parameter_Integer  : Integer              :        0 
   --   26 : hour17                   : Parameter_Integer  : Integer              :        0 
   --   27 : hour18                   : Parameter_Integer  : Integer              :        0 
   --   28 : hour19                   : Parameter_Integer  : Integer              :        0 
   --   29 : hour20                   : Parameter_Integer  : Integer              :        0 
   --   30 : wholoo01                 : Parameter_Integer  : Integer              :        0 
   --   31 : wholoo02                 : Parameter_Integer  : Integer              :        0 
   --   32 : wholoo03                 : Parameter_Integer  : Integer              :        0 
   --   33 : wholoo04                 : Parameter_Integer  : Integer              :        0 
   --   34 : wholoo05                 : Parameter_Integer  : Integer              :        0 
   --   35 : wholoo06                 : Parameter_Integer  : Integer              :        0 
   --   36 : wholoo07                 : Parameter_Integer  : Integer              :        0 
   --   37 : wholoo08                 : Parameter_Integer  : Integer              :        0 
   --   38 : wholoo09                 : Parameter_Integer  : Integer              :        0 
   --   39 : wholoo10                 : Parameter_Integer  : Integer              :        0 
   --   40 : wholoo11                 : Parameter_Integer  : Integer              :        0 
   --   41 : wholoo12                 : Parameter_Integer  : Integer              :        0 
   --   42 : wholoo13                 : Parameter_Integer  : Integer              :        0 
   --   43 : wholoo14                 : Parameter_Integer  : Integer              :        0 
   --   44 : wholoo15                 : Parameter_Integer  : Integer              :        0 
   --   45 : wholoo16                 : Parameter_Integer  : Integer              :        0 
   --   46 : wholoo17                 : Parameter_Integer  : Integer              :        0 
   --   47 : wholoo18                 : Parameter_Integer  : Integer              :        0 
   --   48 : wholoo19                 : Parameter_Integer  : Integer              :        0 
   --   49 : wholoo20                 : Parameter_Integer  : Integer              :        0 
   --   50 : month                    : Parameter_Integer  : Integer              :        0 
   --   51 : howlng01                 : Parameter_Integer  : Integer              :        0 
   --   52 : howlng02                 : Parameter_Integer  : Integer              :        0 
   --   53 : howlng03                 : Parameter_Integer  : Integer              :        0 
   --   54 : howlng04                 : Parameter_Integer  : Integer              :        0 
   --   55 : howlng05                 : Parameter_Integer  : Integer              :        0 
   --   56 : howlng06                 : Parameter_Integer  : Integer              :        0 
   --   57 : howlng07                 : Parameter_Integer  : Integer              :        0 
   --   58 : howlng08                 : Parameter_Integer  : Integer              :        0 
   --   59 : howlng09                 : Parameter_Integer  : Integer              :        0 
   --   60 : howlng10                 : Parameter_Integer  : Integer              :        0 
   --   61 : howlng11                 : Parameter_Integer  : Integer              :        0 
   --   62 : howlng12                 : Parameter_Integer  : Integer              :        0 
   --   63 : howlng13                 : Parameter_Integer  : Integer              :        0 
   --   64 : howlng14                 : Parameter_Integer  : Integer              :        0 
   --   65 : howlng15                 : Parameter_Integer  : Integer              :        0 
   --   66 : howlng16                 : Parameter_Integer  : Integer              :        0 
   --   67 : howlng17                 : Parameter_Integer  : Integer              :        0 
   --   68 : howlng18                 : Parameter_Integer  : Integer              :        0 
   --   69 : howlng19                 : Parameter_Integer  : Integer              :        0 
   --   70 : howlng20                 : Parameter_Integer  : Integer              :        0 
   --   71 : issue                    : Parameter_Integer  : Integer              :        0 
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
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Care_IO;
