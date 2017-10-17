#!/usr/bin/ruby

require 'utils'

def cens( country, a )
        
        puts "
            <table name='#{country}_households' description='HH Projections for #{country} in original format' >
                   <column name='year' type='INTEGER' adaTypeName='Year_Number'  default='1970' primaryKey='true'/>
                   <column name='rec_type' type='CHAR' default='persons' primaryKey='true'/>
                   <column name='variant' type='CHAR' size='20'  primaryKey='true' />
                   <column name='country' type='CHAR' size='20'  primaryKey='true' />
                   <column name='edition' type='INTEGER' adaTypeName='Year_Number' description='a number indicating a release or base year'  default='1970' primaryKey='true'/>
                   ";

        a.each{
                |s|
                ss = censor( s )
                puts "                   <column name='#{ss}' description='#{s}' default='0' type='REAL' adaTypeName='Amount' />\n"
        }
        
        puts "                   <foreign-key foreignTable='forecast_variant'  onDelete='CASCADE'  onUpdate='CASCADE'>
                           <reference foreign='rec_type' local='rec_type' />
                           <reference foreign='variant' local='variant' />
                           <reference foreign='country' local='country' />
                           <reference foreign='edition' local='edition' />
                   </foreign-key> 
            </table>
"
        
end


wales = 
['1 person ',
'2 person (No children) ',
'2 person (1 adult, 1 child) ',
'3 person (No children) ',
'3 person (2 adults, 1 child) ',
'3 person (1 adult, 2 children) ',
'4 person (No children) ',
'4 person (2+ adults, 1+ children) ',
'4 person (1 adult, 3 children) ',
'5+ person (No children) ',
'5+ person (2+ adults, 1+ children) ',
'5+ person (1 adult, 4+ children) '];

puts "WALES\n"
cens( "wales", wales )

nireland = [
'One adult households',
'Two adults without children',
'Other households without children',
'One adult households with children',
'Other households with children'
]

puts "NIREL\n"
cens( "nireland", nireland )

england = [
'One person households: Male',
'One person households: Female',
'One family and no others: Couple: No dependent children',
'A couple and one or more other adults: No dependent children',
'Households with one dependent child',
'Households with two dependent children',
'Households with three dependent children' ]

puts "ENGLA\n"
cens( "england", england )


