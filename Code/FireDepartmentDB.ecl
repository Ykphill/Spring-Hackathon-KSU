EXPORT FireDepartmentDB:= MODULE

    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county_fips;
    INTEGER cnt;
    END;

    EXPORT fireDepartmentStateDS := DATASET('~HMK::OUT::fireDepartmentByState',stateLayout,FLAT);

    EXPORT fireDepartmentCountyDS:= DATASET('~HMK::OUT::fireDepartmentByCounty',countyLayout,FLAT);

END;
