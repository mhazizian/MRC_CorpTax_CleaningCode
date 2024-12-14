


import delimited "D:\CSV_Output\Part1\Hoghooghi_99_1401.csv", clear 

keep id_table nat_guid taxyear

replace id_table = subinstr(id_table,"}", "",.)
replace id_table = subinstr(id_table,"{", "",.)
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)

rename id_table return_id
rename nat_guid id
rename taxyear actyear

save "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", replace