IMPORT $ AS CODE;
IMPORT STD;

HMK:= CODE.File_AllData;

PopStat :=HMK.pop_estimatesDS;

// OUTPUT(PopStat,NAMED('Population'));


//POP Estimate of 2022
MCATribute := PopStat(attribute='POP_ESTIMATE_2022');
PopEstimate :=  Table(MCATribute);

// policeByCounty := TABLE(policeStationDS,{county,cnt := COUNT(GROUP)}, county);
OUTPUT(PopEstimate,, '~HMK::OUT::5000', NAMED('PopEstimate2022'), OVERWRITE);

OUTPUT(PopEstimate(state='CA'));

// OUTPUT(PopEstimate(STD.Str.Contains(PopEstimate.area_name, 'County', TRUE)));
population := PopEstimate(STD.Str.Contains(PopEstimate.area_name, 'County', TRUE));
OUTPUT(population);

population_layout := RECORD
    fip_codes := IF((INTEGER) population.fips_code < 10000, '0' + (STRING) population.fips_code, (STRING) population.fips_code);
    population.value;
END;

OUTPUT(TABLE(population, population_layout),, '~HMK::OUT::5001',  NAMED('TABLE'), OVERWRITE);

IMPORT Visualizer;      

viz_counties := Visualizer.Choropleth.USCounties('USPOPCounties',, 'TABLE');
viz_counties;


// TABLE(PopEstimate, {state, est_population := SUM(value)}, state);
// //N POP CHG of 2022
// popChg := PopStat(attribute='N_POP_CHG_2022');
// PopulationChange2022 :=  Table(popChg);
// OUTPUT(PopulationChange2022,NAMED('PopulationChange2022'));

// //POP International Mig of 2022
// popIMig := PopStat(attribute='INTERNATIONAL_MIG_2022');
// InternationMig2022 :=  Table(popIMig);
// OUTPUT(InternationMig2022,NAMED('InternationMig2022'));

// //POP Domestic of 2022
// popDMig := PopStat(attribute='DOMESTIC_MIG_2022');
// DomesticMig2022 :=  Table(popDMig);
// OUTPUT(DomesticMig2022,NAMED('DomesticMig2022'));

// //POP Domestic of 2022
// popNMig := PopStat(attribute='NET_MIG_2022');
// NetMig2022 :=  Table(popNMig);
// OUTPUT(NetMig2022,NAMED('NetMig2022'));
