*This program is written for Stata and for microdata provided by IPUMS. For those using other base data or programs, it should clarify the variables by which you can merge the backcast file with your data.

*Open or import CPS Census Backcast THP Upjohn data file to get a sense for the setup and save*

*Use your CPS Monthly microdata. You will need to construct race/ethnicity and age variables to match to the backcast file. These cells were selected to match the smallest cells that The Census Bureau provided to assess the effect of the population adjustments in January 2022 and January 2023.

/// Race/Ethnicity
gen ethnic=.
replace ethnic=6 if inrange(hispan,100,902) & ethnic==. 
replace ethnic=1 if race==100  & ethnic==. 
replace ethnic=2 if race==200  & ethnic==. 
replace ethnic=4 if race==651  & ethnic==. 
replace ethnic=5 if inlist(race, 300, 650) & ethnic==. 
replace ethnic=5 if inrange(race, 652, 830) & ethnic==. 
label define ethniclab 1 "white" 2 "Black" 3 "Hispanic" 4 "other"
label values ethnic ethniclab

/// Age Groups
gen agegr=.
replace agegr = 1 if inrange(age, 16, 17)
replace agegr = 2 if inrange(age, 18, 19) 
replace agegr = 3 if inrange(age, 20, 24) 
replace agegr = 4 if inrange(age, 25, 54) 
replace agegr = 5 if inrange(age, 35, 44) 
replace agegr = 6 if inrange(age, 45, 54) 
replace agegr = 7 if inrange(age, 55, 64) 
replace agegr = 8 if inrange(age, 65, 90) 


label define agegrlab 1 "16-17" 2 "18-19" 3 "20-24" 4 "25-34" 5 "35-44" 6 "45-54" 7 "55-64" 8 "65+"
label values agegr agegrlab

*merge backcast file with your data

/// Merge

merge m:1 month year sex agegr ethnic using "backcast file"

/// Weights

*we have provided the monthly and annual weights for the provided weights and the backcast weights.
*monthly adjusted: wtfinl_adj, compwt_adj
*annual provided: wtfinlann, compwtann
*annual adjusted: wtfinl_adjann compwt_adjann

