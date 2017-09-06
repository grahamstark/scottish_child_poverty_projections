--
-- Created by ada_generator.py on 2017-09-06 17:20:42.612809
-- 
with AUnit.Test_Suites; use AUnit.Test_Suites;

with Ukds_Test;

function Suite return Access_Test_Suite is
        result : Access_Test_Suite := new Test_Suite;
begin
        Add_Test( result, new Ukds_Test.Test_Case ); -- Adrs_Data_Ada_Tests.Test_Case
        return result;
end Suite;
