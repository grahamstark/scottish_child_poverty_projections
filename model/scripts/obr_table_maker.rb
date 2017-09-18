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

def createMillTable( colums )
        tableName = 'macro_forecasts'
        tableElem = REXML::Element.new( 'tmp' );
        colums.each{
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
millDatabase = REXML::Element.new( 'tmp' )
millDatabase.add_attribute( "name", "tmp" )

colnames = [ 
        'Employment',
        'Employment rate',
        'Employees',
        'ILO unemployment',
        'ILO unemployment rate',
        'Participation rate',
        'Claimant count',
        'Average hours worked',
        'Total hours worked',
        'Labour share',
        'Compensation of employees ',
        'Wages and salaries',
        'Employers social contributions',
        'Mixed income',
        'Average earnings growth',
        'Average earnings index',
        'Average hourly earnings index',
        'Productivity per hour index',
        'Productivity per worker index',
        'Real product wage',
        'Real consumption wage',
        'RPI',
        'RPIX',
        'CPI',
        'Producer output prices',
        'Mortgage interest payments',
        'Actual rents for housing',
        'Consumer expenditure deflator',
        'House price index',
        'GDP deflator',
        'RPI',
        'RPIX',
        'CPI',
        'Producer output prices',
        'Mortgage interest payments',
        'Actual rents for housing',
        'Consumer expenditure deflator',
        'House price index',
        'GDP deflator',
        'LFS employment',
        'Real household disposable income',
        'Real consumption',
        'Real GDP',
        'LFS employment',
        'Real household disposable income',
        'Real consumption',
        'Real GDP'
        ]

millDatabase << createMillTable( colnames )
millDoc << millDatabase


xmlFile = File.open( "../database/xml/obr_insert.xml", "w")
millDoc.write( xmlFile, 8 ) 
xmlFile.close()