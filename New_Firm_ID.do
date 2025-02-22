

import delimited "D:\CSV_Output\Part2\Compute_Tax.csv", clear 

duplicates drop declarationid, force

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)

rename declarationid return_id

merge 1:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop if(missing(return_id))
drop return_id

drop netprofitloss profitlossadjust adddeductprofitloss exemptrevenue netwindfallincome surplusfinancialaidpaid totaladjust lossnonexemptactivity taxableincomeafterdeduction accumulatdepreciatloss lossofart165 grosstaxableincome chamberofcommerceportion netdeclartaxableincome taxart105 taxrebate taxdiscountt7 payabletax windfalltaxableincome windfallincometax taxpaid remainpayabletax increaseratio havechamberofcommerceportio 

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace




import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id 

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace




// import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_financial.csv", clear 
import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"


keep id
duplicates drop
gen new_id = _n
replace new_id = new_id + 10000000
save "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", replace