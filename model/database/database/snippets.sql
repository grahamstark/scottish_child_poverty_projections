
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

select year,target_group,age_105 from target_data.population_forecasts order by year,target_group;

select distinct year  from frs.adult where age80 is null or age80 < 16;
