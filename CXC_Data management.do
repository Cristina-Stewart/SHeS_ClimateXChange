
/************************************************************************************
*ClimateXChange project: 
"Evidence assessment - understanding the climate impact of food consumed in Scotland"

*Do file for data management

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
global location "K:\DrJaacksGroup\FSS - Dietary Monitoring\SHeS\SHeS 2021\ClimateXChange" 
global data `"$location\Data"'
global output `"$location\Output"'
global code `"$location\Code"'
global date "20231016"

*Demographic data
global dems `"$data\shes21i_eul"'
*Intake24 diet data (multiple obeservations per participant, each observation = food item reported)
global diet `"$data\shes21_intake24_food-level_dietary_data_eul"'
*Set maximum number of variables to 15,000
set maxvar 15000


******************
*Merging datasets
******************
/*Rename missing variable names
use "$diet", clear
sort Cpseriala RecallNo

rename variabl0 Retinol
rename variabl00 TotCarotene
rename variabl01 Alpcarotene
rename variabl02 Betacarotene
rename variabl03 BCryptoxanthin
rename variabl04 VitaminA
rename variabl05 VitaminD
rename variabl06 VitaminB12
rename variabl07 Folate
rename variabl08 Biotin
rename variabl09 Iodine
rename variabl000 Selenium

sort Cpseriala

save "$diet", replace
*/

use "$dems", clear
keep Cpseriala HBCode psu Strata InIntake24 SHeS_Intake24_wt_sc simd20_sga Sex age NumberOfRecalls
sort Cpseriala
merge 1:m Cpseriala using "$diet"
	*check merge - OK
	*tab _merge InIntake24
	drop _merge
	*dropping nutrients not used
	drop Retinol TotCarotene Alpcarotene Betacarotene BCryptoxanthin Alcoholg Waterg Totalsugarsg Othersugarsg Starchg Glucoseg Fructoseg Sucroseg Maltoseg Lactoseg Totalnitrogeng Cholesterolmg Saturatedfattyacidsg CisMonounsaturatedfattyacidsg Cisn6fattyacidsg Cisn3fattyacidsg Transfattyacidsg Fruitg DriedFruitg FruitJuiceg SmoothieFruitg Tomatoesg TomatoPureeg Brassicaceaeg YellowRedGreeng Beansg Nutsg OtherVegg Pantothenicacidmg Biotin VitaminD EnergykJ
		*note: no DRV for pantothenic acid, biotin, or vitamin D

****************************************
*Create subpop variable for analysis
****************************************
*Completed at least 1 recall
gen intake24=0
replace intake24=1 if InIntake24==1


****************************************
*Create age group variable for analysis
****************************************
gen age_cat=.
replace age_cat=1 if age>=16 & age<25
replace age_cat=2 if age>=25 & age<35
replace age_cat=3 if age>=35 & age<45
replace age_cat=4 if age>=45 & age<55
replace age_cat=5 if age>=55 & age<65
replace age_cat=6 if age>=65 & age<75
replace age_cat=7 if age>=75 & age!=.

gen age_catdesc=""
replace age_catdesc="16-24y" if age_cat==1
replace age_catdesc="25-34y" if age_cat==2
replace age_catdesc="35-44y" if age_cat==3
replace age_catdesc="45-54y" if age_cat==4
replace age_catdesc="55-64y" if age_cat==5
replace age_catdesc="65-74y" if age_cat==6
replace age_catdesc="75y+" if age_cat==7

		
*************************************************************************
*Dropping intake from supplements as interested in intake from food only
*************************************************************************
drop if RecipeMainFoodGroupCode==54 /*n=3,589*/


**********************************************************************************
*Tag each unique recall within the food-level dataset for subsequent calculations
**********************************************************************************
bysort Cpseriala RecallNo: gen n=_n==1
replace n=. if RecallNo==.


