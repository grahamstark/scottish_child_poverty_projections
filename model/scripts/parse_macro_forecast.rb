#!/usr/bin/ruby
require 'csv'
require 'utils'
require 'sequel'
require './forecast_libs'

def readMacro( lines, startCol, startKey, out )
        
        return out     
end

out = {:pos=>0,:data=>{}, :label=>'', :years=>[], :keys=>[] }
source = 'obr'
['gdp_per_capita','prices','employment'].each{
        |which|
        fullFName = "#{DATA_PATH}/#{source}/obr_forecast_#{which}.tab"
        puts fullFName;
        

}