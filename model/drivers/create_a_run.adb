--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Exceptions;
with Ada.Command_Line;
with Ada.Text_IO;
with SCP_Types;
with Text_Utils;
with Ada.Calendar;
with Ada.Calendar.Formatting;

with UKDS.Target_Data;
with Weighting_Commons;
with UKDS.Target_Data.Run_IO;

procedure Create_A_Run is
   
   use SCP_Types;
   use UKDS.Target_Data;
   use Ada.Calendar;
   use Text_Utils;
   use Weighting_Commons;
   
   procedure Create_201000 is
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
   begin
      the_run.run_id := 201000;
      the_run.user_id := 1;
      the_run.description := 
         TuS( "Attempt to emulate IFS Weights (From Create_A_Run.adb); created at " & timestr );
      the_run.start_year := 2014;
      the_run.end_year := 2021;
      the_run.macro_edition := 2017;
      the_run.households_edition := 2014;
      the_run.population_edition := 2014;
      the_run.country := UK;
      the_run.households_variant := PPP;
      the_run.population_variant := PPP;
      the_run.macro_variant := BASELINE;
      the_run.run_type := weights_generation;
      the_run.weighting_function := constrained_chi_square;
      the_run.weighting_lower_bound := 0.1;
      the_run.weighting_upper_bound := 4.0;
      the_run.targets_run_id := 100128;
      the_run.targets_run_user_id := 1;
      the_run.data_run_id := 999998;
      the_run.data_run_user_id := 1;
      the_run.selected_clauses := (
         household_type           => True,
         aggregate_ages_by_gender => True,
         employment_by_sector     => True,
         participation_rate       => True,
         others                   => False );
      the_run.data_start_year := 2012;
      the_run.data_end_year := 2015;
      the_run.uk_wide_only := True;
      Run_IO.Save( the_run );
   end Create_201000;
   
begin
   Create_201000;   
end Create_A_Run;