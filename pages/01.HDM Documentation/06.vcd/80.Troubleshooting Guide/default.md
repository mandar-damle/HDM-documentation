---
title: Troubleshooting
---

This section covers troubleshooting for issues known in the HDM product. In case there are issues that are not covered in this document or are not resolved easily, users should contact PrimaryIO support for further help. 

# HDM Deployment


###### **Failures during HDM deployment are not currently handled for recovery**

Failures during the HDM deployment On-Premise or On-Cloud will require the user to first clean the state using HDM reset and retry the deployment. In the current release, HDM doesn’t attempt to automatically recover from deployment failures. (Ref: **CP-4686)**


###### **Deployment taking time or appears in a hung state**

During deployment, the synchronization with NTP server is required. This operation may take time and during this period, the deployment may seem stuck or taking longer than expected. User is not required to take any action here, there will be a delay after which the deployment would continue as usual.

(Ref: **CP-4419)**


###### **Deployment failure with message “Please check the credentials for &lt;IP Address>**

This failure can occur either due to incorrect credentials or incorrect VCD Organization name. Providing the correct credentials or organization name should resolve this issue. (Ref: **CP-5395**)


###### **Deployment failure with message “Insufficient resources to satisfy configured failover level for vSphere HA”**

If there are insufficient CPU or memory resources On-Premise or On-Cloud, the HDM deployment can fail with event in vCenter “Insufficient resources to satisfy configured failover level for vSphere HA”.  

This should be avoided by choosing HDM deployment type according to the resource availability On-Premise and On-Cloud or change the Deployment Type.(Ref: **CP-4243**)


###### **Network configuration change for the PIO Appliance**

If the network selected during PIO Appliance deployment is incorrect and vCenter has not been added yet, user can change the network using the following procedure



1. Power off PIO Appliance
2. Change the network by editing vApp options and set the correct configuration
3. Reboot the PIO Appliance

If the add vCenter has already been performed, change of the network is not possible on the deployed Appliance. User needs to redeploy PIO Appliance.


###### **HDM does not support IPv6 based IPs**

HDM does not support IPv6 configured vmware environments. 


###### **The PIO Appliance password cannot be recovered**

The PIO Appliance password was changed and the user has forgotten the new password.

**Resolution:** Contact PrimaryIO Support to change the password.


###### **A user who **d**oes **n**ot **h**ave **a**dministrator **p**rivileges for a vCenter cannot add that vCenter to the PIO Appliance**

**Resolution: **The user will have to be assigned, administrator privileges for the vCenter that needs to be added.** **Follow the steps described below to assign administrator privileges to the user:



1. Go to **Administration > Users and Groups** from the **Navigation** bar in vCenter.
2. Under **Users** tab, click on **Add User** button as shown in the image below.nishtha-optiplex-3020@ad

	


![alt_text](images/image3.png?classes=content-img "image_tooltip")




3. Once the new user is created, click on **Administrator** > **Global Permissions** from the **Navigation** bar.
4. Under the **Manage** tab, click on the **Add Permissions** button. The **Add Permission** window will be displayed.
5. Select **Administrator** from the **Assigned Role** drop-down. Select **Propagate to children** and click **Add **to add the user.
6. The **Select Users/Groups** window will be displayed.
7. Select the appropriate domain from the **Domain** drop down box.
8. Select the appropriate user and click on **Add**.
9. Click on **OK** to complete the process of assigning administrator privileges to the user.

This user will now be able to add the vCenter to the PIO Appliance.


###### **vCenter is in an ERROR state in the vCenter page in PIO Appliance**

A vCenter entry in the PIO Appliance can show an _‘ERROR’_ state if its credentials have been changed externally in the vCenter after adding it to the PIO Appliance. This issue can also occur if the vCenter is no longer reachable.

**Resolution: **



1. Click on the **Edit** action as shown below.




![alt_text](images/image2.png?classes=content-img "image_tooltip")




2. Enter and save the correct (or most recent) vCenter credentials.




![alt_text](images/image4.png?classes=content-img "image_tooltip")



###### **HDM plugin is not visible on vCenter**

HDM plugin fails to appear in vCenter’s UI even though it has been registered with the vCenter. 

