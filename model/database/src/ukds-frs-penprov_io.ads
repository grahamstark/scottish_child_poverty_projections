--
-- Created by ada_generator.py on 2017-10-16 22:11:04.541024
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

package Ukds.Frs.Penprov_IO is
  
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
   function Next_Free_counter( connection : Database_Connection := null) return Integer;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;
   function Next_Free_benunit( connection : Database_Connection := null) return Integer;
   function Next_Free_person( connection : Database_Connection := null) return Integer;
   function Next_Free_provseq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_penprov match the defaults in Ukds.Frs.Null_Penprov
   --
   function Is_Null( a_penprov : Penprov ) return Boolean;
   
   --
   -- returns the single a_penprov matching the primary key fields, or the Ukds.Frs.Null_Penprov record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; provseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Penprov;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; provseq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Penprov matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Penprov retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_penprov : Ukds.Frs.Penprov; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Penprov
   --
   procedure Delete( a_penprov : in out Ukds.Frs.Penprov; connection : Database_Connection := null );
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
   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stemppay( c : in out d.Criteria; stemppay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_provseq( c : in out d.Criteria; provseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eplong( c : in out d.Criteria; eplong : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_eptype( c : in out d.Criteria; eptype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_keeppen( c : in out d.Criteria; keeppen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_opgov( c : in out d.Criteria; opgov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penamt( c : in out d.Criteria; penamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penamtpd( c : in out d.Criteria; penamtpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pencon( c : in out d.Criteria; pencon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pendat( c : in out d.Criteria; pendat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_pengov( c : in out d.Criteria; pengov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penhelp( c : in out d.Criteria; penhelp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penmort( c : in out d.Criteria; penmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_spwho( c : in out d.Criteria; spwho : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_stemppen( c : in out d.Criteria; stemppen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penreb( c : in out d.Criteria; penreb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rebgov( c : in out d.Criteria; rebgov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penamtdt( c : in out d.Criteria; penamtdt : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_penchk( c : in out d.Criteria; penchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_counter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stemppay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_provseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eplong_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_eptype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_keeppen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_opgov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penamtpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pencon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pendat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_pengov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penhelp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_spwho_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_stemppen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penreb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rebgov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penamtdt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_penchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Penprov;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 28, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    7 : person                   : Parameter_Integer  : Integer              :        0 
   --    8 : stemppay                 : Parameter_Integer  : Integer              :        0 
   --    9 : provseq                  : Parameter_Integer  : Integer              :        0 
   --   10 : eplong                   : Parameter_Integer  : Integer              :        0 
   --   11 : eptype                   : Parameter_Integer  : Integer              :        0 
   --   12 : keeppen                  : Parameter_Integer  : Integer              :        0 
   --   13 : opgov                    : Parameter_Integer  : Integer              :        0 
   --   14 : penamt                   : Parameter_Float    : Amount               :      0.0 
   --   15 : penamtpd                 : Parameter_Integer  : Integer              :        0 
   --   16 : pencon                   : Parameter_Integer  : Integer              :        0 
   --   17 : pendat                   : Parameter_Integer  : Integer              :        0 
   --   18 : pengov                   : Parameter_Integer  : Integer              :        0 
   --   19 : penhelp                  : Parameter_Integer  : Integer              :        0 
   --   20 : penmort                  : Parameter_Integer  : Integer              :        0 
   --   21 : spwho                    : Parameter_Integer  : Integer              :        0 
   --   22 : month                    : Parameter_Integer  : Integer              :        0 
   --   23 : stemppen                 : Parameter_Integer  : Integer              :        0 
   --   24 : penreb                   : Parameter_Integer  : Integer              :        0 
   --   25 : rebgov                   : Parameter_Integer  : Integer              :        0 
   --   26 : issue                    : Parameter_Integer  : Integer              :        0 
   --   27 : penamtdt                 : Parameter_Date     : Ada.Calendar.Time    :    Clock 
   --   28 : penchk                   : Parameter_Integer  : Integer              :        0 
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
   --    4 : counter                  : Parameter_Integer  : Integer              :        0 
   --    5 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    6 : benunit                  : Parameter_Integer  : Integer              :        0 
   --    7 : person                   : Parameter_Integer  : Integer              :        0 
   --    8 : provseq                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Penprov_IO;
