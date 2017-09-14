--
-- Created by ada_generator.py on 2017-09-13 23:07:56.519056
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

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds.target_data is

   use Ada.Strings.Unbounded;
   
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===



   --
   -- record modelling Demographic_Candidates : Merged Household/Individual Population Data One row for each Country/Year/Variant
   --
   type Demographic_Candidates is record
      year : Integer := 0;
      type : Unbounded_String := To_Unbounded_String( "persons" );
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := Year_Number'First;
      target_group : Unbounded_String := MISSING_W_KEY;
      all_ages : Long_Float := 0.0;
      age_0 : Long_Float := 0.0;
      age_1 : Long_Float := 0.0;
      age_2 : Long_Float := 0.0;
      age_3 : Long_Float := 0.0;
      age_4 : Long_Float := 0.0;
      age_5 : Long_Float := 0.0;
      age_6 : Long_Float := 0.0;
      age_7 : Long_Float := 0.0;
      age_8 : Long_Float := 0.0;
      age_9 : Long_Float := 0.0;
      age_10 : Long_Float := 0.0;
      age_11 : Long_Float := 0.0;
      age_12 : Long_Float := 0.0;
      age_13 : Long_Float := 0.0;
      age_14 : Long_Float := 0.0;
      age_15 : Long_Float := 0.0;
      age_16 : Long_Float := 0.0;
      age_17 : Long_Float := 0.0;
      age_18 : Long_Float := 0.0;
      age_19 : Long_Float := 0.0;
      age_20 : Long_Float := 0.0;
      age_21 : Long_Float := 0.0;
      age_22 : Long_Float := 0.0;
      age_23 : Long_Float := 0.0;
      age_24 : Long_Float := 0.0;
      age_25 : Long_Float := 0.0;
      age_26 : Long_Float := 0.0;
      age_27 : Long_Float := 0.0;
      age_28 : Long_Float := 0.0;
      age_29 : Long_Float := 0.0;
      age_30 : Long_Float := 0.0;
      age_31 : Long_Float := 0.0;
      age_32 : Long_Float := 0.0;
      age_33 : Long_Float := 0.0;
      age_34 : Long_Float := 0.0;
      age_35 : Long_Float := 0.0;
      age_36 : Long_Float := 0.0;
      age_37 : Long_Float := 0.0;
      age_38 : Long_Float := 0.0;
      age_39 : Long_Float := 0.0;
      age_40 : Long_Float := 0.0;
      age_41 : Long_Float := 0.0;
      age_42 : Long_Float := 0.0;
      age_43 : Long_Float := 0.0;
      age_44 : Long_Float := 0.0;
      age_45 : Long_Float := 0.0;
      age_46 : Long_Float := 0.0;
      age_47 : Long_Float := 0.0;
      age_48 : Long_Float := 0.0;
      age_49 : Long_Float := 0.0;
      age_50 : Long_Float := 0.0;
      age_51 : Long_Float := 0.0;
      age_52 : Long_Float := 0.0;
      age_53 : Long_Float := 0.0;
      age_54 : Long_Float := 0.0;
      age_55 : Long_Float := 0.0;
      age_56 : Long_Float := 0.0;
      age_57 : Long_Float := 0.0;
      age_58 : Long_Float := 0.0;
      age_59 : Long_Float := 0.0;
      age_60 : Long_Float := 0.0;
      age_61 : Long_Float := 0.0;
      age_62 : Long_Float := 0.0;
      age_63 : Long_Float := 0.0;
      age_64 : Long_Float := 0.0;
      age_65 : Long_Float := 0.0;
      age_66 : Long_Float := 0.0;
      age_67 : Long_Float := 0.0;
      age_68 : Long_Float := 0.0;
      age_69 : Long_Float := 0.0;
      age_70 : Long_Float := 0.0;
      age_71 : Long_Float := 0.0;
      age_72 : Long_Float := 0.0;
      age_73 : Long_Float := 0.0;
      age_74 : Long_Float := 0.0;
      age_75 : Long_Float := 0.0;
      age_76 : Long_Float := 0.0;
      age_77 : Long_Float := 0.0;
      age_78 : Long_Float := 0.0;
      age_79 : Long_Float := 0.0;
      age_80 : Long_Float := 0.0;
      age_81 : Long_Float := 0.0;
      age_82 : Long_Float := 0.0;
      age_83 : Long_Float := 0.0;
      age_84 : Long_Float := 0.0;
      age_85 : Long_Float := 0.0;
      age_86 : Long_Float := 0.0;
      age_87 : Long_Float := 0.0;
      age_88 : Long_Float := 0.0;
      age_89 : Long_Float := 0.0;
      age_90_plus : Long_Float := 0.0;
   end record;
   --
   -- container for Demographic_Candidates : Merged Household/Individual Population Data One row for each Country/Year/Variant
   --
   package Demographic_Candidates_List_Package is new Ada.Containers.Vectors
      (Element_Type => Demographic_Candidates,
      Index_Type => Positive );
   subtype Demographic_Candidates_List is Demographic_Candidates_List_Package.Vector;
   --
   -- default value for Demographic_Candidates : Merged Household/Individual Population Data One row for each Country/Year/Variant
   --
   Null_Demographic_Candidates : constant Demographic_Candidates := (
         year => 0,
         type => To_Unbounded_String( "persons" ),
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => Year_Number'First,
         target_group => MISSING_W_KEY,
         all_ages => 0.0,
         age_0 => 0.0,
         age_1 => 0.0,
         age_2 => 0.0,
         age_3 => 0.0,
         age_4 => 0.0,
         age_5 => 0.0,
         age_6 => 0.0,
         age_7 => 0.0,
         age_8 => 0.0,
         age_9 => 0.0,
         age_10 => 0.0,
         age_11 => 0.0,
         age_12 => 0.0,
         age_13 => 0.0,
         age_14 => 0.0,
         age_15 => 0.0,
         age_16 => 0.0,
         age_17 => 0.0,
         age_18 => 0.0,
         age_19 => 0.0,
         age_20 => 0.0,
         age_21 => 0.0,
         age_22 => 0.0,
         age_23 => 0.0,
         age_24 => 0.0,
         age_25 => 0.0,
         age_26 => 0.0,
         age_27 => 0.0,
         age_28 => 0.0,
         age_29 => 0.0,
         age_30 => 0.0,
         age_31 => 0.0,
         age_32 => 0.0,
         age_33 => 0.0,
         age_34 => 0.0,
         age_35 => 0.0,
         age_36 => 0.0,
         age_37 => 0.0,
         age_38 => 0.0,
         age_39 => 0.0,
         age_40 => 0.0,
         age_41 => 0.0,
         age_42 => 0.0,
         age_43 => 0.0,
         age_44 => 0.0,
         age_45 => 0.0,
         age_46 => 0.0,
         age_47 => 0.0,
         age_48 => 0.0,
         age_49 => 0.0,
         age_50 => 0.0,
         age_51 => 0.0,
         age_52 => 0.0,
         age_53 => 0.0,
         age_54 => 0.0,
         age_55 => 0.0,
         age_56 => 0.0,
         age_57 => 0.0,
         age_58 => 0.0,
         age_59 => 0.0,
         age_60 => 0.0,
         age_61 => 0.0,
         age_62 => 0.0,
         age_63 => 0.0,
         age_64 => 0.0,
         age_65 => 0.0,
         age_66 => 0.0,
         age_67 => 0.0,
         age_68 => 0.0,
         age_69 => 0.0,
         age_70 => 0.0,
         age_71 => 0.0,
         age_72 => 0.0,
         age_73 => 0.0,
         age_74 => 0.0,
         age_75 => 0.0,
         age_76 => 0.0,
         age_77 => 0.0,
         age_78 => 0.0,
         age_79 => 0.0,
         age_80 => 0.0,
         age_81 => 0.0,
         age_82 => 0.0,
         age_83 => 0.0,
         age_84 => 0.0,
         age_85 => 0.0,
         age_86 => 0.0,
         age_87 => 0.0,
         age_88 => 0.0,
         age_89 => 0.0,
         age_90_plus => 0.0
   );
   --
   -- simple print routine for Demographic_Candidates : Merged Household/Individual Population Data One row for each Country/Year/Variant
   --
   function To_String( rec : Demographic_Candidates ) return String;

   --
   -- record modelling Forecast_Variant : 
   --
   type Forecast_Variant is record
      type : Unbounded_String := MISSING_W_KEY;
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := Year_Number'First;
      source : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      description : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      url : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      filename : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
   end record;
   --
   -- container for Forecast_Variant : 
   --
   package Forecast_Variant_List_Package is new Ada.Containers.Vectors
      (Element_Type => Forecast_Variant,
      Index_Type => Positive );
   subtype Forecast_Variant_List is Forecast_Variant_List_Package.Vector;
   --
   -- default value for Forecast_Variant : 
   --
   Null_Forecast_Variant : constant Forecast_Variant := (
         type => MISSING_W_KEY,
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => Year_Number'First,
         source => Ada.Strings.Unbounded.Null_Unbounded_String,
         description => Ada.Strings.Unbounded.Null_Unbounded_String,
         url => Ada.Strings.Unbounded.Null_Unbounded_String,
         filename => Ada.Strings.Unbounded.Null_Unbounded_String
   );
   --
   -- simple print routine for Forecast_Variant : 
   --
   function To_String( rec : Forecast_Variant ) return String;

   --
   -- record modelling Country : 
   --
   type Country is record
      name : Unbounded_String := MISSING_W_KEY;
   end record;
   --
   -- container for Country : 
   --
   package Country_List_Package is new Ada.Containers.Vectors
      (Element_Type => Country,
      Index_Type => Positive );
   subtype Country_List is Country_List_Package.Vector;
   --
   -- default value for Country : 
   --
   Null_Country : constant Country := (
         name => MISSING_W_KEY
   );
   --
   -- simple print routine for Country : 
   --
   function To_String( rec : Country ) return String;

   --
   -- record modelling Forecast_Type : 
   --
   type Forecast_Type is record
      name : Unbounded_String := MISSING_W_KEY;
      description : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
   end record;
   --
   -- container for Forecast_Type : 
   --
   package Forecast_Type_List_Package is new Ada.Containers.Vectors
      (Element_Type => Forecast_Type,
      Index_Type => Positive );
   subtype Forecast_Type_List is Forecast_Type_List_Package.Vector;
   --
   -- default value for Forecast_Type : 
   --
   Null_Forecast_Type : constant Forecast_Type := (
         name => MISSING_W_KEY,
         description => Ada.Strings.Unbounded.Null_Unbounded_String
   );
   --
   -- simple print routine for Forecast_Type : 
   --
   function To_String( rec : Forecast_Type ) return String;



        
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.target_data;
