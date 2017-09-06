#!/usr/bin/ruby
require 'dbi'
# require 'csv'
require 'ukds_schema_utils'
require 'utils'
load 'conversion_constants.rb'
#
# this file makes cleaned-up versions of ukds tab-delimited datasets
# with any needed extra key fields inserted
# FIXME use CSV to reconstruct the files so commas in strings are handled correctly
#
def getCRM( targetDir, tableName )
        crm = CRM114.new()
        targetList = "#{targetDir}/etc/#{tableName}_target_list.txt"
        puts "getCRM; opening |#{targetList}|\n"
        if File.exists?( targetList ) then
                crm.fromFile( targetList )
                puts "read from targetList |#{targetList}| ok"
        else
                crm.fromFile( targetList )
                puts "failed to open |#{targetList}|"
        end
        return crm
end

def remakeLines( inf, outf, dataset, table, year )
        targetDir = "#{dataset}_"
        crm = getCRM( targetDir, table.tableName )
        p = 0
        # variableVarTargets = table.getVariableNames( crm )
        # positions = table.getPositions( variableTargets );
        start = "1,1,#{year},"
        inf.each{
                |line|
                line.gsub!( /\t/, "," )
                line.gsub!( / /, "" )
                if( p == 0 )then
                        line = makeCensoredVarList( line )
                        # postgres doesn't allow header lines when reading tab
                        if( dataset == 'was' )then
                                if table.tableName == 'person' then
                                        outf.write( "user_id,edition,year,combined_case,combined_person," )
                                else
                                        outf.write( "user_id,edition,year,combined_case," )
                                end
                        else
                                outf.write( "user_id,edition,year," )
                        end;
                        outf.write( line +"\n")
                else
                        outf.write( start )
                        if( dataset == 'was' )then
                                if table.tableName == 'person' then
                                        outf.write( "#{p},#{p}," ) # these are temp values; fill in in SQL
                                else
                                        outf.write( "#{p}," )
                                end
                        end;
                        line = fixupVariableLine( line, table )
                        outf.write( line + "\n" )
                end
                p += 1
        }
       
end 

def remakeLinesV2( inf, outf, dataset, table, year, crm, editor = nil )
        #  FIXME complete mess: we need to parse the line into tokens at the start, apply the editor, apply the crm field by field
        # and write out;
        p = 0
        start = "1,1,#{year},"
        positionsToKeep = []
        inf.each{
                |line|
                line = line.gsub( /\t/, "," ).gsub( / /, "" )
                if( p == 0 )then
                        puts "censoring this line |#{line}\n"
                        line = makeCensoredVarList( line )
                        puts "converted to |#{line}|"
                        # postgres doesn't allow header lines when reading tab
                        if( dataset == 'was' )then
                                if table.tableName == 'person' then
                                        line = "combined_case,combined_person," + line
                                else
                                        line = "combined_case," + line
                                end
                        end;
                        line = "user_id,edition,year," + line
                        positionsToKeep = crm.getPositions( CSV.parse_line( line ))
                        puts "positions #{positionsToKeep}\n"
                        editedLine = editDelimitedLine( line, positionsToKeep )
                        outf.write( editedLine +"\n" );
                else
                        line = fixupVariableLine( line, table )
                        if( dataset == 'was' )then
                                if table.tableName == 'person' then
                                        line = "#{start}#{p},#{p},#{line}" # these are temp values; fill in in SQL
                                else
                                        line = "#{start}#{p},#{line}"
                                end
                        else
                                line = "#{start}#{line}"        
                        end;
                        outf.write( editDelimitedLine( line, positionsToKeep )+"\n" );
                end
                p += 1
        }
       
end 

def getCRM( targetDir, tableName )
        crm = CRM114.new()
        targetList = "#{targetDir}/etc/#{tableName}_target_list.txt"
        puts "getCRM; opening |#{targetList}|\n"
        if File.exists?( targetList ) then
                crm.fromFile( targetList )
                puts "read from targetList |#{targetList}| ok"
        else
                puts "failed to open |#{targetList}|"
        end
        return crm
end

def sameArray( a1, a2 )
        n1 = a1.length;
        n2 = a2.length;
        # puts "last #{a1.join( '|' )} now #{a2.join( '|' )}\n"                        
        return false if( n1 != n2 )
        n1.times{
                |i|
                return false if( a1[i] != a2[i] )
        }
        return true
end

