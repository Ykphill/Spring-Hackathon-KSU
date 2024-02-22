EXPORT File_AllData := MODULE
//The datasets proivided in this challenge are all in the public domain and free for you to use. 
//The links to the downloads and specific license info is provided below.


//Unemployment Rates
//Not used in challenge, just interesting info!
EXPORT unemp_rates := RECORD
    STRING Year;
    STRING Jan;
    STRING Feb;
    STRING Mar;
    STRING Apr;
    STRING May;
    STRING Jun;
    STRING Jul;
    STRING Aug;
    STRING Sep;
    STRING Oct;
    STRING Nov;
    STRING Dec;
END; 
EXPORT unemp_ratesDS := DATASET('~hmk::in::us_unemploymentrates',unemp_rates,CSV(HEADING(1)));

//https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
//Unemployment stats from 2000-2021
EXPORT unemp_byCounty := RECORD
    UNSIGNED3 FIPS_Code;
    STRING2   State;
    STRING50  Area_Name;
    STRING45  Attribute;
    REAL8     Value;
END;

EXPORT unemp_byCountyDS := DATASET('~hmk::in::unemployment',unemp_byCounty,CSV(HEADING(1)));

EXPORT pov_estimates := RECORD
    UNSIGNED3 FIPS_Code;
    STRING2   State;
    STRING35  Area_name;
    STRING35  Attribute;
    REAL8     Value;
END;

EXPORT pov_estimatesDS := DATASET('~hmk::in::poverty',pov_estimates,CSV(HEADING(1)));

EXPORT Education := RECORD
    UNSIGNED3 FIPS_Code; //Federal_Information_Processing_Standard
    STRING2   State;
    STRING45  Area_name;
    STRING75  Attribute;
    REAL8     Value;
END;

EXPORT EducationDS := DATASET('~hmk::in::education',education,CSV(HEADING(1)));

EXPORT pop_estimates := RECORD
    UNSIGNED3 FIPS_Code;
    STRING2   State;
    STRING50  Area_Name;
    STRING35  Attribute;
    REAL8     Value;
END;

EXPORT pop_estimatesDS := DATASET('~hmk::in::population',pop_estimates,CSV(HEADING(1)));

//NCMEC Data
//Source:
//https://www.missingkids.org/gethelpnow/search/rss
//data extracted from RSS feeds from original XML format to composite CSV
//Best Records were added from the original import data - instructor will show process
EXPORT mc_byState := RECORD
  UNSIGNED3 RecID;
  STRING11  DatePosted;
  STRING18  FirstName;
  STRING24  LastName;
  UNSIGNED1 CurrentAge;
  UNSIGNED4 DateMissing;
  STRING25  MissingCity;
  STRING2   MissingState;
  STRING150 Contact;
  STRING100 PhotoLink;
END;

EXPORT mc_byStateDS := DATASET('~hmk::IN::ncmecbystate',mc_byState,CSV(HEADING(1)));
// EXPORT mc_byStateDS := DATASET('~HMK::EXPORT::NCMECByState2-2',mc_byState,CSV(HEADING(1)));

//https://hifld-geoplatform.opendata.arcgis.com/datasets/

//Fire Stations
//Available for public use. 
//None. Acknowledgement of the USGS is appreciated. This dataset is provided as is and intended for general mapping purposes. 
//The information contained in these data are dynamic and could change over time. USGS makes no warranty about content accuracy 
//or currentness of the data and assumes no liability for use of this data. 
//User assumes responsibility for appropriate use and interpretation of the dataset.
EXPORT FireRec := RECORD
    REAL8     Xcoor;
    REAL8     Ycoor;
    UNSIGNED3 objectid;
    STRING40  permanent_identifier;
    STRING30  source_featureid;
    STRING40  source_datasetid;
    STRING50  source_datadesc;
    STRING85  source_originator;
    UNSIGNED1 data_security;
    STRING2   distribution_policy;
    STRING25  loaddate;
    UNSIGNED2 ftype;
    UNSIGNED3 fcode;
    STRING100 name;
    UNSIGNED1 islandmark;
    UNSIGNED1 pointlocationtype;
    UNSIGNED1 admintype;
    STRING60  addressbuildingname;
    STRING65  address;
    STRING35  city;
    STRING2   state;
    STRING10  zipcode;
    UNSIGNED4 gnis_id;
    STRING    foot_id;
    STRING    complex_id;
    STRING38  globalid;
END;

EXPORT FireDS := DATASET('~hmk::in::Fire',FireRec,CSV(HEADING(1)));

//Local Law Enforcement Locations in US
//https://hifld-geoplatform.opendata.arcgis.com/datasets/local-law-enforcement-locations/explore
//License: None (Public Use). 
//Users are advised to read the data set's metadata thoroughly to understand appropriate use and data limitations.
EXPORT PoliceRec := RECORD
    REAL8     xCoor;
    REAL8     yCoor;
    UNSIGNED3 objectid;
    UNSIGNED4 id;
    STRING135 name;
    STRING80  address;
    STRING30  city;
    STRING2   state;
    STRING5   zip;
    STRING15  zip4;
    STRING15  telephone;
    STRING25  type;
    STRING15  status;
    INTEGER3  population;
    STRING25  county;
    STRING5   countyfips;
    STRING3   country;
    REAL8     latitude;
    REAL8     longitude;
    UNSIGNED3 naics_code;
    STRING20  naics_desc;
    STRING145 source;
    STRING25  sourcedate;
    STRING15  val_method;
    STRING25  val_date;
    STRING155 website;
    STRING15  ci_id;
    INTEGER4  csllea08id;
    INTEGER2  subtype1;
    INTEGER2  subtype2;
    INTEGER2  tribal;
    INTEGER2  numpre;
    INTEGER2  numfixsub;
    INTEGER2  nummobile;
    INTEGER3  ftsworn;
    INTEGER3  ftciv;
    INTEGER2  ptsworn;
    INTEGER2  ptciv;
