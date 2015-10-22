# Downloads and extracts the data to be analyzed by the "run_analysis.R" script
# Parameters:
# - url = the remote url to fetch the data from (as a zip file)
# - localFileName = the name of the file to be created locally
retrieve_data <- function(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", localFileName = "UCI HAR Dataset.zip") {
  library(tools);
  
  if (file.exists(localFileName)) unlink(localFileName);
  localSubFolder <- file_path_sans_ext(localFileName);
  if (file.exists(localSubFolder)) unlink(localSubFolder, recursive = T, force = T);
  
  download.file(url =  url, destfile = localFileName, mode = "wb");
  unzip(zipfile = localFileName);
}