IMPORT $, STD;

// Missing Children Data Analysis

//  Linking up the Datasets  
HMK := $.File_AllData;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;
hospitalDS := HMK.HospitalDS;

// RECORD for city layouts
cityLayout := RECORD
    citiesDS.city;
    citiesDS.county_name;
    citiesDS.county_fips;
    citiesDS.lat;
    citiesDS.lng;
    citiesDS.density;
END;

// Database Table with ciy being GROUPED
cityLocation := TABLE(
    citiesDS,
    cityLayout,
    city
);

// OUTPUT(cityLocation, NAMED('cityLocation'));
// OUTPUT(countyLocation, NAMED('countyLocation'));

missingChildWithCitiesLayout := RECORD
    STRING firstname;
    STRING lastname;
    STRING yearOfMissing;
    STRING monthOfMissing;
    STRING dayOfMissing;
    STRING state;
    STRING county;
    STRING county_fips;
    DECIMAL lat;
    DECIMAL long;
    DECIMAL density;

END;

// Link up city by county

newDS := JOIN(missingChildDS, 
    cityLocation, 
    STD.Str.ToLowerCase(LEFT.missingcity) = STD.Str.ToLowerCase(RIGHT.city),
    TRANSFORM(missingChildWithCitiesLayout,
    SELF.lat := RIGHT.lat;
    SELF.long := RIGHT.lng;
    SELF.county := RIGHT.county_name;
    SELF.county_fips := RIGHT.county_fips;
    SELF.yearOfMissing := (STRING) LEFT.datemissing[..4];
    SELF.monthOfMissing := (STRING) LEFT.datemissing[5..6];
    SELF.dayOfMissing := (STRING) LEFT.datemissing[7..8];
    SELF.state := LEFT.missingstate;
    SELF.density := RIGHT.density;
    SELF := LEFT;
    SELF := RIGHT;
));

// OUTPUT the SORTED new Dataset
OUTPUT(SORT(newDS, -yearOfMissing, -monthOfMissing, -dayOfMissing), NAMED('NewDataset'));

MissingChildrenByStateDS := TABLE(newDS,{state,cnt := COUNT(GROUP)},state);
WriteNewMissingChildrenByStateDS := OUTPUT(MissingChildrenByStateDS,,'~HMK::OUT::MissingChildrenByStateDS', NAMED('WriteMissingChildrenByStateDS'),OVERWRITE);
// OUTPUT(SORT(MissingChildrenByStateDS,-cnt),NAMED('MissingChildrenByState'));

MissingChildrenByCountyDS:= TABLE(newDS,{county_fips,cnt := COUNT(GROUP)},county_fips);
WriteNewMissingChildrenByCountyDS := OUTPUT(MissingChildrenByCountyDS,,'~HMK::OUT::MissingChildrenByCountyDS', NAMED('WriteMissingChildrenByCountyDS'), OVERWRITE);   
// OUTPUT(SORT(MissingChildrenByCountyDS,-cnt), NAMED('MissingChildrenByCounty'));

MissingChildrenByMonthDS:= TABLE(newDS,{monthOfMissing,cnt := COUNT(GROUP)},monthOfMissing);
WriteNewMissingChildrenByMonthDS := OUTPUT(MissingChildrenByMonthDS,,'~HMK::OUT::MissingChildrenByMonthDS', NAMED('WriteMissingChildrenByMonthDS'),OVERWRITE);   
// OUTPUT(SORT(MissingChildrenByMonthDS,-monthOfMissing),NAMED('MissingChildrenByMonth'));

MissingChildrenByYearDS:= TABLE(newDS,{yearOfMissing,cnt := COUNT(GROUP)},yearOfMissing);
WriteNewMissingChildrenByYearDS := OUTPUT(MissingChildrenByYearDS,,'~HMK::OUT::MissingChildrenByYearDS', NAMED('WriteMissingChildrenByYearDS'),OVERWRITE);   
// OUTPUT(SORT(MissingChildrenByYearDS,yearOfMissing),NAMED('MissingChildrenByYear'));

MissingChildrenByDayDS:= TABLE(newDS,{dayOfMissing,cnt := COUNT(GROUP)},dayOfMissing);
WriteNewMissingChildrenByDayDS := OUTPUT(MissingChildrenByDayDS,,'~HMK::OUT::MissingChildrenByDayDS', NAMED('WriteMissingChildrenByDayDS'),OVERWRITE);   
// OUTPUT(SORT(MissingChildrenByDayDS,-dayOfMissing),NAMED('MissingChildrenByDay'));



IMPORT Visualizer;      

PopStat :=HMK.pop_estimatesDS;

// OUTPUT(PopStat,NAMED('Population'));
//POP Estimate of 2022
MCATribute := PopStat(attribute='POP_ESTIMATE_2022');
PopEstimate :=  Table(MCATribute);

population := PopEstimate(STD.Str.Contains(PopEstimate.area_name, 'County', TRUE));

population_layout := RECORD
    fip_codes := IF((INTEGER) population.fips_code < 10000, '0' + (STRING) population.fips_code, (STRING) population.fips_code);
    population.value;
END;


// TABLE(population, population_layout);

Record_Structure := RECORD
    STRING county_fips;
    INTEGER missing_count;
    INTEGER population;
    DECIMAL missing_to_population_ratio;
END;