END;

EXPORT PoliceDS := DATASET('~hmk::in::Police',PoliceRec,CSV(HEADING(1)));

EXPORT HospitalRec := RECORD
    REAL8     xCoor;
    REAL8     yCoor;
    UNSIGNED2 objectid;
    STRING10  id;
    STRING95  name;
    STRING80  address;
    STRING35  city;
    STRING2   state;
    STRING5   zip;
    STRING15  zip4;
    STRING15  telephone;
    STRING20  type;
    STRING6   status;
    INTEGER2  population;
    STRING20  county;
    STRING5   countyfips;
    STRING3   country;
    REAL8     latitude;
    REAL8     longitude;
    UNSIGNED3 naics_code;
    STRING70  naics_desc;
    STRING165 source;
    STRING22  sourcedate;
    STRING13  val_method;
    STRING22  val_date;
    STRING206 website;
    STRING15  state_id;
    STRING110 alt_name;
    STRING2   st_fips;
    STRING31  owner;
    INTEGER2  ttl_staff;
    INTEGER2  beds;
    STRING45  trauma;
    STRING15  helipad;
END;

EXPORT HospitalDS := DATASET('~hmk::in::Hospitals',HospitalRec,CSV(HEADING(1)));

//Cities Database
//Free Version: https://simplemaps.com/data/us-cities
//
EXPORT CitiesRec := RECORD
    STRING45  city;
    STRING45  city_ascii;
    STRING2   state_id;
    STRING20  state_name;
    STRING5   county_fips;
    STRING30  county_name;
    REAL4     lat;
    REAL8     lng;
    UNSIGNED4 population;
    REAL4     density;
    STRING5   source;
    STRING5   military;
    STRING5   incorporated;
    STRING30  timezone;
    UNSIGNED1 ranking;
    STRING1855 zips;
    UNSIGNED5 id;
END;

EXPORT City_DS := DATASET('~hmk::in::uscities',citiesrec,CSV(HEADING(1)));

//MORE DATA FROM Homeland Infrastructure Foundation-Level Data (HIFLD)
// https://hifld-geoplatform.opendata.arcgis.com/datasets/geoplatform::all-places-of-worship/explore
//Places of Worship

EXPORT ChurchRec := RECORD
    UNSIGNED3 ___objectid;
    UNSIGNED5 ein;
    STRING70 name;
    STRING35 street;
    STRING22 city;
    STRING2 state;
    UNSIGNED3 zip;
    UNSIGNED1 affiliation;
    UNSIGNED3 ruling;
    UNSIGNED1 foundation;
    UNSIGNED5 activity;
    UNSIGNED1 organization;
    UNSIGNED3 tax_period;
    UNSIGNED1 acct_pd;
    STRING13 ntee_cd;
    STRING13 sort_name;
    STRING13 loc_name;
    STRING1 geocoded_status;
    REAL8 score;
    STRING1 match_type;
    STRING75 match_addr;
    STRING13 addr_type;
    STRING13 addnum;
    STRING13 side;
    STRING13 stpredir;
    STRING19 stpretype;
    STRING29 stname;
    STRING13 sttype;
    STRING13 stdir;
    STRING37 staddr;
    STRING30 city_2;
    STRING23 subregion;
    STRING20 region;
    STRING13 regionabbr;
    STRING13 postal;
    STRING3 country;
    STRING13 langcode;
    UNSIGNED1 distance;
    REAL8 x;
    REAL8 y;
    REAL8 displayx;
    REAL8 displayy;
    REAL8 xmin;
    REAL8 xmax;
    REAL8 ymin;
    REAL8 ymax;
    STRING13 addnumfrom;
    STRING13 addnumto;
    STRING13 rank;
    STRING35 arc_address;
    STRING22 arc_city;
    STRING2 arc_region;
    UNSIGNED3 arc_postal;
END;

EXPORT ChurchDS := DATASET('~hmk::in::churches',churchrec,CSV(HEADING(1)));

//FEMA: 
//https://gis-fema.hub.arcgis.com/datasets/da001dee68474719b934a166f7abdc46/explore
//Food banks
EXPORT FoodBankRec := RECORD
    REAL8 ___x;
    REAL8 y;
    UNSIGNED1 fema_region;
    STRING63 food_bank_name;
    UNSIGNED2 member_number;
    STRING42 address;
    STRING16 city;
    STRING2 state;
    STRING10 zip_code;
    STRING60 web_page;
    STRING100 facebook_page;
    UNSIGNED2 fid;
    STRING11 status;
    STRING36 globalid;
END;

EXPORT FoodBankDS := DATASET('~hmk::in::foodbanks',foodbankrec,CSV(HEADING(1)));
END;