

import delimited "D:\CSV_Output\Part2\Tax_Exemptions.csv", delimiter("؛") clear 
destring taxableprofit taxableprofittax rebatecaserate rebateamount, replace ignore("NULL")

drop rebatecase_val
drop if(missing(rebatecase_desc))
drop if((taxableprofit==0 | missing(taxableprofit)) & (taxableprofittax==0 | missing(taxableprofittax)) & (rebatecaserate==0 | missing(rebatecaserate)) & (rebateamount==0 | missing(rebateamount)))

recast str rebatecase_desc

gen bakhsh_id = 2 if(strpos(rebatecase_desc, "شرکت‌هایی که سهام آنها برای معامله خارج از بازارهای بورس داخلی یا خارجی پذیرفته شده است مورد تایید سازمان (ماده 143ق.م.م) ـ کمتر از ٪۲۰ سهام شناور آزاد"))
replace bakhsh_id = 5 if(strpos(rebatecase_desc, "شرکت‌هایی که سهام آنها برای معامله در بازارهای بورس داخلی یا خارجی پذیرفته شده است (ماده 143ق.م.م) ـ کمتر از ٪۲۰ سهام شناور آزاد"))
replace bakhsh_id = 17 if(rebatecase_desc=="بخشودگی مالیات ، موضوع بند م تبصره 6 قانون بودجه سال 1402 کل کشور ")
replace bakhsh_id = 15 if(rebatecase_desc=="بخشودگی مالیات ، موضوع بند ن تبصره 6 قانون بودجه سال 1401 کل کشور ")
replace bakhsh_id = 18 if(rebatecase_desc=="بخشودگی مالیات ، موضوع قانون بودجه کل کشور (بند ن)")
replace bakhsh_id = 13 if(rebatecase_desc=="بخشودگی مالیاتی هزینه های تحقیقاتی و پژوهشی موضوع بند (س) ماده 132 ق.‌م‌.م ")
replace bakhsh_id = 19 if(rebatecase_desc=="تخفیف در نرخ بخشودگی مالیاتی (تبصره 7 ماده 105)")
replace bakhsh_id = 11 if(rebatecase_desc=="تخفیف در نرخ مالیاتی شرکتهای خارجی برای تولید محصولات با نشان معتبرموضوع قسمت اخیر بند <خ> ماده 132 ق.م.م.")
replace bakhsh_id = 7 if(rebatecase_desc=="توسعه، نوسازی و بازسازی واحدهای صنعتی و معدنی (ماده 138 ق.م.م)")
replace bakhsh_id = 12 if(rebatecase_desc=="سایر بخشودگی‌ها")
replace bakhsh_id = 3 if(rebatecase_desc=="شرکتهایی که سهام ان ها برای معامله خارج از بازارهای بورس داخلی یا خارجی پذیرفته شده است مورد تایید سازمان (ماده ۱۴۳ ق.م.م) - ٪۲۰ و بیشتر سهام شناور آزاد ")
replace bakhsh_id = 16 if(rebatecase_desc=="شرکت‌های تعاونی تا سقف درآمد مشمول مالیات ابرازی  (تبصره 6 ماده 105 ق.م.م)")
replace bakhsh_id = 6 if(rebatecase_desc=="شرکت‌هایی که سهام آنها برای معامله در بازارهای بورس داخلی یا خارجی پذیرفته شده است (ماده ۱۴۳ ق.م.م) ـ ٪۲۰ و بیشتر سهام شناور آزاد")
replace bakhsh_id = 4 if(rebatecase_desc=="كالاهاي فروش رفته در بازار بورس کالا (ماده 143 ق.م.م) ـ کمتر از ٪۲۰ سهام شناور آزاد")
replace bakhsh_id = 8 if(rebatecase_desc=="مالیات پرداختی در سایر کشورها (مربوط به درآمدهای خارج از کشورهای - تبصره ماده 180 ق.م.م)")
replace bakhsh_id = 14 if(rebatecase_desc=="معافیت موضوع درآمد ابرازی کلیه تاسیسات ایرانگردی وجهانگردی برای پروانه های بهره برداری که قبل ازاجرای این قانون اخذ گردیده است")
replace bakhsh_id = 10 if(rebatecase_desc=="معافیت موضوع درآمد ابرازی کلیه تاسیسات ایرانگردی وجهانگردی برای پروانه های بهره برداری که قبل ازاجرای این قانون اخذ گردیده است( بند")
replace bakhsh_id = 9 if(rebatecase_desc=="معافیت های ناشی از موافقت‌نامه‌های مالیاتی موضوع ماده 168 ق.م.م")
replace bakhsh_id = 1 if(rebatecase_desc=="کالاهای فروش رفته در بازار بورس کالا (ماده ۱۴۳ ق.م.م) ـ٪۲۰ و بیشتر سهام شناور آزاد")

