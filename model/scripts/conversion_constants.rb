# UKDS_DATA_DIR="/home/graham_s/VirtualWorlds/projects/southampton/model/scripts/mill_data/"
UKDS_DATA_DIR="/mnt/data/"

class WASNameEdit
        
        def edit( name )
                name = basicCensor( name )
                if ( name =~ /personw[1-3]/i ) or ( name =~ /casew[1-3]/i )then
                        return name
                elsif( name =~ /(.*)w[1-3](.*)/i) 
                        return $1+$2                        
                end
                return name
        end
        
end

class BlankEdit 
        def edit( name )
                return basicCensor( name )
        end
end