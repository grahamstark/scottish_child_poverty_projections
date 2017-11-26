
set search_path=public,target_data,frs;

select * from target_data.forecast_variant;

select 
        year,variant,target_group,all_ages,age_0,age_1,age_90 
from 
        target_data.population_forecasts 
where year=2014 or year=2039 
order by year,target_group,variant;

select * from target_data.forecast_variants;


DROP TABLE target_data.population_forecasts;

CREATE TABLE target_data.population_forecasts( 
       year INTEGER not null default 0,
       rec_type TEXT not null default 'persons',
       variant TEXT not null,
       country TEXT not null,
       edition INTEGER not null,
       target_group TEXT not null,
       all_ages DOUBLE PRECISION,
       age_0 DOUBLE PRECISION,
       age_1 DOUBLE PRECISION,
       age_2 DOUBLE PRECISION,
       age_3 DOUBLE PRECISION,
       age_4 DOUBLE PRECISION,
       age_5 DOUBLE PRECISION,
       age_6 DOUBLE PRECISION,
       age_7 DOUBLE PRECISION,
       age_8 DOUBLE PRECISION,
       age_9 DOUBLE PRECISION,
       age_10 DOUBLE PRECISION,
       age_11 DOUBLE PRECISION,
       age_12 DOUBLE PRECISION,
       age_13 DOUBLE PRECISION,
       age_14 DOUBLE PRECISION,
       age_15 DOUBLE PRECISION,
       age_16 DOUBLE PRECISION,
       age_17 DOUBLE PRECISION,
       age_18 DOUBLE PRECISION,
       age_19 DOUBLE PRECISION,
       age_20 DOUBLE PRECISION,
       age_21 DOUBLE PRECISION,
       age_22 DOUBLE PRECISION,
       age_23 DOUBLE PRECISION,
       age_24 DOUBLE PRECISION,
       age_25 DOUBLE PRECISION,
       age_26 DOUBLE PRECISION,
       age_27 DOUBLE PRECISION,
       age_28 DOUBLE PRECISION,
       age_29 DOUBLE PRECISION,
       age_30 DOUBLE PRECISION,
       age_31 DOUBLE PRECISION,
       age_32 DOUBLE PRECISION,
       age_33 DOUBLE PRECISION,
       age_34 DOUBLE PRECISION,
       age_35 DOUBLE PRECISION,
       age_36 DOUBLE PRECISION,
       age_37 DOUBLE PRECISION,
       age_38 DOUBLE PRECISION,
       age_39 DOUBLE PRECISION,
       age_40 DOUBLE PRECISION,
       age_41 DOUBLE PRECISION,
       age_42 DOUBLE PRECISION,
       age_43 DOUBLE PRECISION,
       age_44 DOUBLE PRECISION,
       age_45 DOUBLE PRECISION,
       age_46 DOUBLE PRECISION,
       age_47 DOUBLE PRECISION,
       age_48 DOUBLE PRECISION,
       age_49 DOUBLE PRECISION,
       age_50 DOUBLE PRECISION,
       age_51 DOUBLE PRECISION,
       age_52 DOUBLE PRECISION,
       age_53 DOUBLE PRECISION,
       age_54 DOUBLE PRECISION,
       age_55 DOUBLE PRECISION,
       age_56 DOUBLE PRECISION,
       age_57 DOUBLE PRECISION,
       age_58 DOUBLE PRECISION,
       age_59 DOUBLE PRECISION,
       age_60 DOUBLE PRECISION,
       age_61 DOUBLE PRECISION,
       age_62 DOUBLE PRECISION,
       age_63 DOUBLE PRECISION,
       age_64 DOUBLE PRECISION,
       age_65 DOUBLE PRECISION,
       age_66 DOUBLE PRECISION,
       age_67 DOUBLE PRECISION,
       age_68 DOUBLE PRECISION,
       age_69 DOUBLE PRECISION,
       age_70 DOUBLE PRECISION,
       age_71 DOUBLE PRECISION,
       age_72 DOUBLE PRECISION,
       age_73 DOUBLE PRECISION,
       age_74 DOUBLE PRECISION,
       age_75 DOUBLE PRECISION,
       age_76 DOUBLE PRECISION,
       age_77 DOUBLE PRECISION,
       age_78 DOUBLE PRECISION,
       age_79 DOUBLE PRECISION,
       age_80 DOUBLE PRECISION,
       age_81 DOUBLE PRECISION,
       age_82 DOUBLE PRECISION,
       age_83 DOUBLE PRECISION,
       age_84 DOUBLE PRECISION,
       age_85 DOUBLE PRECISION,
       age_86 DOUBLE PRECISION,
       age_87 DOUBLE PRECISION,
       age_88 DOUBLE PRECISION,
       age_89 DOUBLE PRECISION,
       age_90 DOUBLE PRECISION,
       age_91 DOUBLE PRECISION,
       age_92 DOUBLE PRECISION,
       age_93 DOUBLE PRECISION,
       age_94 DOUBLE PRECISION,
       age_95 DOUBLE PRECISION,
       age_96 DOUBLE PRECISION,
       age_97 DOUBLE PRECISION,
       age_98 DOUBLE PRECISION,
       age_99 DOUBLE PRECISION,
       age_100 DOUBLE PRECISION,
       age_101 DOUBLE PRECISION,
       age_102 DOUBLE PRECISION,
       age_103 DOUBLE PRECISION,
       age_104 DOUBLE PRECISION,
       age_105 DOUBLE PRECISION,
       age_106 DOUBLE PRECISION,
       age_107 DOUBLE PRECISION,
       age_108 DOUBLE PRECISION,
       age_109 DOUBLE PRECISION,
       age_110 DOUBLE PRECISION,
       CONSTRAINT population_forecasts_pk PRIMARY KEY( year, rec_type, variant, country, edition, target_group ),
       CONSTRAINT population_forecasts_FK_0 FOREIGN KEY( rec_type, variant, country, edition) references forecast_variant( rec_type, variant, country, edition ) on delete CASCADE on update CASCADE
);

select 
        year,sum(all_ages),
        sum(
                coalesce( age_0, 0.0 ) +
                coalesce( age_1, 0.0 ) + 
                coalesce( age_2, 0.0 ) +
                coalesce( age_3, 0.0 ) +
                coalesce( age_4, 0.0 ) +
                coalesce( age_5, 0.0 ) +
                coalesce( age_6, 0.0 ) +
                coalesce( age_7, 0.0 ) +
                coalesce( age_8, 0.0 ) +
                coalesce( age_9, 0.0 ) +
                coalesce( age_10, 0.0 ) +
                coalesce( age_11, 0.0 ) +
                coalesce( age_12, 0.0 ) +
                coalesce( age_13, 0.0 ) +
                coalesce( age_14, 0.0 ) +
                coalesce( age_15, 0.0 ) +
                coalesce( age_16, 0.0 ) +
                coalesce( age_17, 0.0 ) +
                coalesce( age_18, 0.0 ) +
                coalesce( age_19, 0.0 ) +
                coalesce( age_20, 0.0 ) +
                coalesce( age_21, 0.0 ) +
                coalesce( age_22, 0.0 ) +
                coalesce( age_23, 0.0 ) +
                coalesce( age_24, 0.0 ) +
                coalesce( age_25, 0.0 ) +
                coalesce( age_26, 0.0 ) +
                coalesce( age_27, 0.0 ) +
                coalesce( age_28, 0.0 ) +
                coalesce( age_29, 0.0 ) +
                coalesce( age_30, 0.0 ) +
                coalesce( age_31, 0.0 ) +
                coalesce( age_32, 0.0 ) +
                coalesce( age_33, 0.0 ) +
                coalesce( age_34, 0.0 ) +
                coalesce( age_35, 0.0 ) +
                coalesce( age_36, 0.0 ) +
                coalesce( age_37, 0.0 ) +
                coalesce( age_38, 0.0 ) +
                coalesce( age_39, 0.0 ) +
                coalesce( age_40, 0.0 ) +
                coalesce( age_41, 0.0 ) +
                coalesce( age_42, 0.0 ) +
                coalesce( age_43, 0.0 ) +
                coalesce( age_44, 0.0 ) +
                coalesce( age_45, 0.0 ) +
                coalesce( age_46, 0.0 ) +
                coalesce( age_47, 0.0 ) +
                coalesce( age_48, 0.0 ) +
                coalesce( age_49, 0.0 ) +
                coalesce( age_50, 0.0 ) +
                coalesce( age_51, 0.0 ) +
                coalesce( age_52, 0.0 ) +
                coalesce( age_53, 0.0 ) +
                coalesce( age_54, 0.0 ) +
                coalesce( age_55, 0.0 ) +
                coalesce( age_56, 0.0 ) +
                coalesce( age_57, 0.0 ) +
                coalesce( age_58, 0.0 ) +
                coalesce( age_59, 0.0 ) +
                coalesce( age_60, 0.0 ) +
                coalesce( age_61, 0.0 ) +
                coalesce( age_62, 0.0 ) +
                coalesce( age_63, 0.0 ) +
                coalesce( age_64, 0.0 ) +
                coalesce( age_65, 0.0 ) +
                coalesce( age_66, 0.0 ) +
                coalesce( age_67, 0.0 ) +
                coalesce( age_68, 0.0 ) +
                coalesce( age_69, 0.0 ) +
                coalesce( age_70, 0.0 ) +
                coalesce( age_71, 0.0 ) +
                coalesce( age_72, 0.0 ) +
                coalesce( age_73, 0.0 ) +
                coalesce( age_74, 0.0 ) +
                coalesce( age_75, 0.0 ) +
                coalesce( age_76, 0.0 ) +
                coalesce( age_77, 0.0 ) +
                coalesce( age_78, 0.0 ) +
                coalesce( age_79, 0.0 ) +
                coalesce( age_80, 0.0 ) +
                coalesce( age_81, 0.0 ) +
                coalesce( age_82, 0.0 ) +
                coalesce( age_83, 0.0 ) +
                coalesce( age_84, 0.0 ) +
                coalesce( age_85, 0.0 ) +
                coalesce( age_86, 0.0 ) +
                coalesce( age_87, 0.0 ) +
                coalesce( age_88, 0.0 ) +
                coalesce( age_89, 0.0 ) +
                coalesce( age_90, 0.0 ) +
                coalesce( age_91, 0.0 ) +
                coalesce( age_92, 0.0 ) +
                coalesce( age_93, 0.0 ) +
                coalesce( age_94, 0.0 ) +
                coalesce( age_95, 0.0 ) +
                coalesce( age_96, 0.0 ) +
                coalesce( age_97, 0.0 ) +
                coalesce( age_98, 0.0 ) +
                coalesce( age_99,  0.0 ) + 
                coalesce( age_100, 0.0 ) +
                coalesce( age_101, 0.0 ) +
                coalesce( age_102, 0.0 ) +
                coalesce( age_103, 0.0 ) +
                coalesce( age_104, 0.0 ) +
                coalesce( age_105, 0.0 ) +
                coalesce( age_106, 0.0 ) +
                coalesce( age_107, 0.0 ) +
                coalesce( age_108, 0.0 ) +
                coalesce( age_109, 0.0 ) +
                coalesce( age_110, 0.0 ))
from 
        target_data.population_forecasts 
where 
        variant='ppl' and target_group in ( 'MALES', 'FEMALES' )
group by year order by year;

select 
        year,
        sum( coalesce( age_0, 0.0 ) +
        coalesce( age_1, 0.0 ) + 
        coalesce( age_2, 0.0 ) +
        coalesce( age_3, 0.0 ) +
        coalesce( age_4, 0.0 ) +
        coalesce( age_5, 0.0 ) +
        coalesce( age_6, 0.0 ) +
        coalesce( age_7, 0.0 ) +
        coalesce( age_8, 0.0 ) +
        coalesce( age_9, 0.0 ) +
        coalesce( age_10, 0.0 ) +
        coalesce( age_11, 0.0 ) +
        coalesce( age_12, 0.0 ) +
        coalesce( age_13, 0.0 ) +
        coalesce( age_14, 0.0 ) +
        coalesce( age_15, 0.0 ) + 
        coalesce( age_16, 0.0 ) ) as children
from target_data.population_forecasts 
where 
        country = 'SCO' and 
        edition = 2014 and
        variant ='ppp' and 
        target_group in ( 'MALES', 'FEMALES' )
group by year order by year;

select year,target_group,age_105 from target_data.population_forecasts order by year,target_group;

select distinct year  from frs.adult where age80 is null or age80 < 16;

select * from dictionaries.variables where dataset='frs' and tables='househol' and label ilike '%household%' and year>2008;

select * from dictionaries.variables where dataset='frs' and tables='adult' and label ilike '%jsa%' and year>=2008 order by year;

<= 2012 ben3q1 
> 2012 wageben6

