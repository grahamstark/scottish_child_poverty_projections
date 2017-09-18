#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs.rb'


def readHouseholds( lines, variant )
       pos = 3
       yearsStr = lines[pos][2..-1]
       years = []
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       puts "years #{years}"
       label = FORECAST_LABELS[ variant ]
       targetGroup = 'HOUSEHOLDS'
       keys = []
       data = {}
       begin
              pos += 1
              key = if ! lines[pos][1].nil? then lines[pos][1] else lines[pos][0] end
              key = reCensorKey(censor( key )) 
              puts "got key as #{key}"
              keys << key
              data[key]=[] if data[key].nil?
              lines[pos][2..-1].each{
                       |cell|
                       # puts "on year #{year} cell |#{cell}|"
                       data[key] << cell.to_i
              }
              
       end while ! lines[pos][1].nil?       
       return {:pos=>pos+1,:data=>data, :label=>label, :targetGroup=>targetGroup, :years=>years, :keys=>keys }        
end

def readONSPersonsBlock( lines, pos, fname, years )
       if( years.nil? )then
               yearsStr = lines[pos][2..-1]
               years = []
               yearsStr.each{
                       |ystr|
                        years << ystr.to_i       
               }
               pos += 1       
       end
       data = {}
       if fname =~ /(.*?)_(.*?)_.*/ then
               label = FORECAST_LABELS[$2] 
       end
       keys = []
       begin
              target = lines[pos][0].to_i
              key = lines[pos][1]
              
              if key =~ /(\d+).*/ then
                     key = "age_#{$1}" 
              end
              keys << key
              data[key]=[] if data[key].nil?
              lines[pos][2..-1].each{
                       |cell|
                       # puts "on year #{year} cell |#{cell}|"
                       data[key] << cell.to_i
              }
              pos += 1 
              break if pos >= lines.length
              break if target != lines[pos][0].to_i
       end while pos < lines.length 
       targetGroup = if target == 1 then 'MALES' else 'FEMALES' end
       return {:pos=>pos,:data=>data, :label=>label, :targetGroup=>targetGroup, :years=>years, :keys=>keys }               
end

def readNRSPersonsBlock( lines, pos )
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
               if key =~ /(\d+).*/ then
                       key = "age_#{$1}" 
               end
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

if ARGV.length < 6 then
        puts "filename, variant (string), country (SCO|ENG|UK), edition (a year) source (ONS, etc.) type (persons|households|macro)"
        exit
end
        
# fname = ARGS[0]
fname = ARGV[0]

variant = ARGV[1]
country = ARGV[2]
edition = ARGV[3]
source = ARGV[4].downcase
recType = ARGV[5].downcase
fullFname = "#{DATA_PATH}/#{source}/#{fname}"

## nrs/pp-2014-based-add-var-euro-zeroeumig-scotland-syoa-1.tab
puts "opening #{fname}\n"
lines = toCSV( fullFname );
pos = 0
# p lines

        
variant_desc = lines[0][0]
l = lines.length - 1
p = 0
out = {}
loop do
        if( source == 'nrs')
                if recType == 'persons' 
                        out = readNRSPersonsBlock( lines, pos )
                else
                        out = readHouseholds( lines, variant )
                end
        elsif( source == 'ons' )
                if p > 0 then
                        years = out[:years]
                else
                        years = nil;
                end
                out = readONSPersonsBlock( lines, pos, fname, years )        
        end
        pos = out[:pos]
        puts "pos end #{out[:pos]}\n"
        varStmt = "insert into target_data.forecast_variant( rec_type, variant, country, edition, source, description, url, filename ) values( '#{recType}', '#{variant}', '#{country}', '#{edition}', '#{source}', '#{out[:label]}', null, '#{fname}' )"                
        # if( recType != 'households')
                if( p == 0 )
                        CONNECTION.run( varStmt )
                end
                loadBlockToDB( out, variant, country, edition, recType )
        # else
                puts "#{varStmt}\n"
                puts "#{out}"
        # end
        p += 1
        break if pos >= l
end