/************************************************************************************
Some dairy product re-categorisation is required:

1) Re-categorising dairy-free items out of dairy and into new dairy-free food groups
2) Re-categorising hot chocolates made with water out of dairy and into 'misc'
3) Re-categorising milky coffees (e.g. lattes, cappucinos) into dairy from 'coffee'
4) Re-categorising two ice lollies (without ice cream) incorrectly categorised into 
'ice cream' instead of 'sugar confectionery'
************************************************************************************/

***1) Recategorising dairy-free items

*Sub food group level
replace RecipeSubFoodGroupCode="13R_DF" if RecipeSubFoodGroupCode=="13R" & (strpos(FoodDescription, "Almond") | strpos(FoodDescription, "Alpro") | strpos(FoodDescription, "soya") | strpos(FoodDescription, "Soya") | strpos(FoodDescription, "Hemp") | strpos(FoodDescription, "Oat") | strpos(FoodDescription, "Rice"))
replace RecipeSubFoodGroupCode="13B_DF" if RecipeSubFoodGroupCode=="13B" & strpos(FoodDescription, "Alpro") 
replace RecipeSubFoodGroupCode="14R_DF" if RecipeSubFoodGroupCode=="14R" & strpos(FoodDescription, "Tofu") 
replace RecipeSubFoodGroupCode="15B_DF" if RecipeSubFoodGroupCode=="15B" & strpos(FoodDescription, "Soya") 
replace RecipeSubFoodGroupCode="15C_DF" if RecipeSubFoodGroupCode=="15C" & strpos(FoodDescription, "Soya") 
replace RecipeSubFoodGroupCode="53R_DF" if RecipeSubFoodGroupCode=="53R" & strpos(FoodDescription, "Dairy free")
*Main food group level
replace RecipeMainFoodGroupCode=63 if RecipeSubFoodGroupCode=="13R_DF" | RecipeSubFoodGroupCode=="13B_DF"
replace RecipeMainFoodGroupCode=64 if RecipeSubFoodGroupCode=="14R_DF"
replace RecipeMainFoodGroupCode=65 if RecipeSubFoodGroupCode=="15B_DF" | RecipeSubFoodGroupCode=="15C_DF"
replace RecipeMainFoodGroupCode=66 if RecipeSubFoodGroupCode=="53R_DF"


***2) Re-categorising hot chocolates made with water

*Sub food group level
replace RecipeSubFoodGroupCode="50A" if RecipeSubFoodGroupCode=="13R" & strpos(FoodDescription, "made with water") 
*Main food group level 
replace RecipeMainFoodGroupCode=50 if RecipeSubFoodGroupCode=="50A"


***3) Re-categorising milky coffees (lattes/cappuccinos/mochas) into 'other milk'

*First, re-categorise dairy-free coffees
replace RecipeSubFoodGroupCode="13R_DF" if RecipeSubFoodGroupCode=="51A" & (strpos(FoodDescription, "soya milk"))

*Sub food group level
replace RecipeSubFoodGroupCode="13R" if RecipeSubFoodGroupCode=="51A" & (strpos(FoodDescription, "Cappuccino") | strpos(FoodDescription, "latte") | strpos(FoodDescription, "cappuccino")| strpos(FoodDescription, "Flat white") | strpos(FoodDescription, "Latte") | strpos(FoodDescription, "Mocha")) 
*Main food group level
replace RecipeMainFoodGroupCode=13 if RecipeSubFoodGroupCode=="13R"


***4) Re-categorising two incorrectly categorised ice lollies

*Sub food group level
replace RecipeSubFoodGroupCode="43R" if RecipeSubFoodGroupCode=="53R" & (strpos(FoodDescription, "Sorbet") | strpos(FoodDescription, "Twister")) 

*Main food group level
replace RecipeMainFoodGroupCode=43 if RecipeSubFoodGroupCode=="43R"


***5) Update main and sub food group description variables based on updated categories

