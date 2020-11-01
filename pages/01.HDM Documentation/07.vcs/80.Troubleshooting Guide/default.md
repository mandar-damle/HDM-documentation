---
title: Troubleshooting
---

This section covers troubleshooting for known issues in HDM 2.1.3. In the event there are issues that are not covered in this document or are not easily resolved, contact PrimaryIO support for assistance. 


# HDM Deployment


###### **Failures during HDM deployment are not currently handled for recovery**

Failures during HDM deployment on-premises or in the cloud will require the state to be cleaned using HDM reset, then the deployment can be retried. In the current release, HDM does not attempt to automatically recover from deployment failures. (Ref: **CP-4686)**


###### **Deployment taking time or appears to be in a hung state**

During deployment, synchronization with the NTP server is required. This operation may take time. During this period, the deployment may seem stuck or taking longer than expected. No action is required. After this expected delay, the deployment will continue as usual. (Ref: **CP-4419)**


###### **Deployment failure with message “Insufficient resources to satisfy configured failover level for vSphere HA”**

Insufficient CPU or memory resources on-premises or in the cloud may cause the HDM deployment to fail and log the following event in vCenter: “Insufficient resources to satisfy configured failover level for vSphere HA.”  

This can be avoided by choosing the HDM deployment type based on the availability of on-premises and cloud resources. (Ref: **CP-4243**)


###### **Network configuration change for the PIO Appliance**

If the network selected during deployment of the PrimaryIO appliance is incorrect and vCenter has not been added yet, the following procedure can be used to change the network:

1. Power off the appliance
2. Change the network by editing vApp options and setting the correct configuration
3. Reboot the appliance

If vCenter has already been added, it is no longer possible to change the network. The appliance will need to be redeployed.


###### **HDM does not support IPv6 based IPs**

HDM does not support an IPv6 configured VMware environment. 


###### **The PrimaryIO appliance password cannot be recovered**

After changing the default appliance password, the new password has been forgotten.

**Resolution:** Contact PrimaryIO support to reset the password.


###### **A user who does not have administrator privileges for a specified vCenter cannot add that vCenter to the appliance**

**Resolution:** The user must be assigned administrator privileges for the specified vCenter. Follow the steps below to do this:

1. Select _Administration_, followed by _Users and Groups_ in vCenter.
2. Select the _Users_ tab, then _Add User_, as shown below.

![alt_text](images/image4.png?classes=content-img "image_tooltip")

3. Once the new user has been created, select _Administrator_, followed by _Global Permissions_ from the navigation bar.
4. Select the _Manage tab, followed by _Add Permissions_. The _Add Permission_ popup window will appear.
5. Select _Administrator_ from the _Assigned Role_ drop-down. Select _Propagate to children_, then select _Add_ to add the user.
6. The _Select Users/Groups_ window will be displayed.
7. Select the appropriate domain from the _Domain_ drop down box.
8. Select the appropriate user, then _Add_.
9. Select _OK_ to complete the process.

This user will now be able to add the specified vCenter to the appliance.


###### **vCenter is in an ERROR state on the vCenter page in the appliance**

A vCenter entry in the PrimaryIO appliance can show an _‘ERROR’_ state if its credentials have been changed externally in vCenter after adding it to the appliance. This issue can also occur if vCenter is no longer reachable.

**Resolution: **

1. Select **Edit** on the appropriate entry line.

![alt_text](images/image2.png?classes=content-img "image_tooltip")

2. Enter and save the correct (or most recent) vCenter credentials.

![alt_text](images/image1.png?classes=content-img "image_tooltip")


###### **The HDM plugin is not visible on vCenter**

The HDM plugin fails to appear in the vCenter UI, despite having been registered with vCenter. 

**Resolution: **

1. Unregister the HDM plugin from vCenter.
2. Search and delete the _‘PrimaryIO’_ or _‘praapa’_ files from vCenter. Execute the following command to locate the files:

    _find / -name **piohyc** -exec rm -rf {} +; service-control --stop vsphere-ui;service-control --start vsphere-ui;"_

3. Restart vCenter.
4. Re-register the HDM plugin with the same vCenter it was deleted from.


###### **The HDM deployment for the on-premises cluster fails if vCenter reflects an invalid state**

The HDM filter deployment on a cluster is unsuccessful and the ‘_Install Filter Task’_ shows vCenter in an invalid state (‘vim.fault.InvalidState’).  

