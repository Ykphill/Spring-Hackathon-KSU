IMPORT $ AS CODE;
HMK:= CODE.File_AllData;

// NAMED("") Names the output of the name 

// Export All this different tables into seperate dataset
// EXPORT HMK.unemp_byCountyDS;

OUTPUT(HMK.unemp_ratesDS,NAMED('US_UnempByMonth'));
OUTPUT(HMK.unemp_byCountyDS,NAMED('Unemployment'));
OUTPUT(HMK.EducationDS,NAMED('Education'));
OUTPUT(HMK.pov_estimatesDS,NAMED('Poverty'));
OUTPUT(HMK.pop_estimatesDS,NAMED('Population'));
OUTPUT(HMK.PoliceDS,NAMED('Police'));
OUTPUT(HMK.FireDS,NAMED('Fire'));
OUTPUT(HMK.HospitalDS,NAMED('Hospitals'));
OUTPUT(HMK.ChurchDS,NAMED('Churches'));
OUTPUT(HMK.FoodBankDS,NAMED('FoodBanks'));
OUTPUT(HMK.mc_byStateDS,NAMED('NCMEC'));
OUTPUT(COUNT(HMK.mc_byStateDS),NAMED('NCMEC_Cnt'));
OUTPUT(HMK.City_DS, NAMED('Cities'));
OUTPUT(COUNT(HMK.City_DS),NAMED('Cities_Cnt'));