*Main food groups
replace RecipeMainFoodGroupDesc="OTHER MILK AND CREAM (DAIRY FREE)" if RecipeMainFoodGroupCode==63
replace RecipeMainFoodGroupDesc="CHEESE (DAIRY FREE)" if RecipeMainFoodGroupCode==64
replace RecipeMainFoodGroupDesc="YOGURT, FROMAGE FRAIS & DAIRY DESSERTS (DAIRY FREE)" if RecipeMainFoodGroupCode==65
replace RecipeMainFoodGroupDesc="ICE CREAM (DAIRY-FREE)" if RecipeMainFoodGroupCode==66
*Sub food group
replace RecipeSubFoodGroupDesc="OTHER MILK (DAIRY-FREE)" if RecipeSubFoodGroupCode=="13R_DF"
replace RecipeSubFoodGroupDesc="CREAM (DAIRY-FREE)" if RecipeSubFoodGroupCode=="13B_DF"
replace RecipeSubFoodGroupDesc="OTHER CHEESE (DAIRY-FREE)" if RecipeSubFoodGroupCode=="14R_DF" 
replace RecipeSubFoodGroupDesc="YOGURT (DAIRY-FREE)" if RecipeSubFoodGroupCode=="15B_DF"
replace RecipeSubFoodGroupDesc="FROMAGE FRAIS AND DAIRY DESSERTS (DAIRY-FREE)" if RecipeSubFoodGroupCode=="15C_DF"
replace RecipeSubFoodGroupDesc="ICE CREAM (DAIRY-FREE)" if RecipeSubFoodGroupCode=="53R_DF"


/***************************************************************************************************
Create high level food categories (that reflect NDNS food categories)
Here, we re-categorise butter (main food group 17) from 'fat spreads' into 'milk and milk products'
***************************************************************************************************/

***Create 'Food Category Code' and 'Food Category Description' variables

**Food category code
gen FoodCategoryCode=.
replace FoodCategoryCode=1 if RecipeMainFoodGroupCode>=1 & RecipeMainFoodGroupCode<=9 |RecipeMainFoodGroupCode==59 
replace FoodCategoryCode=2 if RecipeMainFoodGroupCode>=10 & RecipeMainFoodGroupCode<=15 | RecipeMainFoodGroupCode==17 | RecipeMainFoodGroupCode==60 | RecipeMainFoodGroupCode==53 
replace FoodCategoryCode=3 if RecipeMainFoodGroupCode==16
replace FoodCategoryCode=4 if RecipeMainFoodGroupCode>=18 & RecipeMainFoodGroupCode<=21
replace FoodCategoryCode=5 if RecipeMainFoodGroupCode>=22 & RecipeMainFoodGroupCode<=32
replace FoodCategoryCode=6 if RecipeMainFoodGroupCode>=33 & RecipeMainFoodGroupCode<=35
replace FoodCategoryCode=7 if RecipeMainFoodGroupCode==62
replace FoodCategoryCode=8 if RecipeMainFoodGroupCode>=36 & RecipeMainFoodGroupCode<=39
replace FoodCategoryCode=9 if RecipeMainFoodGroupCode==40
replace FoodCategoryCode=10 if RecipeMainFoodGroupCode==41 | RecipeMainFoodGroupCode==43 | RecipeMainFoodGroupCode==44
replace FoodCategoryCode=11 if RecipeMainFoodGroupCode==42
replace FoodCategoryCode=12 if RecipeMainFoodGroupCode==56 
replace FoodCategoryCode=13 if RecipeMainFoodGroupCode==45 | RecipeMainFoodGroupCode==61 | RecipeMainFoodGroupCode==57 | RecipeMainFoodGroupCode==58 | RecipeMainFoodGroupCode==51
replace FoodCategoryCode=14 if RecipeMainFoodGroupCode>=47 & RecipeMainFoodGroupCode<=49
replace FoodCategoryCode=15 if RecipeMainFoodGroupCode==50
replace FoodCategoryCode=16 if RecipeMainFoodGroupCode==52
replace FoodCategoryCode=17 if RecipeMainFoodGroupCode==55
replace FoodCategoryCode=18	if strpos(RecipeSubFoodGroupCode, "_DF") /* dairy-free items*/
replace FoodCategoryCode=. if RecipeMainFoodGroupCode==.

