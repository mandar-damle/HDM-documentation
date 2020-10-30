---
title: 'Undelpoy Steps'
---

## Steps for HDM Undeployment

HDM undeployment consists of the following high level tasks:

1. Undeploy HDM in the cloud
2. Disable monitoring
3. Undeploy HDM on-premises
4. Uninstall the HDM filter from the cluster
5. Unregister the HDM vCenter plugin
6. Delete the PrimaryIO appliance from vCenter


## Undeploy HDM in the Cloud

Prerequisites

1. Ensure that all virtual machines have been migrated back to the on-premises environment. To do this, check to make sure the resource pool _HDM_MIGRATE_POOL_ in the on-premises vCenter is empty.


Steps

1. In the on-premises vCenter, select _HDM_ from _Shortcuts_ or from _Menu_ to access the HDM dashboard.
2. Select **Administration** from the tab.
3. Select **Clouds** to access the cloud listing.
4. Select the appropriate cloud from the listing, then select **DELETE CLOUD**

![alt_text](images/image28.png?classes=content-img "image_tooltip")

5. Select **OK** on the _Delete Cloud_ popup to begin the undeployment.

![alt_text](images/image10.png?classes=content-img "image_tooltip")

6. This will create undeployment tasks for the cloud components. The task can be monitored in vCenter tasks, as well as in HDM clouds view.

![alt_text](images/image24.png?classes=content-img "image_tooltip")

7. Wait for the undeployment task to finish.

![alt_text](images/image32.png?classes=content-img "image_tooltip")



## Disable Monitoring

Prerequisites

1. There must not be any VMs migrated to cloud (i.e., the _HDM_MIGRATE_POOL_ resource pool in the on-premises vCenter must be empty).


Steps

1. In the On-Premise vCenter, click on HDM from Shortcuts or from Menu to access the HDM dashboard
2. Select **Administration** from the tab
3. Click on **Configuration** to access the cluster listing
4. Against the cluster on which HDM is installed, click on **Disable** under monitoring



![alt_text](images/image14.png?classes=content-img "image_tooltip")




1. Click on OK in the popup that appears



![alt_text](images/image33.png?classes=content-img "image_tooltip")




1. For each VM a reconfiguration task in vCenter will be created when removing HDM SPBM policy as part of disabling the monitoring.


## Undeploy HDM On-Premise

Pre-requisites



1. Ensure On-Cloud undeploy completed successfully.
2. Ensure disable monitoring completed successfully.

Steps



1. In the On-Premise vCenter, click on HDM from Shortcuts or from Menu to access the HDM dashboard
2. Select **Administration** from the tab
3. Click on **Configuration** to access the cluster listing
4. Against the cluster on which HDM is installed, click on **UNINSTALL.**



![alt_text](images/image11.png?classes=content-img "image_tooltip")




5. Click on OK in the Uninstall OnPrem pop-up

![alt_text](images/image3.png?classes=content-img "image_tooltip")




6. This will create undeployment tasks for On-Premise components. The task can be monitored in vCenter Tasks. Also, the progress can be seen in HDM configuration view.


![alt_text](images/image50.png?classes=content-img "image_tooltip")



7. Wait for the undeployment task to finish.


![alt_text](images/image34.png?classes=content-img "image_tooltip")



## Uninstall HDM Filter from Cluster

**Note**: IO filter uninstallation requires ESXi on the On-Premise cluster to be put into maintenance mode. Please ensure that if the cluster has only one node, then all the VMs other than HDM Appliance are powered off.

Pre-requisites



1. HDM On-Premise undeployment must be successful

Steps



1. Access PrimaryIO Appliance on browser.
2. Log into Appliance using Administrator credentials.
3. Select tab vCenters to view the vcenter listing.
4. Against the vCenter, click on **Uninstall**.


![alt_text](images/image7.png?classes=content-img "image_tooltip")




5. A pop up will open which will guide the admin through uninstallation. Select the correct cluster on which the HDM was installed


![alt_text](images/image35.png?classes=content-img "image_tooltip")




6. This will create a task which can be monitored from vCenter tasks.
7. If your Appliance is also part of the cluster and the cluster has just 1 node, you should follow these additional steps
    *   You should power off all the guest VMs residing on that cluster.
    *   You should immediately go to the On-Premise vCenter and power off the Appliance VM, so that the cluster host can go in maintenance mode. You have to do it, before the task of uninstallation of VIB fails in the vCenter.
    *   Once the uninstall task completes successfully, power on the Appliance VM.
    *   After the Appliance VM is booted, re-trigger the uninstall from the Appliance. This time the uninstall should succeed without the power on-off requirement.
8. Wait for the uninstall task to finish, that can be seen on pop up.


![alt_text](images/image36.png?classes=content-img "image_tooltip")



## Unregister HDM vCenter Plugin

Unregistering the HDM plugin causes the HDM icon to get removed from the vCenter.

Pre-requisites



1. Uninstall of HDM filter must be complete.

Steps



1. Access PrimaryIO Appliance on browser.
2. Log into Appliance using Administrator credentials.
3. Select tab vCenters to view the vcenter listing.
4. Against the vCenter, click on **Unregister**


![alt_text](images/image38.png?classes=content-img "image_tooltip")




5. Once the unregister is successful, the HDM icon should not appear in the vCenter menu. However, to see this change, you must logout and login to the vCenter again.


## Delete PrimaryIO Appliance from vCenter


    Pre-requisites 



1. Ensure that HDM plugin has been unregistered.

Steps



1. Access PrimaryIO Appliance on browser.
2. Log into Appliance using Administrator credentials.
3. Select tab vCenters to view the vcenter listing.
4. Against the vCenter, click on **Delete**.



![alt_text](images/image25.png?classes=content-img "image_tooltip")




5. On the popup, click on **Yes** to delete the vCenter from the Appliance.
6. Log into vCenter.
7. From Host and Clusters, power off PrimaryIO Appliance VM.
8. Right click on the Appliance VM and select Delete from Disk to delete the Appliance.

