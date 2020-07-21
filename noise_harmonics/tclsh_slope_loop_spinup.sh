#!/bin/bash

#loop to run multiple tcl scripts at various slopex

for d in 0.02 0.05 0.08 0.1
do
  tclsh spinup.tcl $d
done
