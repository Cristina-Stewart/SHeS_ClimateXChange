
/************************************************************************************
*ClimateXChange project: 
"Evidence assessment - understanding the climate impact of food consumed in Scotland"

*Do file for looking at frequency of items consumed

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
global date "20231016"


*Read in data
use "$data\SHeS 2021_foodlevel_CXC_$date.dta", clear
*Assign survey sampling variables
svyset [pweight=SHeS_Intake24_wt_sc], psu(psu) strata(Strata)


/*******************************************************************
Look at frequency of items reported within five key food groups
********************************************************************/
ta FoodDescription if FoodCategoryDesc=="Fruit" /*Unweighted N*/
svy, subpop(intake24): ta FoodDescription if FoodCategoryDesc=="Fruit" /*Survey-weighted %*/

ta FoodDescription if FoodCategoryDesc=="Vegetables, potatoes"
svy, subpop(intake24): ta FoodDescription if FoodCategoryDesc=="Vegetables, potatoes"

ta FoodDescription if FoodCategoryDesc=="Cereals and Cereal Products"
svy, subpop(intake24): ta FoodDescription if FoodCategoryDesc=="Cereals and Cereal Products"

ta FoodDescription if FoodCategoryDesc=="Sandwiches"
svy, subpop(intake24): ta FoodDescription if FoodCategoryDesc=="Sandwiches"

ta FoodDescription if FoodCategoryDesc=="Non-alcoholic beverages"
svy, subpop(intake24): ta FoodDescription if FoodCategoryDesc=="Non-alcoholic beverages"

