package body SCP_Types is
   
   function Image( c : Countries ) return Unbounded_String is
      s : constant String := Countries'Image( c );
   begin
      return To_Unbounded_String( s( s'First+1 .. s'Last-2 ));
   end Image;

end SCP_Types;