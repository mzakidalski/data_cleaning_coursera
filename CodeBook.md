---
title: "CodeBook"
author: "Marcin Zakidalski"
date: "September 25, 2015"
output: html_document
---

The clean data set contains the following columns:

1. Subject_Id - identifier of the person conducting particular activity. It is integer value between 1 and 30
2. Activity - has the following values:
    + WALKING
    + WALKING_UPSTAIRS
    + WALKING_DOWNSTAIRS
    + SITTING
    + STANDING
    + LAYING
    The activity names are self-explanatory. Is it worth noticing to realise the difference between different kinds of WALKING activities (walking in the plain surrounding, going downstairs, going upstairs)
3. particular measure variables - these are mean values of all observations of particular variable for given pair (Subject_Id, Activity). Measure units are exactly the same as those in the raw data set.Variables were created summing up together the following parts:

     + Time - when variable is measured in the time domain, Freq - when it is in the frequency domain
     + Mean / Std_Deviation - variable is mean or std. deviation
     + Magnitude - magnitude of signals calculated using the Euclidean norm
     + Body / Gravity - part of the signal connected with body movement / gravity influence
     + Gyroscope / Accelerometer - source of the signal 
     + Jerk - angular velocity derived in time
     + X_AXIS, Y_AXIS, Z_AXIS - axis along which the measure was made.



The complete list of other variables:


"Time_Mean_Body_Accelerometer_X_AXIS","Time_Mean_Body_Accelerometer_Y_AXIS",
"Time_Mean_Body_Accelerometer_Z_AXIS","Time_Std_Deviation_Body_Accelerometer_X_AXIS","
Time_Std_Deviation_Body_Accelerometer_Y_AXIS",
"Time_Std_Deviation_Body_Accelerometer_Z_AXIS",
"Time_Mean_Gravity_Accelerometer_X_AXIS", 
"Time_Mean_Gravity_Accelerometer_Y_AXIS",
"Time_Mean_Gravity_Accelerometer_Z_AXIS","Time_Std_Deviation_Gravity_Accelerometer_X_AXIS","Time_Std_Deviation_Gravity_Accelerometer_Y_AXIS",
"Time_Std_Deviation_Gravity_Accelerometer_Z_AXIS","Time_Mean_Body_Accelerometer_Jerk_X_AXIS", "Time_Mean_Body_Accelerometer_Jerk_Y_AXIS","Time_Mean_Body_Accelerometer_Jerk_Z_AXIS","Time_Std_Deviation_Body_Accelerometer_Jerk_X_AXIS","Time_Std_Deviation_Body_Accelerometer_Jerk_Y_AXIS","Time_Std_Deviation_Body_Accelerometer_Jerk_Z_AXIS","Time_Mean_Body_Gyroscope_X_AXIS" ,"Time_Mean_Body_Gyroscope_Y_AXIS","Time_Mean_Body_Gyroscope_Z_AXIS","Time_Std_Deviation_Body_Gyroscope_X_AXIS","Time_Std_Deviation_Body_Gyroscope_Y_AXIS","Time_Std_Deviation_Body_Gyroscope_Z_AXIS","Time_Mean_Body_Gyroscope_Jerk_X_AXIS","Time_Mean_Body_Gyroscope_Jerk_Y_AXIS", "Time_Mean_Body_Gyroscope_Jerk_Z_AXIS","Time_Std_Deviation_Body_Gyroscope_Jerk_X_AXIS","Time_Std_Deviation_Body_Gyroscope_Jerk_Y_AXIS","Time_Std_Deviation_Body_Gyroscope_Jerk_Z_AXIS","Time_Mean_Magnitude_Body_Accelerometer","Time_Std_Deviation_Magnitude_Body_Accelerometer", "Time_Mean_Magnitude_Gravity_Accelerometer","Time_Std_Deviation_Magnitude_Gravity_Accelerometer","Time_Mean_Magnitude_Body_Accelerometer_Jerk", "Time_Std_Deviation_Magnitude_Body_Accelerometer_Jerk","Time_Mean_Magnitude_Body_Gyroscope","Time_Std_Deviation_Magnitude_Body_Gyroscope","Time_Mean_Magnitude_Body_Gyroscope_Jerk","Time_Std_Deviation_Magnitude_Body_Gyroscope_Jerk","Freq_Mean_Body_Accelerometer_X_AXIS","Freq_Mean_Body_Accelerometer_Y_AXIS","Freq_Mean_Body_Accelerometer_Z_AXIS","Freq_Std_Deviation_Body_Accelerometer_X_AXIS", "Freq_Std_Deviation_Body_Accelerometer_Y_AXIS","Freq_Std_Deviation_Body_Accelerometer_Z_AXIS","Freq_Mean_Body_Accelerometer_Jerk_X_AXIS","Freq_Mean_Body_Accelerometer_Jerk_Y_AXIS","Freq_Mean_Body_Accelerometer_Jerk_Z_AXIS","Freq_Std_Deviation_Body_Accelerometer_Jerk_X_AXIS", "Freq_Std_Deviation_Body_Accelerometer_Jerk_Y_AXIS","Freq_Std_Deviation_Body_Accelerometer_Jerk_Z_AXIS","Freq_Mean_Body_Gyroscope_X_AXIS","Freq_Mean_Body_Gyroscope_Y_AXIS","Freq_Mean_Body_Gyroscope_Z_AXIS","Freq_Std_Deviation_Body_Gyroscope_X_AXIS",
"Freq_Std_Deviation_Body_Gyroscope_Y_AXIS","Freq_Std_Deviation_Body_Gyroscope_Z_AXIS","Freq_Mean_Magnitude_Body_Accelerometer","Freq_Std_Deviation_Magnitude_Body_Accelerometer","Freq_Mean_Magnitude_Body_Accelerometer_Jerk","Freq_Std_Deviation_Magnitude_Body_Accelerometer_Jerk",
"Freq_Mean_Magnitude_Body_Gyroscope","Freq_Std_Deviation_Magnitude_Body_Gyroscope","Freq_Mean_Magnitude_Body_Gyroscope_Jerk","Freq_Std_Deviation_Magnitude_Body_Gyroscope_Jerk"