select 
        user_id,
        run_id,
        year,
        min( country_uk ) as min_country_uk, max( country_uk ) as max_country_uk, count( nullif( country_uk, 0 )) as non_zero_country_uk,
        min( country_scotland ) as min_country_scotland, max( country_scotland ) as max_country_scotland, count( nullif( country_scotland, 0 )) as non_zero_country_scotland,
        min( country_england ) as min_country_england, max( country_england ) as max_country_england, count( nullif( country_england, 0 )) as non_zero_country_england,
        min( country_n_ireland ) as min_country_n_ireland, max( country_n_ireland ) as max_country_n_ireland, count( nullif( country_n_ireland, 0 )) as non_zero_country_n_ireland,
        min( country_wales ) as min_country_wales, max( country_wales ) as max_country_wales, count( nullif( country_wales, 0 )) as non_zero_country_wales,
        min( household_one_adult_male ) as min_household_one_adult_male, max( household_one_adult_male ) as max_household_one_adult_male, count( nullif( household_one_adult_male, 0 )) as non_zero_household_one_adult_male,
        min( household_one_adult_female ) as min_household_one_adult_female, max( household_one_adult_female ) as max_household_one_adult_female, count( nullif( household_one_adult_female, 0 )) as non_zero_household_one_adult_female,
        min( household_two_adults ) as min_household_two_adults, max( household_two_adults ) as max_household_two_adults, count( nullif( household_two_adults, 0 )) as non_zero_household_two_adults,
        min( household_one_adult_one_child ) as min_household_one_adult_one_child, max( household_one_adult_one_child ) as max_household_one_adult_one_child, count( nullif( household_one_adult_one_child, 0 )) as non_zero_household_one_adult_one_child,
        min( household_one_adult_two_plus_children ) as min_household_one_adult_two_plus_children, max( household_one_adult_two_plus_children ) as max_household_one_adult_two_plus_children, count( nullif( household_one_adult_two_plus_children, 0 )) as non_zero_household_one_adult_two_plus_children,
        min( household_two_plus_adult_one_plus_children ) as min_household_two_plus_adult_one_plus_children, max( household_two_plus_adult_one_plus_children ) as max_household_two_plus_adult_one_plus_children, count( nullif( household_two_plus_adult_one_plus_children, 0 )) as non_zero_household_two_plus_adult_one_plus_children,
        min( household_three_plus_person_all_adult ) as min_household_three_plus_person_all_adult, max( household_three_plus_person_all_adult ) as max_household_three_plus_person_all_adult, count( nullif( household_three_plus_person_all_adult, 0 )) as non_zero_household_three_plus_person_all_adult,
        min( household_all_households ) as min_household_all_households, max( household_all_households ) as max_household_all_households, count( nullif( household_all_households, 0 )) as non_zero_household_all_households,
        min( male ) as min_male, max( male ) as max_male, count( nullif( male, 0 )) as non_zero_male,
        min( female ) as min_female, max( female ) as max_female, count( nullif( female, 0 )) as non_zero_female,
        min( employed ) as min_employed, max( employed ) as max_employed, count( nullif( employed, 0 )) as non_zero_employed,
        min( employee ) as min_employee, max( employee ) as max_employee, count( nullif( employee, 0 )) as non_zero_employee,
        min( ilo_unemployed ) as min_ilo_unemployed, max( ilo_unemployed ) as max_ilo_unemployed, count( nullif( ilo_unemployed, 0 )) as non_zero_ilo_unemployed,
        min( jsa_claimant ) as min_jsa_claimant, max( jsa_claimant ) as max_jsa_claimant, count( nullif( jsa_claimant, 0 )) as non_zero_jsa_claimant,
        min( age_0_male ) as min_age_0_male, max( age_0_male ) as max_age_0_male, count( nullif( age_0_male, 0 )) as non_zero_age_0_male,
        min( age_1_male ) as min_age_1_male, max( age_1_male ) as max_age_1_male, count( nullif( age_1_male, 0 )) as non_zero_age_1_male,
        min( age_2_male ) as min_age_2_male, max( age_2_male ) as max_age_2_male, count( nullif( age_2_male, 0 )) as non_zero_age_2_male,
        min( age_3_male ) as min_age_3_male, max( age_3_male ) as max_age_3_male, count( nullif( age_3_male, 0 )) as non_zero_age_3_male,
        min( age_4_male ) as min_age_4_male, max( age_4_male ) as max_age_4_male, count( nullif( age_4_male, 0 )) as non_zero_age_4_male,
        min( age_5_male ) as min_age_5_male, max( age_5_male ) as max_age_5_male, count( nullif( age_5_male, 0 )) as non_zero_age_5_male,
        min( age_6_male ) as min_age_6_male, max( age_6_male ) as max_age_6_male, count( nullif( age_6_male, 0 )) as non_zero_age_6_male,
        min( age_7_male ) as min_age_7_male, max( age_7_male ) as max_age_7_male, count( nullif( age_7_male, 0 )) as non_zero_age_7_male,
        min( age_8_male ) as min_age_8_male, max( age_8_male ) as max_age_8_male, count( nullif( age_8_male, 0 )) as non_zero_age_8_male,
        min( age_9_male ) as min_age_9_male, max( age_9_male ) as max_age_9_male, count( nullif( age_9_male, 0 )) as non_zero_age_9_male,
        min( age_10_male ) as min_age_10_male, max( age_10_male ) as max_age_10_male, count( nullif( age_10_male, 0 )) as non_zero_age_10_male,
        min( age_11_male ) as min_age_11_male, max( age_11_male ) as max_age_11_male, count( nullif( age_11_male, 0 )) as non_zero_age_11_male,
        min( age_12_male ) as min_age_12_male, max( age_12_male ) as max_age_12_male, count( nullif( age_12_male, 0 )) as non_zero_age_12_male,
        min( age_13_male ) as min_age_13_male, max( age_13_male ) as max_age_13_male, count( nullif( age_13_male, 0 )) as non_zero_age_13_male,
        min( age_14_male ) as min_age_14_male, max( age_14_male ) as max_age_14_male, count( nullif( age_14_male, 0 )) as non_zero_age_14_male,
        min( age_15_male ) as min_age_15_male, max( age_15_male ) as max_age_15_male, count( nullif( age_15_male, 0 )) as non_zero_age_15_male,
        min( age_16_male ) as min_age_16_male, max( age_16_male ) as max_age_16_male, count( nullif( age_16_male, 0 )) as non_zero_age_16_male,
        min( age_17_male ) as min_age_17_male, max( age_17_male ) as max_age_17_male, count( nullif( age_17_male, 0 )) as non_zero_age_17_male,
        min( age_18_male ) as min_age_18_male, max( age_18_male ) as max_age_18_male, count( nullif( age_18_male, 0 )) as non_zero_age_18_male,
        min( age_19_male ) as min_age_19_male, max( age_19_male ) as max_age_19_male, count( nullif( age_19_male, 0 )) as non_zero_age_19_male,
        min( age_20_male ) as min_age_20_male, max( age_20_male ) as max_age_20_male, count( nullif( age_20_male, 0 )) as non_zero_age_20_male,
        min( age_21_male ) as min_age_21_male, max( age_21_male ) as max_age_21_male, count( nullif( age_21_male, 0 )) as non_zero_age_21_male,
        min( age_22_male ) as min_age_22_male, max( age_22_male ) as max_age_22_male, count( nullif( age_22_male, 0 )) as non_zero_age_22_male,
        min( age_23_male ) as min_age_23_male, max( age_23_male ) as max_age_23_male, count( nullif( age_23_male, 0 )) as non_zero_age_23_male,
        min( age_24_male ) as min_age_24_male, max( age_24_male ) as max_age_24_male, count( nullif( age_24_male, 0 )) as non_zero_age_24_male,
        min( age_25_male ) as min_age_25_male, max( age_25_male ) as max_age_25_male, count( nullif( age_25_male, 0 )) as non_zero_age_25_male,
        min( age_26_male ) as min_age_26_male, max( age_26_male ) as max_age_26_male, count( nullif( age_26_male, 0 )) as non_zero_age_26_male,
        min( age_27_male ) as min_age_27_male, max( age_27_male ) as max_age_27_male, count( nullif( age_27_male, 0 )) as non_zero_age_27_male,
        min( age_28_male ) as min_age_28_male, max( age_28_male ) as max_age_28_male, count( nullif( age_28_male, 0 )) as non_zero_age_28_male,
        min( age_29_male ) as min_age_29_male, max( age_29_male ) as max_age_29_male, count( nullif( age_29_male, 0 )) as non_zero_age_29_male,
        min( age_30_male ) as min_age_30_male, max( age_30_male ) as max_age_30_male, count( nullif( age_30_male, 0 )) as non_zero_age_30_male,
        min( age_31_male ) as min_age_31_male, max( age_31_male ) as max_age_31_male, count( nullif( age_31_male, 0 )) as non_zero_age_31_male,
        min( age_32_male ) as min_age_32_male, max( age_32_male ) as max_age_32_male, count( nullif( age_32_male, 0 )) as non_zero_age_32_male,
        min( age_33_male ) as min_age_33_male, max( age_33_male ) as max_age_33_male, count( nullif( age_33_male, 0 )) as non_zero_age_33_male,
        min( age_34_male ) as min_age_34_male, max( age_34_male ) as max_age_34_male, count( nullif( age_34_male, 0 )) as non_zero_age_34_male,
        min( age_35_male ) as min_age_35_male, max( age_35_male ) as max_age_35_male, count( nullif( age_35_male, 0 )) as non_zero_age_35_male,
        min( age_36_male ) as min_age_36_male, max( age_36_male ) as max_age_36_male, count( nullif( age_36_male, 0 )) as non_zero_age_36_male,
        min( age_37_male ) as min_age_37_male, max( age_37_male ) as max_age_37_male, count( nullif( age_37_male, 0 )) as non_zero_age_37_male,
        min( age_38_male ) as min_age_38_male, max( age_38_male ) as max_age_38_male, count( nullif( age_38_male, 0 )) as non_zero_age_38_male,
        min( age_39_male ) as min_age_39_male, max( age_39_male ) as max_age_39_male, count( nullif( age_39_male, 0 )) as non_zero_age_39_male,
        min( age_40_male ) as min_age_40_male, max( age_40_male ) as max_age_40_male, count( nullif( age_40_male, 0 )) as non_zero_age_40_male,
        min( age_41_male ) as min_age_41_male, max( age_41_male ) as max_age_41_male, count( nullif( age_41_male, 0 )) as non_zero_age_41_male,
        min( age_42_male ) as min_age_42_male, max( age_42_male ) as max_age_42_male, count( nullif( age_42_male, 0 )) as non_zero_age_42_male,
        min( age_43_male ) as min_age_43_male, max( age_43_male ) as max_age_43_male, count( nullif( age_43_male, 0 )) as non_zero_age_43_male,
        min( age_44_male ) as min_age_44_male, max( age_44_male ) as max_age_44_male, count( nullif( age_44_male, 0 )) as non_zero_age_44_male,
        min( age_45_male ) as min_age_45_male, max( age_45_male ) as max_age_45_male, count( nullif( age_45_male, 0 )) as non_zero_age_45_male,
        min( age_46_male ) as min_age_46_male, max( age_46_male ) as max_age_46_male, count( nullif( age_46_male, 0 )) as non_zero_age_46_male,
        min( age_47_male ) as min_age_47_male, max( age_47_male ) as max_age_47_male, count( nullif( age_47_male, 0 )) as non_zero_age_47_male,
        min( age_48_male ) as min_age_48_male, max( age_48_male ) as max_age_48_male, count( nullif( age_48_male, 0 )) as non_zero_age_48_male,
        min( age_49_male ) as min_age_49_male, max( age_49_male ) as max_age_49_male, count( nullif( age_49_male, 0 )) as non_zero_age_49_male,
        min( age_50_male ) as min_age_50_male, max( age_50_male ) as max_age_50_male, count( nullif( age_50_male, 0 )) as non_zero_age_50_male,
        min( age_51_male ) as min_age_51_male, max( age_51_male ) as max_age_51_male, count( nullif( age_51_male, 0 )) as non_zero_age_51_male,
        min( age_52_male ) as min_age_52_male, max( age_52_male ) as max_age_52_male, count( nullif( age_52_male, 0 )) as non_zero_age_52_male,
        min( age_53_male ) as min_age_53_male, max( age_53_male ) as max_age_53_male, count( nullif( age_53_male, 0 )) as non_zero_age_53_male,
        min( age_54_male ) as min_age_54_male, max( age_54_male ) as max_age_54_male, count( nullif( age_54_male, 0 )) as non_zero_age_54_male,
        min( age_55_male ) as min_age_55_male, max( age_55_male ) as max_age_55_male, count( nullif( age_55_male, 0 )) as non_zero_age_55_male,
        min( age_56_male ) as min_age_56_male, max( age_56_male ) as max_age_56_male, count( nullif( age_56_male, 0 )) as non_zero_age_56_male,
        min( age_57_male ) as min_age_57_male, max( age_57_male ) as max_age_57_male, count( nullif( age_57_male, 0 )) as non_zero_age_57_male,
        min( age_58_male ) as min_age_58_male, max( age_58_male ) as max_age_58_male, count( nullif( age_58_male, 0 )) as non_zero_age_58_male,
        min( age_59_male ) as min_age_59_male, max( age_59_male ) as max_age_59_male, count( nullif( age_59_male, 0 )) as non_zero_age_59_male,
        min( age_60_male ) as min_age_60_male, max( age_60_male ) as max_age_60_male, count( nullif( age_60_male, 0 )) as non_zero_age_60_male,
        min( age_61_male ) as min_age_61_male, max( age_61_male ) as max_age_61_male, count( nullif( age_61_male, 0 )) as non_zero_age_61_male,
        min( age_62_male ) as min_age_62_male, max( age_62_male ) as max_age_62_male, count( nullif( age_62_male, 0 )) as non_zero_age_62_male,
        min( age_63_male ) as min_age_63_male, max( age_63_male ) as max_age_63_male, count( nullif( age_63_male, 0 )) as non_zero_age_63_male,
        min( age_64_male ) as min_age_64_male, max( age_64_male ) as max_age_64_male, count( nullif( age_64_male, 0 )) as non_zero_age_64_male,
        min( age_65_male ) as min_age_65_male, max( age_65_male ) as max_age_65_male, count( nullif( age_65_male, 0 )) as non_zero_age_65_male,
        min( age_66_male ) as min_age_66_male, max( age_66_male ) as max_age_66_male, count( nullif( age_66_male, 0 )) as non_zero_age_66_male,
        min( age_67_male ) as min_age_67_male, max( age_67_male ) as max_age_67_male, count( nullif( age_67_male, 0 )) as non_zero_age_67_male,
        min( age_68_male ) as min_age_68_male, max( age_68_male ) as max_age_68_male, count( nullif( age_68_male, 0 )) as non_zero_age_68_male,
        min( age_69_male ) as min_age_69_male, max( age_69_male ) as max_age_69_male, count( nullif( age_69_male, 0 )) as non_zero_age_69_male,
        min( age_70_male ) as min_age_70_male, max( age_70_male ) as max_age_70_male, count( nullif( age_70_male, 0 )) as non_zero_age_70_male,
        min( age_71_male ) as min_age_71_male, max( age_71_male ) as max_age_71_male, count( nullif( age_71_male, 0 )) as non_zero_age_71_male,
        min( age_72_male ) as min_age_72_male, max( age_72_male ) as max_age_72_male, count( nullif( age_72_male, 0 )) as non_zero_age_72_male,
        min( age_73_male ) as min_age_73_male, max( age_73_male ) as max_age_73_male, count( nullif( age_73_male, 0 )) as non_zero_age_73_male,
        min( age_74_male ) as min_age_74_male, max( age_74_male ) as max_age_74_male, count( nullif( age_74_male, 0 )) as non_zero_age_74_male,
        min( age_75_male ) as min_age_75_male, max( age_75_male ) as max_age_75_male, count( nullif( age_75_male, 0 )) as non_zero_age_75_male,
        min( age_76_male ) as min_age_76_male, max( age_76_male ) as max_age_76_male, count( nullif( age_76_male, 0 )) as non_zero_age_76_male,
        min( age_77_male ) as min_age_77_male, max( age_77_male ) as max_age_77_male, count( nullif( age_77_male, 0 )) as non_zero_age_77_male,
        min( age_78_male ) as min_age_78_male, max( age_78_male ) as max_age_78_male, count( nullif( age_78_male, 0 )) as non_zero_age_78_male,
        min( age_79_male ) as min_age_79_male, max( age_79_male ) as max_age_79_male, count( nullif( age_79_male, 0 )) as non_zero_age_79_male,
        min( age_80_male ) as min_age_80_male, max( age_80_male ) as max_age_80_male, count( nullif( age_80_male, 0 )) as non_zero_age_80_male,
        min( age_81_male ) as min_age_81_male, max( age_81_male ) as max_age_81_male, count( nullif( age_81_male, 0 )) as non_zero_age_81_male,
        min( age_82_male ) as min_age_82_male, max( age_82_male ) as max_age_82_male, count( nullif( age_82_male, 0 )) as non_zero_age_82_male,
        min( age_83_male ) as min_age_83_male, max( age_83_male ) as max_age_83_male, count( nullif( age_83_male, 0 )) as non_zero_age_83_male,
        min( age_84_male ) as min_age_84_male, max( age_84_male ) as max_age_84_male, count( nullif( age_84_male, 0 )) as non_zero_age_84_male,
        min( age_85_male ) as min_age_85_male, max( age_85_male ) as max_age_85_male, count( nullif( age_85_male, 0 )) as non_zero_age_85_male,
        min( age_86_male ) as min_age_86_male, max( age_86_male ) as max_age_86_male, count( nullif( age_86_male, 0 )) as non_zero_age_86_male,
        min( age_87_male ) as min_age_87_male, max( age_87_male ) as max_age_87_male, count( nullif( age_87_male, 0 )) as non_zero_age_87_male,
        min( age_88_male ) as min_age_88_male, max( age_88_male ) as max_age_88_male, count( nullif( age_88_male, 0 )) as non_zero_age_88_male,
        min( age_89_male ) as min_age_89_male, max( age_89_male ) as max_age_89_male, count( nullif( age_89_male, 0 )) as non_zero_age_89_male,
        min( age_90_male ) as min_age_90_male, max( age_90_male ) as max_age_90_male, count( nullif( age_90_male, 0 )) as non_zero_age_90_male,
        min( age_91_male ) as min_age_91_male, max( age_91_male ) as max_age_91_male, count( nullif( age_91_male, 0 )) as non_zero_age_91_male,
        min( age_92_male ) as min_age_92_male, max( age_92_male ) as max_age_92_male, count( nullif( age_92_male, 0 )) as non_zero_age_92_male,
        min( age_93_male ) as min_age_93_male, max( age_93_male ) as max_age_93_male, count( nullif( age_93_male, 0 )) as non_zero_age_93_male,
        min( age_94_male ) as min_age_94_male, max( age_94_male ) as max_age_94_male, count( nullif( age_94_male, 0 )) as non_zero_age_94_male,
        min( age_95_male ) as min_age_95_male, max( age_95_male ) as max_age_95_male, count( nullif( age_95_male, 0 )) as non_zero_age_95_male,
        min( age_96_male ) as min_age_96_male, max( age_96_male ) as max_age_96_male, count( nullif( age_96_male, 0 )) as non_zero_age_96_male,
        min( age_97_male ) as min_age_97_male, max( age_97_male ) as max_age_97_male, count( nullif( age_97_male, 0 )) as non_zero_age_97_male,
        min( age_98_male ) as min_age_98_male, max( age_98_male ) as max_age_98_male, count( nullif( age_98_male, 0 )) as non_zero_age_98_male,
        min( age_99_male ) as min_age_99_male, max( age_99_male ) as max_age_99_male, count( nullif( age_99_male, 0 )) as non_zero_age_99_male,
        min( age_100_male ) as min_age_100_male, max( age_100_male ) as max_age_100_male, count( nullif( age_100_male, 0 )) as non_zero_age_100_male,
        min( age_101_male ) as min_age_101_male, max( age_101_male ) as max_age_101_male, count( nullif( age_101_male, 0 )) as non_zero_age_101_male,
        min( age_102_male ) as min_age_102_male, max( age_102_male ) as max_age_102_male, count( nullif( age_102_male, 0 )) as non_zero_age_102_male,
        min( age_103_male ) as min_age_103_male, max( age_103_male ) as max_age_103_male, count( nullif( age_103_male, 0 )) as non_zero_age_103_male,
        min( age_104_male ) as min_age_104_male, max( age_104_male ) as max_age_104_male, count( nullif( age_104_male, 0 )) as non_zero_age_104_male,
        min( age_105_male ) as min_age_105_male, max( age_105_male ) as max_age_105_male, count( nullif( age_105_male, 0 )) as non_zero_age_105_male,
        min( age_106_male ) as min_age_106_male, max( age_106_male ) as max_age_106_male, count( nullif( age_106_male, 0 )) as non_zero_age_106_male,
        min( age_107_male ) as min_age_107_male, max( age_107_male ) as max_age_107_male, count( nullif( age_107_male, 0 )) as non_zero_age_107_male,
        min( age_108_male ) as min_age_108_male, max( age_108_male ) as max_age_108_male, count( nullif( age_108_male, 0 )) as non_zero_age_108_male,
        min( age_109_male ) as min_age_109_male, max( age_109_male ) as max_age_109_male, count( nullif( age_109_male, 0 )) as non_zero_age_109_male,
        min( age_110_male ) as min_age_110_male, max( age_110_male ) as max_age_110_male, count( nullif( age_110_male, 0 )) as non_zero_age_110_male,
        min( age_0_female ) as min_age_0_female, max( age_0_female ) as max_age_0_female, count( nullif( age_0_female, 0 )) as non_zero_age_0_female,
        min( age_1_female ) as min_age_1_female, max( age_1_female ) as max_age_1_female, count( nullif( age_1_female, 0 )) as non_zero_age_1_female,
        min( age_2_female ) as min_age_2_female, max( age_2_female ) as max_age_2_female, count( nullif( age_2_female, 0 )) as non_zero_age_2_female,
        min( age_3_female ) as min_age_3_female, max( age_3_female ) as max_age_3_female, count( nullif( age_3_female, 0 )) as non_zero_age_3_female,
        min( age_4_female ) as min_age_4_female, max( age_4_female ) as max_age_4_female, count( nullif( age_4_female, 0 )) as non_zero_age_4_female,
        min( age_5_female ) as min_age_5_female, max( age_5_female ) as max_age_5_female, count( nullif( age_5_female, 0 )) as non_zero_age_5_female,
        min( age_6_female ) as min_age_6_female, max( age_6_female ) as max_age_6_female, count( nullif( age_6_female, 0 )) as non_zero_age_6_female,
        min( age_7_female ) as min_age_7_female, max( age_7_female ) as max_age_7_female, count( nullif( age_7_female, 0 )) as non_zero_age_7_female,
        min( age_8_female ) as min_age_8_female, max( age_8_female ) as max_age_8_female, count( nullif( age_8_female, 0 )) as non_zero_age_8_female,
        min( age_9_female ) as min_age_9_female, max( age_9_female ) as max_age_9_female, count( nullif( age_9_female, 0 )) as non_zero_age_9_female,
        min( age_10_female ) as min_age_10_female, max( age_10_female ) as max_age_10_female, count( nullif( age_10_female, 0 )) as non_zero_age_10_female,
        min( age_11_female ) as min_age_11_female, max( age_11_female ) as max_age_11_female, count( nullif( age_11_female, 0 )) as non_zero_age_11_female,
        min( age_12_female ) as min_age_12_female, max( age_12_female ) as max_age_12_female, count( nullif( age_12_female, 0 )) as non_zero_age_12_female,
        min( age_13_female ) as min_age_13_female, max( age_13_female ) as max_age_13_female, count( nullif( age_13_female, 0 )) as non_zero_age_13_female,
        min( age_14_female ) as min_age_14_female, max( age_14_female ) as max_age_14_female, count( nullif( age_14_female, 0 )) as non_zero_age_14_female,
        min( age_15_female ) as min_age_15_female, max( age_15_female ) as max_age_15_female, count( nullif( age_15_female, 0 )) as non_zero_age_15_female,
        min( age_16_female ) as min_age_16_female, max( age_16_female ) as max_age_16_female, count( nullif( age_16_female, 0 )) as non_zero_age_16_female,
        min( age_17_female ) as min_age_17_female, max( age_17_female ) as max_age_17_female, count( nullif( age_17_female, 0 )) as non_zero_age_17_female,
        min( age_18_female ) as min_age_18_female, max( age_18_female ) as max_age_18_female, count( nullif( age_18_female, 0 )) as non_zero_age_18_female,
        min( age_19_female ) as min_age_19_female, max( age_19_female ) as max_age_19_female, count( nullif( age_19_female, 0 )) as non_zero_age_19_female,
        min( age_20_female ) as min_age_20_female, max( age_20_female ) as max_age_20_female, count( nullif( age_20_female, 0 )) as non_zero_age_20_female,
        min( age_21_female ) as min_age_21_female, max( age_21_female ) as max_age_21_female, count( nullif( age_21_female, 0 )) as non_zero_age_21_female,
        min( age_22_female ) as min_age_22_female, max( age_22_female ) as max_age_22_female, count( nullif( age_22_female, 0 )) as non_zero_age_22_female,
        min( age_23_female ) as min_age_23_female, max( age_23_female ) as max_age_23_female, count( nullif( age_23_female, 0 )) as non_zero_age_23_female,
        min( age_24_female ) as min_age_24_female, max( age_24_female ) as max_age_24_female, count( nullif( age_24_female, 0 )) as non_zero_age_24_female,
        min( age_25_female ) as min_age_25_female, max( age_25_female ) as max_age_25_female, count( nullif( age_25_female, 0 )) as non_zero_age_25_female,
        min( age_26_female ) as min_age_26_female, max( age_26_female ) as max_age_26_female, count( nullif( age_26_female, 0 )) as non_zero_age_26_female,
        min( age_27_female ) as min_age_27_female, max( age_27_female ) as max_age_27_female, count( nullif( age_27_female, 0 )) as non_zero_age_27_female,
        min( age_28_female ) as min_age_28_female, max( age_28_female ) as max_age_28_female, count( nullif( age_28_female, 0 )) as non_zero_age_28_female,
        min( age_29_female ) as min_age_29_female, max( age_29_female ) as max_age_29_female, count( nullif( age_29_female, 0 )) as non_zero_age_29_female,
        min( age_30_female ) as min_age_30_female, max( age_30_female ) as max_age_30_female, count( nullif( age_30_female, 0 )) as non_zero_age_30_female,
        min( age_31_female ) as min_age_31_female, max( age_31_female ) as max_age_31_female, count( nullif( age_31_female, 0 )) as non_zero_age_31_female,
        min( age_32_female ) as min_age_32_female, max( age_32_female ) as max_age_32_female, count( nullif( age_32_female, 0 )) as non_zero_age_32_female,
        min( age_33_female ) as min_age_33_female, max( age_33_female ) as max_age_33_female, count( nullif( age_33_female, 0 )) as non_zero_age_33_female,
        min( age_34_female ) as min_age_34_female, max( age_34_female ) as max_age_34_female, count( nullif( age_34_female, 0 )) as non_zero_age_34_female,
        min( age_35_female ) as min_age_35_female, max( age_35_female ) as max_age_35_female, count( nullif( age_35_female, 0 )) as non_zero_age_35_female,
        min( age_36_female ) as min_age_36_female, max( age_36_female ) as max_age_36_female, count( nullif( age_36_female, 0 )) as non_zero_age_36_female,
        min( age_37_female ) as min_age_37_female, max( age_37_female ) as max_age_37_female, count( nullif( age_37_female, 0 )) as non_zero_age_37_female,
        min( age_38_female ) as min_age_38_female, max( age_38_female ) as max_age_38_female, count( nullif( age_38_female, 0 )) as non_zero_age_38_female,
        min( age_39_female ) as min_age_39_female, max( age_39_female ) as max_age_39_female, count( nullif( age_39_female, 0 )) as non_zero_age_39_female,
        min( age_40_female ) as min_age_40_female, max( age_40_female ) as max_age_40_female, count( nullif( age_40_female, 0 )) as non_zero_age_40_female,
        min( age_41_female ) as min_age_41_female, max( age_41_female ) as max_age_41_female, count( nullif( age_41_female, 0 )) as non_zero_age_41_female,
        min( age_42_female ) as min_age_42_female, max( age_42_female ) as max_age_42_female, count( nullif( age_42_female, 0 )) as non_zero_age_42_female,
        min( age_43_female ) as min_age_43_female, max( age_43_female ) as max_age_43_female, count( nullif( age_43_female, 0 )) as non_zero_age_43_female,
        min( age_44_female ) as min_age_44_female, max( age_44_female ) as max_age_44_female, count( nullif( age_44_female, 0 )) as non_zero_age_44_female,
        min( age_45_female ) as min_age_45_female, max( age_45_female ) as max_age_45_female, count( nullif( age_45_female, 0 )) as non_zero_age_45_female,
        min( age_46_female ) as min_age_46_female, max( age_46_female ) as max_age_46_female, count( nullif( age_46_female, 0 )) as non_zero_age_46_female,
        min( age_47_female ) as min_age_47_female, max( age_47_female ) as max_age_47_female, count( nullif( age_47_female, 0 )) as non_zero_age_47_female,
        min( age_48_female ) as min_age_48_female, max( age_48_female ) as max_age_48_female, count( nullif( age_48_female, 0 )) as non_zero_age_48_female,
        min( age_49_female ) as min_age_49_female, max( age_49_female ) as max_age_49_female, count( nullif( age_49_female, 0 )) as non_zero_age_49_female,
        min( age_50_female ) as min_age_50_female, max( age_50_female ) as max_age_50_female, count( nullif( age_50_female, 0 )) as non_zero_age_50_female,
        min( age_51_female ) as min_age_51_female, max( age_51_female ) as max_age_51_female, count( nullif( age_51_female, 0 )) as non_zero_age_51_female,
        min( age_52_female ) as min_age_52_female, max( age_52_female ) as max_age_52_female, count( nullif( age_52_female, 0 )) as non_zero_age_52_female,
        min( age_53_female ) as min_age_53_female, max( age_53_female ) as max_age_53_female, count( nullif( age_53_female, 0 )) as non_zero_age_53_female,
        min( age_54_female ) as min_age_54_female, max( age_54_female ) as max_age_54_female, count( nullif( age_54_female, 0 )) as non_zero_age_54_female,
        min( age_55_female ) as min_age_55_female, max( age_55_female ) as max_age_55_female, count( nullif( age_55_female, 0 )) as non_zero_age_55_female,
        min( age_56_female ) as min_age_56_female, max( age_56_female ) as max_age_56_female, count( nullif( age_56_female, 0 )) as non_zero_age_56_female,
        min( age_57_female ) as min_age_57_female, max( age_57_female ) as max_age_57_female, count( nullif( age_57_female, 0 )) as non_zero_age_57_female,
        min( age_58_female ) as min_age_58_female, max( age_58_female ) as max_age_58_female, count( nullif( age_58_female, 0 )) as non_zero_age_58_female,
        min( age_59_female ) as min_age_59_female, max( age_59_female ) as max_age_59_female, count( nullif( age_59_female, 0 )) as non_zero_age_59_female,
        min( age_60_female ) as min_age_60_female, max( age_60_female ) as max_age_60_female, count( nullif( age_60_female, 0 )) as non_zero_age_60_female,
        min( age_61_female ) as min_age_61_female, max( age_61_female ) as max_age_61_female, count( nullif( age_61_female, 0 )) as non_zero_age_61_female,
        min( age_62_female ) as min_age_62_female, max( age_62_female ) as max_age_62_female, count( nullif( age_62_female, 0 )) as non_zero_age_62_female,
        min( age_63_female ) as min_age_63_female, max( age_63_female ) as max_age_63_female, count( nullif( age_63_female, 0 )) as non_zero_age_63_female,
        min( age_64_female ) as min_age_64_female, max( age_64_female ) as max_age_64_female, count( nullif( age_64_female, 0 )) as non_zero_age_64_female,
        min( age_65_female ) as min_age_65_female, max( age_65_female ) as max_age_65_female, count( nullif( age_65_female, 0 )) as non_zero_age_65_female,
        min( age_66_female ) as min_age_66_female, max( age_66_female ) as max_age_66_female, count( nullif( age_66_female, 0 )) as non_zero_age_66_female,
        min( age_67_female ) as min_age_67_female, max( age_67_female ) as max_age_67_female, count( nullif( age_67_female, 0 )) as non_zero_age_67_female,
        min( age_68_female ) as min_age_68_female, max( age_68_female ) as max_age_68_female, count( nullif( age_68_female, 0 )) as non_zero_age_68_female,
        min( age_69_female ) as min_age_69_female, max( age_69_female ) as max_age_69_female, count( nullif( age_69_female, 0 )) as non_zero_age_69_female,
        min( age_70_female ) as min_age_70_female, max( age_70_female ) as max_age_70_female, count( nullif( age_70_female, 0 )) as non_zero_age_70_female,
        min( age_71_female ) as min_age_71_female, max( age_71_female ) as max_age_71_female, count( nullif( age_71_female, 0 )) as non_zero_age_71_female,
        min( age_72_female ) as min_age_72_female, max( age_72_female ) as max_age_72_female, count( nullif( age_72_female, 0 )) as non_zero_age_72_female,
        min( age_73_female ) as min_age_73_female, max( age_73_female ) as max_age_73_female, count( nullif( age_73_female, 0 )) as non_zero_age_73_female,
        min( age_74_female ) as min_age_74_female, max( age_74_female ) as max_age_74_female, count( nullif( age_74_female, 0 )) as non_zero_age_74_female,
        min( age_75_female ) as min_age_75_female, max( age_75_female ) as max_age_75_female, count( nullif( age_75_female, 0 )) as non_zero_age_75_female,
        min( age_76_female ) as min_age_76_female, max( age_76_female ) as max_age_76_female, count( nullif( age_76_female, 0 )) as non_zero_age_76_female,
        min( age_77_female ) as min_age_77_female, max( age_77_female ) as max_age_77_female, count( nullif( age_77_female, 0 )) as non_zero_age_77_female,
        min( age_78_female ) as min_age_78_female, max( age_78_female ) as max_age_78_female, count( nullif( age_78_female, 0 )) as non_zero_age_78_female,
        min( age_79_female ) as min_age_79_female, max( age_79_female ) as max_age_79_female, count( nullif( age_79_female, 0 )) as non_zero_age_79_female,
        min( age_80_female ) as min_age_80_female, max( age_80_female ) as max_age_80_female, count( nullif( age_80_female, 0 )) as non_zero_age_80_female,
        min( age_81_female ) as min_age_81_female, max( age_81_female ) as max_age_81_female, count( nullif( age_81_female, 0 )) as non_zero_age_81_female,
        min( age_82_female ) as min_age_82_female, max( age_82_female ) as max_age_82_female, count( nullif( age_82_female, 0 )) as non_zero_age_82_female,
        min( age_83_female ) as min_age_83_female, max( age_83_female ) as max_age_83_female, count( nullif( age_83_female, 0 )) as non_zero_age_83_female,
        min( age_84_female ) as min_age_84_female, max( age_84_female ) as max_age_84_female, count( nullif( age_84_female, 0 )) as non_zero_age_84_female,
        min( age_85_female ) as min_age_85_female, max( age_85_female ) as max_age_85_female, count( nullif( age_85_female, 0 )) as non_zero_age_85_female,
        min( age_86_female ) as min_age_86_female, max( age_86_female ) as max_age_86_female, count( nullif( age_86_female, 0 )) as non_zero_age_86_female,
        min( age_87_female ) as min_age_87_female, max( age_87_female ) as max_age_87_female, count( nullif( age_87_female, 0 )) as non_zero_age_87_female,
        min( age_88_female ) as min_age_88_female, max( age_88_female ) as max_age_88_female, count( nullif( age_88_female, 0 )) as non_zero_age_88_female,
        min( age_89_female ) as min_age_89_female, max( age_89_female ) as max_age_89_female, count( nullif( age_89_female, 0 )) as non_zero_age_89_female,
        min( age_90_female ) as min_age_90_female, max( age_90_female ) as max_age_90_female, count( nullif( age_90_female, 0 )) as non_zero_age_90_female,
        min( age_91_female ) as min_age_91_female, max( age_91_female ) as max_age_91_female, count( nullif( age_91_female, 0 )) as non_zero_age_91_female,
        min( age_92_female ) as min_age_92_female, max( age_92_female ) as max_age_92_female, count( nullif( age_92_female, 0 )) as non_zero_age_92_female,
        min( age_93_female ) as min_age_93_female, max( age_93_female ) as max_age_93_female, count( nullif( age_93_female, 0 )) as non_zero_age_93_female,
        min( age_94_female ) as min_age_94_female, max( age_94_female ) as max_age_94_female, count( nullif( age_94_female, 0 )) as non_zero_age_94_female,
        min( age_95_female ) as min_age_95_female, max( age_95_female ) as max_age_95_female, count( nullif( age_95_female, 0 )) as non_zero_age_95_female,
        min( age_96_female ) as min_age_96_female, max( age_96_female ) as max_age_96_female, count( nullif( age_96_female, 0 )) as non_zero_age_96_female,
        min( age_97_female ) as min_age_97_female, max( age_97_female ) as max_age_97_female, count( nullif( age_97_female, 0 )) as non_zero_age_97_female,
        min( age_98_female ) as min_age_98_female, max( age_98_female ) as max_age_98_female, count( nullif( age_98_female, 0 )) as non_zero_age_98_female,
        min( age_99_female ) as min_age_99_female, max( age_99_female ) as max_age_99_female, count( nullif( age_99_female, 0 )) as non_zero_age_99_female,
        min( age_100_female ) as min_age_100_female, max( age_100_female ) as max_age_100_female, count( nullif( age_100_female, 0 )) as non_zero_age_100_female,
        min( age_101_female ) as min_age_101_female, max( age_101_female ) as max_age_101_female, count( nullif( age_101_female, 0 )) as non_zero_age_101_female,
        min( age_102_female ) as min_age_102_female, max( age_102_female ) as max_age_102_female, count( nullif( age_102_female, 0 )) as non_zero_age_102_female,
        min( age_103_female ) as min_age_103_female, max( age_103_female ) as max_age_103_female, count( nullif( age_103_female, 0 )) as non_zero_age_103_female,
        min( age_104_female ) as min_age_104_female, max( age_104_female ) as max_age_104_female, count( nullif( age_104_female, 0 )) as non_zero_age_104_female,
        min( age_105_female ) as min_age_105_female, max( age_105_female ) as max_age_105_female, count( nullif( age_105_female, 0 )) as non_zero_age_105_female,
        min( age_106_female ) as min_age_106_female, max( age_106_female ) as max_age_106_female, count( nullif( age_106_female, 0 )) as non_zero_age_106_female,
        min( age_107_female ) as min_age_107_female, max( age_107_female ) as max_age_107_female, count( nullif( age_107_female, 0 )) as non_zero_age_107_female,
        min( age_108_female ) as min_age_108_female, max( age_108_female ) as max_age_108_female, count( nullif( age_108_female, 0 )) as non_zero_age_108_female,
        min( age_109_female ) as min_age_109_female, max( age_109_female ) as max_age_109_female, count( nullif( age_109_female, 0 )) as non_zero_age_109_female,
        min( age_110_female ) as min_age_110_female, max( age_110_female ) as max_age_110_female, count( nullif( age_110_female, 0 )) as non_zero_age_110_female,
        min( age_0 ) as min_age_0, max( age_0 ) as max_age_0, count( nullif( age_0, 0 )) as non_zero_age_0,
        min( age_1 ) as min_age_1, max( age_1 ) as max_age_1, count( nullif( age_1, 0 )) as non_zero_age_1,
        min( age_2 ) as min_age_2, max( age_2 ) as max_age_2, count( nullif( age_2, 0 )) as non_zero_age_2,
        min( age_3 ) as min_age_3, max( age_3 ) as max_age_3, count( nullif( age_3, 0 )) as non_zero_age_3,
        min( age_4 ) as min_age_4, max( age_4 ) as max_age_4, count( nullif( age_4, 0 )) as non_zero_age_4,
        min( age_5 ) as min_age_5, max( age_5 ) as max_age_5, count( nullif( age_5, 0 )) as non_zero_age_5,
        min( age_6 ) as min_age_6, max( age_6 ) as max_age_6, count( nullif( age_6, 0 )) as non_zero_age_6,
        min( age_7 ) as min_age_7, max( age_7 ) as max_age_7, count( nullif( age_7, 0 )) as non_zero_age_7,
        min( age_8 ) as min_age_8, max( age_8 ) as max_age_8, count( nullif( age_8, 0 )) as non_zero_age_8,
        min( age_9 ) as min_age_9, max( age_9 ) as max_age_9, count( nullif( age_9, 0 )) as non_zero_age_9,
        min( age_10 ) as min_age_10, max( age_10 ) as max_age_10, count( nullif( age_10, 0 )) as non_zero_age_10,
        min( age_11 ) as min_age_11, max( age_11 ) as max_age_11, count( nullif( age_11, 0 )) as non_zero_age_11,
        min( age_12 ) as min_age_12, max( age_12 ) as max_age_12, count( nullif( age_12, 0 )) as non_zero_age_12,
        min( age_13 ) as min_age_13, max( age_13 ) as max_age_13, count( nullif( age_13, 0 )) as non_zero_age_13,
        min( age_14 ) as min_age_14, max( age_14 ) as max_age_14, count( nullif( age_14, 0 )) as non_zero_age_14,
        min( age_15 ) as min_age_15, max( age_15 ) as max_age_15, count( nullif( age_15, 0 )) as non_zero_age_15,
        min( age_16 ) as min_age_16, max( age_16 ) as max_age_16, count( nullif( age_16, 0 )) as non_zero_age_16,
        min( age_17 ) as min_age_17, max( age_17 ) as max_age_17, count( nullif( age_17, 0 )) as non_zero_age_17,
        min( age_18 ) as min_age_18, max( age_18 ) as max_age_18, count( nullif( age_18, 0 )) as non_zero_age_18,
        min( age_19 ) as min_age_19, max( age_19 ) as max_age_19, count( nullif( age_19, 0 )) as non_zero_age_19,
        min( age_20 ) as min_age_20, max( age_20 ) as max_age_20, count( nullif( age_20, 0 )) as non_zero_age_20,
        min( age_21 ) as min_age_21, max( age_21 ) as max_age_21, count( nullif( age_21, 0 )) as non_zero_age_21,
        min( age_22 ) as min_age_22, max( age_22 ) as max_age_22, count( nullif( age_22, 0 )) as non_zero_age_22,
        min( age_23 ) as min_age_23, max( age_23 ) as max_age_23, count( nullif( age_23, 0 )) as non_zero_age_23,
        min( age_24 ) as min_age_24, max( age_24 ) as max_age_24, count( nullif( age_24, 0 )) as non_zero_age_24,
        min( age_25 ) as min_age_25, max( age_25 ) as max_age_25, count( nullif( age_25, 0 )) as non_zero_age_25,
        min( age_26 ) as min_age_26, max( age_26 ) as max_age_26, count( nullif( age_26, 0 )) as non_zero_age_26,
        min( age_27 ) as min_age_27, max( age_27 ) as max_age_27, count( nullif( age_27, 0 )) as non_zero_age_27,
        min( age_28 ) as min_age_28, max( age_28 ) as max_age_28, count( nullif( age_28, 0 )) as non_zero_age_28,
        min( age_29 ) as min_age_29, max( age_29 ) as max_age_29, count( nullif( age_29, 0 )) as non_zero_age_29,
        min( age_30 ) as min_age_30, max( age_30 ) as max_age_30, count( nullif( age_30, 0 )) as non_zero_age_30,
        min( age_31 ) as min_age_31, max( age_31 ) as max_age_31, count( nullif( age_31, 0 )) as non_zero_age_31,
        min( age_32 ) as min_age_32, max( age_32 ) as max_age_32, count( nullif( age_32, 0 )) as non_zero_age_32,
        min( age_33 ) as min_age_33, max( age_33 ) as max_age_33, count( nullif( age_33, 0 )) as non_zero_age_33,
        min( age_34 ) as min_age_34, max( age_34 ) as max_age_34, count( nullif( age_34, 0 )) as non_zero_age_34,
        min( age_35 ) as min_age_35, max( age_35 ) as max_age_35, count( nullif( age_35, 0 )) as non_zero_age_35,
        min( age_36 ) as min_age_36, max( age_36 ) as max_age_36, count( nullif( age_36, 0 )) as non_zero_age_36,
        min( age_37 ) as min_age_37, max( age_37 ) as max_age_37, count( nullif( age_37, 0 )) as non_zero_age_37,
        min( age_38 ) as min_age_38, max( age_38 ) as max_age_38, count( nullif( age_38, 0 )) as non_zero_age_38,
        min( age_39 ) as min_age_39, max( age_39 ) as max_age_39, count( nullif( age_39, 0 )) as non_zero_age_39,
        min( age_40 ) as min_age_40, max( age_40 ) as max_age_40, count( nullif( age_40, 0 )) as non_zero_age_40,
        min( age_41 ) as min_age_41, max( age_41 ) as max_age_41, count( nullif( age_41, 0 )) as non_zero_age_41,
        min( age_42 ) as min_age_42, max( age_42 ) as max_age_42, count( nullif( age_42, 0 )) as non_zero_age_42,
        min( age_43 ) as min_age_43, max( age_43 ) as max_age_43, count( nullif( age_43, 0 )) as non_zero_age_43,
        min( age_44 ) as min_age_44, max( age_44 ) as max_age_44, count( nullif( age_44, 0 )) as non_zero_age_44,
        min( age_45 ) as min_age_45, max( age_45 ) as max_age_45, count( nullif( age_45, 0 )) as non_zero_age_45,
        min( age_46 ) as min_age_46, max( age_46 ) as max_age_46, count( nullif( age_46, 0 )) as non_zero_age_46,
        min( age_47 ) as min_age_47, max( age_47 ) as max_age_47, count( nullif( age_47, 0 )) as non_zero_age_47,
        min( age_48 ) as min_age_48, max( age_48 ) as max_age_48, count( nullif( age_48, 0 )) as non_zero_age_48,
        min( age_49 ) as min_age_49, max( age_49 ) as max_age_49, count( nullif( age_49, 0 )) as non_zero_age_49,
        min( age_50 ) as min_age_50, max( age_50 ) as max_age_50, count( nullif( age_50, 0 )) as non_zero_age_50,
        min( age_51 ) as min_age_51, max( age_51 ) as max_age_51, count( nullif( age_51, 0 )) as non_zero_age_51,
        min( age_52 ) as min_age_52, max( age_52 ) as max_age_52, count( nullif( age_52, 0 )) as non_zero_age_52,
        min( age_53 ) as min_age_53, max( age_53 ) as max_age_53, count( nullif( age_53, 0 )) as non_zero_age_53,
        min( age_54 ) as min_age_54, max( age_54 ) as max_age_54, count( nullif( age_54, 0 )) as non_zero_age_54,
        min( age_55 ) as min_age_55, max( age_55 ) as max_age_55, count( nullif( age_55, 0 )) as non_zero_age_55,
        min( age_56 ) as min_age_56, max( age_56 ) as max_age_56, count( nullif( age_56, 0 )) as non_zero_age_56,
        min( age_57 ) as min_age_57, max( age_57 ) as max_age_57, count( nullif( age_57, 0 )) as non_zero_age_57,
        min( age_58 ) as min_age_58, max( age_58 ) as max_age_58, count( nullif( age_58, 0 )) as non_zero_age_58,
        min( age_59 ) as min_age_59, max( age_59 ) as max_age_59, count( nullif( age_59, 0 )) as non_zero_age_59,
        min( age_60 ) as min_age_60, max( age_60 ) as max_age_60, count( nullif( age_60, 0 )) as non_zero_age_60,
        min( age_61 ) as min_age_61, max( age_61 ) as max_age_61, count( nullif( age_61, 0 )) as non_zero_age_61,
        min( age_62 ) as min_age_62, max( age_62 ) as max_age_62, count( nullif( age_62, 0 )) as non_zero_age_62,
        min( age_63 ) as min_age_63, max( age_63 ) as max_age_63, count( nullif( age_63, 0 )) as non_zero_age_63,
        min( age_64 ) as min_age_64, max( age_64 ) as max_age_64, count( nullif( age_64, 0 )) as non_zero_age_64,
        min( age_65 ) as min_age_65, max( age_65 ) as max_age_65, count( nullif( age_65, 0 )) as non_zero_age_65,
        min( age_66 ) as min_age_66, max( age_66 ) as max_age_66, count( nullif( age_66, 0 )) as non_zero_age_66,
        min( age_67 ) as min_age_67, max( age_67 ) as max_age_67, count( nullif( age_67, 0 )) as non_zero_age_67,
        min( age_68 ) as min_age_68, max( age_68 ) as max_age_68, count( nullif( age_68, 0 )) as non_zero_age_68,
        min( age_69 ) as min_age_69, max( age_69 ) as max_age_69, count( nullif( age_69, 0 )) as non_zero_age_69,
        min( age_70 ) as min_age_70, max( age_70 ) as max_age_70, count( nullif( age_70, 0 )) as non_zero_age_70,
        min( age_71 ) as min_age_71, max( age_71 ) as max_age_71, count( nullif( age_71, 0 )) as non_zero_age_71,
        min( age_72 ) as min_age_72, max( age_72 ) as max_age_72, count( nullif( age_72, 0 )) as non_zero_age_72,
        min( age_73 ) as min_age_73, max( age_73 ) as max_age_73, count( nullif( age_73, 0 )) as non_zero_age_73,
        min( age_74 ) as min_age_74, max( age_74 ) as max_age_74, count( nullif( age_74, 0 )) as non_zero_age_74,
        min( age_75 ) as min_age_75, max( age_75 ) as max_age_75, count( nullif( age_75, 0 )) as non_zero_age_75,
        min( age_76 ) as min_age_76, max( age_76 ) as max_age_76, count( nullif( age_76, 0 )) as non_zero_age_76,
        min( age_77 ) as min_age_77, max( age_77 ) as max_age_77, count( nullif( age_77, 0 )) as non_zero_age_77,
        min( age_78 ) as min_age_78, max( age_78 ) as max_age_78, count( nullif( age_78, 0 )) as non_zero_age_78,
        min( age_79 ) as min_age_79, max( age_79 ) as max_age_79, count( nullif( age_79, 0 )) as non_zero_age_79,
        min( age_80 ) as min_age_80, max( age_80 ) as max_age_80, count( nullif( age_80, 0 )) as non_zero_age_80,
        min( age_81 ) as min_age_81, max( age_81 ) as max_age_81, count( nullif( age_81, 0 )) as non_zero_age_81,
        min( age_82 ) as min_age_82, max( age_82 ) as max_age_82, count( nullif( age_82, 0 )) as non_zero_age_82,
        min( age_83 ) as min_age_83, max( age_83 ) as max_age_83, count( nullif( age_83, 0 )) as non_zero_age_83,
        min( age_84 ) as min_age_84, max( age_84 ) as max_age_84, count( nullif( age_84, 0 )) as non_zero_age_84,
        min( age_85 ) as min_age_85, max( age_85 ) as max_age_85, count( nullif( age_85, 0 )) as non_zero_age_85,
        min( age_86 ) as min_age_86, max( age_86 ) as max_age_86, count( nullif( age_86, 0 )) as non_zero_age_86,
        min( age_87 ) as min_age_87, max( age_87 ) as max_age_87, count( nullif( age_87, 0 )) as non_zero_age_87,
        min( age_88 ) as min_age_88, max( age_88 ) as max_age_88, count( nullif( age_88, 0 )) as non_zero_age_88,
        min( age_89 ) as min_age_89, max( age_89 ) as max_age_89, count( nullif( age_89, 0 )) as non_zero_age_89,
        min( age_90 ) as min_age_90, max( age_90 ) as max_age_90, count( nullif( age_90, 0 )) as non_zero_age_90,
        min( age_91 ) as min_age_91, max( age_91 ) as max_age_91, count( nullif( age_91, 0 )) as non_zero_age_91,
        min( age_92 ) as min_age_92, max( age_92 ) as max_age_92, count( nullif( age_92, 0 )) as non_zero_age_92,
        min( age_93 ) as min_age_93, max( age_93 ) as max_age_93, count( nullif( age_93, 0 )) as non_zero_age_93,
        min( age_94 ) as min_age_94, max( age_94 ) as max_age_94, count( nullif( age_94, 0 )) as non_zero_age_94,
        min( age_95 ) as min_age_95, max( age_95 ) as max_age_95, count( nullif( age_95, 0 )) as non_zero_age_95,
        min( age_96 ) as min_age_96, max( age_96 ) as max_age_96, count( nullif( age_96, 0 )) as non_zero_age_96,
        min( age_97 ) as min_age_97, max( age_97 ) as max_age_97, count( nullif( age_97, 0 )) as non_zero_age_97,
        min( age_98 ) as min_age_98, max( age_98 ) as max_age_98, count( nullif( age_98, 0 )) as non_zero_age_98,
        min( age_99 ) as min_age_99, max( age_99 ) as max_age_99, count( nullif( age_99, 0 )) as non_zero_age_99,
        min( age_100 ) as min_age_100, max( age_100 ) as max_age_100, count( nullif( age_100, 0 )) as non_zero_age_100,
        min( age_101 ) as min_age_101, max( age_101 ) as max_age_101, count( nullif( age_101, 0 )) as non_zero_age_101,
        min( age_102 ) as min_age_102, max( age_102 ) as max_age_102, count( nullif( age_102, 0 )) as non_zero_age_102,
        min( age_103 ) as min_age_103, max( age_103 ) as max_age_103, count( nullif( age_103, 0 )) as non_zero_age_103,
        min( age_104 ) as min_age_104, max( age_104 ) as max_age_104, count( nullif( age_104, 0 )) as non_zero_age_104,
        min( age_105 ) as min_age_105, max( age_105 ) as max_age_105, count( nullif( age_105, 0 )) as non_zero_age_105,
        min( age_106 ) as min_age_106, max( age_106 ) as max_age_106, count( nullif( age_106, 0 )) as non_zero_age_106,
        min( age_107 ) as min_age_107, max( age_107 ) as max_age_107, count( nullif( age_107, 0 )) as non_zero_age_107,
        min( age_108 ) as min_age_108, max( age_108 ) as max_age_108, count( nullif( age_108, 0 )) as non_zero_age_108,
        min( age_109 ) as min_age_109, max( age_109 ) as max_age_109, count( nullif( age_109, 0 )) as non_zero_age_109,
        min( age_110 ) as min_age_110, max( age_110 ) as max_age_110, count( nullif( age_110, 0 )) as non_zero_age_110
