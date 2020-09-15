# directory location
dir_d <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(dir_d, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# load library required 
library(readr)
library(dplyr)

# load Activity with Labels and Index with suitable names

act_lab <- fread(file.path(dir_d, "/UCI HAR Dataset/activity_labels.txt"),
                 col.names = c("activityno","activityname"))

# load features names with descriptive names
feature <-fread(file.path(dir_d, "/UCI HAR Dataset/features.txt"),
                col.names = c("featureindex","featurename"))[,2]

feature <-mutate(feature,featurename = gsub("[()]","",featurename))

# load data sets for Train and Test
for( i in c("train","test")){
        for (j in c("y_","subject_","X_")){
                tb_na <- paste(j,i,sep = "")
                tbna <- paste("UCI HAR Dataset/",i,"/",tb_na,".txt", sep = "")
                temp_r <-fread(file.path(dir_d,tbna))
                if (tb_na == paste("X_",i,sep = "")){
                        setnames(temp_r,old = names(temp_r),
                                 new = t(feature)[1,])
                        temp_f <- cbind(temp_f,temp_r)
                } else if (tb_na == paste("y_",i,sep = "")){
                        setnames(temp_r,old = names(temp_r),
                                 new = "labels")
                        temp_f <- temp_r
                }else {
                        setnames(temp_r,old = names(temp_r),
                                 new = "subject")
                        temp_f <- cbind(temp_f,temp_r)
                }
                
        }
        n <- i
        assign(n,temp_f,pos = 1)
        rm(temp_f,temp_r,temp_t)
}  

# Combined data sets
sample_set <- rbind(train,test)
rm(temp_f,temp_r,temp_t,train,test)

# Filtering the column with only Mean and Std 
sample_set1 <-grep("labels|subject|mean$|-mean-|std$|-std",names(sample_set))
sample_set <-select(sample_set,as.vector(sample_set1))

# loading the Activity Names
sample_set[["labels"]] <- factor(sample_set[, labels]
                                 , levels = act_lab[["activityno"]]
                                 , labels = act_lab[["activityname"]])

# rearrange the data based on activity
sample_set3 <-gather(sample_set, acitvity,count,-labels,-subject)

# create a table with Activity Mean
Activity_Mean <- summarize(group_by(sample_set3,labels),means = mean(count))