**Food category description
gen FoodCategoryDesc=""
replace FoodCategoryDesc="Cereals and Cereal Products" if FoodCategoryCode==1
replace FoodCategoryDesc="Milk and Milk Products" if FoodCategoryCode==2
replace FoodCategoryDesc="Eggs and Egg Dishes" if FoodCategoryCode==3
replace FoodCategoryDesc="Fat Spreads" if FoodCategoryCode==4
replace FoodCategoryDesc="Meat and Meat Products" if FoodCategoryCode==5
replace FoodCategoryDesc="Fish and Fish Dishes" if FoodCategoryCode==6
replace FoodCategoryDesc="Sandwiches" if FoodCategoryCode==7
replace FoodCategoryDesc="Vegetables, potatoes" if FoodCategoryCode==8
replace FoodCategoryDesc="Fruit" if FoodCategoryCode==9
replace FoodCategoryDesc="Sugar, Preserves and Confectionery" if FoodCategoryCode==10
replace FoodCategoryDesc="Savoury Snacks" if FoodCategoryCode==11
replace FoodCategoryDesc="Nuts and Seeds" if FoodCategoryCode==12
replace FoodCategoryDesc="Non-alcoholic beverages" if FoodCategoryCode==13
replace FoodCategoryDesc="Alcoholic beverages" if FoodCategoryCode==14
replace FoodCategoryDesc="Misc" if FoodCategoryCode==15
replace FoodCategoryDesc="Toddler foods" if FoodCategoryCode==16
replace FoodCategoryDesc="Artificial sweeteners" if FoodCategoryCode==17
replace FoodCategoryDesc="Milk and Milk Products (dairy-free)" if FoodCategoryCode==18


/***************************************************************************
Create daily summary intakes of each food category and nutrients
***************************************************************************/

***FOOD CATEGORY***			
levelsof FoodCategoryCode, local(FoodCategoryCode) 
foreach 1 of local FoodCategoryCode {
	bysort Cpseriala RecallNo: egen Day_FC_`1' =sum(TotalGrams) if FoodCategoryCode==`1' 
	replace Day_FC_`1' =. if RecallNo==. 
}


***NUTRIENTS***

*Day level
rename Niacinequivalentmg Niacin /*Variable names get too long in the data loop so have to rename*/

*Loop to calculate daily intake of each nutrient
foreach var of varlist Energykcal Proteing Fatg Carbohydrateg Sodiummg Potassiummg Calciummg Magnesiummg Phosphorusmg Ironmg Coppermg Zincmg Chloridemg VitaminA VitaminEmg Thiaminmg Riboflavinmg Niacin VitaminB6mg VitaminB12 Folate VitaminCmg FreeSugarsg AOACFibreg Manganesemg Selenium Iodine {
	bysort Cpseriala RecallNo: egen Day_`var' =sum(`var') 
	replace Day_`var' =. if RecallNo==. 
}



/**************************************************************
 Calculate mean daily intakes of food categories and nutrients
**************************************************************/

*Set local macro
ds Day_* 
local dayvalues `r(varlist)'

*Loop through each daily value
foreach var of varlist `dayvalues' {
	bysort Cpseriala RecallNo: egen DayMax_`var' =max(`var') /*daily intake*/
    bysort Cpseriala: egen Wk_`var' = total(DayMax_`var') if n==1 /*total intake across all days*/
	bysort Cpseriala: egen WkMax_`var' = max(Wk_`var') /*filling in total intake across all days across all observations*/
	bysort Cpseriala: gen Avg_`var' = (WkMax_`var'/NumberOfRecalls) /*mean daily intake*/
	drop DayMax_`var' Wk_`var' WkMax_`var'
}

