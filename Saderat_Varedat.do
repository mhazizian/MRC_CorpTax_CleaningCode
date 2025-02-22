

import delimited "D:\CSV_Output\Part2\Exports_Imports.csv", clear 

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

replace percentageofzerotaxrrate = substr(percentageofzerotaxrrate,1,strpos(percentageofzerotaxrrate,"/")-1)

keep return_id exportsgoodsvalue exportcurrencyid exportrialvalue exportedforeigncurrency percentageofzerotaxrrate exportedcurrencyid importsgoodsvalue importscurrencyid importsrialvalue rialvalue

destring percentageofzerotaxrrate, replace
 
gen valid = 0
foreach j of varlist exportsgoodsvalue exportrialvalue exportedforeigncurrency percentageofzerotaxrrate importsgoodsvalue importsrialvalue rialvalue {
	replace valid = 1 if(missing(`j')==0 & `j'!=0)
}
keep if(valid==1)
drop valid

merge n:1 exportcurrencyid using "D:\Data_Output\Cleaning_Code\Temp\temp_curr_export.dta", nogen
merge n:1 exportedcurrencyid using "D:\Data_Output\Cleaning_Code\Temp\temp_curr_exported.dta", nogen
merge n:1 importscurrencyid using "D:\Data_Output\Cleaning_Code\Temp\temp_curr_import.dta", nogen

drop if(missing(return_id))
drop exportcurrencyid exportedcurrencyid importscurrencyid

merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

gen valid = 0
foreach j of varlist exportsgoodsvalue exportrialvalue exportedforeigncurrency percentageofzerotaxrrate importsgoodsvalue importsrialvalue rialvalue {
	replace valid = 1 if(missing(`j')==0 & `j'!=0)
}
keep if(valid==1)
drop valid

drop return_id

rename exportsgoodsvalue T07_export_good_value
rename exportrialvalue T07_export_rial_value
rename exportedforeigncurrency T07_exported_good_value
rename rialvalue T07_exported_rial_value
rename importsgoodsvalue T07_import_good_value
rename importsrialvalue T07_import_rial_value
rename currency_export T07_export_cur
rename currency_exported T07_exported_cur
rename currency_import T07_import_cur
rename percentageofzerotaxrrate T07_zero_rate_percentage


save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace


****************************************************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear trace_id customs*

foreach j of varlist customs* {
	replace `j' = "" if(`j'=="NULL")
}

gen valid = 0
foreach j of varlist customs* {
	replace valid = 1 if(missing(`j')==0)
}
keep if(valid==1)
drop valid

reshape long customsexpcurrencyprice customsexpcurrencytype customsexprialsprice customsrcpcurrencyprice customsrcpcurrencytype customsimpcurrencyprice customsimpcurrencytype customsimprialsprice customstotalrialsprice, i(id trace_id actyear) j(code) string

destring customs* trace_id, replace ignore("NULL")

gen valid = 0
foreach j of varlist customsexpcurrencyprice customsexprialsprice customsrcpcurrencyprice customsimpcurrencyprice customsimprialsprice customstotalrialsprice {
	replace valid = 1 if(missing(`j')==0 & `j'!=0)
}
keep if(valid==1)
drop valid

rename customsexpcurrencyprice T07_export_good_value
rename customsexprialsprice T07_export_rial_value
rename customsrcpcurrencyprice T07_exported_good_value
rename customsimpcurrencyprice T07_exported_rial_value
rename customsimprialsprice T07_import_good_value
rename customstotalrialsprice T07_import_rial_value
rename customsexpcurrencytype T07_export_cur
rename customsrcpcurrencytype T07_exported_cur
rename customsimpcurrencytype T07_import_cur


save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace


**************************************************************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear trace_id customs*

gen valid = 0
foreach j of varlist customs* {
	replace valid = 1 if(missing(`j')==0)
}
keep if(valid==1)
drop valid

foreach i of varlist customsexpcurrencyprice* customsrcpcurrencyprice* customsimpcurrencyprice* customsimprialsprice* {
    capture confirm string variable `i'
	if(_rc==0){
	    replace `i' = substr(`i',1,strpos(`i',"/")-1)
	}
}

destring customs* trace_id, replace ignore("NULL")

foreach i of varlist customs*id* {
	rename `i' new`i'
}

reshape long customsexpcurrencyprice newcustomsexpcurrencytypeid customsexpcurrencytype customsexprialsprice customsrcpcurrencyprice newcustomsrcpcurrencytypeid customsrcpcurrencytype customsimpcurrencyprice newcustomsimpcurrencytypeid customsimpcurrencytype customsimprialsprice customstotalrialsprice, i(id trace_id actyear) j(code) string

rename newcustomsexpcurrencytypeid customsexpcurrencytypeid
rename newcustomsrcpcurrencytypeid customsrcpcurrencytypeid
rename newcustomsimpcurrencytypeid customsimpcurrencytypeid

gen valid = 0
foreach j of varlist customsexpcurrencyprice customsexprialsprice customsrcpcurrencyprice customsimpcurrencyprice customsimprialsprice customstotalrialsprice customsexpcurrencytypeid customsrcpcurrencytypeid customsimpcurrencytypeid {
	replace valid = 1 if(missing(`j')==0 & `j'!=0)
}
keep if(valid==1)
drop valid

rename customsexpcurrencyprice T07_export_good_value
rename customsexprialsprice T07_export_rial_value
rename customsrcpcurrencyprice T07_exported_good_value
rename customsimpcurrencyprice T07_exported_rial_value
rename customsimprialsprice T07_import_good_value
rename customstotalrialsprice T07_import_rial_value
rename customsexpcurrencytype T07_export_cur
rename customsrcpcurrencytype T07_exported_cur
rename customsimpcurrencytype T07_import_cur
rename customsexpcurrencytypeid T07_export_cur_id
rename customsrcpcurrencytypeid T07_exported_cur_id
rename customsimpcurrencytypeid T07_import_cur_id


append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"


replace code = "مجموع" if(code=="s")
replace code = "" if(code != "مجموع")

merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id
drop if(missing(trace_id))


sort actyear id
order id actyear trace_id


save "D:\Data_Output\Hoghooghi\Export_Import.dta", replace