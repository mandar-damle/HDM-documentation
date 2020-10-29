---
title: "Undeploy Steps"
---

## Steps for HDM Undeployment

HDM undeployment consists of the following four steps:



1. Undeploy HDM in the cloud
2. Undeploy HDM on-premises
3. Unregister the HDM vCenter plug-in
4. Delete the HDM appliance from vCenter


## Step 1: Undeploy HDM in the Cloud

Steps



1. In the on-premises vCenter, access the HDM dashboard by selecting _HDM_ from _Shortcuts_ or from the Menu.
2. Select the _Administration_ tab, then _Clouds_ to access the Cloud listing (figure 33).
3. Choose the cloud from the listing and select _DELETE CLOUD_

_Figure 33: vCenter Cloud Listing_


![alt_text](images/image8.png?classes=content-img "image_tooltip")




4. Select _OK_ on the _Delete Cloud_ pop-up (figure 34) to begin the undeployment process.

_Figure 34: Delete Cloud Pop-Up_

![alt_text](images/image9.png?classes=content-img "image_tooltip")




5. This will create an undeployment task for the cloud components. The task can be monitored in _vCenter Tasks_. The progress can be seen in the _HDM Clouds_ view (figure 35).

_Figure 35: HDM Clouds View_


![alt_text](images/image10.png?classes=content-img "image_tooltip")



## Step 2: Undeploy HDM On-premises

Pre-requisites



1. Ensure that the cloud undeploy completed successfully.

Steps



1. To access the HDM dashboard, select _HDM_ from _Shortcuts_ or from the Menu in the on-premises vCenter.
2. Select the _Administration_ tab, then _Configuration_ to access the cluster listing (figure 36)
3. Choose the cluster where HDM is installed and select _UNINSTALL_

_Figure 36: vCenter On-Premises Cluster Listing_


![alt_text](images/image11.png?classes=content-img "image_tooltip")




4. Select _OK_ in the Uninstall On-premises pop-up (figure 37).

_Figure 37: Uninstall On-Premises Pop-up_


![alt_text](images/image12.png?classes=content-img "image_tooltip")




5. This will create an undeployment task for the on-premises components. The task can be monitored in _vCenter Tasks_. The progress can be seen in the _HDM Configuration_ view (figure 38).

_Figure 38: HDM Configuration View_



![alt_text](images/image13.png?classes=content-img "image_tooltip")



## Step 3: Unregister HDM vCenter Plug-in

Unregistering the HDM plug-in causes the HDM icon to get removed from the vCenter.

Steps



1. Access the HDM appliance from the browser.
2. Log into the HDM appliance using the administrator credentials.
3. Select _vCenters_ tab to view the PrimaryIO vCenter listing (figure 39).
4. Choose the vCenter, then select _Unregister._
5. Once the unregister is successful, the HDM icon should not appear in the vCenter menu. However, you must logout and re-login to vCenter to see the change.

_Figure 39: HDM Plug-In in the PrimaryIO vCenter Listing_


![alt_text](images/image14.png?classes=content-img "image_tooltip")



## Step 4: Delete the HDM Appliance from vCenter

Pre-requisites 



1. Ensure that the HDM plug-in has been unregistered.

Steps



1. Access the HDM Appliance from the browser.
2. Log into the HDM appliance using the administrator credentials.
3. Select _vCenters_ tab to view the PrimaryIO vCenter listing (figure 40).
4. Choose the vCenter, then select _Delete_.
5. In the pop-up, select _Yes_to delete vCenter from the HDM appliance.
6. Log into vCenter.
7. Select _Host_ and _Clusters_, then power off the HDM Appliance.
8. Right-click on the HDM appliance and select _Delete From Disk_ to delete the HDM appliance.

_Figure 40: HDM Appliance in the PrimaryIO vCenter Listing_


![alt_text](images/image15.png?classes=content-img "image_tooltip")

