with UKDS.Target_Data;
with Weighting_Commons;
with SCP_Types;

package Model.SCP.Weights_Creator is

   use UKDS.Target_Data;
   use Weighting_Commons;
   use SCP_Types;
   
   procedure Create_Weights( 
      the_run : Run;
      clauses : Selected_Clauses_Array;
      error   : out Eval_Error_Type );

end  Model.SCP.Weights_Creator;