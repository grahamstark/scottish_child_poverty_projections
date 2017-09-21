package SCP_Types is

   type Weighting_Sample_Type is ( uk, scotland );
   
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
   
   type Selected_Clauses_Array is array( Candidate_Clauses ) of Boolean;
   
end SCP_Types;