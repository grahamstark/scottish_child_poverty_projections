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
with GNAT.Strings;

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
   use GNAT.Strings;
   use GNAT.Command_Line;
   use Ada.Strings.Unbounded;
   
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

      -- cmd_config   : Command_Line_Configuration;
      -- 
      -- start_year : aliased Year_Number := 2014;
      -- end_year   : aliased Year_Number := 2037;
      -- run_id     : aliased Integer := 100_005;
       
      
      --
      -- households_variant : aliased String_Access; -- := new String("ppp")'Access;
      -- households_edition : aliased Integer := 2014;
      -- 
      -- population_variant : aliased String_Access; -- = TuS( "ppp" );
      -- population_edition : aliased Integer := 2014;
      -- macro_variant      : aliased String_Access := TuS( "baseline" );
         -- the_run.macro_edition := 2017;
         -- the_run.country := UK      
         -- Define_Switch( cmd_config, households_variant'Access, Long_Switch=> "Households Projections Variant", Help=>"Households Variant" );
      -- Define_Switch( cmd_config, run_type'Access, Switch=> "Type of Run", Help=>"Type of Run" );
      
      -- loop
        -- case Getopt ("t: -r: -start_year= -end_year=  -popn= -macro= -hh= -country= v: f: p: h") is
         -- when ASCII.NUL => exit;
         -- when 't' =>
            -- run_type := Type_Of_Run'Value( Parameter );
         -- when 'h' =>
            -- Put_Line( HELP_MESSAGE );
            -- return;
         -- when '-' =>
            -- if Full_Switch = "--start " then
               -- null; -- the_run.base_dataset_run_id := Positive'Value( Parameter );
            -- end if;
         -- when others =>
            -- raise Program_Error;  
         -- end case;
      -- end loop;  
      
   procedure Run_One(
      run_id         : Integer;
      run_type       : Type_Of_Run;
      data_run_id    : Integer;
      country        : Unbounded_String;
      targets_run_id : Integer ) is
          
      startTime    : Time;
      endTime      : Time;
      elapsed      : Duration;
      the_run      : UKDS.Target_Data.Run;
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
         the_run.run_id := 999_996;
         UKDS.Target_Data.Run_IO.Save( the_run );
         Model.SCP.FRS_Creator.Create_Dataset( the_run );
      when target_generation =>
         the_run.start_year := 2014;
         the_run.end_year := 2037;
         the_run.run_id := 100_006;
         
         the_run.households_variant := TuS( "ppl" );
         the_run.households_edition := 2014;
         the_run.population_variant := TuS( "ppl" );
         the_run.population_edition := 2014;
         the_run.macro_variant := TuS( "baseline" );
         the_run.macro_edition := 2017;
         the_run.country := SCO;     
         UKDS.Target_Data.Run_IO.Save( the_run );
         Model.SCP.Target_Creator.Create_Dataset( the_run );
         
      when weights_generation =>
         the_run.start_year := 2014;
         the_run.end_year := 2037;
         the_run.run_id := run_id;
   
         the_run.weighting_function := constrained_chi_square;
         the_run.weighting_lower_bound := 0.05;
         the_run.weighting_upper_bound := 4.0;
         the_run.targets_run_id := targets_run_id; -- 100_007;      
         the_run.targets_run_user_id := 1;
         the_run.data_run_id := data_run_id; -- 999_996;
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
         the_run.country := country;
         Log( "Starting Run with ID " & the_run.run_id'Img & " targets " & the_run.targets_run_id'Img );
         UKDS.Target_Data.Run_IO.Save( the_run );
         Model.SCP.Weights_Creator.Create_Weights( the_run, error );
         the_run.data_run_id := the_run.data_run_id + 1;
         the_run.targets_run_id := the_run.targets_run_id + 1;
         Log( "returned with err " & error'Img );
      when validation =>
         -- TODO
         UKDS.Target_Data.Run_IO.Save( the_run );
      end case;
      endTime := Clock;
      elapsed := endTime - startTime;
      Put_Line( "Time Taken " & elapsed'Img & " secs" );
   end Run_One;
   
begin
   Run_One(  
      run_id         => 200_010, 
      run_type       => weights_generation, 
      data_run_id    => 999_996,
      country        => SCO,
      targets_run_id => 100_007 );
end Basic_SCP_Driver;