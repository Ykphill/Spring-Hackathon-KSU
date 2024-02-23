IMPORT $;

HMK := $.File_AllData;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;


OUTPUT(missingChildDS(MissingState IN ['PA', 'GA']));

missingChildStateLayout := RECORD
missingChildDS.MissingState;
minAge := MAX(GROUP, missingChildDS.CurrentAge);

END;


missingChildrenByAge := TABLE(
  missingChildDS,
  missingChildStateLayout,
  missingstate
);

sortedMissingChildrenByAge := SORT(missingChildrenByAge, -minAge);
OUTPUT(sortedMissingChildrenByAge, NAMED('Age'));


missingChildrenByState := TABLE(
  missingChildDS,
  missingChildStateLayout,
  missingstate
);

OUTPUT(missingChildrenByState, NAMED('mc_byStateDS'));
