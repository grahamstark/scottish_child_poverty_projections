# set terminal svg size 800,600 enhanced butt solid
# set terminal svg size 800,600 fixed enhanced butt solid
          
set terminal svg size 800,600 enhanced butt solid
# set terminal png size 800,600
         

set style line 1 lt rgb "#ba5050" dt 1
set style line 2 lt rgb "#8250ba" dt 2
set style line 3 lt rgb "#5062ba" dt 3
set style line 4 lt rgb "#50ba98" dt 4
set style line 5 lt rgb "#3f8039" dt 1
set style line 6 lt rgb "#7f8039" dt 2
set style line 7 lt rgb "#ba5050" dt 3
set style line 8 lt rgb "#828850" dt 4
set style line 9 lt rgb "#bf9347" dt 1
set style line 10 lt rgb "#50ba50" dt 2
set style line 11 lt rgb "#82ba50" dt 3
set style line 12 lt rgb "#bf4793" dt 4
set style line 13 lt rgb "#5050ba" dt 1
set style line 14 lt rgb "#82ba50" dt 2
set style line 15 lt rgb "#47bf93" dt 3

set datafile separator "\t"
set timefmt "%Y"
set format y "%1.0f"

set xlabel "Year"
set xrange [2017:2034]
# set xdata time
set key left top
# set grid rgb "#dddddd" 
set key autotitle columnhead

list=system('ls output/hr/*-targets.tab')
set key left top
        
do for [filename in list ]{                  
        basename = system( 'basename '.filename )
        print filename
        # set yrange restore
        set autoscale
        set xrange [2017:2034]
        
        # set output sprintf('../docs/report/images/%s-hhlds.svg', basename )
        set table sprintf('../docs/report/images/%s-hhlds.tab', basename )
        # set yrange [0:900000]
        set title "Projected Households"
        set ylabel "Households"
        plot     filename using 1:2 with lines ls 1, \
                 filename using 1:3 with lines  ls 2, \
                 filename using 1:4 with lines  ls 3, \
                 filename using 1:5 with lines  ls 4, \
                 filename using 1:6 with lines  ls 5, \
                 filename using 1:7 with lines  ls 6, \
                 filename using 1:8 with lines  ls 7
        # unset output
        unset table

        # set output sprintf('../docs/report/images/%s-employment.svg', basename )
        set table sprintf('../docs/report/images/%s-employment.tab', basename )
        # set yrange [0:2800000]
        set title "Employment, Unemployment and Employees"
        set ylabel "Population"
        # set key right bottom
        plot    filename using 1:9 with lines ls 1, \
                filename using 1:10 with lines ls 2, \
                filename using 1:11 with lines ls 3
        # unset output
        unset table

        # set output sprintf('../docs/report/images/%s-children.svg', basename )
        set table sprintf('../docs/report/images/%s-children.tab', basename )

        # set yrange [0:200000]
        set title "Children"
        set ylabel "Population"
        # set key right bottom
        plot    filename using 1:12 with lines ls 1, \
                filename using 1:13 with lines ls 2, \
                filename using 1:14 with lines ls 3, \
                filename using 1:15 with lines ls 4, \
                filename using 1:29 with lines ls 5, \
                filename using 1:30 with lines ls 6, \
                filename using 1:31 with lines ls 7, \
                filename using 1:32 with lines ls 8
        # unset output
        unset table
        
        # set output sprintf('../docs/report/images/%s-age-groups-and-employment.svg', basename )
        set table sprintf('../docs/report/images/%s-age-groups-and-employment.tab', basename )
        set yrange [0:4000000]
        set title "Children, Adults, Employment"
        set ylabel "Population"
        set key left top
        plot    filename using 1:($12+$13+$14+$29+$30+$31) title "Population 0-15" with lines ls 1, \
                filename using 1:($15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41) title "Population 16-64" with lines ls 2, \
                filename using 1:($25+$26+$27+$28+$41+$42+$43+$44+$45)  title "Population Age 65+" with lines ls 3, \
                filename using 1:9 with lines ls 4, \
                filename using 1:11 with lines ls 5 
        # unset output
        unset table
        
}

