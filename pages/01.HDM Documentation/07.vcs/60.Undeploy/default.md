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

1. In the on-premises vCenter, select _HDM_ from _Shortcuts_ or from _Menu_ to access the HDM dashboard.
2. Select **Administration** from the tab.
3. Select **Configuration** to access the cluster listing.
4. Find the cluster where HDM is installed and select **Disable** under _Monitoring_

![alt_text](images/image14.png?classes=content-img "image_tooltip")

5. Select _OK_ in the popup.

![alt_text](images/image33.png?classes=content-img "image_tooltip")

6. A reconfiguration task will be created in vCenter for each VM when removing the HDM SPBM policy associated with monitoring.


## Undeploy HDM On-Premises

Prerequisites

1. Ensure the cloud undeploy completed successfully.
2. Ensure disable monitoring completed successfully.


Steps

1. In the on-premises vCenter, select _HDM_ from _Shortcuts_ or _Menu_ to access the HDM dashboard.
2. Select **Administration** from the tab.
3. Select **Configuration** to access the cluster listing.
4. Find the cluster where HDM is installed and select **UNINSTALL**.

![alt_text](images/image11.png?classes=content-img "image_tooltip")

5. Select _OK_ in the _Uninstall On-Premises_ pop-up.

![alt_text](images/image3.png?classes=content-img "image_tooltip")

6. Undeployment tasks will be created for the on-premises components. The task can be monitored in vCenter tasks, as well as in the HDM configuration view.

![alt_text](images/image50.png?classes=content-img "image_tooltip")

7. Wait for the undeployment task to finish.

![alt_text](images/image34.png?classes=content-img "image_tooltip")



## Uninstall HDM Filter from Cluster

**Note**: ESXi on the on-premises cluster must be placed into maintenance mode to uninstall the I/O filter. If the cluster only has one node, ensure that all VMs other than the HDM appliance are powered off.

Prerequisites

1. The HDM on-premises undeployment must be successful.


Steps

1. Access the PrimaryIO appliance from the browser.
2. Log into the appliance using administrator credentials.
3. Select the _vCenters_ tab to view the vCenter listing.
4. Find vCenter and select **Uninstall**.

![alt_text](images/image7.png?classes=content-img "image_tooltip")

5. A popup will guide you through the uninstallation. Select the cluster where HDM is installed.

![alt_text](images/image35.png?classes=content-img "image_tooltip")

6. This will create a task which can be monitored from vCenter tasks.
7. If your Appliance is also part of the cluster and the cluster only has one node, follow these additional steps:
    *   Power off all guest VMs residing on the cluster.
    *   Immediately power off the appliance VM on the on-premises vCenter to enable the cluster host to enter maintenance mode. _This step must be completed before the VIB uninstallation task fails in vCenter_.
    *   Once the uninstall task completes successfully, power on the appliance VM.
    *   After the appliance VM is booted, re-trigger the uninstall from the appliance. This time, the uninstall should succeed without the power on/off requirement.
8. Wait for the uninstall task to finish.

![alt_text](images/image36.png?classes=content-img "image_tooltip")


## Unregister the HDM vCenter Plugin

Unregistering the HDM plugin causes the HDM icon to be removed from vCenter.

Prerequisites

1. Uninstall of the HDM filter must be complete.


Steps

1. Access the PrimaryIO appliance from the browser.
2. Log into the appliance using administrator credentials.
3. Select the _vCenters_ tab to view the vCenter listing.
4. Find vCenter, then select **Unregister**

![alt_text](images/image38.png?classes=content-img "image_tooltip")

5. Once the unregister is successful, the HDM icon should no longer appear in the vCenter menu. However, you must logout and log back in to vCenter to see this change.


## Delete PrimaryIO Appliance from vCenter


    Prerequisites 

1. Ensure that the HDM plugin has been unregistered.


Steps

1. Access the PrimaryIO appliance from the browser.
2. Log into the appliance using administrator credentials.
3. Select the vCenters tab to view the vCenter listing.
4. From vCenter, select **Delete**.

![alt_text](images/image25.png?classes=content-img "image_tooltip")

5. Select **Yes** in the popup to delete vCenter from the appliance.
6. Log into vCenter.
7. Select _Host_, followed by _Clusters_, then power off the PrimaryIO Appliance VM.
8. Right click on the appliance VM and select _Delete from Disk_ to delete the appliance.

