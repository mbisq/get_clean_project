First the data from the train and test files (x and y), the subjects and the features is read. 
The names of the columns in the xtrain and xtest files are assigned by using the names of the variables provided in the features.txt file (this should be step 4 in the project but I prefered to do it at the beginning). Also, the information from the subjects (provided in the subject_train.txt and subject_test.txt) is merged to the train and test datasets. 

Next, the data from the xtrain and xtest files is merged together on one side and the ytrain and ytest on the other side (step 1) leading to the dfx and dfy datasets.

From the large set of variables in the database, only those refering to mean or std are kept (step 2). 

The dfy dataset includes factor values which are related to different activities. The descriptive activity is given in the activity_labels.txt. This information is exctracted and used to replace the factors in the dfy dataset (step 3). Next, the dfx and dfy datasets are merged together in the df dataset. 

The df dataset contains several measurements of each variable for each subject and activity. In the last step, this information is summarised in order to have an average value of each variable for each subject and activity (step 5).  
