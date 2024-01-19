*Load sample dataset
use sample_dataset_clean, clear

********************************************************************************
*DERIVE AGE AND TIME VARIABLES
********************************************************************************

*Create variable for time in 10 year intervals 
gen time10 = time/10 

*Centre age at 65 years
gen age65 = age-65

*Duration
bysort id: egen duration = max(time)

********************************************************************************
*DESCRIPTIVE ANALYSES
********************************************************************************

*Continuous variables
foreach var of varlist beh* {
	ttest age0 if n == 1, by(`var')
}

*Categorical variables
local col_vars beh1 beh2 
local row_vars gender edu wealth5 hbp hchol heart lung diabe ///
	cancr psy  
	
foreach col in `col_vars' {
	foreach row in `row_vars' {
		tab  `row' `col' if n == 1, chi2 col
	}
}

*Median follow up duration by behaviours
foreach var of varlist beh* {
	bysort `var': sum duration if n == 1, det
}

*Median follow up duration by lifestyle
bysort lifestyle: sum duration if n == 1, det

*Mean cognitive score at baseline by lifestyle
bysort lifestyle: sum zmem if wave == 1
bysort lifestyle: sum zverb if wave == 1

********************************************************************************
*MEMORY
********************************************************************************

***Independent assocations between each behaviour and 10-year memory decline
foreach var of varlist beh1 beh2 {
	mixed zmem ///
		i.`var' ///
		i.`var'##c.time10##c.time10 ///
		///
		c.time10##c.time10##c.age65 i.country i.edu i.gender c.age65 ///
		i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
		c.wealth5 ///
		///
		|| id: time10, cov(uns)
	
	*Decline over 10 years
	lincom 1.`var'#c.time10 + 1.`var'#c.time10#c.time10
}


***Association between lifestyle and 10-year memory decline (ref: lifestyle 4)
mixed zmem ///
	ib4.lifestyle ///
	ib4.lifestyle##c.time10##c.time10 ///
	///
	c.time10##c.time10##c.age65 i.country i.edu i.gender c.age65 ///
	i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
	c.wealth5 ///
	///
	|| id: time10, cov(uns)

**Differences in 10-year decline between lifestyles
forval i=1/3 {
	di "Lifestyle `i' vs. lifestyle 4"
	lincom `i'.lifestyle#c.time10 + `i'.lifestyle#c.time10#c.time10
}


********************************************************************************
*FLUENCY
********************************************************************************

***Independent assocations between each behaviour and 10-year memory decline
foreach var of varlist beh1 beh2 {
	mixed zverb ///
		i.`var' ///
		i.`var'##c.time10 ///
		///
		c.time10##c.age65 i.country i.edu i.gender c.age65 ///
		i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
		c.wealth5 ///
		///
		|| id: time10, cov(uns)
	
	*Difference in decline over 10 years
	lincom 1.`var'#c.time10 
}


***Association between lifestyle and 10-year fluency decline (ref: lifestyle 4)
mixed zverb ///
	ib4.lifestyle ///
	ib4.lifestyle##c.time10 ///
	///
	c.time10##c.age65 i.country i.edu i.gender c.age65 ///
	i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
	c.wealth5 ///
	///
	|| id: time10, cov(uns)

**Differences in 10-year decline between lifestyles
forval i=1/3 {
	di "Lifestyle `i' vs. lifestyle 4"
	lincom `i'.lifestyle#c.time10 
}

