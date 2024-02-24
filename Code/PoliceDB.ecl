EXPORT PoliceDB:= MODULE

    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county_fips;
    INTEGER cnt;
    END;

    EXPORT fipsLayout := RECORD
        STRING county_fips;
        INTEGER cnt;
    END;

    EXPORT policeStateDS := DATASET('~HMK::OUT::policeByState',stateLayout,FLAT);

    EXPORT policeCountyDS:= DATASET('~HMK::OUT::policeByCounty',countyLayout,FLAT);

    EXPORT policeFipDS := DATASET('~HMK::OUT::policeByFips', fipsLayout, FLAT);

END;
