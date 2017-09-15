--
-- Created by ada_generator.py on 2017-09-15 17:46:22.888514
-- 
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Bounded;
with Ada.Strings.Wide_Fixed;
with ada.strings.Unbounded; 
with Base_Types; 

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===
 
package DB_Commons is

   use Base_Types;
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===
   
   --
   -- not used yet: need something like this so we can 
   -- pass connections to save/update functions
   -- needs to change for odbc, obviously
   -- 
   -- subtype Connection is GNATCOLL.SQL.Exec.Database_Connection;
   -- NULL_Conn : constant Connection := null;

   Mill_Exception : exception;
   
   -- rudimentary schema handling
   function Get_Default_Schema return String;
   procedure Set_Default_Schema( name : String );
   
   -- schema placeholder should be delimited %{SCHEMA}
   function Add_Schema_To_Query( query : String; default : String := "" ) return String;
   
   -- subtype Real is Base_Types.Real;
   subtype Decimal is Base_Types.Decimal;
   --
   --  Simple date time record to serve as an intermediate type
   --  between ADA time records and (say) ODBC date/time types
   --
   type Date_Time_Rec is record
      year,
      month,
      day,
      hour,
      minute,
      second : integer;
      fraction : Long_Float;
   end record;
   
   function Date_Time_To_Ada_Time( dTime : Date_Time_Rec ) return Ada.Calendar.Time; 
   function Ada_Time_To_Date_Time( adaTime : Ada.Calendar.Time ) return Date_Time_Rec;
   function to_string( t : Date_Time_Rec ) return String;
   function to_string( t : Ada.Calendar.Time ) return String;
   --
   -- Criteria: simple (??) way to construct queries
   --
   type Asc_Or_Desc is ( asc, desc );
    
   type operation_type is ( like, gt, ge, lt, le, ne, eq );
   
   type field_type is ( string_type, decimal_type, real_type, integer_type, varchar_type, blob_type, clob_type );
   
   type join_type is ( join_and, join_or );
   
   type Criterion is private;
   type Criteria is private;
   type Order_By_Element is private;
   
   function Make_Order_By_Element( varname : String; direction : Asc_Or_Desc ) return Order_By_Element;

   function Make_Criterion_Element( varname : String;
                                  op : operation_type;
                                  join : join_type; 
                                  value : String;
                                  max_length : integer := -1  ) return Criterion;
                                  
   function Make_Criterion_Element( 
      varname : String;
      op : operation_type;
      join : join_type; 
      value : Integer  ) return Criterion;

   function Make_Criterion_Element( 
      varname : String;
      op : operation_type;
      join : join_type; 
      value : Big_Int  ) return Criterion;
                                  
   function Make_Criterion_Element( 
      varname : String;
      op : operation_type;
      join : join_type; 
      value : Long_Float  ) return Criterion;

   function Make_Criterion_Element( 
      varname : String;
      op : operation_type;
      join : join_type; 
      value : Boolean  ) return Criterion;
                                  
   function Make_Criterion_Element( 
      varname : String;
      op : operation_type;
      join : join_type; 
      t : Ada.Calendar.Time  ) return Criterion;
  
   generic
      type Dec is delta<> digits<>;
      function Make_Decimal_Criterion_Element( 
         varname : String;
         op : operation_type;
         join : join_type; 
         value : Dec  ) return Criterion;
                                  
   --
   -- return a string like 'where xx='1' and yy=22 order by smith
   --
   function To_String( c : Criteria; join_str_override : String := "" ) return String;
   
   --
   -- return a string like '22', 23, 11 
   --
   function To_Crude_Array_Of_Values( c : Criteria ) return String;
   
   procedure Add_To_Criteria( cr : in out Criteria; elem : Criterion );
   procedure Add_To_Criteria( cr : in out Criteria; ob : Order_By_Element );
   procedure Remove_From_Criteria( cr : in out Criteria; varname : String );
   function Merge( c1 : Criteria; c2 : Criteria ) return Criteria;
   --
   -- so, if start=3 and count=1000, gives " limit 1000 offset 2 " since counting from zero
   -- if start=1 and count=Last, returns a zero length string.
   --
   function Make_Limits_Clause( 
      start : Positive := 1;
      count : Positive := Positive'Last ) return String;
      
  function Random_String return String;    
      
   
   DB_Exception : exception;

private 
 
   use Ada.Strings.Unbounded;
   
   package String80 is new Ada.Strings.Bounded.Generic_Bounded_Length (80);
   
   use String80;
   
   type Criterion is record
      s     : Unbounded_String;
      value : Unbounded_String;
      join  : Join_Type;
   end record;
   
   type Order_By_Element is new Ada.Strings.Unbounded.Unbounded_String;
           
   package Criteria_P is new Ada.Containers.Vectors( 
      Element_Type => Criterion, 
      Index_Type   => Positive );
           
   package Order_By_P is new Ada.Containers.Vectors( 
      Element_Type => Order_By_Element, 
      Index_Type   => Positive );
   
   type Criteria is record
      elements  : Criteria_P.Vector;
      orderings : Order_By_P.Vector;
   end record;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===
   
end DB_Commons;
