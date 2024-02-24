EXPORT HospitalDB:= MODULE

    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county;
    INTEGER cnt;
    END;

    EXPORT HospitalStateDS := DATASET('~HMK::OUT::hospitalByState',stateLayout,FLAT);

    EXPORT HospitalCountyDS:= DATASET('~HMK::OUT::hospitalByCounty',countyLayout,FLAT);

END;