drop Day_*

/*********************************************************************
Calculate mean daily nutrient intakes from HIGH LEVEL FOOD CATEGORIES
*********************************************************************/
local nutrients "Energykcal Proteing Fatg Carbohydrateg Sodiummg Potassiummg Calciummg Magnesiummg Phosphorusmg Ironmg Coppermg Zincmg Chloridemg VitaminA VitaminEmg Thiaminmg Riboflavinmg Niacin VitaminB6mg VitaminB12 Folate VitaminCmg FreeSugarsg AOACFibreg Manganesemg Selenium Iodine" 
levelsof FoodCategoryCode, local(FoodCategoryCode) 

foreach var of varlist `nutrients' {
	foreach 1 of local FoodCategoryCode {
	bysort Cpseriala RecallNo: egen D_`var'_FC`1' = sum(`var') if FoodCategoryCode==`1' /*daily nutrient intake by food group*/
	bysort Cpseriala RecallNo: egen DMax_`var'_FC`1' = max(D_`var'_FC`1') /*filling in daily nutrient intake by food group across all observations*/
	bysort Cpseriala: egen Wk_`var'_FC`1' = total(DMax_`var'_FC`1') if n==1 /*total nutrient intake by food group across all days*/
	bysort Cpseriala: egen WkMax_`var'_FC`1' = max(Wk_`var'_FC`1') /*filling in total intake across all days across all observations*/
	bysort Cpseriala: gen Avg_`var'_FC`1'= (WkMax_`var'_FC`1'/NumberOfRecalls) /*mean daily nutrient intake by food group*/
	drop D_* DMax_* Wk_* WkMax*
	}
}	


/********************************************************************
 Create variables for food category contributions to nutrient intakes
********************************************************************/

**Energy
ds Avg_Energykcal_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Energykcal)*100 if Avg_Day_Energykcal>0
	replace Prop_`var'=0 if Avg_Day_Energykcal==0
}

**Protein
ds Avg_Proteing_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Protein)*100 if Avg_Day_Protein>0
	replace Prop_`var'=0 if Avg_Day_Protein==0
}

**Fat
ds Avg_Fatg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Fatg)*100 if Avg_Day_Fatg>0
	replace Prop_`var'=0 if Avg_Day_Fatg==0
}

**Carbohydrate
ds Avg_Carbohydrateg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Carbohydrateg)*100 if Avg_Day_Carbohydrateg>0
	replace Prop_`var'=0 if Avg_Day_Carbohydrateg==0
}

**Sodium
ds Avg_Sodiummg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Sodiummg)*100 if Avg_Day_Sodiummg>0
	replace Prop_`var'=0 if Avg_Day_Sodiummg==0
}

**Potassium
ds Avg_Potassiummg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Potassiummg)*100 if Avg_Day_Potassiummg>0
	replace Prop_`var'=0 if Avg_Day_Potassiummg==0
}

**Calcium
ds Avg_Calciummg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Calciummg)*100 if Avg_Day_Calciummg>0
	replace Prop_`var'=0 if Avg_Day_Calciummg==0
}

**Magnesium
ds Avg_Magnesiummg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Magnesiummg)*100 if Avg_Day_Magnesiummg>0
	replace Prop_`var'=0 if Avg_Day_Magnesiummg==0
}

**Phosphorus
ds Avg_Phosphorusmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Phosphorusmg)*100 if Avg_Day_Phosphorusmg>0
	replace Prop_`var'=0 if Avg_Day_Phosphorusmg==0
}

**Iron
ds Avg_Ironmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Ironmg)*100 if Avg_Day_Ironmg>0
	replace Prop_`var'=0 if Avg_Day_Ironmg==0
}

