             
def makeAgeLists( agebands, varname, postfix )
        agebands.each{
                |range|
                strs = []
                range.each{
                        |age|
                        strs << "#{varname}_#{age}#{postfix}"
                }
                puts "         tmp := #{strs.join( " + " )};\n"
                puts "         Add_Col( tmp );\n"
        } 
end

(16 .. 110).each{
        |age|
   puts "                     when #{age} =>\n" +
"                        Inc( targets.age_#{age} );\n" +
"                        if( adult.sex = 1 ) then\n" +
"                           Inc( targets.age_#{age}_male );\n" +
"                        elsif( adult.sex = 2 ) then\n" +
"                           Inc( targets.age_#{age}_female );\n" +
"                        end if;\n"; 
}


(0 .. 19).each{
        |age|
   puts "                     when #{age} =>\n" +
"                        Inc( targets.age_#{age} );\n" +
"                        if( child.sex = 1 ) then\n" +
"                           Inc( targets.age_#{age}_male );\n" +
"                        elsif( child.sex = 2 ) then\n" +
"                           Inc( targets.age_#{age}_female );\n" +
"                        end if;\n"; 
}

(0 .. 110).each{
        |age|
        puts "           Inc( targets.male, male_popn.age_#{age} );\n";
        puts "           Inc( targets.female, female_popn.age_#{age} );\n";
}

(16 .. 110).each{
        |age|
        puts "           Inc( age_16_plus, male_popn.age_#{age} + female_popn.age_#{age} );";
}

(0 .. 110).each{
        |age|
        puts "           targets.age_#{age} := male_popn.age_#{age} + female_popn.age_#{age};\n";
}

(0 .. 110).each{
        |age|
        puts "           targets.age_#{age}_male := male_popn.age_#{age};\n";
        puts "           targets.age_#{age}_female := female_popn.age_#{age};\n";
}


agebands = [ (0..4), ( 5..10), (11..15), (16..19), (20..24), (25..29), (30..34), (35..39), (40..44), (45..49), (50..54),
             (55..59), (60..64), (65..69), (70..74), (75..79), (80..110) ]
             
makeAgeLists( agebands, "targets.age", "_male" )
makeAgeLists( agebands, "targets.age", "_female" )
makeAgeLists( agebands, "targets.age", "" )