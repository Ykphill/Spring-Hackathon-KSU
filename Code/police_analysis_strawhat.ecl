IMPORT $, STD;

// Retrieve Website, latitude, longitude, county, population, state, city
HMK := $.File_AllData;
policeDS := HMK.PoliceDS;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;

// OUTPUT(policeDS, NAMED('PoliceStation'));
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
    policeDS.city;
    policeDS.state;
    policeDS.zip;
    policeDS.source;
END;

cityLocation := TABLE(
    citiesDS,
    cityLayout,
    city
);


OUTPUT(cityLocation, NAMED('CityLocation'));

// newDS := TABLE(policeDS,
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

policeStationDS := JOIN(policeDS, 
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

OUTPUT(policeStationDS, NAMED('policeStationDS'));

policeByState := TABLE(policeStationDS,{state,cnt := COUNT(GROUP)}, state);
writePoliceByState := OUTPUT(policeByState,, '~HMK::OUT::policeByState', NAMED('policeByState'),OVERWRITE);
writePoliceByState;

policeByCounty := TABLE(policeStationDS,{county,cnt := COUNT(GROUP)}, county);
writePoliceByCounty := OUTPUT(policeByCounty,, '~HMK::OUT::policeByCounty', NAMED('policeByCounty'),OVERWRITE);
writePoliceByCounty;

policeByFips := TABLE(policeStationDS,{county_fips,cnt := COUNT(GROUP)}, county_fips);
writePoliceByFips := OUTPUT(policeByFips,, '~HMK::OUT::policeByFips', NAMED('policeByFips'),OVERWRITE);
writePoliceByFips;