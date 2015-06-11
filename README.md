# get_data_course_project

## This file explains the course project for the Coursera course "Getting and Cleaning Data"
* First down load the files by: 
* > purl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
* > download.file(purl,destfile= "./projectdata.zip")
* the zip file was downloaded 6/3/2015 9:18 PM Eastern Time (USA)

* After downloading the files, one would unzip the file to get a folder of files named "UCI HAR Dataset".  Put that folder in the working directory.
* run the run_analysis.R script would yield the tidy data set.
* The script consists of 4 segments:
* 1. make a data frame consists of training and test data sets with variable names obtained from features. using select() from the dplyr package to select out the columns containing either "mean" or "std" in the names. 86 columns met the criteria.
* 2. make a data.frame that contains the activity levels with descriptive labels.
* 3. make a data.frame that contains the subjects
* 4. The final synthesis: combine activity(activity),subject(subjectdata) and the subsetted X data(mean_sd_data)to form a complete data.frame, group the data.frame by activity and subject,summarize the data, save a .txt file to the working directory and return the summary

* (Incidentally, one can also use function aggregate() to solve this problem; it uses two lists and one data frame, so the underlying data structure would be different. aggregate(mydata,by=list(activitylist,subjectlist),FUN="mean"). detail not shown )

* Acknowledgement: I would like to thank community TA David Hood for his post "David's personal course project FAQ" (https://class.coursera.org/getdata-015/forum/thread?thread_id=26), which is of tremendous help for me to get started. I would like to thank community TA Richard Aaron and for fellow student Antoine Chopin for very helpful discussions. I would like to thank you, my fellow student, for spending time to evaluate my project.
* PS, I know that submission of tidydata.txt in gitHub is not required, but I do so just to make sure that you can see the result in case the uploading is not successful.
