IMPORT $;

HMK := $.File_AllData;
FirstName := SET(HMK.mc_byStateDS, firstname);

OUTPUT(HMK.mc_byStateDS, NAMED('NCMEC'));

