#!/bin/sh
# individual years forecast, zero eu migration, scotland only
./parse_forecast_files.rb  pp-2014-based-add-var-euro-zeroeumig-scotland-syoa-1.tab zeroeu SCO 2014 NRS
./parse_forecast_files.rb  pp-2014-based-add-var-euro-150percenteumig-scotland-syoa.tab eu-150pc SCO 2014 NRS
./parse_forecast_files.rb  pp-2014-based-add-var-euro-50percenteumig-scotland-syoa.tab eu-50pc SCO 2014 NRS
./parse_forecast_files.rb  14-pop-proj-scotland-syoa.tab baseline  SCO 2014 NRS