from target_data.target_dataset group by run_id,user_id,year order by run_id,user_id,year;


alter table target_data.run add column macro_edition INTEGER default 1970;
alter table target_data.run add column households_edition INTEGER default 1970;
alter table target_data.run add column population_edition INTEGER default 1970;
alter table target_data.run add column country TEXT default 'SCO';
alter table target_data.run drop column household_source;
alter table target_data.run add column households_source TEXT;

alter table target_data.run drop column households_source;
alter table target_data.run drop column population_source;
alter table target_data.run drop column macro_source;

alter table target_data.run add column households_variant TEXT;
alter table target_data.run add column population_variant TEXT;
alter table target_data.run add column macro_variant TEXT;

select 
        run_id,count(*) 
from                
        target_data.target_dataset
group by 
        run_id
order by
        run_id;

        
select
        *
from
        target_data.run
order by
        run_id;

select 
        run_id,year,target_year,count(*),min( weight ), max( weight ), avg( weight )
from 
        target_data.output_weights
where 
        run_id >= 200000
group by 
        run_id,year,target_year
order by 
        run_id,target_year,year; 

select 
        run_id,target_year,count(*) 
from 
        target_data.output_weights
where 
        run_id >= 200000
group by 
        run_id,target_year
order by 
        run_id,target_year; 
        
