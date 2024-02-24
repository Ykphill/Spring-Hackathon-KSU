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

StateGDP_Rusty := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayout, CSV(HEADING(1)));
StateGDP_Cleaned := JOIN(
    
)

StateGDPLayoutQ1 := RECORD
    StateGDP.GeoFips;
    // state := StateGDP.GeoName;
    StateGDP.Q1;
END;

StateGDPLayoutQ2 := RECORD
    StateGDP.GeoFips;
    // state := StateGDP.GeoName;
    StateGDP.Q2;
END;

StateGDPLayoutQ3 := RECORD
    StateGDP.GeoFips;
    // state := StateGDP.GeoName;
    StateGDP.Q3;
END;

StateGDPLayoutQ4 := RECORD
    StateGDP.GeoFips;
    // state := StateGDP.GeoName;
    StateGDP.Q4;
END;

STD.
OUTPUT(TABLE(StateGDP, StateGDPLayoutQ1),, '~HMK::OUT::1070', NAMED('StateGDPQ1'), OVERWRITE);
OUTPUT(TABLE(StateGDP, StateGDPLayoutQ2),, '~HMK::OUT::1071', NAMED('StateGDPQ2'), OVERWRITE);
OUTPUT(TABLE(StateGDP, StateGDPLayoutQ3),, '~HMK::OUT::1072', NAMED('StateGDPQ3'), OVERWRITE);
OUTPUT(TABLE(StateGDP, StateGDPLayoutQ4),, '~HMK::OUT::1073', NAMED('StateGDPQ4'), OVERWRITE);

VISUALIZER.Choropleth.USStates('StateGDPQ1_NAME',, 'StateGDPQ1' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));
VISUALIZER.Choropleth.USStates('StateGDPQ2_NAME',, 'StateGDPQ2' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));
VISUALIZER.Choropleth.USStates('StateGDPQ3_NAME',, 'StateGDPQ3' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));
VISUALIZER.Choropleth.USStates('StateGDPQ4_NAME',, 'StateGDPQ4' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

// OUTPUT(FoodBankDB.foodBankStateDS,, '~HMK::OUT::1010',  NAMED('FoodBanksState'), OVERWRITE);
// VISUALIZER.Choropleth.USStates('FoodBankStateChoropleth',, 'FoodBanksState' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

// OUTPUT(FoodBankDB.foodBankCountyDS,, '~HMK::OUT::1011', NAMED('FoodBanksCounty'), OVERWRITE);
// VISUALIZER.Choropleth.USCounties('FoodBankCountyChoropleth',, 'FoodBanksCounty');

// OUTPUT(HospitalDB.HospitalStateDS ,, '~HMK::OUT::1020',  NAMED('HospitalState'), OVERWRITE);
// VISUALIZER.Choropleth.USStates('HospitalStateChoropleth',, 'HospitalState');

// OUTPUT(HospitalDB.HospitalCountyDS,, '~HMK::OUT::1021', NAMED('HospitalCounty'), OVERWRITE);
// VISUALIZER.Choropleth.USCounties('HospitalCountyChoropleth',, 'HospitalCounty');

// OUTPUT(MissingChildrenDB.MCStateDS,, '~HMK::OUT::1030',  NAMED('MissingChildrenState'), OVERWRITE);
// VISUALIZER.Choropleth.USStates('MissingChildrenStateChoropleth',, 'MissingChildrenState' ,,, DATASET([{'palleteID', 'PuBuGn'}], VISUALIZER.KeyValueDef));

// OUTPUT(MissingChildrenDB.MCCountyDS,, '~HMK::OUT::1031', NAMED('MissingChildrenCounty'), OVERWRITE);
// VISUALIZER.Choropleth.USCounties('MissingChildrenCountyChoropleth',, 'MissingChildrenCounty');
