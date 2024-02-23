// Later on Figure How to create index and build new datasets

// WriteNewDS      := OUTPUT(CleanChurchFIPS,,'~HMK::OUT::Churches',NAMED('WriteDS'),OVERWRITE);                                          
// CleanChurchesDS    := DATASET('~HMK::OUT::Churches',CleanChurchRec,FLAT);

// //Declare and Build Indexes (special datasets that can be used in the ROXIE data delivery cluster
// CleanChurchIDX     := INDEX(CleanChurchesDS,{city,state},{CleanChurchesDS},'~HMK::IDX::Church::CityPay');
// CleanChurchFIPSIDX := INDEX(CleanChurchesDS,{PrimaryFIPS},{CleanChurchesDS},'~HMK::IDX::Church::FIPSPay');
// BuildChurchIDX     := BUILD(CleanChurchIDX,NAMED('BldIDX1'),OVERWRITE);
// BuildChurchFIPSIDX := BUILD(CleanChurchFIPSIDX,NAMED('BLDIDX2'),OVERWRITE);

EXPORT MissingChildrenDB:= MODULE
    // OUTPUT(SORT(newDS, -yearOfMissing, -monthOfMissing, -dayOfMissing), NAMED('NewDataset'));
    EXPORT stateLayout := RECORD
    STRING state;
    INTEGER cnt;
    END;

    EXPORT countyLayout := RECORD
    STRING county;
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
