with Ada.Assertions;

package body SCP_Types is
   use Ada.Assertions;
   
   function Image( c : Countries ) return Unbounded_String is
      s : constant String := Countries'Image( c );
   begin
      return To_Unbounded_String( s( s'First+1 .. s'Last-2 ));
   end Image;

   function Country_From_Country( s : Unbounded_String ) return Countries is  -- amazingly stupid design
      cntry : Countries;
   begin
      if s = SCO then 
         cntry := SCO_C;
      elsif s = ENG then
         cntry := ENG_C;
      elsif s = WAL then
         cntry := WAL_C;
      elsif s = NIR then
         cntry := NIR_C;
      elsif s = UK then
         cntry := UK_C;
      else
         Assert( false, "unknown country String " & To_String( s ));
      end if;
      return cntry;
   end Country_From_Country; 
            
end SCP_Types;