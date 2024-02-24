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
writeHospitalByState := OUTPUT(hospitalByState,, '~HMK::OUT::hospitalByState', NAMED('hospitalByState'), OVERWRITE);
writeHospitalByState;

hospitalByCounty := TABLE(newDS,{county_fips,cnt := COUNT(GROUP)}, county_fips);
writeHospitalByCounty := OUTPUT(hospitalByCounty,, '~HMK::OUT::hospitalByCounty', NAMED('hospitalByCounty'), OVERWRITE);
writeHospitalByCounty;
