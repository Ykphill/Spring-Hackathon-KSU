IMPORT $, STD;

HMK := $.File_AllData;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;

OUTPUT(citiesDS, NAMED('CITIES'));
OUTPUT(missingChildDS, NAMED('MissingChildren'));

locationLayout := RECORD
    citiesDS.city;
    citiesDS.lat;
    citiesDS.lng;
    citiesDS.density;
END;

cityLocation := TABLE(
    citiesDS,
    locationLayout,
    city
);

OUTPUT(cityLocation, NAMED('cityLocation'));

missingChildWithCitiesLayout := RECORD
    STRING firstname;
    STRING lastname;
    STRING state;
    DECIMAL lat;
    DECIMAL long;
    DECIMAL density;

END;

newDS := JOIN(missingChildDS, 
    cityLocation, 
    STD.Str.ToLowerCase(LEFT.missingcity) = STD.Str.ToLowerCase(RIGHT.city),
    TRANSFORM(missingChildWithCitiesLayout,
    SELF.lat := RIGHT.lat;
    SELF.long := RIGHT.lng;
    SELF.state := LEFT.missingstate;
    SELF.density := RIGHT.density;
    SELF := LEFT;
    SELF := RIGHT;
    ));

OUTPUT(missingChildDS(firstname = 'Tyler'));
OUTPUT(newDS, NAMED('NewDS'));

