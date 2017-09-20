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
