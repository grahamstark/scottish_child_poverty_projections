#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'

DATA_PATH="/home/graham_s/VirtualWorlds/projects/scottish_child_poverty_projections/docs/"

CONNECTION = Sequel.connect(
        :adapter=>'postgres', 
        :host=>'localhost', 
        :database=>'ukds', 
        :user=>'postgres' )

def toCSV( filename )
        f = File.new( filename, 'rb' );
        lines = CSV.parse( f, { col_sep:"\t" } )
        f.close()
        return lines
end

TABLE_NAME ={
     'persons' => 'population_forecasts',   
     'households' => 'households_forecasts',
     'macro' => "macro_forecasts",
     'participation' => 'obr_participation_rates'
        
}

FORECAST_LABELS = {
        'ppp' => 'principal projection',
        'hpp' => 'high fertility variant',
        'lpp' => 'low fertility variant',
        'php' => 'high life expectancy variant',  
        'plp' => 'low life expectancy variant',
        'pph' => 'high migration variant',
        'ppl' => 'low migration variant',
        'pjp' => 'moderately high life expectancy variant',
        'pkp' => 'moderately low life expectancy variant',
        'ppq' => '0% future EU migration variant (not National Statistics)',
        'ppr' => '50% future EU migration variant (not National Statistics)',
        'pps' => '150% future EU migration variant (not National Statistics)',
        'hhh' => 'high population variant',
        'lll' => 'low population variant',
        'ppz' => 'zero net migration (natural change only) variant',
        'hlh' => 'young age structure variant',
        'lhl' => 'old age structure variant',
        'rpp' => 'replacement fertility variant',
        'cpp' => 'constant fertility variant',
        'pnp' => 'no mortality improvement variant',
        'cnp' => 'no change variant',
        'ppb' => 'long term balanced net migration variant'
}

def reCensorKey( key )
        key.gsub( "1", 'one' ).gsub( "2", 'two').gsub( '3', 'three' ).gsub( 'v_', '' )
end

def loadBlockToDB( out, variant, country, edition, recType, table=nil )
        p out # [:data]
        i = 0
        out[:years].each{
                |year|
                v = []
                v << year
                v << "'#{recType}'"
                v << "'#{variant}'"
                v << "'#{country}'"
                v << edition
                keys = out[:keys].clone()
                p keys
                keys.each{
                        |key|
                        puts "key: #{key} i #{i}\n"
                        v << out[:data][key][i]
                }
                if recType == 'persons' 
                        v << "'#{out[:targetGroup]}'"
                        keys << 'target_group'
                end
                i += 1
                puts "#{year}\n"
                vs = v.join(', ')
                
                table = TABLE_NAME[ recType ] if table.nil?
                
                dataStmt = "insert into target_data.#{table}( year, rec_type, variant, country, edition, #{keys.join(', ')} ) values( #{vs} )";
                puts "stmt #{dataStmt}\n"                
                CONNECTION.run( dataStmt )
        }
end

INSERT_RUN_STMT = CONNECTION[
        "insert into target_data.run( 
                run_id,
                user_id,
                description,
                start_year,
                end_year,
                macro_edition,
                households_edition,
                population_edition,
                country,
                households_variant,
                population_variant,
                macro_variant,
                run_type,
                weighting_function,
                weighting_lower_bound,
                weighting_upper_bound,
                targets_run_id,
                targets_run_user_id,
                data_run_id,
                data_run_user_id,
                selected_clauses,
                data_start_year,
                data_end_year,
                uk_wide_only ) 
        values( 
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ? )",
        :$run_id,
        :$user_id,
        :$description,
        :$start_year,
        :$end_year,
        :$macro_edition,
        :$households_edition,
        :$population_edition,
        :$country,
        :$households_variant,
        :$population_variant,
        :$macro_variant,
        :$run_type,
        :$weighting_function,
        :$weighting_lower_bound,
        :$weighting_upper_bound,
        :$targets_run_id,
        :$targets_run_user_id,
        :$data_run_id,
        :$data_run_user_id,
        :$selected_clauses,
        :$data_start_year,
        :$data_end_year,
        :$uk_wide_only ];



def readScottishHouseholds( lines, variant )
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