select 
        run_id,
        user_id,
        year,
        min( country_uk ) as min_country_uk, max( country_uk ) as max_country_uk, count( nullif( country_uk, 0 )) as non_zero_country_uk,
        min( country_scotland ) as min_country_scotland, max( country_scotland ) as max_country_scotland, count( nullif( country_scotland, 0 )) as non_zero_country_scotland,
        min( country_england ) as min_country_england, max( country_england ) as max_country_england, count( nullif( country_england, 0 )) as non_zero_country_england,
        min( country_wales ) as min_country_wales, max( country_wales ) as max_country_wales, count( nullif( country_wales, 0 )) as non_zero_country_wales,
        min( country_n_ireland ) as min_country_n_ireland, max( country_n_ireland ) as max_country_n_ireland, count( nullif( country_n_ireland, 0 )) as non_zero_country_n_ireland,
        min( male ) as min_male, max( male ) as max_male, count( nullif( male, 0 )) as non_zero_male,
        min( female ) as min_female, max( female ) as max_female, count( nullif( female, 0 )) as non_zero_female,
        min( employed ) as min_employed, max( employed ) as max_employed, count( nullif( employed, 0 )) as non_zero_employed,
        min( employee ) as min_employee, max( employee ) as max_employee, count( nullif( employee, 0 )) as non_zero_employee,
        min( ilo_unemployed ) as min_ilo_unemployed, max( ilo_unemployed ) as max_ilo_unemployed, count( nullif( ilo_unemployed, 0 )) as non_zero_ilo_unemployed,
        min( jsa_claimant ) as min_jsa_claimant, max( jsa_claimant ) as max_jsa_claimant, count( nullif( jsa_claimant, 0 )) as non_zero_jsa_claimant,
        min( age_0_male ) as min_age_0_male, max( age_0_male ) as max_age_0_male, count( nullif( age_0_male, 0 )) as non_zero_age_0_male,
        min( age_1_male ) as min_age_1_male, max( age_1_male ) as max_age_1_male, count( nullif( age_1_male, 0 )) as non_zero_age_1_male,
        min( age_2_male ) as min_age_2_male, max( age_2_male ) as max_age_2_male, count( nullif( age_2_male, 0 )) as non_zero_age_2_male,
        min( age_3_male ) as min_age_3_male, max( age_3_male ) as max_age_3_male, count( nullif( age_3_male, 0 )) as non_zero_age_3_male,
        min( age_4_male ) as min_age_4_male, max( age_4_male ) as max_age_4_male, count( nullif( age_4_male, 0 )) as non_zero_age_4_male,
        min( age_5_male ) as min_age_5_male, max( age_5_male ) as max_age_5_male, count( nullif( age_5_male, 0 )) as non_zero_age_5_male,
        min( age_6_male ) as min_age_6_male, max( age_6_male ) as max_age_6_male, count( nullif( age_6_male, 0 )) as non_zero_age_6_male,
        min( age_7_male ) as min_age_7_male, max( age_7_male ) as max_age_7_male, count( nullif( age_7_male, 0 )) as non_zero_age_7_male,
        min( age_8_male ) as min_age_8_male, max( age_8_male ) as max_age_8_male, count( nullif( age_8_male, 0 )) as non_zero_age_8_male,
        min( age_9_male ) as min_age_9_male, max( age_9_male ) as max_age_9_male, count( nullif( age_9_male, 0 )) as non_zero_age_9_male,
        min( age_10_male ) as min_age_10_male, max( age_10_male ) as max_age_10_male, count( nullif( age_10_male, 0 )) as non_zero_age_10_male,
        min( age_11_male ) as min_age_11_male, max( age_11_male ) as max_age_11_male, count( nullif( age_11_male, 0 )) as non_zero_age_11_male,
        min( age_12_male ) as min_age_12_male, max( age_12_male ) as max_age_12_male, count( nullif( age_12_male, 0 )) as non_zero_age_12_male,
        min( age_13_male ) as min_age_13_male, max( age_13_male ) as max_age_13_male, count( nullif( age_13_male, 0 )) as non_zero_age_13_male,
        min( age_14_male ) as min_age_14_male, max( age_14_male ) as max_age_14_male, count( nullif( age_14_male, 0 )) as non_zero_age_14_male,
        min( age_15_male ) as min_age_15_male, max( age_15_male ) as max_age_15_male, count( nullif( age_15_male, 0 )) as non_zero_age_15_male,
        min( age_16_male ) as min_age_16_male, max( age_16_male ) as max_age_16_male, count( nullif( age_16_male, 0 )) as non_zero_age_16_male,
        min( age_17_male ) as min_age_17_male, max( age_17_male ) as max_age_17_male, count( nullif( age_17_male, 0 )) as non_zero_age_17_male,
        min( age_18_male ) as min_age_18_male, max( age_18_male ) as max_age_18_male, count( nullif( age_18_male, 0 )) as non_zero_age_18_male,
        min( age_19_male ) as min_age_19_male, max( age_19_male ) as max_age_19_male, count( nullif( age_19_male, 0 )) as non_zero_age_19_male,
        min( age_20_male ) as min_age_20_male, max( age_20_male ) as max_age_20_male, count( nullif( age_20_male, 0 )) as non_zero_age_20_male,
        min( age_21_male ) as min_age_21_male, max( age_21_male ) as max_age_21_male, count( nullif( age_21_male, 0 )) as non_zero_age_21_male,
        min( age_22_male ) as min_age_22_male, max( age_22_male ) as max_age_22_male, count( nullif( age_22_male, 0 )) as non_zero_age_22_male,
        min( age_23_male ) as min_age_23_male, max( age_23_male ) as max_age_23_male, count( nullif( age_23_male, 0 )) as non_zero_age_23_male,
        min( age_24_male ) as min_age_24_male, max( age_24_male ) as max_age_24_male, count( nullif( age_24_male, 0 )) as non_zero_age_24_male,
        min( age_25_male ) as min_age_25_male, max( age_25_male ) as max_age_25_male, count( nullif( age_25_male, 0 )) as non_zero_age_25_male,
        min( age_26_male ) as min_age_26_male, max( age_26_male ) as max_age_26_male, count( nullif( age_26_male, 0 )) as non_zero_age_26_male,
        min( age_27_male ) as min_age_27_male, max( age_27_male ) as max_age_27_male, count( nullif( age_27_male, 0 )) as non_zero_age_27_male,
        min( age_28_male ) as min_age_28_male, max( age_28_male ) as max_age_28_male, count( nullif( age_28_male, 0 )) as non_zero_age_28_male,
        min( age_29_male ) as min_age_29_male, max( age_29_male ) as max_age_29_male, count( nullif( age_29_male, 0 )) as non_zero_age_29_male,
        min( age_30_male ) as min_age_30_male, max( age_30_male ) as max_age_30_male, count( nullif( age_30_male, 0 )) as non_zero_age_30_male,
        min( age_31_male ) as min_age_31_male, max( age_31_male ) as max_age_31_male, count( nullif( age_31_male, 0 )) as non_zero_age_31_male,
        min( age_32_male ) as min_age_32_male, max( age_32_male ) as max_age_32_male, count( nullif( age_32_male, 0 )) as non_zero_age_32_male,
        min( age_33_male ) as min_age_33_male, max( age_33_male ) as max_age_33_male, count( nullif( age_33_male, 0 )) as non_zero_age_33_male,
        min( age_34_male ) as min_age_34_male, max( age_34_male ) as max_age_34_male, count( nullif( age_34_male, 0 )) as non_zero_age_34_male,
        min( age_35_male ) as min_age_35_male, max( age_35_male ) as max_age_35_male, count( nullif( age_35_male, 0 )) as non_zero_age_35_male,
        min( age_36_male ) as min_age_36_male, max( age_36_male ) as max_age_36_male, count( nullif( age_36_male, 0 )) as non_zero_age_36_male,
        min( age_37_male ) as min_age_37_male, max( age_37_male ) as max_age_37_male, count( nullif( age_37_male, 0 )) as non_zero_age_37_male,
        min( age_38_male ) as min_age_38_male, max( age_38_male ) as max_age_38_male, count( nullif( age_38_male, 0 )) as non_zero_age_38_male,
        min( age_39_male ) as min_age_39_male, max( age_39_male ) as max_age_39_male, count( nullif( age_39_male, 0 )) as non_zero_age_39_male,
        min( age_40_male ) as min_age_40_male, max( age_40_male ) as max_age_40_male, count( nullif( age_40_male, 0 )) as non_zero_age_40_male,
        min( age_41_male ) as min_age_41_male, max( age_41_male ) as max_age_41_male, count( nullif( age_41_male, 0 )) as non_zero_age_41_male,
        min( age_42_male ) as min_age_42_male, max( age_42_male ) as max_age_42_male, count( nullif( age_42_male, 0 )) as non_zero_age_42_male,
        min( age_43_male ) as min_age_43_male, max( age_43_male ) as max_age_43_male, count( nullif( age_43_male, 0 )) as non_zero_age_43_male,
        min( age_44_male ) as min_age_44_male, max( age_44_male ) as max_age_44_male, count( nullif( age_44_male, 0 )) as non_zero_age_44_male,
        min( age_45_male ) as min_age_45_male, max( age_45_male ) as max_age_45_male, count( nullif( age_45_male, 0 )) as non_zero_age_45_male,
        min( age_46_male ) as min_age_46_male, max( age_46_male ) as max_age_46_male, count( nullif( age_46_male, 0 )) as non_zero_age_46_male,
        min( age_47_male ) as min_age_47_male, max( age_47_male ) as max_age_47_male, count( nullif( age_47_male, 0 )) as non_zero_age_47_male,
        min( age_48_male ) as min_age_48_male, max( age_48_male ) as max_age_48_male, count( nullif( age_48_male, 0 )) as non_zero_age_48_male,
        min( age_49_male ) as min_age_49_male, max( age_49_male ) as max_age_49_male, count( nullif( age_49_male, 0 )) as non_zero_age_49_male,
        min( age_50_male ) as min_age_50_male, max( age_50_male ) as max_age_50_male, count( nullif( age_50_male, 0 )) as non_zero_age_50_male,
        min( age_51_male ) as min_age_51_male, max( age_51_male ) as max_age_51_male, count( nullif( age_51_male, 0 )) as non_zero_age_51_male,
        min( age_52_male ) as min_age_52_male, max( age_52_male ) as max_age_52_male, count( nullif( age_52_male, 0 )) as non_zero_age_52_male,
        min( age_53_male ) as min_age_53_male, max( age_53_male ) as max_age_53_male, count( nullif( age_53_male, 0 )) as non_zero_age_53_male,
        min( age_54_male ) as min_age_54_male, max( age_54_male ) as max_age_54_male, count( nullif( age_54_male, 0 )) as non_zero_age_54_male,
        min( age_55_male ) as min_age_55_male, max( age_55_male ) as max_age_55_male, count( nullif( age_55_male, 0 )) as non_zero_age_55_male,
        min( age_56_male ) as min_age_56_male, max( age_56_male ) as max_age_56_male, count( nullif( age_56_male, 0 )) as non_zero_age_56_male,
        min( age_57_male ) as min_age_57_male, max( age_57_male ) as max_age_57_male, count( nullif( age_57_male, 0 )) as non_zero_age_57_male,
        min( age_58_male ) as min_age_58_male, max( age_58_male ) as max_age_58_male, count( nullif( age_58_male, 0 )) as non_zero_age_58_male,
        min( age_59_male ) as min_age_59_male, max( age_59_male ) as max_age_59_male, count( nullif( age_59_male, 0 )) as non_zero_age_59_male,
        min( age_60_male ) as min_age_60_male, max( age_60_male ) as max_age_60_male, count( nullif( age_60_male, 0 )) as non_zero_age_60_male,
        min( age_61_male ) as min_age_61_male, max( age_61_male ) as max_age_61_male, count( nullif( age_61_male, 0 )) as non_zero_age_61_male,
        min( age_62_male ) as min_age_62_male, max( age_62_male ) as max_age_62_male, count( nullif( age_62_male, 0 )) as non_zero_age_62_male,
        min( age_63_male ) as min_age_63_male, max( age_63_male ) as max_age_63_male, count( nullif( age_63_male, 0 )) as non_zero_age_63_male,
        min( age_64_male ) as min_age_64_male, max( age_64_male ) as max_age_64_male, count( nullif( age_64_male, 0 )) as non_zero_age_64_male,
        min( age_65_male ) as min_age_65_male, max( age_65_male ) as max_age_65_male, count( nullif( age_65_male, 0 )) as non_zero_age_65_male,
        min( age_66_male ) as min_age_66_male, max( age_66_male ) as max_age_66_male, count( nullif( age_66_male, 0 )) as non_zero_age_66_male,
        min( age_67_male ) as min_age_67_male, max( age_67_male ) as max_age_67_male, count( nullif( age_67_male, 0 )) as non_zero_age_67_male,
        min( age_68_male ) as min_age_68_male, max( age_68_male ) as max_age_68_male, count( nullif( age_68_male, 0 )) as non_zero_age_68_male,
        min( age_69_male ) as min_age_69_male, max( age_69_male ) as max_age_69_male, count( nullif( age_69_male, 0 )) as non_zero_age_69_male,
        min( age_70_male ) as min_age_70_male, max( age_70_male ) as max_age_70_male, count( nullif( age_70_male, 0 )) as non_zero_age_70_male,
        min( age_71_male ) as min_age_71_male, max( age_71_male ) as max_age_71_male, count( nullif( age_71_male, 0 )) as non_zero_age_71_male,
        min( age_72_male ) as min_age_72_male, max( age_72_male ) as max_age_72_male, count( nullif( age_72_male, 0 )) as non_zero_age_72_male,
        min( age_73_male ) as min_age_73_male, max( age_73_male ) as max_age_73_male, count( nullif( age_73_male, 0 )) as non_zero_age_73_male,
        min( age_74_male ) as min_age_74_male, max( age_74_male ) as max_age_74_male, count( nullif( age_74_male, 0 )) as non_zero_age_74_male,
        min( age_75_male ) as min_age_75_male, max( age_75_male ) as max_age_75_male, count( nullif( age_75_male, 0 )) as non_zero_age_75_male,
        min( age_76_male ) as min_age_76_male, max( age_76_male ) as max_age_76_male, count( nullif( age_76_male, 0 )) as non_zero_age_76_male,
        min( age_77_male ) as min_age_77_male, max( age_77_male ) as max_age_77_male, count( nullif( age_77_male, 0 )) as non_zero_age_77_male,
        min( age_78_male ) as min_age_78_male, max( age_78_male ) as max_age_78_male, count( nullif( age_78_male, 0 )) as non_zero_age_78_male,
        min( age_79_male ) as min_age_79_male, max( age_79_male ) as max_age_79_male, count( nullif( age_79_male, 0 )) as non_zero_age_79_male,
        min( age_80_male ) as min_age_80_male, max( age_80_male ) as max_age_80_male, count( nullif( age_80_male, 0 )) as non_zero_age_80_male,
        min( age_81_male ) as min_age_81_male, max( age_81_male ) as max_age_81_male, count( nullif( age_81_male, 0 )) as non_zero_age_81_male,
        min( age_82_male ) as min_age_82_male, max( age_82_male ) as max_age_82_male, count( nullif( age_82_male, 0 )) as non_zero_age_82_male,
        min( age_83_male ) as min_age_83_male, max( age_83_male ) as max_age_83_male, count( nullif( age_83_male, 0 )) as non_zero_age_83_male,
        min( age_84_male ) as min_age_84_male, max( age_84_male ) as max_age_84_male, count( nullif( age_84_male, 0 )) as non_zero_age_84_male,
        min( age_85_male ) as min_age_85_male, max( age_85_male ) as max_age_85_male, count( nullif( age_85_male, 0 )) as non_zero_age_85_male,
        min( age_86_male ) as min_age_86_male, max( age_86_male ) as max_age_86_male, count( nullif( age_86_male, 0 )) as non_zero_age_86_male,
        min( age_87_male ) as min_age_87_male, max( age_87_male ) as max_age_87_male, count( nullif( age_87_male, 0 )) as non_zero_age_87_male,
        min( age_88_male ) as min_age_88_male, max( age_88_male ) as max_age_88_male, count( nullif( age_88_male, 0 )) as non_zero_age_88_male,
        min( age_89_male ) as min_age_89_male, max( age_89_male ) as max_age_89_male, count( nullif( age_89_male, 0 )) as non_zero_age_89_male,
        min( age_90_male ) as min_age_90_male, max( age_90_male ) as max_age_90_male, count( nullif( age_90_male, 0 )) as non_zero_age_90_male,
        min( age_91_male ) as min_age_91_male, max( age_91_male ) as max_age_91_male, count( nullif( age_91_male, 0 )) as non_zero_age_91_male,
        min( age_92_male ) as min_age_92_male, max( age_92_male ) as max_age_92_male, count( nullif( age_92_male, 0 )) as non_zero_age_92_male,
        min( age_93_male ) as min_age_93_male, max( age_93_male ) as max_age_93_male, count( nullif( age_93_male, 0 )) as non_zero_age_93_male,
        min( age_94_male ) as min_age_94_male, max( age_94_male ) as max_age_94_male, count( nullif( age_94_male, 0 )) as non_zero_age_94_male,
        min( age_95_male ) as min_age_95_male, max( age_95_male ) as max_age_95_male, count( nullif( age_95_male, 0 )) as non_zero_age_95_male,
        min( age_96_male ) as min_age_96_male, max( age_96_male ) as max_age_96_male, count( nullif( age_96_male, 0 )) as non_zero_age_96_male,
        min( age_97_male ) as min_age_97_male, max( age_97_male ) as max_age_97_male, count( nullif( age_97_male, 0 )) as non_zero_age_97_male,
        min( age_98_male ) as min_age_98_male, max( age_98_male ) as max_age_98_male, count( nullif( age_98_male, 0 )) as non_zero_age_98_male,
        min( age_99_male ) as min_age_99_male, max( age_99_male ) as max_age_99_male, count( nullif( age_99_male, 0 )) as non_zero_age_99_male,
        min( age_100_male ) as min_age_100_male, max( age_100_male ) as max_age_100_male, count( nullif( age_100_male, 0 )) as non_zero_age_100_male,
        min( age_101_male ) as min_age_101_male, max( age_101_male ) as max_age_101_male, count( nullif( age_101_male, 0 )) as non_zero_age_101_male,
        min( age_102_male ) as min_age_102_male, max( age_102_male ) as max_age_102_male, count( nullif( age_102_male, 0 )) as non_zero_age_102_male,
        min( age_103_male ) as min_age_103_male, max( age_103_male ) as max_age_103_male, count( nullif( age_103_male, 0 )) as non_zero_age_103_male,
        min( age_104_male ) as min_age_104_male, max( age_104_male ) as max_age_104_male, count( nullif( age_104_male, 0 )) as non_zero_age_104_male,
        min( age_105_male ) as min_age_105_male, max( age_105_male ) as max_age_105_male, count( nullif( age_105_male, 0 )) as non_zero_age_105_male,
        min( age_106_male ) as min_age_106_male, max( age_106_male ) as max_age_106_male, count( nullif( age_106_male, 0 )) as non_zero_age_106_male,
        min( age_107_male ) as min_age_107_male, max( age_107_male ) as max_age_107_male, count( nullif( age_107_male, 0 )) as non_zero_age_107_male,
        min( age_108_male ) as min_age_108_male, max( age_108_male ) as max_age_108_male, count( nullif( age_108_male, 0 )) as non_zero_age_108_male,
        min( age_109_male ) as min_age_109_male, max( age_109_male ) as max_age_109_male, count( nullif( age_109_male, 0 )) as non_zero_age_109_male,
        min( age_110_male ) as min_age_110_male, max( age_110_male ) as max_age_110_male, count( nullif( age_110_male, 0 )) as non_zero_age_110_male,
        min( age_0_female ) as min_age_0_female, max( age_0_female ) as max_age_0_female, count( nullif( age_0_female, 0 )) as non_zero_age_0_female,
        min( age_1_female ) as min_age_1_female, max( age_1_female ) as max_age_1_female, count( nullif( age_1_female, 0 )) as non_zero_age_1_female,
        min( age_2_female ) as min_age_2_female, max( age_2_female ) as max_age_2_female, count( nullif( age_2_female, 0 )) as non_zero_age_2_female,
        min( age_3_female ) as min_age_3_female, max( age_3_female ) as max_age_3_female, count( nullif( age_3_female, 0 )) as non_zero_age_3_female,
        min( age_4_female ) as min_age_4_female, max( age_4_female ) as max_age_4_female, count( nullif( age_4_female, 0 )) as non_zero_age_4_female,
        min( age_5_female ) as min_age_5_female, max( age_5_female ) as max_age_5_female, count( nullif( age_5_female, 0 )) as non_zero_age_5_female,
        min( age_6_female ) as min_age_6_female, max( age_6_female ) as max_age_6_female, count( nullif( age_6_female, 0 )) as non_zero_age_6_female,
        min( age_7_female ) as min_age_7_female, max( age_7_female ) as max_age_7_female, count( nullif( age_7_female, 0 )) as non_zero_age_7_female,
        min( age_8_female ) as min_age_8_female, max( age_8_female ) as max_age_8_female, count( nullif( age_8_female, 0 )) as non_zero_age_8_female,
        min( age_9_female ) as min_age_9_female, max( age_9_female ) as max_age_9_female, count( nullif( age_9_female, 0 )) as non_zero_age_9_female,
        min( age_10_female ) as min_age_10_female, max( age_10_female ) as max_age_10_female, count( nullif( age_10_female, 0 )) as non_zero_age_10_female,
        min( age_11_female ) as min_age_11_female, max( age_11_female ) as max_age_11_female, count( nullif( age_11_female, 0 )) as non_zero_age_11_female,
        min( age_12_female ) as min_age_12_female, max( age_12_female ) as max_age_12_female, count( nullif( age_12_female, 0 )) as non_zero_age_12_female,
        min( age_13_female ) as min_age_13_female, max( age_13_female ) as max_age_13_female, count( nullif( age_13_female, 0 )) as non_zero_age_13_female,
        min( age_14_female ) as min_age_14_female, max( age_14_female ) as max_age_14_female, count( nullif( age_14_female, 0 )) as non_zero_age_14_female,
        min( age_15_female ) as min_age_15_female, max( age_15_female ) as max_age_15_female, count( nullif( age_15_female, 0 )) as non_zero_age_15_female,
        min( age_16_female ) as min_age_16_female, max( age_16_female ) as max_age_16_female, count( nullif( age_16_female, 0 )) as non_zero_age_16_female,
        min( age_17_female ) as min_age_17_female, max( age_17_female ) as max_age_17_female, count( nullif( age_17_female, 0 )) as non_zero_age_17_female,
        min( age_18_female ) as min_age_18_female, max( age_18_female ) as max_age_18_female, count( nullif( age_18_female, 0 )) as non_zero_age_18_female,
        min( age_19_female ) as min_age_19_female, max( age_19_female ) as max_age_19_female, count( nullif( age_19_female, 0 )) as non_zero_age_19_female,
        min( age_20_female ) as min_age_20_female, max( age_20_female ) as max_age_20_female, count( nullif( age_20_female, 0 )) as non_zero_age_20_female,
        min( age_21_female ) as min_age_21_female, max( age_21_female ) as max_age_21_female, count( nullif( age_21_female, 0 )) as non_zero_age_21_female,
        min( age_22_female ) as min_age_22_female, max( age_22_female ) as max_age_22_female, count( nullif( age_22_female, 0 )) as non_zero_age_22_female,
        min( age_23_female ) as min_age_23_female, max( age_23_female ) as max_age_23_female, count( nullif( age_23_female, 0 )) as non_zero_age_23_female,
        min( age_24_female ) as min_age_24_female, max( age_24_female ) as max_age_24_female, count( nullif( age_24_female, 0 )) as non_zero_age_24_female,
        min( age_25_female ) as min_age_25_female, max( age_25_female ) as max_age_25_female, count( nullif( age_25_female, 0 )) as non_zero_age_25_female,
        min( age_26_female ) as min_age_26_female, max( age_26_female ) as max_age_26_female, count( nullif( age_26_female, 0 )) as non_zero_age_26_female,
        min( age_27_female ) as min_age_27_female, max( age_27_female ) as max_age_27_female, count( nullif( age_27_female, 0 )) as non_zero_age_27_female,
        min( age_28_female ) as min_age_28_female, max( age_28_female ) as max_age_28_female, count( nullif( age_28_female, 0 )) as non_zero_age_28_female,
        min( age_29_female ) as min_age_29_female, max( age_29_female ) as max_age_29_female, count( nullif( age_29_female, 0 )) as non_zero_age_29_female,
        min( age_30_female ) as min_age_30_female, max( age_30_female ) as max_age_30_female, count( nullif( age_30_female, 0 )) as non_zero_age_30_female,
        min( age_31_female ) as min_age_31_female, max( age_31_female ) as max_age_31_female, count( nullif( age_31_female, 0 )) as non_zero_age_31_female,
        min( age_32_female ) as min_age_32_female, max( age_32_female ) as max_age_32_female, count( nullif( age_32_female, 0 )) as non_zero_age_32_female,
        min( age_33_female ) as min_age_33_female, max( age_33_female ) as max_age_33_female, count( nullif( age_33_female, 0 )) as non_zero_age_33_female,
        min( age_34_female ) as min_age_34_female, max( age_34_female ) as max_age_34_female, count( nullif( age_34_female, 0 )) as non_zero_age_34_female,
        min( age_35_female ) as min_age_35_female, max( age_35_female ) as max_age_35_female, count( nullif( age_35_female, 0 )) as non_zero_age_35_female,
        min( age_36_female ) as min_age_36_female, max( age_36_female ) as max_age_36_female, count( nullif( age_36_female, 0 )) as non_zero_age_36_female,
        min( age_37_female ) as min_age_37_female, max( age_37_female ) as max_age_37_female, count( nullif( age_37_female, 0 )) as non_zero_age_37_female,
        min( age_38_female ) as min_age_38_female, max( age_38_female ) as max_age_38_female, count( nullif( age_38_female, 0 )) as non_zero_age_38_female,
        min( age_39_female ) as min_age_39_female, max( age_39_female ) as max_age_39_female, count( nullif( age_39_female, 0 )) as non_zero_age_39_female,
        min( age_40_female ) as min_age_40_female, max( age_40_female ) as max_age_40_female, count( nullif( age_40_female, 0 )) as non_zero_age_40_female,
        min( age_41_female ) as min_age_41_female, max( age_41_female ) as max_age_41_female, count( nullif( age_41_female, 0 )) as non_zero_age_41_female,
        min( age_42_female ) as min_age_42_female, max( age_42_female ) as max_age_42_female, count( nullif( age_42_female, 0 )) as non_zero_age_42_female,
        min( age_43_female ) as min_age_43_female, max( age_43_female ) as max_age_43_female, count( nullif( age_43_female, 0 )) as non_zero_age_43_female,
        min( age_44_female ) as min_age_44_female, max( age_44_female ) as max_age_44_female, count( nullif( age_44_female, 0 )) as non_zero_age_44_female,
        min( age_45_female ) as min_age_45_female, max( age_45_female ) as max_age_45_female, count( nullif( age_45_female, 0 )) as non_zero_age_45_female,
        min( age_46_female ) as min_age_46_female, max( age_46_female ) as max_age_46_female, count( nullif( age_46_female, 0 )) as non_zero_age_46_female,
        min( age_47_female ) as min_age_47_female, max( age_47_female ) as max_age_47_female, count( nullif( age_47_female, 0 )) as non_zero_age_47_female,
        min( age_48_female ) as min_age_48_female, max( age_48_female ) as max_age_48_female, count( nullif( age_48_female, 0 )) as non_zero_age_48_female,
        min( age_49_female ) as min_age_49_female, max( age_49_female ) as max_age_49_female, count( nullif( age_49_female, 0 )) as non_zero_age_49_female,
        min( age_50_female ) as min_age_50_female, max( age_50_female ) as max_age_50_female, count( nullif( age_50_female, 0 )) as non_zero_age_50_female,
        min( age_51_female ) as min_age_51_female, max( age_51_female ) as max_age_51_female, count( nullif( age_51_female, 0 )) as non_zero_age_51_female,
        min( age_52_female ) as min_age_52_female, max( age_52_female ) as max_age_52_female, count( nullif( age_52_female, 0 )) as non_zero_age_52_female,
        min( age_53_female ) as min_age_53_female, max( age_53_female ) as max_age_53_female, count( nullif( age_53_female, 0 )) as non_zero_age_53_female,
        min( age_54_female ) as min_age_54_female, max( age_54_female ) as max_age_54_female, count( nullif( age_54_female, 0 )) as non_zero_age_54_female,
        min( age_55_female ) as min_age_55_female, max( age_55_female ) as max_age_55_female, count( nullif( age_55_female, 0 )) as non_zero_age_55_female,
        min( age_56_female ) as min_age_56_female, max( age_56_female ) as max_age_56_female, count( nullif( age_56_female, 0 )) as non_zero_age_56_female,
        min( age_57_female ) as min_age_57_female, max( age_57_female ) as max_age_57_female, count( nullif( age_57_female, 0 )) as non_zero_age_57_female,
        min( age_58_female ) as min_age_58_female, max( age_58_female ) as max_age_58_female, count( nullif( age_58_female, 0 )) as non_zero_age_58_female,
        min( age_59_female ) as min_age_59_female, max( age_59_female ) as max_age_59_female, count( nullif( age_59_female, 0 )) as non_zero_age_59_female,
        min( age_60_female ) as min_age_60_female, max( age_60_female ) as max_age_60_female, count( nullif( age_60_female, 0 )) as non_zero_age_60_female,
        min( age_61_female ) as min_age_61_female, max( age_61_female ) as max_age_61_female, count( nullif( age_61_female, 0 )) as non_zero_age_61_female,
        min( age_62_female ) as min_age_62_female, max( age_62_female ) as max_age_62_female, count( nullif( age_62_female, 0 )) as non_zero_age_62_female,
        min( age_63_female ) as min_age_63_female, max( age_63_female ) as max_age_63_female, count( nullif( age_63_female, 0 )) as non_zero_age_63_female,
        min( age_64_female ) as min_age_64_female, max( age_64_female ) as max_age_64_female, count( nullif( age_64_female, 0 )) as non_zero_age_64_female,
        min( age_65_female ) as min_age_65_female, max( age_65_female ) as max_age_65_female, count( nullif( age_65_female, 0 )) as non_zero_age_65_female,
        min( age_66_female ) as min_age_66_female, max( age_66_female ) as max_age_66_female, count( nullif( age_66_female, 0 )) as non_zero_age_66_female,
        min( age_67_female ) as min_age_67_female, max( age_67_female ) as max_age_67_female, count( nullif( age_67_female, 0 )) as non_zero_age_67_female,
        min( age_68_female ) as min_age_68_female, max( age_68_female ) as max_age_68_female, count( nullif( age_68_female, 0 )) as non_zero_age_68_female,
        min( age_69_female ) as min_age_69_female, max( age_69_female ) as max_age_69_female, count( nullif( age_69_female, 0 )) as non_zero_age_69_female,
        min( age_70_female ) as min_age_70_female, max( age_70_female ) as max_age_70_female, count( nullif( age_70_female, 0 )) as non_zero_age_70_female,
        min( age_71_female ) as min_age_71_female, max( age_71_female ) as max_age_71_female, count( nullif( age_71_female, 0 )) as non_zero_age_71_female,
        min( age_72_female ) as min_age_72_female, max( age_72_female ) as max_age_72_female, count( nullif( age_72_female, 0 )) as non_zero_age_72_female,
        min( age_73_female ) as min_age_73_female, max( age_73_female ) as max_age_73_female, count( nullif( age_73_female, 0 )) as non_zero_age_73_female,
        min( age_74_female ) as min_age_74_female, max( age_74_female ) as max_age_74_female, count( nullif( age_74_female, 0 )) as non_zero_age_74_female,
        min( age_75_female ) as min_age_75_female, max( age_75_female ) as max_age_75_female, count( nullif( age_75_female, 0 )) as non_zero_age_75_female,
        min( age_76_female ) as min_age_76_female, max( age_76_female ) as max_age_76_female, count( nullif( age_76_female, 0 )) as non_zero_age_76_female,
        min( age_77_female ) as min_age_77_female, max( age_77_female ) as max_age_77_female, count( nullif( age_77_female, 0 )) as non_zero_age_77_female,
        min( age_78_female ) as min_age_78_female, max( age_78_female ) as max_age_78_female, count( nullif( age_78_female, 0 )) as non_zero_age_78_female,
        min( age_79_female ) as min_age_79_female, max( age_79_female ) as max_age_79_female, count( nullif( age_79_female, 0 )) as non_zero_age_79_female,
        min( age_80_female ) as min_age_80_female, max( age_80_female ) as max_age_80_female, count( nullif( age_80_female, 0 )) as non_zero_age_80_female,
        min( age_81_female ) as min_age_81_female, max( age_81_female ) as max_age_81_female, count( nullif( age_81_female, 0 )) as non_zero_age_81_female,
        min( age_82_female ) as min_age_82_female, max( age_82_female ) as max_age_82_female, count( nullif( age_82_female, 0 )) as non_zero_age_82_female,
        min( age_83_female ) as min_age_83_female, max( age_83_female ) as max_age_83_female, count( nullif( age_83_female, 0 )) as non_zero_age_83_female,
        min( age_84_female ) as min_age_84_female, max( age_84_female ) as max_age_84_female, count( nullif( age_84_female, 0 )) as non_zero_age_84_female,
        min( age_85_female ) as min_age_85_female, max( age_85_female ) as max_age_85_female, count( nullif( age_85_female, 0 )) as non_zero_age_85_female,
        min( age_86_female ) as min_age_86_female, max( age_86_female ) as max_age_86_female, count( nullif( age_86_female, 0 )) as non_zero_age_86_female,
        min( age_87_female ) as min_age_87_female, max( age_87_female ) as max_age_87_female, count( nullif( age_87_female, 0 )) as non_zero_age_87_female,
        min( age_88_female ) as min_age_88_female, max( age_88_female ) as max_age_88_female, count( nullif( age_88_female, 0 )) as non_zero_age_88_female,
        min( age_89_female ) as min_age_89_female, max( age_89_female ) as max_age_89_female, count( nullif( age_89_female, 0 )) as non_zero_age_89_female,
        min( age_90_female ) as min_age_90_female, max( age_90_female ) as max_age_90_female, count( nullif( age_90_female, 0 )) as non_zero_age_90_female,
        min( age_91_female ) as min_age_91_female, max( age_91_female ) as max_age_91_female, count( nullif( age_91_female, 0 )) as non_zero_age_91_female,
        min( age_92_female ) as min_age_92_female, max( age_92_female ) as max_age_92_female, count( nullif( age_92_female, 0 )) as non_zero_age_92_female,
        min( age_93_female ) as min_age_93_female, max( age_93_female ) as max_age_93_female, count( nullif( age_93_female, 0 )) as non_zero_age_93_female,
        min( age_94_female ) as min_age_94_female, max( age_94_female ) as max_age_94_female, count( nullif( age_94_female, 0 )) as non_zero_age_94_female,
        min( age_95_female ) as min_age_95_female, max( age_95_female ) as max_age_95_female, count( nullif( age_95_female, 0 )) as non_zero_age_95_female,
        min( age_96_female ) as min_age_96_female, max( age_96_female ) as max_age_96_female, count( nullif( age_96_female, 0 )) as non_zero_age_96_female,
        min( age_97_female ) as min_age_97_female, max( age_97_female ) as max_age_97_female, count( nullif( age_97_female, 0 )) as non_zero_age_97_female,
        min( age_98_female ) as min_age_98_female, max( age_98_female ) as max_age_98_female, count( nullif( age_98_female, 0 )) as non_zero_age_98_female,
        min( age_99_female ) as min_age_99_female, max( age_99_female ) as max_age_99_female, count( nullif( age_99_female, 0 )) as non_zero_age_99_female,
        min( age_100_female ) as min_age_100_female, max( age_100_female ) as max_age_100_female, count( nullif( age_100_female, 0 )) as non_zero_age_100_female,
        min( age_101_female ) as min_age_101_female, max( age_101_female ) as max_age_101_female, count( nullif( age_101_female, 0 )) as non_zero_age_101_female,
        min( age_102_female ) as min_age_102_female, max( age_102_female ) as max_age_102_female, count( nullif( age_102_female, 0 )) as non_zero_age_102_female,
        min( age_103_female ) as min_age_103_female, max( age_103_female ) as max_age_103_female, count( nullif( age_103_female, 0 )) as non_zero_age_103_female,
        min( age_104_female ) as min_age_104_female, max( age_104_female ) as max_age_104_female, count( nullif( age_104_female, 0 )) as non_zero_age_104_female,
        min( age_105_female ) as min_age_105_female, max( age_105_female ) as max_age_105_female, count( nullif( age_105_female, 0 )) as non_zero_age_105_female,
        min( age_106_female ) as min_age_106_female, max( age_106_female ) as max_age_106_female, count( nullif( age_106_female, 0 )) as non_zero_age_106_female,
        min( age_107_female ) as min_age_107_female, max( age_107_female ) as max_age_107_female, count( nullif( age_107_female, 0 )) as non_zero_age_107_female,
        min( age_108_female ) as min_age_108_female, max( age_108_female ) as max_age_108_female, count( nullif( age_108_female, 0 )) as non_zero_age_108_female,
        min( age_109_female ) as min_age_109_female, max( age_109_female ) as max_age_109_female, count( nullif( age_109_female, 0 )) as non_zero_age_109_female,
        min( age_110_female ) as min_age_110_female, max( age_110_female ) as max_age_110_female, count( nullif( age_110_female, 0 )) as non_zero_age_110_female,
        min( participation_16_19_male ) as min_participation_16_19_male, max( participation_16_19_male ) as max_participation_16_19_male, count( nullif( participation_16_19_male, 0 )) as non_zero_participation_16_19_male,
        min( participation_20_24_male ) as min_participation_20_24_male, max( participation_20_24_male ) as max_participation_20_24_male, count( nullif( participation_20_24_male, 0 )) as non_zero_participation_20_24_male,
        min( participation_25_29_male ) as min_participation_25_29_male, max( participation_25_29_male ) as max_participation_25_29_male, count( nullif( participation_25_29_male, 0 )) as non_zero_participation_25_29_male,
        min( participation_30_34_male ) as min_participation_30_34_male, max( participation_30_34_male ) as max_participation_30_34_male, count( nullif( participation_30_34_male, 0 )) as non_zero_participation_30_34_male,
        min( participation_35_39_male ) as min_participation_35_39_male, max( participation_35_39_male ) as max_participation_35_39_male, count( nullif( participation_35_39_male, 0 )) as non_zero_participation_35_39_male,
        min( participation_40_44_male ) as min_participation_40_44_male, max( participation_40_44_male ) as max_participation_40_44_male, count( nullif( participation_40_44_male, 0 )) as non_zero_participation_40_44_male,
        min( participation_45_49_male ) as min_participation_45_49_male, max( participation_45_49_male ) as max_participation_45_49_male, count( nullif( participation_45_49_male, 0 )) as non_zero_participation_45_49_male,
        min( participation_50_54_male ) as min_participation_50_54_male, max( participation_50_54_male ) as max_participation_50_54_male, count( nullif( participation_50_54_male, 0 )) as non_zero_participation_50_54_male,
        min( participation_55_59_male ) as min_participation_55_59_male, max( participation_55_59_male ) as max_participation_55_59_male, count( nullif( participation_55_59_male, 0 )) as non_zero_participation_55_59_male,
        min( participation_60_64_male ) as min_participation_60_64_male, max( participation_60_64_male ) as max_participation_60_64_male, count( nullif( participation_60_64_male, 0 )) as non_zero_participation_60_64_male,
        min( participation_65_69_male ) as min_participation_65_69_male, max( participation_65_69_male ) as max_participation_65_69_male, count( nullif( participation_65_69_male, 0 )) as non_zero_participation_65_69_male,
        min( participation_70_74_male ) as min_participation_70_74_male, max( participation_70_74_male ) as max_participation_70_74_male, count( nullif( participation_70_74_male, 0 )) as non_zero_participation_70_74_male,
        min( participation_75_plus_male ) as min_participation_75_plus_male, max( participation_75_plus_male ) as max_participation_75_plus_male, count( nullif( participation_75_plus_male, 0 )) as non_zero_participation_75_plus_male,
        min( participation_16_19_female ) as min_participation_16_19_female, max( participation_16_19_female ) as max_participation_16_19_female, count( nullif( participation_16_19_female, 0 )) as non_zero_participation_16_19_female,
        min( participation_20_24_female ) as min_participation_20_24_female, max( participation_20_24_female ) as max_participation_20_24_female, count( nullif( participation_20_24_female, 0 )) as non_zero_participation_20_24_female,
        min( participation_25_29_female ) as min_participation_25_29_female, max( participation_25_29_female ) as max_participation_25_29_female, count( nullif( participation_25_29_female, 0 )) as non_zero_participation_25_29_female,
        min( participation_30_34_female ) as min_participation_30_34_female, max( participation_30_34_female ) as max_participation_30_34_female, count( nullif( participation_30_34_female, 0 )) as non_zero_participation_30_34_female,
        min( participation_35_39_female ) as min_participation_35_39_female, max( participation_35_39_female ) as max_participation_35_39_female, count( nullif( participation_35_39_female, 0 )) as non_zero_participation_35_39_female,
        min( participation_40_44_female ) as min_participation_40_44_female, max( participation_40_44_female ) as max_participation_40_44_female, count( nullif( participation_40_44_female, 0 )) as non_zero_participation_40_44_female,
        min( participation_45_49_female ) as min_participation_45_49_female, max( participation_45_49_female ) as max_participation_45_49_female, count( nullif( participation_45_49_female, 0 )) as non_zero_participation_45_49_female,
        min( participation_50_54_female ) as min_participation_50_54_female, max( participation_50_54_female ) as max_participation_50_54_female, count( nullif( participation_50_54_female, 0 )) as non_zero_participation_50_54_female,
        min( participation_55_59_female ) as min_participation_55_59_female, max( participation_55_59_female ) as max_participation_55_59_female, count( nullif( participation_55_59_female, 0 )) as non_zero_participation_55_59_female,
        min( participation_60_64_female ) as min_participation_60_64_female, max( participation_60_64_female ) as max_participation_60_64_female, count( nullif( participation_60_64_female, 0 )) as non_zero_participation_60_64_female,
        min( participation_65_69_female ) as min_participation_65_69_female, max( participation_65_69_female ) as max_participation_65_69_female, count( nullif( participation_65_69_female, 0 )) as non_zero_participation_65_69_female,
        min( participation_70_74_female ) as min_participation_70_74_female, max( participation_70_74_female ) as max_participation_70_74_female, count( nullif( participation_70_74_female, 0 )) as non_zero_participation_70_74_female,
        min( participation_75_plus_female ) as min_participation_75_plus_female, max( participation_75_plus_female ) as max_participation_75_plus_female, count( nullif( participation_75_plus_female, 0 )) as non_zero_participation_75_plus_female,
        min( one_adult_hh_wales ) as min_one_adult_hh_wales, max( one_adult_hh_wales ) as max_one_adult_hh_wales, count( nullif( one_adult_hh_wales, 0 )) as non_zero_one_adult_hh_wales,
        min( two_adult_hhs_wales ) as min_two_adult_hhs_wales, max( two_adult_hhs_wales ) as max_two_adult_hhs_wales, count( nullif( two_adult_hhs_wales, 0 )) as non_zero_two_adult_hhs_wales,
        min( other_hh_wales ) as min_other_hh_wales, max( other_hh_wales ) as max_other_hh_wales, count( nullif( other_hh_wales, 0 )) as non_zero_other_hh_wales,
        min( one_adult_hh_nireland ) as min_one_adult_hh_nireland, max( one_adult_hh_nireland ) as max_one_adult_hh_nireland, count( nullif( one_adult_hh_nireland, 0 )) as non_zero_one_adult_hh_nireland,
        min( two_adult_hhs_nireland ) as min_two_adult_hhs_nireland, max( two_adult_hhs_nireland ) as max_two_adult_hhs_nireland, count( nullif( two_adult_hhs_nireland, 0 )) as non_zero_two_adult_hhs_nireland,
        min( other_hh_nireland ) as min_other_hh_nireland, max( other_hh_nireland ) as max_other_hh_nireland, count( nullif( other_hh_nireland, 0 )) as non_zero_other_hh_nireland,
        min( one_adult_hh_england ) as min_one_adult_hh_england, max( one_adult_hh_england ) as max_one_adult_hh_england, count( nullif( one_adult_hh_england, 0 )) as non_zero_one_adult_hh_england,
        min( two_adult_hhs_england ) as min_two_adult_hhs_england, max( two_adult_hhs_england ) as max_two_adult_hhs_england, count( nullif( two_adult_hhs_england, 0 )) as non_zero_two_adult_hhs_england,
        min( other_hh_england ) as min_other_hh_england, max( other_hh_england ) as max_other_hh_england, count( nullif( other_hh_england, 0 )) as non_zero_other_hh_england,
        min( one_adult_hh_scotland ) as min_one_adult_hh_scotland, max( one_adult_hh_scotland ) as max_one_adult_hh_scotland, count( nullif( one_adult_hh_scotland, 0 )) as non_zero_one_adult_hh_scotland,
        min( two_adult_hhs_scotland ) as min_two_adult_hhs_scotland, max( two_adult_hhs_scotland ) as max_two_adult_hhs_scotland, count( nullif( two_adult_hhs_scotland, 0 )) as non_zero_two_adult_hhs_scotland,
        min( other_hh_scotland ) as min_other_hh_scotland, max( other_hh_scotland ) as max_other_hh_scotland, count( nullif( other_hh_scotland, 0 )) as non_zero_other_hh_scotland,
        min( sco_hhld_one_adult_male ) as min_sco_hhld_one_adult_male, max( sco_hhld_one_adult_male ) as max_sco_hhld_one_adult_male, count( nullif( sco_hhld_one_adult_male, 0 )) as non_zero_sco_hhld_one_adult_male,
        min( sco_hhld_one_adult_female ) as min_sco_hhld_one_adult_female, max( sco_hhld_one_adult_female ) as max_sco_hhld_one_adult_female, count( nullif( sco_hhld_one_adult_female, 0 )) as non_zero_sco_hhld_one_adult_female,
        min( sco_hhld_two_adults ) as min_sco_hhld_two_adults, max( sco_hhld_two_adults ) as max_sco_hhld_two_adults, count( nullif( sco_hhld_two_adults, 0 )) as non_zero_sco_hhld_two_adults,
        min( sco_hhld_one_adult_one_child ) as min_sco_hhld_one_adult_one_child, max( sco_hhld_one_adult_one_child ) as max_sco_hhld_one_adult_one_child, count( nullif( sco_hhld_one_adult_one_child, 0 )) as non_zero_sco_hhld_one_adult_one_child,
        min( sco_hhld_one_adult_two_plus_children ) as min_sco_hhld_one_adult_two_plus_children, max( sco_hhld_one_adult_two_plus_children ) as max_sco_hhld_one_adult_two_plus_children, count( nullif( sco_hhld_one_adult_two_plus_children, 0 )) as non_zero_sco_hhld_one_adult_two_plus_children,
        min( sco_hhld_two_plus_adult_one_plus_children ) as min_sco_hhld_two_plus_adult_one_plus_children, max( sco_hhld_two_plus_adult_one_plus_children ) as max_sco_hhld_two_plus_adult_one_plus_children, count( nullif( sco_hhld_two_plus_adult_one_plus_children, 0 )) as non_zero_sco_hhld_two_plus_adult_one_plus_children,
        min( sco_hhld_three_plus_person_all_adult ) as min_sco_hhld_three_plus_person_all_adult, max( sco_hhld_three_plus_person_all_adult ) as max_sco_hhld_three_plus_person_all_adult, count( nullif( sco_hhld_three_plus_person_all_adult, 0 )) as non_zero_sco_hhld_three_plus_person_all_adult,
        min( eng_hhld_one_person_households_male ) as min_eng_hhld_one_person_households_male, max( eng_hhld_one_person_households_male ) as max_eng_hhld_one_person_households_male, count( nullif( eng_hhld_one_person_households_male, 0 )) as non_zero_eng_hhld_one_person_households_male,
        min( eng_hhld_one_person_households_female ) as min_eng_hhld_one_person_households_female, max( eng_hhld_one_person_households_female ) as max_eng_hhld_one_person_households_female, count( nullif( eng_hhld_one_person_households_female, 0 )) as non_zero_eng_hhld_one_person_households_female,
        min( eng_hhld_households_with_one_dependent_child ) as min_eng_hhld_households_with_one_dependent_child, max( eng_hhld_households_with_one_dependent_child ) as max_eng_hhld_households_with_one_dependent_child, count( nullif( eng_hhld_households_with_one_dependent_child, 0 )) as non_zero_eng_hhld_households_with_one_dependent_child,
        min( eng_hhld_households_with_two_dependent_children ) as min_eng_hhld_households_with_two_dependent_children, max( eng_hhld_households_with_two_dependent_children ) as max_eng_hhld_households_with_two_dependent_children, count( nullif( eng_hhld_households_with_two_dependent_children, 0 )) as non_zero_eng_hhld_households_with_two_dependent_children,
        min( eng_hhld_households_with_three_dependent_children ) as min_eng_hhld_households_with_three_dependent_children, max( eng_hhld_households_with_three_dependent_children ) as max_eng_hhld_households_with_three_dependent_children, count( nullif( eng_hhld_households_with_three_dependent_children, 0 )) as non_zero_eng_hhld_households_with_three_dependent_children,
        min( eng_hhld_other_households ) as min_eng_hhld_other_households, max( eng_hhld_other_households ) as max_eng_hhld_other_households, count( nullif( eng_hhld_other_households, 0 )) as non_zero_eng_hhld_other_households,
        min( nir_hhld_one_adult_households ) as min_nir_hhld_one_adult_households, max( nir_hhld_one_adult_households ) as max_nir_hhld_one_adult_households, count( nullif( nir_hhld_one_adult_households, 0 )) as non_zero_nir_hhld_one_adult_households,
        min( nir_hhld_two_adults_without_children ) as min_nir_hhld_two_adults_without_children, max( nir_hhld_two_adults_without_children ) as max_nir_hhld_two_adults_without_children, count( nullif( nir_hhld_two_adults_without_children, 0 )) as non_zero_nir_hhld_two_adults_without_children,
        min( nir_hhld_other_households_without_children ) as min_nir_hhld_other_households_without_children, max( nir_hhld_other_households_without_children ) as max_nir_hhld_other_households_without_children, count( nullif( nir_hhld_other_households_without_children, 0 )) as non_zero_nir_hhld_other_households_without_children,
        min( nir_hhld_one_adult_households_with_children ) as min_nir_hhld_one_adult_households_with_children, max( nir_hhld_one_adult_households_with_children ) as max_nir_hhld_one_adult_households_with_children, count( nullif( nir_hhld_one_adult_households_with_children, 0 )) as non_zero_nir_hhld_one_adult_households_with_children,
        min( nir_hhld_other_households_with_children ) as min_nir_hhld_other_households_with_children, max( nir_hhld_other_households_with_children ) as max_nir_hhld_other_households_with_children, count( nullif( nir_hhld_other_households_with_children, 0 )) as non_zero_nir_hhld_other_households_with_children,
        min( wal_hhld_1_person ) as min_wal_hhld_1_person, max( wal_hhld_1_person ) as max_wal_hhld_1_person, count( nullif( wal_hhld_1_person, 0 )) as non_zero_wal_hhld_1_person,
        min( wal_hhld_2_person_no_children ) as min_wal_hhld_2_person_no_children, max( wal_hhld_2_person_no_children ) as max_wal_hhld_2_person_no_children, count( nullif( wal_hhld_2_person_no_children, 0 )) as non_zero_wal_hhld_2_person_no_children,
        min( wal_hhld_2_person_1_adult_1_child ) as min_wal_hhld_2_person_1_adult_1_child, max( wal_hhld_2_person_1_adult_1_child ) as max_wal_hhld_2_person_1_adult_1_child, count( nullif( wal_hhld_2_person_1_adult_1_child, 0 )) as non_zero_wal_hhld_2_person_1_adult_1_child,
        min( wal_hhld_3_person_no_children ) as min_wal_hhld_3_person_no_children, max( wal_hhld_3_person_no_children ) as max_wal_hhld_3_person_no_children, count( nullif( wal_hhld_3_person_no_children, 0 )) as non_zero_wal_hhld_3_person_no_children,
        min( wal_hhld_3_person_2_adults_1_child ) as min_wal_hhld_3_person_2_adults_1_child, max( wal_hhld_3_person_2_adults_1_child ) as max_wal_hhld_3_person_2_adults_1_child, count( nullif( wal_hhld_3_person_2_adults_1_child, 0 )) as non_zero_wal_hhld_3_person_2_adults_1_child,
        min( wal_hhld_3_person_1_adult_2_children ) as min_wal_hhld_3_person_1_adult_2_children, max( wal_hhld_3_person_1_adult_2_children ) as max_wal_hhld_3_person_1_adult_2_children, count( nullif( wal_hhld_3_person_1_adult_2_children, 0 )) as non_zero_wal_hhld_3_person_1_adult_2_children,
        min( wal_hhld_4_person_no_children ) as min_wal_hhld_4_person_no_children, max( wal_hhld_4_person_no_children ) as max_wal_hhld_4_person_no_children, count( nullif( wal_hhld_4_person_no_children, 0 )) as non_zero_wal_hhld_4_person_no_children,
        min( wal_hhld_4_person_2_plus_adults_1_plus_children ) as min_wal_hhld_4_person_2_plus_adults_1_plus_children, max( wal_hhld_4_person_2_plus_adults_1_plus_children ) as max_wal_hhld_4_person_2_plus_adults_1_plus_children, count( nullif( wal_hhld_4_person_2_plus_adults_1_plus_children, 0 )) as non_zero_wal_hhld_4_person_2_plus_adults_1_plus_children,
        min( wal_hhld_4_person_1_adult_3_children ) as min_wal_hhld_4_person_1_adult_3_children, max( wal_hhld_4_person_1_adult_3_children ) as max_wal_hhld_4_person_1_adult_3_children, count( nullif( wal_hhld_4_person_1_adult_3_children, 0 )) as non_zero_wal_hhld_4_person_1_adult_3_children,
        min( wal_hhld_5_plus_person_no_children ) as min_wal_hhld_5_plus_person_no_children, max( wal_hhld_5_plus_person_no_children ) as max_wal_hhld_5_plus_person_no_children, count( nullif( wal_hhld_5_plus_person_no_children, 0 )) as non_zero_wal_hhld_5_plus_person_no_children,
        min( wal_hhld_5_plus_person_2_plus_adults_1_plus_children ) as min_wal_hhld_5_plus_person_2_plus_adults_1_plus_children, max( wal_hhld_5_plus_person_2_plus_adults_1_plus_children ) as max_wal_hhld_5_plus_person_2_plus_adults_1_plus_children, count( nullif( wal_hhld_5_plus_person_2_plus_adults_1_plus_children, 0 )) as non_zero_wal_hhld_5_plus_person_2_plus_adults_1_plus_children,
        min( wal_hhld_5_plus_person_1_adult_4_plus_children ) as min_wal_hhld_5_plus_person_1_adult_4_plus_children, max( wal_hhld_5_plus_person_1_adult_4_plus_children ) as max_wal_hhld_5_plus_person_1_adult_4_plus_children, count( nullif( wal_hhld_5_plus_person_1_adult_4_plus_children, 0 )) as non_zero_wal_hhld_5_plus_person_1_adult_4_plus_children,
        min( eng_hhld_one_family_and_no_others_couple_no_dependent_chi ) as min_eng_hhld_one_family_and_no_others_couple_no_dependent_chi, max( eng_hhld_one_family_and_no_others_couple_no_dependent_chi ) as max_eng_hhld_one_family_and_no_others_couple_no_dependent_chi, count( nullif( eng_hhld_one_family_and_no_others_couple_no_dependent_chi, 0 )) as non_zero_eng_hhld_one_family_and_no_others_couple_no_dependent_chi,
        min( household_all_households ) as min_household_all_households, max( household_all_households ) as max_household_all_households, count( nullif( household_all_households, 0 )) as non_zero_household_all_households,
        min( eng_hhld_a_couple_and_other_adults_no_dependent_children ) as min_eng_hhld_a_couple_and_other_adults_no_dependent_children, max( eng_hhld_a_couple_and_other_adults_no_dependent_children ) as max_eng_hhld_a_couple_and_other_adults_no_dependent_children, count( nullif( eng_hhld_a_couple_and_other_adults_no_dependent_children, 0 )) as non_zero_eng_hhld_a_couple_and_other_adults_no_dependent_children
