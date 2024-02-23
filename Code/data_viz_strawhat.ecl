// HPCC = Hiigh Performace Computer Clusters
// Program the Language to get what we want, Declaritive Function
// A bunch of functions that runs the operations for you

//  Police has X, and Y coordinates

// Hospitals has Address Names and X, Y coordinates

// #OPTION('obfuscateOutput', TRUE);

IMPORT $.File_AllData;
// IMPORT Visualizer;

// _usStates := DATASET([{'AL', 4779736},                          
// {'AK', 710231},                          
// {'AZ', 6392017},                          
// {'AR', 2915918}],                         
// {STRING State, INTEGER4 weight});  

// data_usStates := OUTPUT(_usStates, NAMED('choro_usStates'));  
// data_usStates;  

// viz_usstates := Visualizer.Choropleth.USStates('usStates',, 'choro_usStates');  
// viz_usstates;

IMPORT Visualizer; 
ds := DATASET([ {'English', 5},                
{'History', 17},                
{'Geography', 7},                
{'Chemistry', 16},                
{'Irish', 26},                
{'Spanish', 67},                
{'Bioligy', 66},                
{'Physics', 46},                
{'Math', 98}],                
{STRING subject, INTEGER4 year}); 

data_example := OUTPUT(ds, NAMED('Chart2D__test')); 
data_example; 

Visualizer.TwoD.Bubble('bubble',, 'Chart2D__test'); 


