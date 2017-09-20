#!/usr/bin/ruby
require 'rexml/document'
require 'rexml/element'
require 'rexml/xpath'
# require 'dbi'
require 'csv'
require 'ukds_schema_utils'
require 'utils'
load './conversion_constants.rb'
#
# Hack, rushed .. create a db table out of OBR supp. tables 1.5 .. 1.7
#
include REXML

def createMillTable( colNames )
        tableName = 'macro_forecasts'
        tableElem = REXML::Element.new( 'table' );
        tableElem.add_attribute( "name" "target_dataset")
        column = REXML::Element.new( "column" )
        column.add_attribute( "name", "run_id")
        column.add_attribute( "description", "" )
        column.add_attribute( "primaryKey", "True" );
        column.add_attribute("type", "INTEGER" );
        tableElem << column
        colNames.each{
                |colname|
                column = REXML::Element.new( "column" )
                column.add_attribute( "name", censor( colname ))
                column.add_attribute( "description", colname )
                column.add_attribute("default", "0.0" );
                column.add_attribute("type", "REAL" );
                column.add_attribute( "adaTypeName", "Amount" )
                tableElem << column
        }
        
        return tableElem
end

millDoc = REXML::Document.new();
millDTD = REXML::DocType.new('database PUBLIC "http://virtual-worlds.biz/Mill"  "http://www.virtual-worlds.biz/dtds/mill.dtd"');
millDoc << millDTD
millDatabase = REXML::Element.new( 'targets' )
millDatabase.add_attribute( "name", "targets" )

colnames = [
        'household_one_adult_male',
        'household_one_adult_female',
        'household_two_adults',
        'household_one_adult_one_child',
        'household_one_adult_two_plus_children',
        'household_two_plus_adult_one_plus_children',
        'household_three_plus_person_all_adult',
        'household_all_households',
        'male',
        'female',
        'employed',
        'employee',
        'ilo_unemployed',
        'jsa_claimant'
 ]


['male','female'].each{
        |mf|
        (0..110).each{
                |age|
                colnames << "age_#{age}_#{mf}"        
        
        }
}
(0..110).each{
        |age|
        colnames << "age_#{age}"        
}



millDatabase << createMillTable( colnames )
millDoc << millDatabase


xmlFile = File.open( "../database/xml/target_data_insert.xml", "w")
millDoc.write( xmlFile, 8 ) 
xmlFile.close()