IMPORT $;
IMPORT VISUALIZER;

FireDepartmentDB := $.FireDepartmentDB;

SORT(FireDepartmentDB.fireDepartmentCountyDS, -cnt);
SORT(FireDepartmentDB.fireDepartmentCountyDS, -cnt);

// StateGDPLayout := RECORD
//     INTEGER GeoFips;
//     STRING Geoname;
//     DECIMAL Q1;
//     DECIMAL Q2;
//     DECIMAL Q3;
//     DECIMAL Q4;
// END;

// StateGDP := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayout, CSV(HEADING(1)));
// OUTPUT(StateGDP, NAMED('StateGDP'));

OUTPUT(FireDepartmentDB.fireDepartmentStateDS,, '~HMK::OUT::3001', NAMED('FireState'),OVERWRITE);
VISUALIZER.Choropleth.USStates('FireChloropleth1',, 'FireState',,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

OUTPUT(FireDepartmentDB.fireDepartmentCountyDS,, '~HMK::OUT::3003', NAMED('FireFips'),OVERWRITE);
VISUALIZER.Choropleth.USCounties('FireChloropleth3',, 'FireFips',,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));
