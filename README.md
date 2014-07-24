## Description of program
 Requirements:
 <ol>
 <li>Merges the training and the test sets to create one data set.</li>
 <li>Extracts only the measurements on the mean and standard deviation for each measurement. </li>
 <li>Uses descriptive activity names to name the activities in the data set.</li>
 <li>Appropriately labels the data set with descriptive variable names.</li>
 <li>Creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
 </ol>

## loading data
read activity labels
read features names

read training data set 
* data     : X_train.txt
* activity : y_train.txt
* subject  : subject_train.txt
merge descriptive activity names to name the activities in the data set
make train data all in one
label each variable names

read test data set
* data     : X_test.txt
* activity : y_test.txt
* subject  : subject_test.txt
merge descriptive activity names to name the activities in the data set
make test data all in one
label each variable names

## processing data
Merges the training and the test sets to create one data set.
---------------------------------------------------------------------------
Extracts only the measurements on the mean and standard deviation for each measurement. 
  grep feature label for "mean" and "std"
---------------------------------------------------------------------------
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Output data
write tidyData to a local file.


