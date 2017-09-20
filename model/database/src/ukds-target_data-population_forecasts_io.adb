--
-- Created by ada_generator.py on 2017-09-20 12:26:49.859552
-- 
with Ukds;


with Ada.Containers.Vectors;

with Environment;

with DB_Commons; 

with GNATCOLL.SQL_Impl;
with GNATCOLL.SQL.Postgres;
with DB_Commons.PSQL;


with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with Text_IO;
with Ada.Strings.Maps;
with Connection_Pool;
with GNATColl.Traces;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Target_Data.Population_Forecasts_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.TARGET_DATA.POPULATION_FORECASTS_IO" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --

   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "year, rec_type, variant, country, edition, target_group, all_ages, age_0, age_1, age_2," &
         "age_3, age_4, age_5, age_6, age_7, age_8, age_9, age_10, age_11, age_12," &
         "age_13, age_14, age_15, age_16, age_17, age_18, age_19, age_20, age_21, age_22," &
         "age_23, age_24, age_25, age_26, age_27, age_28, age_29, age_30, age_31, age_32," &
         "age_33, age_34, age_35, age_36, age_37, age_38, age_39, age_40, age_41, age_42," &
         "age_43, age_44, age_45, age_46, age_47, age_48, age_49, age_50, age_51, age_52," &
         "age_53, age_54, age_55, age_56, age_57, age_58, age_59, age_60, age_61, age_62," &
         "age_63, age_64, age_65, age_66, age_67, age_68, age_69, age_70, age_71, age_72," &
         "age_73, age_74, age_75, age_76, age_77, age_78, age_79, age_80, age_81, age_82," &
         "age_83, age_84, age_85, age_86, age_87, age_88, age_89, age_90, age_91, age_92," &
         "age_93, age_94, age_95, age_96, age_97, age_98, age_99, age_100, age_101, age_102," &
         "age_103, age_104, age_105, age_106, age_107, age_108, age_109, age_110 " &
         " from target_data.population_forecasts " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_data.population_forecasts (" &
         "year, rec_type, variant, country, edition, target_group, all_ages, age_0, age_1, age_2," &
         "age_3, age_4, age_5, age_6, age_7, age_8, age_9, age_10, age_11, age_12," &
         "age_13, age_14, age_15, age_16, age_17, age_18, age_19, age_20, age_21, age_22," &
         "age_23, age_24, age_25, age_26, age_27, age_28, age_29, age_30, age_31, age_32," &
         "age_33, age_34, age_35, age_36, age_37, age_38, age_39, age_40, age_41, age_42," &
         "age_43, age_44, age_45, age_46, age_47, age_48, age_49, age_50, age_51, age_52," &
         "age_53, age_54, age_55, age_56, age_57, age_58, age_59, age_60, age_61, age_62," &
         "age_63, age_64, age_65, age_66, age_67, age_68, age_69, age_70, age_71, age_72," &
         "age_73, age_74, age_75, age_76, age_77, age_78, age_79, age_80, age_81, age_82," &
         "age_83, age_84, age_85, age_86, age_87, age_88, age_89, age_90, age_91, age_92," &
         "age_93, age_94, age_95, age_96, age_97, age_98, age_99, age_100, age_101, age_102," &
         "age_103, age_104, age_105, age_106, age_107, age_108, age_109, age_110 " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_data.population_forecasts ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_data.population_forecasts set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 118 ) := ( if update_order then (
            1 => ( Parameter_Float, 0.0 ),   --  : all_ages (Amount)
            2 => ( Parameter_Float, 0.0 ),   --  : age_0 (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : age_1 (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : age_2 (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : age_3 (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : age_4 (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : age_5 (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : age_6 (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : age_7 (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : age_8 (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : age_9 (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : age_10 (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : age_11 (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : age_12 (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : age_13 (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : age_14 (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : age_15 (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : age_16 (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : age_17 (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : age_18 (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : age_19 (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : age_20 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : age_21 (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : age_22 (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : age_23 (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : age_24 (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : age_25 (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : age_26 (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : age_27 (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : age_28 (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : age_29 (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : age_30 (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : age_31 (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : age_32 (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : age_33 (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : age_34 (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : age_35 (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : age_36 (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : age_37 (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : age_38 (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : age_39 (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : age_40 (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : age_41 (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : age_42 (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : age_43 (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : age_44 (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : age_45 (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : age_46 (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : age_47 (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : age_48 (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : age_49 (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : age_50 (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : age_51 (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : age_52 (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : age_53 (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : age_54 (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : age_55 (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : age_56 (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : age_57 (Amount)
           60 => ( Parameter_Float, 0.0 ),   --  : age_58 (Amount)
           61 => ( Parameter_Float, 0.0 ),   --  : age_59 (Amount)
           62 => ( Parameter_Float, 0.0 ),   --  : age_60 (Amount)
           63 => ( Parameter_Float, 0.0 ),   --  : age_61 (Amount)
           64 => ( Parameter_Float, 0.0 ),   --  : age_62 (Amount)
           65 => ( Parameter_Float, 0.0 ),   --  : age_63 (Amount)
           66 => ( Parameter_Float, 0.0 ),   --  : age_64 (Amount)
           67 => ( Parameter_Float, 0.0 ),   --  : age_65 (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : age_66 (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : age_67 (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : age_68 (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : age_69 (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : age_70 (Amount)
           73 => ( Parameter_Float, 0.0 ),   --  : age_71 (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : age_72 (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : age_73 (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : age_74 (Amount)
           77 => ( Parameter_Float, 0.0 ),   --  : age_75 (Amount)
           78 => ( Parameter_Float, 0.0 ),   --  : age_76 (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : age_77 (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : age_78 (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : age_79 (Amount)
           82 => ( Parameter_Float, 0.0 ),   --  : age_80 (Amount)
           83 => ( Parameter_Float, 0.0 ),   --  : age_81 (Amount)
           84 => ( Parameter_Float, 0.0 ),   --  : age_82 (Amount)
           85 => ( Parameter_Float, 0.0 ),   --  : age_83 (Amount)
           86 => ( Parameter_Float, 0.0 ),   --  : age_84 (Amount)
           87 => ( Parameter_Float, 0.0 ),   --  : age_85 (Amount)
           88 => ( Parameter_Float, 0.0 ),   --  : age_86 (Amount)
           89 => ( Parameter_Float, 0.0 ),   --  : age_87 (Amount)
           90 => ( Parameter_Float, 0.0 ),   --  : age_88 (Amount)
           91 => ( Parameter_Float, 0.0 ),   --  : age_89 (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : age_90 (Amount)
           93 => ( Parameter_Float, 0.0 ),   --  : age_91 (Amount)
           94 => ( Parameter_Float, 0.0 ),   --  : age_92 (Amount)
           95 => ( Parameter_Float, 0.0 ),   --  : age_93 (Amount)
           96 => ( Parameter_Float, 0.0 ),   --  : age_94 (Amount)
           97 => ( Parameter_Float, 0.0 ),   --  : age_95 (Amount)
           98 => ( Parameter_Float, 0.0 ),   --  : age_96 (Amount)
           99 => ( Parameter_Float, 0.0 ),   --  : age_97 (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : age_98 (Amount)
           101 => ( Parameter_Float, 0.0 ),   --  : age_99 (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : age_100 (Amount)
           103 => ( Parameter_Float, 0.0 ),   --  : age_101 (Amount)
           104 => ( Parameter_Float, 0.0 ),   --  : age_102 (Amount)
           105 => ( Parameter_Float, 0.0 ),   --  : age_103 (Amount)
           106 => ( Parameter_Float, 0.0 ),   --  : age_104 (Amount)
           107 => ( Parameter_Float, 0.0 ),   --  : age_105 (Amount)
           108 => ( Parameter_Float, 0.0 ),   --  : age_106 (Amount)
           109 => ( Parameter_Float, 0.0 ),   --  : age_107 (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : age_108 (Amount)
           111 => ( Parameter_Float, 0.0 ),   --  : age_109 (Amount)
           112 => ( Parameter_Float, 0.0 ),   --  : age_110 (Amount)
           113 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           114 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
           115 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
           116 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
           117 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
           118 => ( Parameter_Text, null, Null_Unbounded_String )   --  : target_group (Unbounded_String)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            6 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : target_group (Unbounded_String)
            7 => ( Parameter_Float, 0.0 ),   --  : all_ages (Amount)
            8 => ( Parameter_Float, 0.0 ),   --  : age_0 (Amount)
            9 => ( Parameter_Float, 0.0 ),   --  : age_1 (Amount)
           10 => ( Parameter_Float, 0.0 ),   --  : age_2 (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : age_3 (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : age_4 (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : age_5 (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : age_6 (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : age_7 (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : age_8 (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : age_9 (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : age_10 (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : age_11 (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : age_12 (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : age_13 (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : age_14 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : age_15 (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : age_16 (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : age_17 (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : age_18 (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : age_19 (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : age_20 (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : age_21 (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : age_22 (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : age_23 (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : age_24 (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : age_25 (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : age_26 (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : age_27 (Amount)
           36 => ( Parameter_Float, 0.0 ),   --  : age_28 (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : age_29 (Amount)
           38 => ( Parameter_Float, 0.0 ),   --  : age_30 (Amount)
           39 => ( Parameter_Float, 0.0 ),   --  : age_31 (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : age_32 (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : age_33 (Amount)
           42 => ( Parameter_Float, 0.0 ),   --  : age_34 (Amount)
           43 => ( Parameter_Float, 0.0 ),   --  : age_35 (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : age_36 (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : age_37 (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : age_38 (Amount)
           47 => ( Parameter_Float, 0.0 ),   --  : age_39 (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : age_40 (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : age_41 (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : age_42 (Amount)
           51 => ( Parameter_Float, 0.0 ),   --  : age_43 (Amount)
           52 => ( Parameter_Float, 0.0 ),   --  : age_44 (Amount)
           53 => ( Parameter_Float, 0.0 ),   --  : age_45 (Amount)
           54 => ( Parameter_Float, 0.0 ),   --  : age_46 (Amount)
           55 => ( Parameter_Float, 0.0 ),   --  : age_47 (Amount)
           56 => ( Parameter_Float, 0.0 ),   --  : age_48 (Amount)
           57 => ( Parameter_Float, 0.0 ),   --  : age_49 (Amount)
           58 => ( Parameter_Float, 0.0 ),   --  : age_50 (Amount)
           59 => ( Parameter_Float, 0.0 ),   --  : age_51 (Amount)
           60 => ( Parameter_Float, 0.0 ),   --  : age_52 (Amount)
           61 => ( Parameter_Float, 0.0 ),   --  : age_53 (Amount)
           62 => ( Parameter_Float, 0.0 ),   --  : age_54 (Amount)
           63 => ( Parameter_Float, 0.0 ),   --  : age_55 (Amount)
           64 => ( Parameter_Float, 0.0 ),   --  : age_56 (Amount)
           65 => ( Parameter_Float, 0.0 ),   --  : age_57 (Amount)
           66 => ( Parameter_Float, 0.0 ),   --  : age_58 (Amount)
           67 => ( Parameter_Float, 0.0 ),   --  : age_59 (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : age_60 (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : age_61 (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : age_62 (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : age_63 (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : age_64 (Amount)
           73 => ( Parameter_Float, 0.0 ),   --  : age_65 (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : age_66 (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : age_67 (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : age_68 (Amount)
           77 => ( Parameter_Float, 0.0 ),   --  : age_69 (Amount)
           78 => ( Parameter_Float, 0.0 ),   --  : age_70 (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : age_71 (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : age_72 (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : age_73 (Amount)
           82 => ( Parameter_Float, 0.0 ),   --  : age_74 (Amount)
           83 => ( Parameter_Float, 0.0 ),   --  : age_75 (Amount)
           84 => ( Parameter_Float, 0.0 ),   --  : age_76 (Amount)
           85 => ( Parameter_Float, 0.0 ),   --  : age_77 (Amount)
           86 => ( Parameter_Float, 0.0 ),   --  : age_78 (Amount)
           87 => ( Parameter_Float, 0.0 ),   --  : age_79 (Amount)
           88 => ( Parameter_Float, 0.0 ),   --  : age_80 (Amount)
           89 => ( Parameter_Float, 0.0 ),   --  : age_81 (Amount)
           90 => ( Parameter_Float, 0.0 ),   --  : age_82 (Amount)
           91 => ( Parameter_Float, 0.0 ),   --  : age_83 (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : age_84 (Amount)
           93 => ( Parameter_Float, 0.0 ),   --  : age_85 (Amount)
           94 => ( Parameter_Float, 0.0 ),   --  : age_86 (Amount)
           95 => ( Parameter_Float, 0.0 ),   --  : age_87 (Amount)
           96 => ( Parameter_Float, 0.0 ),   --  : age_88 (Amount)
           97 => ( Parameter_Float, 0.0 ),   --  : age_89 (Amount)
           98 => ( Parameter_Float, 0.0 ),   --  : age_90 (Amount)
           99 => ( Parameter_Float, 0.0 ),   --  : age_91 (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : age_92 (Amount)
           101 => ( Parameter_Float, 0.0 ),   --  : age_93 (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : age_94 (Amount)
           103 => ( Parameter_Float, 0.0 ),   --  : age_95 (Amount)
           104 => ( Parameter_Float, 0.0 ),   --  : age_96 (Amount)
           105 => ( Parameter_Float, 0.0 ),   --  : age_97 (Amount)
           106 => ( Parameter_Float, 0.0 ),   --  : age_98 (Amount)
           107 => ( Parameter_Float, 0.0 ),   --  : age_99 (Amount)
           108 => ( Parameter_Float, 0.0 ),   --  : age_100 (Amount)
           109 => ( Parameter_Float, 0.0 ),   --  : age_101 (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : age_102 (Amount)
           111 => ( Parameter_Float, 0.0 ),   --  : age_103 (Amount)
           112 => ( Parameter_Float, 0.0 ),   --  : age_104 (Amount)
           113 => ( Parameter_Float, 0.0 ),   --  : age_105 (Amount)
           114 => ( Parameter_Float, 0.0 ),   --  : age_106 (Amount)
           115 => ( Parameter_Float, 0.0 ),   --  : age_107 (Amount)
           116 => ( Parameter_Float, 0.0 ),   --  : age_108 (Amount)
           117 => ( Parameter_Float, 0.0 ),   --  : age_109 (Amount)
           118 => ( Parameter_Float, 0.0 )   --  : age_110 (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 6 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            2 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : rec_type (Unbounded_String)
            3 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : variant (Unbounded_String)
            4 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : country (Unbounded_String)
            5 => ( Parameter_Integer, 0 ),   --  : edition (Year_Number)
            6 => ( Parameter_Text, null, Null_Unbounded_String )   --  : target_group (Unbounded_String)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5 and target_group = $6"; 
   begin 
      return Get_Prepared_Retrieve_Statement( s ); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return gse.Prepared_Statement is 
   begin 
      return Get_Prepared_Retrieve_Statement( d.To_String( crit )); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) & sqlstr; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Retrieve_Statement; 


   function Get_Prepared_Update_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " all_ages = $1, age_0 = $2, age_1 = $3, age_2 = $4, age_3 = $5, age_4 = $6, age_5 = $7, age_6 = $8, age_7 = $9, age_8 = $10, age_9 = $11, age_10 = $12, age_11 = $13, age_12 = $14, age_13 = $15, age_14 = $16, age_15 = $17, age_16 = $18, age_17 = $19, age_18 = $20, age_19 = $21, age_20 = $22, age_21 = $23, age_22 = $24, age_23 = $25, age_24 = $26, age_25 = $27, age_26 = $28, age_27 = $29, age_28 = $30, age_29 = $31, age_30 = $32, age_31 = $33, age_32 = $34, age_33 = $35, age_34 = $36, age_35 = $37, age_36 = $38, age_37 = $39, age_38 = $40, age_39 = $41, age_40 = $42, age_41 = $43, age_42 = $44, age_43 = $45, age_44 = $46, age_45 = $47, age_46 = $48, age_47 = $49, age_48 = $50, age_49 = $51, age_50 = $52, age_51 = $53, age_52 = $54, age_53 = $55, age_54 = $56, age_55 = $57, age_56 = $58, age_57 = $59, age_58 = $60, age_59 = $61, age_60 = $62, age_61 = $63, age_62 = $64, age_63 = $65, age_64 = $66, age_65 = $67, age_66 = $68, age_67 = $69, age_68 = $70, age_69 = $71, age_70 = $72, age_71 = $73, age_72 = $74, age_73 = $75, age_74 = $76, age_75 = $77, age_76 = $78, age_77 = $79, age_78 = $80, age_79 = $81, age_80 = $82, age_81 = $83, age_82 = $84, age_83 = $85, age_84 = $86, age_85 = $87, age_86 = $88, age_87 = $89, age_88 = $90, age_89 = $91, age_90 = $92, age_91 = $93, age_92 = $94, age_93 = $95, age_94 = $96, age_95 = $97, age_96 = $98, age_97 = $99, age_98 = $100, age_99 = $101, age_100 = $102, age_101 = $103, age_102 = $104, age_103 = $105, age_104 = $106, age_105 = $107, age_106 = $108, age_107 = $109, age_108 = $110, age_109 = $111, age_110 = $112 where year = $113 and rec_type = $114 and variant = $115 and country = $116 and edition = $117 and target_group = $118"; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Update_Statement; 


   
   
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     


   
   Next_Free_year_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from target_data.population_forecasts", SCHEMA_NAME );
   Next_Free_year_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_year_query, On_Server => True );
   -- 
   -- Next highest avaiable value of year - useful for saving  
   --
   function Next_Free_year( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_year;


   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from target_data.population_forecasts", SCHEMA_NAME );
   Next_Free_edition_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_edition_query, On_Server => True );
   -- 
   -- Next highest avaiable value of edition - useful for saving  
   --
   function Next_Free_edition( connection : Database_Connection := null) return Year_Number is
      cursor              : gse.Forward_Cursor;
      ai                  : Year_Number;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_edition_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Year_Number'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_edition;



   --
   -- returns true if the primary key parts of Ukds.Target_Data.Population_Forecasts match the defaults in Ukds.Target_Data.Null_Population_Forecasts
   --
   --
   -- Does this Ukds.Target_Data.Population_Forecasts equal the default Ukds.Target_Data.Null_Population_Forecasts ?
   --
   function Is_Null( a_population_forecasts : Population_Forecasts ) return Boolean is
   begin
      return a_population_forecasts = Ukds.Target_Data.Null_Population_Forecasts;
   end Is_Null;


   
   --
   -- returns the single Ukds.Target_Data.Population_Forecasts matching the primary key fields, or the Ukds.Target_Data.Null_Population_Forecasts record
   -- if no such record exists
   --
   function Retrieve_By_PK( year : Integer; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts is
      l : Ukds.Target_Data.Population_Forecasts_List;
      a_population_forecasts : Ukds.Target_Data.Population_Forecasts;
      c : d.Criteria;
   begin      
      Add_year( c, year );
      Add_rec_type( c, rec_type );
      Add_variant( c, variant );
      Add_country( c, country );
      Add_edition( c, edition );
      Add_target_group( c, target_group );
      l := Retrieve( c, connection );
      if( not Ukds.Target_Data.Population_Forecasts_List_Package.is_empty( l ) ) then
         a_population_forecasts := Ukds.Target_Data.Population_Forecasts_List_Package.First_Element( l );
      else
         a_population_forecasts := Ukds.Target_Data.Null_Population_Forecasts;
      end if;
      return a_population_forecasts;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from target_data.population_forecasts where year = $1 and rec_type = $2 and variant = $3 and country = $4 and edition = $5 and target_group = $6", 
        On_Server => True );
        
   function Exists( year : Integer; rec_type : Unbounded_String; variant : Unbounded_String; country : Unbounded_String; edition : Year_Number; target_group : Unbounded_String; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      aliased_rec_type : aliased String := To_String( rec_type );
      aliased_variant : aliased String := To_String( variant );
      aliased_country : aliased String := To_String( country );
      aliased_target_group : aliased String := To_String( target_group );
      cursor : gse.Forward_Cursor;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      found : Boolean;        
   begin 
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      params( 1 ) := "+"( Integer'Pos( year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( edition ));
      params( 6 ) := "+"( aliased_target_group'Access );
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Population_Forecasts matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Population_Forecasts retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Target_Data.Population_Forecasts is
      a_population_forecasts : Ukds.Target_Data.Population_Forecasts;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_population_forecasts.year := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_population_forecasts.rec_type:= To_Unbounded_String( gse.Value( cursor, 1 ));
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_population_forecasts.variant:= To_Unbounded_String( gse.Value( cursor, 2 ));
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_population_forecasts.country:= To_Unbounded_String( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_population_forecasts.edition := Year_Number'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_population_forecasts.target_group:= To_Unbounded_String( gse.Value( cursor, 5 ));
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_population_forecasts.all_ages:= Amount'Value( gse.Value( cursor, 6 ));
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_population_forecasts.age_0:= Amount'Value( gse.Value( cursor, 7 ));
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_population_forecasts.age_1:= Amount'Value( gse.Value( cursor, 8 ));
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_population_forecasts.age_2:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_population_forecasts.age_3:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_population_forecasts.age_4:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_population_forecasts.age_5:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_population_forecasts.age_6:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_population_forecasts.age_7:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_population_forecasts.age_8:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_population_forecasts.age_9:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_population_forecasts.age_10:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_population_forecasts.age_11:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_population_forecasts.age_12:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_population_forecasts.age_13:= Amount'Value( gse.Value( cursor, 20 ));
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_population_forecasts.age_14:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_population_forecasts.age_15:= Amount'Value( gse.Value( cursor, 22 ));
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_population_forecasts.age_16:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_population_forecasts.age_17:= Amount'Value( gse.Value( cursor, 24 ));
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_population_forecasts.age_18:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_population_forecasts.age_19:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_population_forecasts.age_20:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_population_forecasts.age_21:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_population_forecasts.age_22:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_population_forecasts.age_23:= Amount'Value( gse.Value( cursor, 30 ));
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_population_forecasts.age_24:= Amount'Value( gse.Value( cursor, 31 ));
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_population_forecasts.age_25:= Amount'Value( gse.Value( cursor, 32 ));
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_population_forecasts.age_26:= Amount'Value( gse.Value( cursor, 33 ));
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_population_forecasts.age_27:= Amount'Value( gse.Value( cursor, 34 ));
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_population_forecasts.age_28:= Amount'Value( gse.Value( cursor, 35 ));
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_population_forecasts.age_29:= Amount'Value( gse.Value( cursor, 36 ));
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_population_forecasts.age_30:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_population_forecasts.age_31:= Amount'Value( gse.Value( cursor, 38 ));
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_population_forecasts.age_32:= Amount'Value( gse.Value( cursor, 39 ));
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_population_forecasts.age_33:= Amount'Value( gse.Value( cursor, 40 ));
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_population_forecasts.age_34:= Amount'Value( gse.Value( cursor, 41 ));
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_population_forecasts.age_35:= Amount'Value( gse.Value( cursor, 42 ));
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_population_forecasts.age_36:= Amount'Value( gse.Value( cursor, 43 ));
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_population_forecasts.age_37:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_population_forecasts.age_38:= Amount'Value( gse.Value( cursor, 45 ));
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_population_forecasts.age_39:= Amount'Value( gse.Value( cursor, 46 ));
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_population_forecasts.age_40:= Amount'Value( gse.Value( cursor, 47 ));
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_population_forecasts.age_41:= Amount'Value( gse.Value( cursor, 48 ));
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_population_forecasts.age_42:= Amount'Value( gse.Value( cursor, 49 ));
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_population_forecasts.age_43:= Amount'Value( gse.Value( cursor, 50 ));
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_population_forecasts.age_44:= Amount'Value( gse.Value( cursor, 51 ));
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_population_forecasts.age_45:= Amount'Value( gse.Value( cursor, 52 ));
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_population_forecasts.age_46:= Amount'Value( gse.Value( cursor, 53 ));
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_population_forecasts.age_47:= Amount'Value( gse.Value( cursor, 54 ));
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_population_forecasts.age_48:= Amount'Value( gse.Value( cursor, 55 ));
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_population_forecasts.age_49:= Amount'Value( gse.Value( cursor, 56 ));
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_population_forecasts.age_50:= Amount'Value( gse.Value( cursor, 57 ));
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_population_forecasts.age_51:= Amount'Value( gse.Value( cursor, 58 ));
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_population_forecasts.age_52:= Amount'Value( gse.Value( cursor, 59 ));
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_population_forecasts.age_53:= Amount'Value( gse.Value( cursor, 60 ));
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_population_forecasts.age_54:= Amount'Value( gse.Value( cursor, 61 ));
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_population_forecasts.age_55:= Amount'Value( gse.Value( cursor, 62 ));
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_population_forecasts.age_56:= Amount'Value( gse.Value( cursor, 63 ));
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_population_forecasts.age_57:= Amount'Value( gse.Value( cursor, 64 ));
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_population_forecasts.age_58:= Amount'Value( gse.Value( cursor, 65 ));
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_population_forecasts.age_59:= Amount'Value( gse.Value( cursor, 66 ));
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_population_forecasts.age_60:= Amount'Value( gse.Value( cursor, 67 ));
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_population_forecasts.age_61:= Amount'Value( gse.Value( cursor, 68 ));
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_population_forecasts.age_62:= Amount'Value( gse.Value( cursor, 69 ));
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_population_forecasts.age_63:= Amount'Value( gse.Value( cursor, 70 ));
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_population_forecasts.age_64:= Amount'Value( gse.Value( cursor, 71 ));
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_population_forecasts.age_65:= Amount'Value( gse.Value( cursor, 72 ));
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_population_forecasts.age_66:= Amount'Value( gse.Value( cursor, 73 ));
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_population_forecasts.age_67:= Amount'Value( gse.Value( cursor, 74 ));
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_population_forecasts.age_68:= Amount'Value( gse.Value( cursor, 75 ));
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_population_forecasts.age_69:= Amount'Value( gse.Value( cursor, 76 ));
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_population_forecasts.age_70:= Amount'Value( gse.Value( cursor, 77 ));
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_population_forecasts.age_71:= Amount'Value( gse.Value( cursor, 78 ));
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_population_forecasts.age_72:= Amount'Value( gse.Value( cursor, 79 ));
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_population_forecasts.age_73:= Amount'Value( gse.Value( cursor, 80 ));
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_population_forecasts.age_74:= Amount'Value( gse.Value( cursor, 81 ));
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_population_forecasts.age_75:= Amount'Value( gse.Value( cursor, 82 ));
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_population_forecasts.age_76:= Amount'Value( gse.Value( cursor, 83 ));
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_population_forecasts.age_77:= Amount'Value( gse.Value( cursor, 84 ));
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_population_forecasts.age_78:= Amount'Value( gse.Value( cursor, 85 ));
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_population_forecasts.age_79:= Amount'Value( gse.Value( cursor, 86 ));
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_population_forecasts.age_80:= Amount'Value( gse.Value( cursor, 87 ));
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_population_forecasts.age_81:= Amount'Value( gse.Value( cursor, 88 ));
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_population_forecasts.age_82:= Amount'Value( gse.Value( cursor, 89 ));
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_population_forecasts.age_83:= Amount'Value( gse.Value( cursor, 90 ));
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_population_forecasts.age_84:= Amount'Value( gse.Value( cursor, 91 ));
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_population_forecasts.age_85:= Amount'Value( gse.Value( cursor, 92 ));
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_population_forecasts.age_86:= Amount'Value( gse.Value( cursor, 93 ));
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_population_forecasts.age_87:= Amount'Value( gse.Value( cursor, 94 ));
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_population_forecasts.age_88:= Amount'Value( gse.Value( cursor, 95 ));
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_population_forecasts.age_89:= Amount'Value( gse.Value( cursor, 96 ));
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_population_forecasts.age_90:= Amount'Value( gse.Value( cursor, 97 ));
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_population_forecasts.age_91:= Amount'Value( gse.Value( cursor, 98 ));
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_population_forecasts.age_92:= Amount'Value( gse.Value( cursor, 99 ));
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_population_forecasts.age_93:= Amount'Value( gse.Value( cursor, 100 ));
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_population_forecasts.age_94:= Amount'Value( gse.Value( cursor, 101 ));
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_population_forecasts.age_95:= Amount'Value( gse.Value( cursor, 102 ));
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_population_forecasts.age_96:= Amount'Value( gse.Value( cursor, 103 ));
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_population_forecasts.age_97:= Amount'Value( gse.Value( cursor, 104 ));
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_population_forecasts.age_98:= Amount'Value( gse.Value( cursor, 105 ));
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_population_forecasts.age_99:= Amount'Value( gse.Value( cursor, 106 ));
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_population_forecasts.age_100:= Amount'Value( gse.Value( cursor, 107 ));
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_population_forecasts.age_101:= Amount'Value( gse.Value( cursor, 108 ));
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_population_forecasts.age_102:= Amount'Value( gse.Value( cursor, 109 ));
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_population_forecasts.age_103:= Amount'Value( gse.Value( cursor, 110 ));
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_population_forecasts.age_104:= Amount'Value( gse.Value( cursor, 111 ));
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_population_forecasts.age_105:= Amount'Value( gse.Value( cursor, 112 ));
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_population_forecasts.age_106:= Amount'Value( gse.Value( cursor, 113 ));
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_population_forecasts.age_107:= Amount'Value( gse.Value( cursor, 114 ));
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_population_forecasts.age_108:= Amount'Value( gse.Value( cursor, 115 ));
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_population_forecasts.age_109:= Amount'Value( gse.Value( cursor, 116 ));
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_population_forecasts.age_110:= Amount'Value( gse.Value( cursor, 117 ));
      end if;
      return a_population_forecasts;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Target_Data.Population_Forecasts_List is
      l : Ukds.Target_Data.Population_Forecasts_List;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) 
         & " " & sqlstr;
      cursor   : gse.Forward_Cursor;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "retrieve made this as query " & query );
      cursor.Fetch( local_connection, query );
      Check_Result( local_connection );
      while gse.Has_Row( cursor ) loop
         declare
            a_population_forecasts : Ukds.Target_Data.Population_Forecasts := Map_From_Cursor( cursor );
         begin
            l.append( a_population_forecasts ); 
         end;
         gse.Next( cursor );
      end loop;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --

   UPDATE_PS : constant gse.Prepared_Statement := Get_Prepared_Update_Statement;
   
   procedure Update( a_population_forecasts : Ukds.Target_Data.Population_Forecasts; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_population_forecasts.rec_type );
      aliased_variant : aliased String := To_String( a_population_forecasts.variant );
      aliased_country : aliased String := To_String( a_population_forecasts.country );
      aliased_target_group : aliased String := To_String( a_population_forecasts.target_group );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Float( a_population_forecasts.all_ages ));
      params( 2 ) := "+"( Float( a_population_forecasts.age_0 ));
      params( 3 ) := "+"( Float( a_population_forecasts.age_1 ));
      params( 4 ) := "+"( Float( a_population_forecasts.age_2 ));
      params( 5 ) := "+"( Float( a_population_forecasts.age_3 ));
      params( 6 ) := "+"( Float( a_population_forecasts.age_4 ));
      params( 7 ) := "+"( Float( a_population_forecasts.age_5 ));
      params( 8 ) := "+"( Float( a_population_forecasts.age_6 ));
      params( 9 ) := "+"( Float( a_population_forecasts.age_7 ));
      params( 10 ) := "+"( Float( a_population_forecasts.age_8 ));
      params( 11 ) := "+"( Float( a_population_forecasts.age_9 ));
      params( 12 ) := "+"( Float( a_population_forecasts.age_10 ));
      params( 13 ) := "+"( Float( a_population_forecasts.age_11 ));
      params( 14 ) := "+"( Float( a_population_forecasts.age_12 ));
      params( 15 ) := "+"( Float( a_population_forecasts.age_13 ));
      params( 16 ) := "+"( Float( a_population_forecasts.age_14 ));
      params( 17 ) := "+"( Float( a_population_forecasts.age_15 ));
      params( 18 ) := "+"( Float( a_population_forecasts.age_16 ));
      params( 19 ) := "+"( Float( a_population_forecasts.age_17 ));
      params( 20 ) := "+"( Float( a_population_forecasts.age_18 ));
      params( 21 ) := "+"( Float( a_population_forecasts.age_19 ));
      params( 22 ) := "+"( Float( a_population_forecasts.age_20 ));
      params( 23 ) := "+"( Float( a_population_forecasts.age_21 ));
      params( 24 ) := "+"( Float( a_population_forecasts.age_22 ));
      params( 25 ) := "+"( Float( a_population_forecasts.age_23 ));
      params( 26 ) := "+"( Float( a_population_forecasts.age_24 ));
      params( 27 ) := "+"( Float( a_population_forecasts.age_25 ));
      params( 28 ) := "+"( Float( a_population_forecasts.age_26 ));
      params( 29 ) := "+"( Float( a_population_forecasts.age_27 ));
      params( 30 ) := "+"( Float( a_population_forecasts.age_28 ));
      params( 31 ) := "+"( Float( a_population_forecasts.age_29 ));
      params( 32 ) := "+"( Float( a_population_forecasts.age_30 ));
      params( 33 ) := "+"( Float( a_population_forecasts.age_31 ));
      params( 34 ) := "+"( Float( a_population_forecasts.age_32 ));
      params( 35 ) := "+"( Float( a_population_forecasts.age_33 ));
      params( 36 ) := "+"( Float( a_population_forecasts.age_34 ));
      params( 37 ) := "+"( Float( a_population_forecasts.age_35 ));
      params( 38 ) := "+"( Float( a_population_forecasts.age_36 ));
      params( 39 ) := "+"( Float( a_population_forecasts.age_37 ));
      params( 40 ) := "+"( Float( a_population_forecasts.age_38 ));
      params( 41 ) := "+"( Float( a_population_forecasts.age_39 ));
      params( 42 ) := "+"( Float( a_population_forecasts.age_40 ));
      params( 43 ) := "+"( Float( a_population_forecasts.age_41 ));
      params( 44 ) := "+"( Float( a_population_forecasts.age_42 ));
      params( 45 ) := "+"( Float( a_population_forecasts.age_43 ));
      params( 46 ) := "+"( Float( a_population_forecasts.age_44 ));
      params( 47 ) := "+"( Float( a_population_forecasts.age_45 ));
      params( 48 ) := "+"( Float( a_population_forecasts.age_46 ));
      params( 49 ) := "+"( Float( a_population_forecasts.age_47 ));
      params( 50 ) := "+"( Float( a_population_forecasts.age_48 ));
      params( 51 ) := "+"( Float( a_population_forecasts.age_49 ));
      params( 52 ) := "+"( Float( a_population_forecasts.age_50 ));
      params( 53 ) := "+"( Float( a_population_forecasts.age_51 ));
      params( 54 ) := "+"( Float( a_population_forecasts.age_52 ));
      params( 55 ) := "+"( Float( a_population_forecasts.age_53 ));
      params( 56 ) := "+"( Float( a_population_forecasts.age_54 ));
      params( 57 ) := "+"( Float( a_population_forecasts.age_55 ));
      params( 58 ) := "+"( Float( a_population_forecasts.age_56 ));
      params( 59 ) := "+"( Float( a_population_forecasts.age_57 ));
      params( 60 ) := "+"( Float( a_population_forecasts.age_58 ));
      params( 61 ) := "+"( Float( a_population_forecasts.age_59 ));
      params( 62 ) := "+"( Float( a_population_forecasts.age_60 ));
      params( 63 ) := "+"( Float( a_population_forecasts.age_61 ));
      params( 64 ) := "+"( Float( a_population_forecasts.age_62 ));
      params( 65 ) := "+"( Float( a_population_forecasts.age_63 ));
      params( 66 ) := "+"( Float( a_population_forecasts.age_64 ));
      params( 67 ) := "+"( Float( a_population_forecasts.age_65 ));
      params( 68 ) := "+"( Float( a_population_forecasts.age_66 ));
      params( 69 ) := "+"( Float( a_population_forecasts.age_67 ));
      params( 70 ) := "+"( Float( a_population_forecasts.age_68 ));
      params( 71 ) := "+"( Float( a_population_forecasts.age_69 ));
      params( 72 ) := "+"( Float( a_population_forecasts.age_70 ));
      params( 73 ) := "+"( Float( a_population_forecasts.age_71 ));
      params( 74 ) := "+"( Float( a_population_forecasts.age_72 ));
      params( 75 ) := "+"( Float( a_population_forecasts.age_73 ));
      params( 76 ) := "+"( Float( a_population_forecasts.age_74 ));
      params( 77 ) := "+"( Float( a_population_forecasts.age_75 ));
      params( 78 ) := "+"( Float( a_population_forecasts.age_76 ));
      params( 79 ) := "+"( Float( a_population_forecasts.age_77 ));
      params( 80 ) := "+"( Float( a_population_forecasts.age_78 ));
      params( 81 ) := "+"( Float( a_population_forecasts.age_79 ));
      params( 82 ) := "+"( Float( a_population_forecasts.age_80 ));
      params( 83 ) := "+"( Float( a_population_forecasts.age_81 ));
      params( 84 ) := "+"( Float( a_population_forecasts.age_82 ));
      params( 85 ) := "+"( Float( a_population_forecasts.age_83 ));
      params( 86 ) := "+"( Float( a_population_forecasts.age_84 ));
      params( 87 ) := "+"( Float( a_population_forecasts.age_85 ));
      params( 88 ) := "+"( Float( a_population_forecasts.age_86 ));
      params( 89 ) := "+"( Float( a_population_forecasts.age_87 ));
      params( 90 ) := "+"( Float( a_population_forecasts.age_88 ));
      params( 91 ) := "+"( Float( a_population_forecasts.age_89 ));
      params( 92 ) := "+"( Float( a_population_forecasts.age_90 ));
      params( 93 ) := "+"( Float( a_population_forecasts.age_91 ));
      params( 94 ) := "+"( Float( a_population_forecasts.age_92 ));
      params( 95 ) := "+"( Float( a_population_forecasts.age_93 ));
      params( 96 ) := "+"( Float( a_population_forecasts.age_94 ));
      params( 97 ) := "+"( Float( a_population_forecasts.age_95 ));
      params( 98 ) := "+"( Float( a_population_forecasts.age_96 ));
      params( 99 ) := "+"( Float( a_population_forecasts.age_97 ));
      params( 100 ) := "+"( Float( a_population_forecasts.age_98 ));
      params( 101 ) := "+"( Float( a_population_forecasts.age_99 ));
      params( 102 ) := "+"( Float( a_population_forecasts.age_100 ));
      params( 103 ) := "+"( Float( a_population_forecasts.age_101 ));
      params( 104 ) := "+"( Float( a_population_forecasts.age_102 ));
      params( 105 ) := "+"( Float( a_population_forecasts.age_103 ));
      params( 106 ) := "+"( Float( a_population_forecasts.age_104 ));
      params( 107 ) := "+"( Float( a_population_forecasts.age_105 ));
      params( 108 ) := "+"( Float( a_population_forecasts.age_106 ));
      params( 109 ) := "+"( Float( a_population_forecasts.age_107 ));
      params( 110 ) := "+"( Float( a_population_forecasts.age_108 ));
      params( 111 ) := "+"( Float( a_population_forecasts.age_109 ));
      params( 112 ) := "+"( Float( a_population_forecasts.age_110 ));
      params( 113 ) := "+"( Integer'Pos( a_population_forecasts.year ));
      params( 114 ) := "+"( aliased_rec_type'Access );
      params( 115 ) := "+"( aliased_variant'Access );
      params( 116 ) := "+"( aliased_country'Access );
      params( 117 ) := "+"( Year_Number'Pos( a_population_forecasts.edition ));
      params( 118 ) := "+"( aliased_target_group'Access );
      
      gse.Execute( local_connection, UPDATE_PS, params );
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   SAVE_PS : constant gse.Prepared_Statement := Get_Prepared_Insert_Statement;      

   procedure Save( a_population_forecasts : Ukds.Target_Data.Population_Forecasts; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_rec_type : aliased String := To_String( a_population_forecasts.rec_type );
      aliased_variant : aliased String := To_String( a_population_forecasts.variant );
      aliased_country : aliased String := To_String( a_population_forecasts.country );
      aliased_target_group : aliased String := To_String( a_population_forecasts.target_group );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_population_forecasts.year, a_population_forecasts.rec_type, a_population_forecasts.variant, a_population_forecasts.country, a_population_forecasts.edition, a_population_forecasts.target_group ) then
         Update( a_population_forecasts, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_population_forecasts.year ));
      params( 2 ) := "+"( aliased_rec_type'Access );
      params( 3 ) := "+"( aliased_variant'Access );
      params( 4 ) := "+"( aliased_country'Access );
      params( 5 ) := "+"( Year_Number'Pos( a_population_forecasts.edition ));
      params( 6 ) := "+"( aliased_target_group'Access );
      params( 7 ) := "+"( Float( a_population_forecasts.all_ages ));
      params( 8 ) := "+"( Float( a_population_forecasts.age_0 ));
      params( 9 ) := "+"( Float( a_population_forecasts.age_1 ));
      params( 10 ) := "+"( Float( a_population_forecasts.age_2 ));
      params( 11 ) := "+"( Float( a_population_forecasts.age_3 ));
      params( 12 ) := "+"( Float( a_population_forecasts.age_4 ));
      params( 13 ) := "+"( Float( a_population_forecasts.age_5 ));
      params( 14 ) := "+"( Float( a_population_forecasts.age_6 ));
      params( 15 ) := "+"( Float( a_population_forecasts.age_7 ));
      params( 16 ) := "+"( Float( a_population_forecasts.age_8 ));
      params( 17 ) := "+"( Float( a_population_forecasts.age_9 ));
      params( 18 ) := "+"( Float( a_population_forecasts.age_10 ));
      params( 19 ) := "+"( Float( a_population_forecasts.age_11 ));
      params( 20 ) := "+"( Float( a_population_forecasts.age_12 ));
      params( 21 ) := "+"( Float( a_population_forecasts.age_13 ));
      params( 22 ) := "+"( Float( a_population_forecasts.age_14 ));
      params( 23 ) := "+"( Float( a_population_forecasts.age_15 ));
      params( 24 ) := "+"( Float( a_population_forecasts.age_16 ));
      params( 25 ) := "+"( Float( a_population_forecasts.age_17 ));
      params( 26 ) := "+"( Float( a_population_forecasts.age_18 ));
      params( 27 ) := "+"( Float( a_population_forecasts.age_19 ));
      params( 28 ) := "+"( Float( a_population_forecasts.age_20 ));
      params( 29 ) := "+"( Float( a_population_forecasts.age_21 ));
      params( 30 ) := "+"( Float( a_population_forecasts.age_22 ));
      params( 31 ) := "+"( Float( a_population_forecasts.age_23 ));
      params( 32 ) := "+"( Float( a_population_forecasts.age_24 ));
      params( 33 ) := "+"( Float( a_population_forecasts.age_25 ));
      params( 34 ) := "+"( Float( a_population_forecasts.age_26 ));
      params( 35 ) := "+"( Float( a_population_forecasts.age_27 ));
      params( 36 ) := "+"( Float( a_population_forecasts.age_28 ));
      params( 37 ) := "+"( Float( a_population_forecasts.age_29 ));
      params( 38 ) := "+"( Float( a_population_forecasts.age_30 ));
      params( 39 ) := "+"( Float( a_population_forecasts.age_31 ));
      params( 40 ) := "+"( Float( a_population_forecasts.age_32 ));
      params( 41 ) := "+"( Float( a_population_forecasts.age_33 ));
      params( 42 ) := "+"( Float( a_population_forecasts.age_34 ));
      params( 43 ) := "+"( Float( a_population_forecasts.age_35 ));
      params( 44 ) := "+"( Float( a_population_forecasts.age_36 ));
      params( 45 ) := "+"( Float( a_population_forecasts.age_37 ));
      params( 46 ) := "+"( Float( a_population_forecasts.age_38 ));
      params( 47 ) := "+"( Float( a_population_forecasts.age_39 ));
      params( 48 ) := "+"( Float( a_population_forecasts.age_40 ));
      params( 49 ) := "+"( Float( a_population_forecasts.age_41 ));
      params( 50 ) := "+"( Float( a_population_forecasts.age_42 ));
      params( 51 ) := "+"( Float( a_population_forecasts.age_43 ));
      params( 52 ) := "+"( Float( a_population_forecasts.age_44 ));
      params( 53 ) := "+"( Float( a_population_forecasts.age_45 ));
      params( 54 ) := "+"( Float( a_population_forecasts.age_46 ));
      params( 55 ) := "+"( Float( a_population_forecasts.age_47 ));
      params( 56 ) := "+"( Float( a_population_forecasts.age_48 ));
      params( 57 ) := "+"( Float( a_population_forecasts.age_49 ));
      params( 58 ) := "+"( Float( a_population_forecasts.age_50 ));
      params( 59 ) := "+"( Float( a_population_forecasts.age_51 ));
      params( 60 ) := "+"( Float( a_population_forecasts.age_52 ));
      params( 61 ) := "+"( Float( a_population_forecasts.age_53 ));
      params( 62 ) := "+"( Float( a_population_forecasts.age_54 ));
      params( 63 ) := "+"( Float( a_population_forecasts.age_55 ));
      params( 64 ) := "+"( Float( a_population_forecasts.age_56 ));
      params( 65 ) := "+"( Float( a_population_forecasts.age_57 ));
      params( 66 ) := "+"( Float( a_population_forecasts.age_58 ));
      params( 67 ) := "+"( Float( a_population_forecasts.age_59 ));
      params( 68 ) := "+"( Float( a_population_forecasts.age_60 ));
      params( 69 ) := "+"( Float( a_population_forecasts.age_61 ));
      params( 70 ) := "+"( Float( a_population_forecasts.age_62 ));
      params( 71 ) := "+"( Float( a_population_forecasts.age_63 ));
      params( 72 ) := "+"( Float( a_population_forecasts.age_64 ));
      params( 73 ) := "+"( Float( a_population_forecasts.age_65 ));
      params( 74 ) := "+"( Float( a_population_forecasts.age_66 ));
      params( 75 ) := "+"( Float( a_population_forecasts.age_67 ));
      params( 76 ) := "+"( Float( a_population_forecasts.age_68 ));
      params( 77 ) := "+"( Float( a_population_forecasts.age_69 ));
      params( 78 ) := "+"( Float( a_population_forecasts.age_70 ));
      params( 79 ) := "+"( Float( a_population_forecasts.age_71 ));
      params( 80 ) := "+"( Float( a_population_forecasts.age_72 ));
      params( 81 ) := "+"( Float( a_population_forecasts.age_73 ));
      params( 82 ) := "+"( Float( a_population_forecasts.age_74 ));
      params( 83 ) := "+"( Float( a_population_forecasts.age_75 ));
      params( 84 ) := "+"( Float( a_population_forecasts.age_76 ));
      params( 85 ) := "+"( Float( a_population_forecasts.age_77 ));
      params( 86 ) := "+"( Float( a_population_forecasts.age_78 ));
      params( 87 ) := "+"( Float( a_population_forecasts.age_79 ));
      params( 88 ) := "+"( Float( a_population_forecasts.age_80 ));
      params( 89 ) := "+"( Float( a_population_forecasts.age_81 ));
      params( 90 ) := "+"( Float( a_population_forecasts.age_82 ));
      params( 91 ) := "+"( Float( a_population_forecasts.age_83 ));
      params( 92 ) := "+"( Float( a_population_forecasts.age_84 ));
      params( 93 ) := "+"( Float( a_population_forecasts.age_85 ));
      params( 94 ) := "+"( Float( a_population_forecasts.age_86 ));
      params( 95 ) := "+"( Float( a_population_forecasts.age_87 ));
      params( 96 ) := "+"( Float( a_population_forecasts.age_88 ));
      params( 97 ) := "+"( Float( a_population_forecasts.age_89 ));
      params( 98 ) := "+"( Float( a_population_forecasts.age_90 ));
      params( 99 ) := "+"( Float( a_population_forecasts.age_91 ));
      params( 100 ) := "+"( Float( a_population_forecasts.age_92 ));
      params( 101 ) := "+"( Float( a_population_forecasts.age_93 ));
      params( 102 ) := "+"( Float( a_population_forecasts.age_94 ));
      params( 103 ) := "+"( Float( a_population_forecasts.age_95 ));
      params( 104 ) := "+"( Float( a_population_forecasts.age_96 ));
      params( 105 ) := "+"( Float( a_population_forecasts.age_97 ));
      params( 106 ) := "+"( Float( a_population_forecasts.age_98 ));
      params( 107 ) := "+"( Float( a_population_forecasts.age_99 ));
      params( 108 ) := "+"( Float( a_population_forecasts.age_100 ));
      params( 109 ) := "+"( Float( a_population_forecasts.age_101 ));
      params( 110 ) := "+"( Float( a_population_forecasts.age_102 ));
      params( 111 ) := "+"( Float( a_population_forecasts.age_103 ));
      params( 112 ) := "+"( Float( a_population_forecasts.age_104 ));
      params( 113 ) := "+"( Float( a_population_forecasts.age_105 ));
      params( 114 ) := "+"( Float( a_population_forecasts.age_106 ));
      params( 115 ) := "+"( Float( a_population_forecasts.age_107 ));
      params( 116 ) := "+"( Float( a_population_forecasts.age_108 ));
      params( 117 ) := "+"( Float( a_population_forecasts.age_109 ));
      params( 118 ) := "+"( Float( a_population_forecasts.age_110 ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Target_Data.Null_Population_Forecasts
   --

   procedure Delete( a_population_forecasts : in out Ukds.Target_Data.Population_Forecasts; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_year( c, a_population_forecasts.year );
      Add_rec_type( c, a_population_forecasts.rec_type );
      Add_variant( c, a_population_forecasts.variant );
      Add_country( c, a_population_forecasts.country );
      Add_edition( c, a_population_forecasts.edition );
      Add_target_group( c, a_population_forecasts.target_group );
      Delete( c, connection );
      a_population_forecasts := Ukds.Target_Data.Null_Population_Forecasts;
      Log( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null ) is
   begin      
      delete( d.to_string( c ), connection );
      Log( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_clause : String; connection : gse.Database_Connection := null ) is
      local_connection : gse.Database_Connection;     
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( DELETE_PART, SCHEMA_NAME ) & where_clause;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "delete; executing query" & query );
      gse.Execute( local_connection, query );
      Check_Result( local_connection );
      Log( "delete; execute query OK" );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, year );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, To_String( rec_type ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_rec_type( c : in out d.Criteria; rec_type : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rec_type", op, join, rec_type );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type;


   procedure Add_variant( c : in out d.Criteria; variant : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "variant", op, join, To_String( variant ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant;


   procedure Add_variant( c : in out d.Criteria; variant : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "variant", op, join, variant, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant;


   procedure Add_country( c : in out d.Criteria; country : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, To_String( country ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_country( c : in out d.Criteria; country : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, country, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_edition( c : in out d.Criteria; edition : Year_Number; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edition", op, join, Integer( edition ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition;


   procedure Add_target_group( c : in out d.Criteria; target_group : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "target_group", op, join, To_String( target_group ), 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_target_group;


   procedure Add_target_group( c : in out d.Criteria; target_group : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "target_group", op, join, target_group, 20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_target_group;


   procedure Add_all_ages( c : in out d.Criteria; all_ages : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "all_ages", op, join, Long_Float( all_ages ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_all_ages;


   procedure Add_age_0( c : in out d.Criteria; age_0 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_0", op, join, Long_Float( age_0 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0;


   procedure Add_age_1( c : in out d.Criteria; age_1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_1", op, join, Long_Float( age_1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1;


   procedure Add_age_2( c : in out d.Criteria; age_2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_2", op, join, Long_Float( age_2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2;


   procedure Add_age_3( c : in out d.Criteria; age_3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_3", op, join, Long_Float( age_3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3;


   procedure Add_age_4( c : in out d.Criteria; age_4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_4", op, join, Long_Float( age_4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4;


   procedure Add_age_5( c : in out d.Criteria; age_5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_5", op, join, Long_Float( age_5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5;


   procedure Add_age_6( c : in out d.Criteria; age_6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_6", op, join, Long_Float( age_6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6;


   procedure Add_age_7( c : in out d.Criteria; age_7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_7", op, join, Long_Float( age_7 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7;


   procedure Add_age_8( c : in out d.Criteria; age_8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_8", op, join, Long_Float( age_8 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8;


   procedure Add_age_9( c : in out d.Criteria; age_9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_9", op, join, Long_Float( age_9 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9;


   procedure Add_age_10( c : in out d.Criteria; age_10 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_10", op, join, Long_Float( age_10 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10;


   procedure Add_age_11( c : in out d.Criteria; age_11 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_11", op, join, Long_Float( age_11 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11;


   procedure Add_age_12( c : in out d.Criteria; age_12 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_12", op, join, Long_Float( age_12 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12;


   procedure Add_age_13( c : in out d.Criteria; age_13 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_13", op, join, Long_Float( age_13 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13;


   procedure Add_age_14( c : in out d.Criteria; age_14 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_14", op, join, Long_Float( age_14 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14;


   procedure Add_age_15( c : in out d.Criteria; age_15 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_15", op, join, Long_Float( age_15 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15;


   procedure Add_age_16( c : in out d.Criteria; age_16 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_16", op, join, Long_Float( age_16 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16;


   procedure Add_age_17( c : in out d.Criteria; age_17 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_17", op, join, Long_Float( age_17 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17;


   procedure Add_age_18( c : in out d.Criteria; age_18 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_18", op, join, Long_Float( age_18 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18;


   procedure Add_age_19( c : in out d.Criteria; age_19 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_19", op, join, Long_Float( age_19 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19;


   procedure Add_age_20( c : in out d.Criteria; age_20 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_20", op, join, Long_Float( age_20 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20;


   procedure Add_age_21( c : in out d.Criteria; age_21 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_21", op, join, Long_Float( age_21 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21;


   procedure Add_age_22( c : in out d.Criteria; age_22 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_22", op, join, Long_Float( age_22 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22;


   procedure Add_age_23( c : in out d.Criteria; age_23 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_23", op, join, Long_Float( age_23 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23;


   procedure Add_age_24( c : in out d.Criteria; age_24 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_24", op, join, Long_Float( age_24 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24;


   procedure Add_age_25( c : in out d.Criteria; age_25 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_25", op, join, Long_Float( age_25 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25;


   procedure Add_age_26( c : in out d.Criteria; age_26 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_26", op, join, Long_Float( age_26 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26;


   procedure Add_age_27( c : in out d.Criteria; age_27 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_27", op, join, Long_Float( age_27 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27;


   procedure Add_age_28( c : in out d.Criteria; age_28 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_28", op, join, Long_Float( age_28 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28;


   procedure Add_age_29( c : in out d.Criteria; age_29 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_29", op, join, Long_Float( age_29 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29;


   procedure Add_age_30( c : in out d.Criteria; age_30 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_30", op, join, Long_Float( age_30 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30;


   procedure Add_age_31( c : in out d.Criteria; age_31 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_31", op, join, Long_Float( age_31 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31;


   procedure Add_age_32( c : in out d.Criteria; age_32 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_32", op, join, Long_Float( age_32 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32;


   procedure Add_age_33( c : in out d.Criteria; age_33 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_33", op, join, Long_Float( age_33 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33;


   procedure Add_age_34( c : in out d.Criteria; age_34 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_34", op, join, Long_Float( age_34 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34;


   procedure Add_age_35( c : in out d.Criteria; age_35 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_35", op, join, Long_Float( age_35 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35;


   procedure Add_age_36( c : in out d.Criteria; age_36 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_36", op, join, Long_Float( age_36 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36;


   procedure Add_age_37( c : in out d.Criteria; age_37 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_37", op, join, Long_Float( age_37 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37;


   procedure Add_age_38( c : in out d.Criteria; age_38 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_38", op, join, Long_Float( age_38 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38;


   procedure Add_age_39( c : in out d.Criteria; age_39 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_39", op, join, Long_Float( age_39 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39;


   procedure Add_age_40( c : in out d.Criteria; age_40 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_40", op, join, Long_Float( age_40 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40;


   procedure Add_age_41( c : in out d.Criteria; age_41 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_41", op, join, Long_Float( age_41 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41;


   procedure Add_age_42( c : in out d.Criteria; age_42 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_42", op, join, Long_Float( age_42 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42;


   procedure Add_age_43( c : in out d.Criteria; age_43 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_43", op, join, Long_Float( age_43 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43;


   procedure Add_age_44( c : in out d.Criteria; age_44 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_44", op, join, Long_Float( age_44 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44;


   procedure Add_age_45( c : in out d.Criteria; age_45 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_45", op, join, Long_Float( age_45 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45;


   procedure Add_age_46( c : in out d.Criteria; age_46 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_46", op, join, Long_Float( age_46 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46;


   procedure Add_age_47( c : in out d.Criteria; age_47 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_47", op, join, Long_Float( age_47 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47;


   procedure Add_age_48( c : in out d.Criteria; age_48 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_48", op, join, Long_Float( age_48 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48;


   procedure Add_age_49( c : in out d.Criteria; age_49 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_49", op, join, Long_Float( age_49 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49;


   procedure Add_age_50( c : in out d.Criteria; age_50 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_50", op, join, Long_Float( age_50 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50;


   procedure Add_age_51( c : in out d.Criteria; age_51 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_51", op, join, Long_Float( age_51 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51;


   procedure Add_age_52( c : in out d.Criteria; age_52 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_52", op, join, Long_Float( age_52 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52;


   procedure Add_age_53( c : in out d.Criteria; age_53 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_53", op, join, Long_Float( age_53 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53;


   procedure Add_age_54( c : in out d.Criteria; age_54 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_54", op, join, Long_Float( age_54 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54;


   procedure Add_age_55( c : in out d.Criteria; age_55 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_55", op, join, Long_Float( age_55 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55;


   procedure Add_age_56( c : in out d.Criteria; age_56 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_56", op, join, Long_Float( age_56 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56;


   procedure Add_age_57( c : in out d.Criteria; age_57 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_57", op, join, Long_Float( age_57 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57;


   procedure Add_age_58( c : in out d.Criteria; age_58 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_58", op, join, Long_Float( age_58 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58;


   procedure Add_age_59( c : in out d.Criteria; age_59 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_59", op, join, Long_Float( age_59 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59;


   procedure Add_age_60( c : in out d.Criteria; age_60 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_60", op, join, Long_Float( age_60 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60;


   procedure Add_age_61( c : in out d.Criteria; age_61 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_61", op, join, Long_Float( age_61 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61;


   procedure Add_age_62( c : in out d.Criteria; age_62 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_62", op, join, Long_Float( age_62 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62;


   procedure Add_age_63( c : in out d.Criteria; age_63 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_63", op, join, Long_Float( age_63 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63;


   procedure Add_age_64( c : in out d.Criteria; age_64 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_64", op, join, Long_Float( age_64 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64;


   procedure Add_age_65( c : in out d.Criteria; age_65 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_65", op, join, Long_Float( age_65 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65;


   procedure Add_age_66( c : in out d.Criteria; age_66 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_66", op, join, Long_Float( age_66 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66;


   procedure Add_age_67( c : in out d.Criteria; age_67 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_67", op, join, Long_Float( age_67 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67;


   procedure Add_age_68( c : in out d.Criteria; age_68 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_68", op, join, Long_Float( age_68 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68;


   procedure Add_age_69( c : in out d.Criteria; age_69 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_69", op, join, Long_Float( age_69 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69;


   procedure Add_age_70( c : in out d.Criteria; age_70 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_70", op, join, Long_Float( age_70 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70;


   procedure Add_age_71( c : in out d.Criteria; age_71 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_71", op, join, Long_Float( age_71 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71;


   procedure Add_age_72( c : in out d.Criteria; age_72 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_72", op, join, Long_Float( age_72 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72;


   procedure Add_age_73( c : in out d.Criteria; age_73 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_73", op, join, Long_Float( age_73 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73;


   procedure Add_age_74( c : in out d.Criteria; age_74 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_74", op, join, Long_Float( age_74 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74;


   procedure Add_age_75( c : in out d.Criteria; age_75 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_75", op, join, Long_Float( age_75 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75;


   procedure Add_age_76( c : in out d.Criteria; age_76 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_76", op, join, Long_Float( age_76 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76;


   procedure Add_age_77( c : in out d.Criteria; age_77 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_77", op, join, Long_Float( age_77 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77;


   procedure Add_age_78( c : in out d.Criteria; age_78 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_78", op, join, Long_Float( age_78 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78;


   procedure Add_age_79( c : in out d.Criteria; age_79 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_79", op, join, Long_Float( age_79 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79;


   procedure Add_age_80( c : in out d.Criteria; age_80 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_80", op, join, Long_Float( age_80 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80;


   procedure Add_age_81( c : in out d.Criteria; age_81 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_81", op, join, Long_Float( age_81 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81;


   procedure Add_age_82( c : in out d.Criteria; age_82 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_82", op, join, Long_Float( age_82 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82;


   procedure Add_age_83( c : in out d.Criteria; age_83 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_83", op, join, Long_Float( age_83 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83;


   procedure Add_age_84( c : in out d.Criteria; age_84 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_84", op, join, Long_Float( age_84 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84;


   procedure Add_age_85( c : in out d.Criteria; age_85 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_85", op, join, Long_Float( age_85 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85;


   procedure Add_age_86( c : in out d.Criteria; age_86 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_86", op, join, Long_Float( age_86 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86;


   procedure Add_age_87( c : in out d.Criteria; age_87 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_87", op, join, Long_Float( age_87 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87;


   procedure Add_age_88( c : in out d.Criteria; age_88 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_88", op, join, Long_Float( age_88 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88;


   procedure Add_age_89( c : in out d.Criteria; age_89 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_89", op, join, Long_Float( age_89 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89;


   procedure Add_age_90( c : in out d.Criteria; age_90 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_90", op, join, Long_Float( age_90 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90;


   procedure Add_age_91( c : in out d.Criteria; age_91 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_91", op, join, Long_Float( age_91 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91;


   procedure Add_age_92( c : in out d.Criteria; age_92 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_92", op, join, Long_Float( age_92 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92;


   procedure Add_age_93( c : in out d.Criteria; age_93 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_93", op, join, Long_Float( age_93 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93;


   procedure Add_age_94( c : in out d.Criteria; age_94 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_94", op, join, Long_Float( age_94 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94;


   procedure Add_age_95( c : in out d.Criteria; age_95 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_95", op, join, Long_Float( age_95 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95;


   procedure Add_age_96( c : in out d.Criteria; age_96 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_96", op, join, Long_Float( age_96 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96;


   procedure Add_age_97( c : in out d.Criteria; age_97 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_97", op, join, Long_Float( age_97 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97;


   procedure Add_age_98( c : in out d.Criteria; age_98 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_98", op, join, Long_Float( age_98 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98;


   procedure Add_age_99( c : in out d.Criteria; age_99 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_99", op, join, Long_Float( age_99 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99;


   procedure Add_age_100( c : in out d.Criteria; age_100 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_100", op, join, Long_Float( age_100 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100;


   procedure Add_age_101( c : in out d.Criteria; age_101 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_101", op, join, Long_Float( age_101 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101;


   procedure Add_age_102( c : in out d.Criteria; age_102 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_102", op, join, Long_Float( age_102 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102;


   procedure Add_age_103( c : in out d.Criteria; age_103 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_103", op, join, Long_Float( age_103 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103;


   procedure Add_age_104( c : in out d.Criteria; age_104 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_104", op, join, Long_Float( age_104 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104;


   procedure Add_age_105( c : in out d.Criteria; age_105 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_105", op, join, Long_Float( age_105 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105;


   procedure Add_age_106( c : in out d.Criteria; age_106 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_106", op, join, Long_Float( age_106 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106;


   procedure Add_age_107( c : in out d.Criteria; age_107 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_107", op, join, Long_Float( age_107 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107;


   procedure Add_age_108( c : in out d.Criteria; age_108 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_108", op, join, Long_Float( age_108 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108;


   procedure Add_age_109( c : in out d.Criteria; age_109 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_109", op, join, Long_Float( age_109 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109;


   procedure Add_age_110( c : in out d.Criteria; age_110 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age_110", op, join, Long_Float( age_110 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_year_To_Orderings;


   procedure Add_rec_type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rec_type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rec_type_To_Orderings;


   procedure Add_variant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "variant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_variant_To_Orderings;


   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_To_Orderings;


   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition_To_Orderings;


   procedure Add_target_group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "target_group", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_target_group_To_Orderings;


   procedure Add_all_ages_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "all_ages", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_all_ages_To_Orderings;


   procedure Add_age_0_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_0", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_0_To_Orderings;


   procedure Add_age_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_1_To_Orderings;


   procedure Add_age_2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_2_To_Orderings;


   procedure Add_age_3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_3_To_Orderings;


   procedure Add_age_4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_4_To_Orderings;


   procedure Add_age_5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_5_To_Orderings;


   procedure Add_age_6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_6_To_Orderings;


   procedure Add_age_7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_7_To_Orderings;


   procedure Add_age_8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_8_To_Orderings;


   procedure Add_age_9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_9_To_Orderings;


   procedure Add_age_10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_10_To_Orderings;


   procedure Add_age_11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_11_To_Orderings;


   procedure Add_age_12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_12_To_Orderings;


   procedure Add_age_13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_13_To_Orderings;


   procedure Add_age_14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_14_To_Orderings;


   procedure Add_age_15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_15_To_Orderings;


   procedure Add_age_16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_16_To_Orderings;


   procedure Add_age_17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_17_To_Orderings;


   procedure Add_age_18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_18_To_Orderings;


   procedure Add_age_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_19_To_Orderings;


   procedure Add_age_20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_20", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_20_To_Orderings;


   procedure Add_age_21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_21", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_21_To_Orderings;


   procedure Add_age_22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_22", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_22_To_Orderings;


   procedure Add_age_23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_23", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_23_To_Orderings;


   procedure Add_age_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_24", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_24_To_Orderings;


   procedure Add_age_25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_25", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_25_To_Orderings;


   procedure Add_age_26_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_26", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_26_To_Orderings;


   procedure Add_age_27_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_27", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_27_To_Orderings;


   procedure Add_age_28_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_28", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_28_To_Orderings;


   procedure Add_age_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_29", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_29_To_Orderings;


   procedure Add_age_30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_30", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_30_To_Orderings;


   procedure Add_age_31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_31", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_31_To_Orderings;


   procedure Add_age_32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_32", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_32_To_Orderings;


   procedure Add_age_33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_33", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_33_To_Orderings;


   procedure Add_age_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_34", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_34_To_Orderings;


   procedure Add_age_35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_35", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_35_To_Orderings;


   procedure Add_age_36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_36", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_36_To_Orderings;


   procedure Add_age_37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_37", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_37_To_Orderings;


   procedure Add_age_38_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_38", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_38_To_Orderings;


   procedure Add_age_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_39", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_39_To_Orderings;


   procedure Add_age_40_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_40", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_40_To_Orderings;


   procedure Add_age_41_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_41", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_41_To_Orderings;


   procedure Add_age_42_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_42", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_42_To_Orderings;


   procedure Add_age_43_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_43", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_43_To_Orderings;


   procedure Add_age_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_44", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_44_To_Orderings;


   procedure Add_age_45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_45", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_45_To_Orderings;


   procedure Add_age_46_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_46", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_46_To_Orderings;


   procedure Add_age_47_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_47", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_47_To_Orderings;


   procedure Add_age_48_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_48", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_48_To_Orderings;


   procedure Add_age_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_49", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_49_To_Orderings;


   procedure Add_age_50_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_50", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_50_To_Orderings;


   procedure Add_age_51_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_51", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_51_To_Orderings;


   procedure Add_age_52_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_52", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_52_To_Orderings;


   procedure Add_age_53_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_53", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_53_To_Orderings;


   procedure Add_age_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_54", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_54_To_Orderings;


   procedure Add_age_55_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_55", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_55_To_Orderings;


   procedure Add_age_56_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_56", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_56_To_Orderings;


   procedure Add_age_57_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_57", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_57_To_Orderings;


   procedure Add_age_58_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_58", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_58_To_Orderings;


   procedure Add_age_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_59", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_59_To_Orderings;


   procedure Add_age_60_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_60", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_60_To_Orderings;


   procedure Add_age_61_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_61", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_61_To_Orderings;


   procedure Add_age_62_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_62", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_62_To_Orderings;


   procedure Add_age_63_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_63", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_63_To_Orderings;


   procedure Add_age_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_64", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_64_To_Orderings;


   procedure Add_age_65_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_65", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_65_To_Orderings;


   procedure Add_age_66_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_66", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_66_To_Orderings;


   procedure Add_age_67_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_67", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_67_To_Orderings;


   procedure Add_age_68_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_68", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_68_To_Orderings;


   procedure Add_age_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_69", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_69_To_Orderings;


   procedure Add_age_70_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_70", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_70_To_Orderings;


   procedure Add_age_71_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_71", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_71_To_Orderings;


   procedure Add_age_72_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_72", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_72_To_Orderings;


   procedure Add_age_73_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_73", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_73_To_Orderings;


   procedure Add_age_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_74", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_74_To_Orderings;


   procedure Add_age_75_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_75", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_75_To_Orderings;


   procedure Add_age_76_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_76", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_76_To_Orderings;


   procedure Add_age_77_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_77", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_77_To_Orderings;


   procedure Add_age_78_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_78", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_78_To_Orderings;


   procedure Add_age_79_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_79", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_79_To_Orderings;


   procedure Add_age_80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_80_To_Orderings;


   procedure Add_age_81_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_81", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_81_To_Orderings;


   procedure Add_age_82_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_82", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_82_To_Orderings;


   procedure Add_age_83_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_83", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_83_To_Orderings;


   procedure Add_age_84_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_84", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_84_To_Orderings;


   procedure Add_age_85_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_85", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_85_To_Orderings;


   procedure Add_age_86_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_86", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_86_To_Orderings;


   procedure Add_age_87_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_87", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_87_To_Orderings;


   procedure Add_age_88_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_88", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_88_To_Orderings;


   procedure Add_age_89_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_89", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_89_To_Orderings;


   procedure Add_age_90_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_90", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_90_To_Orderings;


   procedure Add_age_91_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_91", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_91_To_Orderings;


   procedure Add_age_92_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_92", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_92_To_Orderings;


   procedure Add_age_93_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_93", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_93_To_Orderings;


   procedure Add_age_94_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_94", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_94_To_Orderings;


   procedure Add_age_95_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_95", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_95_To_Orderings;


   procedure Add_age_96_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_96", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_96_To_Orderings;


   procedure Add_age_97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_97", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_97_To_Orderings;


   procedure Add_age_98_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_98", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_98_To_Orderings;


   procedure Add_age_99_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_99", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_99_To_Orderings;


   procedure Add_age_100_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_100", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_100_To_Orderings;


   procedure Add_age_101_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_101", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_101_To_Orderings;


   procedure Add_age_102_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_102", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_102_To_Orderings;


   procedure Add_age_103_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_103", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_103_To_Orderings;


   procedure Add_age_104_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_104", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_104_To_Orderings;


   procedure Add_age_105_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_105", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_105_To_Orderings;


   procedure Add_age_106_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_106", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_106_To_Orderings;


   procedure Add_age_107_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_107", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_107_To_Orderings;


   procedure Add_age_108_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_108", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_108_To_Orderings;


   procedure Add_age_109_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_109", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_109_To_Orderings;


   procedure Add_age_110_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_110", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_110_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Target_Data.Population_Forecasts_IO;
