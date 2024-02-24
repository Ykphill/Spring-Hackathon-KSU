EXPORT FoodBankDB:= MODULE

    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county_fips;
    INTEGER cnt;
    END;

    EXPORT foodBankStateDS := DATASET('~HMK::OUT::foodBankByState',stateLayout,FLAT);

    EXPORT foodBankCountyDS:= DATASET('~HMK::OUT::foodBankByCounty',countyLayout,FLAT);

END;