def remakeLinesWithCounter( inf, outf, year, table, keyFields )
        lineNumber = 0
        numKeyFields = keyFields.length
        lastValues = []
        values = []
        positions = []
        numElements = 0
        start = [ 1, 1, year ]
        counter = 1                
        inf.each{
                |line|
                line = line.gsub( /\t/, "," ).gsub( / /, '' ).downcase()
                # puts line
                if lineNumber > 0 then # FIXME horrible hack
                        line = fixupVariableLine( line, table )
                end
                elements = line.split( "," )
                if( lineNumber == 0 )then
                        line = makeCensoredVarList( line )
                        outf.write( "user_id,edition,year,counter," )
                        numElements = elements.length
                        numElements.times(){
                                |kp|
                                keyFields.each{
                                        |kf|
                                        if( elements[kp] == kf )then
                                                positions << kp                
                                        end 
                                }
                        }
                        outf.write( line + "\n" )
                        puts "keyfields #{keyFields.join('|')} positions #{positions.join('|')}\n"
                        puts "elements #{elements}\n"
                else
                        numKeyFields.times{
                                |keyNumber|
                                pp = positions[keyNumber]
                                puts "remakeLinesWithCounter; keyFields #{keyFields} |#{keyNumber}|; pp |#{pp}|\n"                                
                                v = elements[pp].to_i
                                values[pp] = v
                        }
                        if sameArray( lastValues, values )then
                                counter += 1 
                        else
                                counter = 1
                        end
                        
                        lastValues = values.clone()
                        start[3] = counter
                        outf.write( start.join( "," ) + "," )
                        outf.write( line  +"\n")
                        
                end
                lineNumber += 1
        }       
end

def parseFRSDataset( )
        dataset = 'frs'
        connection  = getConnection()
        stmt = "select distinct dataset,year,name from dictionaries.tables where dataset='#{dataset}' order by year,name"
        rs = connection.execute( stmt )
        rs.fetch_hash{
                |res|
                year = res['year'].to_i
                puts "on year #{year} year #{year}"
                tableName = res['name'].downcase()
                table = loadTable( dataset, year, tableName )
                dataPath = "#{UKDS_DATA_DIR}/#{dataset}/"
                infileName = "#{dataPath}#{year}/tab/#{table.tableName}.tab" 
                outfilePath = "#{UKDS_DATA_DIR}/#{dataset}/#{year}/postgres_load_files/"
                mkdirSafe( outfilePath )
                outfileName = "#{outfilePath}#{tableName}.csv"         
                inf = File.open( infileName, "rb")
                outf = File.open( outfileName, "w")        
                puts "opening #{infileName} and writing to #{outfileName}\n"
                crm = getCRM( "mill_data/#{dataset}", tableName )
                if FRS_TABLES_THAT_NEED_COUNTERS.include?( tableName )then
                        case tableName                     
                        when 'care'
                                keyFields = ['sernum', 'benunit' ]
                        when 'nimigr', 'owner'
                                keyFields = ['sernum' ]
                        else
                                keyFields = ['sernum', 'benunit', 'person' ]
                        end
                        remakeLinesWithCounter( inf, outf, year, table, keyFields )
                else
                        remakeLines( inf, outf, 'frs', table, year )
                end
                inf.close()
                outf.close()
        }
end

