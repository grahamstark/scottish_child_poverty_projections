#!/usr/bin/ruby
require 'csv'
require 'utils'
# require 'narray'
# require 'set'
require 'sequel'

DATA_PATH="/home/graham_s/VirtualWorlds/projects/scottish_child_poverty_projections/docs/"
CONNECTION = Sequel.connect(
        :adapter=>'postgres', 
        :host=>'localhost', 
        :database=>'ukds', 
        :user=>'graham_s' )

def toCSV( filename )
        f = File.new( filename, 'rb' );
        lines = CSV.parse( f, { col_sep:"\t" } )
        f.close()
        return lines
end


def readPersonsBlock( lines, pos )
       label = lines[pos][0]
       puts "label #{label}\n"
       pos += 1
       pos += 1 if lines[pos][1].nil? # check for irregular spacing
       puts "on line #{pos}\n"
       p lines[pos]
       data = {}
       years = []
       yearsStr = lines[pos][1..-1]
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       pos += 1
       pos +=1 if lines[pos][0].nil?
       targetGroup = lines[pos][0]
       p years      
       puts "target group #{targetGroup}\n"
       pos += 1
       keys = []
       begin
               
               key = lines[pos][0]
               key = "age_#{key}" if key =~ /\d+/
               key = censor("#{key}")
               puts "on line #{pos} |#{lines[pos][0]}| key #{key}\n"
               data[key]=[] if data[key].nil?
               lines[pos][1..-1].each{
                       |cell|
                       # puts "on year #{year} cell |#{cell}|"
                       data[key] << cell.to_i
               }
               keys << key
               pos +=1
               
       end while ! lines[pos][1].nil?
       return {:pos=>pos+1,:data=>data, :label=>label, :targetGroup=>targetGroup, :years=>years, :keys=>keys }
end

def loadBlockToDB( out, variant, country, edition )
        p out # [:data]
        i = 0
        out[:years].each{
                |year|
                v = []
                v << year
                v << "'people'"
                v << "'#{variant}'"
                v << "'#{country}'"
                v << edition
                out[:keys].each{
                        |key|
                        v << out[:data][key][i]
                }
                i += 1
                puts "#{year}\n"
                vs = v.join(', ')
                dataStmt = "insert into target_data.population_forecasts( year, rec_type, variant, country, edition, #{out[:keys].join(', ')} ) values( #{vs} )";
                puts "stmt #{dataStmt}\n"                
                CONNECTION.run( dataStmt )
        }
end

if ARGV.length < 5 then
        puts "filename, variant (string), country (SCO|ENG|UK), edition (a year) source (ONS, etc.)"
        exit
end
        
# fname = ARGS[0]
fname = ARGV[0]

variant = ARGV[1]
country = ARGV[2]
edition = ARGV[3]
source = ARGV[4]
fullFname = "#{DATA_PATH}/#{source.downcase}/#{fname}"
## nrs/pp-2014-based-add-var-euro-zeroeumig-scotland-syoa-1.tab
puts "opening #{fname}\n"
lines = toCSV( fullFname );
pos = 0
# p lines

        
variant_desc = lines[0][0]
l = lines.length - 1
p = 0
loop do
        out = readPersonsBlock( lines, pos )
        pos = out[:pos]
        puts "pos end #{out[:pos]}\n"
        if( p == 0 )
                varStmt = "insert into target_data.forecast_variant( rec_type, variant, country, edition, source, description, url, filename ) values( 'persons', '#{variant}', '#{country}', '#{edition}', '#{source}', '#{out[:label]}', '#{fname}' )"
                puts "#{varStmt}\n"
                CONNECTION.run( varStmt )
        end
        loadBlockToDB( out, variant, country, edition )
        break if pos >= l
end