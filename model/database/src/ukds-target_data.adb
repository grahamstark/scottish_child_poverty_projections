--
-- Created by ada_generator.py on 2017-09-13 23:07:56.720903
-- 

with GNAT.Calendar.Time_IO;
-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.target_data is

   use ada.strings.Unbounded;
   package tio renames GNAT.Calendar.Time_IO;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===
   
   
   function To_String( rec : Demographic_Candidates ) return String is
   begin
      return  "Demographic_Candidates: " &
         "year = " & rec.year'Img &
         "type = " & To_String( rec.type ) &
         "variant = " & To_String( rec.variant ) &
         "country = " & To_String( rec.country ) &
         "edition = " & rec.edition'Img &
         "target_group = " & To_String( rec.target_group ) &
         "all_ages = " & rec.all_ages'Img &
         "age_0 = " & rec.age_0'Img &
         "age_1 = " & rec.age_1'Img &
         "age_2 = " & rec.age_2'Img &
         "age_3 = " & rec.age_3'Img &
         "age_4 = " & rec.age_4'Img &
         "age_5 = " & rec.age_5'Img &
         "age_6 = " & rec.age_6'Img &
         "age_7 = " & rec.age_7'Img &
         "age_8 = " & rec.age_8'Img &
         "age_9 = " & rec.age_9'Img &
         "age_10 = " & rec.age_10'Img &
         "age_11 = " & rec.age_11'Img &
         "age_12 = " & rec.age_12'Img &
         "age_13 = " & rec.age_13'Img &
         "age_14 = " & rec.age_14'Img &
         "age_15 = " & rec.age_15'Img &
         "age_16 = " & rec.age_16'Img &
         "age_17 = " & rec.age_17'Img &
         "age_18 = " & rec.age_18'Img &
         "age_19 = " & rec.age_19'Img &
         "age_20 = " & rec.age_20'Img &
         "age_21 = " & rec.age_21'Img &
         "age_22 = " & rec.age_22'Img &
         "age_23 = " & rec.age_23'Img &
         "age_24 = " & rec.age_24'Img &
         "age_25 = " & rec.age_25'Img &
         "age_26 = " & rec.age_26'Img &
         "age_27 = " & rec.age_27'Img &
         "age_28 = " & rec.age_28'Img &
         "age_29 = " & rec.age_29'Img &
         "age_30 = " & rec.age_30'Img &
         "age_31 = " & rec.age_31'Img &
         "age_32 = " & rec.age_32'Img &
         "age_33 = " & rec.age_33'Img &
         "age_34 = " & rec.age_34'Img &
         "age_35 = " & rec.age_35'Img &
         "age_36 = " & rec.age_36'Img &
         "age_37 = " & rec.age_37'Img &
         "age_38 = " & rec.age_38'Img &
         "age_39 = " & rec.age_39'Img &
         "age_40 = " & rec.age_40'Img &
         "age_41 = " & rec.age_41'Img &
         "age_42 = " & rec.age_42'Img &
         "age_43 = " & rec.age_43'Img &
         "age_44 = " & rec.age_44'Img &
         "age_45 = " & rec.age_45'Img &
         "age_46 = " & rec.age_46'Img &
         "age_47 = " & rec.age_47'Img &
         "age_48 = " & rec.age_48'Img &
         "age_49 = " & rec.age_49'Img &
         "age_50 = " & rec.age_50'Img &
         "age_51 = " & rec.age_51'Img &
         "age_52 = " & rec.age_52'Img &
         "age_53 = " & rec.age_53'Img &
         "age_54 = " & rec.age_54'Img &
         "age_55 = " & rec.age_55'Img &
         "age_56 = " & rec.age_56'Img &
         "age_57 = " & rec.age_57'Img &
         "age_58 = " & rec.age_58'Img &
         "age_59 = " & rec.age_59'Img &
         "age_60 = " & rec.age_60'Img &
         "age_61 = " & rec.age_61'Img &
         "age_62 = " & rec.age_62'Img &
         "age_63 = " & rec.age_63'Img &
         "age_64 = " & rec.age_64'Img &
         "age_65 = " & rec.age_65'Img &
         "age_66 = " & rec.age_66'Img &
         "age_67 = " & rec.age_67'Img &
         "age_68 = " & rec.age_68'Img &
         "age_69 = " & rec.age_69'Img &
         "age_70 = " & rec.age_70'Img &
         "age_71 = " & rec.age_71'Img &
         "age_72 = " & rec.age_72'Img &
         "age_73 = " & rec.age_73'Img &
         "age_74 = " & rec.age_74'Img &
         "age_75 = " & rec.age_75'Img &
         "age_76 = " & rec.age_76'Img &
         "age_77 = " & rec.age_77'Img &
         "age_78 = " & rec.age_78'Img &
         "age_79 = " & rec.age_79'Img &
         "age_80 = " & rec.age_80'Img &
         "age_81 = " & rec.age_81'Img &
         "age_82 = " & rec.age_82'Img &
         "age_83 = " & rec.age_83'Img &
         "age_84 = " & rec.age_84'Img &
         "age_85 = " & rec.age_85'Img &
         "age_86 = " & rec.age_86'Img &
         "age_87 = " & rec.age_87'Img &
         "age_88 = " & rec.age_88'Img &
         "age_89 = " & rec.age_89'Img &
         "age_90_plus = " & rec.age_90_plus'Img;
   end to_String;


   function To_String( rec : Forecast_Variant ) return String is
   begin
      return  "Forecast_Variant: " &
         "type = " & To_String( rec.type ) &
         "variant = " & To_String( rec.variant ) &
         "country = " & To_String( rec.country ) &
         "edition = " & rec.edition'Img &
         "source = " & To_String( rec.source ) &
         "description = " & To_String( rec.description ) &
         "url = " & To_String( rec.url ) &
         "filename = " & To_String( rec.filename );
   end to_String;


   function To_String( rec : Country ) return String is
   begin
      return  "Country: " &
         "name = " & To_String( rec.name );
   end to_String;


   function To_String( rec : Forecast_Type ) return String is
   begin
      return  "Forecast_Type: " &
         "name = " & To_String( rec.name ) &
         "description = " & To_String( rec.description );
   end to_String;



        
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.target_data;
