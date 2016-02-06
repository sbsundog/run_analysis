# The purpose of this document is to explain the  r script called runanalysis.

Run_analysis processes  measures of six activities for 30 individuals. The major steps are identified here.

## Initial data gathering

          1. Obtains the UCI data file and places them on local disk.

## Preliminary setup

          1. Activity data is obtained and identified as factors, including the description of the                          activities. Activity data identifies the type of motion.
          2. Vounteer data is obtained and identified as factors.
             Volunteer data identifies the individuals who performed the activities.
          3. Features data is obtained  Features data represents physical data measured by sensors on                       the Samsung S phone or derived measures from them.
             

## Assign More Descriptive Names
   
          1. Mmore descriptive variable names for the features variables are assigned and thereby
             replace the generic V1, V2, V3 variable names with the original researchers' variable names
             and by employing "friendlier" names.
          2. Variables with  mean and stdd are converted to Mean and Std for readability
          3. Variables with '-()' in their names have the three characters set to "" 
          
## Merge Test and Training Data Into One File

## Eliminate the non mean and non std dev variables frm the combined test and train dataset,

## Create a tidy dataset that summarizes the mean of each variable for each activity for each individual. 