--
-- this stuff is just to force compilation - borrowed from auto test case.
--

with Model.SCP.FRS_Creator;
with Model.SCP.Target_Creator;

with Ada.Calendar;
with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Text_Utils;

with UKDS.Target_Data;
with UKDS.Target_Data.Run_IO;
with Ada.Text_IO;

procedure Basic_SCP_Driver is
   
   use Ada.Exceptions;
   use Ada.Text_IO;
   use Ada.Calendar;
   use Text_Utils;
   CREATE_FRS     : constant Boolean := False;
   CREATE_TARGETS : constant Boolean := True;
   
   startTime    : Time;
   endTime      : Time;
   elapsed      : Duration;
   the_run      : UKDS.Target_Data.Run;
begin
   startTime := Clock;
   Put_Line( "We're making a start on this.." );
   if CREATE_FRS then
      the_run.start_year := 2008;
      the_run.end_year := 2015;
      the_run.run_id := 999_998;
      the_run.user_id := 1;
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.FRS_Creator.Create_Dataset( the_run );
   elsif CREATE_TARGETS then
      the_run.start_year := 2015;
      the_run.end_year := 2039;
      the_run.run_id := 100_000;
      the_run.user_id := 1;
      the_run.households_source := TuS( "ppp" );
      the_run.households_edition := 2014;
      the_run.population_source := TuS( "ppp" );
      the_run.population_edition := 2014;
      the_run.macro_source := TuS( "baseline" );
      the_run.macro_edition := 2017;
      the_run.country := TuS( "UK" );      
      UKDS.Target_Data.Run_IO.Save( the_run );
      Model.SCP.FRS_Creator.Create_Dataset( the_run );      
   end if;
   endTime := Clock;
   elapsed := endTime - startTime;
   Put_Line( "Time Taken " & elapsed'Img & " secs" );
end Basic_SCP_Driver;