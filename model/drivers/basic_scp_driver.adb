--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Exceptions;
with Ada.Command_Line;
with Ada.Text_IO;
with SCP_Types;
with GNAT.Command_Line; 
with GNATColl.Traces;
with Text_Utils;

with UKDS.Target_Data;
with UKDS.Target_Data.Run_IO;

with Model.SCP.FRS_Creator;
with Model.SCP.Target_Creator;
with Model.SCP.Weights_Creator;


procedure Basic_SCP_Driver is
   
   use Ada.Text_IO;
   use Ada.Calendar;
   use SCP_Types;
   use UKDS;
   use Text_Utils;
   use Target_Data;
   use GNAT.Command_Line;
   
   HELP_MESSAGE : constant String := 
      "-r : run id " & LINE_BREAK &
      " note: create run with scripts/create_runs.rb ";
   

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "BASIC_SCP_DRIVER" );
   
   
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   run_id     : Integer;
   start_time : Time := Clock;
   end_time   : Time;
   elapsed    : Duration;
   the_run    : UKDS.Target_Data.Run;
   error      : Model.Maths_Funcs.Eval_Error_Type;  
begin
   
   loop
      case Getopt ("r: h") is
         when ASCII.NUL => exit;
         when 'h' =>
            Put_Line( HELP_MESSAGE );
            return;
         when 'r' =>
            run_id  := Positive'Value( Parameter );
         when others =>
            raise Program_Error;  
         end case;
   end loop;
   Put_Line( "Starting on run id " & the_run.run_id'Img & " type " & the_run.run_type'Img );
   GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   the_run := Run_IO.Retrieve_By_PK( 1, run_id );
   if the_run = Null_Run then
      Put_Line( "run " & run_id'Img & " hasn't been created; " & HELP_MESSAGE ); 
      return;
   end if;
   case the_run.run_type is
      when data_generation =>
         Model.SCP.FRS_Creator.Create_Dataset( the_run );
      when target_generation =>
         Model.SCP.Target_Creator.Create_Dataset( the_run );
      when weights_generation =>
         Model.SCP.Weights_Creator.Create_Weights( the_run, error );
         Put_Line( "error is " & error'Img );
      when validation => null;
   end case;
   end_time := Clock;
   elapsed := end_time - start_time;
   Put_Line( "finished in " & Formatting.Image( elapsed ) & " secs " );
   
end Basic_SCP_Driver;