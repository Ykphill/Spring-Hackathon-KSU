IMPORT $,STD;
//This file is used to demonstrate how to "clean" a raw dataset (Churches) and create an index to be used in a ROXIE service
Churches := $.File_AllData.ChurchDS;
Cities   := $.File_AllData.City_DS;


//First, determine what fields you want to clean:
CleanChurchRec := RECORD
    STRING70  name;
    STRING35  street;
    STRING22  city;
    STRING2   state;
    UNSIGNED3 zip;
    UNSIGNED1 affiliation; 
    UNSIGNED3 PrimaryFIPS; //New - will be added from Cities DS
END;
//PROJECT is used to transform one data record to another.
CleanChurch := PROJECT(Churches,TRANSFORM(CleanChurchRec,
                                          SELF.name                := STD.STR.ToUpperCase(LEFT.name),
                                          SELF.street              := STD.STR.ToUpperCase(LEFT.street),
                                          SELF.city                := STD.STR.ToUpperCase(LEFT.city),
                                          SELF.State               := STD.STR.ToUpperCase(LEFT.state),
                                          SELF.zip                 := LEFT.zip,
                                          SELF.affiliation         := LEFT.affiliation,
                                          SELF.PrimaryFIPS         := 0));
//JOIN is used to combine data from different datasets 
CleanChurchFIPS :=       JOIN(CleanChurch,Cities,
                           LEFT.city  = STD.STR.ToUpperCase(RIGHT.city) AND
                           LEFT.state = RIGHT.state_id,
                           TRANSFORM(CleanChurchRec,
                                     SELF.PrimaryFIPS := (UNSIGNED3)RIGHT.county_fips,
                                     SELF             := LEFT),LEFT OUTER,LOOKUP);
//Write out the new file and then define it using DATASET
WriteChurches      := OUTPUT(CleanChurchFIPS,,'~HMK::OUT::Churches',NAMED('WriteDS'),OVERWRITE);                                          
CleanChurchesDS    := DATASET('~HMK::OUT::Churches',CleanChurchRec,FLAT);

//Declare and Build Indexes (special datasets that can be used in the ROXIE data delivery cluster
CleanChurchIDX     := INDEX(CleanChurchesDS,{city,state},{CleanChurchesDS},'~HMK::IDX::Church::CityPay');
CleanChurchFIPSIDX := INDEX(CleanChurchesDS,{PrimaryFIPS},{CleanChurchesDS},'~HMK::IDX::Church::FIPSPay');
BuildChurchIDX     := BUILD(CleanChurchIDX,NAMED('BldIDX1'),OVERWRITE);
BuildChurchFIPSIDX := BUILD(CleanChurchFIPSIDX,NAMED('BLDIDX2'),OVERWRITE);

//Cross-Tab Reports:
//Churches by City: 

CT_City := TABLE(CleanChurchesDS,{city,state,cnt := COUNT(GROUP)},state,city);
Out_CT_City := OUTPUT(SORT(CT_City,-cnt),NAMED('ChurchByCity'));

//Cross-Tab by State:

CT_ST := TABLE(CleanChurchesDS,{state,cnt := COUNT(GROUP)},state);
Out_CT_ST := OUTPUT(SORT(CT_ST,-cnt),NAMED('ChurchByState'));

//Cross-Tab by Primary FIPS:

CT_FIPS := TABLE(CleanChurchesDS,{PrimaryFIPS,cnt := COUNT(GROUP)},PrimaryFIPS);
Out_CT_FIPS := OUTPUT(SORT(CT_FIPS(PrimaryFIPS <> 0),-cnt),NAMED('ChurchByFIPS'));

//SEQUENTIAL is similar to OUTPUT, but executes the actions in sequence instead of the default parallel actions of the HPCC
SEQUENTIAL(WriteChurches,BuildChurchIDX,BuildChurchFIPSIDX,out_Ct_City,Out_Ct_ST,Out_CT_FIPS);


