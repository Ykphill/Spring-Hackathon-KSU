IMPORT $, STD;

// Retrieve Website, latitude, longitude, county, population, state, city
HMK := $.File_AllData;
hospitalDS := HMK.HospitalDS;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;

// OUTPUT(hospitalDS, NAMED('Hospital'));
// OUTPUT(missingChildDS, NAMED('MissingChildren'));
// OUTPUT(citiesDS, NAMED('Cities'));

cityLayout := RECORD
    citiesDS.city;
    citiesDS.county_name;
    citiesDS.county_fips;
    citiesDS.lat;
    citiesDS.lng;
    citiesDS.density;
END;

locationLayout := RECORD
    hospitalDS.city;
    hospitalDS.state;
    hospitalDS.zip;
    hospitalDS.source;
END;

cityLocation := TABLE(
    citiesDS,
    cityLayout,
    city
);

OUTPUT(cityLocation, NAMED('CityLocation'));

// newDS := TABLE(hospitalDS,
// locationLayout,
// city);

missingChildWithCitiesLayout := RECORD
    STRING name;
    STRING state;
    STRING county;
    STRING county_fips;
    DECIMAL lat;
    DECIMAL long;

END;

newDS := JOIN(hospitalDS, 
    cityLocation, 
    STD.Str.ToLowerCase(LEFT.city) = STD.Str.ToLowerCase(RIGHT.city),
    TRANSFORM(missingChildWithCitiesLayout,
    SELF.lat := LEFT.latitude;
    SELF.long := LEFT.longitude;
    SELF.county := RIGHT.county_name;
    SELF.county_fips := RIGHT.county_fips;
    SELF.state := LEFT.state;
    SELF := LEFT;
    SELF := RIGHT;
));

OUTPUT(newDS, NAMED('newDS'));

hospitalByState := TABLE(newDS,{state,cnt := COUNT(GROUP)}, state);
OUTPUT(hospitalByState, NAMED('hospitalByState'));

hospitalByCounty := TABLE(newDS,{county,cnt := COUNT(GROUP)}, county);
OUTPUT(hospitalByCounty, NAMED('hospitalByCounty'));

// missingChildWithCitiesLayout := RECORD
//     STRING firstname;
//     STRING lastname;
//     STRING state;
//     DECIMAL lat;
//     DECIMAL long;
//     DECIMAL density;

// END;

// newDS := JOIN(missingChildDS, 
//     cityLocation, 
//     STD.Str.ToLowerCase(LEFT.missingcity) = STD.Str.ToLowerCase(RIGHT.city),
//     TRANSFORM(missingChildWithCitiesLayout,
//     SELF.lat := RIGHT.lat;
//     SELF.long := RIGHT.lng;
//     SELF.state := LEFT.missingstate;
//     SELF.density := RIGHT.density;
//     SELF := LEFT;
//     SELF := RIGHT;
//     ));

// OUTPUT(missingChildDS(firstname = 'Tyler'));
// OUTPUT(newDS, NAMED('NewDS'));
