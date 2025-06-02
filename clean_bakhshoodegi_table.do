clear all

// global dir "D:\Data_Output\Hoghooghi"
global dir "~\Documents\Majlis RC\data\tax_return\Hoghooghi"


use "$dir\Bakhshhodegi.dta", replace

gsort -Rebate_Amount 

duplicates drop
duplicates drop id actyear trace_id bakhshoodegi_description bakhshoodegi_id Rebate_Amount , force


// duplicates tag id actyear trace_id bakhshoodegi_description bakhshoodegi_id , gen(tag)

duplicates drop id actyear trace_id bakhshoodegi_description bakhshoodegi_id , force


save "$dir\Bakhshhodegi.dta", replace