This can happen if the previous version of HDM has not been cleanly uninstalled, or the PrimaryIO appliance IP that was used during installation is not reachable. In this case, check the EAM logs within vCenter and look for the error message, `"https://&lt;IP>/bundle/primaryio_6.x.zip is not reachable". Check to ensure the IP of the appliance is the same one that is shown in the error message, and that the URL is reachable.

**Resolution:** Log into “https://&lt;vcenter_ip>/eam/mob” using vCenter administrator credentials to access the ESXi Agent Manager. Next to _agency_ you will see _ArrayofManagedObjectReference_. 

![alt_text](images/image5.png?classes=content-img "image_tooltip")

Select the associated action to obtain the list of agents. Then, check _AgencyConfigInfo_ to see if if belongs to PrimaryIO. 

![alt_text](images/image6.png?classes=content-img "image_tooltip")

Select _Uninstall_ if the agent was not cleanly uninstalled earlier. Wait for the uninstallation task to succeed in vCenter, then select _Destroy_ to clean the agent. 

Refresh “`https://&lt;vcenter_ip>/eam/mob`”  to ensure the agency has been successfully removed. This will remove vCenter from the invalid state. Use _HDM Reset_ to redeploy the product on-premises.


###### **Network configuration issues for cloud deployment **

If vCenter and the cloud ESXi are configured on different networks and resolved through different DNS settings, the cloud vCenter will be added if the correct DNS is set during _Add Cloud_. However, ESXi resolution will fail, resulting in the subsequent failures of cold and warm migrations. 

Similarly, _Add Cloud_ may fail if the cloud vCenter has been configured with FQDN, but the DNS used to resolve vCenter is incorrect or is not provided during the operation.

**Resolution:** Add rules in the network to forward the resolution of the specified vCenter or ESXi FQDNs to the correct DNS.


###### **I/O monitoring may not start due to a delay in creating an HDM SPBM policy**

After creating the HDM SPBM policy, the VM storage policies should list _praapa_ as a new caching component. However, the creation of a new VM storage policy, and its subsequent display in vCenter, may take time. As a result, _praapa_ may not be displayed under _Caching Component_ following the creation of the HDM SPBM Policy and I/O monitoring may not succeed for the VMs.

**Resolution**: In vCenter, select _Administration_, followed by _System Configuration_, _Services_, then _Restart VMware vSphere Profile-Driven Storage Service_. This will update the vCenter state and _praapa_ will be visible.


###### **SPBM policy creation failure during "Enable Monitoring"**

During _Enable Monitoring_ the HDM SPBM policy creation can fail.

**Workaround**: Manually create the SPBM policy with the name _HDM Analyzer Profile_. If the _praapa_ policy is not shown, delete and rescan the praapa storage provider by selecting _vCenter_, followed by _Configure_.


###### **HDM SPBM policy attach failure on disks with IDE controllers**

VMs with IDE controllers do not allow the HDM SPBM policy to be attached in the powered on state.

**Resolution**: Power the VMs off, then attach the policy. (Ref: **CP-4297)**


###### **Applying SPBM Policy in Enhanced Linked Mode vCenter may fail**

This problem is specific to an _Enhanced Linked_ setup. Consider configuring an Enhanced Linked setup using two vCenter servers, each containing ESXi hosts:

1. vcenterserver01.dopio.com 
2. vcenterserver02.dopio.com

Assume that HDM is installed using vCenter _vcenterserver01.dopio.com_. The HDM SPBM policy **HDM Analyzer Profile** will be visible in _vcenterserver02.dopio.com_, but the policy attributes will not available. Attempting to apply this policy from _vcenterserver02.dopio.com_ to any VM may fail. 

**Workaround** : Use the vCenter _vcenterserver01.dopio.com_ to apply an SPBM policy to any VM.


###### **Failure of the HDM SQS Message Bus configuration**

Configuration of the SQS message bus can fail if incorrect tokens or non-existent queues are provided during configuration. Ensure that the queues provided are already created in the Amazon SQS service. 


###### **Re-deployment on-premises can fail if the I/O filter ‘praapa’ has stopped or is in the process of restarting**

