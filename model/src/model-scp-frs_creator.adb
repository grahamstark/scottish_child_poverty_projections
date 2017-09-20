with Ada.Calendar;
with Ada.Exceptions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with Data_Constants;
with Base_Model_Types;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Macro_Forecasts_IO;
with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.Target_Data_IO;

with Ukds.Frs.Househol_IO;
with Ukds.Frs.Benunit_IO;
with Ukds.Frs.Adult_IO;
with Ukds.Frs.Child_IO;
with DB_Commons;

with Connection_Pool;


package body Model.SCP.FRS_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use UKDS.FRS;
   use UKDS.Target_Data;
   use Ada.Text_IO;
   use Ada.Calendar;
   use GNATCOLL.SQL.Exec;
   package d renames DB_Commons;
   package frsh_io renames Househol_IO;

   
   
   procedure Create_Dataset( the_run : Run ) is
      startTime    : Time;
      endTime      : Time;
      elapsed      : Duration;
      cursor       : GNATCOLL.SQL.Exec.Forward_Cursor;
      household_r  : Househol;
      ps           : GNATCOLL.SQL.Exec.Prepared_Statement;   
      conn         : Database_Connection;
      count        : Natural := 0;
      frs_criteria : d.Criteria;
   begin
      startTime := Clock;
      Put_Line( "We're making a start on this.." );
      Connection_Pool.Initialise;
      conn := Connection_Pool.Lease;
      Househol_IO.Add_User_Id( frs_criteria, run.user_id );
      Househol_IO.Add_Edition( frs_criteria, 1 );
      Househol_IO.Add_Year( frs_criteria, run.start_year, d.GE );
      Househol_IO.Add_Year( frs_criteria, run.end_year, d.LE );
      Househol_IO.Add_Year_To_Orderings( frs_criteria, d.Asc );
      Househol_IO.Add_Sernum_To_Orderings( frs_criteria, d.Asc );
      ps := Househol_IO.Get_Prepared_Retrieve_Statement( frs_criteria );  
      cursor.Fetch( conn, ps ); -- "select * from frs.househol where year >= 2011 order by year,sernum" );
      while Has_Row( cursor ) loop 
         household_r := Househol_IO.Map_From_Cursor( cursor );
         declare
            hh_crit : d.Criteria;
            targets : Target_Data; 
         begin         
            Househol_IO.Add_User_Id( hh_crit, household_r.user_id );
            Househol_IO.Add_Edition( hh_crit, household_r.edition );
            Househol_IO.Add_Year( hh_crit, household_r.year );
            Househol_IO.Add_Sernum( hh_crit, household_r.sernum );
            Adult_IO.Add_Person_To_Orderings( hh_crit, d.Asc );
            Put_Line( d.To_String( hh_crit ));
            Put_Line( "on year " & household_r.year'Img & " sernum " & household_r.sernum'Img );
            declare
               adult_l : FRS.Adult_List := Adult_IO.Retrieve( hh_crit );
               child_l : FRS.Child_List := Child_IO.Retrieve( hh_crit );
            begin
               Put_Line( "num adults " & adult_l.Length'Img );
               Put_Line( "num children " & child_l.Length'Img );
            end;
         end;
         count := count + 1;
         Next( cursor );
      end loop;
      endTime := Clock;
      elapsed := endTime - startTime;
      Put_Line( "Time Taken " & elapsed'Img & " secs " & count'Img & " hhlds " );
   end Create_Dataset;

end  Model.SCP.FRS_Creator;