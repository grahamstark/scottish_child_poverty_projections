set terminal svg size 800,600 enhanced butt solid

set datafile separator "\t"
set timefmt "%Y"
set format y "%1.0f"

set xlabel "Year"
set xrange [2016:2038]
# set xdata time
set key left top
set grid
set key autotitle columnhead

list=system('ls *-targets.tab')

do for [filename in list ]{ 
        
        set output sprintf('../../../docs/report/images/%s-hhlds.svg', filename )
        set yrange [0:900000]
        set title "Projected Households"
        set ylabel "Households"
        plot     filename using 1:2 with lines , \
                 filename using 1:3 with lines , \
                 filename using 1:4 with lines , \
                 filename using 1:5 with lines , \
                 filename using 1:6 with lines , \
                 filename using 1:7 with lines , \
                 filename using 1:8 with lines 
        unset output
        
        set output sprintf('../../../docs/report/images/%s-employment.svg', filename )
        set yrange [0:2800000]
        set title "Employment"
        set ylabel "Population"
        plot    filename using 1:9 with lines, \
                filename using 1:10 with lines, \
                filename using 1:11 with lines
        unset output
        
        set output sprintf('../../../docs/report/images/%s-children.svg', filename )
        set yrange [0:200000]
        set title "Children"
        set ylabel "Population"
        plot    filename using 1:12 with lines, \
                filename using 1:13 with lines, \
                filename using 1:14 with lines, \
                filename using 1:15 with lines, \
                filename using 1:29 with lines, \
                filename using 1:30 with lines, \
                filename using 1:31 with lines, \
                filename using 1:32 with lines
        unset output
}