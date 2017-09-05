#!/usr/bin/ruby
#
# bits and pieces to load converted allissue schema files into a postgres database
# you need to convert the .rtf files to ascii first. Do this with:
# soffice --headless --convert-to tab *.rtf
# 

require 'ukds_schema_utils'
require 'utils'
load 'conversion_constants.rb'



todo = [ "frs" ] 
#
# parse all .tab files in a directory and load to ukds.dictionaries schema
#
def parseFiles( targetdir, dataset, year )
        be = BlankEdit.new()
        Dir["#{targetdir}/*.txt"].each{
                |filename|
                if filename =~ /#{targetdir}\/(.*)_ukda_data_dictionary\.txt/i then
                        tablename = $1
                        puts "datset #{dataset}; Parsing #{filename} #{tablename}"
                        readOneRTF( dataset, year, filename, tablename, be )
                end
        }
end

if todo.include?( "frs" )then
        (2013..2015).each{
                |year|
                targetdir="/mnt/data/frs/#{year}/mrdoc/allissue/"
                puts "on dir #{targetdir}"
                parseFiles( targetdir, 'frs', year )
        }
end