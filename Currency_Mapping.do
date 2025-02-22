
import delimited "D:\CSV_Output\Part2\Exports_Imports.csv", clear 

keep exportcurrencyid exportcurrency_val
duplicates drop exportcurrencyid exportcurrency_val, force

rename exportcurrencyid curr_name
rename exportcurrency_val curr_code

save "D:\Data_Output\Cleaning_Code\Temp\temp_curr_export.dta", replace 


import delimited "D:\CSV_Output\Part2\Exports_Imports.csv", clear 

keep importscurrencyid importcurrency_val
duplicates drop importscurrencyid importcurrency_val, force

rename importscurrencyid curr_name
rename importcurrency_val curr_code

append using "D:\Data_Output\Cleaning_Code\Temp\temp_curr_export.dta"

duplicates drop
sort curr_name
drop if(missing(curr_name))

gen counter = _n
gen invalid = "نامشخص"

tostring counter, replace

replace curr_code = invalid + " " + counter if(missing(curr_code))

drop counter invalid

rename curr_name exportcurrencyid 
rename curr_code currency_export

save "D:\Data_Output\Cleaning_Code\Temp\temp_curr_export.dta", replace

rename exportcurrencyid importscurrencyid 
rename currency_export currency_import

save "D:\Data_Output\Cleaning_Code\Temp\temp_curr_import.dta", replace

rename importscurrencyid exportedcurrencyid
rename currency_import currency_exported

save "D:\Data_Output\Cleaning_Code\Temp\temp_curr_exported.dta", replace