--
-- Created by Ada Mill (https://github.com/grahamstark/ada_mill)
-- 
with Ada.Containers.Vectors;
--
-- FIXME: may not be needed
--
with Ada.Calendar;

with Base_Types; use Base_Types;

with Ada.Strings.Unbounded;
with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;
with SCP_Types;
with Weighting_Commons;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds is

   use Ada.Strings.Unbounded;
   
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;
   use SCP_Types;
   use Weighting_Commons;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===


   package Data_Changes_Array_Package is new Float_Mapper( Index=> Candidate_Clauses, Data_Type=>AMOUNT, Array_Type=> Abs_Data_Changes_Array );
   package Data_Ops_Array_Package is new Discrete_Mapper( Index=> Candidate_Clauses, Data_Type=>S_Operation_Type, Array_Type=> Abs_Data_Ops_Array );
   package Selected_Clauses_Array_Package is new Boolean_Mapper( Index=> Candidate_Clauses, Array_Type=> Abs_Selected_Clauses_Array );



        
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds;