from target_data.target_dataset group by run_id,user_id,year order by run_id,user_id,year;

--
-- counts of 16-21 labour force from child and adult recs
--
select year,count(age), min(age), max(age) from frs.child where age >= 16 and trainee = 1 group by year;
select year,count(age80), min(age80), max(age80) from frs.adult where age80 <= 21 group by year order by year;

select
        run_id,
        user_id,
        year,
        min( nir_hhld_one_adult_households ) as min_nir_hhld_one_adult_households, max( nir_hhld_one_adult_households ) as max_nir_hhld_one_adult_households, count( nullif( nir_hhld_one_adult_households, 0 )) as non_zero_nir_hhld_one_adult_households,
        min( nir_hhld_two_adults_without_children ) as min_nir_hhld_two_adults_without_children, max( nir_hhld_two_adults_without_children ) as max_nir_hhld_two_adults_without_children, count( nullif( nir_hhld_two_adults_without_children, 0 )) as non_zero_nir_hhld_two_adults_without_children,
        min( nir_hhld_other_households_without_children ) as min_nir_hhld_other_households_without_children, max( nir_hhld_other_households_without_children ) as max_nir_hhld_other_households_without_children, count( nullif( nir_hhld_other_households_without_children, 0 )) as non_zero_nir_hhld_other_households_without_children,
        min( nir_hhld_one_adult_households_with_children ) as min_nir_hhld_one_adult_households_with_children, max( nir_hhld_one_adult_households_with_children ) as max_nir_hhld_one_adult_households_with_children, count( nullif( nir_hhld_one_adult_households_with_children, 0 )) as non_zero_nir_hhld_one_adult_households_with_children,
        min( nir_hhld_other_households_with_children ) as min_nir_hhld_other_households_with_children, max( nir_hhld_other_households_with_children ) as max_nir_hhld_other_households_with_children, count( nullif( nir_hhld_other_households_with_children, 0 )) as non_zero_nir_hhld_other_households_with_children
