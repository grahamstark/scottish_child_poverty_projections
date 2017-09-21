--
-- Created by ada_generator.py on 2017-09-21 13:28:52.988113
-- 
with Ukds;


with Ada.Containers.Vectors;

with Environment;

with DB_Commons; 

with GNATCOLL.SQL_Impl;
with GNATCOLL.SQL.Postgres;
with DB_Commons.PSQL;


with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with Text_IO;
with Ada.Strings.Maps;
with Connection_Pool;
with GNATColl.Traces;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Macro_Forecasts_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.MACRO_FORECASTS_IO" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --

   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "year, rec_type, variant, country, edition, employment, employment_rate, employees, ilo_unemployment, ilo_unemployment_rate," &
         "participation_rate, claimant_count, average_hours_worked, total_hours_worked, labour_share, compensation_of_employees, wages_and_salaries, employers_social_contributions, mixed_income, average_earnings_growth," &
         "average_earnings_index, average_hourly_earnings_index, productivity_per_hour_index, productivity_per_worker_index, real_product_wage, real_consumption_wage, rpi, rpix, cpi, producer_output_prices," &
         "mortgage_interest_payments, actual_rents_for_housing, consumer_expenditure_deflator, house_price_index, gdp_deflator, lfs_employment, real_household_disposable_income, real_consumption, real_gdp, lfs_employment_age_16_plus," &
         "real_household_disposable_income_age_16_plus, real_consumption_age_16_plus, real_gdp_age_16_plus " &
         " from target_data.macro_forecasts " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.macro_forecasts (" &
         "year, rec_type, variant, country, edition, employment, employment_rate, employees, ilo_unemployment, ilo_unemployment_rate," &
         "participation_rate, claimant_count, average_hours_worked, total_hours_worked, labour_share, compensation_of_employees, wages_and_salaries, employers_social_contributions, mixed_income, average_earnings_growth," &
         "average_earnings_index, average_hourly_earnings_index, productivity_per_hour_index, productivity_per_worker_index, real_product_wage, real_consumption_wage, rpi, rpix, cpi, producer_output_prices," &
         "mortgage_interest_payments, actual_rents_for_housing, consumer_expenditure_deflator, house_price_index, gdp_deflator, lfs_employment, real_household_disposable_income, real_consumption, real_gdp, lfs_employment_age_16_plus," &
         "real_household_disposable_income_age_16_plus, real_consumption_age_16_plus, real_gdp_age_16_plus " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.macro_forecasts ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.macro_forecasts set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 43 ) := ( if update_order then (
            1 => ( Parameter_Float, 0.0 ),   --  : employment (Amount)
            2 => ( Parameter_Float, 0.0 ),   --  : employment_rate (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : employees (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployment (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployment_rate (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : participation_rate (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : claimant_count (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : average_hours_worked (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : total_hours_worked (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : labour_share (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : compensation_of_employees (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : wages_and_salaries (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : employers_social_contributions (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : mixed_income (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : average_earnings_growth (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : average_earnings_index (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : average_hourly_earnings_index (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : productivity_per_hour_index (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : productivity_per_worker_index (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : real_product_wage (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : real_consumption_wage (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : rpi (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : rpix (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : cpi (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : producer_output_prices (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : mortgage_interest_payments (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : actual_rents_for_housing (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : consumer_expenditure_deflator (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : house_price_index (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : gdp_deflator (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : lfs_employment (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : real_household_disposable_income (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : real_consumption (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : real_gdp (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : lfs_employment_age_16_plus (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : real_household_disposable_income_age_16_plus (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : real_consumption_age_16_plus (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : real_gdp_age_16_plus (Amount)
           39 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           40 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
           41 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
           42 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
           43 => ( Parameter_Integer, 0 )   --  : edition (Year_Number)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            6 => ( Parameter_Float, 0.0 ),   --  : employment (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : employment_rate (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : employees (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployment (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : ilo_unemployment_rate (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : participation_rate (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : claimant_count (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : average_hours_worked (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : total_hours_worked (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : labour_share (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : compensation_of_employees (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : wages_and_salaries (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : employers_social_contributions (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : mixed_income (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : average_earnings_growth (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : average_earnings_index (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : average_hourly_earnings_index (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : productivity_per_hour_index (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : productivity_per_worker_index (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : real_product_wage (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : real_consumption_wage (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : rpi (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : rpix (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : cpi (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : producer_output_prices (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : mortgage_interest_payments (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : actual_rents_for_housing (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : consumer_expenditure_deflator (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : house_price_index (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : gdp_deflator (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : lfs_employment (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : real_household_disposable_income (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : real_consumption (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : real_gdp (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : lfs_employment_age_16_plus (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : real_household_disposable_income_age_16_plus (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : real_consumption_age_16_plus (Amount)
           43 => ( Parameter_Float, 0.0 )   --  : real_gdp_age_16_plus (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 5 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 )   --  : edition (Year_Number)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5"; 
   begin 
      return Get_Prepared_Retrieve_Statement( s ); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return gse.Prepared_Statement is 
   begin 
      return Get_Prepared_Retrieve_Statement( d.To_String( crit )); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) & sqlstr; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Retrieve_Statement; 


   function Get_Prepared_Update_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " employment = $1, employment_rate = $2, employees = $3, ilo_unemployment = $4, ilo_unemployment_rate = $5, participation_rate = $6, claimant_count = $7, average_hours_worked = $8, total_hours_worked = $9, labour_share = $10, compensation_of_employees = $11, wages_and_salaries = $12, employers_social_contributions = $13, mixed_income = $14, average_earnings_growth = $15, average_earnings_index = $16, average_hourly_earnings_index = $17, productivity_per_hour_index = $18, productivity_per_worker_index = $19, real_product_wage = $20, real_consumption_wage = $21, rpi = $22, rpix = $23, cpi = $24, producer_output_prices = $25, mortgage_interest_payments = $26, actual_rents_for_housing = $27, consumer_expenditure_deflator = $28, house_price_index = $29, gdp_deflator = $30, lfs_employment = $31, real_household_disposable_income = $32, real_consumption = $33, real_gdp = $34, lfs_employment_age_16_plus = $35, real_household_disposable_income_age_16_plus = $36, real_consumption_age_16_plus = $37, real_gdp_age_16_plus = $38 where year = $39 and rec_type = $40 and variant = $41 and country = $42 and edition = $43"; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Update_Statement; 


   
   
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     


   
   Next_Free_year_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from target_data.macro_forecasts", SCHEMA_NAME );
   Next_Free_year_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_year_query, On_Server => True );
   -- 
   -- Next highest avaiable value of year - useful for saving  
   --
   function Next_Free_year( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_year;


   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from target_data.macro_forecasts", SCHEMA_NAME );
   Next_Free_edition_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_edition_query, On_Server => True );
   -- 
   -- Next highest avaiable value of edition - useful for saving  
   --
   function Next_Free_edition( connection : Database_Connection := null) return Year_Number is
      cursor              : gse.Forward_Cursor;
      ai                  : Year_Number;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_edition_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Year_Number'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_edition;



   --
   -- returns true if the primary key parts of Ukds.Target_Data.Macro_Forecasts match the defaults in Ukds.Target_Data.Null_Macro_Forecasts
   --
   --
   -- Does this Ukds.Target_Data.Macro_Forecasts equal the default Ukds.Target_Data.Null_Macro_Forecasts ?
   --
   function Is_Null( a_macro_forecasts : Macro_Forecasts ) return Boolean is
   begin
      return a_macro_forecasts = Ukds.Target_Data.Null_Macro_Forecasts;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Macro_Forecasts matching the primary key fields, or the Ukds.Target_Data.Null_Macro_Forecasts record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Integer; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Ukds.Target_Data.Macro_Forecasts is
      l : Ukds.Target_Data.Macro_Forecasts_List;
      a_macro_forecasts : Ukds.Target_Data.Macro_Forecasts;
      c : d.Criteria;
   begin      
      Add_year( c, year );
      Add_rec_type( c, rec_type );
      Add_variant( c, variant );
      Add_country( c, country );
      Add_edition( c, edition );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Macro_Forecasts_List_Package.is_empty( l ) ) then
         a_macro_forecasts := Ukds.Target_Data.Macro_Forecasts_List_Package.First_Element( l );
      else
         a_macro_forecasts := Ukds.Target_Data.Null_Macro_Forecasts;
      end if;
      return a_macro_forecasts;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.macro_forecasts where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5", 
        On_Server => True );
        
   function Exists( year : Integer; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      aliased_rec_type : aliased String := To_String( rec_type );
      aliased_variant : aliased String := To_String( variant );
      aliased_country : aliased String := To_String( country );
      cursor : gse.Forward_Cursor;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      found : Boolean;        
   begin 
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      params( 1 ) := "+"( Integer'Pos( year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( edition ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Macro_Forecasts matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Macro_Forecasts_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Macro_Forecasts retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Macro_Forecasts is
      a_macro_forecasts : Ukds.Target_Data.Macro_Forecasts;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_macro_forecasts.year := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_macro_forecasts.rec_type:= To_Unbounded_String( gse.Value( cursor, 1 ));
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_macro_forecasts.variant:= To_Unbounded_String( gse.Value( cursor, 2 ));
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_macro_forecasts.country:= To_Unbounded_String( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_macro_forecasts.edition := Year_Number'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_macro_forecasts.employment:= Amount'Value( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_macro_forecasts.employment_rate:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_macro_forecasts.employees:= Amount'Value( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_macro_forecasts.ilo_unemployment:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_macro_forecasts.ilo_unemployment_rate:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_macro_forecasts.participation_rate:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_macro_forecasts.claimant_count:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_macro_forecasts.average_hours_worked:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_macro_forecasts.total_hours_worked:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_macro_forecasts.labour_share:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_macro_forecasts.compensation_of_employees:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_macro_forecasts.wages_and_salaries:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_macro_forecasts.employers_social_contributions:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_macro_forecasts.mixed_income:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_macro_forecasts.average_earnings_growth:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_macro_forecasts.average_earnings_index:= Amount'Value( gse.Value( cursor, 20 ));
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_macro_forecasts.average_hourly_earnings_index:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_macro_forecasts.productivity_per_hour_index:= Amount'Value( gse.Value( cursor, 22 ));
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_macro_forecasts.productivity_per_worker_index:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_macro_forecasts.real_product_wage:= Amount'Value( gse.Value( cursor, 24 ));
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_macro_forecasts.real_consumption_wage:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_macro_forecasts.rpi:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_macro_forecasts.rpix:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_macro_forecasts.cpi:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_macro_forecasts.producer_output_prices:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_macro_forecasts.mortgage_interest_payments:= Amount'Value( gse.Value( cursor, 30 ));
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_macro_forecasts.actual_rents_for_housing:= Amount'Value( gse.Value( cursor, 31 ));
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_macro_forecasts.consumer_expenditure_deflator:= Amount'Value( gse.Value( cursor, 32 ));
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_macro_forecasts.house_price_index:= Amount'Value( gse.Value( cursor, 33 ));
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_macro_forecasts.gdp_deflator:= Amount'Value( gse.Value( cursor, 34 ));
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_macro_forecasts.lfs_employment:= Amount'Value( gse.Value( cursor, 35 ));
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_macro_forecasts.real_household_disposable_income:= Amount'Value( gse.Value( cursor, 36 ));
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_macro_forecasts.real_consumption:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_macro_forecasts.real_gdp:= Amount'Value( gse.Value( cursor, 38 ));
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_macro_forecasts.lfs_employment_age_16_plus:= Amount'Value( gse.Value( cursor, 39 ));
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_macro_forecasts.real_household_disposable_income_age_16_plus:= Amount'Value( gse.Value( cursor, 40 ));
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_macro_forecasts.real_consumption_age_16_plus:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_macro_forecasts.real_gdp_age_16_plus:= Amount'Value( gse.Value( cursor, 42 ));
      end if;
      return a_macro_forecasts;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Macro_Forecasts_List is
      l : Ukds.Target_Data.Macro_Forecasts_List;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) 
         & " " & sqlstr;
      cursor   : gse.Forward_Cursor;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "retrieve made this as query " & query );
      cursor.Fetch( local_connection, query );
      Check_Result( local_connection );
      while gse.Has_Row( cursor ) loop
         declare
            a_macro_forecasts : Ukds.Target_Data.Macro_Forecasts := Map_From_Cursor( cursor );
         begin
            l.append( a_macro_forecasts ); 
         end;
         gse.Next( cursor );
      end loop;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --

   UPDATE_PS : constant gse.Prepared_Statement := Get_Prepared_Update_Statement;
   
   procedure Update( a_macro_forecasts : Ukds.Target_Data.Macro_Forecasts; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_macro_forecasts.rec_type );
      aliased_variant : aliased String := To_String( a_macro_forecasts.variant );
      aliased_country : aliased String := To_String( a_macro_forecasts.country );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Float( a_macro_forecasts.employment ));
      params( 2 ) := "+"( Float( a_macro_forecasts.employment_rate ));
      params( 3 ) := "+"( Float( a_macro_forecasts.employees ));
      params( 4 ) := "+"( Float( a_macro_forecasts.ilo_unemployment ));
      params( 5 ) := "+"( Float( a_macro_forecasts.ilo_unemployment_rate ));
      params( 6 ) := "+"( Float( a_macro_forecasts.participation_rate ));
      params( 7 ) := "+"( Float( a_macro_forecasts.claimant_count ));
      params( 8 ) := "+"( Float( a_macro_forecasts.average_hours_worked ));
      params( 9 ) := "+"( Float( a_macro_forecasts.total_hours_worked ));
      params( 10 ) := "+"( Float( a_macro_forecasts.labour_share ));
      params( 11 ) := "+"( Float( a_macro_forecasts.compensation_of_employees ));
      params( 12 ) := "+"( Float( a_macro_forecasts.wages_and_salaries ));
      params( 13 ) := "+"( Float( a_macro_forecasts.employers_social_contributions ));
      params( 14 ) := "+"( Float( a_macro_forecasts.mixed_income ));
      params( 15 ) := "+"( Float( a_macro_forecasts.average_earnings_growth ));
      params( 16 ) := "+"( Float( a_macro_forecasts.average_earnings_index ));
      params( 17 ) := "+"( Float( a_macro_forecasts.average_hourly_earnings_index ));
      params( 18 ) := "+"( Float( a_macro_forecasts.productivity_per_hour_index ));
      params( 19 ) := "+"( Float( a_macro_forecasts.productivity_per_worker_index ));
      params( 20 ) := "+"( Float( a_macro_forecasts.real_product_wage ));
      params( 21 ) := "+"( Float( a_macro_forecasts.real_consumption_wage ));
      params( 22 ) := "+"( Float( a_macro_forecasts.rpi ));
      params( 23 ) := "+"( Float( a_macro_forecasts.rpix ));
      params( 24 ) := "+"( Float( a_macro_forecasts.cpi ));
      params( 25 ) := "+"( Float( a_macro_forecasts.producer_output_prices ));
      params( 26 ) := "+"( Float( a_macro_forecasts.mortgage_interest_payments ));
      params( 27 ) := "+"( Float( a_macro_forecasts.actual_rents_for_housing ));
      params( 28 ) := "+"( Float( a_macro_forecasts.consumer_expenditure_deflator ));
      params( 29 ) := "+"( Float( a_macro_forecasts.house_price_index ));
      params( 30 ) := "+"( Float( a_macro_forecasts.gdp_deflator ));
      params( 31 ) := "+"( Float( a_macro_forecasts.lfs_employment ));
      params( 32 ) := "+"( Float( a_macro_forecasts.real_household_disposable_income ));
      params( 33 ) := "+"( Float( a_macro_forecasts.real_consumption ));
      params( 34 ) := "+"( Float( a_macro_forecasts.real_gdp ));
      params( 35 ) := "+"( Float( a_macro_forecasts.lfs_employment_age_16_plus ));
      params( 36 ) := "+"( Float( a_macro_forecasts.real_household_disposable_income_age_16_plus ));
      params( 37 ) := "+"( Float( a_macro_forecasts.real_consumption_age_16_plus ));
      params( 38 ) := "+"( Float( a_macro_forecasts.real_gdp_age_16_plus ));
      params( 39 ) := "+"( Integer'Pos( a_macro_forecasts.year ));
      params( 40 ) := "+"( aliased_rec_type'Access );
      params( 41 ) := "+"( aliased_variant'Access );
      params( 42 ) := "+"( aliased_country'Access );
      params( 43 ) := "+"( Year_Number'Pos( a_macro_forecasts.edition ));
      
      gse.Execute( local_connection, UPDATE_PS, params );
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   SAVE_PS : constant gse.Prepared_Statement := Get_Prepared_Insert_Statement;      

   procedure Save( a_macro_forecasts : Ukds.Target_Data.Macro_Forecasts; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_macro_forecasts.rec_type );
      aliased_variant : aliased String := To_String( a_macro_forecasts.variant );
      aliased_country : aliased String := To_String( a_macro_forecasts.country );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_macro_forecasts.year, a_macro_forecasts.rec_type, a_macro_forecasts.variant, a_macro_forecasts.country, a_macro_forecasts.edition ) then
         Update( a_macro_forecasts, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_macro_forecasts.year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( a_macro_forecasts.edition ));
      params( 6 ) := "+"( Float( a_macro_forecasts.employment ));
      params( 7 ) := "+"( Float( a_macro_forecasts.employment_rate ));
      params( 8 ) := "+"( Float( a_macro_forecasts.employees ));
      params( 9 ) := "+"( Float( a_macro_forecasts.ilo_unemployment ));
      params( 10 ) := "+"( Float( a_macro_forecasts.ilo_unemployment_rate ));
      params( 11 ) := "+"( Float( a_macro_forecasts.participation_rate ));
      params( 12 ) := "+"( Float( a_macro_forecasts.claimant_count ));
      params( 13 ) := "+"( Float( a_macro_forecasts.average_hours_worked ));
      params( 14 ) := "+"( Float( a_macro_forecasts.total_hours_worked ));
      params( 15 ) := "+"( Float( a_macro_forecasts.labour_share ));
      params( 16 ) := "+"( Float( a_macro_forecasts.compensation_of_employees ));
      params( 17 ) := "+"( Float( a_macro_forecasts.wages_and_salaries ));
      params( 18 ) := "+"( Float( a_macro_forecasts.employers_social_contributions ));
      params( 19 ) := "+"( Float( a_macro_forecasts.mixed_income ));
      params( 20 ) := "+"( Float( a_macro_forecasts.average_earnings_growth ));
      params( 21 ) := "+"( Float( a_macro_forecasts.average_earnings_index ));
      params( 22 ) := "+"( Float( a_macro_forecasts.average_hourly_earnings_index ));
      params( 23 ) := "+"( Float( a_macro_forecasts.productivity_per_hour_index ));
      params( 24 ) := "+"( Float( a_macro_forecasts.productivity_per_worker_index ));
      params( 25 ) := "+"( Float( a_macro_forecasts.real_product_wage ));
      params( 26 ) := "+"( Float( a_macro_forecasts.real_consumption_wage ));
      params( 27 ) := "+"( Float( a_macro_forecasts.rpi ));
      params( 28 ) := "+"( Float( a_macro_forecasts.rpix ));
      params( 29 ) := "+"( Float( a_macro_forecasts.cpi ));
      params( 30 ) := "+"( Float( a_macro_forecasts.producer_output_prices ));
      params( 31 ) := "+"( Float( a_macro_forecasts.mortgage_interest_payments ));
      params( 32 ) := "+"( Float( a_macro_forecasts.actual_rents_for_housing ));
      params( 33 ) := "+"( Float( a_macro_forecasts.consumer_expenditure_deflator ));
      params( 34 ) := "+"( Float( a_macro_forecasts.house_price_index ));
      params( 35 ) := "+"( Float( a_macro_forecasts.gdp_deflator ));
      params( 36 ) := "+"( Float( a_macro_forecasts.lfs_employment ));
      params( 37 ) := "+"( Float( a_macro_forecasts.real_household_disposable_income ));
      params( 38 ) := "+"( Float( a_macro_forecasts.real_consumption ));
      params( 39 ) := "+"( Float( a_macro_forecasts.real_gdp ));
      params( 40 ) := "+"( Float( a_macro_forecasts.lfs_employment_age_16_plus ));
      params( 41 ) := "+"( Float( a_macro_forecasts.real_household_disposable_income_age_16_plus ));
      params( 42 ) := "+"( Float( a_macro_forecasts.real_consumption_age_16_plus ));
      params( 43 ) := "+"( Float( a_macro_forecasts.real_gdp_age_16_plus ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Macro_Forecasts
   --

   procedure Delete( a_macro_forecasts : in out Ukds.Target_Data.Macro_Forecasts; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_year( c, a_macro_forecasts.year );
      Add_rec_type( c, a_macro_forecasts.rec_type );
      Add_variant( c, a_macro_forecasts.variant );
      Add_country( c, a_macro_forecasts.country );
      Add_edition( c, a_macro_forecasts.edition );
      Delete( c, connection );
      a_macro_forecasts := Ukds.Target_Data.Null_Macro_Forecasts;
      Log( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null ) is
   begin      
      delete( d.to_string( c ), connection );
      Log( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_clause : String; connection : gse.Database_Connection := null ) is
      local_connection : gse.Database_Connection;     
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( DELETE_PART, SCHEMA_NAME ) & where_clause;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "delete; executing query" & query );
      gse.Execute( local_connection, query );
      Check_Result( local_connection );
      Log( "delete; execute query OK" );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, year );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, To_String( rec_type ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, rec_type );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_variant( c : in out d.Criteria; variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "variant", op, join, To_String( variant ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant;


   procedure Add_variant( c : in out d.Criteria; variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "variant", op, join, variant, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant;


   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, To_String( country ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, country, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_edition( c : in out d.Criteria; edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edition", op, join, Integer( edition ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition;


   procedure Add_employment( c : in out d.Criteria; employment : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "employment", op, join, Long_Float( employment ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_employment;


   procedure Add_employment_rate( c : in out d.Criteria; employment_rate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "employment_rate", op, join, Long_Float( employment_rate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_employment_rate;


   procedure Add_employees( c : in out d.Criteria; employees : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "employees", op, join, Long_Float( employees ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_employees;


   procedure Add_ilo_unemployment( c : in out d.Criteria; ilo_unemployment : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ilo_unemployment", op, join, Long_Float( ilo_unemployment ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ilo_unemployment;


   procedure Add_ilo_unemployment_rate( c : in out d.Criteria; ilo_unemployment_rate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ilo_unemployment_rate", op, join, Long_Float( ilo_unemployment_rate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ilo_unemployment_rate;


   procedure Add_participation_rate( c : in out d.Criteria; participation_rate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "participation_rate", op, join, Long_Float( participation_rate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_rate;


   procedure Add_claimant_count( c : in out d.Criteria; claimant_count : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claimant_count", op, join, Long_Float( claimant_count ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_claimant_count;


   procedure Add_average_hours_worked( c : in out d.Criteria; average_hours_worked : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "average_hours_worked", op, join, Long_Float( average_hours_worked ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_hours_worked;


   procedure Add_total_hours_worked( c : in out d.Criteria; total_hours_worked : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "total_hours_worked", op, join, Long_Float( total_hours_worked ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_total_hours_worked;


   procedure Add_labour_share( c : in out d.Criteria; labour_share : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "labour_share", op, join, Long_Float( labour_share ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_labour_share;


   procedure Add_compensation_of_employees( c : in out d.Criteria; compensation_of_employees : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "compensation_of_employees", op, join, Long_Float( compensation_of_employees ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_compensation_of_employees;


   procedure Add_wages_and_salaries( c : in out d.Criteria; wages_and_salaries : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wages_and_salaries", op, join, Long_Float( wages_and_salaries ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wages_and_salaries;


   procedure Add_employers_social_contributions( c : in out d.Criteria; employers_social_contributions : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "employers_social_contributions", op, join, Long_Float( employers_social_contributions ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_employers_social_contributions;


   procedure Add_mixed_income( c : in out d.Criteria; mixed_income : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mixed_income", op, join, Long_Float( mixed_income ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mixed_income;


   procedure Add_average_earnings_growth( c : in out d.Criteria; average_earnings_growth : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "average_earnings_growth", op, join, Long_Float( average_earnings_growth ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_earnings_growth;


   procedure Add_average_earnings_index( c : in out d.Criteria; average_earnings_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "average_earnings_index", op, join, Long_Float( average_earnings_index ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_earnings_index;


   procedure Add_average_hourly_earnings_index( c : in out d.Criteria; average_hourly_earnings_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "average_hourly_earnings_index", op, join, Long_Float( average_hourly_earnings_index ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_hourly_earnings_index;


   procedure Add_productivity_per_hour_index( c : in out d.Criteria; productivity_per_hour_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "productivity_per_hour_index", op, join, Long_Float( productivity_per_hour_index ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_productivity_per_hour_index;


   procedure Add_productivity_per_worker_index( c : in out d.Criteria; productivity_per_worker_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "productivity_per_worker_index", op, join, Long_Float( productivity_per_worker_index ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_productivity_per_worker_index;


   procedure Add_real_product_wage( c : in out d.Criteria; real_product_wage : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_product_wage", op, join, Long_Float( real_product_wage ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_product_wage;


   procedure Add_real_consumption_wage( c : in out d.Criteria; real_consumption_wage : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_consumption_wage", op, join, Long_Float( real_consumption_wage ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_consumption_wage;


   procedure Add_rpi( c : in out d.Criteria; rpi : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rpi", op, join, Long_Float( rpi ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rpi;


   procedure Add_rpix( c : in out d.Criteria; rpix : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rpix", op, join, Long_Float( rpix ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rpix;


   procedure Add_cpi( c : in out d.Criteria; cpi : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cpi", op, join, Long_Float( cpi ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_cpi;


   procedure Add_producer_output_prices( c : in out d.Criteria; producer_output_prices : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "producer_output_prices", op, join, Long_Float( producer_output_prices ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_producer_output_prices;


   procedure Add_mortgage_interest_payments( c : in out d.Criteria; mortgage_interest_payments : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortgage_interest_payments", op, join, Long_Float( mortgage_interest_payments ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortgage_interest_payments;


   procedure Add_actual_rents_for_housing( c : in out d.Criteria; actual_rents_for_housing : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "actual_rents_for_housing", op, join, Long_Float( actual_rents_for_housing ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_actual_rents_for_housing;


   procedure Add_consumer_expenditure_deflator( c : in out d.Criteria; consumer_expenditure_deflator : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "consumer_expenditure_deflator", op, join, Long_Float( consumer_expenditure_deflator ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_consumer_expenditure_deflator;


   procedure Add_house_price_index( c : in out d.Criteria; house_price_index : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "house_price_index", op, join, Long_Float( house_price_index ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_house_price_index;


   procedure Add_gdp_deflator( c : in out d.Criteria; gdp_deflator : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gdp_deflator", op, join, Long_Float( gdp_deflator ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_gdp_deflator;


   procedure Add_lfs_employment( c : in out d.Criteria; lfs_employment : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lfs_employment", op, join, Long_Float( lfs_employment ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_lfs_employment;


   procedure Add_real_household_disposable_income( c : in out d.Criteria; real_household_disposable_income : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_household_disposable_income", op, join, Long_Float( real_household_disposable_income ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_household_disposable_income;


   procedure Add_real_consumption( c : in out d.Criteria; real_consumption : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_consumption", op, join, Long_Float( real_consumption ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_consumption;


   procedure Add_real_gdp( c : in out d.Criteria; real_gdp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_gdp", op, join, Long_Float( real_gdp ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_gdp;


   procedure Add_lfs_employment_age_16_plus( c : in out d.Criteria; lfs_employment_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lfs_employment_age_16_plus", op, join, Long_Float( lfs_employment_age_16_plus ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_lfs_employment_age_16_plus;


   procedure Add_real_household_disposable_income_age_16_plus( c : in out d.Criteria; real_household_disposable_income_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_household_disposable_income_age_16_plus", op, join, Long_Float( real_household_disposable_income_age_16_plus ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_household_disposable_income_age_16_plus;


   procedure Add_real_consumption_age_16_plus( c : in out d.Criteria; real_consumption_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_consumption_age_16_plus", op, join, Long_Float( real_consumption_age_16_plus ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_consumption_age_16_plus;


   procedure Add_real_gdp_age_16_plus( c : in out d.Criteria; real_gdp_age_16_plus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "real_gdp_age_16_plus", op, join, Long_Float( real_gdp_age_16_plus ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_gdp_age_16_plus;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_year_To_Orderings;


   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rec_type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type_To_Orderings;


   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "variant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant_To_Orderings;


   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_To_Orderings;


   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition_To_Orderings;


   procedure Add_employment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "employment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_employment_To_Orderings;


   procedure Add_employment_rate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "employment_rate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_employment_rate_To_Orderings;


   procedure Add_employees_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "employees", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_employees_To_Orderings;


   procedure Add_ilo_unemployment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ilo_unemployment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ilo_unemployment_To_Orderings;


   procedure Add_ilo_unemployment_rate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ilo_unemployment_rate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ilo_unemployment_rate_To_Orderings;


   procedure Add_participation_rate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "participation_rate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_participation_rate_To_Orderings;


   procedure Add_claimant_count_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claimant_count", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claimant_count_To_Orderings;


   procedure Add_average_hours_worked_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "average_hours_worked", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_hours_worked_To_Orderings;


   procedure Add_total_hours_worked_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "total_hours_worked", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_total_hours_worked_To_Orderings;


   procedure Add_labour_share_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "labour_share", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_labour_share_To_Orderings;


   procedure Add_compensation_of_employees_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "compensation_of_employees", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_compensation_of_employees_To_Orderings;


   procedure Add_wages_and_salaries_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wages_and_salaries", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wages_and_salaries_To_Orderings;


   procedure Add_employers_social_contributions_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "employers_social_contributions", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_employers_social_contributions_To_Orderings;


   procedure Add_mixed_income_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mixed_income", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mixed_income_To_Orderings;


   procedure Add_average_earnings_growth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "average_earnings_growth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_earnings_growth_To_Orderings;


   procedure Add_average_earnings_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "average_earnings_index", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_earnings_index_To_Orderings;


   procedure Add_average_hourly_earnings_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "average_hourly_earnings_index", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_average_hourly_earnings_index_To_Orderings;


   procedure Add_productivity_per_hour_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "productivity_per_hour_index", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_productivity_per_hour_index_To_Orderings;


   procedure Add_productivity_per_worker_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "productivity_per_worker_index", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_productivity_per_worker_index_To_Orderings;


   procedure Add_real_product_wage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_product_wage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_product_wage_To_Orderings;


   procedure Add_real_consumption_wage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_consumption_wage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_consumption_wage_To_Orderings;


   procedure Add_rpi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rpi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rpi_To_Orderings;


   procedure Add_rpix_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rpix", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rpix_To_Orderings;


   procedure Add_cpi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cpi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cpi_To_Orderings;


   procedure Add_producer_output_prices_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "producer_output_prices", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_producer_output_prices_To_Orderings;


   procedure Add_mortgage_interest_payments_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortgage_interest_payments", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortgage_interest_payments_To_Orderings;


   procedure Add_actual_rents_for_housing_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "actual_rents_for_housing", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_actual_rents_for_housing_To_Orderings;


   procedure Add_consumer_expenditure_deflator_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "consumer_expenditure_deflator", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_consumer_expenditure_deflator_To_Orderings;


   procedure Add_house_price_index_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "house_price_index", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_house_price_index_To_Orderings;


   procedure Add_gdp_deflator_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gdp_deflator", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gdp_deflator_To_Orderings;


   procedure Add_lfs_employment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lfs_employment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lfs_employment_To_Orderings;


   procedure Add_real_household_disposable_income_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_household_disposable_income", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_household_disposable_income_To_Orderings;


   procedure Add_real_consumption_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_consumption", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_consumption_To_Orderings;


   procedure Add_real_gdp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_gdp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_gdp_To_Orderings;


   procedure Add_lfs_employment_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lfs_employment_age_16_plus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lfs_employment_age_16_plus_To_Orderings;


   procedure Add_real_household_disposable_income_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_household_disposable_income_age_16_plus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_household_disposable_income_age_16_plus_To_Orderings;


   procedure Add_real_consumption_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_consumption_age_16_plus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_consumption_age_16_plus_To_Orderings;


   procedure Add_real_gdp_age_16_plus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "real_gdp_age_16_plus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_real_gdp_age_16_plus_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Macro_Forecasts_IO;
