
/************************************************************************************
*ClimateXChange project: 
"Evidence assessment - understanding the climate impact of food consumed in Scotland"

*Do file for exporting tables to Excel

Author: Cristina Stewart
Date: 30th Nov 2023
************************************************************************************/

****************
*Clear settings
****************
clear all
clear matrix
macro drop _all
graph drop _all


**************************************************************
*Assign values using global macros for file location and date
**************************************************************
global location "K:\DrJaacksGroup\FSS - Dietary Monitoring\SHeS\SHeS 2021" 
global data `"$location\Data"'
global date "20231016"


*Read in data
use "$data\SHeS 2021_participantlevel__CXC_$date.dta", clear
*Assign survey sampling variables
svyset [pweight=SHeS_Intake24_wt_sc], psu(psu) strata(Strata)


/************************************
Mean daily intakes of food categories
************************************/

matrix avgintakes = J(555, 6, .)
local r=4

quietly foreach var of varlist Avg_Day_FC_1 Avg_Day_FC_2 Avg_Day_FC_3 Avg_Day_FC_4 Avg_Day_FC_5 Avg_Day_FC_6 Avg_Day_FC_7 Avg_Day_FC_8 Avg_Day_FC_9 Avg_Day_FC_10 Avg_Day_FC_11 Avg_Day_FC_12 Avg_Day_FC_13 Avg_Day_FC_14 Avg_Day_FC_15 Avg_Day_FC_16 Avg_Day_FC_17 Avg_Day_FC_18 {
	
		*overall
		sum `var'
		matrix avgintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix avgintakes[`r',2]=r(mean) 
		matrix avgintakes[`r',4]=r(sd) 
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc], p(2.5, 50, 97.5)
		matrix avgintakes[`r',3]=r(r2) 
		matrix avgintakes[`r',5]=r(r1) 
		matrix avgintakes[`r',6]=r(r3) 
		
		*by sex
		*female
		sum `var' if Sex==2 
		matrix avgintakes[`r'+19,1]=r(N) 

		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if Sex==2, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+19,3]=r(r2) 
		matrix avgintakes[`r'+19,5]=r(r1) 
		matrix avgintakes[`r'+19,6]=r(r3) 
	
		*male
		sum `var' if Sex==1 
		matrix avgintakes[`r'+38,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if Sex==1, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+38,3]=r(r2) 
		matrix avgintakes[`r'+38,5]=r(r1) 
		matrix avgintakes[`r'+38,6]=r(r3)
 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix avgintakes[`r'+19,2]=r(mean)[1,2] 
		matrix avgintakes[`r'+19,4]=r(sd)[1,2]
		
		matrix avgintakes[`r'+38,2]=r(mean)[1,1] 
		matrix avgintakes[`r'+38,4]=r(sd)[1,1]
	

		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix avgintakes[`r'+57,1]=r(N) 

		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==1, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+57,3]=r(r2) 
		matrix avgintakes[`r'+57,5]=r(r1) 
		matrix avgintakes[`r'+57,6]=r(r3) 
		
		*25-34
		sum `var' if age_cat==2
		matrix avgintakes[`r'+76,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==2, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+76,3]=r(r2) 
		matrix avgintakes[`r'+76,5]=r(r1) 
		matrix avgintakes[`r'+76,6]=r(r3)
		
 		*35-44
		sum `var' if age_cat==3
		matrix avgintakes[`r'+95,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==3, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+95,3]=r(r2) 
		matrix avgintakes[`r'+95,5]=r(r1) 
		matrix avgintakes[`r'+95,6]=r(r3)	
			
 		*45-54
		sum `var' if age_cat==4
		matrix avgintakes[`r'+114,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==4, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+114,3]=r(r2) 
		matrix avgintakes[`r'+114,5]=r(r1) 
		matrix avgintakes[`r'+114,6]=r(r3)
			
 		*55-64
		sum `var' if age_cat==5
		matrix avgintakes[`r'+133,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==5, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+133,3]=r(r2) 
		matrix avgintakes[`r'+133,5]=r(r1) 
		matrix avgintakes[`r'+133,6]=r(r3)		
				
 		*65-74
		sum `var' if age_cat==6
		matrix avgintakes[`r'+152,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==6, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+152,3]=r(r2) 
		matrix avgintakes[`r'+152,5]=r(r1) 
		matrix avgintakes[`r'+152,6]=r(r3)			
					
 		*75+
		sum `var' if age_cat==7
		matrix avgintakes[`r'+171,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if age_cat==7, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+171,3]=r(r2) 
		matrix avgintakes[`r'+171,5]=r(r1) 
		matrix avgintakes[`r'+171,6]=r(r3)	
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix avgintakes[`r'+57,2]=r(mean)[1,1] 
		matrix avgintakes[`r'+57,4]=r(sd)[1,1] 
		matrix avgintakes[`r'+76,2]=r(mean)[1,2] 
		matrix avgintakes[`r'+76,4]=r(sd)[1,2] 
		matrix avgintakes[`r'+95,2]=r(mean)[1,3] 
		matrix avgintakes[`r'+95,4]=r(sd)[1,3]	
		matrix avgintakes[`r'+114,2]=r(mean)[1,4] 
		matrix avgintakes[`r'+114,4]=r(sd)[1,4]	
		matrix avgintakes[`r'+133,2]=r(mean)[1,5] 
		matrix avgintakes[`r'+133,4]=r(sd)[1,5]	
		matrix avgintakes[`r'+152,2]=r(mean)[1,6] 
		matrix avgintakes[`r'+152,4]=r(sd)[1,6]	
		matrix avgintakes[`r'+171,2]=r(mean)[1,7] 
		matrix avgintakes[`r'+171,4]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix avgintakes[`r'+190,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if simd20_sga==1, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+190,3]=r(r2) 
		matrix avgintakes[`r'+190,5]=r(r1) 
		matrix avgintakes[`r'+190,6]=r(r3)	

		*SIMD 2
		sum `var' if simd20_sga==2
		matrix avgintakes[`r'+209,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if simd20_sga==2, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+209,3]=r(r2) 
		matrix avgintakes[`r'+209,5]=r(r1) 
		matrix avgintakes[`r'+209,6]=r(r3)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix avgintakes[`r'+228,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if simd20_sga==3, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+228,3]=r(r2) 
		matrix avgintakes[`r'+228,5]=r(r1) 
		matrix avgintakes[`r'+228,6]=r(r3)
				
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix avgintakes[`r'+247,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if simd20_sga==4, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+247,3]=r(r2) 
		matrix avgintakes[`r'+247,5]=r(r1) 
		matrix avgintakes[`r'+247,6]=r(r3)

		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix avgintakes[`r'+266,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if simd20_sga==5, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+266,3]=r(r2) 
		matrix avgintakes[`r'+266,5]=r(r1) 
		matrix avgintakes[`r'+266,6]=r(r3)
		
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix avgintakes[`r'+190,2]=r(mean)[1,1] 
		matrix avgintakes[`r'+190,4]=r(sd)[1,1] 
		matrix avgintakes[`r'+209,2]=r(mean)[1,2] 
		matrix avgintakes[`r'+209,4]=r(sd)[1,2] 
		matrix avgintakes[`r'+228,2]=r(mean)[1,3] 
		matrix avgintakes[`r'+228,4]=r(sd)[1,3]
		matrix avgintakes[`r'+247,2]=r(mean)[1,4] 
		matrix avgintakes[`r'+247,4]=r(sd)[1,4]
		matrix avgintakes[`r'+266,2]=r(mean)[1,5] 
		matrix avgintakes[`r'+266,4]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix avgintakes[`r'+285,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==1, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+285,3]=r(r2) 
		matrix avgintakes[`r'+285,5]=r(r1) 
		matrix avgintakes[`r'+285,6]=r(r3)	

		*Borders
		sum `var' if HBCode==2
		matrix avgintakes[`r'+304,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==2, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+304,3]=r(r2) 
		matrix avgintakes[`r'+304,5]=r(r1) 
		matrix avgintakes[`r'+304,6]=r(r3)
		
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix avgintakes[`r'+323,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==3, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+323,3]=r(r2) 
		matrix avgintakes[`r'+323,5]=r(r1) 
		matrix avgintakes[`r'+323,6]=r(r3)
				
		*Fife
		sum `var' if HBCode==4
		matrix avgintakes[`r'+342,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==4, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+342,3]=r(r2) 
		matrix avgintakes[`r'+342,5]=r(r1) 
		matrix avgintakes[`r'+342,6]=r(r3)

		*Forth valley
		sum `var' if HBCode==5
		matrix avgintakes[`r'+361,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==5, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+361,3]=r(r2) 
		matrix avgintakes[`r'+361,5]=r(r1) 
		matrix avgintakes[`r'+361,6]=r(r3)
		
		*Grampian
		sum `var' if HBCode==6
		matrix avgintakes[`r'+380,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==1, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+380,3]=r(r2) 
		matrix avgintakes[`r'+380,5]=r(r1) 
		matrix avgintakes[`r'+380,6]=r(r3)	

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix avgintakes[`r'+399,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==2, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+399,3]=r(r2) 
		matrix avgintakes[`r'+399,5]=r(r1) 
		matrix avgintakes[`r'+399,6]=r(r3)
		
		*Highland
		sum `var' if HBCode==8
		matrix avgintakes[`r'+418,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==3, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+418,3]=r(r2) 
		matrix avgintakes[`r'+418,5]=r(r1) 
		matrix avgintakes[`r'+418,6]=r(r3)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix avgintakes[`r'+437,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==4, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+437,3]=r(r2) 
		matrix avgintakes[`r'+437,5]=r(r1) 
		matrix avgintakes[`r'+437,6]=r(r3)

		*Lothian
		sum `var' if HBCode==10
		matrix avgintakes[`r'+456,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==5, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+456,3]=r(r2) 
		matrix avgintakes[`r'+456,5]=r(r1) 
		matrix avgintakes[`r'+456,6]=r(r3)

		*Orkney
		sum `var' if HBCode==11
		matrix avgintakes[`r'+475,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==2, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+475,3]=r(r2) 
		matrix avgintakes[`r'+475,5]=r(r1) 
		matrix avgintakes[`r'+475,6]=r(r3)
		
		*Shetland
		sum `var' if HBCode==12
		matrix avgintakes[`r'+494,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==3, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+494,3]=r(r2) 
		matrix avgintakes[`r'+494,5]=r(r1) 
		matrix avgintakes[`r'+494,6]=r(r3)
				
		*Tayside
		sum `var' if HBCode==13
		matrix avgintakes[`r'+513,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==4, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+513,3]=r(r2) 
		matrix avgintakes[`r'+513,5]=r(r1) 
		matrix avgintakes[`r'+513,6]=r(r3)

		*Western Isles
		sum `var' if HBCode==14
		matrix avgintakes[`r'+532,1]=r(N)
		
		_pctile `var' [pweight=SHeS_Intake24_wt_sc] if HBCode==5, p(2.5, 50, 97.5)
		matrix avgintakes[`r'+532,3]=r(r2) 
		matrix avgintakes[`r'+532,5]=r(r1) 
		matrix avgintakes[`r'+532,6]=r(r3)

		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix avgintakes[`r'+285,2]=r(mean)[1,1] 
		matrix avgintakes[`r'+285,4]=r(sd)[1,1] 
		matrix avgintakes[`r'+304,2]=r(mean)[1,2] 
		matrix avgintakes[`r'+304,4]=r(sd)[1,2] 
		matrix avgintakes[`r'+323,2]=r(mean)[1,3] 
		matrix avgintakes[`r'+323,4]=r(sd)[1,3]
		matrix avgintakes[`r'+342,2]=r(mean)[1,4] 
		matrix avgintakes[`r'+342,4]=r(sd)[1,4]
		matrix avgintakes[`r'+361,2]=r(mean)[1,5] 
		matrix avgintakes[`r'+361,4]=r(sd)[1,5]	
		matrix avgintakes[`r'+380,2]=r(mean)[1,6] 
		matrix avgintakes[`r'+380,4]=r(sd)[1,6] 
		matrix avgintakes[`r'+399,2]=r(mean)[1,7] 
		matrix avgintakes[`r'+399,4]=r(sd)[1,7] 
		matrix avgintakes[`r'+418,2]=r(mean)[1,8] 
		matrix avgintakes[`r'+418,4]=r(sd)[1,8]
		matrix avgintakes[`r'+437,2]=r(mean)[1,9] 
		matrix avgintakes[`r'+437,4]=r(sd)[1,9]
		matrix avgintakes[`r'+456,2]=r(mean)[1,10] 
		matrix avgintakes[`r'+456,4]=r(sd)[1,10]	
		matrix avgintakes[`r'+475,2]=r(mean)[1,11] 
		matrix avgintakes[`r'+475,4]=r(sd)[1,11] 
		matrix avgintakes[`r'+494,2]=r(mean)[1,12] 
		matrix avgintakes[`r'+494,4]=r(sd)[1,12]
		matrix avgintakes[`r'+513,2]=r(mean)[1,13] 
		matrix avgintakes[`r'+513,4]=r(sd)[1,13]
		matrix avgintakes[`r'+532,2]=r(mean)[1,14] 
		matrix avgintakes[`r'+532,4]=r(sd)[1,14]	

		local r=`r'+1
}	

	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Food Category_Mean intakes") modify
	putexcel B2=matrix(avgintakes)

/*********************************************************************
Mean per cent contributions to nutrient intakes @ food category level
*********************************************************************/

*Energy
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Energykcal_FC1- Prop_Avg_Energykcal_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	

	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Energy - % contribution") modify
	putexcel B2=matrix(propintakes)
	
*Protein
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Proteing_FC1- Prop_Avg_Proteing_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	

	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Protein - % contribution") modify
	putexcel B2=matrix(propintakes)
	

*Fat
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Fatg_FC1- Prop_Avg_Fatg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Fat - % contribution") modify
	putexcel B2=matrix(propintakes)
	
*Carbohydrates
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Carbohydrateg_FC1- Prop_Avg_Carbohydrateg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Carbohydrate - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Sodium
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Sodiummg_FC1- Prop_Avg_Sodiummg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Sodium - % contribution") modify
	putexcel B2=matrix(propintakes)

*Potassium
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Potassiummg_FC1- Prop_Avg_Potassiummg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Potassium - % contribution") modify
	putexcel B2=matrix(propintakes)

*Calcium
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Calciummg_FC1- Prop_Avg_Calciummg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Calcium - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Magnesium
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Magnesiummg_FC1- Prop_Avg_Magnesiummg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	

	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Magnesium - % contribution") modify
	putexcel B2=matrix(propintakes)
	
*Phosphorus
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Phosphorusmg_FC1- Prop_Avg_Phosphorusmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Phosphorus - % contribution") modify
	putexcel B2=matrix(propintakes)
	
*Iron
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Ironmg_FC1- Prop_Avg_Ironmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Iron - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Copper
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Coppermg_FC1- Prop_Avg_Coppermg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Copper - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Zinc
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Zincmg_FC1- Prop_Avg_Zincmg_FC18 {
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Zinc - % contribution") modify
	putexcel B2=matrix(propintakes)
	
*Chloride
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Chloridemg_FC1- Prop_Avg_Chloridemg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Chloride - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Vitamin A
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_VitaminA_FC1- Prop_Avg_VitaminA_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Vitamin A - % contribution") modify
	putexcel B2=matrix(propintakes)

	
*Vitamin E
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_VitaminEmg_FC1- Prop_Avg_VitaminEmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Vitamin E - % contribution") modify
	putexcel B2=matrix(propintakes)

	
*Vitamin E
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_VitaminEmg_FC1- Prop_Avg_VitaminEmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Vitamin E - % contribution") modify
	putexcel B2=matrix(propintakes)

	
*Thiamin
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Thiaminmg_FC1- Prop_Avg_Thiaminmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	

	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Thiamin - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Riboflavin
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Riboflavinmg_FC1- Prop_Avg_Riboflavinmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Riboflavin - % contribution") modify
	putexcel B2=matrix(propintakes)

	
*Niacin
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Niacin_FC1- Prop_Avg_Niacin_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Niacin - % contribution") modify
	putexcel B2=matrix(propintakes)

	
*Vitamin B6
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_VitaminB6mg_FC1- Prop_Avg_VitaminB6mg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Vitamin B6 - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Vitamin B12
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_VitaminB12_FC1- Prop_Avg_VitaminB12_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Vitamin B12 - % contribution") modify
	putexcel B2=matrix(propintakes)
	

*Folate
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Folate_FC1- Prop_Avg_Folate_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Folate - % contribution") modify
	putexcel B2=matrix(propintakes)
	

*Vitamin C
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_VitaminCmg_FC1- Prop_Avg_VitaminCmg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Vitamin C - % contribution") modify
	putexcel B2=matrix(propintakes)
	

*Free sugars
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_FreeSugarsg_FC1- Prop_Avg_FreeSugarsg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Free sugars - % contribution") modify
	putexcel B2=matrix(propintakes)
	
*AOAC Fibre
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_AOACFibreg_FC1- Prop_Avg_AOACFibreg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("AOAC Fibre - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Manganese
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Manganesemg_FC1- Prop_Avg_Manganesemg_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Manganese - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Selenium
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Selenium_FC1- Prop_Avg_Selenium_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Selenium - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	
*Iodine
matrix propintakes = J(555, 6, .)
local r=2

quietly foreach var of varlist Prop_Avg_Iodine_FC1- Prop_Avg_Iodine_FC18 {
	
		*overall
		sum `var'
		matrix propintakes[`r',1]=r(N) 
		
		svy, subpop(intake24): mean `var'
		estat sd
		matrix propintakes[`r',2]=r(mean) 
		matrix propintakes[`r',3]=r(sd) 
				
		*by sex
		*female
		sum `var' if Sex==2 
		matrix propintakes[`r'+19,1]=r(N) 
	
		*male
		sum `var' if Sex==1 
		matrix propintakes[`r'+38,1]=r(N)
		 		
		svy, subpop(intake24): mean `var', over(Sex)
		estat sd
		matrix propintakes[`r'+19,2]=r(mean)[1,2] 
		matrix propintakes[`r'+19,3]=r(sd)[1,2]
		matrix propintakes[`r'+38,2]=r(mean)[1,1] 
		matrix propintakes[`r'+38,3]=r(sd)[1,1]
	
		*by age
		*16-24
		sum `var' if age_cat==1 
		matrix propintakes[`r'+57,1]=r(N) 
		
		*25-34
		sum `var' if age_cat==2
		matrix propintakes[`r'+76,1]=r(N)
				
 		*35-44
		sum `var' if age_cat==3
		matrix propintakes[`r'+95,1]=r(N)
					
 		*45-54
		sum `var' if age_cat==4
		matrix propintakes[`r'+114,1]=r(N)
					
 		*55-64
		sum `var' if age_cat==5
		matrix propintakes[`r'+133,1]=r(N)
						
 		*65-74
		sum `var' if age_cat==6
		matrix propintakes[`r'+152,1]=r(N)
							
 		*75+
		sum `var' if age_cat==7
		matrix propintakes[`r'+171,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(age_cat)
		estat sd
		matrix propintakes[`r'+57,2]=r(mean)[1,1] 
		matrix propintakes[`r'+57,3]=r(sd)[1,1] 
		matrix propintakes[`r'+76,2]=r(mean)[1,2] 
		matrix propintakes[`r'+76,3]=r(sd)[1,2] 
		matrix propintakes[`r'+95,2]=r(mean)[1,3] 
		matrix propintakes[`r'+95,3]=r(sd)[1,3]	
		matrix propintakes[`r'+114,2]=r(mean)[1,4] 
		matrix propintakes[`r'+114,3]=r(sd)[1,4]	
		matrix propintakes[`r'+133,2]=r(mean)[1,5] 
		matrix propintakes[`r'+133,3]=r(sd)[1,5]	
		matrix propintakes[`r'+152,2]=r(mean)[1,6] 
		matrix propintakes[`r'+152,3]=r(sd)[1,6]	
		matrix propintakes[`r'+171,2]=r(mean)[1,7] 
		matrix propintakes[`r'+171,3]=r(sd)[1,7]
		
		*By SIMD
		*SIMD 1 (most deprived)
		sum `var' if simd20_sga==1
		matrix propintakes[`r'+190,1]=r(N)
		
		*SIMD 2
		sum `var' if simd20_sga==2
		matrix propintakes[`r'+209,1]=r(N)
		
		*SIMD 3
		sum `var' if simd20_sga==3
		matrix propintakes[`r'+228,1]=r(N)
						
		*SIMD 4
		sum `var' if simd20_sga==4
		matrix propintakes[`r'+247,1]=r(N)
		
		*SIMD 5 (least deprived)
		sum `var' if simd20_sga==5
		matrix propintakes[`r'+266,1]=r(N)
				
		svy, subpop(intake24): mean `var', over(simd20_sga)
		estat sd
		matrix propintakes[`r'+190,2]=r(mean)[1,1] 
		matrix propintakes[`r'+190,3]=r(sd)[1,1] 
		matrix propintakes[`r'+209,2]=r(mean)[1,2] 
		matrix propintakes[`r'+209,3]=r(sd)[1,2] 
		matrix propintakes[`r'+228,2]=r(mean)[1,3] 
		matrix propintakes[`r'+228,3]=r(sd)[1,3]
		matrix propintakes[`r'+247,2]=r(mean)[1,4] 
		matrix propintakes[`r'+247,3]=r(sd)[1,4]
		matrix propintakes[`r'+266,2]=r(mean)[1,5] 
		matrix propintakes[`r'+266,3]=r(sd)[1,5]	

		*By health board
		*Ayrshire and Arran
		sum `var' if HBCode==1
		matrix propintakes[`r'+285,1]=r(N)
		
		*Borders
		sum `var' if HBCode==2
		matrix propintakes[`r'+304,1]=r(N)
				
		*Dumfries and Galloway
		sum `var' if HBCode==3
		matrix propintakes[`r'+323,1]=r(N)
						
		*Fife
		sum `var' if HBCode==4
		matrix propintakes[`r'+342,1]=r(N)
		
		*Forth valley
		sum `var' if HBCode==5
		matrix propintakes[`r'+361,1]=r(N)
				
		*Grampian
		sum `var' if HBCode==6
		matrix propintakes[`r'+380,1]=r(N)

		*Greater Glasgow and Clyde
		sum `var' if HBCode==7
		matrix propintakes[`r'+399,1]=r(N)
		
		*Highland
		sum `var' if HBCode==8
		matrix propintakes[`r'+418,1]=r(N)
				
		*Lanarkshire
		sum `var' if HBCode==9
		matrix propintakes[`r'+437,1]=r(N)
		
		*Lothian
		sum `var' if HBCode==10
		matrix propintakes[`r'+456,1]=r(N)

		*Orkney
		sum `var' if HBCode==11
		matrix propintakes[`r'+475,1]=r(N)
				
		*Shetland
		sum `var' if HBCode==12
		matrix propintakes[`r'+494,1]=r(N)
						
		*Tayside
		sum `var' if HBCode==13
		matrix propintakes[`r'+513,1]=r(N)
		
		*Western Isles
		sum `var' if HBCode==14
		matrix propintakes[`r'+532,1]=r(N)
		
		svy, subpop(intake24): mean `var', over(HBCode)
		estat sd
		matrix propintakes[`r'+285,2]=r(mean)[1,1] 
		matrix propintakes[`r'+285,3]=r(sd)[1,1] 
		matrix propintakes[`r'+304,2]=r(mean)[1,2] 
		matrix propintakes[`r'+304,3]=r(sd)[1,2] 
		matrix propintakes[`r'+323,2]=r(mean)[1,3] 
		matrix propintakes[`r'+323,3]=r(sd)[1,3]
		matrix propintakes[`r'+342,2]=r(mean)[1,4] 
		matrix propintakes[`r'+342,3]=r(sd)[1,4]
		matrix propintakes[`r'+361,2]=r(mean)[1,5] 
		matrix propintakes[`r'+361,3]=r(sd)[1,5]	
		matrix propintakes[`r'+380,2]=r(mean)[1,6] 
		matrix propintakes[`r'+380,3]=r(sd)[1,6] 
		matrix propintakes[`r'+399,2]=r(mean)[1,7] 
		matrix propintakes[`r'+399,3]=r(sd)[1,7] 
		matrix propintakes[`r'+418,2]=r(mean)[1,8] 
		matrix propintakes[`r'+418,3]=r(sd)[1,8]
		matrix propintakes[`r'+437,2]=r(mean)[1,9] 
		matrix propintakes[`r'+437,3]=r(sd)[1,9]
		matrix propintakes[`r'+456,2]=r(mean)[1,10] 
		matrix propintakes[`r'+456,3]=r(sd)[1,10]	
		matrix propintakes[`r'+475,2]=r(mean)[1,11] 
		matrix propintakes[`r'+475,3]=r(sd)[1,11] 
		matrix propintakes[`r'+494,2]=r(mean)[1,12] 
		matrix propintakes[`r'+494,3]=r(sd)[1,12]
		matrix propintakes[`r'+513,2]=r(mean)[1,13] 
		matrix propintakes[`r'+513,3]=r(sd)[1,13]
		matrix propintakes[`r'+532,2]=r(mean)[1,14] 
		matrix propintakes[`r'+532,3]=r(sd)[1,14]	

		local r=`r'+1
}	


	*Export to Excel
	putexcel set "$output\SHeS_ClimateXChange.xlsx", sheet("Iodine - % contribution") modify
	putexcel B2=matrix(propintakes)
	
	