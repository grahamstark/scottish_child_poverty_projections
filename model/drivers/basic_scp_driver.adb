--
-- this stuff is just to force compilation - borrowed from auto test case.
--

with Model.SCP.FRS_Creator;

with Ada.Calendar;
with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 

with UKDS.Target_Data;
with UKDS.Target_Data.Run_IO;
with Ada.Text_IO;

procedure Basic_SCP_Driver is
   
   use Ada.Exceptions;
   use Ada.Text_IO;
   use Ada.Calendar;
   startTime    : Time;
   endTime      : Time;
   elapsed      : Duration;
   the_run      : UKDS.Target_Data.Run;
begin
   startTime := Clock;
   Put_Line( "We're making a start on this.." );
   
   the_run.start_year := 2008;
   the_run.end_year := 2015;
   the_run.run_id := 999_999;
   the_run.user_id := 1;
   UKDS.Target_Data.Run_IO.Save( the_run );
   Model.SCP.FRS_Creator.Create_Dataset( the_run );
   
   endTime := Clock;
   elapsed := endTime - startTime;
   Put_Line( "Time Taken " & elapsed'Img & " secs" );
end Basic_SCP_Driver;