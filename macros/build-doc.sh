#!/bin/bash

# build VCD macros

# m4 -dtfl 
# use -dtfl to debug where the macros are 
# clear build log
echo > build.log
m4 -dtfl VCS-Deployment.m4 > ../pages/04.HDM\ Doc\ 2.2/08.vcs/40.Deployment\ Steps/default.md 2>>build.log

m4 -dftl ibm-vcd-Deployment.m4 >  ../pages/04.HDM\ Doc\ 2.2/07.vcd/40.Deployment\ Steps/default.md 2>>build.log