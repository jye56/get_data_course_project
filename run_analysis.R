run_analysis<-function(){

	library(dplyr)

	#------------------------------------------------------------------
	# 1. make a data.frame that contains X data with columns with names containing
	#"mean" or "std"
	#---------------------------------------------------------------

	#load X_train and X_test into memory, then combine them into a single data.frame
	mytrain<- read.table("./UCI HAR Dataset/train/X_train.txt")
	mytest<- read.table("./UCI HAR Dataset/test/X_test.txt")
	mydata<- rbind(mytrain,mytest)
	rm("mytrain")	# free up the memory when the function is executing
	rm("mytest")	# free up the memory when the function is executing

	#load features, process and then use features for the variable names for all the columns
	myfeatures<-read.table("./UCI HAR Dataset/features.txt")
	featurelist<-myfeatures[,2]
	vecnames<-as.vector(featurelist)

	#make the features unique and then remove the punctuations from the features
	vecnamesu<-make.unique(vecnames)
	vecnamesu<-gsub("[[:punct:]]","",vecnamesu)

	#assign the clean-uped features as the column names of the combined data
	colnames(mydata)<-vecnamesu

	#subset combined data set to select out columns with names containing either "mean" or "std"
	mean_sd_data<-select(mydata, contains("mean"), contains("std"))
	
	rm("mydata")	# free up the memory when the function is executing

	#----------------------------------------------------------------
	# 2.make a data.frame that contains the activity levels with descriptive labels
	#-----------------------------------------------------------------

	# read files y_train and y_test and combine the data frames
	ytrain<- read.table("./UCI HAR Dataset/train/y_train.txt")
	ytest<- read.table("./UCI HAR Dataset/test/y_test.txt")
	ydata<- rbind(ytrain,ytest)

	#assign a name "activity" to the column
	colnames(ydata)<-"activity"

	#convert activity levels from numeric codes to descriptive labels
	#(this is not elegant; there must be a better way. If you did it with
	# a better way, would you point me to that direction?)
	ydata[ydata==1]<-"WALKING"
	ydata[ydata==2]<-"WALKING_UPSTAIRS"
	ydata[ydata==3]<-"WALKING_DOWNSTAIRS"
	ydata[ydata==4]<-"SITTING"
	ydata[ydata==5]<-"STANDING"
	ydata[ydata==6]<-"LAYING"

	#-----------------------------------------------------
	# 3.make a data.frame that contains the subjects
	#-----------------------------------------------------
	
	#read files subject_train and subject_test and combine the data frames
	subjecttrain<- read.table("./UCI HAR Dataset/train/subject_train.txt")
	subjecttest<- read.table("./UCI HAR Dataset/test/subject_test.txt")
	subjectdata<- rbind(subjecttrain,subjecttest)

	# assign a name "subject" to the column
	colnames(subjectdata)<-"subject"

	#----------------------------------------------------------
	# 4. combine activity(activity),subject(subjectdata) and the subsetted X data(mean_sd_data)
	# to form a complete data.frame, group the data.frame by activity and subject,
	# summarize the data, save a .txt file to the working directory and return the summary
	#-----------------------------------------------------------

	#combine 3 data frames into one
	completedata<-cbind(ydata,subjectdata,mean_sd_data)

	# group the combined data frame by activity and subject
	by_activity_subject<-group_by(completedata,activity,subject)
	
	# use summarise_each to produce the tidy data specified the course project
	datasummary<-summarise_each(by_activity_subject, funs(mean))

	# save the data frame in .txt format to the working directory
	write.table(datasummary,"./tidydata.txt")

	datasummary

}

################################################################################



