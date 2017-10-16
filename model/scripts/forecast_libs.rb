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

def loadBlockToDB( out, variant, country, edition, recType )
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
                table = TABLE_NAME[ recType ]
                dataStmt = "insert into target_data.#{table}( year, rec_type, variant, country, edition, #{keys.join(', ')} ) values( #{vs} )";
                puts "stmt #{dataStmt}\n"                
                CONNECTION.run( dataStmt )
        }
end