This file contains details about the format of the data processed by the function cleanData(). As
this function returns two data.frames (in a list), each data.frame is explained below in a dedicated
section.

# Original Data

The first element of the list returned by cleanData() is labelled "original data". In this dataset,
there are 73 columns, describing either the subject undergoing the measurements, the variables
measured during the experiment and the different activities that the subject was doing.

* 1. subjectid:
  * The integer identifier of the person (subject) undergoing the tests, ranging from 1 to 30.* 
* 68. Walking:
  * A logical variable indicating if the subject was walking while data was recorded.
* 69. WalkingUpstairs:
  * A logical variable indicating if the subject was walking up a flight of stairs while data was recorded.
* 70. WalkingDownstairs:
  * A logical variable indicating if the subject was walking down a flight of stairs while data was recorded.
* 71. Sitting:
  * A logical variable indicating if the subject was sitting while data was recorded.
* 72. Standing:
  * A logical variable indicating if the subject was standing while data was recorded.
* 73. Laying:
  * A logical variable indicating if the subject was laying while data was recorded.  

For variables ranging from column number 2 to 67, the variables are defined as follows.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals (prefix 'Time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm, labelled as Magnitude. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency domain data, (prefix 'Frequency'). The signals which received this treatment are the 3-axial BodyAccelerometer, BodyAccelerometerJerk and BodyGyroscope, as well as the Euclidian norms BodyAccelerometerJerkMagnitude, BodyGyroscopeMagnitude, BodyGyroscopeJerkMagnitude.

The letters X, Y and Z are appended to the variable names to denote 3-axial signals in the X, Y and Z directions.

Finally, for each of the quantities introduced here, the mean and standard deviation are computed and are stored in the variables which are appended with the label "Mean" and "StandardDeviation", respectively.

# Processed Data

The second element of the list returned by cleanData() is labelled "original data". In this dataset,
there are 73 columns also, and the quantities originate from the description above. However, for each subject and each activity of the original dataset, the mean of each variable was evaluated and stored in a new variable called `<original_name>`MeanPerSubject.
