IMPORT $, STD;

// Retrieve Website, latitude, longitude, county, population, state, city
HMK := $.File_AllData;
foodDS := HMK.FoodBankDS;
citiesDS := HMK.City_DS;

OUTPUT(foodDS, NAMED('foodBankDS'));
// OUTPUT(missingChildDS, NAMED('MissingChildren'));
OUTPUT(citiesDS, NAMED('Cities'));

cityLayout := RECORD
    citiesDS.city;
    citiesDS.county_name;
    citiesDS.county_fips;
    citiesDS.lat;
    citiesDS.lng;
    citiesDS.density;
END;

locationLayout := RECORD
    foodDS.city;
    foodDS.state;
    foodDS.zip_code;
    foodDS.web_page;
END;

cityLocation := TABLE(
    citiesDS,
    cityLayout,
    city
);

// OUTPUT(cityLocation, NAMED('CityLocation'));

missingChildWithCitiesLayout := RECORD
    STRING food_bank_name;
    STRING state;
    STRING county;
    STRING county_fips;
    // DECIMAL lat;
    // DECIMAL long;

END;

newDS := JOIN(foodDS, 
    cityLocation, 
    STD.Str.ToLowerCase(LEFT.city) = STD.Str.ToLowerCase(RIGHT.city),
    TRANSFORM(missingChildWithCitiesLayout,
    // SELF.lat := .latitude;
    // SELF.long := LEFT.longitude;
    SELF.county := RIGHT.county_name;
    SELF.county_fips := RIGHT.county_fips;
    SELF.state := LEFT.state;
    SELF := LEFT;
    SELF := RIGHT;
));

OUTPUT(newDS, NAMED('newDS'));

foodBankByState := TABLE(newDS,{state,cnt := COUNT(GROUP)}, state);
writeFoodBankByState := OUTPUT(foodBankByState,, '~HMK::OUT::foodBankByState', NAMED('foodBankByState'));
writeFoodBankByState;

foodBankByCounty := TABLE(newDS,{county_fips,cnt := COUNT(GROUP)}, county_fips);
writeFoodBankByCounty := OUTPUT(foodBankByCounty,, '~HMK::OUT::foodBankByCounty', NAMED('foodBankByCounty'));
writeFoodBankByCounty;
