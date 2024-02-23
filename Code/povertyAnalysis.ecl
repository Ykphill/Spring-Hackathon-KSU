IMPORT $ AS CODE;
HMK:= CODE.File_AllData;

PovertyStat :=HMK.pov_estimatesDS;

OUTPUT(PovertyStat,NAMED('Poverty'));

SortedAttribute := SORT (PovertyStat,attribute);

OUTPUT(SortedAttribute,NAMED('Asc_ordered'));
