#!/usr/bin/ruby
require 'rexml/document'
require 'rexml/element'
require 'rexml/xpath'
# require 'dbi'
require 'sequel'
require 'csv'
require 'ukds_schema_utils'
require 'utils'
load './conversion_constants.rb'

include REXML

def loadVariableTargets( dataset )
        targets = {}
        filename = '#{datasets}_targets.txt'
        regexp = []
        if File.exist?( filename) then
                open( filename ).each do |line|
                        regexps << line         
                end
                f.close()
        end
        targets = Regexp.new( regexps.join( "|" ))
        return targets
end

def recordNameFromTableName( tableName )
        name = tableName.downcase
        return "Account" if( name == 'accounts' )
        return "Adult" if( name == 'adult' )
        return "Admin" if( name == 'admin' )
        return "Asset" if( name == 'assets' )
        return "Benefit" if( name == 'benefits' )
        return "Benunit" if( name == 'benunit' )
        return "Care" if( name == 'care' )
        return "Child" if( name == 'child' )
        return "Endowment" if( name == 'endowmnt' )
        return "ExtChild" if( name == 'extchild' )
        return "GovPay" if( name == 'govpay' )
        return "Household" if( name == 'househol' )
        return "Insurance" if( name == 'insuranc' )
        return "Job" if( name == 'job' )
        return "Maint" if( name == 'maint' )
        return "MortCont" if( name == 'mortcont' )
        return "Mortgage" if( name == 'mortgage' )
        return "OddJob" if( name == 'oddjob' )
        return "Owner" if( name == 'owner' )
        return "PenProv" if( name == 'penprov' )
        return "PenAmt" if( name == 'penamt' )
        return "Pension" if( name == 'pension' )
        return "RentCont" if( name == 'rentcont' )
        return "Renter" if( name == 'renter' )
        return "Vehicle" if ( name == 'vehicle' )
        return "ChildCare" if ( name == 'chldcare' )
        return tableName.capitalize;
end  


def makePKCol( name )
        column = REXML::Element.new( "column" )
        column.add_attribute( 'name', name )
        column.add_attribute( 'type', "INTEGER" );
        column.add_attribute( 'default', 0 );
        column.add_attribute( 'primaryKey', 'true' );
        return column;
end

def makeFKRef( target )
        fk = REXML::Element.new( "reference" )
        fk.add_attribute( "foreign", target )
        fk.add_attribute( "local", target );
        return fk
end

def makeUniqueIndex( names )
        ui = REXML::Element.new( "unique" )
        [ "year", "user_id", "edition" ].each{
                |name|
                uc = REXML::Element.new( "unique-column" )
                uc.add_attribute( 'name', name );
                ui << uc
        }
        names.each{
                |name|
                uc = REXML::Element.new( "unique-column" )
                uc.add_attribute( 'name', name );
                ui << uc
        }
        return ui
end



def makeIndex( names )
        ui = REXML::Element.new( "index" )
        names.each{
                |name|
                uc = REXML::Element.new( "index-column" )
                uc.add_attribute( 'name', name );
                ui << uc
        }
        return ui
end

        
def makeFK( target, dataset )
        fk = REXML::Element.new( "foreign-key" )
        fk.add_attribute( 'foreignTable', "#{target}" );        
        fk << makeFKRef( "year")
        fk << makeFKRef( "user_id")
        fk << makeFKRef( "edition")
        case dataset 
        when 'frs' then
                fk << makeFKRef( "sernum")
                if( target == 'adult' or target == 'benunit' )then
                        fk << makeFKRef( "benunit" )
                end
                if( target == 'adult' )then     
                        fk << makeFKRef( "person" )
                end
        when 'was'
                if( target == 'hhold' )then
                        fk << makeFKRef( "combined_case" )
                end
        end
        return fk
end

