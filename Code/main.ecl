IMPORT $;
IMPORT VISUALIZER;
IMPORT STD;

// HMK := $.File_AllData;
// STD.DataPatterns.Profile(,HMK.missingChildDS);


HospitalDB := $.HospitalDB;
FoodBankDB := $.FoodBankDB;
MissingChildrenDB := $.MissingChildrenDB;
PoliceDB := $.PoliceDB;
FireDepartmentDB := $.FireDepartmentDB;

SORT(FoodBankDB.foodBankStateDS, -cnt);

StateGDPLayout := RECORD
    INTEGER GeoFips;
    STRING GeoName;
    DECIMAL Q1;
    DECIMAL Q2;
    DECIMAL Q3;
    DECIMAL Q4;
END;

StateGDP := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayout, CSV(HEADING(1)));
OUTPUT(StateGDP, NAMED('StateGDP'));

OUTPUT(FoodBankDB.foodBankStateDS,, '~HMK::OUT::1010',  NAMED('FoodBanksState'), OVERWRITE);
VISUALIZER.Choropleth.USStates('FoodBankStateChoropleth',, 'FoodBanksState' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

OUTPUT(FoodBankDB.foodBankCountyDS,, '~HMK::OUT::1011', NAMED('FoodBanksCounty'), OVERWRITE);
VISUALIZER.Choropleth.USCounties('FoodBankCountyChoropleth',, 'FoodBanksCounty');

OUTPUT(HospitalDB.HospitalStateDS ,, '~HMK::OUT::1020',  NAMED('HospitalState'), OVERWRITE);
VISUALIZER.Choropleth.USStates('HospitalStateChoropleth',, 'HospitalState');

OUTPUT(HospitalDB.HospitalCountyDS,, '~HMK::OUT::1021', NAMED('HospitalCounty'), OVERWRITE);
VISUALIZER.Choropleth.USCounties('HospitalCountyChoropleth',, 'HospitalCounty');

OUTPUT(MissingChildrenDB.MCStateDS,, '~HMK::OUT::1030',  NAMED('MissingChildrenState'), OVERWRITE);
VISUALIZER.Choropleth.USStates('MissingChildrenStateChoropleth',, 'MissingChildrenState' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

OUTPUT(MissingChildrenDB.MCCountyDS,, '~HMK::OUT::1031', NAMED('MissingChildrenCounty'), OVERWRITE);
VISUALIZER.Choropleth.USCounties('MissingChildrenCountyChoropleth',, 'MissingChildrenCounty');

// OUTPUT(FoodBankDB.foodBankStateDS,, '~HMK::OUT::1010',  NAMED('FoodBanksState'), OVERWRITE);
// VISUALIZER.Choropleth.USStates('FoodBankStateChoropleth',, 'FoodBanksState');

// OUTPUT(FoodBankDB.foodBankCountyDS,, '~HMK::OUT::1011', NAMED('FoodBanksCounty'), OVERWRITE);
// VISUALIZER.Choropleth.USCounties('FoodBankCountyChoropleth',, 'FoodBanksCounty');

// OUTPUT(FoodBankDB.foodBankStateDS,, '~HMK::OUT::1010',  NAMED('FoodBanksState'), OVERWRITE);
// VISUALIZER.Choropleth.USStates('FoodBankStateChoropleth',, 'FoodBanksState');

// OUTPUT(FoodBankDB.foodBankCountyDS,, '~HMK::OUT::1011', NAMED('FoodBanksCounty'), OVERWRITE);
// VISUALIZER.Choropleth.USCounties('FoodBankCountyChoropleth',, 'FoodBanksCounty');

// OUTPUT(FoodBankDB.foodBankStateDS,, '~HMK::OUT::1010',  NAMED('FoodBanksState'), OVERWRITE);
// VISUALIZER.Choropleth.USStates('FoodBankStateChoropleth',, 'FoodBanksState');

// OUTPUT(FoodBankDB.foodBankCountyDS,, '~HMK::OUT::1011', NAMED('FoodBanksCounty'), OVERWRITE);
// VISUALIZER.Choropleth.USCounties('FoodBankCountyChoropleth',, 'FoodBanksCounty');
