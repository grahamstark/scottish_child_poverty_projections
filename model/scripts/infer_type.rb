require "ukds_schema_utils"
load "conversion_constants.rb"

todo = [ "frs"] ### elsa","was", "hse", "frs" ] # "frs", "hse", "elsa", "hse", "frs", "was"

blankEdit = BlankEdit.new()

if todo.include?( "hse" )then
        dataset = "hse"
        year = 2012
        filename = "#{UKDS_DATA_DIR}hse/tab/hse2012ah.tab"
        tablename = "hseah"
        inferDataTypes( dataset, year, filename, tablename, true, blankEdit )
        filename = "#{UKDS_DATA_DIR}hse/tab/hse2012ai.tab"
        tablename = "hseai"
        inferDataTypes( dataset, year, filename, tablename, true, blankEdit )
end
if todo.include?( "frs" )then
        dataset = "frs"
        (2013..2013).each{ # earlier years already done
                |year|
                targetdir = "#{UKDS_DATA_DIR}/frs/#{year}/tab/"
                puts "dataset #{dataset}, year #{year}, targetdir #{targetdir}\n";
                Dir["#{targetdir}/*.tab"].each{
                        |filename|
                        puts "#{dataset} on file #{filename}"
                        tablename =  File.basename( filename, ".tab")
                        inferDataTypes( dataset, year, filename, tablename, false, blankEdit )
                }
                year += 1
        }
        
end

updateVarGroup( DATE, "frs", "transact", "penamtdt" );

if todo.include?( "was" )then
        # DO Was manually
        wasEdit = WASNameEdit.new()
        wasfiles = "#{UKDS_DATA_DIR}was/tab/"
        dataset = "was"
        year = 2006
        filename=wasfiles+"was_wave_1_hhold_eul.tab"
        tablename="hhold"
        inferDataTypes( dataset, year, filename, tablename, false, wasEdit )
        filename=wasfiles+"was_wave_1_person_eul.tab"
        tablename="person"
        inferDataTypes( dataset, year, filename, tablename, false, wasEdit )
        year = 2008
        filename=wasfiles+"was_wave_2_hhold_eul.tab"
        tablename="hhold"
        inferDataTypes( dataset, year, filename, tablename, false, wasEdit )
        filename=wasfiles+"was_wave_2_person_eul.tab"
        tablename="person"
        inferDataTypes( dataset, year, filename, tablename, false, wasEdit )
        year = 2010
        filename=wasfiles+"was_wave_3_hhold_eul.tab"
        tablename="hhold"
        inferDataTypes( dataset, year, filename, tablename, false, wasEdit )
        filename=wasfiles+"was_wave_3_person_eul.tab"
        tablename="person"
        inferDataTypes( dataset, year, filename, tablename, false, wasEdit )
        updateVarGroup( STRING, "was", "person", "sic%" );
end


#
# hacked version of above for elsa; we need a year in the db so map wave 1 to 2002 and so on
#
if todo.include?( "elsa" )then
        dataset = "elsa"
        targetdir = "#{UKDS_DATA_DIR}elsa/tab/"
        Dir["#{targetdir}/*.tab"].each{
                |filename|
                if( filename =~ /#{targetdir}\/wave_(.?)_(.*)\.tab/)then
                        tablename = $2
                        wave = $1.to_i()
                        if( wave > 0 )then
                                year = 2000 + (wave*2)
                                if tablename =~ /(.*)_v[0-9]/i then
                                        tablename = $1
                                end
                                puts "Parsing file=#{filename} table=#{tablename} year=#{year}"
                                begin
                                        inferDataTypes( dataset, year, filename, tablename, false, blankEdit )
                                rescue  Exception=>e
                                        puts "ERROR PARSING #{filename}"
                                        puts e.message  
                                        puts e.backtrace.inspect         
                                end
                        end
                end
                
        }
end
