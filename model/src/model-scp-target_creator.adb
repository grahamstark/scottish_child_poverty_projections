with Ada.Calendar;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Calendar;
with Ada.Text_IO;

with Data_Constants;
with Base_Model_Types;
with Text_Utils;
with SCP_Types;

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Run_IO;
with Ukds.Target_Data.Macro_Forecasts_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.England_Households_IO;
with Ukds.Target_Data.Wales_Households_IO;
with Ukds.Target_Data.Nireland_Households_IO;
with Ukds.Target_Data.Obr_Participation_Rates_IO;

with Ukds.Target_Data.Population_Forecasts_IO;
with Ukds.Target_Data.Target_Dataset_IO;

with DB_Commons;

with Connection_Pool;


package body Model.SCP.Target_Creator is

   use UKDS.Target_Data;
   use UKDS;
   use Text_Utils;   
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Calendar;
   use GNATCOLL.SQL.Exec;
   use SCP_Types;
   
   package d renames DB_Commons;
   

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.SCP.TARGET_CREATOR" );
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   function Get_Participation_Scale( 
      country : Unbounded_String; 
      sex : Integer; 
      age : Integer ) return Amount is
      type Age_Range is ( v16_19, v20_24, v25_34, v35_49, v50_64, v65_plus );
      type Weight_Array is array( Age_Range, Countries,  Genders_Type ) of Amount;
      sex_c : Genders_Type := ( if sex = 1 then male else female );
      cntry : Countries := Country_From_Country( country );
      ager : Age_Range; 
      weights : Weight_Array := ( 
        -- I think there is a compiler bug here with named arrays
        -- v16_19 => ( 
                   -- ( sco_c => ( males => 50.0, females => 49.6 )),
                   -- ( eng_c => ( males => 43.5, females => 43.5 )),
                   -- ( wal_c => ( males => 42.9, females => 45.0 )),
                   -- ( nir_c => ( males => 33.2, females => 33.3 )),
                   -- ( uk_c  => ( males => 43.7, females => 43.7 ))),
         -- v20_24 => ( 
                  -- ( sco_c => ( males => 76.0, females => 71.8 )),
                  -- ( eng_c => ( males => 76.7, females => 71.0 )),
                  -- ( wal_c => ( males => 68.2, females => 66.6 )),
                  -- ( nir_c => ( males => 75.3, females => 77.5 )),
                  -- ( uk_c  => ( males => 76.1, females => 71.0 ))),
            -- 
         -- v25_34 => ( 
                  -- ( sco_c => ( males => 91.1, females => 79.7 )),
                  -- ( eng_c => ( males => 93.4, females => 78.5 )),
                  -- ( wal_c => ( males => 90.1, females => 78.4 )),
                  -- ( nir_c => ( males => 89.4, females => 79.9 )),
                  -- ( uk_c  => ( males => 92.9, females => 78.7 ))),
         -- v35_49 => (  
                  -- ( sco_c => ( males => 88.7, females => 81.2 )),
                  -- ( eng_c => ( males => 93.0, females => 81.1 )),
                  -- ( wal_c => ( males => 89.9, females => 83.2 )),
                  -- ( nir_c => ( males => 90.8, females => 76.4 )),
                  -- ( uk_c  => ( males => 92.4, females => 81.0 ))),
        -- v50_64 => ( 
                  -- ( sco_c => ( males => 75.9, females => 66.2 )),
                  -- ( eng_c => ( males => 79.1, females => 67.7 )),
                  -- ( wal_c => ( males => 73.8, females => 64.8 )),
                  -- ( nir_c => ( males => 73.1, females => 57.0 )),
                  -- ( uk_c  => ( males => 78.4, females => 67.1 ))),
         -- v65_plus => (              
                  -- ( sco_c => ( males => 12.0, females => 6.6 )),
                  -- ( eng_c => ( males => 14.0, females => 7.7 )),
                  -- ( wal_c => ( males => 11.5, females => 7.2 )),
                  -- ( nir_c => ( males => 13.9, females => 4.4 )),
                  -- ( uk_c  => ( males => 13.7, females => 7.5 ))));
                  
         (
          (( 50.0, 49.6 )),
          (( 43.5, 43.5 )),
          (( 42.9, 45.0 )),
          (( 33.2, 33.3 )),
          (( 43.7, 43.7 ))),
         (
          (( 76.0, 71.8 )),
          (( 76.7, 71.0 )),
          (( 68.2, 66.6 )),
          (( 75.3, 77.5 )),
          (( 76.1, 71.0 ))),
          
         (
          (( 91.1, 79.7 )),
          (( 93.4, 78.5 )),
          (( 90.1, 78.4 )),
          (( 89.4, 79.9 )),
          (( 92.9, 78.7 ))),
         (
          (( 88.7, 81.2 )),
          (( 93.0, 81.1 )),
          (( 89.9, 83.2 )),
          (( 90.8, 76.4 )),
          (( 92.4, 81.0 ))),
        ( 
          (( 75.9, 66.2 )),
          (( 79.1, 67.7 )),
          (( 73.8, 64.8 )),
          (( 73.1, 57.0 )),
          (( 78.4, 67.1 ))),
         (      
          (( 12.0, 6.6 )),
          (( 14.0, 7.7 )),
          (( 11.5, 7.2 )),
          (( 13.9, 4.4 )),
          (( 13.7, 7.5 ))));
          
                  
   begin
      case age is
         when 16 .. 19 => ager := v16_19;
         when 20 .. 24 => ager := v20_24; 
         when 25 .. 34 => ager := v25_34; 
         when 35 .. 49 => ager := v35_49; 
         when 50 .. 64 => ager := v50_64; 
         when 65 .. 120 => ager := v65_plus;
         when others => Assert( false, "age out of range " & age'Img );
      end case;
      return weights( ager, cntry, sex_c ) / weights( ager, UK_C, sex_c );
   end Get_Participation_Scale;
   
   function Q_Weighed_Av( q123, q4 : Amount ) return Amount is
      use Maths_Funcs.Matrix_Functions;
      v1 : constant Vector( 1 .. 2 ) := ( q123, q4 );
      v2 : constant Vector( 1 .. 2 ) := ( 0.75, 0.25 );
      a  : constant Amount := v1*v2; 
   begin
      return a;
   end Q_Weighed_Av;
 
   --
   -- we only have 3 2014 hhld variants; choose the nearest to some person projection
   -- 
   function Nearest_HH_Variant( popn_variant : Unbounded_String ) return Unbounded_String is
      hht : Unbounded_String;
   begin
      if popn_variant = PPP or -- principal projection
         popn_variant = PJP or -- moderately high life expectancy variant
         popn_variant = PKP then -- moderately low life expectancy variant
         hht := PPP;   
      elsif 
         popn_variant = PPL or -- low migration variant
         popn_variant = PPQ or -- 0% future EU migration variant (not National Statistics)
         popn_variant = PPR or -- 50% future EU migration variant (not National Statistics)
         popn_variant = LLL or -- low population variant
         popn_variant = LPP or --- low fertility variant
         popn_variant = PLP or -- low life expectancy variant
         popn_variant = PPZ then -- zero net migration variant (natural change only)
         hht := PPL;
      elsif 
         popn_variant = PHP or -- high life expectancy variant
         popn_variant = HHH or -- high population variant 
         popn_variant = HPP or -- high fertility variant
         popn_variant = PPS or -- 150% future EU migration variant (not National Statistics)
         popn_variant = PPH then -- high migration variant
         hht := PPH;
      else
         Assert( False, "missing map for " & TS( popn_variant ));
      end if;
      return hht;
   end Nearest_HH_Variant;
   
   --
   -- CAREFUL! This is a hacked Scotland only version
   --
   procedure Create_Dataset( the_run : Run ) is
      macro_data : Macro_Forecasts;
   begin
      -- Population_Forecasts_IO.Add_Variant( pop_crit, the_run.people_source ); 
      -- Households_Forecasts_IO.Add_Variant( hh_crit, the_run.household_source );
      -- Macro_Forecasts_IO.Add_Variant( mac_crit, the_run.macro_source );
      for year in the_run.start_year .. the_run.end_year loop

         declare
            female_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "FEMALES" )                           
            );
            female_popn_yp1 : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year+1,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "FEMALES" )                           
            );
            male_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => PERSONS,
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "MALES" )                           
            );
            male_popn_yp1 : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year+1,
               rec_type => PERSONS,
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "MALES" )                           
            );
            
            --
            -- overkill - just to scale hhlds
            --
            female_popn_2014 : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => 2014,
               target_group => TuS( "FEMALES" )                           
            );
            female_popn_yp1_2014 : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year+1,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => 2014,
               target_group => TuS( "FEMALES" )                           
            );
            male_popn_2014 : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => PERSONS,
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => 2014,
               target_group => TuS( "MALES" )                           
            );
            male_popn_yp1_2014 : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year+1,
               rec_type => PERSONS,
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => 2014,
               target_group => TuS( "MALES" )                           
            );
            
            popn_2017_edn : constant Amount := 
               Q_Weighed_Av( 
               male_popn.all_ages + female_popn.all_ages, 
               male_popn_yp1.all_ages + female_popn_yp1.all_ages );
            
            popn_2014_edn : constant Amount := 
               Q_Weighed_Av( 
               male_popn_2014.all_ages + female_popn_2014.all_ages, 
               male_popn_yp1_2014.all_ages + female_popn_yp1_2014.all_ages );
            
            --
            -- for 2016 edn hhlds, we just scale the likely 2014 edition by total popn change
            -- between the 2014 and 2016 forecasts for that year. Best we can do, I think.
            --
            hh_scaling : constant Amount :=  popn_2017_edn/popn_2014_edn;  
            
            scottish_households : constant Households_Forecasts := Households_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => Nearest_HH_Variant( the_run.population_variant ),
               country  => SCO,
               edition  => 2014 -- could just jam this on to 2014 ...
            );
            
          targets     : Target_Dataset;  
            
         begin   
            if year <= 2022 then
                 macro_data  := Macro_Forecasts_IO.Retrieve_By_PK(
                  year     => year,
                  rec_type => MACRO,
                  variant  => the_run.macro_variant,
                  country  => the_run.country, -- for now ..
                  edition  => the_run.macro_edition                   
               );
            end if; -- so keep last one if later
         
            targets.run_id := the_run.run_id;
            targets.user_id := the_run.user_id;
            targets.year := year;
            targets.sernum := Sernum_Value'First;

            Log(  " year " & year'Img &
                  " hh scaling " & Format( hh_scaling*100.0 ) & "% " &
                  " popn 2017 edn " & Format( popn_2017_edn ) &
                  " popn 2014 edn " & Format( popn_2014_edn ));
            
            targets.sco_hhld_one_adult_male := scottish_households.one_adult_male * hh_scaling;
            targets.sco_hhld_one_adult_female := scottish_households.one_adult_female * hh_scaling;
            targets.sco_hhld_two_adults := scottish_households.two_adults  * hh_scaling;
            targets.sco_hhld_one_adult_one_child := scottish_households.one_adult_one_child  * hh_scaling;
            targets.sco_hhld_one_adult_two_plus_children := scottish_households.one_adult_two_plus_children * hh_scaling;
            targets.sco_hhld_two_plus_adult_one_plus_children := scottish_households.two_plus_adult_one_plus_children * hh_scaling;
            targets.sco_hhld_three_plus_person_all_adult := scottish_households.three_plus_person_all_adult * hh_scaling;
            targets.household_all_households := targets.household_all_households + scottish_households.all_households * hh_scaling;
            targets.country_scotland := scottish_households.all_households * hh_scaling;
            
            targets.age_0_male := Q_Weighed_Av( male_popn.age_0, male_popn_yp1.age_0 );
            targets.age_0_female := Q_Weighed_Av( female_popn.age_0, female_popn_yp1.age_0 );
            targets.age_1_male := Q_Weighed_Av( male_popn.age_1, male_popn_yp1.age_1 );
            targets.age_1_female := Q_Weighed_Av( female_popn.age_1, female_popn_yp1.age_1 );
            targets.age_2_male := Q_Weighed_Av( male_popn.age_2, male_popn_yp1.age_2 );
            targets.age_2_female := Q_Weighed_Av( female_popn.age_2, female_popn_yp1.age_2 );
            targets.age_3_male := Q_Weighed_Av( male_popn.age_3, male_popn_yp1.age_3 );
            targets.age_3_female := Q_Weighed_Av( female_popn.age_3, female_popn_yp1.age_3 );
            targets.age_4_male := Q_Weighed_Av( male_popn.age_4, male_popn_yp1.age_4 );
            targets.age_4_female := Q_Weighed_Av( female_popn.age_4, female_popn_yp1.age_4 );
            targets.age_5_male := Q_Weighed_Av( male_popn.age_5, male_popn_yp1.age_5 );
            targets.age_5_female := Q_Weighed_Av( female_popn.age_5, female_popn_yp1.age_5 );
            targets.age_6_male := Q_Weighed_Av( male_popn.age_6, male_popn_yp1.age_6 );
            targets.age_6_female := Q_Weighed_Av( female_popn.age_6, female_popn_yp1.age_6 );
            targets.age_7_male := Q_Weighed_Av( male_popn.age_7, male_popn_yp1.age_7 );
            targets.age_7_female := Q_Weighed_Av( female_popn.age_7, female_popn_yp1.age_7 );
            targets.age_8_male := Q_Weighed_Av( male_popn.age_8, male_popn_yp1.age_8 );
            targets.age_8_female := Q_Weighed_Av( female_popn.age_8, female_popn_yp1.age_8 );
            targets.age_9_male := Q_Weighed_Av( male_popn.age_9, male_popn_yp1.age_9 );
            targets.age_9_female := Q_Weighed_Av( female_popn.age_9, female_popn_yp1.age_9 );
            targets.age_10_male := Q_Weighed_Av( male_popn.age_10, male_popn_yp1.age_10 );
            targets.age_10_female := Q_Weighed_Av( female_popn.age_10, female_popn_yp1.age_10 );
            targets.age_11_male := Q_Weighed_Av( male_popn.age_11, male_popn_yp1.age_11 );
            targets.age_11_female := Q_Weighed_Av( female_popn.age_11, female_popn_yp1.age_11 );
            targets.age_12_male := Q_Weighed_Av( male_popn.age_12, male_popn_yp1.age_12 );
            targets.age_12_female := Q_Weighed_Av( female_popn.age_12, female_popn_yp1.age_12 );
            targets.age_13_male := Q_Weighed_Av( male_popn.age_13, male_popn_yp1.age_13 );
            targets.age_13_female := Q_Weighed_Av( female_popn.age_13, female_popn_yp1.age_13 );
            targets.age_14_male := Q_Weighed_Av( male_popn.age_14, male_popn_yp1.age_14 );
            targets.age_14_female := Q_Weighed_Av( female_popn.age_14, female_popn_yp1.age_14 );
            targets.age_15_male := Q_Weighed_Av( male_popn.age_15, male_popn_yp1.age_15 );
            targets.age_15_female := Q_Weighed_Av( female_popn.age_15, female_popn_yp1.age_15 );
            targets.age_16_male := Q_Weighed_Av( male_popn.age_16, male_popn_yp1.age_16 );
            targets.age_16_female := Q_Weighed_Av( female_popn.age_16, female_popn_yp1.age_16 );
            targets.age_17_male := Q_Weighed_Av( male_popn.age_17, male_popn_yp1.age_17 );
            targets.age_17_female := Q_Weighed_Av( female_popn.age_17, female_popn_yp1.age_17 );
            targets.age_18_male := Q_Weighed_Av( male_popn.age_18, male_popn_yp1.age_18 );
            targets.age_18_female := Q_Weighed_Av( female_popn.age_18, female_popn_yp1.age_18 );
            targets.age_19_male := Q_Weighed_Av( male_popn.age_19, male_popn_yp1.age_19 );
            targets.age_19_female := Q_Weighed_Av( female_popn.age_19, female_popn_yp1.age_19 );
            targets.age_20_male := Q_Weighed_Av( male_popn.age_20, male_popn_yp1.age_20 );
            targets.age_20_female := Q_Weighed_Av( female_popn.age_20, female_popn_yp1.age_20 );
            targets.age_21_male := Q_Weighed_Av( male_popn.age_21, male_popn_yp1.age_21 );
            targets.age_21_female := Q_Weighed_Av( female_popn.age_21, female_popn_yp1.age_21 );
            targets.age_22_male := Q_Weighed_Av( male_popn.age_22, male_popn_yp1.age_22 );
            targets.age_22_female := Q_Weighed_Av( female_popn.age_22, female_popn_yp1.age_22 );
            targets.age_23_male := Q_Weighed_Av( male_popn.age_23, male_popn_yp1.age_23 );
            targets.age_23_female := Q_Weighed_Av( female_popn.age_23, female_popn_yp1.age_23 );
            targets.age_24_male := Q_Weighed_Av( male_popn.age_24, male_popn_yp1.age_24 );
            targets.age_24_female := Q_Weighed_Av( female_popn.age_24, female_popn_yp1.age_24 );
            targets.age_25_male := Q_Weighed_Av( male_popn.age_25, male_popn_yp1.age_25 );
            targets.age_25_female := Q_Weighed_Av( female_popn.age_25, female_popn_yp1.age_25 );
            targets.age_26_male := Q_Weighed_Av( male_popn.age_26, male_popn_yp1.age_26 );
            targets.age_26_female := Q_Weighed_Av( female_popn.age_26, female_popn_yp1.age_26 );
            targets.age_27_male := Q_Weighed_Av( male_popn.age_27, male_popn_yp1.age_27 );
            targets.age_27_female := Q_Weighed_Av( female_popn.age_27, female_popn_yp1.age_27 );
            targets.age_28_male := Q_Weighed_Av( male_popn.age_28, male_popn_yp1.age_28 );
            targets.age_28_female := Q_Weighed_Av( female_popn.age_28, female_popn_yp1.age_28 );
            targets.age_29_male := Q_Weighed_Av( male_popn.age_29, male_popn_yp1.age_29 );
            targets.age_29_female := Q_Weighed_Av( female_popn.age_29, female_popn_yp1.age_29 );
            targets.age_30_male := Q_Weighed_Av( male_popn.age_30, male_popn_yp1.age_30 );
            targets.age_30_female := Q_Weighed_Av( female_popn.age_30, female_popn_yp1.age_30 );
            targets.age_31_male := Q_Weighed_Av( male_popn.age_31, male_popn_yp1.age_31 );
            targets.age_31_female := Q_Weighed_Av( female_popn.age_31, female_popn_yp1.age_31 );
            targets.age_32_male := Q_Weighed_Av( male_popn.age_32, male_popn_yp1.age_32 );
            targets.age_32_female := Q_Weighed_Av( female_popn.age_32, female_popn_yp1.age_32 );
            targets.age_33_male := Q_Weighed_Av( male_popn.age_33, male_popn_yp1.age_33 );
            targets.age_33_female := Q_Weighed_Av( female_popn.age_33, female_popn_yp1.age_33 );
            targets.age_34_male := Q_Weighed_Av( male_popn.age_34, male_popn_yp1.age_34 );
            targets.age_34_female := Q_Weighed_Av( female_popn.age_34, female_popn_yp1.age_34 );
            targets.age_35_male := Q_Weighed_Av( male_popn.age_35, male_popn_yp1.age_35 );
            targets.age_35_female := Q_Weighed_Av( female_popn.age_35, female_popn_yp1.age_35 );
            targets.age_36_male := Q_Weighed_Av( male_popn.age_36, male_popn_yp1.age_36 );
            targets.age_36_female := Q_Weighed_Av( female_popn.age_36, female_popn_yp1.age_36 );
            targets.age_37_male := Q_Weighed_Av( male_popn.age_37, male_popn_yp1.age_37 );
            targets.age_37_female := Q_Weighed_Av( female_popn.age_37, female_popn_yp1.age_37 );
            targets.age_38_male := Q_Weighed_Av( male_popn.age_38, male_popn_yp1.age_38 );
            targets.age_38_female := Q_Weighed_Av( female_popn.age_38, female_popn_yp1.age_38 );
            targets.age_39_male := Q_Weighed_Av( male_popn.age_39, male_popn_yp1.age_39 );
            targets.age_39_female := Q_Weighed_Av( female_popn.age_39, female_popn_yp1.age_39 );
            targets.age_40_male := Q_Weighed_Av( male_popn.age_40, male_popn_yp1.age_40 );
            targets.age_40_female := Q_Weighed_Av( female_popn.age_40, female_popn_yp1.age_40 );
            targets.age_41_male := Q_Weighed_Av( male_popn.age_41, male_popn_yp1.age_41 );
            targets.age_41_female := Q_Weighed_Av( female_popn.age_41, female_popn_yp1.age_41 );
            targets.age_42_male := Q_Weighed_Av( male_popn.age_42, male_popn_yp1.age_42 );
            targets.age_42_female := Q_Weighed_Av( female_popn.age_42, female_popn_yp1.age_42 );
            targets.age_43_male := Q_Weighed_Av( male_popn.age_43, male_popn_yp1.age_43 );
            targets.age_43_female := Q_Weighed_Av( female_popn.age_43, female_popn_yp1.age_43 );
            targets.age_44_male := Q_Weighed_Av( male_popn.age_44, male_popn_yp1.age_44 );
            targets.age_44_female := Q_Weighed_Av( female_popn.age_44, female_popn_yp1.age_44 );
            targets.age_45_male := Q_Weighed_Av( male_popn.age_45, male_popn_yp1.age_45 );
            targets.age_45_female := Q_Weighed_Av( female_popn.age_45, female_popn_yp1.age_45 );
            targets.age_46_male := Q_Weighed_Av( male_popn.age_46, male_popn_yp1.age_46 );
            targets.age_46_female := Q_Weighed_Av( female_popn.age_46, female_popn_yp1.age_46 );
            targets.age_47_male := Q_Weighed_Av( male_popn.age_47, male_popn_yp1.age_47 );
            targets.age_47_female := Q_Weighed_Av( female_popn.age_47, female_popn_yp1.age_47 );
            targets.age_48_male := Q_Weighed_Av( male_popn.age_48, male_popn_yp1.age_48 );
            targets.age_48_female := Q_Weighed_Av( female_popn.age_48, female_popn_yp1.age_48 );
            targets.age_49_male := Q_Weighed_Av( male_popn.age_49, male_popn_yp1.age_49 );
            targets.age_49_female := Q_Weighed_Av( female_popn.age_49, female_popn_yp1.age_49 );
            targets.age_50_male := Q_Weighed_Av( male_popn.age_50, male_popn_yp1.age_50 );
            targets.age_50_female := Q_Weighed_Av( female_popn.age_50, female_popn_yp1.age_50 );
            targets.age_51_male := Q_Weighed_Av( male_popn.age_51, male_popn_yp1.age_51 );
            targets.age_51_female := Q_Weighed_Av( female_popn.age_51, female_popn_yp1.age_51 );
            targets.age_52_male := Q_Weighed_Av( male_popn.age_52, male_popn_yp1.age_52 );
            targets.age_52_female := Q_Weighed_Av( female_popn.age_52, female_popn_yp1.age_52 );
            targets.age_53_male := Q_Weighed_Av( male_popn.age_53, male_popn_yp1.age_53 );
            targets.age_53_female := Q_Weighed_Av( female_popn.age_53, female_popn_yp1.age_53 );
            targets.age_54_male := Q_Weighed_Av( male_popn.age_54, male_popn_yp1.age_54 );
            targets.age_54_female := Q_Weighed_Av( female_popn.age_54, female_popn_yp1.age_54 );
            targets.age_55_male := Q_Weighed_Av( male_popn.age_55, male_popn_yp1.age_55 );
            targets.age_55_female := Q_Weighed_Av( female_popn.age_55, female_popn_yp1.age_55 );
            targets.age_56_male := Q_Weighed_Av( male_popn.age_56, male_popn_yp1.age_56 );
            targets.age_56_female := Q_Weighed_Av( female_popn.age_56, female_popn_yp1.age_56 );
            targets.age_57_male := Q_Weighed_Av( male_popn.age_57, male_popn_yp1.age_57 );
            targets.age_57_female := Q_Weighed_Av( female_popn.age_57, female_popn_yp1.age_57 );
            targets.age_58_male := Q_Weighed_Av( male_popn.age_58, male_popn_yp1.age_58 );
            targets.age_58_female := Q_Weighed_Av( female_popn.age_58, female_popn_yp1.age_58 );
            targets.age_59_male := Q_Weighed_Av( male_popn.age_59, male_popn_yp1.age_59 );
            targets.age_59_female := Q_Weighed_Av( female_popn.age_59, female_popn_yp1.age_59 );
            targets.age_60_male := Q_Weighed_Av( male_popn.age_60, male_popn_yp1.age_60 );
            targets.age_60_female := Q_Weighed_Av( female_popn.age_60, female_popn_yp1.age_60 );
            targets.age_61_male := Q_Weighed_Av( male_popn.age_61, male_popn_yp1.age_61 );
            targets.age_61_female := Q_Weighed_Av( female_popn.age_61, female_popn_yp1.age_61 );
            targets.age_62_male := Q_Weighed_Av( male_popn.age_62, male_popn_yp1.age_62 );
            targets.age_62_female := Q_Weighed_Av( female_popn.age_62, female_popn_yp1.age_62 );
            targets.age_63_male := Q_Weighed_Av( male_popn.age_63, male_popn_yp1.age_63 );
            targets.age_63_female := Q_Weighed_Av( female_popn.age_63, female_popn_yp1.age_63 );
            targets.age_64_male := Q_Weighed_Av( male_popn.age_64, male_popn_yp1.age_64 );
            targets.age_64_female := Q_Weighed_Av( female_popn.age_64, female_popn_yp1.age_64 );
            targets.age_65_male := Q_Weighed_Av( male_popn.age_65, male_popn_yp1.age_65 );
            targets.age_65_female := Q_Weighed_Av( female_popn.age_65, female_popn_yp1.age_65 );
            targets.age_66_male := Q_Weighed_Av( male_popn.age_66, male_popn_yp1.age_66 );
            targets.age_66_female := Q_Weighed_Av( female_popn.age_66, female_popn_yp1.age_66 );
            targets.age_67_male := Q_Weighed_Av( male_popn.age_67, male_popn_yp1.age_67 );
            targets.age_67_female := Q_Weighed_Av( female_popn.age_67, female_popn_yp1.age_67 );
            targets.age_68_male := Q_Weighed_Av( male_popn.age_68, male_popn_yp1.age_68 );
            targets.age_68_female := Q_Weighed_Av( female_popn.age_68, female_popn_yp1.age_68 );
            targets.age_69_male := Q_Weighed_Av( male_popn.age_69, male_popn_yp1.age_69 );
            targets.age_69_female := Q_Weighed_Av( female_popn.age_69, female_popn_yp1.age_69 );
            targets.age_70_male := Q_Weighed_Av( male_popn.age_70, male_popn_yp1.age_70 );
            targets.age_70_female := Q_Weighed_Av( female_popn.age_70, female_popn_yp1.age_70 );
            targets.age_71_male := Q_Weighed_Av( male_popn.age_71, male_popn_yp1.age_71 );
            targets.age_71_female := Q_Weighed_Av( female_popn.age_71, female_popn_yp1.age_71 );
            targets.age_72_male := Q_Weighed_Av( male_popn.age_72, male_popn_yp1.age_72 );
            targets.age_72_female := Q_Weighed_Av( female_popn.age_72, female_popn_yp1.age_72 );
            targets.age_73_male := Q_Weighed_Av( male_popn.age_73, male_popn_yp1.age_73 );
            targets.age_73_female := Q_Weighed_Av( female_popn.age_73, female_popn_yp1.age_73 );
            targets.age_74_male := Q_Weighed_Av( male_popn.age_74, male_popn_yp1.age_74 );
            targets.age_74_female := Q_Weighed_Av( female_popn.age_74, female_popn_yp1.age_74 );
            targets.age_75_male := Q_Weighed_Av( male_popn.age_75, male_popn_yp1.age_75 );
            targets.age_75_female := Q_Weighed_Av( female_popn.age_75, female_popn_yp1.age_75 );
            targets.age_76_male := Q_Weighed_Av( male_popn.age_76, male_popn_yp1.age_76 );
            targets.age_76_female := Q_Weighed_Av( female_popn.age_76, female_popn_yp1.age_76 );
            targets.age_77_male := Q_Weighed_Av( male_popn.age_77, male_popn_yp1.age_77 );
            targets.age_77_female := Q_Weighed_Av( female_popn.age_77, female_popn_yp1.age_77 );
            targets.age_78_male := Q_Weighed_Av( male_popn.age_78, male_popn_yp1.age_78 );
            targets.age_78_female := Q_Weighed_Av( female_popn.age_78, female_popn_yp1.age_78 );
            targets.age_79_male := Q_Weighed_Av( male_popn.age_79, male_popn_yp1.age_79 );
            targets.age_79_female := Q_Weighed_Av( female_popn.age_79, female_popn_yp1.age_79 );
            targets.age_80_male := Q_Weighed_Av( male_popn.age_80, male_popn_yp1.age_80 );
            targets.age_80_female := Q_Weighed_Av( female_popn.age_80, female_popn_yp1.age_80 );
            targets.age_81_male := Q_Weighed_Av( male_popn.age_81, male_popn_yp1.age_81 );
            targets.age_81_female := Q_Weighed_Av( female_popn.age_81, female_popn_yp1.age_81 );
            targets.age_82_male := Q_Weighed_Av( male_popn.age_82, male_popn_yp1.age_82 );
            targets.age_82_female := Q_Weighed_Av( female_popn.age_82, female_popn_yp1.age_82 );
            targets.age_83_male := Q_Weighed_Av( male_popn.age_83, male_popn_yp1.age_83 );
            targets.age_83_female := Q_Weighed_Av( female_popn.age_83, female_popn_yp1.age_83 );
            targets.age_84_male := Q_Weighed_Av( male_popn.age_84, male_popn_yp1.age_84 );
            targets.age_84_female := Q_Weighed_Av( female_popn.age_84, female_popn_yp1.age_84 );
            targets.age_85_male := Q_Weighed_Av( male_popn.age_85, male_popn_yp1.age_85 );
            targets.age_85_female := Q_Weighed_Av( female_popn.age_85, female_popn_yp1.age_85 );
            targets.age_86_male := Q_Weighed_Av( male_popn.age_86, male_popn_yp1.age_86 );
            targets.age_86_female := Q_Weighed_Av( female_popn.age_86, female_popn_yp1.age_86 );
            targets.age_87_male := Q_Weighed_Av( male_popn.age_87, male_popn_yp1.age_87 );
            targets.age_87_female := Q_Weighed_Av( female_popn.age_87, female_popn_yp1.age_87 );
            targets.age_88_male := Q_Weighed_Av( male_popn.age_88, male_popn_yp1.age_88 );
            targets.age_88_female := Q_Weighed_Av( female_popn.age_88, female_popn_yp1.age_88 );
            targets.age_89_male := Q_Weighed_Av( male_popn.age_89, male_popn_yp1.age_89 );
            targets.age_89_female := Q_Weighed_Av( female_popn.age_89, female_popn_yp1.age_89 );
            targets.age_90_male := Q_Weighed_Av( male_popn.age_90, male_popn_yp1.age_90 );
            targets.age_90_female := Q_Weighed_Av( female_popn.age_90, female_popn_yp1.age_90 );
            targets.age_91_male := Q_Weighed_Av( male_popn.age_91, male_popn_yp1.age_91 );
            targets.age_91_female := Q_Weighed_Av( female_popn.age_91, female_popn_yp1.age_91 );
            targets.age_92_male := Q_Weighed_Av( male_popn.age_92, male_popn_yp1.age_92 );
            targets.age_92_female := Q_Weighed_Av( female_popn.age_92, female_popn_yp1.age_92 );
            targets.age_93_male := Q_Weighed_Av( male_popn.age_93, male_popn_yp1.age_93 );
            targets.age_93_female := Q_Weighed_Av( female_popn.age_93, female_popn_yp1.age_93 );
            targets.age_94_male := Q_Weighed_Av( male_popn.age_94, male_popn_yp1.age_94 );
            targets.age_94_female := Q_Weighed_Av( female_popn.age_94, female_popn_yp1.age_94 );
            targets.age_95_male := Q_Weighed_Av( male_popn.age_95, male_popn_yp1.age_95 );
            targets.age_95_female := Q_Weighed_Av( female_popn.age_95, female_popn_yp1.age_95 );
            targets.age_96_male := Q_Weighed_Av( male_popn.age_96, male_popn_yp1.age_96 );
            targets.age_96_female := Q_Weighed_Av( female_popn.age_96, female_popn_yp1.age_96 );
            targets.age_97_male := Q_Weighed_Av( male_popn.age_97, male_popn_yp1.age_97 );
            targets.age_97_female := Q_Weighed_Av( female_popn.age_97, female_popn_yp1.age_97 );
            targets.age_98_male := Q_Weighed_Av( male_popn.age_98, male_popn_yp1.age_98 );
            targets.age_98_female := Q_Weighed_Av( female_popn.age_98, female_popn_yp1.age_98 );
            targets.age_99_male := Q_Weighed_Av( male_popn.age_99, male_popn_yp1.age_99 );
            targets.age_99_female := Q_Weighed_Av( female_popn.age_99, female_popn_yp1.age_99 );
            targets.age_100_male := Q_Weighed_Av( male_popn.age_100, male_popn_yp1.age_100 );
            targets.age_100_female := Q_Weighed_Av( female_popn.age_100, female_popn_yp1.age_100 );
            targets.age_101_male := Q_Weighed_Av( male_popn.age_101, male_popn_yp1.age_101 );
            targets.age_101_female := Q_Weighed_Av( female_popn.age_101, female_popn_yp1.age_101 );
            targets.age_102_male := Q_Weighed_Av( male_popn.age_102, male_popn_yp1.age_102 );
            targets.age_102_female := Q_Weighed_Av( female_popn.age_102, female_popn_yp1.age_102 );
            targets.age_103_male := Q_Weighed_Av( male_popn.age_103, male_popn_yp1.age_103 );
            targets.age_103_female := Q_Weighed_Av( female_popn.age_103, female_popn_yp1.age_103 );
            targets.age_104_male := Q_Weighed_Av( male_popn.age_104, male_popn_yp1.age_104 );
            targets.age_104_female := Q_Weighed_Av( female_popn.age_104, female_popn_yp1.age_104 );
            targets.age_105_male := Q_Weighed_Av( male_popn.age_105, male_popn_yp1.age_105 );
            targets.age_105_female := Q_Weighed_Av( female_popn.age_105, female_popn_yp1.age_105 );
            targets.age_106_male := Q_Weighed_Av( male_popn.age_106, male_popn_yp1.age_106 );
            targets.age_106_female := Q_Weighed_Av( female_popn.age_106, female_popn_yp1.age_106 );
            targets.age_107_male := Q_Weighed_Av( male_popn.age_107, male_popn_yp1.age_107 );
            targets.age_107_female := Q_Weighed_Av( female_popn.age_107, female_popn_yp1.age_107 );
            targets.age_108_male := Q_Weighed_Av( male_popn.age_108, male_popn_yp1.age_108 );
            targets.age_108_female := Q_Weighed_Av( female_popn.age_108, female_popn_yp1.age_108 );
            targets.age_109_male := Q_Weighed_Av( male_popn.age_109, male_popn_yp1.age_109 );
            targets.age_109_female := Q_Weighed_Av( female_popn.age_109, female_popn_yp1.age_109 );
            targets.age_110_male := Q_Weighed_Av( male_popn.age_110, male_popn_yp1.age_110 );
            targets.age_110_female := Q_Weighed_Av( female_popn.age_110, female_popn_yp1.age_110 );

            declare
               ages : Age_Range_Array := To_Array( targets );
               age_16_plus : Amount := Sum( ages, 16 );
            begin
               Log( "16 plus popn " & Format( age_16_plus ));
               targets.employed := macro_data.employment_rate * age_16_plus/100.0;
               targets.participation := macro_data.participation_rate * age_16_plus/100.0;
               targets.ilo_unemployed := macro_data.ilo_unemployment_rate * targets.participation / 100.0;
               Log( "on year " & year'Img & " unemp. rate " & Format( macro_data.ilo_unemployment_rate ) &
                    "age_16_plus " & Format( age_16_plus ) & " => ilo unemployed " & 
                    Format( targets.ilo_unemployed ));
                    
               targets.employee := macro_data.employee_rate * age_16_plus / 100.0;
            end;
            Log( To_String( targets )); 
            UKDS.Target_Data.Target_Dataset_IO.Save( targets );
         end;
      end loop;
   
   end Create_Dataset;    
      
   procedure Create_Dataset_2014( the_run : Run ) is
      pop_crit : d.Criteria;
      mac_crit : d.Criteria;
      hh_crit : d.Criteria;
   begin
      -- Population_Forecasts_IO.Add_Variant( pop_crit, the_run.people_source ); 
      -- Households_Forecasts_IO.Add_Variant( hh_crit, the_run.household_source );
      -- Macro_Forecasts_IO.Add_Variant( mac_crit, the_run.macro_source );
      for year in the_run.start_year .. the_run.end_year loop
         
         declare
            female_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => TuS( "persons" ),
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "FEMALES" )                           
            );
            
            male_popn : constant Population_Forecasts := Population_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => PERSONS,
               variant  => the_run.population_variant,
               country  => the_run.country,
               edition  => the_run.population_edition,
               target_group => TuS( "MALES" )                           
            );
            scottish_households : constant Households_Forecasts := Households_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => SCO,
               edition  => the_run.households_edition                   
            );
           england_hhlds : constant England_Households := England_Households_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => ENG,
               edition  => the_run.households_edition                   
            );
            wales_hhlds : constant Wales_Households := Wales_Households_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => WAL,
               edition  => the_run.households_edition                   
            );
            nireland_hhlds : constant Nireland_Households := Nireland_Households_IO.Retrieve_By_PK(
               year     => year,
               rec_type => HOUSEHOLDS,
               variant  => the_run.households_variant,
               country  => NIR,
               edition  => 2012 -- the_run.households_edition FIXME!!! only this one for NIRE                   
            );
            
            macro_data : constant Macro_Forecasts := Macro_Forecasts_IO.Retrieve_By_PK(
               year     => year,
               rec_type => MACRO,
               variant  => the_run.macro_variant,
               country  => UK, -- for now ..
               edition  => the_run.macro_edition                   
            );
            
            participation_males : constant Obr_Participation_Rates := Obr_Participation_Rates_IO.Retrieve_By_PK(
               year     => year,
               rec_type => PARTICIPATION,
               variant  => the_run.macro_variant,
               country  => UK,
               edition  => the_run.macro_edition,
               target_group => TuS( "MALES" )                           
            );
                        
            participation_females : constant Obr_Participation_Rates := Obr_Participation_Rates_IO.Retrieve_By_PK(
               year     => year,
               rec_type => PARTICIPATION,
               variant  => the_run.macro_variant,
               country  => UK,
               edition  => the_run.macro_edition,
               target_group => TuS( "FEMALES" )                           
            );
            
            age_16_plus : Amount := 0.0;
            targets     : Target_Dataset; 
         begin

            targets.run_id := the_run.run_id;
            targets.user_id := the_run.user_id;
            targets.year := year;
            targets.sernum := Sernum_Value'First;
            if scottish_households /= Null_Households_Forecasts then
               targets.sco_hhld_one_adult_male := scottish_households.one_adult_male;
               targets.sco_hhld_one_adult_female := scottish_households.one_adult_female;
               targets.sco_hhld_two_adults := scottish_households.two_adults;
               targets.sco_hhld_one_adult_one_child := scottish_households.one_adult_one_child;
               targets.sco_hhld_one_adult_two_plus_children := scottish_households.one_adult_two_plus_children;
               targets.sco_hhld_two_plus_adult_one_plus_children := scottish_households.two_plus_adult_one_plus_children;
               targets.sco_hhld_three_plus_person_all_adult := scottish_households.three_plus_person_all_adult;
               targets.household_all_households := targets.household_all_households + scottish_households.all_households;
               targets.country_scotland := scottish_households.all_households;
              Inc( targets.other_hh, 
                  scottish_households.one_adult_one_child +
                  scottish_households.one_adult_two_plus_children +
                  scottish_households.two_plus_adult_one_plus_children +
                  scottish_households.three_plus_person_all_adult
                      );               
               Inc( targets.two_adult_hh, scottish_households.two_adults );
               Inc( targets.one_adult_hh, scottish_households.one_adult_male + scottish_households.one_adult_female );
            end if;
            if england_hhlds /= Null_England_Households then   -- actually this is redundant since we'll assign to zero either way          
               targets.eng_hhld_one_person_households_male := england_hhlds.one_person_households_male;
               targets.eng_hhld_one_person_households_female := england_hhlds.one_person_households_female;
               targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi := england_hhlds.one_family_and_no_others_couple_no_dependent_children;
               targets.eng_hhld_a_couple_and_other_adults_no_dependent_children := england_hhlds.a_couple_and_one_or_more_other_adults_no_dependent_children;
               targets.eng_hhld_households_with_one_dependent_child := england_hhlds.households_with_one_dependent_child;
               targets.eng_hhld_households_with_two_dependent_children := england_hhlds.households_with_two_dependent_children;
               targets.eng_hhld_households_with_three_dependent_children := england_hhlds.households_with_three_dependent_children;
               targets.eng_hhld_other_households := england_hhlds.other_households;
               declare -- stupid - just have a sum field ..
                  s : constant Amount := 
                  targets.eng_hhld_one_person_households_male +
                  targets.eng_hhld_one_person_households_female +
                  targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi +
                  targets.eng_hhld_a_couple_and_other_adults_no_dependent_children +
                  targets.eng_hhld_households_with_one_dependent_child +
                  targets.eng_hhld_households_with_two_dependent_children +
                  targets.eng_hhld_households_with_three_dependent_children +
                  targets.eng_hhld_other_households;
               begin      
                  Inc( targets.household_all_households, s );
                  Inc( targets.country_england, s );              
               end;
               Inc( targets.other_hh, 
                  targets.eng_hhld_a_couple_and_other_adults_no_dependent_children +
                  targets.eng_hhld_households_with_one_dependent_child +
                  targets.eng_hhld_households_with_two_dependent_children +
                  targets.eng_hhld_households_with_three_dependent_children +
                  targets.eng_hhld_other_households                     
                   );               
               Inc( targets.two_adult_hh, targets.eng_hhld_one_family_and_no_others_couple_no_dependent_chi );
               Inc( targets.one_adult_hh, targets.eng_hhld_one_person_households_male +
                  targets.eng_hhld_one_person_households_female );
               
               
               
            end if;
            -- wales
            targets.wal_hhld_1_person := wales_hhlds.v_1_person;
            targets.wal_hhld_2_person_no_children := wales_hhlds.v_2_person_no_children;
            targets.wal_hhld_2_person_1_adult_1_child := wales_hhlds.v_2_person_1_adult_1_child;
            targets.wal_hhld_3_person_no_children := wales_hhlds.v_3_person_no_children;
            targets.wal_hhld_3_person_2_adults_1_child := wales_hhlds.v_3_person_2_adults_1_child;
            targets.wal_hhld_3_person_1_adult_2_children := wales_hhlds.v_3_person_1_adult_2_children;
            targets.wal_hhld_4_person_no_children := wales_hhlds.v_4_person_no_children;
            targets.wal_hhld_4_person_2_plus_adults_1_plus_children := wales_hhlds.v_4_person_2_plus_adults_1_plus_children;
            targets.wal_hhld_4_person_1_adult_3_children := wales_hhlds.v_4_person_1_adult_3_children;
            targets.wal_hhld_5_plus_person_no_children := wales_hhlds.v_5_plus_person_no_children;
            targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children := wales_hhlds.v_5_plus_person_2_plus_adults_1_plus_children;
            targets.wal_hhld_5_plus_person_1_adult_4_plus_children := wales_hhlds.v_5_plus_person_1_adult_4_plus_children;
            declare
               s : constant Amount := 
                  targets.wal_hhld_1_person +
                  targets.wal_hhld_2_person_no_children +
                  targets.wal_hhld_2_person_1_adult_1_child +
                  targets.wal_hhld_3_person_no_children +
                  targets.wal_hhld_3_person_2_adults_1_child +
                  targets.wal_hhld_3_person_1_adult_2_children +
                  targets.wal_hhld_4_person_no_children +
                  targets.wal_hhld_4_person_2_plus_adults_1_plus_children +
                  targets.wal_hhld_4_person_1_adult_3_children +
                  targets.wal_hhld_5_plus_person_no_children +
                  targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children +
                  targets.wal_hhld_5_plus_person_1_adult_4_plus_children;
            begin
               Inc( targets.household_all_households, s );
               Inc( targets.country_wales, s );              
            end;
            
            Inc( targets.other_hh, 
                  targets.wal_hhld_2_person_1_adult_1_child +
                  targets.wal_hhld_3_person_no_children +
                  targets.wal_hhld_3_person_2_adults_1_child +
                  targets.wal_hhld_3_person_1_adult_2_children +
                  targets.wal_hhld_4_person_no_children +
                  targets.wal_hhld_4_person_2_plus_adults_1_plus_children +
                  targets.wal_hhld_4_person_1_adult_3_children +
                  targets.wal_hhld_5_plus_person_no_children +
                  targets.wal_hhld_5_plus_person_2_plus_adults_1_plus_children +
                  targets.wal_hhld_5_plus_person_1_adult_4_plus_children
                );               
            Inc( targets.two_adult_hh, targets.wal_hhld_2_person_no_children );
            Inc( targets.one_adult_hh, targets.wal_hhld_1_person );
            
            
            targets.nir_hhld_one_adult_households := nireland_hhlds.one_adult_households;
            targets.nir_hhld_two_adults_without_children := nireland_hhlds.two_adults_without_children;
            targets.nir_hhld_other_households_without_children := nireland_hhlds.other_households_without_children;
            targets.nir_hhld_one_adult_households_with_children := nireland_hhlds.one_adult_households_with_children;
            targets.nir_hhld_other_households_with_children := nireland_hhlds.other_households_with_children;
            
            Inc( targets.other_hh, 
               nireland_hhlds.other_households_without_children + 
               nireland_hhlds.one_adult_households_with_children + 
               nireland_hhlds.other_households_with_children );               
            Inc( targets.two_adult_hh, nireland_hhlds.two_adults_without_children );
            Inc( targets.one_adult_hh, nireland_hhlds.one_adult_households );
            
            
            declare 
               s : constant Amount := 
               targets.nir_hhld_one_adult_households +
               targets.nir_hhld_two_adults_without_children +
               targets.nir_hhld_other_households_without_children +
               targets.nir_hhld_one_adult_households_with_children +
               targets.nir_hhld_other_households_with_children;
            begin
               Inc( targets.household_all_households, s );
               Inc( targets.country_n_ireland, s );              
            end;
            
            targets.age_0_male := male_popn.age_0;
            targets.age_0_female := female_popn.age_0;
            targets.age_1_male := male_popn.age_1;
            targets.age_1_female := female_popn.age_1;
            targets.age_2_male := male_popn.age_2;
            targets.age_2_female := female_popn.age_2;
            targets.age_3_male := male_popn.age_3;
            targets.age_3_female := female_popn.age_3;
            targets.age_4_male := male_popn.age_4;
            targets.age_4_female := female_popn.age_4;
            targets.age_5_male := male_popn.age_5;
            targets.age_5_female := female_popn.age_5;
            targets.age_6_male := male_popn.age_6;
            targets.age_6_female := female_popn.age_6;
            targets.age_7_male := male_popn.age_7;
            targets.age_7_female := female_popn.age_7;
            targets.age_8_male := male_popn.age_8;
            targets.age_8_female := female_popn.age_8;
            targets.age_9_male := male_popn.age_9;
            targets.age_9_female := female_popn.age_9;
            targets.age_10_male := male_popn.age_10;
            targets.age_10_female := female_popn.age_10;
            targets.age_11_male := male_popn.age_11;
            targets.age_11_female := female_popn.age_11;
            targets.age_12_male := male_popn.age_12;
            targets.age_12_female := female_popn.age_12;
            targets.age_13_male := male_popn.age_13;
            targets.age_13_female := female_popn.age_13;
            targets.age_14_male := male_popn.age_14;
            targets.age_14_female := female_popn.age_14;
            targets.age_15_male := male_popn.age_15;
            targets.age_15_female := female_popn.age_15;
            targets.age_16_male := male_popn.age_16;
            targets.age_16_female := female_popn.age_16;
            targets.age_17_male := male_popn.age_17;
            targets.age_17_female := female_popn.age_17;
            targets.age_18_male := male_popn.age_18;
            targets.age_18_female := female_popn.age_18;
            targets.age_19_male := male_popn.age_19;
            targets.age_19_female := female_popn.age_19;
            targets.age_20_male := male_popn.age_20;
            targets.age_20_female := female_popn.age_20;
            targets.age_21_male := male_popn.age_21;
            targets.age_21_female := female_popn.age_21;
            targets.age_22_male := male_popn.age_22;
            targets.age_22_female := female_popn.age_22;
            targets.age_23_male := male_popn.age_23;
            targets.age_23_female := female_popn.age_23;
            targets.age_24_male := male_popn.age_24;
            targets.age_24_female := female_popn.age_24;
            targets.age_25_male := male_popn.age_25;
            targets.age_25_female := female_popn.age_25;
            targets.age_26_male := male_popn.age_26;
            targets.age_26_female := female_popn.age_26;
            targets.age_27_male := male_popn.age_27;
            targets.age_27_female := female_popn.age_27;
            targets.age_28_male := male_popn.age_28;
            targets.age_28_female := female_popn.age_28;
            targets.age_29_male := male_popn.age_29;
            targets.age_29_female := female_popn.age_29;
            targets.age_30_male := male_popn.age_30;
            targets.age_30_female := female_popn.age_30;
            targets.age_31_male := male_popn.age_31;
            targets.age_31_female := female_popn.age_31;
            targets.age_32_male := male_popn.age_32;
            targets.age_32_female := female_popn.age_32;
            targets.age_33_male := male_popn.age_33;
            targets.age_33_female := female_popn.age_33;
            targets.age_34_male := male_popn.age_34;
            targets.age_34_female := female_popn.age_34;
            targets.age_35_male := male_popn.age_35;
            targets.age_35_female := female_popn.age_35;
            targets.age_36_male := male_popn.age_36;
            targets.age_36_female := female_popn.age_36;
            targets.age_37_male := male_popn.age_37;
            targets.age_37_female := female_popn.age_37;
            targets.age_38_male := male_popn.age_38;
            targets.age_38_female := female_popn.age_38;
            targets.age_39_male := male_popn.age_39;
            targets.age_39_female := female_popn.age_39;
            targets.age_40_male := male_popn.age_40;
            targets.age_40_female := female_popn.age_40;
            targets.age_41_male := male_popn.age_41;
            targets.age_41_female := female_popn.age_41;
            targets.age_42_male := male_popn.age_42;
            targets.age_42_female := female_popn.age_42;
            targets.age_43_male := male_popn.age_43;
            targets.age_43_female := female_popn.age_43;
            targets.age_44_male := male_popn.age_44;
            targets.age_44_female := female_popn.age_44;
            targets.age_45_male := male_popn.age_45;
            targets.age_45_female := female_popn.age_45;
            targets.age_46_male := male_popn.age_46;
            targets.age_46_female := female_popn.age_46;
            targets.age_47_male := male_popn.age_47;
            targets.age_47_female := female_popn.age_47;
            targets.age_48_male := male_popn.age_48;
            targets.age_48_female := female_popn.age_48;
            targets.age_49_male := male_popn.age_49;
            targets.age_49_female := female_popn.age_49;
            targets.age_50_male := male_popn.age_50;
            targets.age_50_female := female_popn.age_50;
            targets.age_51_male := male_popn.age_51;
            targets.age_51_female := female_popn.age_51;
            targets.age_52_male := male_popn.age_52;
            targets.age_52_female := female_popn.age_52;
            targets.age_53_male := male_popn.age_53;
            targets.age_53_female := female_popn.age_53;
            targets.age_54_male := male_popn.age_54;
            targets.age_54_female := female_popn.age_54;
            targets.age_55_male := male_popn.age_55;
            targets.age_55_female := female_popn.age_55;
            targets.age_56_male := male_popn.age_56;
            targets.age_56_female := female_popn.age_56;
            targets.age_57_male := male_popn.age_57;
            targets.age_57_female := female_popn.age_57;
            targets.age_58_male := male_popn.age_58;
            targets.age_58_female := female_popn.age_58;
            targets.age_59_male := male_popn.age_59;
            targets.age_59_female := female_popn.age_59;
            targets.age_60_male := male_popn.age_60;
            targets.age_60_female := female_popn.age_60;
            targets.age_61_male := male_popn.age_61;
            targets.age_61_female := female_popn.age_61;
            targets.age_62_male := male_popn.age_62;
            targets.age_62_female := female_popn.age_62;
            targets.age_63_male := male_popn.age_63;
            targets.age_63_female := female_popn.age_63;
            targets.age_64_male := male_popn.age_64;
            targets.age_64_female := female_popn.age_64;
            targets.age_65_male := male_popn.age_65;
            targets.age_65_female := female_popn.age_65;
            targets.age_66_male := male_popn.age_66;
            targets.age_66_female := female_popn.age_66;
            targets.age_67_male := male_popn.age_67;
            targets.age_67_female := female_popn.age_67;
            targets.age_68_male := male_popn.age_68;
            targets.age_68_female := female_popn.age_68;
            targets.age_69_male := male_popn.age_69;
            targets.age_69_female := female_popn.age_69;
            targets.age_70_male := male_popn.age_70;
            targets.age_70_female := female_popn.age_70;
            targets.age_71_male := male_popn.age_71;
            targets.age_71_female := female_popn.age_71;
            targets.age_72_male := male_popn.age_72;
            targets.age_72_female := female_popn.age_72;
            targets.age_73_male := male_popn.age_73;
            targets.age_73_female := female_popn.age_73;
            targets.age_74_male := male_popn.age_74;
            targets.age_74_female := female_popn.age_74;
            targets.age_75_male := male_popn.age_75;
            targets.age_75_female := female_popn.age_75;
            targets.age_76_male := male_popn.age_76;
            targets.age_76_female := female_popn.age_76;
            targets.age_77_male := male_popn.age_77;
            targets.age_77_female := female_popn.age_77;
            targets.age_78_male := male_popn.age_78;
            targets.age_78_female := female_popn.age_78;
            targets.age_79_male := male_popn.age_79;
            targets.age_79_female := female_popn.age_79;
            targets.age_80_male := male_popn.age_80;
            targets.age_80_female := female_popn.age_80;
            targets.age_81_male := male_popn.age_81;
            targets.age_81_female := female_popn.age_81;
            targets.age_82_male := male_popn.age_82;
            targets.age_82_female := female_popn.age_82;
            targets.age_83_male := male_popn.age_83;
            targets.age_83_female := female_popn.age_83;
            targets.age_84_male := male_popn.age_84;
            targets.age_84_female := female_popn.age_84;
            targets.age_85_male := male_popn.age_85;
            targets.age_85_female := female_popn.age_85;
            targets.age_86_male := male_popn.age_86;
            targets.age_86_female := female_popn.age_86;
            targets.age_87_male := male_popn.age_87;
            targets.age_87_female := female_popn.age_87;
            targets.age_88_male := male_popn.age_88;
            targets.age_88_female := female_popn.age_88;
            targets.age_89_male := male_popn.age_89;
            targets.age_89_female := female_popn.age_89;
            targets.age_90_male := male_popn.age_90;
            targets.age_90_female := female_popn.age_90;
            targets.age_91_male := male_popn.age_91;
            targets.age_91_female := female_popn.age_91;
            targets.age_92_male := male_popn.age_92;
            targets.age_92_female := female_popn.age_92;
            targets.age_93_male := male_popn.age_93;
            targets.age_93_female := female_popn.age_93;
            targets.age_94_male := male_popn.age_94;
            targets.age_94_female := female_popn.age_94;
            targets.age_95_male := male_popn.age_95;
            targets.age_95_female := female_popn.age_95;
            targets.age_96_male := male_popn.age_96;
            targets.age_96_female := female_popn.age_96;
            targets.age_97_male := male_popn.age_97;
            targets.age_97_female := female_popn.age_97;
            targets.age_98_male := male_popn.age_98;
            targets.age_98_female := female_popn.age_98;
            targets.age_99_male := male_popn.age_99;
            targets.age_99_female := female_popn.age_99;
            targets.age_100_male := male_popn.age_100;
            targets.age_100_female := female_popn.age_100;
            targets.age_101_male := male_popn.age_101;
            targets.age_101_female := female_popn.age_101;
            targets.age_102_male := male_popn.age_102;
            targets.age_102_female := female_popn.age_102;
            targets.age_103_male := male_popn.age_103;
            targets.age_103_female := female_popn.age_103;
            targets.age_104_male := male_popn.age_104;
            targets.age_104_female := female_popn.age_104;
            targets.age_105_male := male_popn.age_105;
            targets.age_105_female := female_popn.age_105;
            targets.age_106_male := male_popn.age_106;
            targets.age_106_female := female_popn.age_106;
            targets.age_107_male := male_popn.age_107;
            targets.age_107_female := female_popn.age_107;
            targets.age_108_male := male_popn.age_108;
            targets.age_108_female := female_popn.age_108;
            targets.age_109_male := male_popn.age_109;
            targets.age_109_female := female_popn.age_109;
            targets.age_110_male := male_popn.age_110;
            targets.age_110_female := female_popn.age_110;
                       
            Inc( targets.male, male_popn.age_0 );
            Inc( targets.female, female_popn.age_0 );
            Inc( targets.male, male_popn.age_1 );
            Inc( targets.female, female_popn.age_1 );
            Inc( targets.male, male_popn.age_2 );
            Inc( targets.female, female_popn.age_2 );
            Inc( targets.male, male_popn.age_3 );
            Inc( targets.female, female_popn.age_3 );
            Inc( targets.male, male_popn.age_4 );
            Inc( targets.female, female_popn.age_4 );
            Inc( targets.male, male_popn.age_5 );
            Inc( targets.female, female_popn.age_5 );
            Inc( targets.male, male_popn.age_6 );
            Inc( targets.female, female_popn.age_6 );
            Inc( targets.male, male_popn.age_7 );
            Inc( targets.female, female_popn.age_7 );
            Inc( targets.male, male_popn.age_8 );
            Inc( targets.female, female_popn.age_8 );
            Inc( targets.male, male_popn.age_9 );
            Inc( targets.female, female_popn.age_9 );
            Inc( targets.male, male_popn.age_10 );
            Inc( targets.female, female_popn.age_10 );
            Inc( targets.male, male_popn.age_11 );
            Inc( targets.female, female_popn.age_11 );
            Inc( targets.male, male_popn.age_12 );
            Inc( targets.female, female_popn.age_12 );
            Inc( targets.male, male_popn.age_13 );
            Inc( targets.female, female_popn.age_13 );
            Inc( targets.male, male_popn.age_14 );
            Inc( targets.female, female_popn.age_14 );
            Inc( targets.male, male_popn.age_15 );
            Inc( targets.female, female_popn.age_15 );
            Inc( targets.male, male_popn.age_16 );
            Inc( targets.female, female_popn.age_16 );
            Inc( targets.male, male_popn.age_17 );
            Inc( targets.female, female_popn.age_17 );
            Inc( targets.male, male_popn.age_18 );
            Inc( targets.female, female_popn.age_18 );
            Inc( targets.male, male_popn.age_19 );
            Inc( targets.female, female_popn.age_19 );
            Inc( targets.male, male_popn.age_20 );
            Inc( targets.female, female_popn.age_20 );
            Inc( targets.male, male_popn.age_21 );
            Inc( targets.female, female_popn.age_21 );
            Inc( targets.male, male_popn.age_22 );
            Inc( targets.female, female_popn.age_22 );
            Inc( targets.male, male_popn.age_23 );
            Inc( targets.female, female_popn.age_23 );
            Inc( targets.male, male_popn.age_24 );
            Inc( targets.female, female_popn.age_24 );
            Inc( targets.male, male_popn.age_25 );
            Inc( targets.female, female_popn.age_25 );
            Inc( targets.male, male_popn.age_26 );
            Inc( targets.female, female_popn.age_26 );
            Inc( targets.male, male_popn.age_27 );
            Inc( targets.female, female_popn.age_27 );
            Inc( targets.male, male_popn.age_28 );
            Inc( targets.female, female_popn.age_28 );
            Inc( targets.male, male_popn.age_29 );
            Inc( targets.female, female_popn.age_29 );
            Inc( targets.male, male_popn.age_30 );
            Inc( targets.female, female_popn.age_30 );
            Inc( targets.male, male_popn.age_31 );
            Inc( targets.female, female_popn.age_31 );
            Inc( targets.male, male_popn.age_32 );
            Inc( targets.female, female_popn.age_32 );
            Inc( targets.male, male_popn.age_33 );
            Inc( targets.female, female_popn.age_33 );
            Inc( targets.male, male_popn.age_34 );
            Inc( targets.female, female_popn.age_34 );
            Inc( targets.male, male_popn.age_35 );
            Inc( targets.female, female_popn.age_35 );
            Inc( targets.male, male_popn.age_36 );
            Inc( targets.female, female_popn.age_36 );
            Inc( targets.male, male_popn.age_37 );
            Inc( targets.female, female_popn.age_37 );
            Inc( targets.male, male_popn.age_38 );
            Inc( targets.female, female_popn.age_38 );
            Inc( targets.male, male_popn.age_39 );
            Inc( targets.female, female_popn.age_39 );
            Inc( targets.male, male_popn.age_40 );
            Inc( targets.female, female_popn.age_40 );
            Inc( targets.male, male_popn.age_41 );
            Inc( targets.female, female_popn.age_41 );
            Inc( targets.male, male_popn.age_42 );
            Inc( targets.female, female_popn.age_42 );
            Inc( targets.male, male_popn.age_43 );
            Inc( targets.female, female_popn.age_43 );
            Inc( targets.male, male_popn.age_44 );
            Inc( targets.female, female_popn.age_44 );
            Inc( targets.male, male_popn.age_45 );
            Inc( targets.female, female_popn.age_45 );
            Inc( targets.male, male_popn.age_46 );
            Inc( targets.female, female_popn.age_46 );
            Inc( targets.male, male_popn.age_47 );
            Inc( targets.female, female_popn.age_47 );
            Inc( targets.male, male_popn.age_48 );
            Inc( targets.female, female_popn.age_48 );
            Inc( targets.male, male_popn.age_49 );
            Inc( targets.female, female_popn.age_49 );
            Inc( targets.male, male_popn.age_50 );
            Inc( targets.female, female_popn.age_50 );
            Inc( targets.male, male_popn.age_51 );
            Inc( targets.female, female_popn.age_51 );
            Inc( targets.male, male_popn.age_52 );
            Inc( targets.female, female_popn.age_52 );
            Inc( targets.male, male_popn.age_53 );
            Inc( targets.female, female_popn.age_53 );
            Inc( targets.male, male_popn.age_54 );
            Inc( targets.female, female_popn.age_54 );
            Inc( targets.male, male_popn.age_55 );
            Inc( targets.female, female_popn.age_55 );
            Inc( targets.male, male_popn.age_56 );
            Inc( targets.female, female_popn.age_56 );
            Inc( targets.male, male_popn.age_57 );
            Inc( targets.female, female_popn.age_57 );
            Inc( targets.male, male_popn.age_58 );
            Inc( targets.female, female_popn.age_58 );
            Inc( targets.male, male_popn.age_59 );
            Inc( targets.female, female_popn.age_59 );
            Inc( targets.male, male_popn.age_60 );
            Inc( targets.female, female_popn.age_60 );
            Inc( targets.male, male_popn.age_61 );
            Inc( targets.female, female_popn.age_61 );
            Inc( targets.male, male_popn.age_62 );
            Inc( targets.female, female_popn.age_62 );
            Inc( targets.male, male_popn.age_63 );
            Inc( targets.female, female_popn.age_63 );
            Inc( targets.male, male_popn.age_64 );
            Inc( targets.female, female_popn.age_64 );
            Inc( targets.male, male_popn.age_65 );
            Inc( targets.female, female_popn.age_65 );
            Inc( targets.male, male_popn.age_66 );
            Inc( targets.female, female_popn.age_66 );
            Inc( targets.male, male_popn.age_67 );
            Inc( targets.female, female_popn.age_67 );
            Inc( targets.male, male_popn.age_68 );
            Inc( targets.female, female_popn.age_68 );
            Inc( targets.male, male_popn.age_69 );
            Inc( targets.female, female_popn.age_69 );
            Inc( targets.male, male_popn.age_70 );
            Inc( targets.female, female_popn.age_70 );
            Inc( targets.male, male_popn.age_71 );
            Inc( targets.female, female_popn.age_71 );
            Inc( targets.male, male_popn.age_72 );
            Inc( targets.female, female_popn.age_72 );
            Inc( targets.male, male_popn.age_73 );
            Inc( targets.female, female_popn.age_73 );
            Inc( targets.male, male_popn.age_74 );
            Inc( targets.female, female_popn.age_74 );
            Inc( targets.male, male_popn.age_75 );
            Inc( targets.female, female_popn.age_75 );
            Inc( targets.male, male_popn.age_76 );
            Inc( targets.female, female_popn.age_76 );
            Inc( targets.male, male_popn.age_77 );
            Inc( targets.female, female_popn.age_77 );
            Inc( targets.male, male_popn.age_78 );
            Inc( targets.female, female_popn.age_78 );
            Inc( targets.male, male_popn.age_79 );
            Inc( targets.female, female_popn.age_79 );
            Inc( targets.male, male_popn.age_80 );
            Inc( targets.female, female_popn.age_80 );
            Inc( targets.male, male_popn.age_81 );
            Inc( targets.female, female_popn.age_81 );
            Inc( targets.male, male_popn.age_82 );
            Inc( targets.female, female_popn.age_82 );
            Inc( targets.male, male_popn.age_83 );
            Inc( targets.female, female_popn.age_83 );
            Inc( targets.male, male_popn.age_84 );
            Inc( targets.female, female_popn.age_84 );
            Inc( targets.male, male_popn.age_85 );
            Inc( targets.female, female_popn.age_85 );
            Inc( targets.male, male_popn.age_86 );
            Inc( targets.female, female_popn.age_86 );
            Inc( targets.male, male_popn.age_87 );
            Inc( targets.female, female_popn.age_87 );
            Inc( targets.male, male_popn.age_88 );
            Inc( targets.female, female_popn.age_88 );
            Inc( targets.male, male_popn.age_89 );
            Inc( targets.female, female_popn.age_89 );
            Inc( targets.male, male_popn.age_90 );
            Inc( targets.female, female_popn.age_90 );
            Inc( targets.male, male_popn.age_91 );
            Inc( targets.female, female_popn.age_91 );
            Inc( targets.male, male_popn.age_92 );
            Inc( targets.female, female_popn.age_92 );
            Inc( targets.male, male_popn.age_93 );
            Inc( targets.female, female_popn.age_93 );
            Inc( targets.male, male_popn.age_94 );
            Inc( targets.female, female_popn.age_94 );
            Inc( targets.male, male_popn.age_95 );
            Inc( targets.female, female_popn.age_95 );
            Inc( targets.male, male_popn.age_96 );
            Inc( targets.female, female_popn.age_96 );
            Inc( targets.male, male_popn.age_97 );
            Inc( targets.female, female_popn.age_97 );
            Inc( targets.male, male_popn.age_98 );
            Inc( targets.female, female_popn.age_98 );
            Inc( targets.male, male_popn.age_99 );
            Inc( targets.female, female_popn.age_99 );
            Inc( targets.male, male_popn.age_100 );
            Inc( targets.female, female_popn.age_100 );
            Inc( targets.male, male_popn.age_101 );
            Inc( targets.female, female_popn.age_101 );
            Inc( targets.male, male_popn.age_102 );
            Inc( targets.female, female_popn.age_102 );
            Inc( targets.male, male_popn.age_103 );
            Inc( targets.female, female_popn.age_103 );
            Inc( targets.male, male_popn.age_104 );
            Inc( targets.female, female_popn.age_104 );
            Inc( targets.male, male_popn.age_105 );
            Inc( targets.female, female_popn.age_105 );
            Inc( targets.male, male_popn.age_106 );
            Inc( targets.female, female_popn.age_106 );
            Inc( targets.male, male_popn.age_107 );
            Inc( targets.female, female_popn.age_107 );
            Inc( targets.male, male_popn.age_108 );
            Inc( targets.female, female_popn.age_108 );
            Inc( targets.male, male_popn.age_109 );
            Inc( targets.female, female_popn.age_109 );
            Inc( targets.male, male_popn.age_110 );
            Inc( targets.female, female_popn.age_110 );
            Inc( age_16_plus, male_popn.age_16 + female_popn.age_16 );
            Inc( age_16_plus, male_popn.age_17 + female_popn.age_17 );
            Inc( age_16_plus, male_popn.age_18 + female_popn.age_18 );
            Inc( age_16_plus, male_popn.age_19 + female_popn.age_19 );
            Inc( age_16_plus, male_popn.age_20 + female_popn.age_20 );
            Inc( age_16_plus, male_popn.age_21 + female_popn.age_21 );
            Inc( age_16_plus, male_popn.age_22 + female_popn.age_22 );
            Inc( age_16_plus, male_popn.age_23 + female_popn.age_23 );
            Inc( age_16_plus, male_popn.age_24 + female_popn.age_24 );
            Inc( age_16_plus, male_popn.age_25 + female_popn.age_25 );
            Inc( age_16_plus, male_popn.age_26 + female_popn.age_26 );
            Inc( age_16_plus, male_popn.age_27 + female_popn.age_27 );
            Inc( age_16_plus, male_popn.age_28 + female_popn.age_28 );
            Inc( age_16_plus, male_popn.age_29 + female_popn.age_29 );
            Inc( age_16_plus, male_popn.age_30 + female_popn.age_30 );
            Inc( age_16_plus, male_popn.age_31 + female_popn.age_31 );
            Inc( age_16_plus, male_popn.age_32 + female_popn.age_32 );
            Inc( age_16_plus, male_popn.age_33 + female_popn.age_33 );
            Inc( age_16_plus, male_popn.age_34 + female_popn.age_34 );
            Inc( age_16_plus, male_popn.age_35 + female_popn.age_35 );
            Inc( age_16_plus, male_popn.age_36 + female_popn.age_36 );
            Inc( age_16_plus, male_popn.age_37 + female_popn.age_37 );
            Inc( age_16_plus, male_popn.age_38 + female_popn.age_38 );
            Inc( age_16_plus, male_popn.age_39 + female_popn.age_39 );
            Inc( age_16_plus, male_popn.age_40 + female_popn.age_40 );
            Inc( age_16_plus, male_popn.age_41 + female_popn.age_41 );
            Inc( age_16_plus, male_popn.age_42 + female_popn.age_42 );
            Inc( age_16_plus, male_popn.age_43 + female_popn.age_43 );
            Inc( age_16_plus, male_popn.age_44 + female_popn.age_44 );
            Inc( age_16_plus, male_popn.age_45 + female_popn.age_45 );
            Inc( age_16_plus, male_popn.age_46 + female_popn.age_46 );
            Inc( age_16_plus, male_popn.age_47 + female_popn.age_47 );
            Inc( age_16_plus, male_popn.age_48 + female_popn.age_48 );
            Inc( age_16_plus, male_popn.age_49 + female_popn.age_49 );
            Inc( age_16_plus, male_popn.age_50 + female_popn.age_50 );
            Inc( age_16_plus, male_popn.age_51 + female_popn.age_51 );
            Inc( age_16_plus, male_popn.age_52 + female_popn.age_52 );
            Inc( age_16_plus, male_popn.age_53 + female_popn.age_53 );
            Inc( age_16_plus, male_popn.age_54 + female_popn.age_54 );
            Inc( age_16_plus, male_popn.age_55 + female_popn.age_55 );
            Inc( age_16_plus, male_popn.age_56 + female_popn.age_56 );
            Inc( age_16_plus, male_popn.age_57 + female_popn.age_57 );
            Inc( age_16_plus, male_popn.age_58 + female_popn.age_58 );
            Inc( age_16_plus, male_popn.age_59 + female_popn.age_59 );
            Inc( age_16_plus, male_popn.age_60 + female_popn.age_60 );
            Inc( age_16_plus, male_popn.age_61 + female_popn.age_61 );
            Inc( age_16_plus, male_popn.age_62 + female_popn.age_62 );
            Inc( age_16_plus, male_popn.age_63 + female_popn.age_63 );
            Inc( age_16_plus, male_popn.age_64 + female_popn.age_64 );
            Inc( age_16_plus, male_popn.age_65 + female_popn.age_65 );
            Inc( age_16_plus, male_popn.age_66 + female_popn.age_66 );
            Inc( age_16_plus, male_popn.age_67 + female_popn.age_67 );
            Inc( age_16_plus, male_popn.age_68 + female_popn.age_68 );
            Inc( age_16_plus, male_popn.age_69 + female_popn.age_69 );
            Inc( age_16_plus, male_popn.age_70 + female_popn.age_70 );
            Inc( age_16_plus, male_popn.age_71 + female_popn.age_71 );
            Inc( age_16_plus, male_popn.age_72 + female_popn.age_72 );
            Inc( age_16_plus, male_popn.age_73 + female_popn.age_73 );
            Inc( age_16_plus, male_popn.age_74 + female_popn.age_74 );
            Inc( age_16_plus, male_popn.age_75 + female_popn.age_75 );
            Inc( age_16_plus, male_popn.age_76 + female_popn.age_76 );
            Inc( age_16_plus, male_popn.age_77 + female_popn.age_77 );
            Inc( age_16_plus, male_popn.age_78 + female_popn.age_78 );
            Inc( age_16_plus, male_popn.age_79 + female_popn.age_79 );
            Inc( age_16_plus, male_popn.age_80 + female_popn.age_80 );
            Inc( age_16_plus, male_popn.age_81 + female_popn.age_81 );
            Inc( age_16_plus, male_popn.age_82 + female_popn.age_82 );
            Inc( age_16_plus, male_popn.age_83 + female_popn.age_83 );
            Inc( age_16_plus, male_popn.age_84 + female_popn.age_84 );
            Inc( age_16_plus, male_popn.age_85 + female_popn.age_85 );
            Inc( age_16_plus, male_popn.age_86 + female_popn.age_86 );
            Inc( age_16_plus, male_popn.age_87 + female_popn.age_87 );
            Inc( age_16_plus, male_popn.age_88 + female_popn.age_88 );
            Inc( age_16_plus, male_popn.age_89 + female_popn.age_89 );
            Inc( age_16_plus, male_popn.age_90 + female_popn.age_90 );
            Inc( age_16_plus, male_popn.age_91 + female_popn.age_91 );
            Inc( age_16_plus, male_popn.age_92 + female_popn.age_92 );
            Inc( age_16_plus, male_popn.age_93 + female_popn.age_93 );
            Inc( age_16_plus, male_popn.age_94 + female_popn.age_94 );
            Inc( age_16_plus, male_popn.age_95 + female_popn.age_95 );
            Inc( age_16_plus, male_popn.age_96 + female_popn.age_96 );
            Inc( age_16_plus, male_popn.age_97 + female_popn.age_97 );
            Inc( age_16_plus, male_popn.age_98 + female_popn.age_98 );
            Inc( age_16_plus, male_popn.age_99 + female_popn.age_99 );
            Inc( age_16_plus, male_popn.age_100 + female_popn.age_100 );
            Inc( age_16_plus, male_popn.age_101 + female_popn.age_101 );
            Inc( age_16_plus, male_popn.age_102 + female_popn.age_102 );
            Inc( age_16_plus, male_popn.age_103 + female_popn.age_103 );
            Inc( age_16_plus, male_popn.age_104 + female_popn.age_104 );
            Inc( age_16_plus, male_popn.age_105 + female_popn.age_105 );
            Inc( age_16_plus, male_popn.age_106 + female_popn.age_106 );
            Inc( age_16_plus, male_popn.age_107 + female_popn.age_107 );
            Inc( age_16_plus, male_popn.age_108 + female_popn.age_108 );
            Inc( age_16_plus, male_popn.age_109 + female_popn.age_109 );
            Inc( age_16_plus, male_popn.age_110 + female_popn.age_110 );
            -- targets.age_0 := male_popn.age_0 + female_popn.age_0;
            -- targets.age_1 := male_popn.age_1 + female_popn.age_1;
            -- targets.age_2 := male_popn.age_2 + female_popn.age_2;
            -- targets.age_3 := male_popn.age_3 + female_popn.age_3;
            -- targets.age_4 := male_popn.age_4 + female_popn.age_4;
            -- targets.age_5 := male_popn.age_5 + female_popn.age_5;
            -- targets.age_6 := male_popn.age_6 + female_popn.age_6;
            -- targets.age_7 := male_popn.age_7 + female_popn.age_7;
            -- targets.age_8 := male_popn.age_8 + female_popn.age_8;
            -- targets.age_9 := male_popn.age_9 + female_popn.age_9;
            -- targets.age_10 := male_popn.age_10 + female_popn.age_10;
            -- targets.age_11 := male_popn.age_11 + female_popn.age_11;
            -- targets.age_12 := male_popn.age_12 + female_popn.age_12;
            -- targets.age_13 := male_popn.age_13 + female_popn.age_13;
            -- targets.age_14 := male_popn.age_14 + female_popn.age_14;
            -- targets.age_15 := male_popn.age_15 + female_popn.age_15;
            -- targets.age_16 := male_popn.age_16 + female_popn.age_16;
            -- targets.age_17 := male_popn.age_17 + female_popn.age_17;
            -- targets.age_18 := male_popn.age_18 + female_popn.age_18;
            -- targets.age_19 := male_popn.age_19 + female_popn.age_19;
            -- targets.age_20 := male_popn.age_20 + female_popn.age_20;
            -- targets.age_21 := male_popn.age_21 + female_popn.age_21;
            -- targets.age_22 := male_popn.age_22 + female_popn.age_22;
            -- targets.age_23 := male_popn.age_23 + female_popn.age_23;
            -- targets.age_24 := male_popn.age_24 + female_popn.age_24;
            -- targets.age_25 := male_popn.age_25 + female_popn.age_25;
            -- targets.age_26 := male_popn.age_26 + female_popn.age_26;
            -- targets.age_27 := male_popn.age_27 + female_popn.age_27;
            -- targets.age_28 := male_popn.age_28 + female_popn.age_28;
            -- targets.age_29 := male_popn.age_29 + female_popn.age_29;
            -- targets.age_30 := male_popn.age_30 + female_popn.age_30;
            -- targets.age_31 := male_popn.age_31 + female_popn.age_31;
            -- targets.age_32 := male_popn.age_32 + female_popn.age_32;
            -- targets.age_33 := male_popn.age_33 + female_popn.age_33;
            -- targets.age_34 := male_popn.age_34 + female_popn.age_34;
            -- targets.age_35 := male_popn.age_35 + female_popn.age_35;
            -- targets.age_36 := male_popn.age_36 + female_popn.age_36;
            -- targets.age_37 := male_popn.age_37 + female_popn.age_37;
            -- targets.age_38 := male_popn.age_38 + female_popn.age_38;
            -- targets.age_39 := male_popn.age_39 + female_popn.age_39;
            -- targets.age_40 := male_popn.age_40 + female_popn.age_40;
            -- targets.age_41 := male_popn.age_41 + female_popn.age_41;
            -- targets.age_42 := male_popn.age_42 + female_popn.age_42;
            -- targets.age_43 := male_popn.age_43 + female_popn.age_43;
            -- targets.age_44 := male_popn.age_44 + female_popn.age_44;
            -- targets.age_45 := male_popn.age_45 + female_popn.age_45;
            -- targets.age_46 := male_popn.age_46 + female_popn.age_46;
            -- targets.age_47 := male_popn.age_47 + female_popn.age_47;
            -- targets.age_48 := male_popn.age_48 + female_popn.age_48;
            -- targets.age_49 := male_popn.age_49 + female_popn.age_49;
            -- targets.age_50 := male_popn.age_50 + female_popn.age_50;
            -- targets.age_51 := male_popn.age_51 + female_popn.age_51;
            -- targets.age_52 := male_popn.age_52 + female_popn.age_52;
            -- targets.age_53 := male_popn.age_53 + female_popn.age_53;
            -- targets.age_54 := male_popn.age_54 + female_popn.age_54;
            -- targets.age_55 := male_popn.age_55 + female_popn.age_55;
            -- targets.age_56 := male_popn.age_56 + female_popn.age_56;
            -- targets.age_57 := male_popn.age_57 + female_popn.age_57;
            -- targets.age_58 := male_popn.age_58 + female_popn.age_58;
            -- targets.age_59 := male_popn.age_59 + female_popn.age_59;
            -- targets.age_60 := male_popn.age_60 + female_popn.age_60;
            -- targets.age_61 := male_popn.age_61 + female_popn.age_61;
            -- targets.age_62 := male_popn.age_62 + female_popn.age_62;
            -- targets.age_63 := male_popn.age_63 + female_popn.age_63;
            -- targets.age_64 := male_popn.age_64 + female_popn.age_64;
            -- targets.age_65 := male_popn.age_65 + female_popn.age_65;
            -- targets.age_66 := male_popn.age_66 + female_popn.age_66;
            -- targets.age_67 := male_popn.age_67 + female_popn.age_67;
            -- targets.age_68 := male_popn.age_68 + female_popn.age_68;
            -- targets.age_69 := male_popn.age_69 + female_popn.age_69;
            -- targets.age_70 := male_popn.age_70 + female_popn.age_70;
            -- targets.age_71 := male_popn.age_71 + female_popn.age_71;
            -- targets.age_72 := male_popn.age_72 + female_popn.age_72;
            -- targets.age_73 := male_popn.age_73 + female_popn.age_73;
            -- targets.age_74 := male_popn.age_74 + female_popn.age_74;
            -- targets.age_75 := male_popn.age_75 + female_popn.age_75;
            -- targets.age_76 := male_popn.age_76 + female_popn.age_76;
            -- targets.age_77 := male_popn.age_77 + female_popn.age_77;
            -- targets.age_78 := male_popn.age_78 + female_popn.age_78;
            -- targets.age_79 := male_popn.age_79 + female_popn.age_79;
            -- targets.age_80 := male_popn.age_80 + female_popn.age_80;
            -- targets.age_81 := male_popn.age_81 + female_popn.age_81;
            -- targets.age_82 := male_popn.age_82 + female_popn.age_82;
            -- targets.age_83 := male_popn.age_83 + female_popn.age_83;
            -- targets.age_84 := male_popn.age_84 + female_popn.age_84;
            -- targets.age_85 := male_popn.age_85 + female_popn.age_85;
            -- targets.age_86 := male_popn.age_86 + female_popn.age_86;
            -- targets.age_87 := male_popn.age_87 + female_popn.age_87;
            -- targets.age_88 := male_popn.age_88 + female_popn.age_88;
            -- targets.age_89 := male_popn.age_89 + female_popn.age_89;
            -- targets.age_90 := male_popn.age_90 + female_popn.age_90;
            -- targets.age_91 := male_popn.age_91 + female_popn.age_91;
            -- targets.age_92 := male_popn.age_92 + female_popn.age_92;
            -- targets.age_93 := male_popn.age_93 + female_popn.age_93;
            -- targets.age_94 := male_popn.age_94 + female_popn.age_94;
            -- targets.age_95 := male_popn.age_95 + female_popn.age_95;
            -- targets.age_96 := male_popn.age_96 + female_popn.age_96;
            -- targets.age_97 := male_popn.age_97 + female_popn.age_97;
            -- targets.age_98 := male_popn.age_98 + female_popn.age_98;
            -- targets.age_99 := male_popn.age_99 + female_popn.age_99;
            -- targets.age_100 := male_popn.age_100 + female_popn.age_100;
            -- targets.age_101 := male_popn.age_101 + female_popn.age_101;
            -- targets.age_102 := male_popn.age_102 + female_popn.age_102;
            -- targets.age_103 := male_popn.age_103 + female_popn.age_103;
            -- targets.age_104 := male_popn.age_104 + female_popn.age_104;
            -- targets.age_105 := male_popn.age_105 + female_popn.age_105;
            -- targets.age_106 := male_popn.age_106 + female_popn.age_106;
            -- targets.age_107 := male_popn.age_107 + female_popn.age_107;
            -- targets.age_108 := male_popn.age_108 + female_popn.age_108;
            -- targets.age_109 := male_popn.age_109 + female_popn.age_109;
            -- targets.age_110 := male_popn.age_110 + female_popn.age_110;     
            
            targets.employed := age_16_plus * macro_data.employment_rate/100.0;
            targets.ilo_unemployed := age_16_plus * macro_data.ilo_unemployment_rate/100.0;
            
            targets.participation_16_19_male := (
               male_popn.age_16+
               male_popn.age_17+
               male_popn.age_18+
               male_popn.age_19 ) * ( participation_males.age_16_19 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 16 );
      
            targets.participation_20_24_male := (
               male_popn.age_20+
               male_popn.age_21+
               male_popn.age_22+
               male_popn.age_23+
               male_popn.age_24 ) * ( participation_males.age_20_24 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 20 );
      
            targets.participation_25_29_male := (
               male_popn.age_25+
               male_popn.age_26+
               male_popn.age_27+
               male_popn.age_28+
               male_popn.age_29 ) * ( participation_males.age_25_29 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 25 );
            targets.participation_30_34_male := (
               male_popn.age_30+
               male_popn.age_31+
               male_popn.age_32+
               male_popn.age_33+
               male_popn.age_34 ) * ( participation_males.age_30_34 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 30 );
      
            targets.participation_35_39_male := (
               male_popn.age_35+
               male_popn.age_36+
               male_popn.age_37+
               male_popn.age_38+
               male_popn.age_39 ) * ( participation_males.age_35_39 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 35 );
      
            targets.participation_40_44_male := (
               male_popn.age_40+
               male_popn.age_41+
               male_popn.age_42+
               male_popn.age_43+
               male_popn.age_44 ) * ( participation_males.age_40_44 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 40 );
      
            targets.participation_45_49_male := (
               male_popn.age_45+
               male_popn.age_46+
               male_popn.age_47+
               male_popn.age_48+
               male_popn.age_49 ) * ( participation_males.age_45_49 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 45 );
      
            targets.participation_50_54_male := (
               male_popn.age_50+
               male_popn.age_51+
               male_popn.age_52+
               male_popn.age_53+
               male_popn.age_54 ) * ( participation_males.age_50_54 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 50 );
      
            targets.participation_55_59_male := (
               male_popn.age_55+
               male_popn.age_56+
               male_popn.age_57+
               male_popn.age_58+
               male_popn.age_59 ) * ( participation_males.age_55_59 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 55 );
      
            targets.participation_60_64_male := (
               male_popn.age_60+
               male_popn.age_61+
               male_popn.age_62+
               male_popn.age_63+
               male_popn.age_64 ) * ( participation_males.age_60_64 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 60 );
      
            targets.participation_65_69_male := (
               male_popn.age_65+
               male_popn.age_66+
               male_popn.age_67+
               male_popn.age_68+
               male_popn.age_69 ) * ( participation_males.age_65_69 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 65 );
      
            targets.participation_70_74_male := (
               male_popn.age_70+
               male_popn.age_71+
               male_popn.age_72+
               male_popn.age_73+
               male_popn.age_74 ) * ( participation_males.age_70_74 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 70 );
      
            targets.participation_75_plus_male := (
               male_popn.age_75+
               male_popn.age_76+
               male_popn.age_77+
               male_popn.age_78+
               male_popn.age_79+
               male_popn.age_80+
               male_popn.age_81+
               male_popn.age_82+
               male_popn.age_83+
               male_popn.age_84+
               male_popn.age_85+
               male_popn.age_86+
               male_popn.age_87+
               male_popn.age_88+
               male_popn.age_89+
               male_popn.age_90+
               male_popn.age_91+
               male_popn.age_92+
               male_popn.age_93+
               male_popn.age_94+
               male_popn.age_95+
               male_popn.age_96+
               male_popn.age_97+
               male_popn.age_98+
               male_popn.age_99+
               male_popn.age_100+
               male_popn.age_101+
               male_popn.age_102+
               male_popn.age_103+
               male_popn.age_104+
               male_popn.age_105+
               male_popn.age_106+
               male_popn.age_107+
               male_popn.age_108+
               male_popn.age_109+
               male_popn.age_110 ) * ( participation_males.age_75_plus / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 1, 75 );
      
            targets.participation_16_19_female := (
               female_popn.age_16+
               female_popn.age_17+
               female_popn.age_18+
               female_popn.age_19 ) * ( participation_females.age_16_19 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 16 );
      
            targets.participation_20_24_female := (
               female_popn.age_20+
               female_popn.age_21+
               female_popn.age_22+
               female_popn.age_23+
               female_popn.age_24 ) * ( participation_females.age_20_24 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 20 );
      
            targets.participation_25_29_female := (
               female_popn.age_25+
               female_popn.age_26+
               female_popn.age_27+
               female_popn.age_28+
               female_popn.age_29 ) * ( participation_females.age_25_29 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 25 );
      
            targets.participation_30_34_female := (
               female_popn.age_30+
               female_popn.age_31+
               female_popn.age_32+
               female_popn.age_33+
               female_popn.age_34 ) * ( participation_females.age_30_34 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 30 );
      
            targets.participation_35_39_female := (
               female_popn.age_35+
               female_popn.age_36+
               female_popn.age_37+
               female_popn.age_38+
               female_popn.age_39 ) * ( participation_females.age_35_39 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 35 );
      
            targets.participation_40_44_female := (
               female_popn.age_40+
               female_popn.age_41+
               female_popn.age_42+
               female_popn.age_43+
               female_popn.age_44 ) * ( participation_females.age_40_44 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 40 );
      
            targets.participation_45_49_female := (
               female_popn.age_45+
               female_popn.age_46+
               female_popn.age_47+
               female_popn.age_48+
               female_popn.age_49 ) * ( participation_females.age_45_49 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 45 );
      
            targets.participation_50_54_female := (
               female_popn.age_50+
               female_popn.age_51+
               female_popn.age_52+
               female_popn.age_53+
               female_popn.age_54 ) * ( participation_females.age_50_54 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 50 );
      
            targets.participation_55_59_female := (
               female_popn.age_55+
               female_popn.age_56+
               female_popn.age_57+
               female_popn.age_58+
               female_popn.age_59 ) * ( participation_females.age_55_59 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 55 );
      
            targets.participation_60_64_female := (
               female_popn.age_60+
               female_popn.age_61+
               female_popn.age_62+
               female_popn.age_63+
               female_popn.age_64 ) * ( participation_females.age_60_64 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 60 );
      
            targets.participation_65_69_female := (
               female_popn.age_65+
               female_popn.age_66+
               female_popn.age_67+
               female_popn.age_68+
               female_popn.age_69 ) * ( participation_females.age_65_69 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 65 );
      
            targets.participation_70_74_female := (
               female_popn.age_70+
               female_popn.age_71+
               female_popn.age_72+
               female_popn.age_73+
               female_popn.age_74 ) * ( participation_females.age_70_74 / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 70 );
      
            targets.participation_75_plus_female := (
               female_popn.age_75+
               female_popn.age_76+
               female_popn.age_77+
               female_popn.age_78+
               female_popn.age_79+
               female_popn.age_80+
               female_popn.age_81+
               female_popn.age_82+
               female_popn.age_83+
               female_popn.age_84+
               female_popn.age_85+
               female_popn.age_86+
               female_popn.age_87+
               female_popn.age_88+
               female_popn.age_89+
               female_popn.age_90+
               female_popn.age_91+
               female_popn.age_92+
               female_popn.age_93+
               female_popn.age_94+
               female_popn.age_95+
               female_popn.age_96+
               female_popn.age_97+
               female_popn.age_98+
               female_popn.age_99+
               female_popn.age_100+
               female_popn.age_101+
               female_popn.age_102+
               female_popn.age_103+
               female_popn.age_104+
               female_popn.age_105+
               female_popn.age_106+
               female_popn.age_107+
               female_popn.age_108+
               female_popn.age_109+
               female_popn.age_110 ) * ( participation_females.age_75_plus / 100.0 ) * 
            Get_Participation_Scale( the_run.country, 2, 75 ); 
            
            if macro_data /= Null_Macro_Forecasts then
               -- horrible reverse engineering
               -- TODO BOUNDS ON YEARS
               declare               
                  implied_16_plus        : constant Amount := 100.0*macro_data.employment/macro_data.employment_rate;
                  implied_employees_rate : constant Amount := macro_data.employees/implied_16_plus;
                  implied_claimant_rate  : constant Amount := macro_data.claimant_count/implied_16_plus;
               begin
                  Log( "over 16s " & Format( age_16_plus ));
                  Log( "implied 16 plus (UK) " & Format( implied_16_plus ));
                  Log( "implied employees_rate " & Format( implied_employees_rate*100.0 ));               
                  Log( "implied_claimant_rate " & Format( implied_claimant_rate*100.0 ));               
                  targets.employee := implied_employees_rate*age_16_plus;
                  targets.jsa_claimant := implied_claimant_rate*age_16_plus;                  
                  targets.private_sector_employed := macro_data.private_sector_employment;
                  targets.public_sector_employed := macro_data.public_sector_employment;
               end; 
            end if;
            Log( To_String( targets )); 
            UKDS.Target_Data.Target_Dataset_IO.Save( targets );
         end;
      end loop;
   end Create_Dataset_2014;

end Model.SCP.Target_Creator;