def getTypeDeclarations( tableName, var )
        #
        # FIXME we shouldn't need the query here
        #
        return {'ada'=>'Ada.Calendar.Time', 'sql'=>'Date' } if var.data_type == DATE
        return { 'ada'=>'Sernum_Value', 'sql'=> 'INTEGER', 'default'=> '0' } if( var.name == 'SERNUM' ) or (var.name == 'pserial')
        varname = var.name
        varname = KEYWORD_TRANSLATIONS_REVERSE[ var.name ] if KEYWORD_TRANSLATIONS_REVERSE.has_key?( var.name )
        typeStmt = "select max( data_type ) as mtype from dictionaries.variables where tables='#{tableName}' and name='#{varname}'";
        # print "typeStmt #{typeStmt}\n"
        data_type = var.data_type
        CONNECTION.fetch( typeStmt ).each{
                |eres|
                data_type = eres[:mtype].to_i()               
        }
        print "#{var.name} type is #{data_type} "
        typedefs = {'ada'=> '', 'sql'=> 'INTEGER', 'default'=> '0'}
        case data_type
        when DATE
                typedefs = { 'ada'=>'Time', 'sql'=>'Date' } # FIXME Posgres only?
        when SERNUM 
                typedefs = { 'ada'=>'Sernum_Value', 'sql'=>'BIGINT' } # FIXME Posgres only?
        when STRING 
                typedefs =  {'ada'=> '', 'sql'=> 'CHAR', 'default'=> "''" }
        when AMOUNT 
                typedefs =  {'ada'=> 'Amount', 'sql'=> 'REAL', 'default'=> '0.0'}
        when DECIMAL
                typedefs =  {'ada'=> '', 'sql'=> 'DECIMAL', 'default'=> '0.0'}
        when ENUM 
                typedefs =  {'ada'=> '', 'sql'=> 'INTEGER', 'default'=> '0' } # FIXME
        when INT
                typedefs =  {'ada'=> '', 'sql'=> 'INTEGER', 'default'=> '0'}
        end 
        print "typedefs #{typedefs}\n"
        return typedefs 
end


def createMillTableFRS( tableData )
        tableName = tableData.tableName.downcase()
        tableElem = REXML::Element.new( 'table' );
        tableElem.add_attribute( 'name', tableName );
        tableElem.add_attribute( 'description', tableName )
        ourVariables = getExtraFieldsForTable( 'frs', tableName, true )
        ourVariables.each{
                |var|                
                puts "needs a counter\n"
                tableElem << makePKCol( var )                
        }
        hasADFK = false  
        hasBUFK = false
        tableData.variableNames.each{
                |vname|
                var = tableData.variables[vname]
                column = REXML::Element.new( "column" )
                column.add_attribute( "description", var.label )

                types = getTypeDeclarations( tableName, var )
                column.add_attribute( 'type', types['sql'] );
                if( types['sql'] == 'DECIMAL' )then
                        column.add_attribute( 'length', "10" ) 
                        column.add_attribute( 'prec', "1" ) 
                end
                column.add_attribute( 'adaTypeName', types['ada'] ) if( types['ada'] != '' )
                column.add_attribute( 'default', types['default'] ) if( types['default'] != '' )
                
                vcu = vname.upcase()
                isPK = ( vcu == 'SERNUM' or 
                       vcu == 'BENUNIT' or 
                       vcu == 'PERSON' or
                       # vcu == 'ISSUE' or 
                       vcu == 'VHSEEQ' or 
                       vcu == 'VEHSEQ' or 
                       vcu == 'RENTSEQ' or
                       vcu == 'PENSEQ' or
                       vcu == 'PROVSEQ' or
                       vcu == 'BENEFIT' or
                       # (tableData.tableName == 'OWNER' and vcu == 'ISSUE' ) or
                       (tableData.tableName == 'assets' and vcu == 'ASSETYPE' ) or                       
                       vcu == 'ODDSEQ' or 
                       vcu == 'MORTSEQ' or 
                       vcu == 'CONTSEQ' or 
                       vcu == 'MAINTSEQ' or
                       vcu == 'JOBTYPE' or
                       vcu == 'EXTSEQ' or
                       vcu == 'MORTSEQ' or
                       vcu == 'ENDOWSEQ' or 
                       vcu == 'SEQ' or
                       vcu == 'INSSEQ' or
                       vcu == 'ACCOUNT' or
                       vcu == 'CHLOOK' or
                       (( tableData.tableName == 'transact') and ( vcu == 'ROWID' )) or
                       (( tableData.tableName == 'vehicle' ) and ( vcu == 'VEHSEQ' )) or
                       (( tableData.tableName == 'nimigr' ) and ( vcu == 'MIPER' )));
               
                if( isPK )
                        column.add_attribute( 'primaryKey', 'true' );
                end
                # column.add_attribute( 'default', default );
                column.add_attribute( 'name', vname.downcase() )
                tableElem << column
                if( vcu == 'BENUNIT' ) and (( tableName != 'benunit' ) and ( tableName != 'hbai' ) and ( tableName != 'nimigra' ) and ( tableName != 'pianon0910' ))then
                        hasBUFK = true
                end
                if( vcu == 'PERSON' and 
                        ( tableName != 'adult' and tableName != 'child' and 
                                tableName != 'prscrptn' and tableName != 'benefits' and 
                                tableName != 'chldcare' and tableName != 'hbai' ))then
                        # prscrptn, chldcare and benefits since 'person' 
                        # field can point to either adult or child records so a PK isn't really possible  
                        hasADFK = true                
                end
        }
        if( tableName != 'househol')then
                tableElem << makeFK( 'househol', 'frs' )
        end
        if hasBUFK then
                tableElem << makeFK( 'benunit', 'frs' )
        end
        if hasADFK then
                tableElem << makeFK( 'adult', 'frs' )
        end
        return tableElem
