#!/usr/bin/ruby
require 'csv'
require 'utils'
# require 'narray'
# require 'set'

DATA_PATH="/home/graham_s/VirtualWorlds/projects/scottish_child_poverty_projections/docs/"

def toCSV( filename )
        f = File.new( filename, 'rb' );
        lines = CSV.parse( f, { col_sep:"\t" } )
        f.close()
        return lines
end

def readBlock( lines, pos )
       label = lines[pos][0]
       puts "label #{label}\n"
       pos += 1
       pos += 1 if lines[pos][1].nil? # check for irregular spacing
       puts "on line #{pos}\n"
       p lines[pos]
       data = []
       years = []
       yearsStr = lines[pos][1..-1]
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       pos += 2
       targetGroup = lines[pos][0]
       pos +=1
       p years      
       puts "target group #{targetGroup}\n"
       begin
               
               key = lines[pos][0]
               key = "age_#{key}" if key =~ /\d+/
               key = censor("#{targetGroup}_#{key}")
               puts "on line #{pos} |#{lines[pos][0]}| key #{key}\n"
               pos +=1
               
       end while ! lines[pos][1].nil?
       return pos+1
       
end

# fname = ARGS[0]
fname = "#{DATA_PATH}/#{ARGV[0]}"
variant = ARGV[1]
## nrs/pp-2014-based-add-var-euro-zeroeumig-scotland-syoa-1.tab
puts "opening #{fname}\n"
lines = toCSV( fname );
pos = 0
# p lines
variant_desc = lines[0][0]

begin
        pos = readBlock( lines, pos )
        puts "pos end #{pos}\n"
        
end while pos < lines.length-1




