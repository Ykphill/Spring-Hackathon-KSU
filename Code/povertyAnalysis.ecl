IMPORT $ AS CODE;
HMK:= CODE.File_AllData;

PovertyStat :=HMK.pov_estimatesDS;

OUTPUT(PovertyStat,NAMED('Poverty'));





MCATribute := TABLE(PovertyStat,{attribute,cnt := COUNT(GROUP)},attribute);
Out_MCATribute := OUTPUT(SORT(MCATribute,-cnt),NAMED('refined'));
Out_MCATribute