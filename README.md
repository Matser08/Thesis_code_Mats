# Thesis_code_Mats
In this repository one will be able to find all the code used in my thesis

The files that are used for method 1, where we use machine learning algorithms (Random forest classification and logistic regression), on the data 
without feature extraction, are: 

	Step 1 - Start_file_working_out_how_to_deal_with_the_data 

	Step 2 - Creating_2d_csv_per_participant

	Step 3 - creating_train_and_test_data_further

	Step 4 - code 


The files that are used for method 2, where we use machine learning algorithms (Random forest classification and logistic regression) on the data 
with feature extraction, are:

	step 1 - WorkingCode_Morlet_Wavelet_Transform_and_Baseline, code for applying the morlet 
	wavelet frequency in Fieldtrip, which is adapted from code provided in the dataset 
	that is the basis of my thesis (Gregory et al., 2021). The original code
	from the database has been added as Analysis_MatlabScript_Fieldtrip. 

	Step 2 - Code_applying_wavelet_transform

	Step 3 - Feature_Ex_RandFor_LogReg


Finally, for plotting some graphs: 

	file - code for plotting graphs
	
For clarity, the methods section explaining the 2 methods: 

	Method one
Firstly, the EEG data was opened and examined to ensure a comprehensive understanding of the data. The data was opened with the Python library package Scipy.io. Due to the file originally being a MATLAB file, the data shape was not being correctly shown in Python. Hence, we looped through all the values and put them into an array so that it would be in a format that could be easily accessed. Due to the differences in the length of the epochs per trial, we took the max length of all the trials per subject and made that the length of all the epochs. This resulted in the data having zero padding. Next, the EEG data was merged with the relevant labels, such that each trial was appropriately classified as a valid or invalid stick trial or a valid or invalid avatar trial. The trials were then aggregated and consolidated into a single CSV file for each participant. Afterward, the files were concatenated together to make the training and test sets, with the data of one participant, subject 1, serving as the test set. When putting together the data into single CSV files, the rows were checked if they contained only zeros, and the rows that had only zeros, and not a decimal, were deleted. Using one participant as the test set and leaving that participant out of the training set has been done to ensure that there is no overlap between the test and training data. In this way, we avoid having a deceitful high accuracy. The classification algorithms random forest classification and logistic regression were then applied to the data. Finally, the outcomes of the classification model were evaluated using various performance metrics. The performance metrics used are accuracy, precision, and confusion metrics.  

	Method two  
The second method uses the feature extraction WT on the data, but the first steps are the same as method one. For this method, the data was also opened with the library package Scipy.io and afterward, the values were put in an empty array. However, contrary to the previous method, after putting the data in an array, frequency extraction was applied and instead of saving the data per subject, the data was saved per trial as valid stick cue, valid avatar cue, invalid stick cue, or invalid avatar cue. We applied the mne algorithm for Morlet Wavelet Transform on these 4 categories, which are in a 3-dimensional array of size (trials * channels * timepoints), and got back the time-frequency transform in a 4-dimensional array of the size (trials, channels, frequencies, timepoints). To use this output as input for a machine learning algorithm, the channels, frequencies, and time dimensions were flattened into a single dimension. We did this by taking the averages of the frequencies per channel and putting these in a list with their participant number, if they were valid or invalid, stick cue or avatar cue, and the electrode number. This resulted in a list with the categories “participant”, “label”, “electrode” and “power”. In this step, all the trials of the participants were put together so that the train data was in one data frame and the test data was in one data frame. Then they were transformed into data frames and saved as CSV files. For the fitting of the X_train and X_test variables the input needed to be 2-dimensional instead of 1-dimensional. So before putting it into the machine learning algorithms, the arrays were converted to 2-dimensional arrays with a single feature column. For doing so, we made use of the reshape() method of the package Numpy in Python. The resulting training and test data could then be used as input for a machine learning algorithm to classify the data based on the features extracted from the frequency representation. 


Reference:
Gregory, S. E., Wang, H., & Kessler, K. (2021). Social Memory cuing. OpenNeuro. [Dataset] doi: 10.18112/openneuro.ds003702.v1.0.1
