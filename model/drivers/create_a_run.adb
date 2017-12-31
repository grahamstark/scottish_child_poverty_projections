--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Exceptions;
with Ada.Command_Line;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with SCP_Types;
with Text_Utils;
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Base_Model_Types;
with UKDS.Target_Data;
with Weighting_Commons;
with UKDS.Target_Data.Run_IO;

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
   
   procedure Create_Targets_201001 is
      the_run : Run;
      timestr : constant String := Formatting.Image( Clock );
      targets_run_id : Positive := 100_120;
      target_populations : array( 1 .. 15 ) of Unbounded_String := (      
         1 => ppp, -- principal projection
         2 => hhh, -- high population variant
         3 => hpp, -- high fertility variant
         4 => lll, -- low population variant
         5 => lpp, -- low fertility variant
         6 => php, -- high life expectancy variant
         7 => pjp, -- moderately high life expectancy variant
         8 => pkp, -- moderately low life expectancy variant
         9 => plp, -- low life expectancy variant
         10 => pph, -- high migration variant
         11 => ppl, -- low migration variant
         12 => ppq, -- 0% future EU migration variant (not National Statistics)
         13 => ppr, -- 50% future EU migration variant (not National Statistics)
         14 => pps, -- 150% future EU migration variant (not National Statistics)
         15 => ppz ); -- zero net migration variant (natural change only)      
   begin

      for pop_targ of target_populations loop
         the_run.run_id := targets_run_id;
         the_run.user_id := 1;
         the_run.description := 
            TuS( "Scottish Targetset using FCS Macro and 2016 edition population forecasts; variant" & TS( pop_targ ) & " created at: " & timestr );
         the_run.start_year := 2016;
         the_run.end_year := 2040;
         the_run.macro_edition := 2017;
         the_run.households_edition := 2014;
         the_run.population_edition := 2016;
         the_run.country := SCO;
         the_run.households_variant := PPP; -- this is ignored and set automatically
         the_run.population_variant := pop_targ;
         the_run.macro_variant := BASELINE;
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
         Inc( targets_run_id );
      end loop;
   end Create_Targets_201001;

   
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
   Create_201001;   
end Create_A_Run;