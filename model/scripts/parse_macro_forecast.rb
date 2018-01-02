#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs'

def readMacro( lines, startCol, keyLineStart, out )
        p = 0
        keys = []
        data = {}
        years = []
        loop do
              p lines[p]
              if(( ! lines[p][startCol].nil? ) && ( lines[p][startCol] =~ /#{keyLineStart}/ ))
                        lines[p][startCol..-1].each{
                                |l|
                                if not l.nil? then
                                        puts "p = #{p} l '#{l}'\n"
                                        if l =~ /(.*)\(.*/
                                                l = $1
                                        end
                                        l.gsub!( 'billion', '' )
                                        key = censor( l )
                                        keys << key
                                end
                        }
                        puts "made keys as #{out[:keys]}; breaking"
                        break;
              end
              p += 1
        end
        #
        # skip to the financial year bit YYYY
        #
        loop do
                puts "lines[#{p}][1] #{lines[p][1]}\n"
                break if lines[p][1] =~ /\//
                p += 1
        end
        
        puts "starting on line #{p}"
        begin
                year = lines[p][1].to_i
                years << year
                puts "on line #{p}; year #{year}\n"
                c = 0
                lines[p][startCol..-1].each{
                        |d|
                        key = keys[c]
                        data[key] = [] if data[key].nil?
                        data[key] << d.to_f 
                        c += 1
                        
                        

                }
                p += 1
        end while (lines[p][1] =~ /[0-9\/]+/)
        p keys
        p years
        p data
        data.each{
                |k,v|
                out[:data][k] = v;
        }
        out[:years] = years # if out[:years].nil?
        keys.each{
                |k|
                out[:keys] << k
        }

        return out     
end

out = {:pos=>0,:data=>{}, :label=>'', :years=>[], :keys=>[] }
source = 'obr'

#
# hacked together Nov 2017 version
# '1.5' ignored for now - need to parse > 1 line for header can't be arsed.
['1.6','1.7'].each{
        |which|
        fullFName = "#{DATA_PATH}/#{source}/Nov_2017/obr_nov_#{which}.tab"
        puts fullFName;
        lines = toCSV( fullFName );
        case which
        when '1.5' then
                        out = readMacro( lines, 2, 'LFS', out )
        when '1.7' then                  
                        out = readMacro( lines, 11, 'RPI', out )
        when '1.6' then              
                        out = readMacro( lines, 2, 'Employment', out )
        end
        
}

#
# March 2017 version
#
if false then
        ['gdp_per_capita','prices','employment'].each{
                |which|
                fullFName = "#{DATA_PATH}/#{source}/obr_forecast_#{which}.tab"
                puts fullFName;
                lines = toCSV( fullFName );
                case which
                when 'gdp_per_capita' then
                                out = readMacro( lines, 2, 'LFS', out )
                when 'prices' then                  
                                out = readMacro( lines, 11, 'RPI', out )
                when 'employment' then              
                                out = readMacro( lines, 2, 'Employment', out )
                end
                
        }
end

p out
country = 'UK'
edition = 2018 # fuckup!!! 2 2017 versions... 
recType = 'macro'
variant = 'baseline'
fname='obr_forecast_gdp_per_capita.tab'
varStmt = "insert into target_data.forecast_variant( rec_type, variant, country, edition, source, description, url, filename ) values( '#{recType}', '#{variant}', '#{country}', '#{edition}', '#{source}', '#{out[:label]}', null, '#{fname}' )"
loadBlockToDB( out, variant, country, edition, recType )
