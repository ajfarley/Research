#!/bin/bash

#loop to run multiple tcl scripts at various slopex

for d in 0.1 0.01
do
  tclsh spinup.tcl $d
done
