IMPORT $;

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
    MissingChildrenDB.MCCountyDS,
    FoodBankDB.foodBankCountyDS, 
    LEFT.county_fips  =  RIGHT.county_fips,    
    TRANSFORM(missingChildren_food_layout, 
            SELF.missing_count := LEFT.cnt;
            SELF.food_count := RIGHT.cnt;
            SELF := LEFT; 
            SELF := RIGHT;
            SELF := [];
));

OUTPUT(MissingChildrenDB.MCCountyDS);
