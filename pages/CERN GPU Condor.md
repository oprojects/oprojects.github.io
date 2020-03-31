---
title: CERN HTCondor GPUs
layout: content
toc: true
---


* Table of Contents 
{:toc}
<br>
# CERN HTCondor GPUs Users Guide

## DESCRIPTION
-----------
In this tutorial I will teach how to setup your environment, write the scripts and submits your jobs to use the GPUs in HTCondor batch system at CERN.
The objective is to train machine learning  models using or not jupyter notebooks.
The official tutorial can be found at [https://batchdocs.web.cern.ch/index.html](https://batchdocs.web.cern.ch/index.html)
I am taking only the required for GPUs proccesing.


## The most basic test
-----------
The objective is to get an interactive session in a gpu machine quickly,
for that we need to do the next steps.

1. 1) connect to lxplus 


2. 2) write a script file job.sh with the next code


```sh
universe                = vanilla
arguments               = 
log                     = test.log
output                  = outfile.$(Cluster).$(Process).out
error                   = errors.$(Cluster).$(Process).err
                                                                                                                                                                                                                                                             
request_gpus = 1 #required to take a node with GPU                                                                                                                                                                                                                                      
+testJob = True # required to get priority in the queue (just to do short tests)                                                                                                                                                                                                                                              
queue           
```

3. 3) submit the job with


```sh
condor_submit -interactive job.sh
```

When you get the prompt you can load the cvmfs stack for machine learning already compiled with cuda

```sh
source /cvmfs/sft.cern.ch/lcg/views/LCG_96py3cu10/x86_64-centos7-gcc7-opt/setup.sh 
```

Lets check that the GPU is working in tensorflow,
open ipython and write

```py
import tensorflow as tf 
tf.test.is_gpu_available()
```

The return should be True.

4. 4) to check the GPUs stats run
```sh
nvidia-smi
```




## Training with python script
In this  section the objetive is to train a basic model in tensorflow
without an interactive session. For that porpuse with need to create two scripts, one with the tf code and a second one in 
bash to load the environment. 
The model based on this tutorial https://machinelearningmastery.com/tutorial-first-neural-network-python-keras/
it is just an ilustrative example where keras is taken from tensorflow.

write the 3 files code.py job.sh and train.sh to submit the job

code.py
```py
from numpy import loadtxt
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
# load the dataset
dataset = loadtxt('./pima-indians-diabetes.data.csv', delimiter=',')
# split into input (X) and output (y) variables
X = dataset[:,0:8]
y = dataset[:,8]
# define the keras model
model = Sequential()
model.add(Dense(12, input_dim=8, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1, activation='sigmoid'))
# compile the keras model
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
# fit the keras model on the dataset
model.fit(X, y, epochs=150, batch_size=10)
# evaluate the keras model
_, accuracy = model.evaluate(X, y)
print('Accuracy: %.2f' % (accuracy*100))
```
job.sh
```.sh
universe                = vanilla
executable              = train.sh
arguments               = 
log                     = test.log
output                  = outfile.$(Cluster).$(Process).out
error                   = errors.$(Cluster).$(Process).err
should_transfer_files   = NO
+JobFlavour = "espresso"
#espresso     = 20 minutes
#microcentury = 1 hour
#longlunch    = 2 hours
#workday      = 8 hours
#tomorrow     = 1 day
#testmatch    = 3 days
#nextweek     = 1 week
request_gpus = 1
queue
```

train.sh

```.sh
#!/bin/bash
source /cvmfs/sft.cern.ch/lcg/views/LCG_96py3cu10/x86_64-centos7-gcc7-opt/setup.sh
cd path_to_your_code.py
python code.py
```


to submit the job run
```.sh
condor_submit job.sh
```
