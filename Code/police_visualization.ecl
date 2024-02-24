IMPORT $;
IMPORT VISUALIZER;

PoliceDB := $.PoliceDB;

SORT(PoliceDB.policeStateDS, -cnt);
SORT(PoliceDB.policeFipDS, -cnt);
SORT(PoliceDB.policeCountyDS, -cnt);

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

OUTPUT(PoliceDB.policeStateDS,, '~HMK::OUT::2001', NAMED('PoliceState'),OVERWRITE);
VISUALIZER.Choropleth.USStates('PoliceChloropleth1',, 'PoliceState',,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

OUTPUT(PoliceDB.policeFipDS,, '~HMK::OUT::2003', NAMED('PoliceFips'),OVERWRITE);
VISUALIZER.Choropleth.USCounties('PoliceChloropleth3',, 'PoliceFips',,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));