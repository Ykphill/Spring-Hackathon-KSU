IMPORT $, STD;

// Missing Children Data Analysis

HMK := $.File_AllData;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;
hospitalDS := HMK.HospitalDS;

// OUTPUT(citiesDS, NAMED('CITIES'));
// OUTPUT(missingChildDS, NAMED('MissingChildren'));

// Location Layout for Specifying Cities and Latitude, Longitude, Density
cityLayout := RECORD
    citiesDS.city;
    citiesDS.county_name;
    citiesDS.county_fips;
    citiesDS.lat;
    citiesDS.lng;
    citiesDS.density;
END;

// Database Table with unique city as key
cityLocation := TABLE(
    citiesDS,
    cityLayout,
    city
);

// OUTPUT(cityLocation, NAMED('cityLocation'));
// OUTPUT(countyLocation, NAMED('countyLocation'));

missingChildWithCitiesLayout := RECORD
    STRING firstname;
    STRING lastname;
    STRING yearOfMissing;
    STRING monthOfMissing;
    STRING dayOfMissing;
    STRING state;
    STRING county;
    STRING county_fips;
    DECIMAL lat;
    DECIMAL long;
    DECIMAL density;

END;

// Link up city by county

newDS := JOIN(missingChildDS, 
    cityLocation, 
    STD.Str.ToLowerCase(LEFT.missingcity) = STD.Str.ToLowerCase(RIGHT.city),
    TRANSFORM(missingChildWithCitiesLayout,
    SELF.lat := RIGHT.lat;
    SELF.long := RIGHT.lng;
    SELF.county := RIGHT.county_name;
    SELF.county_fips := RIGHT.county_fips;
    SELF.yearOfMissing := (STRING) LEFT.datemissing[..4];
    SELF.monthOfMissing := (STRING) LEFT.datemissing[5..6];
    SELF.dayOfMissing := (STRING) LEFT.datemissing[7..8];
    SELF.state := LEFT.missingstate;
    SELF.density := RIGHT.density;
    SELF := LEFT;
    SELF := RIGHT;
));

OUTPUT(SORT(newDS, -yearOfMissing, -monthOfMissing, -dayOfMissing), NAMED('NewDataset'));
TEST_RECORD := RECORD
    STRING state; 
    INTEGER cnt;
END;


MissingChildrenByStateDS := TABLE(newDS,{state,cnt := COUNT(GROUP)},state);
// WriteNewMissingChildrenByStateDS := OUTPUT(MissingChildrenByStateDS,,'~HMK::OUT::MissingChildrenByStateDS', NAMED('WriteMissingChildrenByStateDS'),OVERWRITE);
OUTPUT(SORT(MissingChildrenByStateDS,-cnt),NAMED('MissingChildrenByState'));


MissingChildrenByCountyDS:= TABLE(newDS,{county,cnt := COUNT(GROUP)},county);
// WriteNewMissingChildrenByCountyDS := OUTPUT(MissingChildrenByCountyDS,,'~HMK::OUT::MissingChildrenByCountyDS', NAMED('WriteMissingChildrenByCountyDS'),OVERWRITE);   
OUTPUT(SORT(MissingChildrenByCountyDS,-cnt),NAMED('MissingChildrenByCounty'));

MissingChildrenByMonthDS:= TABLE(newDS,{monthOfMissing,cnt := COUNT(GROUP)},monthOfMissing);
// WriteNewMissingChildrenByMonthDS := OUTPUT(MissingChildrenByMonthDS,,'~HMK::OUT::MissingChildrenByMonthDS', NAMED('WriteMissingChildrenByMonthDS'),OVERWRITE);   
OUTPUT(SORT(MissingChildrenByMonthDS,-monthOfMissing),NAMED('MissingChildrenByMonth'));

MissingChildrenByYearDS:= TABLE(newDS,{yearOfMissing,cnt := COUNT(GROUP)},yearOfMissing);
// WriteNewMissingChildrenByYearDS := OUTPUT(MissingChildrenByYearDS,,'~HMK::OUT::MissingChildrenByYearDS', NAMED('WriteMissingChildrenByYearDS'),OVERWRITE);   
OUTPUT(SORT(MissingChildrenByYearDS,yearOfMissing),NAMED('MissingChildrenByYear'));

MissingChildrenByDayDS:= TABLE(newDS,{dayOfMissing,cnt := COUNT(GROUP)},dayOfMissing);
// WriteNewMissingChildrenByDayDS := OUTPUT(MissingChildrenByDayDS,,'~HMK::OUT::MissingChildrenByDayDS', NAMED('WriteMissingChildrenByDayDS'),OVERWRITE);   
OUTPUT(SORT(MissingChildrenByDayDS,-dayOfMissing),NAMED('MissingChildrenByDay'));

// SEQUENTIAL(WriteNewMissingChildrenByStateDS,WriteNewMissingChildrenByCountyDS,MissingChildrenByCountyDS2);

IMPORT Visualizer;                    
                    
viz_year := Visualizer.MultiD.Area('area',, 'MissingChildrenByYear');
viz_year;
 
viz_month := Visualizer.MultiD.Bar('bar',, 'MissingChildrenByMonth');
viz_month;

viz_day := Visualizer.MultiD.Column('column',, 'MissingChildrenByDay');
viz_day;


// data_usStates := OUTPUT(_usStates, NAMED('choro_usStates'));  
// data_usStates;  

viz_states := Visualizer.Choropleth.USStates('usStates',, 'MissingChildrenByState');  
viz_states;