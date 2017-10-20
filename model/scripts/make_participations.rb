#!/usr/bin/ruby

def doOne( startAge, endAge, sex )
        isex = if sex=='male' then 1 else 2 end
        s = "      targets.participation_#{startAge}_#{endAge}_#{sex} := (\n         "
        a = []
        (startAge..endAge).each{
              |age|
              a << "#{sex}_popn.age_#{age}"  
        }
        
        s += a.join( "+\n         " )
        s += " ) * ( participation_#{sex}s.age_#{startAge}_#{endAge} / 100.0 ) * \n"
        s += "      Get_Participation_Scale( the_run.country, #{isex}, #{startAge} );\n\n"
        s
end



puts( doOne( 16, 19, 'male' ));
puts( doOne( 20, 24, 'male' ));
puts( doOne( 25, 29, 'male' ));
puts( doOne( 30, 34, 'male' ));
puts( doOne( 35, 39, 'male' ));
puts( doOne( 40, 44, 'male' ));
puts( doOne( 45, 49, 'male' ));
puts( doOne( 50, 54, 'male' ));
puts( doOne( 55, 59, 'male' ));
puts( doOne( 60, 64, 'male' ));
puts( doOne( 65, 69, 'male' ));
puts( doOne( 70, 74, 'male' ));
puts( doOne( 75, 110, 'male' ));
      
puts( doOne( 16, 19, 'female' ));
puts( doOne( 20, 24, 'female' ));
puts( doOne( 25, 29, 'female' ));
puts( doOne( 30, 34, 'female' ));
puts( doOne( 35, 39, 'female' ));
puts( doOne( 40, 44, 'female' ));
puts( doOne( 45, 49, 'female' ));
puts( doOne( 50, 54, 'female' ));
puts( doOne( 55, 59, 'female' ));
puts( doOne( 60, 64, 'female' ));
puts( doOne( 65, 69, 'female' ));
puts( doOne( 70, 74, 'female' ));
puts( doOne( 75, 110, 'female' ));
