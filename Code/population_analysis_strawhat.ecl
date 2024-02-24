IMPORT $ AS CODE;
HMK:= CODE.File_AllData;

PopStat :=HMK.pop_estimatesDS;

OUTPUT(PopStat,NAMED('Population'));


//POP Estimate of 2022
MCATribute := PopStat(attribute='POP_ESTIMATE_2022');
PopEstimate :=  Table(MCATribute);
OUTPUT(PopEstimate,NAMED('PopEstimate2022'));

//N POP CHG of 2022
popChg := PopStat(attribute='N_POP_CHG_2022');
PopulationChange2022 :=  Table(popChg);
OUTPUT(PopulationChange2022,NAMED('PopulationChange2022'));

//POP International Mig of 2022
popIMig := PopStat(attribute='INTERNATIONAL_MIG_2022');
InternationMig2022 :=  Table(popIMig);
OUTPUT(InternationMig2022,NAMED('InternationMig2022'));

//POP Domestic of 2022
popDMig := PopStat(attribute='DOMESTIC_MIG_2022');
DomesticMig2022 :=  Table(popDMig);
OUTPUT(DomesticMig2022,NAMED('DomesticMig2022'));

//POP Domestic of 2022
popNMig := PopStat(attribute='NET_MIG_2022');
NetMig2022 :=  Table(popNMig);
OUTPUT(NetMig2022,NAMED('NetMig2022'));
