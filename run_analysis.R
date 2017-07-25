library(dplyr)

# Read the data
xtrain<-read.table("train/X_train.txt")
dim(xtrain)
ytrain<-read.table("train/y_train.txt")
dim(ytrain)
xtest<-read.table("test/X_test.txt")
dim(xtest)
ytest<-read.table("test/y_test.txt")
dim(ytest)

# Read the subjects data
subject_train<-read.table("train/subject_train.txt")
subject_test<-read.table("test/subject_test.txt")

# Read the features data
features<-read.table("features.txt")
nam<-as.list(as.character(features[,2]))

####### 4. Rename the columns of the data with the features names
names(xtest)<-nam
names(xtrain)<-nam

names(subject_train)<-c("subject")
names(subject_test)<-c("subject")

# Merge the subject information with x data frames
xtrain<-cbind(subject_train,xtrain)
xtest<-cbind(subject_test,xtest)


#######  1. Merge the training an test data sets
dfx<-rbind(xtrain, xtest)
dfy<-rbind(ytrain, ytest)


####### 2. Extract only the columns with reference to 'mean', 'std' and 'subject'
# in the x data
toMatch<-c("mean\\()", "std\\()", "subject")
nam2<-c("subject", nam)
cols_selec<-grep(paste(toMatch, collapse = "|"), nam2)
sub_dfx<-dfx[,cols_selec]

####### 3. Use descriptive activity names from the data in activity_labels
act_names<-read.table("activity_labels.txt")
new<-sapply(dfy[,1], function(x) {as.character(act_names[x,2])})
y_act<-as.data.frame(new)
names(y_act)<-c("Activity")

# Merge the x and y
df<-cbind(sub_dfx, y_act)

####### 5. Average of each variable for each activity and each subject
# Group by subject and activity
df_df<-tbl_df(df)
df_res<-group_by(df_df, subject, Activity)


# Remove the symbols () and - in the colunm names
names(df_res)<-sub("\\()", "_", names(df_res))
names(df_res)<-sub("\\-","_", names(df_res))
names(df_res)<-sub("\\-","", names(df_res))

# Obtain the mean of each variable for each group
df_means<- aggregate(.~subject+Activity, df_res, mean)
write.table(df_means, "df_means.txt")
