EXPORT GDP_Percapita:= MODULE
///GDP is only pulling from Q1
EXPORT StateGDPLayoutQ1 := RECORD
    INTEGER GeoFips;
    STRING GeoName;
    DECIMAL Q1;

END;

EXPORT StateGDPQ1 := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayoutQ1, CSV(HEADING(1)));

 StateGDPLayoutQ2 := RECORD
    INTEGER GeoFips;
    STRING GeoName;
    DECIMAL Q2;
END;

 EXPORT StateGDPQ2 := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayoutQ2, CSV(HEADING(1)));

StateGDPLayoutQ3 := RECORD
    INTEGER GeoFips;
    STRING GeoName;
    DECIMAL q3;
   
END;

EXPORT StateGDPQ3 := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayoutQ3, CSV(HEADING(1)));

 StateGDPLayoutQ4 := RECORD
    INTEGER GeoFips;
    STRING GeoName;
    DECIMAL Q4;
END;

 EXPORT StateGDPQ4 := DATASET('~hmk::out::stategdp::state_gdp.csv', StateGDPLayoutQ4, CSV(HEADING(1)));
END;



