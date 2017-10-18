with Ada.Calendar;
with Base_Model_Types;
with Ada.Strings.Unbounded;

package SCP_Types is

   use Ada.Calendar;
   use Base_Model_Types;
   use Ada.Strings.Unbounded;
   
   type Countries is (
      SCO_C,
      ENG_C,
      WAL_C,
      NIR_C,
      UK_C );
      
   function Image( c : Countries ) return Unbounded_String; 
   
   SCO : constant Unbounded_String := To_Unbounded_String( "SCO" );
   ENG : constant Unbounded_String := To_Unbounded_String( "ENG" );
   WAL : constant Unbounded_String := To_Unbounded_String( "WAL" );
   NIR : constant Unbounded_String := To_Unbounded_String( "NIR" );
   UK  : constant Unbounded_String := To_Unbounded_String( "UK" );
   
   PERSONS       : constant Unbounded_String := To_Unbounded_String( "persons" );
   HOUSEHOLDS    : constant Unbounded_String := To_Unbounded_String( "households" );
   MACRO         : constant Unbounded_String := To_Unbounded_String( "macro" );
   PARTICIPATION : constant Unbounded_String := To_Unbounded_String( "participation" );
   -- type Weighting_Sample_Type is ( uk, scotland );
   
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
      jsa_claimants,
      participation_rate
   );
   
   type Abs_Selected_Clauses_Array is array( Candidate_Clauses range <> ) of Boolean;
   subtype Selected_Clauses_Array is Abs_Selected_Clauses_Array( Candidate_Clauses'Range ); 
   

   type Weights_Index is record
      year   : Year_Number;
      sernum : Sernum_Value;
   end record;
   

   
end SCP_Types;