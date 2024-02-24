EXPORT PoliceDB:= MODULE

    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county_fips;
    INTEGER cnt;
    END;

    EXPORT policeStateDS := DATASET('~HMK::OUT::fireStationByState',stateLayout,FLAT);

    EXPORT policeCountyDS:= DATASET('~HMK::OUT::fireStationByCounty',countyLayout,FLAT);

END;
