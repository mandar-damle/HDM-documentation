--- 
title: 'Support Logs'
---

If you require technical support for HDM, you will need to provide the HDM support logs and VMware support logs from the deployed system. The collected logs must be provided to HDM support, along with a description of the issue.


### Download HDM Logs

Pre-requisites



1. HDM appliance must be powered on.

Steps for download



1. Log into the HDM appliance by accessing _https://&lt;appliance ip>_ in a supported web browser. 
2. Select the user profile icon in the top right corner, and choose _Download Debug Logs_ (figure 41).
3. A zip file named _pio_logs.zip_ will be downloaded. This file can be sent as an attachment for further analysis of the issue.

_Figure 41: Downloading Debug Logs from HDM_




![alt_text](images/image16.png "image_tooltip")



### Download _VMware support_ logs

Steps:



1. Log into the on-premises vCenter from the vSphere web client. Right-click on the vCenter IP and select _Export System Logs_ (figure 42).
2. From the _Select Hosts_ page, select the hosts that are part of the cluster where HDM is installed. Also select the _Include vCenter and vSphere Web Client Logs_ option.
3. Complete the rest of the wizard to generate a zip file containing the _VMware support_ _logs_ from the vCenter and ESXi hosts.

_Figure 42: Downloading System Logs from vCenter_


![alt_text](images/image1.png "image_tooltip")



