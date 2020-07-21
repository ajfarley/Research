#!/Library/Frameworks/Python.framework/Versions/3.8/bin/python3
"""
Author : Abe Farley ajfarley@email.arizona.edu
Purpose: Convert numpy harmonic or noise to pfb inputs for tilted v domain

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
dz = 0.5
z = 5


start_time = int(sys.argv[1])
end_time = int(sys.argv[2])
signal = genfromtxt('noise_input_july.csv', delimiter=',')
time = len(signal)


nx = 31
ny = 5
nz = 100



for t in range(start_time, end_time):
    forcing_array = np.zeros((nz, ny, nx))
    forcing_array[nz-1,:,:] = signal[t]/dz
    filename = '//Users/abramfarley/ParF/uahpc/matching_inputs/over0.4freq_hn/noise_inputs/noise_input.{:05}.pfb'.format(t)
    pfio.pfwrite(forcing_array, filename, 0, 0, 0, dx, dy, dz)
