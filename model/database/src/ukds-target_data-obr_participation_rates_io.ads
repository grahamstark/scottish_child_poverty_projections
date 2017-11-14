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

package Ukds.Target_Data.Obr_Participation_Rates_IO is
  
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
   -- returns true if the primary key parts of a_obr_participation_rates match the defaults in Ukds.Target_Data.Null_Obr_Participation_Rates
   --
   function Is_Null( a_obr_participation_rates : Obr_Participation_Rates ) return Boolean;
   
   --
   -- returns the single a_obr_participation_rates matching the primary key fields, or the Ukds.Target_Data.Null_Obr_Participation_Rates record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Obr_Participation_Rates matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Obr_Participation_Rates retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Obr_Participation_Rates_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_obr_participation_rates : Ukds.Target_Data.Obr_Participation_Rates; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Obr_Participation_Rates
   --
   procedure Delete( a_obr_participation_rates : in out Ukds.Target_Data.Obr_Participation_Rates; connection : Database_Connection := null );
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
   procedure Add_target_group( c : in out d.Criteria; target_group : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_target_group( c : in out d.Criteria; target_group : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_16_19( c : in out d.Criteria; age_16_19 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_20_24( c : in out d.Criteria; age_20_24 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_25_29( c : in out d.Criteria; age_25_29 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_30_34( c : in out d.Criteria; age_30_34 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_35_39( c : in out d.Criteria; age_35_39 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_40_44( c : in out d.Criteria; age_40_44 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_45_49( c : in out d.Criteria; age_45_49 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_50_54( c : in out d.Criteria; age_50_54 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_55_59( c : in out d.Criteria; age_55_59 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_60_64( c : in out d.Criteria; age_60_64 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_65_69( c : in out d.Criteria; age_65_69 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_70_74( c : in out d.Criteria; age_70_74 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_age_75_plus( c : in out d.Criteria; age_75_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_target_group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_16_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_20_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_25_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_30_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_35_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_40_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_45_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_50_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_55_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_60_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_65_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_70_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_age_75_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Obr_Participation_Rates;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 19, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    6 : target_group             : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    7 : age_16_19                : Parameter_Float    : Amount               :      0.0 
   --    8 : age_20_24                : Parameter_Float    : Amount               :      0.0 
   --    9 : age_25_29                : Parameter_Float    : Amount               :      0.0 
   --   10 : age_30_34                : Parameter_Float    : Amount               :      0.0 
   --   11 : age_35_39                : Parameter_Float    : Amount               :      0.0 
   --   12 : age_40_44                : Parameter_Float    : Amount               :      0.0 
   --   13 : age_45_49                : Parameter_Float    : Amount               :      0.0 
   --   14 : age_50_54                : Parameter_Float    : Amount               :      0.0 
   --   15 : age_55_59                : Parameter_Float    : Amount               :      0.0 
   --   16 : age_60_64                : Parameter_Float    : Amount               :      0.0 
   --   17 : age_65_69                : Parameter_Float    : Amount               :      0.0 
   --   18 : age_70_74                : Parameter_Float    : Amount               :      0.0 
   --   19 : age_75_plus              : Parameter_Float    : Amount               :      0.0 
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
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    6 : target_group             : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Target_Data.Obr_Participation_Rates_IO;
