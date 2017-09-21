with Ada.Calendar;
with Base_Model_Types;

package SCP_Types is

   use Ada.Calendar;
   use  Base_Model_Types;
   
   type Weighting_Sample_Type is ( uk, scotland );
   
   type Type_Of_Run is ( data_generation, target_generation, weights_generation, validation );
   
   type Candidate_Clauses is (
      genders,
      household_type,
      by_year_ages,
      by_year_ages_by_gender,
      aggregate_ages,
      aggregate_ages_by_gender,
      employment,
      employees,
      ilo_unemployment,
      jsa_claimants
   );
   
   type Abs_Selected_Clauses_Array is array( Candidate_Clauses range <> ) of Boolean;
   subtype Selected_Clauses_Array is Abs_Selected_Clauses_Array( Candidate_Clauses'Range ); 
   

   type Weights_Index is record
      year : Year_Number;
      id   : Sernum_Value;
   end record;
   

   
end SCP_Types;