merge n:1 bakhsh_id using "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegiha.dta", nogen

drop if(missing(declarationid))
keep if(missing(exemption_id))
drop exemption_id bakhsh_id

replace declarationid = subinstr(declarationid,"}", "",.)
replace declarationid = subinstr(declarationid,"{", "",.)
rename declarationid return_id

merge n:1 return_id using "D:\Data_Output\Cleaning_Code\Temp\temp_id.dta", nogen

drop if(missing(rebatecase_desc))
drop if(missing(return_id))
drop return_id
drop if(missing(id))

merge n:1 bakhshoodegi_id using "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegi_codes.dta", nogen

drop rebatecase_desc
rename taxableprofit Taxable_Profit
rename taxableprofittax Taxable_Profit_Tax
rename rebatecaserate Rebate_Rate
rename rebateamount Rebate_Amount

sort actyear id
order id actyear bakhshoodegi_description bakhshoodegi_id Taxable_Profit Taxable_Profit_Tax Rebate_Rate Rebate_Amount

save "D:\Data_Output\Cleaning_Code\Temp\temp1.dta", replace


******************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_91.csv", delimiter("؛") encoding(UTF-8) clear 

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

duplicates drop id actyear, force ////// Concern

keep id actyear bakhshoodegi* 
drop bakhshoodegi *sum

destring bakhshoodegi*, replace ignore("NULL")

rename bakhshoodegibenefit* Taxable_Profit*
rename bakhshoodegitax* Taxable_Profit_Tax*
rename bakhshoodegirate* Rebate_Rate*
rename bakhshoodegiqty* Rebate_Amount*

reshape long Taxable_Profit Taxable_Profit_Tax Rebate_Rate Rebate_Amount, i(id actyear) j(code)

drop if((Taxable_Profit==0 | missing(Taxable_Profit)) & (Taxable_Profit_Tax==0 | missing(Taxable_Profit_Tax)) & (Rebate_Amount==0 | missing(Rebate_Amount)))

gen exemption_id = .
replace exemption_id = 115 if(code==9)
replace exemption_id = 114 if(code==10)

gen bakhshoodegi_id = .
replace bakhshoodegi_id = 1 if(code==1)
replace bakhshoodegi_id = 6 if(code==2)
replace bakhshoodegi_id = 7 if(code==3)
replace bakhshoodegi_id = 8 if(code==4)
replace bakhshoodegi_id = 10 if(code==5)
replace bakhshoodegi_id = 11 if(code==6)
replace bakhshoodegi_id = 215 if(code==7)
replace bakhshoodegi_id = 216 if(code==8)
replace bakhshoodegi_id = 12 if(code==11)

merge n:1 bakhshoodegi_id using "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegi_codes.dta", nogen

drop if(missing(id))
drop if(missing(bakhshoodegi_description))
drop code exemption_id