Re-deployment on-premises can fail during configuration of the HDM ESXi Manager. Services within the ESXi Manager must be configured to communicate with the I/O filter service within ESXi to service I/O requests. If the I/O filter service _praapa_ is stopped or is in the process of restarting within ESXi, configuration will fail. Check the I/O filter status on the ESXi _Configure_ page in vCenter and restart the service to retry the on-premises deployment. 


# HDM Migrations

###### **Not able to connect or validate Key Manager. Please verify settings**

This issue can occur when CA certificate details are provided for the key manager. Providing valid CA certificates for the key manager will resolve the issue. (Ref: **CP-5408**)


###### **Failed to generate migration request**

This issue can occur when the key manager details are not updated correctly. When editing the key manager, ensure that the operation is successful. If the operation fails, the key manager will be marked as unreachable. This will lead to the failure of try in cloud and warm migration. To ensure successful integration, be sure to use correct credentials and certificates to edit the key manager. Ensure that the key manager is reachable from the appliance at all times. (Ref: **CP-5444**)


###### **Prepare to migrate failed for VMs with UEFI BIOS**

HDM does not currently support UEFI BIOS. As a result, the prepare to migrate operation will fail for these VMs. Only use VMs with IBM PC BIOS for HDM migration.


###### **VMDK operations on the migrated VMs in cloud vCenter**

The Cloud vCenter enables a few VMDK operations such as add/grow disks on the migrated VMs. HDM does not support these operations on the migrated VMs. While the operation may succeed, these VMs can’t be migrated back or re-migrated to the cloud. (Ref: **CP-2595)**


###### **Cold migration may be retried, even after the user cancelled the vCenter task**

If the vCenter task for cold migration is cancelled by the user, the existing task gets cancelled. However, HDM will retry the cold migration until all retry attempts have been exhausted. To truly cancel the operation, cancel all retries. (Ref: **CP-4365)**


###### **Migration failure due to insufficient space on the target**

Prior to warm migration, HDM will check for free space on the target. However, because the actual storage required for thin disks can vary, the available space on the target cannot always be pre-validated. As a result, failure due to insufficient storage space during migration is still possible. To avoid this failure, ensure that the target has enough free space prior to attempting the migration. (Ref: **CP-4301)**


###### **Failed to do warm migration of a linked clone VM**

To warm migrate linked clones, attach the SPBM policy _HDM Analyzer Profile_ to the base VM of the linked clone.


###### **Warm migration fails due to the inaccessibility of the cloud vCenter or ESXi in an FQDN based cloud environment **

In an FQDN based deployment, HDM may not be able to resolve the cloud vCenter or ESXi, which can cause the warm migration to fail. During HDM installation, the DNS entry should have been configured to resolve the FQDN. If this is missing, manually add the DNS nameserver to the HDM cloud cache component, using the following procedure:

1. Login to the cloud vCenter.
2. Find the HDM cloud cache component VMs with the name _HDM-Cloud-Cache-*_.
3. ssh into each HDM cloud cache component VM with root credentials and use the password _admin123_.
4. Set the DNS server in /`etc/resolv.conf` to resolve the FQDN.
5. Use the ping command to ensure that the FQDN is reachable.

(Ref: **CP-4330**)


###### **Applications on migrated VMs may fail due to incorrect network mapping**

During the _add cloud_ operation, specify the correct default application network for the cloud, or map the on-premises network to the cloud network. If this is not done, the VM migration may succeed but applications on the migrated VMs may still fail. In an SQS based migration, network mapping can be specified during migration. (Ref: **CP-4433)**


###### **Enable Virtualized CPU Performance Counters Check flag not retained on cloud**

Certain VM parameters will not be retained post migration, so will need to be enabled manually. (Ref : **CP-2859**)


###### **VM is present in HDM_MIGRATE_POOL even after migrate back**

After migrating back, moving the VM to its original resource pool can sometimes fail in vCenter 6.7. If this happens, use vCenter to move the VM from the HDM_MIGRATE_POOL to its original resource pool. (Ref: **CP-4652**)


###### **vCenter does not show the option to migrate the VM**

After complete deployment, users may not find any action available to migrate VM in vCenter or it may just show ‘loading...’. 

**Resolution**: The solution will be do logout-login of vCenter and try again migrating, if it still not giving any option then please restart vsphere-ui (`service-control --stop vsphere-ui;service-control --start vsphere-ui;`)  service from the vcenter ssh console.


###### **Power off during migrate back is taking long time for some flavor of Linux guest VMs**

