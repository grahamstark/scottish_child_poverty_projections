--
-- Created by ada_generator.py on 2017-09-21 20:55:36.885895
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

package Ukds.Target_Data.Macro_Forecasts_IO is
  
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
   -- returns true if the primary key parts of a_macro_forecasts match the defaults in Ukds.Target_Data.Null_Macro_Forecasts
   --
   function Is_Null( a_macro_forecasts : Macro_Forecasts ) return Boolean;
   
   --
   -- returns the single a_macro_forecasts matching the primary key fields, or the Ukds.Target_Data.Null_Macro_Forecasts record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Macro_Forecasts;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( year : Year_Number; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Macro_Forecasts matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Macro_Forecasts_List;
   
   --
   -- Retrieves a list of Ukds.Target_Data.Macro_Forecasts retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Macro_Forecasts_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_macro_forecasts : Ukds.Target_Data.Macro_Forecasts; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Macro_Forecasts
   --
   procedure Delete( a_macro_forecasts : in out Ukds.Target_Data.Macro_Forecasts; connection : Database_Connection := null );
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
   procedure Add_employment( c : in out d.Criteria; employment : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employment_rate( c : in out d.Criteria; employment_rate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employees( c : in out d.Criteria; employees : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ilo_unemployment( c : in out d.Criteria; ilo_unemployment : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_ilo_unemployment_rate( c : in out d.Criteria; ilo_unemployment_rate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_participation_rate( c : in out d.Criteria; participation_rate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_claimant_count( c : in out d.Criteria; claimant_count : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_average_hours_worked( c : in out d.Criteria; average_hours_worked : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_total_hours_worked( c : in out d.Criteria; total_hours_worked : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_labour_share( c : in out d.Criteria; labour_share : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_compensation_of_employees( c : in out d.Criteria; compensation_of_employees : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_wages_and_salaries( c : in out d.Criteria; wages_and_salaries : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_employers_social_contributions( c : in out d.Criteria; employers_social_contributions : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mixed_income( c : in out d.Criteria; mixed_income : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_average_earnings_growth( c : in out d.Criteria; average_earnings_growth : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_average_earnings_index( c : in out d.Criteria; average_earnings_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_average_hourly_earnings_index( c : in out d.Criteria; average_hourly_earnings_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_productivity_per_hour_index( c : in out d.Criteria; productivity_per_hour_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_productivity_per_worker_index( c : in out d.Criteria; productivity_per_worker_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_product_wage( c : in out d.Criteria; real_product_wage : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_consumption_wage( c : in out d.Criteria; real_consumption_wage : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rpi( c : in out d.Criteria; rpi : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rpix( c : in out d.Criteria; rpix : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_cpi( c : in out d.Criteria; cpi : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_producer_output_prices( c : in out d.Criteria; producer_output_prices : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortgage_interest_payments( c : in out d.Criteria; mortgage_interest_payments : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_actual_rents_for_housing( c : in out d.Criteria; actual_rents_for_housing : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_consumer_expenditure_deflator( c : in out d.Criteria; consumer_expenditure_deflator : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_house_price_index( c : in out d.Criteria; house_price_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_gdp_deflator( c : in out d.Criteria; gdp_deflator : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lfs_employment( c : in out d.Criteria; lfs_employment : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_household_disposable_income( c : in out d.Criteria; real_household_disposable_income : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_consumption( c : in out d.Criteria; real_consumption : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_gdp( c : in out d.Criteria; real_gdp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_lfs_employment_age_16_plus( c : in out d.Criteria; lfs_employment_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_household_disposable_income_age_16_plus( c : in out d.Criteria; real_household_disposable_income_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_consumption_age_16_plus( c : in out d.Criteria; real_consumption_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_real_gdp_age_16_plus( c : in out d.Criteria; real_gdp_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employment_rate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employees_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ilo_unemployment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_ilo_unemployment_rate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_participation_rate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_claimant_count_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_average_hours_worked_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_total_hours_worked_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_labour_share_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_compensation_of_employees_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_wages_and_salaries_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_employers_social_contributions_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mixed_income_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_average_earnings_growth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_average_earnings_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_average_hourly_earnings_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_productivity_per_hour_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_productivity_per_worker_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_product_wage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_consumption_wage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rpi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rpix_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_cpi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_producer_output_prices_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortgage_interest_payments_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_actual_rents_for_housing_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_consumer_expenditure_deflator_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_house_price_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_gdp_deflator_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lfs_employment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_household_disposable_income_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_consumption_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_gdp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_lfs_employment_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_household_disposable_income_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_consumption_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_real_gdp_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Target_Data.Macro_Forecasts;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 43, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : year                     : Parameter_Integer  : Year_Number          :        0 
   --    2 : rec_type                 : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    3 : variant                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    4 : country                  : Parameter_Text     : Unbounded_String     : null, Null_Unbounded_String 
   --    5 : edition                  : Parameter_Integer  : Year_Number          :        0 
   --    6 : employment               : Parameter_Float    : Amount               :      0.0 
   --    7 : employment_rate          : Parameter_Float    : Amount               :      0.0 
   --    8 : employees                : Parameter_Float    : Amount               :      0.0 
   --    9 : ilo_unemployment         : Parameter_Float    : Amount               :      0.0 
   --   10 : ilo_unemployment_rate    : Parameter_Float    : Amount               :      0.0 
   --   11 : participation_rate       : Parameter_Float    : Amount               :      0.0 
   --   12 : claimant_count           : Parameter_Float    : Amount               :      0.0 
   --   13 : average_hours_worked     : Parameter_Float    : Amount               :      0.0 
   --   14 : total_hours_worked       : Parameter_Float    : Amount               :      0.0 
   --   15 : labour_share             : Parameter_Float    : Amount               :      0.0 
   --   16 : compensation_of_employees : Parameter_Float    : Amount               :      0.0 
   --   17 : wages_and_salaries       : Parameter_Float    : Amount               :      0.0 
   --   18 : employers_social_contributions : Parameter_Float    : Amount               :      0.0 
   --   19 : mixed_income             : Parameter_Float    : Amount               :      0.0 
   --   20 : average_earnings_growth  : Parameter_Float    : Amount               :      0.0 
   --   21 : average_earnings_index   : Parameter_Float    : Amount               :      0.0 
   --   22 : average_hourly_earnings_index : Parameter_Float    : Amount               :      0.0 
   --   23 : productivity_per_hour_index : Parameter_Float    : Amount               :      0.0 
   --   24 : productivity_per_worker_index : Parameter_Float    : Amount               :      0.0 
   --   25 : real_product_wage        : Parameter_Float    : Amount               :      0.0 
   --   26 : real_consumption_wage    : Parameter_Float    : Amount               :      0.0 
   --   27 : rpi                      : Parameter_Float    : Amount               :      0.0 
   --   28 : rpix                     : Parameter_Float    : Amount               :      0.0 
   --   29 : cpi                      : Parameter_Float    : Amount               :      0.0 
   --   30 : producer_output_prices   : Parameter_Float    : Amount               :      0.0 
   --   31 : mortgage_interest_payments : Parameter_Float    : Amount               :      0.0 
   --   32 : actual_rents_for_housing : Parameter_Float    : Amount               :      0.0 
   --   33 : consumer_expenditure_deflator : Parameter_Float    : Amount               :      0.0 
   --   34 : house_price_index        : Parameter_Float    : Amount               :      0.0 
   --   35 : gdp_deflator             : Parameter_Float    : Amount               :      0.0 
   --   36 : lfs_employment           : Parameter_Float    : Amount               :      0.0 
   --   37 : real_household_disposable_income : Parameter_Float    : Amount               :      0.0 
   --   38 : real_consumption         : Parameter_Float    : Amount               :      0.0 
   --   39 : real_gdp                 : Parameter_Float    : Amount               :      0.0 
   --   40 : lfs_employment_age_16_plus : Parameter_Float    : Amount               :      0.0 
   --   41 : real_household_disposable_income_age_16_plus : Parameter_Float    : Amount               :      0.0 
   --   42 : real_consumption_age_16_plus : Parameter_Float    : Amount               :      0.0 
   --   43 : real_gdp_age_16_plus     : Parameter_Float    : Amount               :      0.0 
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

  
end Ukds.Target_Data.Macro_Forecasts_IO;
