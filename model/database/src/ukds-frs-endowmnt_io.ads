--
-- Created by Ada Mill (https://github.com/grahamstark/ada_mill)
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

package Ukds.Frs.Endowmnt_IO is
  
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
   function Next_Free_mortseq( connection : Database_Connection := null) return Integer;
   function Next_Free_endowseq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_endowmnt match the defaults in Ukds.Frs.Null_Endowmnt
   --
   function Is_Null( a_endowmnt : Endowmnt ) return Boolean;
   
   --
   -- returns the single a_endowmnt matching the primary key fields, or the Ukds.Frs.Null_Endowmnt record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; mortseq : Integer; endowseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Endowmnt;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; mortseq : Integer; endowseq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Endowmnt matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Endowmnt_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Endowmnt retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Endowmnt_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_endowmnt : Ukds.Frs.Endowmnt; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Endowmnt
   --
   procedure Delete( a_endowmnt : in out Ukds.Frs.Endowmnt; connection : Database_Connection := null );
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
   procedure Add_mortseq( c : in out d.Criteria; mortseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endowseq( c : in out d.Criteria; endowseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incinint( c : in out d.Criteria; incinint : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_menpolam( c : in out d.Criteria; menpolam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_menpolpd( c : in out d.Criteria; menpolpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_menstyr( c : in out d.Criteria; menstyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endowseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incinint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_menpolam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_menpolpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_menstyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Endowmnt;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 12, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : mortseq                  : Parameter_Integer  : Integer              :        0 
   --    6 : endowseq                 : Parameter_Integer  : Integer              :        0 
   --    7 : incinint                 : Parameter_Integer  : Integer              :        0 
   --    8 : menpolam                 : Parameter_Float    : Amount               :      0.0 
   --    9 : menpolpd                 : Parameter_Integer  : Integer              :        0 
   --   10 : menstyr                  : Parameter_Integer  : Integer              :        0 
   --   11 : month                    : Parameter_Integer  : Integer              :        0 
   --   12 : issue                    : Parameter_Integer  : Integer              :        0 
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
   --    5 : mortseq                  : Parameter_Integer  : Integer              :        0 
   --    6 : endowseq                 : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Endowmnt_IO;