VMs that are migrated back are first powered off on the On-Cloud. For Ubuntu 16.04 and RHEL 7.4, this operation can take longer time. IO errors can also be seen in the guest VMs during this process. 

This is due to an issue in a specific version of linux kernel, where iSCSI connection is closed too early during the shutdown process. This causes ongoing IOs to not be able to go through and thus stalls the guest VM shutdown. HDM does multiple retries and finally hard power off such VMs during migration back. This is also discussed in public forum at::

[https://bugzilla.redhat.com/show_bug.cgi?id=1164756](https://bugzilla.redhat.com/show_bug.cgi?id=1164756)


###### **Migration request through SQS failed due to Appliance not having access to Internet**

The SQS initiated migration request can fail if the Appliance does not have access to the Internet. Users should ensure that Appliance has access to the Internet while using SQS for migration. 


###### **Virtual machine rename On-Cloud failed during warm migration**

During warm migration, virtual machines On-Cloud have postfix ‘ARM’ to identify virtual machines being managed by HDM. This postfix is later removed once the data has been transferred and changes have been synced to the On-Cloud virtual machine. The renaming of a virtual machine can fail if there is an existing virtual machine with the same name on On-Cloud.


###### **Completed Migration may sometimes not show correct status on Wizard **

This could happen if the Wizard continues to remain open while the operation is performed and gets completed. The status on WIzard sometimes may not get updated. For accurate status of the operation, refer to the VCenter tasks. (Ref : **CP-5622**) 


###### **Already completed Migration status for Virtual machine goes into an error state**

For each Virtual Machine migration a vCenter task is created. The progress and status of migration is then updated in the vCenter task object. The same status is also reflected on the Migration’s In-Progress tab on HDN vCenter Plugin for global and cluster view. In cases where the task has been completed, a vSphere server may delete the reference from the vSphere database. In this case, as the task object has been removed, the correct status of migration does not reflect on the UI and shows the migration state as ERROR. Users can check the task status under vCenter task list for the virtual machine to get the correct status.


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

Failures for migration/ migration back, on-premise deployment and add On-Cloud are shown in vCenter under Tasks and Events. Any failure seen due to the HDM component going down is also captured within vCenter events with the description starting with ‘<code><em>com.primaryio.hdm.'</em></code>. This is currently shown in HTML and Flash view of the vCenter. However the details for the failures are not always available in both the views, for example for vCenter version 6.5 it is available in the Adobe Flash view.  


###### **PIO Appliance not reflecting the failure status of HDM components**

If a HDM On-Cloud component VM remains shutdown for an extended period, the failed HDM components health may not get reflected in the PIO Appliance. 

However**, **the failed component will be detected and alerts can be seen in the Home -> HDM-> Dashboard. Once the component VM gets rebooted successfully, the PIO Appliance will correctly show the health of all components. (Ref: **CP-4647**)


# Failure Handling in HDM


###### **vCenter task failures with message “Request exceeded the limit set”**

HDM operations at times can fail with vCenter giving the error message “Request exceeded the limit set”.

**Resolution**: VAPI Endpoint Service may need a restart. To restart the service, you need to login to vCenter using Flash and go to Home -> Administration -> Deployment -> System Configuration -> Services. Right click on the VAPI Endpoint Service and choose Restart. (Ref: **DP-2700)**


###### **HDM is in a hung state or crawling**

This can happen sometimes when there is a failure that HDM is repairing, for example a component failure. The repair may be  in progress but it is not complete. Users might notice a hung system while HDM is still attempting, retrying for recovery.  It may happen both when HDM is deployed but there is no activity on the system or it may happen when there is migration activity on the system. 

Users can wait for sometime and give time for  the system repair to complete. If it looks that HDM recovery is stalled for some reason, it recommended that the user executes HDM reset and proceeds with the redeployment with a clean state. 


###### **HDM has active migrations going on but the migrations did not complete as expected**

A user starts a few migrations or the user might have ongoing migrations. All or some of the migrations might not complete due to a failure. The process of recovery in HDM would migrate back the affected VMs that were either already migrated or in the process of being migrated. The VMs would be found in the HDM Recovery Pool On-Premise. 


###### **All migrated VMs are automatically migrated back and present in RECOVERY_POOL_SUCCESS**

Migrated VMs can be migrated back, if any of the HDM component fails. As part of HDM recovery, the failed component is repaired and only the affected VMs are migrated back and brought to the RECOVERY_POOL_SUCCESS. However, HDM cloud cache is a critical component and its failure would affect all the migrated VMs and this  would  result in all VMs to be migrated back.(Ref: **DP-2739**)


###### **HDM Appliance got hung due to its datastore space full**

HDM Appliance can get hung if the datastore on which it was present has no space left.

Users should power off the HDM Appliance VM, create enough space in the datastore and power on the Appliance again. Please note that datastore full can cause other issues and the resolution here may not always work. User may need to do HDM reset or re-deploy HDM with appropriate storage.


###### **Additional NICs attached to the VMs that got migrated back due to network failure **

Due to network failure, the already migrated VMs can be migrated back by HDM. In some cases, such VMs can be found with additional NICs then the ones they were originally configured with. HDM adds these NICs during the migration operation and are usually cleaned up automatically. However, in some failure scenarios when automatic cleanup has failed, users have to perform manual cleanup of these NICs. (Ref: **CP-4841**) 


###### **How do network disconnects result in failures**

HDM is deployed both On-Premise and on the On-Cloud. VMs migrate from the On-Premise to the On-Cloud, there are occasions when VMs are migrated back to the On-Premise after a temporary migration to the On-Cloud (for example for the TBC use case) or because of a failure during the migration. The Network availability is critical during the entire Migration operation and for continuity of HDM component services. 

Thus the disruption in the network connectivity is tolerated for a limited time, typically upto 4-5 minutes  beyond which HDM gets into Failure and Recovery mode. Recovery operation will also succeed only when the Network is available. If the system gets into a state where HDM reset needs to be executed, it can succeed only when the network connectivity is available for cleaning up the state on the On-Cloud. 

HDM operations are designed for retries and resilience for somewhat jittery Networks. More than 4-5 minutes of continuous disconnect triggers failures and eventual process of recovery and repair if that network becomes available. 


# HDM Undeployment


###### **HDM On-Cloud **u**ninstall **f**ails when one of the ESXi hosts in the cluster on which it was installed is inaccessible**

Uninstallation happens at the cluster level and it will fail if any host in the cluster is unavailable.

**Resolution**: System administrators will have to first resolve the connection issue with the unreachable ESXi host and then retry the uninstallation process.


###### **HDM On-Premise uninstall fails when one of the ESXi hosts in the cluster on which it was installed is inaccessible**

Uninstallation happens at the cluster level and will fail if a VIB or HDM component removal cannot be done on any host in the cluster.

**Resolution:** System administrators will first have to resolve the connection issue with the unreachable ESXi host and retry the uninstallation process.


###### **‘praapa’ vib uninstall failure during undeployment**

During HDM undeployment the ‘praapa’ vib can fail to uninstall on some ESXi in the cluster.

**Resolution**: User should restart the iofilter daemon on ESXi (ssh login to the ESXi and run command /etc/init.d/iofilterd-prapaa restart) and then uninstall the product. (Ref: **DP-2578)**


###### **'HDM_DRS_*' tags still present in On-Cloud vCenter after uninstallation of HDM**

The tags are created to set affinity rules on HDM component hosts managed by HDM On-Cloud vCenter. These rules are only used by PrimaryIO HDM and do not affect the working of other virtual machines in On-Cloud vCenter. Currently these are not deleted as part of uninstallation of HDM.

**Resolution**: Follow these steps to clean HDM_DRS_* tags from On-Cloud vcenter.



1. Delete HDM tag
    *   Login to On-Cloud vCenter
    *   Go to Menu → Tags & Custom Attributes → TAGS
    *   Delete tag with name “HDM_DRS_TAG”
2. Delete HDM category
    *   Login to On-Cloud vCenter
    *   Go to Menu → Tags & Custom Attributes → CATEGORIES
    *   Delete category with name “HDM_DRS_CATEGORY“
3. Delete HDM DRS policy
    *   Login to On-Cloud vCenter
    *   Menu → Policies and Profiles → Compute Policies
    *   Delete policy with name “HDM_DRS_POLICY“


###### **Uninstall of HDM **f**ilter fails when a cluster host cannot be put in the Maintenance Mode**

HDM filter uninstall requires the cluster hosts to be put in the maintenance mode one host at a time. If for any reason, a host fails to go in the Maintenance mode, the HDM filter uninstall fails. 

**Resolution**: User should put the host in maintenance mode manually and retry the uninstall operation. This may require the user to perform a vMotion on the active VMs to another host in the cluster. If the cluster has just one host, the User may be required to power off the active VMs. Please note that the PIO Appliance host should not be powered off before initiating the uninstall.


###### **‘praapa’ service is still present on ESXi Configure tab in vCenter even after PrimaryIO HDM filter has been uninstalled from the On-Premise cluster**

Uninstall of HDM filter from PIO Appliance creates an uninstall task that executes successfully. However, the HDM icon on vCenter still shows the HDM version and the service  ‘praapa’ is also found on the ESXi host. 

**Resolution**: This issue is seen when the uninstall is attempted on a cluster where the ESXi hosts cannot be put into Maintenance Mode either due to DRS not configured or insufficient number of ESXi for vMotion. In such a situation the ‘uninstall’ request is registered but not executed. To complete the uninstallation, follow the steps:



1. The host under the cluster on which the HDM uninstall is pending, needs to be put into Maintenance Mode manually through the vCenter.
2. This will start the uninstallation task on the ESXi and will cleanly remove the ‘praapa’ IOFilter.
3. Exit the Maintenance Mode once the installation is complete.
4. Steps 1-3 may have to be repeated on all the ESXi hosts that could not be put into Maintenance Mode, to completely remove PrimaryIO HDM from the cluster.


###### **HDM plugin entry is not removed from the vCenter after HDM plugin is unregistered from the appliance.**

An entry for the HDM plugin continues to be displayed in the Administration->Client Plug-Ins listing or in the Menu even after it has been unregistered from the appliance.

This is a vCenter listing issue and does not affect the vCenter functionality.

**Issues**: The new plugin may not load properly if we register the same or lower plugin version but a higher plugin version will always work.

**Resolution**: Steps are:  



1. SSH to vCenter shell.
2. Following command will find and delete all stale entries for HDM and will restart vsphere-ui service.

        "`find / -name *piohyc* -exec rm -rf {} +;  service-control --stop vsphere-ui;service-control --start vsphere-ui;`"


###### **Disable monitoring failure during undeployment**

During uninstall disable monitoring on some VMs can fail in certain situations. 

**Resolution**: The workaround for this is to power-off the VMs and then disable monitoring. (Ref: **CP-4431)**


###### **Undeployment while migration is in progress**

Do not perform On-Cloud undeployment while migrations are in progress. The UI does not prevent this action. However, the undeployment can fail and the migrating VMs cleanup may not happen. 

(Ref: **CP-4373)** 


###### **Undeploy HDM On-Premise failure due to VMs having snapshots**

The HDM On-Premise uninstall can fail, if there are any VMs which have HDM created snapshot (named pio_*). Usually, this applies for VMs that were migrated back as part of failure recovery and are residing in HDM_RECOVERY_SUCCESS. 

**Resolution**: The migrate time snapshot (pio_*) should be explicitly deleted by the user before retrying the undeploy. (Ref: **CP-3749)**


###### **Detaching SPBM Policy fails when IO Filter service ‘praapa’ in the ESXi is stopped or restarted**

If IO Filter service ‘praapa’ is stopped or is restarting within an ESXi, detach SPBM policy on virtual machines can fail as the service is unavailable and policy state cannot be cleaned. Check service status under ESXi configure page and retry detach operation.


# HDM Reset


###### **HDM Reset did not remove all component VMs**

If there is a network disconnect between appliance and On-Cloud, HDM components On-Cloud  and migrated VMs will not get deleted. Even though the HDM reset task on vCenter shows as completed,  HDM components as well as migrated VMs might still be present on the On-Cloud leaving the system in an unclean state. 

**Resolution**: The resolution is to manually delete HDM components and migrated VMs for completing the process of clean up and get it to state for new deployment. 


###### **HDM Reset failure due to PIO Appliance restart issues**

As part of HDM reset, PIO Appliance VM restart is required. In some cases, this restart may not succeed or the PIO Appliance may not get IP. 

**Resolution**: This could be a transient error situation and the user should attempt restart of the PIO Appliance so that the HDM reset can complete successfully. (Ref: **CP-4610)**


###### **Cleanup issues due to ESXi host reboot during HDM Reset **

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