set autoscale
# set output '../docs/report/images/all-households-variants.svg'
set table '../docs/report/images/all-households-variants.tab'
# set yrange [2000000:3000000]
set title "Households"
set ylabel "Total Households, Forecast Variants"
# set key right bottom
plot \
        'output/hr/200120_sco_2016_2038_ppp_ppp_baseline_2012_2015-targets.tab' using 1:(($2+$3+$4+$5+$6+$7)) title "Principal" with lines ls 1, \
        'output/hr/200121_sco_2016_2038_ppp_hhh_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "High Population" with lines ls 2, \
        'output/hr/200122_sco_2016_2038_ppp_hpp_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "High Fertility" with lines ls 3, \
        'output/hr/200123_sco_2016_2038_ppp_lll_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "Low Population" with lines ls 4, \
        'output/hr/200124_sco_2016_2038_ppp_lpp_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "Low Fertility" with lines ls 5, \
        'output/hr/200125_sco_2016_2038_ppp_php_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "High Life Expectancy" with lines ls 6, \
        'output/hr/200126_sco_2016_2038_ppp_plp_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "Low Life Expectancy" with lines ls 7, \
        'output/hr/200127_sco_2016_2038_ppp_pph_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "High Migration" with lines ls 8, \
        'output/hr/200128_sco_2016_2038_ppp_ppl_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "Low Migration" with lines ls 9, \
        'output/hr/200129_sco_2016_2038_ppp_ppq_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "0% Future EU Migration" with lines ls 10, \
        'output/hr/200130_sco_2016_2038_ppp_ppr_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "50% Future EU Migration" with lines ls 11, \
        'output/hr/200131_sco_2016_2038_ppp_pps_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "150% Future EU Migration" with lines ls 12, \
        'output/hr/200132_sco_2016_2038_ppp_ppz_baseline_2012_2015-targets.tab' using 1:($2+$3+$4+$5+$6+$7) title "Zero Net Migration" with lines  ls 13
# unset output;
unset table;

# set output '../docs/report/images/employment-variants.svg'
set table '../docs/report/images/employment-variants.tab'
# set yrange [100000:2800000]
set title "Total Employment, Forecast Variants"
set ylabel "Employment"
# set key right bottom
plot \
        'output/hr/200120_sco_2016_2038_ppp_ppp_baseline_2012_2015-targets.tab' using 1:10 title "Principal" with lines ls 1, \
        'output/hr/200121_sco_2016_2038_ppp_hhh_baseline_2012_2015-targets.tab' using 1:10 title "High Population" with lines ls 2, \
        'output/hr/200122_sco_2016_2038_ppp_hpp_baseline_2012_2015-targets.tab' using 1:10 title "High Fertility" with lines ls 3, \
        'output/hr/200123_sco_2016_2038_ppp_lll_baseline_2012_2015-targets.tab' using 1:10 title "Low Population" with lines ls 4, \
        'output/hr/200124_sco_2016_2038_ppp_lpp_baseline_2012_2015-targets.tab' using 1:10 title "Low Fertility" with lines  ls 5, \
        'output/hr/200125_sco_2016_2038_ppp_php_baseline_2012_2015-targets.tab' using 1:10 title "High Life Expectancy" with lines  ls 6, \
        'output/hr/200126_sco_2016_2038_ppp_plp_baseline_2012_2015-targets.tab' using 1:10 title "Low Life Expectancy" with lines ls 7, \
        'output/hr/200127_sco_2016_2038_ppp_pph_baseline_2012_2015-targets.tab' using 1:10 title "High Migration" with lines ls 8, \
        'output/hr/200128_sco_2016_2038_ppp_ppl_baseline_2012_2015-targets.tab' using 1:10 title "Low Migration" with lines ls 9, \
        'output/hr/200129_sco_2016_2038_ppp_ppq_baseline_2012_2015-targets.tab' using 1:10 title "0% Future EU Migration" with lines ls 10, \
        'output/hr/200130_sco_2016_2038_ppp_ppr_baseline_2012_2015-targets.tab' using 1:10 title "50% Future EU Migration" with lines ls 11, \
        'output/hr/200131_sco_2016_2038_ppp_pps_baseline_2012_2015-targets.tab' using 1:10 title "150% Future EU Migration" with lines ls 12, \
        'output/hr/200132_sco_2016_2038_ppp_ppz_baseline_2012_2015-targets.tab' using 1:10 title "Zero Net Migration" with lines  ls 13
