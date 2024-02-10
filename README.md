# Nutritional contributions of food groups in the Scottish Health Survey (2021) and National Diet and Nutrition Survey (NDNS, 2016/17, 2017/18 and 2018/19)
Analysis of food group intake (current intakes and nutritional contributions) among adults 16+ years in the 2021 Scottish Health Survey (SHeS).

Visualisation of nutritional contributions among children and young people 1.5-18 years in the National Diet and Nutrition Survey (NDNS, 2016/17, 2017/18 and 2018/19 combined) using data extracted from published NDNS tables. 

## Data Management File for SHeS analysis

### CXC_Data management
This Stata do-file creates a food-level and participant-level dataset for SHeS. It combines demographic survey data with dietary data collected through Intake24. At the participant level, mean daily intakes of each high-level food category are calculated, as well as their mean daily per cent contributions to 27 nutrients.

Files needed to run this do-file:
#### Data files
Two data files are needed to run this do-file, and can be downloaded from the UK Data Archive.
- shes21_intake24_food-level_dietary_data_eul - Intake 24 diet data. There are multiple observations per participant, each observation corresponds to a food item reported.
- shes21i_eul - participant demographic survey data. There is only one observation per participant.

### Output
- SHeS 2021_foodlevel_CXC_20231016.dta - this dataset has multiple observations for each participant, corresponding to each food item reported
- SHeS 2021_participantlevel_CXC_20231016.dta - this dataset has one observation for each participant

## Data Analysis Files for SHeS analysis
### CXC_Exporting data into Excel tables.do
This do-file contains code which exports the following data into Excel tables, overall and among population subgroups (age, gender, Scottish Index of Multiple Deprivation, and Health Board): 
1) Mean daily intake of each food category per capita
2) Mean per cent contributions of nutrient intakes from food groups

### CXC_Food items frequency of consumption.do
This do-file tabulates (unweighted n's and survey-weighted %'s) food item consumption frequencies within the following food categories:
1) Fruit
2) Vegetables, potatoes
3) Cereals and cereal products
4) Sandwiches
5) Non-alcoholic beverages

## Output Files 
#### Figures SHeS_Nutrient intake by population group adults
This Word file contains figures of nutrient intake by population group among adults in SHeS 2021.

### Figures NDNS_Nutrient intake by population group children
This Word file contains figures of nutrient intake by population group among children and young people in NDNS 2016/17, 2017/18 and 2018/19 (combined).
