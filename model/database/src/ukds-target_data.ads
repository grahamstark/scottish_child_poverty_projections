--
-- Created by ada_generator.py on 2017-09-14 14:06:16.598244
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
   -- record modelling Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   type Population_Forecasts is record
      year : Integer := 0;
      rec_type : Unbounded_String := To_Unbounded_String( "persons" );
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := Year_Number'First;
      target_group : Unbounded_String := MISSING_W_KEY;
      all_ages : Amount := 0.0;
      age_0 : Amount := 0.0;
      age_1 : Amount := 0.0;
      age_2 : Amount := 0.0;
      age_3 : Amount := 0.0;
      age_4 : Amount := 0.0;
      age_5 : Amount := 0.0;
      age_6 : Amount := 0.0;
      age_7 : Amount := 0.0;
      age_8 : Amount := 0.0;
      age_9 : Amount := 0.0;
      age_10 : Amount := 0.0;
      age_11 : Amount := 0.0;
      age_12 : Amount := 0.0;
      age_13 : Amount := 0.0;
      age_14 : Amount := 0.0;
      age_15 : Amount := 0.0;
      age_16 : Amount := 0.0;
      age_17 : Amount := 0.0;
      age_18 : Amount := 0.0;
      age_19 : Amount := 0.0;
      age_20 : Amount := 0.0;
      age_21 : Amount := 0.0;
      age_22 : Amount := 0.0;
      age_23 : Amount := 0.0;
      age_24 : Amount := 0.0;
      age_25 : Amount := 0.0;
      age_26 : Amount := 0.0;
      age_27 : Amount := 0.0;
      age_28 : Amount := 0.0;
      age_29 : Amount := 0.0;
      age_30 : Amount := 0.0;
      age_31 : Amount := 0.0;
      age_32 : Amount := 0.0;
      age_33 : Amount := 0.0;
      age_34 : Amount := 0.0;
      age_35 : Amount := 0.0;
      age_36 : Amount := 0.0;
      age_37 : Amount := 0.0;
      age_38 : Amount := 0.0;
      age_39 : Amount := 0.0;
      age_40 : Amount := 0.0;
      age_41 : Amount := 0.0;
      age_42 : Amount := 0.0;
      age_43 : Amount := 0.0;
      age_44 : Amount := 0.0;
      age_45 : Amount := 0.0;
      age_46 : Amount := 0.0;
      age_47 : Amount := 0.0;
      age_48 : Amount := 0.0;
      age_49 : Amount := 0.0;
      age_50 : Amount := 0.0;
      age_51 : Amount := 0.0;
      age_52 : Amount := 0.0;
      age_53 : Amount := 0.0;
      age_54 : Amount := 0.0;
      age_55 : Amount := 0.0;
      age_56 : Amount := 0.0;
      age_57 : Amount := 0.0;
      age_58 : Amount := 0.0;
      age_59 : Amount := 0.0;
      age_60 : Amount := 0.0;
      age_61 : Amount := 0.0;
      age_62 : Amount := 0.0;
      age_63 : Amount := 0.0;
      age_64 : Amount := 0.0;
      age_65 : Amount := 0.0;
      age_66 : Amount := 0.0;
      age_67 : Amount := 0.0;
      age_68 : Amount := 0.0;
      age_69 : Amount := 0.0;
      age_70 : Amount := 0.0;
      age_71 : Amount := 0.0;
      age_72 : Amount := 0.0;
      age_73 : Amount := 0.0;
      age_74 : Amount := 0.0;
      age_75 : Amount := 0.0;
      age_76 : Amount := 0.0;
      age_77 : Amount := 0.0;
      age_78 : Amount := 0.0;
      age_79 : Amount := 0.0;
      age_80 : Amount := 0.0;
      age_81 : Amount := 0.0;
      age_82 : Amount := 0.0;
      age_83 : Amount := 0.0;
      age_84 : Amount := 0.0;
      age_85 : Amount := 0.0;
      age_86 : Amount := 0.0;
      age_87 : Amount := 0.0;
      age_88 : Amount := 0.0;
      age_89 : Amount := 0.0;
      age_90_plus : Amount := 0.0;
   end record;
   --
   -- container for Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   package Population_Forecasts_List_Package is new Ada.Containers.Vectors
      (Element_Type => Population_Forecasts,
      Index_Type => Positive );
   subtype Population_Forecasts_List is Population_Forecasts_List_Package.Vector;
   --
   -- default value for Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   Null_Population_Forecasts : constant Population_Forecasts := (
         year => 0,
         rec_type => To_Unbounded_String( "persons" ),
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
   -- simple print routine for Population_Forecasts : Population Data One row for each Country/Year/Variant/type [M/F/Both]
   --
   function To_String( rec : Population_Forecasts ) return String;

   --
   -- record modelling Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   type Households_Forecasts is record
      year : Integer := 0;
      rec_type : Unbounded_String := To_Unbounded_String( "households" );
      variant : Unbounded_String := MISSING_W_KEY;
      country : Unbounded_String := MISSING_W_KEY;
      edition : Year_Number := Year_Number'First;
      one_adult_male : Amount := 0.0;
      one_adult_female : Amount := 0.0;
      two_adults : Amount := 0.0;
      one_adult_one_child : Amount := 0.0;
      one_adult_two_plus_children : Amount := 0.0;
      two_plus_adult_one_plus_children : Amount := 0.0;
      three_plus_person_all_adult : Amount := 0.0;
      all_households : Amount := 0.0;
   end record;
   --
   -- container for Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   package Households_Forecasts_List_Package is new Ada.Containers.Vectors
      (Element_Type => Households_Forecasts,
      Index_Type => Positive );
   subtype Households_Forecasts_List is Households_Forecasts_List_Package.Vector;
   --
   -- default value for Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   Null_Households_Forecasts : constant Households_Forecasts := (
         year => 0,
         rec_type => To_Unbounded_String( "households" ),
         variant => MISSING_W_KEY,
         country => MISSING_W_KEY,
         edition => Year_Number'First,
         one_adult_male => 0.0,
         one_adult_female => 0.0,
         two_adults => 0.0,
         one_adult_one_child => 0.0,
         one_adult_two_plus_children => 0.0,
         two_plus_adult_one_plus_children => 0.0,
         three_plus_person_all_adult => 0.0,
         all_households => 0.0
   );
   --
   -- simple print routine for Households_Forecasts : Household Data One row for each Country/Year/Variant
   --
   function To_String( rec : Households_Forecasts ) return String;

   --
   -- record modelling Forecast_Variant : 
   --
   type Forecast_Variant is record
      rec_type : Unbounded_String := MISSING_W_KEY;
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
         rec_type => MISSING_W_KEY,
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
   
   subtype Forecast_Age_Ranges is Natural range 0 .. 90;
   type Age_Range_Array is array( Forecast_Age_Ranges ) of Amount; 
   function To_Array( popn : Population_Forecasts ) return Age_Range_Array;
   
   -- === CUSTOM PROCS END ===

end Ukds.target_data;
