with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;
with Weighting_Commons;
with Data_Constants;
with Base_Model_Types;
with Text_Utils;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Macro_Forecasts_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.Target_Dataset_IO;

with DB_Commons;

with Connection_Pool;


package body Model.SCP.Weights_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use Text_Utils;   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   use Ada.Strings.Unbounded;
   use GNATCOLL.SQL.Exec;
   
   package d renames DB_Commons;
   
   function Col_Count( 
      clauses : Selected_Clauses_Array ) return Natural is
   begin
      
      return 0;
   end Col_Count;
   
   procedure Fill_One_Row( 
      clauses  : Selected_Clauses_Array;
      targets  : Target_Dataset;
      row      : out Abs_Amount_Array ) is
    begin
      row := ( others => 0.0 );
       
      Assert( for all row as r => r > 0.0, " there is a zero in output row " & To_String( row ));
    end Create_One_Row;
      
   
   procedure Create_Weights( 
      the_run : Run;
      clauses : Selected_Clauses_Array;
      error   : out Eval_Error_Type ) is
   begin
      null;
   end  Create_Weights; 

   
end Model.SCP.Weights_Creator;