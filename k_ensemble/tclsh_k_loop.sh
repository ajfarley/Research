#!/bin/bash

#loop to run multiple tcl scripts at various slopex

for d in 1 5 10
do
  tclsh tiltedv_variablek.tcl $d
done
