--
-- Created by ada_generator.py on 2017-09-20 15:38:47.644744
-- 

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

with Ada.Strings.Unbounded;

package body Environment is

   use Ada.Strings.Unbounded;
   

   SERVER_NAME       : Unbounded_String := To_Unbounded_String( "" );
   DATABASE_NAME     : Unbounded_String := To_Unbounded_String( "ukds" );
   USER_NAME         : Unbounded_String := To_Unbounded_String( "ukds" );
   PASSWORD          : Unbounded_String := To_Unbounded_String( "ukds" );
   PORT              : Integer := -1;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   function Get_Port return Integer is
   begin
      return PORT;
   end Get_Port;    

   procedure Set_Port( new_port : Integer ) is
   begin
      PORT := new_port;
   end Set_Port;    
   
   function Get_Server_Name return String is
   begin
      return To_String( SERVER_NAME );
   end Get_Server_Name;

   function Get_Database_Name return String is
   begin
      return To_String( DATABASE_NAME );
   end Get_Database_Name;
   
   function Get_Username return String is
   begin
      return To_String( USER_NAME );
   end Get_Username;
   
   function Get_Password return String is
   begin
      return To_String( PASSWORD );
   end Get_Password;
   
   procedure Set_Server_Name( name : String ) is
   begin
      SERVER_NAME := To_Unbounded_String( name );
   end Set_Server_Name;
     
   procedure Set_Database_Name( name : String ) is
   begin
      DATABASE_NAME := To_Unbounded_String( name );
   end Set_Database_Name;
   
   procedure Set_Username( name : String ) is
   begin
      USER_NAME := To_Unbounded_String( name );
   end Set_Username;
   
   procedure Set_Password( pwd : String ) is
   begin
      PASSWORD := To_Unbounded_String( pwd );
   end Set_Password;

   
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Environment;

