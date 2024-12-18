

///////////////////////////////////////////////////////////////////////////////
// Code Author: Karina Shyrokykhy
// This code was used for inferential analysis for an article entitled "Black knight NGOs and international disinformation"
// Piblished in European Security
// Year: 2024
// ORCID: https://doi.org/10.1080/09662839.2024.2437781
///////////////////////////////////////////////////////////////////////////////

use "mydata_h2_3.dta", clear

gen followers = .
replace followers = 902 if name_swedhr == 1
replace followers = 5246 if name_prof == 1
replace followers = 1046 if name_swedhr != 1 & name_prof !=1


hist n_retweets
gen log_retweets = log(n_retweets)
gen sqrt_retweets = sqrt(n_retweets)
hist log_retweets
hist sqrt_retweets

sum n_retweets 

nbreg n_retweets is_about_cw n_likes is_swedhr, vce (cluster fullname)
est sto m3_nb

nbreg n_retweets is_about_cw n_likes is_swedhr, vce (cluster fullname) irr
est sto m3_nb_irr

// summary statistics and correlations (Appendix)
sum n_retweets is_swedhr is_about_cw n_likes followers
cor n_retweets is_swedhr is_about_cw n_likes followers


//Model 1, Table 1
nbreg n_retweets is_swedhr is_about_cw n_likes followers, vce (cluster fullname) irr
est sto m3_nb_irr

// To generate a table
esttab m5_nb_irr using ///
"../Table_1.rtf", ///
legend label title(Table 5. )  eform replace