end

def createMillTable( tableData, dataset, crm )
        tableName = tableData.tableName.downcase()
        tableElem = REXML::Element.new( 'table' );
        tableElem.add_attribute( 'name', tableName );
        tableElem.add_attribute( 'description', tableName )
        ourVariables = getExtraFieldsForTable( dataset, tableName, true )
        ourVariables.each{
                |var|
                # FIXME need to add adaType for userid here !! hack it.. adaType = 
                tableElem << makePKCol( var )                
        }
        puts "tableName #{tableName}\n"
        colsAdded = 0
        tableData.variableNames.each{
                |variableName|
                next if not crm.matches( variableName )
                var = tableData.variables[ variableName ]
                vcu = variableName.upcase()
                case dataset
                when 'hse'
                        isPK =  vcu == 'PSERIAL'
                when 'elsa'
                        isPK = false
                        if vcu == 'IDAUNIQ' or vcu == 'WPPENN' then # pension counter variable in pension_grid
                                isPK = true
                        elsif tableName == 'pension_grid' then
                                isPK = ( vcu == 'PENNUM' ) # FIXME this needs all the potential keys pension, pensno.. fixed different names in 06/08
                        elsif tableName == 'mortgage_grid' then                                
                                isPK = ((vcu =~ /IDAHHW.*/) or (vcu == 'MID'))
                        end
                else
                        isPK = false
                end
                column = REXML::Element.new( "column" )
                column.add_attribute( 'name', variableName.downcase() )
                column.add_attribute( "description", var.label )
                types = getTypeDeclarations( tableName, var )
                column.add_attribute( 'type', types['sql'] );
                if types['sql'] == 'DECIMAL' then
                        column.add_attribute( 'size', "10" ) 
                        column.add_attribute( 'scale', "1" ) 
                elsif types['sql'] == 'CHAR' then
                        column.add_attribute( 'size', "100" )       # arbitrary number since we use 'text'  
                end
                column.add_attribute( 'adaTypeName', types['ada'] ) if( types['ada'] != '' )
                column.add_attribute( 'default', types['default'] ) if( types['default'] != '' )
                if( isPK )
                        column.add_attribute( 'primaryKey', 'true' );
                end
                tableElem << column
                colsAdded += 1
        }
        if colsAdded > 1000 then
                puts "**** WARNING table #{tableName} has over 1000 columns (#{colsAdded}); SQL creation probably won't work"
        end
        case dataset
        when 'hse'
                tableElem << makeIndex( [ 'hserial'] ) 
                tableElem << makeUniqueIndex( ['hserial', 'persno']) 
        when 'was'
                if( tableName == 'person')
                        tableElem << makeIndex( [ 'personw2'] ) 
                        tableElem << makeIndex( [ 'personw1'] )
                        # tableElem << makeFK( 'hhold', 'was' ) FIXME!! hhold 
                end
                tableElem << makeIndex( [ 'casew1'] ) 
                tableElem << makeIndex( [ 'casew2'] ) 
        else
               isPK = false
        end
        
        return tableElem
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