**Resolution: **



1. [Unregister the HDM plugin from vCenter](https://docs.google.com/document/d/18amfu5ZjgqTv-qsmg2pdA__MILma4K1mQlgIxF8p3N0/edit#heading=h.3fwokq0).
2. Search and delete _‘PrimaryIO’_ or _‘praapa’_ files from vCenter. To find the files execute the following command:

	


    _find / -name **piohyc** -exec rm -rf {} +; service-control --stop vsphere-ui;service-control --start vsphere-ui;"_



3. Restart vCenter.
4. [Register HDM plugin](https://docs.google.com/document/d/18amfu5ZjgqTv-qsmg2pdA__MILma4K1mQlgIxF8p3N0/edit#heading=h.1v1yuxt) again with the same vCenter from where it was deleted.


###### **Network configuration issues for On-Cloud deployment **

In case, On-Cloud VCD is configured on different networks and resolved through different DNS settings. In this case On-Cloud VCD will get added if correct DNS is set during Add Cloud, but ESXi resolution will fail resulting in Cold and Warm migration Failure. 

Similarly, “Add Cloud” may fail if On-Cloud VCD has been configured with FQDN and DNS to resolve vCenter is incorrect or is not provided during the operation.

**Resolution: ** Customers should add rules in their Network to forward resolution of these FQDN to the correct DNS, whether it is for the vCenter or ESXi.


###### **Installation Failed - Exception during container create syncd-cloud **

This can happen if the VCD cloud end-point is not reachable. The current operation being performed (deployment, mugration) will fail. The connectivity to cloud end-point needs to be re-established before continuing. (Ref : **CP-5596**) 



# HDM Migrations


###### **Not able to connect or validate Key Manager. Please verify settings**

This issue can occur when CA certificate details are provided for Key Manager. Providing valid CA certificates for Key Manager will resolve the issue.  (Ref: **CP-5408**)


###### **HDM Disk Controller Support**

Following are known limitations with virtual machine disk controller configurations for migration to VMware Cloud Director. HDM does not support migration of:



1. Virtual machines having SATA and IDE based virtual disks
2. Virtual machines having more than 3 controllers if the first controller is not paravirtual.
3. Virtual machines with more than 15 virtual disks for the first paravirtual controller.
4. Virtual machines with LSI controller as boot disk and paravirtual controller as data disks. 


###### **VM fails to poweron on IBM VCD after migration is successfully completed. **

This can happen is the CPU resources are exhausted for the VCD organization into which the migration happened. Do update the CPU resources and try powering-on the VM. (Ref: **CP-5469**) 


###### **IPs may not be allocated for virtual machines having Ubuntu16 or SLEL16 Operating System post migration**
This is a known issue with these operating systems. IP addresses will need to be allocated manually. (Ref : **CP-5626**)


###### **Cold migration may be retried even after the user cancelled the vCenter task**

If the vCentre task for cold migration is cancelled by the user, the existing task gets cancelled. However, HDM re-attempts, the cold migration till all the retry attempts are over. The user should cancel all the re-attempts, so as to truly cancel the operation, (Ref: **CP-4365)**


###### **Migration failure due to insufficient space on the target**

Even though HDM checks free space on the target of a warm migration, the available space on target cannot always be pre-validated because actual storage required for thin disks can vary. This may lead to failure because of insufficient storage space during migration. 

User should explicitly make sure that the target has enough free space before attempting to migrate. 

(Ref: **CP-4301)**


###### **Applications on migrated VMs may fail due to incorrect network mapping specified**

During add cloud operation, users should specify the correct default application network On-Cloud or map  On-Premise network to On-Cloud network. Failing to do so, the VM migration may succeed but applications on the migrated VMs may fail. In the SQS based migration, the network mapping can be specified at the migration time. (Ref: **CP-4433)**


###### **Enable Virtualized CPU Performance Counters Check flag not reatined on cloud**

Certain virtual machine parameters may not be retained post migration. These will need to be set manually. (Ref : **DP-2859**)


###### **vCenter does not show the option to migrate VM**

After complete deployment, users may not find any action available to migrate VM in vCenter or it may just show ‘loading...’. 

**Resolution**: The solution will be do logout-login of vCenter and try again migrating, if it still not giving any option then please restart vsphere-ui (`service-control --stop vsphere-ui;service-control --start vsphere-ui;`)  service from the vcenter ssh console.


###### **Already completed Migration status for Virtual machine goes into an error state**

For each Virtual Machine migration a vCenter task is created. The progress and status of migration is then updated in the vCenter task object. The same status is also reflected on the Migration’s In-Progress tab on HDM vCenter Plugin for global and cluster view. In cases where the task has been completed, a vSphere server may delete the reference from the vSphere database. In this case, as the task object has been removed, the correct status of migration does not reflect on the UI and shows the migration state as ERROR. Users can check the task status under vCenter task list for the virtual machine to get the correct status.


###### **IP conflict if HDM internal network configured with DHCP for Ubuntu and SLES**

In HDM On-Cloud deployment, if the Internal network on the On-Cloud is configured for DHCP IP addresses, IP addresses assigned to migrated VM (WARM or TBC) with DHCP can experience lease timeout. This is because on some versions of Linux distributions (mainly all Ubuntu and SLES distributions) DHCP lease is not renewed for the IBFT enabled NIC which is connected to the Internal network for TFTP/iSCSI booting. 

All the versions of Windows and RHEL/CentOS distributions are not affected by this issue.

If the Internal network on the On-Cloud is configured for IP addresses with Static IP address pool, this issue will not arise.

Workaround:



*   If HDM On-Cloud deployment is configured for DHCP IP addresses on the Internal network, configure DHCP IP address lease timeout to be greater than the time the migrated VM is supposed to stay booted on the On-Cloud.
*   Configure the HDM On-Cloud deployment to use IP addresses with Static IP address pool on the Internal network.

(Ref: **DP-2777**)


# HDM System Health


###### **Failure Alerts and Notification HDM component or operations failure details are not visible in vCenter. **

Failures for migration/ migration back, On-Premise deployment and add On-Cloud are shown in vCenter under Tasks and Events. Any failure seen due to the HDM component going down is also captured within vCenter events with the description starting with ‘<code><em>com.primaryio.hdm.'</em></code>. This is currently shown in HTML and Flash view of the vCenter. However the details for the failures are not always available in both the views, for example for vCenter version 6.5 it is available in the Adobe Flash view. Such information is also available in the Health Tab of HDM plugin.  


###### **PIO Appliance not reflecting the failure status of HDM components**

If a HDM On-Cloud component VM remains shutdown for an extended period, the failed HDM components health may not get reflected in the PIO Appliance. 

However**, **the failed component will be detected and alerts can be seen in the Home -> HDM ->Administration->Health->Component Health. Once the component VM gets rebooted successfully, the PIO Appliance will correctly show the health of all components. (Ref: **CP-4647**)


# Failure Handling in HDM


###### **HDM is in a hung state or crawling**

This can happen sometimes when there is a failure that HDM is repairing, for example a component failure. The repair may be  in progress but it is not complete. Users might notice a hung system while HDM is still attempting, retrying for recovery.  It may happen both when HDM is deployed but there is no activity on the system or it may happen when there is migration activity on the system. 

Users can wait for sometime and give time for  the system repair to complete. If it looks that HDM recovery is stalled for some reason, it recommended that the user executes HDM reset and proceeds with the redeployment with a clean state. 


###### **HDM has active migrations going on but the migrations did not complete as expected**

A user starts a few migrations or the user might have ongoing migrations. All or some of the migrations might not complete due to a failure. A failure in Cloud_Msg_GW could cause this. An HDM Reset and cancelling of tasks on VCenter is required to resolve this.  


###### **HDM Appliance got hung due to its datastore space full**

HDM Appliance can get hung if the datastore on which it was present has no space left.

Users should power off the HDM Appliance VM, create enough space in the datastore and power on the Appliance again. Please note that datastore full can cause other issues and the resolution here may not always work. User may need to do HDM reset or re-deploy HDM with appropriate storage.


###### **How do network disconnects result in failures**

HDM is deployed both On-Premise and on the On-Cloud. VMs migrate from the On-Premise to the On-Cloud, there are occasions when VMs are migrated back to the On-Premise after a temporary migration to the On-Cloud (for example for the TBC use case) or because of a failure during the migration. The Network availability is critical during the entire Migration operation and for continuity of HDM component services. 

Thus the disruption in the network connectivity is tolerated for a limited time, typically upto 4-5 minutes  beyond which HDM gets into Failure and Recovery mode. Recovery operation will also succeed only when the Network is available. If the system gets into a state where HDM reset needs to be executed, it can succeed only when the network connectivity is available for cleaning up the state on the On-Cloud. 

HDM operations are designed for retries and resilience for somewhat jittery Networks. More than 4-5 minutes of continuous disconnect triggers failures and eventual process of recovery and repair if that network becomes available. 


# HDM Undeployment


###### **HDM On-Cloud uninstall fails when one of the ESXi hosts in the cluster on which it was installed is inaccessible**

Uninstallation happens at the cluster level and it will fail if any host in the cluster is unavailable.

**Resolution**: System administrators will have to first resolve the connection issue with the unreachable ESXi host and then retry the uninstallation process.


###### **HDM plugin entry is not removed from the vCenter after  HDMplugin is unregistered from the appliance.**

An entry for the HDMplugin continues to be displayed in the Administration->Client Plug-Ins listing or in the Menu even after it has been unregistered from the appliance.

This is a vCenter listing issue and does not affect the vCenter functionality.

**Issues**: The new plugin may not load properly if we register the same or lower plugin version but a higher plugin version will always work.

**Resolution**: Steps are:  



1. SSH to vCenter shell.
2. Following command will find and delete all stale entries for HDM and will restart vsphere-ui service.

        "`find / -name *piohyc* -exec rm -rf {} +;  service-control --stop vsphere-ui;service-control --start vsphere-ui;`"


###### **Undeployment while migration is in progress**

Do not perform On-Cloud undeployment while migrations are in progress. The UI does not prevent this action. However, the undeployment can fail and the migrating VMs cleanup may not happen. 

(Ref: **CP-4373)** 


# HDM Reset


###### **HDM Reset did not remove all component VMs**

If there is a network disconnect between appliance and On-Cloud, HDM components On-Cloud  and migrated VMs will not get deleted. Even though the HDM reset task on vCenter shows as completed,  HDM components as well as migrated VMs might still be present on the On-Cloud leaving the system in an unclean state. 

**Resolution**: The resolution is to manually delete HDM components and migrated VMs for completing the process of clean up and get it to state for new deployment. 


###### **HDM Reset failure due to PIO Appliance restart issues**

As part of HDM reset, PIO Appliance VM restart is required. In some cases, this restart may not succeed or the PIO Appliance may not get IP. 

**Resolution**: This could be a transient error situation and the user should attempt restart of the PIO Appliance so that the HDM reset can complete successfully. (Ref: **CP-4610)**


###### **Cleanup issues due to ESXi host reboot during HDM Reset**

During HDM reset, if any of the ESXi hosts in the On-Premise cluster is rebooted for some reason, the cleanup for that host may not happen. The HDM reset may still succeed, however a future attempt for On-Premise deployment may fail. 

**Resolution**: In such a situation, users should do HDM reset again and perform redeployment. 

(Ref: **CP-4648)**


###### **HDM Reset did not start even after rebooting the PIO appliance**

Post appliance reboot, HDM reset task stays in queued state even after the appliance has been rebooted. This may happen if there has been some transient issues while configuring all the network adapters within the PIO appliance post reboot.

**Resolution: **In such a situation, users should reboot the appliance again. (Ref: **CP-4836**)


###### **HDM Reset and other operations fail after rebooting the PIO appliance post an ESXi failure**

In case of non DRS or HA enabled clusters, when an ESXi on which PIO Appliance fails the vApp option properties set on the virtual machine gets reset.

**Resolution:** Need to perform the following steps:



*   Power off appliance
*   Under Configure->vapp-> edit and under OVF setting, reset the VMware tool checkbox and save.
*   Again Under Configure->vapp-> edit and under OVF setting, set the VMware tool checkbox and save.
*   Power on the appliance

(Ref: **CP-4848**)
