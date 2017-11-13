-- 
-- Created by ada_generator.py on 2017-11-13 10:51:15.052558
-- 

with Ada.Exceptions;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body DB_Commons.PSQL is


   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   procedure Check_Result( conn : dexec.Database_Connection ) is
   use Ada.Exceptions;
      error_msg : constant String := dexec.Error( conn );
   begin
      if( error_msg /= "" )then
         Raise_Exception( Mill_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     

   procedure Execute_Script( connection : dexec.Database_Connection; script : String ) is
   begin
      dexec.Execute( connection, script );
      Check_Result( connection );
   end Execute_Script;

   function Make_SQL_Parameter_Discrete( t : Some_Discrete_Type )  return dexec.SQL_Parameter is
   begin
      return dexec."+"( Some_Discrete_Type'Pos( t ));   
   end Make_SQL_Parameter_Discrete;
   
   function Make_SQL_Parameter_Float( f : Some_Floating_Type ) return dexec.SQL_Parameter is
   begin
      return dexec."+"( Float( f ));
   end Make_SQL_Parameter_Float;
         
   function "+" ( s : Unbounded_String ) return dexec.SQL_Parameter is
      ss : aliased String := To_String( s );
   begin
      return dexec."+"( ss'Access );
   end "+";
   
   
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end DB_Commons.PSQL;