sort actyear id
order id actyear bakhshoodegi_description bakhshoodegi_id Taxable_Profit Taxable_Profit_Tax Rebate_Rate Rebate_Amount

save "D:\Data_Output\Cleaning_Code\Temp\temp2.dta", replace



******************************
import delimited "D:\CSV_Output\Part1\Hoghooghi_92_98_financial.csv", clear

drop if(missing(actyear))
replace nat_guid = subinstr(nat_guid,"}", "",.)
replace nat_guid = subinstr(nat_guid,"{", "",.)
rename nat_guid id

duplicates drop id actyear, force ////// Concern

keep id actyear bakhshoodegi* 
drop bakhshoodegi *sum

destring bakhshoodegi*, replace ignore("NULL/")

gen bakhshoodegi = 0
foreach i of varlist bakhshoodegi* {
	replace bakhshoodegi = 1 if(missing(`i')==0 & `i'!=0)
}

keep if(bakhshoodegi==1)
drop bakhshoodegi

rename bakhshoodegibenefit* Taxable_Profit*
rename bakhshoodegitax* Taxable_Profit_Tax*
rename bakhshoodegirate* Rebate_Rate*
rename bakhshoodegiqty* Rebate_Amount*

reshape long Taxable_Profit Taxable_Profit_Tax Rebate_Rate Rebate_Amount, i(id actyear) j(code)

drop if((Taxable_Profit==0 | missing(Taxable_Profit)) & (Taxable_Profit_Tax==0 | missing(Taxable_Profit_Tax)) & (Rebate_Amount==0 | missing(Rebate_Amount)))

replace Rebate_Rate = Rebate_Rate / 10000

gen exemption_id = .
replace exemption_id = 115 if(code==9)
replace exemption_id = 114 if(code==10)

gen bakhshoodegi_id = .
replace bakhshoodegi_id = 1 if(code==1)
replace bakhshoodegi_id = 6 if(code==2)
replace bakhshoodegi_id = 7 if(code==3)
replace bakhshoodegi_id = 8 if(code==4)
replace bakhshoodegi_id = 10 if(code==5)
replace bakhshoodegi_id = 11 if(code==6)
replace bakhshoodegi_id = 215 if(code==7)
replace bakhshoodegi_id = 216 if(code==8)
replace bakhshoodegi_id = 12 if(code==11)
replace bakhshoodegi_id = 4 if(code==12)
replace bakhshoodegi_id = 5 if(code==13)
*replace bakhshoodegi_id =  if(code==14)
*replace bakhshoodegi_id =  if(code==15)

merge n:1 bakhshoodegi_id using "D:\Data_Output\Cleaning_Code\Temp\bakhshoodegi_codes.dta", nogen

drop if(missing(id))
drop if(missing(bakhshoodegi_description))
drop code exemption_id

sort actyear id
order id actyear bakhshoodegi_description bakhshoodegi_id Taxable_Profit Taxable_Profit_Tax Rebate_Rate Rebate_Amount

append using "D:\Data_Output\Cleaning_Code\Temp\temp2.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp1.dta"
append using "D:\Data_Output\Cleaning_Code\Temp\temp_bakh_in_moaf.dta"


merge n:1 id using "D:\Data_Output\Cleaning_Code\Temp\temp_id_new.dta", nogen
drop id
rename new_id id

drop if((Taxable_Profit==0 | missing(Taxable_Profit)) & (Taxable_Profit_Tax==0 | missing(Taxable_Profit_Tax)) & (Rebate_Amount==0 | missing(Rebate_Amount)))

sort actyear id
order id actyear

encode bakhshoodegi_description, gen(temp)
drop bakhshoodegi_description
rename temp bakhshoodegi_description

sort actyear id
order id actyear bakhshoodegi_description bakhshoodegi_id Taxable_Profit Taxable_Profit_Tax Rebate_Rate Rebate_Amount

save "D:\Data_Output\Hoghooghi\Bakhshhodegi.dta", replace