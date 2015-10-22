# Getting and Cleaning Data Course Project
This repository contains the code for the "Getting and Cleaning Data" course of the Data Science specialization on Coursera.

## Steps to perform the data cleaning
1. Clone this repository in a local folder <localPath> 
2. Start an R session and set the current working directory to <localPath>
```{r}
setwd(<localPath>)
```
3. Download the zipped file containing the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", and extract its content under <localPath>. You can do it either manually or by executing the "retrieve_data.R" script.
```{r}
source("retrieve_data.R")
retrieve_data()
```
Your working directory should like like:
```{r}
<localPath>
|- retrieve_data.R
|- run_analysis.R
|- README.md
|- UCI HAR Dataset
   |- test
   |  |- ...
   |
   |- train
   |  |- ...
   |
   |- activity_labels.txt
   |- features.txt
   |- features_info.txt
   |- README.txt
```
4. Run the "run_analysis.R" script, to perform the data cleaning process and generate the tidy dataset
```{r}
source("run_analysis.R")
```
5. The tidy dataset generated is at "<localPath>/dataset_byActivityAndSubject.txt"