IMPORT $, STD;

// Retrieve Website, latitude, longitude, county, population, state, city
HMK := $.File_AllData;
fireDS := HMK.FireDS;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;

// OUTPUT(fireDS, NAMED('FireStation'));
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
    fireDS.city;
    fireDS.state;
    fireDS.zipcode;
    fireDS.source_originator;
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

fireDepartmentDS := JOIN(fireDS, 
    cityLocation, 
    STD.Str.ToLowerCase(LEFT.city) = STD.Str.ToLowerCase(RIGHT.city),
    TRANSFORM(missingChildWithCitiesLayout,
    SELF.lat := LEFT.ycoor;
    SELF.long := LEFT.xcoor;
    SELF.county := RIGHT.county_name;
    SELF.county_fips := RIGHT.county_fips;
    SELF.state := LEFT.state;
    SELF := LEFT;
    SELF := RIGHT;
));

OUTPUT(fireDepartmentDS, NAMED('fireDepartmentDS'));

fireDepartmentByState := TABLE(fireDepartmentDS,{state,cnt := COUNT(GROUP)}, state);
writeFireDepartmentByState := OUTPUT(fireDepartmentByState,, '~HMK::OUT::fireDepartmentByState', NAMED('fireDepartmentByState'),OVERWRITE);
writeFireDepartmentByState;

fireDepartmentByCounty := TABLE(fireDepartmentDS,{county_fips,cnt := COUNT(GROUP)}, county_fips);
writeFireDepartmentByCounty := OUTPUT(fireDepartmentByCounty,, '~HMK::OUT::fireDepartmentByCounty', NAMED('fireDepartmentByCounty'),OVERWRITE);
writeFireDepartmentByCounty;
