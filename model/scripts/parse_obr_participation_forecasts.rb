#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs.rb'


def readRates( lines, mf )
       label = lines[1][1]
       pos = 3
       yearsStr = lines[pos][2..-1]
       years = []
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       puts "years #{years}"
       keys = []
       data = {}
       keys << 'target_group'
       data['target_group'] = []
       years.each{
               |y|
               data['target_group'] << "'#{mf}'"
       }
       begin
              pos += 1
              key = lines[pos][1]
              key = 'age_'+key.gsub('-','_' )
              key = 'age_75_plus' if key == 'age_75_89'
              puts "got key as #{key}"
              keys << key
              if data[key].nil?
                      data[key]=[] 
                      
              end
              lines[pos][2..-1].each{
                       |cell|
                       data[key] << cell.to_f
              }
              
       end while pos < 16   
       return {:data=>data, :label=>label, :years=>years, :keys=>keys }        
end


puts "filename, variant (string), country (SCO|ENG|UK), edition (a year) source (ONS, etc.) type (persons|households|macro|participation)"


country = 'UK'
edition = 2017
source = 'obr'
recType = 'participation'
variant = '1'

# fname = ARGS[0]
['males', 'females'].each{
        |mf|
        variant = mf
        fname = "obr_participation_rates_uk_#{mf}.tab"
        fullFname = "#{DATA_PATH}/#{source}/#{fname}"
        ## nrs/pp-2014-based-add-var-euro-zeroeumig-scotland-syoa-1.tab
        puts "opening #{fname}\n"
        lines = toCSV( fullFname );
        out = readRates( lines, mf )
        out[:variant] = variant
        out[:target_group] = mf;
        out[:label] += '(note: 2009-2021 16-19YOs is interpolated.'
        varStmt = "insert into target_data.forecast_variant( rec_type, variant, country, edition, source, description, url, filename ) values( '#{recType}', '#{variant}', '#{country}', '#{edition}', '#{source}', '#{out[:label]}', null, '#{fname}' )"                
        p out
        CONNECTION.run( varStmt )
        loadBlockToDB( out, variant, country, edition, recType )
}