#!/Library/Frameworks/Python.framework/Versions/3.8/bin/python3
"""
Author : Abe Farley ajfarley@email.arizona.edu
Purpose: Convert numpy timesynth signal to pfb inputs

Code to read in a csv file created from a TimeSynth generator and then create a
series of pfb inputs to be read into a pf tclscript as the atmo forcings for
each timestep using the pfio import

"""

import numpy as np
from numpy import genfromtxt
import pfio
import sys

np.set_printoptions(threshold=sys.maxsize)

#domain discretization
dx = 10
dy = 10
dz = 0.25
z = 2.5


start_time = int(sys.argv[1])
end_time = int(sys.argv[2])
signal = genfromtxt('signal_layered.csv', delimiter=',')
time = len(signal)
#porosity = pfio.pfread('//Users/abramfarley/ParF/uahpc/tilted_v/TiltedV_Larger/TiltedV_Larger.out.porosity.pfb')
#nx = porosity.shape[2]
#nz = porosity.shape[0]
#ny = porosity.shape[1]

nx = 15
ny = 5
nz = 10


for t in range(start_time, end_time):
    forcing_array = np.zeros((nz, ny , nx))
    forcing_array[0,:,:] = signal[t]/dz
    #print(forcing_array)
    #forcing_array = np.full((ny, nx), signal[t]/dz)
    #forcing_array = forcing_array[np.newaxis,...]
    #filename = 'test.{:05}.pfb'.format(t)
    filename = 'forcing_input_layered.{:05}.pfb'.format(t)
    pfio.pfwrite(forcing_array, filename, 0, 0, 0, 10, 10, 2.5)
    #print(signal[t], signal[t]/dz)
