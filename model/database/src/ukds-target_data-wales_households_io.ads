--
-- Created by ada_generator.py on 2017-10-25 13:04:26.454725
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

package Ukds.Target_Data.Wales_Households_IO is
  
   package d renames DB_Commons;   
   use Base_Types;
   use Ada.Strings.Unbounded;
   use Ada.Calendar;
   
   SCHEMA_NAME : constant String := "target_data";
   
   use GNATCOLL.SQL.Exec;
   
   use Ukds;
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;
   use SCP_Types;
   use Weighting_Commons;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_year( connection : Database_Connection := null) return Year_Number;
   function Next_Free_edition( connection : Database_Connection := null) return Year_Number;

   --
   -- returns true if the primary key parts of a_wales_households match the defaults in Ukds.Target_Data.Null_Wales_Households
   --
   function Is_Null( a_wales_households : Wales_Households ) return Boolean;
   
   --
   -- returns the single a_wales_households matching the primary key fields, or the Ukds.Target_Data.Null_Wales_Households record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Wales_Households;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Wales_Households matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Wales_Households_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Wales_Households retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Wales_Households_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_wales_households : Ukds.Target_Data.Wales_Households; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Wales_Households
   --
   procedure Delete( a_wales_households : in out Ukds.Target_Data.Wales_Households; connection : Database_Connection := null );
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
   procedure Add_year( c : in out d.Criteria; year : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_variant( c : in out d.Criteria; variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_variant( c : in out d.Criteria; variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_1_person( c : in out d.Criteria; v_1_person : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_2_person_no_children( c : in out d.Criteria; v_2_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_2_person_1_adult_1_child( c : in out d.Criteria; v_2_person_1_adult_1_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_3_person_no_children( c : in out d.Criteria; v_3_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_3_person_2_adults_1_child( c : in out d.Criteria; v_3_person_2_adults_1_child : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_3_person_1_adult_2_children( c : in out d.Criteria; v_3_person_1_adult_2_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_4_person_no_children( c : in out d.Criteria; v_4_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_4_person_2_plus_adults_1_plus_children( c : in out d.Criteria; v_4_person_2_plus_adults_1_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_4_person_1_adult_3_children( c : in out d.Criteria; v_4_person_1_adult_3_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_5_plus_person_no_children( c : in out d.Criteria; v_5_plus_person_no_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_5_plus_person_2_plus_adults_1_plus_children( c : in out d.Criteria; v_5_plus_person_2_plus_adults_1_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_v_5_plus_person_1_adult_4_plus_children( c : in out d.Criteria; v_5_plus_person_1_adult_4_plus_children : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_1_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_2_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_2_person_1_adult_1_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_3_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_3_person_2_adults_1_child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_3_person_1_adult_2_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_4_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_4_person_2_plus_adults_1_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_4_person_1_adult_3_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_5_plus_person_no_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_5_plus_person_2_plus_adults_1_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_v_5_plus_person_1_adult_4_plus_children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Wales_Households;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 17, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    6 : v_1_person               : Parameter_Float    : Amount               :      0.0 
   --    7 : v_2_person_no_children   : Parameter_Float    : Amount               :      0.0 
   --    8 : v_2_person_1_adult_1_child : Parameter_Float    : Amount               :      0.0 
   --    9 : v_3_person_no_children   : Parameter_Float    : Amount               :      0.0 
   --   10 : v_3_person_2_adults_1_child : Parameter_Float    : Amount               :      0.0 
   --   11 : v_3_person_1_adult_2_children : Parameter_Float    : Amount               :      0.0 
   --   12 : v_4_person_no_children   : Parameter_Float    : Amount               :      0.0 
   --   13 : v_4_person_2_plus_adults_1_plus_children : Parameter_Float    : Amount               :      0.0 
   --   14 : v_4_person_1_adult_3_children : Parameter_Float    : Amount               :      0.0 
   --   15 : v_5_plus_person_no_children : Parameter_Float    : Amount               :      0.0 
   --   16 : v_5_plus_person_2_plus_adults_1_plus_children : Parameter_Float    : Amount               :      0.0 
   --   17 : v_5_plus_person_1_adult_4_plus_children : Parameter_Float    : Amount               :      0.0 
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
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Wales_Households_IO;