ResultName := JOIN(
    MissingChildrenByCountyDS,
    TABLE(population, population_layout),
    LEFT.county_fips  =  RIGHT.fip_codes
    ,transform(Record_Structure, 
                SELF.missing_count := LEFT.cnt; 
                SELF.population := RIGHT.value; 
                SELF.missing_to_population_ratio := (LEFT.cnt / RIGHT.value) * 1000;
                SELF := LEFT; 
                SELF := RIGHT;
                SELF := [];
    ),INNER,LOCAL);

ratio_layout := RECORD
    ResultName.county_fips;
    ResultName.missing_to_population_ratio;
END;

HospitalDB := $.HospitalDB;
FoodBankDB := $.FoodBankDB;
MissingChildrenDB := $.MissingChildrenDB;
PoliceDB := $.PoliceDB;
FireDepartmentDB := $.FireDepartmentDB;

missingChildren_food_layout := RECORD
    STRING county_fips;
    INTEGER missing_count;
    INTEGER food_count;
END;

MissingChildren_Food_Name := JOIN(
    MissingChildrenByCountyDS,
    FoodBankDB.foodBankCountyDS, 
    LEFT.county_fips  =  RIGHT.county_fips,    
    TRANSFORM(missingChildren_food_layout, 
            SELF.missing_count := LEFT.cnt;
            SELF.food_count := RIGHT.cnt;
            SELF := LEFT; 
            SELF := RIGHT;
            SELF := [];
));

// OUTPUT(MissingChildren_Food_Name, NAMED('MissingChildren_Food_Name'));
OUTPUT(CORRELATION(MissingChildren_Food_Name, MissingChildren_Food_Name.missing_count, MissingChildren_Food_Name.food_count), NAMED('MissingChildren_Food_Corr'));

missingChildren_hospital_layout := RECORD
    STRING county_fips;
    INTEGER missing_count;
    INTEGER hospital_count;
END;

MissingChildren_hospital_Name := JOIN(
    MissingChildrenByCountyDS,
    HospitalDB.HospitalCountyDS, 
    LEFT.county_fips  =  RIGHT.county_fips,    
    TRANSFORM(missingChildren_hospital_layout, 
            SELF.missing_count := LEFT.cnt;
            SELF.hospital_count := RIGHT.cnt;
            SELF := LEFT; 
            SELF := RIGHT;
            SELF := [];
));

// OUTPUT(MissingChildren_Food_Name, NAMED('MissingChildren_Hospital_Name'));
OUTPUT(CORRELATION(MissingChildren_hospital_Name, MissingChildren_hospital_Name.missing_count, MissingChildren_hospital_Name.hospital_count), NAMED('MissingChildren_Hospital_Corr'));

missingChildren_police_layout := RECORD
    STRING county_fips;
    INTEGER missing_count;
    INTEGER police_count;
END;

MissingChildren_police_Name := JOIN(
    MissingChildrenByCountyDS,
    PoliceDB.policeFipDS, 
    LEFT.county_fips  =  RIGHT.county_fips,    
    TRANSFORM(missingChildren_police_layout, 
            SELF.missing_count := LEFT.cnt;
            SELF.police_count := RIGHT.cnt;
            SELF := LEFT; 
            SELF := RIGHT;
            SELF := [];
));

// OUTPUT(MissingChildren_Food_Name, NAMED('MissingChildren_Hospital_Name'));
OUTPUT(CORRELATION(MissingChildren_police_Name, MissingChildren_police_Name.missing_count, MissingChildren_police_Name.police_count), NAMED('MissingChildren_Police_Corr'));

missingChildren_fire_layout := RECORD
    STRING county_fips;
    INTEGER missing_count;
    INTEGER fire_dep_count;
END;

MissingChildren_fire_Name := JOIN(
    MissingChildrenByCountyDS,
    FireDepartmentDB.fireDepartmentCountyDS, 
    LEFT.county_fips  =  RIGHT.county_fips,    
    TRANSFORM(missingChildren_fire_layout, 
            SELF.missing_count := LEFT.cnt;
            SELF.fire_dep_count := RIGHT.cnt;
            SELF := LEFT; 
            SELF := RIGHT;
            SELF := [];
));

// OUTPUT(MissingChildren_fire_Name, NAMED('MissingChildren_Hospital_Name'));
OUTPUT(CORRELATION(MissingChildren_fire_Name, MissingChildren_fire_Name.missing_count, MissingChildren_fire_Name.fire_dep_count), NAMED('MissingChildren_FIRE_Corr'));

// OUTPUT(PoliceDB.policeCountyDS);
// OUTPUT(TABLE(ResultName, ratio_layout),, '~HMK::OUT::6000', NAMED('MissingChildrenPopulationRatio'), OVERWRITE);
viz_miss_pop_ratio := Visualizer.Choropleth.USCounties('MissingChildrenPopChor',, 'MissingChildrenPopulationRatio');
viz_miss_pop_ratio;

// Visualize the Missing Children By Year
// viz_year := Visualizer.MultiD.Area('yearArea',, 'MissingChildrenByYear');
// viz_year;

// // Visualize the Missing Children By Month using a Column Graph
// viz_month := Visualizer.MultiD.Column('monthColumn',, 'MissingChildrenByMonth');
// viz_month;

// // Visualize the Missing Children By Month using a  Graph
// viz_day := Visualizer.MultiD.Column('dayColumn',, 'MissingChildrenByDay');
// viz_day;

// viz_counties := Visualizer.Choropleth.USCounties('USCounties',, 'MissingChildrenByCounty');
// viz_counties;
