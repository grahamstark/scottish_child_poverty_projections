#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs'



$OBR_TO_SFC_MAP = {
        "employment" => NIL,
        "employment_rate" => "v_16_plus_employment_rate",
        "employees" => "v_16_plus_employees_in_employment",
        "ilo_unemployment" => "v_16_plus_unemployment_level",
        "ilo_unemployment_rate" => "ilo_unemployment_rate",
        "participation_rate" => "v_16_plus_participation_rate",
        "claimant_count" => NIL,
        "average_hours_worked" => "average_weekly_hours_worked",
        "total_hours_worked" => NIL,
        "labour_share" => NIL,
        "compensation_of_employees" => NIL,
        "wages_and_salaries" => NIL,
        "employers_social_contributions" => NIL,
        "mixed_income" => NIL,
        "average_earnings_growth" => NIL,
        "average_earnings_index" => NIL,
        "average_hourly_earnings_index" => NIL,
        "productivity_per_hour_index" => NIL,
        "productivity_per_worker_index" => NIL,
        "real_product_wage" => NIL,
        "real_consumption_wage" => NIL,
        "rpi" => NIL,
        "rpix" => NIL,
        "cpi" => NIL,
        "producer_output_prices" => NIL,
        "mortgage_interest_payments" => NIL,
        "actual_rents_for_housing" => NIL,
        "consumer_expenditure_deflator" => NIL,
        "house_price_index" => NIL,
        "gdp_deflator" => NIL,
        "lfs_employment" => NIL,
        "real_household_disposable_income" => NIL,
        "real_consumption" => NIL,
        "real_gdp" => NIL,
        "lfs_employment_age_16_plus" => NIL,
        "real_household_disposable_income_age_16_plus" => NIL,
        "real_consumption_age_16_plus" => NIL,
        "real_gdp_age_16_plus" => NIL,
        "private_sector_employment" => NIL,
        "public_sector_employment" => NIL 
        }

def readMacro( lines, startCol, keyLineStart, out )
        p = 0
        finalKeys = []
        keys = []
        data = {}
        years = []
        loop do
              p lines[p]
              if(( ! lines[p][startCol].nil? ) && ( lines[p][startCol] =~ /#{keyLineStart}/ ))
                        lines[p][startCol..-1].each{
                                |l|
                                puts "p = #{p} l '#{l}'\n"
                                if l =~ /(.*)\(.*/
                                        l = $1
                                end
                                l.gsub!( 'billion', '' )
                                key = censor( l )
                                keys << key
                        }
                        puts "made keys as #{out[:keys]}; breaking"
                        break;
              end
              p += 1
        end
        #
        # skip to the financial year bit YYYY/YY
        #
        loop do
                puts "lines[#{p}][1] #{lines[p][1]}\n"
                break if lines[p][3] =~ /\-/
                p += 1
        end
        
        puts "starting on line #{p}"
        begin
                year = lines[p][3].to_i
                years << year
                # puts "on line #{p}; year #{year}\n"
                c = 0
                lines[p][startCol..-1].each{
                        |d|
                        key = $OBR_TO_SFC_MAP.key( keys[c] )
                        if not key.nil? then 
                                puts "using key #{key} from #{keys[c]}"
                                data[key] = [] if data[key].nil?
                                data[key] << d.to_f
                                finalKeys << key
                        end
                        c += 1
                }
                p += 1
        end while (lines[p][3] =~ /[0-9\-]+/) # while col 1 is a financial year
        p keys
        p years
        p data
        data.each{
                |k,v|
                out[:data][k] = v;
        }
        out[:years] = years # if out[:years].nil?
        out[:keys] = data.keys()
        #finalKeys.each{
        #        |k|
        #        out[:keys] << k
        #}

        return out     
end

out = {:pos=>0,:data=>{}, :label=>'', :years=>[], :keys=>[] }
source = 'sfc'
fullFName = "#{DATA_PATH}/#{source}/scotlands-economic-fiscal-forecasts-chapter-2-economy-supplementary-tables.tab"
lines = toCSV( fullFName );
out = readMacro( lines, 1, 'Year', out )

p out
country = 'SCO'
edition = 2017
recType = 'macro'
variant = 'baseline'
fname='scotlands-economic-fiscal-forecasts-chapter-2-economy-supplementary-tables.tab'
varStmt = "insert into target_data.forecast_variant( rec_type, variant, country, edition, source, description, url, filename ) values( '#{recType}', '#{variant}', '#{country}', '#{edition}', '#{source}', '#{out[:label]}', null, '#{fname}' )"
loadBlockToDB( out, variant, country, edition, recType )
