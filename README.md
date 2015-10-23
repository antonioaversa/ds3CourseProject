# Getting and Cleaning Data Course Project
This repository contains the code for the "Getting and Cleaning Data" course of the Data Science specialization on Coursera.

## Steps to perform the tidy dataset generation
1. Clone this repository in a local folder `<localPath>`
2. Start an R session and set the current working directory to `<localPath>`
    
	```{r}
    setwd(<localPath>)
    ```
3. Install the required package `dplyr`, if you've never install it before in your current environment

    ```{r}
    install.packages("dplyr")
    ```
4. Download the zipped file containing the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", and extract its content under <localPath>. You can do it either manually or by executing the "retrieve_data.R" script.
    
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
5. Run the "run_analysis.R" script, to perform the data cleaning process and generate the tidy dataset
    
	```{r}
    source("run_analysis.R")
    ```
6. The tidy dataset generated is at "`<localPath>`/dataset_byActivityAndSubject.txt"

## Steps performed by the run_analysis.R script
The `run_analysis.R` script, executed at step 5 of the tidy dataset generation process, performs the following operation on the data:

1. data are loaded from the `UCI HAR Dataset` folder into R data frames
2. `X_train` and `X_test`, `y_train` and `y_test`, `subject_train` and `subject_test` are merged by rows, obtaining `X_total`, `y_total` and `subject_total`
3. the feature list is loaded into a `features` data frame, and the name of the features of type mean and std are extracted from it
4. the `X_total` is projected on the selected features, generating `X_total_projected`
5. the activity labels are loaded into a `activity_labels` data frame, which is labelled and joint with `y_total`, generating `activity_total`
6. a complete data set is generated, appending by column `X_total_projected`, `activity_total` and `subject_total`
7. this complete data set is grouped by activity and subject, and for each group the mean of each column is emitted
8. the resulting data set is saved to disk, as a space-separated text file 




