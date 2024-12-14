

import delimited "D:\CSV_Output\Part2\Exempted_Revenue.csv", clear 

drop if(missing(exemptactivitiesdescription))
drop if((totalincome==0 | missing(totalincome)) & (directcostexemptincome==0 | missing(directcostexemptincome)) & (sharejointexpences==0 | missing(sharejointexpences)) & (profitlossexemptincome==0 | missing(profitlossexemptincome)))

recast str exemptactivitiesdescription

merge n:1 exemptactivitiesdescription using "D:\Data_Output\Cleaning_Code\Temp\exemptions.dta", nogen

drop if(missing(declarationid))
keep if(missing(bakhshoodegi_id)==0)
drop v9 D value exemption_id articlekind

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop if(missing(exemptactivitiesdescription))
drop if(missing(return_id))
drop return_id
drop if(missing(id))

merge n:1 bakhshoodegi_id using "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegi_codes.dta", nogen

keep id actyear profitlossexemptincome bakhshoodegi_id bakhshoodegi_description
       
rename profitlossexemptincome Rebate_Amount

sort actyear id
order id actyear bakhshoodegi_id bakhshoodegi_description Rebate_Amount

save "D:\Data_Output\Cleaning_Code\Temp\temp_bakh_in_moaf.dta", replace