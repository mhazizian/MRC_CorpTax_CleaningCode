clear all

global dir "D:\Data_Output\Hoghooghi"
// global dir "~\Documents\Majlis RC\data\tax_return\Hoghooghi"


use "$dir\Moafiat.dta", replace

duplicates drop


gsort -Exempted_Profit 
egen flag = tag(id actyear trace_id exemption_description original_description)
duplicates drop id actyear trace_id exemption_description original_description flag, force

drop if flag == 0
drop flag


save "$dir\Moafiat.dta", replace