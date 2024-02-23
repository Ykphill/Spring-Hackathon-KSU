IMPORT $;
IMPORT VISUALIZER;

HospitalDB := $.HospitalDB;
FoodBankDB := $.FoodBankDB;
MissingChildrenDB := $.MissingChildrenDB;

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

// SORT(FoodBankDB.foodBankStateDS, -cnt);

VISUALIZER.