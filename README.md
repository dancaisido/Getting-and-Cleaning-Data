# Getting and Cleaning Data Course Project
A peer - graded assignment as one of the requirements in Coursera Data Science: Getting and Cleaning Data lesson.

The R script, `run_analysis.R`, does the following:

1. Download and unzip the file
2. Load the datasets: Activity, Features
3. Create an identifier list to extract only the mean and std from the Feature dataset
4. Load the datasets: Train and Test, and extract only the mean and std using the identifier from Step 3
5. Apply the appropriate column names
6. Combine all the datasets into only 1 big file
7. Get the average of each column by Subject by Activity
8. Create another file that will show Step 7

The generated dataset is names as `aggregated_data.txt`.
The variables are listed in the `CodeBook.md`

