--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Calendar.Formatting;
with Ada.Calendar;
with Ada.Command_Line;
with Ada.Exceptions;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with Base_Model_Types;
with SCP_Types;
with Text_Utils;
with UKDS.Target_Data.Run_IO;
with UKDS.Target_Data;
with Weighting_Commons;
with Model.SCP.Target_Creator;

procedure Create_A_Run is
   
   use SCP_Types;
   use UKDS.Target_Data;
   use Ada.Calendar;
   use Text_Utils;
   use Base_Model_Types;
   use Weighting_Commons;
   use Ada.Strings.Unbounded;
   
   procedure Create_201000 is
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
   begin
      the_run.run_id := 201_000;
      the_run.user_id := 1;
      the_run.description := 
         TuS( "Attempt to emulate IFS Weights (From Create_A_Run.adb); created at " & timestr );
      the_run.start_year := 2016;
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

      procedure Create_Targets_100_140_to_100_148 is
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
      targets_run_id : Positive := 100_140;
      target_populations : array( 1 .. 9 ) of Unbounded_String := (      
         1 => ppp, -- principal projection
         2 => hhh, -- high population variant
         3 => hpp, -- high fertility variant
         4 => lpp, -- low fertility variant
         5 => php, -- high life expectancy variant
         6 => plp, -- low life expectancy variant
         7 => pph, -- high migration variant
         8 => ppl, -- low migration variant
         9 => ppz ); -- zero net migration variant (natural change only)      
   begin

      for pop_targ of target_populations loop
         the_run.run_id := targets_run_id;
         the_run.user_id := 1;
         the_run.description := 
            TuS( "UK Targetset using OBR November Macro and 2016 edition population forecasts; variant: '" & TS( pop_targ ) & "' created at: " & timestr );
         the_run.start_year := 2016;
         the_run.end_year := 2038; -- last hhld and 2014 ppn forecast year -1 since we're using financial
         the_run.macro_edition := 2017;
         the_run.households_edition := 2014;
         the_run.population_edition := 2016;
         the_run.country := UK;
         the_run.households_variant := PPP; -- this is ignored and set automatically
         the_run.population_variant := pop_targ;
         the_run.macro_variant := BASELINE; -- pro-tem this is hard-wor
         the_run.run_type := target_generation;
         the_run.targets_run_id := targets_run_id;
         the_run.targets_run_user_id := 1;
         the_run.data_run_id := 999998;
         the_run.data_run_user_id := 1;
         Run_IO.Save( the_run );
         Inc( targets_run_id );
      end loop;
   end Create_Targets_100_140_to_100_148;

   
   
   --
   -- These are the main Scottish ones using 2016 popns and the SFC forecasts
   --
   procedure Create_Targets_100_120_to_100_132 is
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
      targets_run_id : Positive := 100_120;
      target_populations : array( 1 .. 13 ) of Unbounded_String := (      
         1 => ppp, -- principal projection
         2 => hhh, -- high population variant
         3 => hpp, -- high fertility variant
         4 => lll, -- low population variant
         5 => lpp, -- low fertility variant
         6 => php, -- high life expectancy variant
         -- 7 => pjp, -- moderately high life expectancy variant (not in 2014)
         -- 8 => pkp, -- moderately low life expectancy variant (not in 2014)
         7 => plp, -- low life expectancy variant
         8 => pph, -- high migration variant
         9 => ppl, -- low migration variant
         10 => ppq, -- 0% future EU migration variant (not National Statistics)
         11 => ppr, -- 50% future EU migration variant (not National Statistics)
         12 => pps, -- 150% future EU migration variant (not National Statistics)
         13 => ppz ); -- zero net migration variant (natural change only)      
   begin

      for pop_targ of target_populations loop
         the_run.run_id := targets_run_id;
         the_run.user_id := 1;
         the_run.description := 
            TuS( "Scottish Targetset using FCS Macro and 2016 edition population forecasts; variant: '" & TS( pop_targ ) & "' created at: " & timestr );
         the_run.start_year := 2016;
         the_run.end_year := 2038; -- last hhld and 2014 ppn forecast year -1 since we're using financial
         the_run.macro_edition := 2017;
         the_run.households_edition := 2014;
         the_run.population_edition := 2016;
         the_run.country := SCO;
         the_run.households_variant := PPP; -- this is ignored and set automatically
         the_run.population_variant := pop_targ;
         the_run.macro_variant := BASELINE; -- pro-tem this is hard-wor
         the_run.run_type := target_generation;
         -- the_run.weighting_function := constrained_chi_square;
         -- the_run.weighting_lower_bound := 0.1;
         -- the_run.weighting_upper_bound := 4.0;
         the_run.targets_run_id := targets_run_id;
         the_run.targets_run_user_id := 1;
         the_run.data_run_id := 999998;
         the_run.data_run_user_id := 1;
         -- the_run.selected_clauses := (
            -- compressed_household_type => True,
            -- aggregate_ages_by_gender  => True,
            -- employment_by_sector      => True,
            -- participation_rate        => True,
            -- others                    => False );
         -- the_run.data_start_year := 2015;
         -- the_run.data_end_year := 2015;
         -- the_run.uk_wide_only := True;
         Run_IO.Save( the_run );
         -- Model.SCP.Target_Creator.Create_Dataset( the_run );
         Inc( targets_run_id );
      end loop;
   end Create_Targets_100_120_to_100_132;

   procedure Create_Weights_200_120_to_200_132 is
      targets_run_id : Positive := 100_120;
      run_id         : Positive := 200_120;
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
   begin
      for r in 0 .. 12 loop
         the_run.run_id := run_id;
         the_run.user_id := 1;
         the_run.description := 
            TuS( "Scottish weights using FCS Macro and 2016 edition population forecasts; variant: '" & targets_run_id'Img & "' created at: " & timestr );
         the_run.start_year := 2016;
         the_run.end_year := 2038;
         the_run.run_type := weights_generation;
         the_run.weighting_function := constrained_chi_square;
         the_run.weighting_lower_bound := 0.1;
         the_run.weighting_upper_bound := 4.0;
         the_run.targets_run_id := targets_run_id;
         the_run.targets_run_user_id := 1;
         the_run.data_run_id := 999998;
         the_run.data_run_user_id := 1;
         the_run.country := SCO;
         the_run.selected_clauses := (
            household_type            => True,
            aggregate_ages_by_gender  => True,
            single_participation_rate => False,
            employees                 => True,
            employment                => True,
            ilo_unemployment          => True,
            others                    => False );
         the_run.data_start_year := 2012;
         the_run.data_end_year := 2015;
         Run_IO.Save( the_run );
         Inc( targets_run_id );
         Inc( run_id );
      end loop;
   end Create_Weights_200_120_to_200_132;     
   
   procedure Create_201001 is
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
   begin
      the_run.run_id := 201_001;
      the_run.user_id := 1;
      the_run.description := 
         TuS( "Attempt to emulate IFS Weights (From Create_A_Run.adb); created at " & timestr );
      the_run.start_year := 2016;
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
         compressed_household_type => True,
         aggregate_ages_by_gender  => True,
         employment_by_sector      => True,
         participation_rate        => True,
         others                    => False );
      the_run.data_start_year := 2015;
      the_run.data_end_year := 2015;
      the_run.uk_wide_only := True;
      Run_IO.Save( the_run );
   end Create_201001;
  
begin
   -- Create_201001;
   -- Create_Targets_100_120_to_100_132;
   -- Create_Weights_200_120_to_200_132;
   Create_Targets_100_140_to_100_148;
end Create_A_Run;