from target_data.target_dataset 
where run_id = 100004 
group by run_id,user_id,year 
order by run_id,user_id,year;

--
-- people with public sector jobs as 2nd jobs
--
select 
        year,counter,jobsect,count(counter) 
from 
        frs.job where year>=2010 and jobsect=2 and counter > 1 
group by 
        year,jobsect,counter 
order by 
        year,jobsect,counter;
        
select 
        year,private_sector_employment,public_sector_employment 
from 
        target_data.macro_forecasts;        
        
-- insert public/private employment.        
-- FROM OBR SupplementaryEconomytablesMarch2017-2.xlsx table 1.12
-- 1.12 Market Sector and general government employment (millions, final quarter of the financial year)
-- March 2017 forecast

update target_data.macro_forecasts set private_sector_employment = 23.8, public_sector_employment=5.47 where year=2011;
update target_data.macro_forecasts set private_sector_employment = 24.4, public_sector_employment=5.19 where year=2012;
update target_data.macro_forecasts set private_sector_employment = 25.1, public_sector_employment=5.20 where year=2013;
update target_data.macro_forecasts set private_sector_employment = 25.8, public_sector_employment=5.16 where year=2014;
update target_data.macro_forecasts set private_sector_employment = 26.3, public_sector_employment=5.13 where year=2015;
update target_data.macro_forecasts set private_sector_employment = 26.5, public_sector_employment=5.14 where year=2016;
update target_data.macro_forecasts set private_sector_employment = 26.6, public_sector_employment=5.18 where year=2017;
update target_data.macro_forecasts set private_sector_employment = 26.8, public_sector_employment=5.16 where year=2018;
update target_data.macro_forecasts set private_sector_employment = 27.0, public_sector_employment=5.12 where year=2019;
update target_data.macro_forecasts set private_sector_employment = 27.1, public_sector_employment=5.09 where year=2020;
update target_data.macro_forecasts set private_sector_employment = 27.3, public_sector_employment=5.01 where year=2021;

