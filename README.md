# HDM Documentation

http://docs.primaryio.com  

|Documentation Type| Git branch| Public URL|
|--|---|---|
|Published official docs| RELEASE | http://docs.primaryio.com  |
|Pre-release docs under development | master | http://ec2-34-222-41-154.us-west-2.compute.amazonaws.com/ |
  
Steps to configure a grav server.
https://docs.google.com/document/d/1rJcLI2-yTGhndvP3TW-EEtxZ__KkkowfV4GyCbSmVrE/edit#heading=h.x2wyo4w0hvz7

Steps to modify the document.
https://docs.google.com/document/d/1nBjm9kzM93IMkwZ_GeK7QAzzIR_WK6yIPgg4ebHvXhE/edit?usp=sharing

# Macros to generate the docs.

HDM product supports multiple VMware platforms like

* IBM VCS
* IBM VCD
* VMware CDS
* generic VCD

To avoid confusion there are seperate manauals for each of these platforms. 

In the initial versions of the document these content for these sections were duplicated or where identical was a symbolic link to avoid duplication. 

Since version 2.2.1 we have created a m4 based macro layer which does macro substitution to generate the different versions of the document. There is a golden version of the document with m4 macros and conditional generation clauses. 

The structure is as follows
/macros/build-doc.sh - Script to generate final .md documents in /pages/

# References

* https://www.gnu.org/software/m4//manual/m4-1.4.16/m4.html
