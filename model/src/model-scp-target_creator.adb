with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with Data_Constants;
with Base_Model_Types;
with Text_Utils;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Macro_Forecasts_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.Target_Dataset_IO;

with DB_Commons;

with Connection_Pool;


package body Model.SCP.Target_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use Text_Utils;   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   
   use GNATCOLL.SQL.Exec;
   
   package d renames DB_Commons;
   
   procedure Create_Dataset( the_run : Run ) is
      pop_crit : d.Criteria;
      mac_crit : d.Criteria;
      hh_crit : d.Criteria;
   begin
      -- Population_Forecasts_IO.Add_Variant( pop_crit, the_run.people_source ); 
      -- Households_Forecasts_IO.Add_Variant( hh_crit, the_run.household_source );
      -- Macro_Forecasts_IO.Add_Variant( mac_crit, the_run.macro_source );
      for year in the_run.start_year .. the_run.end_year loop
         
         declare
            female_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year => year,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_source,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "FEMALES" )                           
            );
            male_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year => year,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_source,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "MALES" )                           
            );
            households : constant Households_Forecasts := Households_Forecasts_IO.Retrieve_By_PK(
               year => year,
               rec_type => TuS( "households" ),
               variant  => the_run.households_source,
               country  => the_run.country,
               edition  => the_run.households_edition                   
            );
            macro : constant Macro_Forecasts := Macro_Forecasts_IO.Retrieve_By_PK(
               year => year,
               rec_type => TuS( "macro" ),
               variant  => the_run.macro_source,
               country  => the_run.country,
               edition  => the_run.macro_edition                   
            ); 
         begin
            null;
         end;
         -- Population_Forecasts_IO.Add_Year( pop_crit, year ); 
         -- Households_Forecasts_IO.Add_Year( hh_crit, year );
         -- Macro_Forecasts_IO.Add_Year( mac_crit, year );
         -- 
         -- 
         -- 
         -- d.Remove_From_Criteria( mac_crit, "year" );
         -- d.Remove_From_Criteria( pop_crit, "year" );
         -- d.Remove_From_Criteria( hh_crit, "year" );
      end loop;
   end Create_Dataset;

end Model.SCP.Target_Creator;