# unset output;
unset table

# set output '../docs/report/images/all-children-variants.svg'
set table '../docs/report/images/all-children-variants.tab'
# set yrange [800000:1300000]
set title "Numbers of Children, Forecast Variants"
set ylabel "Children"
# set key right bottom
plot \
        'output/hr/200120_sco_2016_2038_ppp_ppp_baseline_2012_2015-targets.tab' using 1:(($12+$13+$14+$29+$30+$31)) title "Principal" with lines ls 1, \
        'output/hr/200121_sco_2016_2038_ppp_hhh_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "High Population" with lines ls 2, \
        'output/hr/200122_sco_2016_2038_ppp_hpp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "High Fertility" with lines ls 3, \
        'output/hr/200123_sco_2016_2038_ppp_lll_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "Low Population" with lines ls 4, \
        'output/hr/200124_sco_2016_2038_ppp_lpp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "Low Fertility" with lines  ls 5, \
        'output/hr/200125_sco_2016_2038_ppp_php_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "High Life Expectancy" with lines  ls 6, \
        'output/hr/200126_sco_2016_2038_ppp_plp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "Low Life Expectancy" with lines ls 7, \
        'output/hr/200127_sco_2016_2038_ppp_pph_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "High Migration" with lines ls 8, \
        'output/hr/200128_sco_2016_2038_ppp_ppl_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "Low Migration" with lines ls 9, \
        'output/hr/200129_sco_2016_2038_ppp_ppq_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "0% Future EU Migration" with lines ls 10, \
        'output/hr/200130_sco_2016_2038_ppp_ppr_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "50% Future EU Migration" with lines ls 11, \
        'output/hr/200131_sco_2016_2038_ppp_pps_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "150% Future EU Migration" with lines ls 12, \
        'output/hr/200132_sco_2016_2038_ppp_ppz_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$29+$30+$31) title "Zero Net Migration" with lines  ls 13
# unset output;
unset table;

# set output '../docs/report/images/population-variants.svg'
set table '../docs/report/images/population-variants.tab'
# set yrange [500000:6000000]
set title "Scottish Population, Forecast Variants"
set ylabel "People"
# set key right bottom
plot \
        'output/hr/200120_sco_2016_2038_ppp_ppp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "Principal" with lines ls 1, \
        'output/hr/200121_sco_2016_2038_ppp_hhh_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "High Population" with lines ls 2, \
        'output/hr/200122_sco_2016_2038_ppp_hpp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "High Fertility" with lines ls 3, \
        'output/hr/200123_sco_2016_2038_ppp_lll_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "Low Population" with lines ls 4, \
        'output/hr/200124_sco_2016_2038_ppp_lpp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "Low Fertility" with lines  ls 5, \
        'output/hr/200125_sco_2016_2038_ppp_php_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "High Life Expectancy" with lines  ls 6, \
        'output/hr/200126_sco_2016_2038_ppp_plp_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "Low Life Expectancy" with lines ls 7, \
        'output/hr/200127_sco_2016_2038_ppp_pph_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "High Migration" with lines ls 8, \
        'output/hr/200128_sco_2016_2038_ppp_ppl_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "Low Migration" with lines ls 9, \
        'output/hr/200129_sco_2016_2038_ppp_ppq_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "0% Future EU Migration" with lines ls 10, \
        'output/hr/200130_sco_2016_2038_ppp_ppr_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "50% Future EU Migration" with lines ls 11, \
        'output/hr/200131_sco_2016_2038_ppp_pps_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "150% Future EU Migration" with lines ls 12, \
        'output/hr/200132_sco_2016_2038_ppp_ppz_baseline_2012_2015-targets.tab' using 1:($12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37+$38+$39+$40+$41+$42+$43+$44+$45) title "Zero Net Migration" with lines  ls 13
# unset output;
unset table;

