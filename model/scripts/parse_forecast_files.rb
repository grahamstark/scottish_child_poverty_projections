#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs.rb'



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
                        out = readScottishHouseholds( lines, variant )
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
                        # CONNECTION.run( varStmt )
                end
                loadBlockToDB( out, variant, country, edition, recType )
        # else
                puts "#{varStmt}\n"
                puts "#{out}"
        # end
        p += 1
        break if pos >= l
end