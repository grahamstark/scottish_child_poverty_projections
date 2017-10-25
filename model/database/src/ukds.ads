--
-- Created by ada_generator.py on 2017-10-25 13:04:25.669695
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


   package Selected_Clauses_Array_Package is new Boolean_Mapper( Index=> Candidate_Clauses, Array_Type=> Abs_Selected_Clauses_Array );



        
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds;
