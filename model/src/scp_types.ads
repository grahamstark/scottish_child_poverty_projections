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
      
   type Genders_Type is ( male, female );   
      
   function Image( c : Countries ) return Unbounded_String; 
   
   SCO : constant Unbounded_String := To_Unbounded_String( "SCO" );
   ENG : constant Unbounded_String := To_Unbounded_String( "ENG" );
   WAL : constant Unbounded_String := To_Unbounded_String( "WAL" );
   NIR : constant Unbounded_String := To_Unbounded_String( "NIR" );
   UK  : constant Unbounded_String := To_Unbounded_String( "UK" );
   
   Target_Countries : constant array( 1 .. 2 ) of Unbounded_String := ( SCO, UK );
   
   PPP : constant Unbounded_String := To_Unbounded_String( "ppp" ); -- principal projection,
   HPP : constant Unbounded_String := To_Unbounded_String( "hpp" ); -- high fertility variant,
   LPP : constant Unbounded_String := To_Unbounded_String( "lpp" ); -- low fertility variant,
   PHP : constant Unbounded_String := To_Unbounded_String( "php" ); -- high life expectancy variant,  
   PLP : constant Unbounded_String := To_Unbounded_String( "plp" ); -- low life expectancy variant,
   PPH : constant Unbounded_String := To_Unbounded_String( "pph" ); -- high migration variant,
   PPL : constant Unbounded_String := To_Unbounded_String( "ppl" ); -- low migration variant,
   PJP : constant Unbounded_String := To_Unbounded_String( "pjp" ); -- moderately high life expectancy variant,
   PKP : constant Unbounded_String := To_Unbounded_String( "pkp" ); -- moderately low life expectancy variant,
   PPQ : constant Unbounded_String := To_Unbounded_String( "ppq" ); -- 0% future EU migration variant (not National Statistics),
   PPR : constant Unbounded_String := To_Unbounded_String( "ppr" ); -- 50% future EU migration variant (not National Statistics),
   PPS : constant Unbounded_String := To_Unbounded_String( "pps" ); -- 150% future EU migration variant (not National Statistics),
   HHH : constant Unbounded_String := To_Unbounded_String( "hhh" ); -- high population variant,
   LLL : constant Unbounded_String := To_Unbounded_String( "lll" ); -- low population variant,
   PPZ : constant Unbounded_String := To_Unbounded_String( "ppz" ); -- zero net migration (natural change only) variant,
   HLH : constant Unbounded_String := To_Unbounded_String( "hlh" ); -- young age structure variant,
   LHL : constant Unbounded_String := To_Unbounded_String( "lhl" ); -- old age structure variant,
   RPP : constant Unbounded_String := To_Unbounded_String( "rpp" ); -- replacement fertility variant,
   CPP : constant Unbounded_String := To_Unbounded_String( "cpp" ); -- constant fertility variant,
   PNP : constant Unbounded_String := To_Unbounded_String( "pnp" ); -- no mortality improvement variant,
   CNP : constant Unbounded_String := To_Unbounded_String( "cnp" ); -- no change variant,
   PPB : constant Unbounded_String := To_Unbounded_String( "ppb" ); -- long term balanced net migration variant
   
   Variants : constant array( 1 .. 22 ) of Unbounded_String := ( 
      PPP , HPP , LPP , PHP , PLP , PPH , PPL , PJP , PKP , PPQ , PPR , PPS , 
      HHH , LLL , PPZ , HLH , LHL , RPP , CPP , PNP , CNP , PPB ); 
   
   -- zero net migration (natural change only) variant
       
   BASELINE : constant Unbounded_String := To_Unbounded_String( "baseline" );
   
   function Country_From_Country( s : Unbounded_String ) return Countries; -- amazingly stupid design
   
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
      participation_rate,
      employment_by_sector,
      compressed_household_type,
      spare_type
   );
   
   type Abs_Selected_Clauses_Array is array( Candidate_Clauses range <> ) of Boolean;
   subtype Selected_Clauses_Array is Abs_Selected_Clauses_Array( Candidate_Clauses'Range ); 

   type Weights_Index is record
      year   : Year_Number;
      sernum : Sernum_Value;
   end record;
   
end SCP_Types;