**Copper
ds Avg_Coppermg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Coppermg)*100 if Avg_Day_Coppermg>0
	replace Prop_`var'=0 if Avg_Day_Coppermg==0
}

**Zinc
ds Avg_Zincmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Zincmg)*100 if Avg_Day_Zincmg>0
	replace Prop_`var'=0 if Avg_Day_Zincmg==0
}

**Chloride
ds Avg_Chloridemg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Chloridemg)*100 if Avg_Day_Chloridemg>0
	replace Prop_`var'=0 if Avg_Day_Chloridemg==0
}

**Vitamin A
ds Avg_VitaminA_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_VitaminA)*100 if Avg_Day_VitaminA>0
	replace Prop_`var'=0 if Avg_Day_VitaminA==0
}

**Vitamin E
ds Avg_VitaminEmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_VitaminEmg)*100 if Avg_Day_VitaminEmg>0
	replace Prop_`var'=0 if Avg_Day_VitaminEmg==0
}

**Thiamin
ds Avg_Thiaminmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Thiaminmg)*100 if Avg_Day_Thiaminmg>0
	replace Prop_`var'=0 if Avg_Day_Thiaminmg==0
}

**Riboflavin
ds Avg_Riboflavinmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Riboflavinmg)*100 if Avg_Day_Riboflavinmg>0
	replace Prop_`var'=0 if Avg_Day_Riboflavinmg==0
}

**Niacin
ds Avg_Niacin_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Niacin)*100 if Avg_Day_Niacin>0
	replace Prop_`var'=0 if Avg_Day_Niacin==0
}

**Vitamin B6
ds Avg_VitaminB6mg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_VitaminB6mg)*100 if Avg_Day_VitaminB6mg>0
	replace Prop_`var'=0 if Avg_Day_VitaminB6mg==0
}

**Vitamin B12
ds Avg_VitaminB12_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_VitaminB12)*100 if Avg_Day_VitaminB12>0
	replace Prop_`var'=0 if Avg_Day_VitaminB12==0
}

**Folate
ds Avg_Folate_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Folate)*100 if Avg_Day_Folate>0
	replace Prop_`var'=0 if Avg_Day_Folate==0
}

**Vitamin C
ds Avg_VitaminCmg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_VitaminCmg)*100 if Avg_Day_VitaminCmg>0
	replace Prop_`var'=0 if Avg_Day_VitaminCmg==0
}

**Free sugars
ds Avg_FreeSugarsg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_FreeSugarsg)*100 if Avg_Day_FreeSugarsg>0
	replace Prop_`var'=0 if Avg_Day_FreeSugarsg==0
}

**AOAC Fibre
ds Avg_AOACFibreg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_AOACFibreg)*100 if Avg_Day_AOACFibreg>0
	replace Prop_`var'=0 if Avg_Day_AOACFibreg==0
}

**Manganese
ds Avg_Manganesemg_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Manganesemg)*100 if Avg_Day_Manganesemg>0
	replace Prop_`var'=0 if Avg_Day_Manganesemg==0
}

**Selenium
ds Avg_Selenium_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Selenium)*100  if Avg_Day_Selenium>0
	replace Prop_`var'=0 if Avg_Day_Selenium==0
}

**Iodine
ds Avg_Iodine_*
local dailyaverage `r(varlist)'
foreach var of varlist `dailyaverage' {
    bysort Cpseriala: gen Prop_`var'=(`var'/Avg_Day_Iodine)*100 if Avg_Day_Iodine>0
	replace Prop_`var'=0 if Avg_Day_Iodine==0
}


**************
*Save Dataset
**************

*Food level dataset
save "$data\SHeS 2021_foodlevel_CXC_$date.dta", replace
*Participant level dataset for analysis (drop duplicates and unecessary food level variables)
duplicates drop Cpseriala, force
drop SubDay-TotalGrams n FoodCategoryCode FoodCategoryDesc

save "$data\SHeS 2021_participantlevel__CXC_$date.dta", replace





