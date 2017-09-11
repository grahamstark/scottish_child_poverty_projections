#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'narray'
require 'set'

DATA_PATH="/home/graham_s/VirtualWorlds/projects/scottish_child_poverty_projections/docs/"

def toCSV( filename )
        f = File.new( filename, 'rb' );
        lines = CSV.parse( f )
        f.close()
        return lines
end

lines = toCSV( "#{DATA_PATH}/nrs/pp-2014-based-add-var-euro-zeroumig-scotland-syoa-1.tab" );

p lines