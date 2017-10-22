--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Calendar;
with Ada.Exceptions;
with Ada.Command_Line;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with GNAT.Command_Line; 
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
   
   HELP_MESSAGE : constant String := 
      "-d : dataset id " & LINE_BREAK &
      "-v : data variant " & LINE_BREAK &
      "     1 = full" & LINE_BREAK &
      "     2 = 1:3 subsample; (default 2)" & LINE_BREAK &
      "-f : Population forecast ID " & LINE_BREAK &
      "-p : population_weighting = " & LINE_BREAK &     
      "     none" & LINE_BREAK &                        
      "     compressed_population" & LINE_BREAK &       
      "     full_population" & LINE_BREAK &             
      "     popn_plus_others_compressed [DEFAULT]" & LINE_BREAK & 
      "     popn_plus_others_full" & LINE_BREAK;
   

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
     -- case Getopt ("d: v: f: p: h") is
      -- when ASCII.NUL => exit;
      -- when 'h' =>
         -- Put_Line( HELP_MESSAGE );
         -- return;
      -- when 'd' =>
            -- the_run.base_dataset_run_id := Positive'Value( Parameter );
      -- when 'v' =>
            -- the_run.base_dataset_variant := Positive'Value( Parameter );
      -- when 'f' =>
            -- the_run.population_forecast := Positive'Value( Parameter );
      -- when 'p' =>
            -- the_run.population_weighting := Population_Weighting_Level'Value( Parameter );
      -- when others =>
         -- raise Program_Error;  
      -- end case;
   -- end loop;  
   
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
      the_run.run_id := 999_997;
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.FRS_Creator.Create_Dataset( the_run );
   when target_generation =>
      the_run.start_year := 2014;
      the_run.end_year := 2037;
      the_run.run_id := 100_004;
      
      the_run.households_variant := TuS( "ppp" );
      the_run.households_edition := 2014;
      the_run.population_variant := TuS( "ppp" );
      the_run.population_edition := 2014;
      the_run.macro_variant := TuS( "baseline" );
      the_run.macro_edition := 2017;
      the_run.country := TuS( "SCO" );      
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.Target_Creator.Create_Dataset( the_run );
      
   when weights_generation =>
      the_run.start_year := 2014;
      the_run.end_year := 2037;
      the_run.run_id := 200_004;

      the_run.weighting_function := constrained_chi_square;
      the_run.weighting_lower_bound := 0.1;
      the_run.weighting_upper_bound := 3.0;
      the_run.targets_run_id := 100_004;      
      the_run.targets_run_user_id := 1;
      the_run.data_run_id := 999_997;
      the_run.data_run_user_id := 1;
      the_run.data_start_year := 2012;
      the_run.data_end_year := 2015;
      the_run.selected_clauses := ( 
            genders                  => False,
            household_type           => True,
            by_year_ages             => False,
            by_year_ages_by_gender   => False,
            aggregate_ages           => False,
            aggregate_ages_by_gender => True,
            employment               => False,
            employees                => False,
            ilo_unemployment         => False,
            jsa_claimants            => False,
            participation_rate       => True );
      the_run.country := UK;
      for i in 1 .. 1 loop
         Log( "Starting Run with ID " & the_run.run_id'Img & " targets " & the_run.targets_run_id'Img );
         UKDS.Target_Data.Run_IO.Save( the_run );
         Model.SCP.Weights_Creator.Create_Weights( the_run, error );
         the_run.data_run_id := the_run.data_run_id + 1;
         the_run.targets_run_id := the_run.targets_run_id + 1;
      end loop;
      Log( "returned with err " & error'Img );
   when validation =>
      
      UKDS.Target_Data.Run_IO.Save( the_run );
   end case;
   endTime := Clock;
   elapsed := endTime - startTime;
   Put_Line( "Time Taken " & elapsed'Img & " secs" );
end Basic_SCP_Driver;