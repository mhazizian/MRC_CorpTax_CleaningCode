clear all

global dir "D:\Data_Output\Hoghooghi"
// global dir "~\Documents\Majlis RC\data\tax_return\Hoghooghi"


use "$dir\Moafiat.dta", replace

duplicates drop
duplicates drop id actyear trace_id original_description exemption_description exemption_id Exempted_Profit, force

gsort -Exempted_Profit 

// duplicates tag id actyear trace_id original_description exemption_description exemption_id , gen(tag)

duplicates drop id actyear trace_id exemption_description exemption_id original_description, force


save "$dir\Moafiat.dta", replace