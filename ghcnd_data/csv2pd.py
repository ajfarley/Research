#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 20 14:31:00 2020

@author: abramfarley
"""


###reading in climate data csv from ghcnd dataset
###from new york state

#%%
#import statements
import pandas as pd
import numpy as np
from numpy import genfromtxt
import matplotlib.pyplot as plt


from scipy import pi
from scipy.fftpack import fft
from scipy import fftpack
from scipy import signal
from scipy import integrate

import heapq

#%%
data = pd.read_csv("/Users/abramfarley/Documents/ghcnd_data/2221687.csv") 

#%%
 
precip = data[['DATE', 'PRCP']].copy()

#%%
precip.plot(x='DATE', y='PRCP')

#%%
index = precip.index
columns = precip.columns
values = precip.values


#%%
# get pds column to array format 
a=precip.iloc[:,1:]
b=precip.iloc[:,1:].values
#%%
samplingFrequency_peryear   = 365
samplingFrequency_perday = 1

fourierTransform = np.fft.fft(b)/len(b)
fourierTransform = fourierTransform[range(int(len(b)/2))]

# tpCount     = len(b)
# values      = np.arange(int(tpCount/2))
# timePeriod  = 36367/samplingFrequency #days
# frequencies = values/timePeriod
#%%
#frequency shown in 1/day values 
samplingFrequency_peryear   = 365
samplingFrequency_perday = 1
fourierTransform = np.fft.fft(b)/len(b)
fourierTransform = fourierTransform[range(int(len(b)/2))]
tpCount     = len(b)
values      = np.arange(int(tpCount/2))
timePeriod  = tpCount/samplingFrequency_perday
frequencies = values/timePeriod


plt.plot(frequencies, abs(fourierTransform))
plt.xlabel('frequency (1/day)')
plt.ylabel('magnitude')
plt.title('fft of precip fredonia, ny  1915-2015')


#%%
#frequency shown in 1/year values 
samplingFrequency_peryear   = 365
samplingFrequency_perday = 1
fourierTransform = np.fft.fft(b)/len(b)
fourierTransform = fourierTransform[range(int(len(b)/2))]
tpCount     = len(b)
values      = np.arange(int(tpCount/2))
timePeriod  = tpCount/samplingFrequency_peryear
frequencies = values/timePeriod


plt.plot(frequencies, abs(fourierTransform))
plt.xlabel('frequency (1/year)')
plt.ylabel('magnitude')
plt.title('fft of precip fredonia, ny  1915-2015')


#%%##FFT of the time series

##let us write a code to get the tpo 3 frequencies
real_values = abs(fourierTransform)
ind = real_values.argsort()[-3:][::-1]
print(real_values[ind])


#%%
idx = heapq.nlargest(3, range(len(real_values)), real_values.take)
print(real_values[idx])
print('freq in years', frequencies[idx])




#%%



#%%
# fourierTransform = np.fft.fft(amplitude)/len(amplitude)
# fourierTransform = fourierTransform[range(int(len(amplitude)/2))]

# tpCount     = len(amplitude)

# values      = np.arange(int(tpCount/2))

# timePeriod  = tpCount/samplingFrequency

# frequencies = values/timePeriod