update target_data.macro_forecasts set private_sector_employment = private_sector_employment * 1000000;
update target_data.macro_forecasts set public_sector_employment = public_sector_employment * 1000000;

--
-- add compressed household element to clauses (only works at end; see: https://www.postgresql.org/docs/9.1/static/functions-array.html
--
update target_data.run set selected_clauses = array_append( selected_clauses, 'f' );

select 
        run_id,
        year,
        other_hh,
        one_adult_hh,
        two_adult_hh,
        other_hh +
        one_adult_hh +
        two_adult_hh as all_hhlds
        
from 
        target_data.target_dataset
where 
        run_id in ( select run_id from target_data.run where run_type = 1 and country='UK');

--
-- I forgot to add this to the FRS parts of the targets
--
update target_data.target_dataset set 
        other_hh = 
                eng_hhld_a_couple_and_other_adults_no_dependent_children +
                eng_hhld_households_with_one_dependent_child +
                eng_hhld_households_with_two_dependent_children +
                eng_hhld_households_with_three_dependent_children +
                eng_hhld_other_households + 
                sco_hhld_one_adult_one_child +
                sco_hhld_one_adult_two_plus_children +
                sco_hhld_two_plus_adult_one_plus_children +
                sco_hhld_three_plus_person_all_adult +
                wal_hhld_2_person_1_adult_1_child +
                wal_hhld_3_person_no_children +
                wal_hhld_3_person_2_adults_1_child +
                wal_hhld_3_person_1_adult_2_children +
                wal_hhld_4_person_no_children +
                wal_hhld_4_person_2_plus_adults_1_plus_children +
                wal_hhld_4_person_1_adult_3_children +
                wal_hhld_5_plus_person_no_children +
                wal_hhld_5_plus_person_2_plus_adults_1_plus_children +
                wal_hhld_5_plus_person_1_adult_4_plus_children +
                nir_hhld_other_households_without_children +
                nir_hhld_one_adult_households_with_children +
                nir_hhld_other_households_with_children,
          
        one_adult_hh = 
                wal_hhld_1_person+
                nir_hhld_one_adult_households +
                eng_hhld_one_person_households_male +
                eng_hhld_one_person_households_female +
                sco_hhld_one_adult_male +
                sco_hhld_one_adult_female,
               
        two_adult_hh =
                sco_hhld_two_adults +
                eng_hhld_one_family_and_no_others_couple_no_dependent_chi +
                wal_hhld_2_person_no_children +      
                nir_hhld_two_adults_without_children  
where 
        run_id in (
                select run_id from target_data.run where run_type=0 and country='UK' );
          
        