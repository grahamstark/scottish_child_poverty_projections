with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
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
with Ukds.Target_Data.Target_Dataset_IO;

with DB_Commons;

with Connection_Pool;


package body Model.SCP.Target_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use UKDS.FRS;
   use UKDS.Target_Data;
   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   
   use GNATCOLL.SQL.Exec;
   
   package d renames DB_Commons;
   package frsh_io renames Househol_IO;
   
   procedure Create_Dataset( the_run : Run ) is
   begin
      
      
      
      null;
   end Create_Dataset;

end Model.SCP.Target_Creator;