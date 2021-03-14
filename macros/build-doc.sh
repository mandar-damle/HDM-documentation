#!/bin/bash

# build VCD macros

# m4 -dtfl 
# use -dtfl to debug where the macros are 
# clear build log
echo > build.log

# Build the deployment section of all types

## VCS
m4 -dtfl VCS/VCS-Deployment.m4 > ../pages/04.HDM\ Doc\ 2.2/08.vcs/40.Deployment\ Steps/default.md 2>>build.log

## VCD
m4 -dftl VCD/ibm-vcd-Deployment.m4 >  ../pages/04.HDM\ Doc\ 2.2/07.vcd/40.Deployment\ Steps/default.md 2>>build.log

## CDS
m4 -dftl CDS/CDS-Deployment.m4 > ../pages/04.HDM\ Doc\ 2.2/06.cds/40.Deployment\ Steps/default.md 2>>build.log
