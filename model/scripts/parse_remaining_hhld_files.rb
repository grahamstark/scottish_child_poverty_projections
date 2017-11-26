#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs.rb'

def readNI( lines )
       label = lines[0][1]
       yearsStr = lines[1][1..-1]
       years = []
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       pos = 1
       puts "years #{years}"
       keys = []
       data = {}
       begin
              pos += 1
              key = lines[pos][0]
              key = censor( key )
              puts "got key as #{key}"
              keys << key
              if data[key].nil?
                      data[key]=[] 
                      
              end
              lines[pos][1..-1].each{
                       |cell|
                       data[key] << cell.to_f
              }
              
       end while pos < 6  
       return {:data=>data, :label=>label, :years=>years, :keys=>keys }        
end

def readWA( lines )
       label = lines[25][0] + lines[26][0] + lines[28][0]
       yearsStr = lines[7][2..-1]
       years = []
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       pos = 8
       puts "years #{years}"
       keys = []
       data = {}
       begin
              pos += 1
              key = lines[pos][1]
              key = censor( key )
              puts "got key as #{key}"
              keys << key
              if data[key].nil?
                      data[key]=[] 
                      
              end
              lines[pos][2..-1].each{
                       |cell|
                       data[key] << cell.to_f
              }
              
       end while pos < 20  
       return {:data=>data, :label=>label, :years=>years, :keys=>keys }        
        
end

def readEN( lines )
       label = "England; base assumptions"
       pos = 0
       yearsStr = lines[pos][5..-1]
       years = []
       yearsStr.each{
               |ystr|
                years << ystr.to_i       
       }
       puts "years #{years}"
       keys = []
       data = {}
       begin
              pos += 1
              key = lines[pos][3]
              key = censor( key )
              puts "got key as #{key}"
              keys << key
              if data[key].nil?
                      data[key]=[] 
                      
              end
              lines[pos][5..-1].each{
                       |cell|
                       data[key] << cell.to_f
              }
              
       end while pos < 8  
       return {:data=>data, :label=>label, :years=>years, :keys=>keys }        
end


puts "filename, variant (string), country (SCO|ENG|UK), edition (a year) source (ONS, etc.) type (persons|households|macro|participation)"


edition = 2017
source = 'ons'
recType = 'households'
variant = '1'

# fname = ARGS[0]
[ 'NIR' ].each{ #'ENG' , 'WAL'
        |country|
        case country
        when 'NIR' 
           edition = 2012
           fname = "#{DATA_PATH}/nireland/HHP12-NI.csv"
           lines = toCSV( fname )
           out = readNI( lines )
           table = 'nireland_households'
        when 'ENG' 
           edition = 2014
           fname = "#{DATA_PATH}/england/england-hh-projections.csv"
           lines = toCSV( fname )
           out = readEN( lines )
           table = 'england_households'
        when 'WAL' 
           fname = "#{DATA_PATH}/wales/export.csv"
           edition  = 2014
           lines = toCSV( fname )
           p lines
           out = readWA( lines )
           table = 'wales_households'
        end 
        puts "opening #{fname}\n"
        out[:variant] = variant
        varStmt = "insert into target_data.forecast_variant( rec_type, variant, country, edition, source, description, url, filename ) values( '#{recType}', '#{variant}', '#{country}', '#{edition}', '#{source}', '#{out[:label]}', null, '#{fname}' )"                
        p varStmt
        p out
        CONNECTION.run( varStmt )
        loadBlockToDB( out, variant, country, edition, recType, table )
}