--
-- Created by ada_generator.py on 2017-09-06 17:20:42.721720
-- 


with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with GNATColl.Traces;

with AUnit.Assertions;             
with AUnit.Test_Cases; 

with Base_Types;
with SCP_Types;
with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Model.SCP.Target_Creator.Tests is
   
   use Base_Types;
   use Ada.Strings.Unbounded;
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;
   use Ada.Text_IO;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS_TEST" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
      -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use AUnit.Test_Cases.Registration;
   
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Calendar;
   use SCP_Types;
   
   
--
-- test creating and deleting records  
--
--
   procedure Get_Participation_Scale_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      ratio : Amount;
   begin
      for sex in 1 .. 2 loop
         for age in 16..120 loop
            ratio := Get_Participation_Scale( 
               country => UK,
               sex     => sex, 
               age     => age );
            Assert( ratio = 1.0, "UK => UK ratio always 1.0 " & ratio'Img );
            ratio := Get_Participation_Scale( 
               country => SCO,
               sex     => sex, 
               age     => age );
            Put_Line( "SCO :: age => " & age'Img & " sex " & sex'Img & " ratio " & format( 100.0*ratio )); 
            ratio := Get_Participation_Scale( 
               country => ENG,
               sex     => sex, 
               age     => age );
            Put_Line( "ENG :: age => " & age'Img & " sex " & sex'Img & " ratio " & format( 100.0*ratio )); 
         end loop;
      end loop;
   end  Get_Participation_Scale_Test;
   
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      --
      -- Tests of record creation/deletion
      --
      Register_Routine (T, Get_Participation_Scale_Test'Access, "t_Participation_Scale_Test" );
   end Register_Tests;
   
   --  Register routines to be run
   
   
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format( "Ukds_Test Test Suite" );
   end Name;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===
   
   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case ) is
   begin
       GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   end Set_Up;
   
   --  Preparation performed after each routine:
   procedure Shut_Down( t : in out Test_Case ) is
   begin
      null;
   end Shut_Down;
   
   
begin
   null;
end Model.SCP.Target_Creator.Tests;