def parseELSADataset()
        namemap = {
                "wave_4_pension_grid.tab"=> "wave_4_pension_grid_v1.tab",
                "wave_1_core_data.tab"=> "wave_1_core_data_v3.tab",
                "wave_2_core_data.tab"=> "wave_2_core_data_v3.tab",
                "wave_2_pension_grid.tab"=> "wave_2_pension_grid_v3.tab",
                "wave_3_pension_grid.tab"=> "wave_3_pension_grid_v3.tab",
                "wave_4_elsa_data.tab"=> "wave_4_elsa_data_v3.tab",
                "wave_5_elsa_data.tab"=> "wave_5_elsa_data_v3.tab",
                "index_file_wave_0-wave_5.tab"=> "index_file_wave_0-wave_5_v2.tab",
                "wave_0_common_variables.tab"=> "wave_0_common_variables_v2.tab",
                "wave_1_pension_wealth.tab"=> "wave_1_pension_wealth_v2.tab",
                "wave_2_nurse_data.tab"=> "wave_2_nurse_data_v2.tab",
                "wave_5_pension_grid.tab"=> "wave_5_pension_grid_v2.tab",
                "wave_3_elsa_data.tab"=> "wave_3_elsa_data_v4.tab" }

        dataset = 'elsa'
        connection  = getConnection()
        stmt = "select distinct dataset,year,name from dictionaries.tables where dataset='#{dataset}'"
        rs = connection.execute( stmt )
        rs.fetch_hash{
                |res|
                year = res['year'].to_i
                puts "on year #{year}"
                tableName = res['name'].downcase()
                if tableName == 'elsa_data'  then
                        next if tableName == 'life_history_data' ## too big to handle for now
                        dataPath = "#{UKDS_DATA_DIR}#{dataset}/"
                        
                        case year
                        when 2002 then wave = '1'
                        when 2004 then wave = '2'
                        when 2006 then wave = '3'
                        when 2008 then wave = '4'
                        when 2010 then wave = '5'
                        when 2012 then wave = '6'
                        end
                        table = loadTable( dataset, year, tableName )
                        infileName = "wave_#{wave}_#{tableName}.tab"
                        infileName = namemap[infileName] if namemap.has_key?( infileName )
                        infileName = "#{dataPath}/tab/#{infileName}"
                        puts "on file #{infileName}"
                        mkdirSafe( "#{dataPath}#{year}" )
                        mkdirSafe( "#{dataPath}#{year}/postgres_load_files/" )
                        outfileName = "#{dataPath}#{year}/postgres_load_files/#{tableName}.csv"         
                        inf = File.open( infileName, "rb")
                        outf = File.open( outfileName, "w")        
                        crm = getCRM( "mill_data/#{dataset}", tableName )
                        puts "opening #{infileName} and writing to #{outfileName}\n"
                        remakeLinesV2( inf, outf, dataset, table, year, crm )
                        inf.close()
                        outf.close()
                end
        }
end

def parseHSEDataset()
        dataset = 'hse'
        connection  = getConnection()
        stmt = "select distinct dataset,year,name from dictionaries.tables where dataset='#{dataset}'"
        rs = connection.execute( stmt )
        rs.fetch_hash{
                |res|
                year = res['year'].to_i
                puts "on year #{year}"
                tableName = res['name'].downcase()
                table = loadTable( dataset, year, tableName )
                dataPath = "#{UKDS_DATA_DIR}#{dataset}/"
                infileName = "#{tableName[0..2]}#{year}#{tableName[3..6]}.tab"
                infileName = "#{dataPath}/tab/#{infileName}"
                puts "on file #{infileName}"
                mkdirSafe( "#{dataPath}#{year}" )
                mkdirSafe( "#{dataPath}#{year}/postgres_load_files/" )
                outfileName = "#{dataPath}#{year}/postgres_load_files/#{tableName}.csv"         
                inf = File.open( infileName, "rb" )
                outf = File.open( outfileName, "w")        
                puts "opening #{infileName} and writing to #{outfileName}\n"
                crm = getCRM( "mill_data/#{dataset}", tableName )
                remakeLinesV2( inf, outf, dataset, table, year, crm )
                inf.close()
                outf.close()
        }
end

def parseWASDataset()
        dataset = 'was'
        connection  = getConnection()
        stmt = "select distinct dataset,year,name from dictionaries.tables where dataset='#{dataset}'"
        rs = connection.execute( stmt )
        rs.fetch_hash{
                |res|
                year = res['year'].to_i
                case year
                when 2006 then wave='1'
                when 2008 then wave='2'
                when 2010 then wave='3'
                end
                puts "on year #{year}"
                tableName = res['name'].downcase()
                # if( year == 2010 and tableName = 'hhold')then
                        table = loadTable( dataset, year, tableName )
                        dataPath = "#{UKDS_DATA_DIR}#{dataset}/"
                        infileName = "was_wave_#{wave}_#{tableName}_eul.tab"
                        infileName = "#{dataPath}/tab/#{infileName}"
                        puts "on file #{infileName}"
                        mkdirSafe( "#{dataPath}#{year}" )
                        mkdirSafe( "#{dataPath}#{year}/postgres_load_files/" )
                        outfileName = "#{dataPath}#{year}/postgres_load_files/#{tableName}.csv.new"         
                        inf = File.open( infileName, "rb")
                        outf = File.open( outfileName, "w")        
                        puts "opening #{infileName} and writing to #{outfileName}\n"
                        targetDir = "../database/#{dataset}"
                        crm = getCRM( targetDir, tableName )
                        remakeLinesV2( inf, outf, dataset, table, year, crm )
                        inf.close()
                        outf.close()
                # end
        }
end

# parseHSEDataset()
# parseELSADataset()
# parseWASDataset()
parseFRSDataset()
