#!/bin/bash

# build VCD macros

# m4 -dtfl 
# use -dtfl to debug where the macros are 
# clear build log
echo > build.log

# Build the deployment section of all types

## VCS
echo VCS Build start >> build.log
echo ============= >> build.log
### deployment
echo VCS Build deployment >> build.log
echo ============= >> build.log
m4 -dtfl VCS/VCS-Deployment.m4 > ../pages/04.HDM\ Doc\ 2.2/08.vcs/40.Deployment\ Steps/default.md 2>>build.log
### migration
echo VCS Build migration >> build.log
echo ============= >> build.log
m4 -dtfl VCS/VCS-Migration.m4 > ../pages/04.HDM\ Doc\ 2.2/08.vcs/50.Performing\ Migrations/default.md 2>>build.log


## VCD
echo VCD Build start >> build.log
echo ============= >> build.log
### deployment
echo VCD Build deployment >> build.log
echo ============= >> build.log
m4 -dftl VCD/ibm-vcd-Deployment.m4 >  ../pages/04.HDM\ Doc\ 2.2/07.vcd/40.Deployment\ Steps/default.md 2>>build.log
### migration
echo VCD Build migration >> build.log
echo ============= >> build.log
m4 -dftl VCD/ibm-vcd-Migration.m4 >  ../pages/04.HDM\ Doc\ 2.2/07.vcd/50.Performing\ Migrations/default.md 2>>build.log

## CDS
echo CDS Build start >> build.log
echo ============= >> build.log

### deployment
echo CDS Build deployment >> build.log
echo ============= >> build.log
m4 -dftl CDS/CDS-Deployment.m4 > ../pages/04.HDM\ Doc\ 2.2/06.cds/40.Deployment\ Steps/default.md 2>>build.log

### migrations
# CDS migration is a symlink from VCD