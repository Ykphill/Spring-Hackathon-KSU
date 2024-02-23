IMPORT $;

HMK := $.File_AllData;
missingChildDS := HMK.mc_byStateDS;
citiesDS := HMK.City_DS;


OUTPUT(missingChildDS(MissingState IN ['PA', 'GA']));

missingChildStateLayout := RECORD
missingChildDS.MissingState;
minAge := MAX(GROUP, missingChildDS.CurrentAge);

END;

// missingChildStateLayout1 := RECORD
// missingChildDS.MissingState;
// minAge := AVE(missingChildDS.CurrentAge);
// END;


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

// MyRecord := RECORD
//   INTEGER Id;
//   STRING Name;
//   INTEGER Age;

// END;

// MyDataset := DATASET([
//   {1, 'Alice', 25},
//   {2, 'Bob', 30},
//   {3, 'Alice', 35},
//   {4, 'Bob', 40},
//   {5, 'Charlie', 20}
// ], MyRecord);

// // Group by name and calculate average age
// Grouped := GROUP(MyDataset, name);
// Result := SUMMARIZE(Grouped, AVG(age));
// OUTPUT(Result);

