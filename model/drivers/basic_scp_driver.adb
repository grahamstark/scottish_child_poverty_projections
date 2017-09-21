--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with GNATColl.Traces;

with Text_Utils;
with Weighting_Commons;

with UKDS.Target_Data;
with UKDS.Target_Data.Run_IO;

with SCP_Types;
with Model;

with Model.SCP.FRS_Creator;
with Model.SCP.Target_Creator;
with Model.SCP.Weights_Creator;


procedure Basic_SCP_Driver is
   
   use Ada.Exceptions;
   use Ada.Text_IO;
   use Ada.Calendar;
   use Text_Utils;
   use SCP_Types;
   use Weighting_Commons;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "BASIC_SCP_DRIVER" );
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
   startTime    : Time;
   endTime      : Time;
   elapsed      : Duration;
   the_run      : UKDS.Target_Data.Run;
   run_type     : constant Type_Of_Run := weights_generation;
   error        : Model.Maths_Funcs.Eval_Error_Type;
begin
   startTime := Clock;
   GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   the_run.run_type := run_type;
   the_run.user_id := 1;
   Put_Line( "We're making a start on this.." );
   Log( "type of run is " & run_type'Img );
   case run_type is
   when data_generation =>      
      the_run.start_year := 2008;
      the_run.end_year := 2015;
      the_run.run_id := 999_998;
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.FRS_Creator.Create_Dataset( the_run );
   when target_generation =>
      the_run.start_year := 2014;
      the_run.end_year := 2021;
      the_run.run_id := 100_002;
      
      the_run.households_variant := TuS( "pph" );
      the_run.households_edition := 2014;
      the_run.population_variant := TuS( "pph" );
      the_run.population_edition := 2014;
      the_run.macro_variant := TuS( "baseline" );
      the_run.macro_edition := 2017;
      the_run.country := TuS( "SCO" );      
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.Target_Creator.Create_Dataset( the_run );
   when weights_generation =>
      the_run.start_year := 2014;
      the_run.end_year := 2021;
      the_run.run_id := 200_000;

      the_run.weighting_function := constrained_chi_square;
      the_run.weighting_lower_bound := 0.2;
      the_run.weighting_upper_bound := 2.0;
      the_run.targets_run_id := 100_000;      
      the_run.targets_run_user_id := 1;
      the_run.data_run_id := 999_998;
      the_run.data_run_user_id := 1;
      the_run.selected_clauses := ( 
            genders                  => True,
            household_type           => True,
            by_year_ages             => False,
            by_year_ages_by_gender   => False,
            aggregate_ages           => True,
            aggregate_ages_by_gender => False,
            employment               => True,
            employees                => True,
            ilo_unemployment         => True,
            jsa_claimants            => True );
      the_run.country := TuS( "SCO" );
      
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.Weights_Creator.Create_Weights( the_run, error );
      Log( "returned with err " & error'Img );
   when validation =>
      
      UKDS.Target_Data.Run_IO.Save( the_run );
   end case;
   endTime := Clock;
   elapsed := endTime - startTime;
   Put_Line( "Time Taken " & elapsed'Img & " secs" );
end Basic_SCP_Driver;