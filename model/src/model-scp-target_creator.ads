with UKDS.Target_Data;
with Ada.Strings.Unbounded; 

--
-- Creates a dataset that can be used to create targets for weighting. 
-- Bit of a mishmash; the original idea was a dataset by country (EN,SCO,UK..), stacked,
-- but now it's got EN/WA.. household bits wired in seperately since the household classifications
-- are different for each devolved administation hh forecast.
-- 
package Model.SCP.Target_Creator is

   use UKDS.Target_Data;
   use Ada.Strings.Unbounded;
   
   procedure Create_Dataset( the_run : Run );

private


   --
   -- participation rate of some age/gender group from EN,WAl,SCOT,NIR relative to UK
   -- average, using data Retrieved from NOMIS on 19/10/2017 on country-level
   -- participation rates by age band and gender from Annual Population Survey.
   --
   function Get_Participation_Scale( 
      country : Unbounded_String; 
      sex : Integer; 
      age : Integer ) return Amount;

end  Model.SCP.Target_Creator;