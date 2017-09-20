with UKDS.Target_Data;
with Weighting_Commons;

package Model.SCP.Weights_Creator is

   use UKDS.Target_Data;
   use Weighting_Commons;
   
   procedure Create_Weights( 
      the_run : Run;
      clauses : Selected_Clauses_Array;
      error   : out Eval_Error_Type );

end  Model.SCP.Weights_Creator;