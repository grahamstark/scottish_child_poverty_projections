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