def createOneDatabase( millDoc, dataset )
        targetDir = "../database/#{dataset}"
        mkdirSafe( targetDir )
        mkdirSafe( targetDir+"/sql/" )
        mkdirSafe( targetDir+"/xml/" );
        loadStatementsFile = File.open( "#{targetDir}/sql/postgres_load_statements.sql", "w")
        loadStatementsFile.write( "SET datestyle='MDY';\n")
        connection  = getConnection()
        stmt = "select distinct priority,year,name from dictionaries.tables where dataset='#{dataset}' order by priority asc, name, year desc"
        tables = Hash.new
        tableNames = Array.new
        connection.fetch( stmt ).each{
                |res|
                year = res[:year]
                tableName = res[:name ]
                next if( dataset == 'elsa' and tableName == 'life_history_data')
                recordName = recordNameFromTableName( tableName )
                table = loadTable( dataset, year, tableName )
                crm = getCRM( targetDir, tableName )
                loadStatement = makePostgresLoadStatement("#{UKDS_DATA_DIR}/#{dataset}/", dataset, table, crm )+"\n"
                loadStatementsFile.write( loadStatement )
                puts "on table #{tableName} year #{year}"
                tableNames << tableName
                if( tables.has_key?( tableName )) then
                        tables[ tableName ] = mergeTables( table, tables[ tableName ])
                else
                        tables[ tableName ] = table;
                end
                
        }
        schema = REXML::Element.new( 'schema' )
        schema.add_attribute( "name", dataset );
        tableNames.uniq.each{
                |tableName|
                table = tables[ tableName ]
                crm = getCRM( targetDir, tableName )
                case dataset 
                        when 'frs'
                                schema << createMillTableFRS( table )
                        else
                                schema << createMillTable( table, dataset, crm )
                end
        }
        
        connection.disconnect()
        loadStatementsFile.close()
        return schema
end

def addPackage( name )
        dpackage = REXML::Element.new( 'adaTypePackage' )
        dpackage.add_attribute( "name", name )
        return dpackage
end

millDoc = REXML::Document.new();
millDTD = REXML::DocType.new('database PUBLIC "http://virtual-worlds.biz/Mill"  "http://www.virtual-worlds.biz/dtds/mill.dtd"');
millDoc << millDTD
millDatabase = REXML::Element.new( 'database' )
millDatabase.add_attribute( "name", "ukds" )
millDoc << millDatabase
millDatabase << addPackage( "Data_Constants" )
millDatabase << addPackage( "Base_Model_Types" )
millDatabase << addPackage( "Ada.Calendar" )
[ 'frs' ].each{ # 'frs', 'hse', , 'elsa'  
        |ds|
        millDatabase << createOneDatabase( millDatabase, ds )
}
xmlFile = File.open( "../database/xml/database-schema.xml", "w")
millDoc.write( xmlFile, 8 ) 
xmlFile.close()