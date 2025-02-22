****************************************************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear costcont* trace_id

destring costcont* trace_id, replace ignore("NULL")

rename costcontractormaterial T12_R01
rename costcontractorfee T12_R02
rename costcontractorsecondhand T12_R03
rename costcontractorrentmachin T12_R04
rename costcontractordepreciate T12_R05
rename costcontractoretc T12_R06
rename costcontractorcyclesum T12_R07
rename costcontractorduringfirst T12_R08
rename costcontractorduringend T12_R09
rename costcontractorsum T12_R10


save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace



**************************************************************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98.csv", clear 


drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

keep id actyear costcont* trace_id

destring costcont* trace_id, replace ignore("NULL")

rename costcontractormaterial T12_R01
rename costcontractorfee T12_R02
rename costcontractorsecondhand T12_R03
rename costcontractorrentmachin T12_R04
rename costcontractordepreciate T12_R05
rename costcontractoretc T12_R06
rename costcontractorcyclesum T12_R07
rename costcontractorduringfirst T12_R08
rename costcontractorduringend T12_R09
rename costcontractorsum T12_R10
rename costcontractormaterialinternal T12_R01_D
rename costcontractormaterialforeign T12_R01_F
rename costcontractorfeeinternal T12_R02_D
rename costcontractorfeeforeign T12_R02_F
rename costcontractorsecondhandinternal T12_R03_D
rename costcontractorsecondhandforeign T12_R03_F
rename costcontractorrentmachininternal T12_R04_D
rename costcontractorrentmachinforeign T12_R04_F
rename costcontractordepreciateinternal T12_R05_D
rename costcontractordepreciateforeign T12_R05_F
rename costcontractoretcinternal T12_R06_D
rename costcontractoretcforeign T12_R06_F
rename costcontractorcyclesuminternal T12_R07_D
rename costcontractorcyclesumforeign T12_R07_F
rename costcontractorduringfirstinterna T12_R08_D
rename costcontractorduringfirstforeign T12_R08_F
rename costcontractorduringendinternal T12_R09_D
rename costcontractorduringendforeign T12_R09_F
rename costcontractorsuminternal T12_R10_D
rename costcontractorsumforeign T12_R10_F


append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"

merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

sort actyear id
order id actyear trace_id


save "D:\Data_Output\Hoghooghi\Baha_Kar.dta", replace