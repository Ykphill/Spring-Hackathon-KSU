EXPORT MissingChildrenDB:= MODULE
    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county_lips;
    INTEGER cnt;
    END;

    EXPORT yearLayout := RECORD
    STRING yearOfMissing;
    INTEGER cnt;
    END;

    EXPORT monthLayout := RECORD
    STRING monthOfMissing;
    INTEGER cnt;
    END;

    EXPORT dayLayout := RECORD
    STRING dayOfMissing;
    INTEGER cnt;
    END;

    EXPORT MCStateDS := DATASET('~HMK::OUT::MissingChildrenByStateDS',stateLayout,FLAT);

    EXPORT MCCountyDS:= DATASET('~HMK::OUT::MissingChildrenByCountyDS',countyLayout,FLAT);

    EXPORT MCMonthDS:= DATASET('~HMK::OUT::MissingChildrenByMonthDS',monthLayout,FLAT);

    EXPORT MCYearDS:= DATASET('~HMK::OUT::MissingChildrenByYearDS',yearLayout,FLAT);

    EXPORT MCDayDS:= DATASET('~HMK::OUT::MissingChildrenByDayDS',dayLayout,FLAT);

END;
