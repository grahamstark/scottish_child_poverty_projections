--
-- Created by Ada Mill (https://github.com/grahamstark/ada_mill)
-- 
-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Environment is

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===
   
   function Get_Server_Name return String;
   function Get_Database_Name return String;   
   function Get_Username return String;
   function Get_Password return String;
   function Get_Port return Integer;
   
   procedure Set_Server_Name( name : String );
   procedure Set_Database_Name( name : String );
   procedure Set_Username( name : String );
   procedure Set_Password( pwd : String );
   procedure Set_Port( new_port : Integer );

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Environment;
