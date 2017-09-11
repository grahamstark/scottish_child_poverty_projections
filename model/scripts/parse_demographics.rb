#!/usr/bin/ruby
#

def parsePopulationBlock( data_arr, type, label )
	rowNum = 0;
	puts "opened #{filename}" ;
	
		|row|
		rowNum+=1;
		numCols = row.length - 1;
		if( rowNum == 8 )then ## parse top line into an array of variable names
                        (1 .. numCols).each{
                                |colNum|
                                varname = row[colNum].data;
                                en = "#{filename}_#{varname}"
                                enumName = stringToEnum( en ).downcase()
                                $enumeratedTypes << enumName;
                        }
		elsif( rowNum > 8 )then
                        laname = row[0].data;
                        if( laname =~ /ualad09:(.*)/ )then # we only want district ones, so we match the DWP data
                                laname = $1.gsub(/[`’']/, "");
                                if( $las.has_key?( laname ))then
                                        (1 .. numCols).each{
                                                |colNum|
                                                count = cleanupRealNumberToAda( row[colNum].data )
                                                $las[laname].data << count.gsub( /_/, '' );
                                        }
                                else
                                        $unmatched[ laname ] = laname
                                        puts "Unmatched #{laname}"
                                end
                        end
                end
	}
end

def parseDemographicFile( filename )
        file = File.open( DATA_PATH+filename+".tab", 'rb' );
        lines = CSV::Reader.parse( file, ',' );
        label = lines[0]
        years = lines[2][2,-1]
end
	