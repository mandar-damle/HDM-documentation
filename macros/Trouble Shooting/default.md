---
title: Troubleshooting
---
NOTICE_FOR_MACRO_PREPROCESSOR

This section covers troubleshooting for known issues in HDM 2.2.1. In the event there are issues that are not covered in this document or are not easily resolved, contact PrimaryIO support for assistance. 

# HDM Deployment


###### **Failures during HDM deployment are not currently handled for recovery**

Failures during HDM deployment on-premises or in the cloud will require the state to be cleaned using HDM reset, then the deployment can be retried. In the current release, HDM does not attempt to automatically recover from deployment failures. (Ref: **CP-4686)**

###### **Deployment taking time or appears to be in a hung state**

During deployment, synchronization with the NTP server is required. This operation may take time. During this period, the deployment may seem stuck or taking longer than expected. No action is required. After this expected delay, the deployment will continue as usual. (Ref: **CP-4419)**


###### **Deployment failure with message “Please check the credentials for IP Address>**

This failure can occur either due to incorrect credentials or incorrect Cloud Director Organization name. Providing the correct credentials or organization name should resolve this issue. (Ref: **CP-5395**)

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

ifdef(~sTARGET_VCD~e, ~s
###### **Network configuration issues for on-cloud deployment **

In case, On-Cloud Cloud Director is configured on different networks and resolved through different DNS settings. In this case On-Cloud Cloud Director will get added if correct DNS is set during Add Cloud, but ESXi resolution will fail resulting in Cold and Warm migration Failure. 

Similarly, “Add Cloud” may fail if On-Cloud Cloud Director has been configured with FQDN and DNS to resolve vCenter is incorrect or is not provided during the operation.

**Resolution: ** Customers should add rules in their Network to forward resolution of these FQDN to the correct DNS, whether it is for the vCenter or ESXi.


###### **Installation Failed - Exception during container create syncd-cloud **

This can happen if the Cloud Director cloud end-point is not reachable. The current operation being performed (deployment, mugration) will fail. The connectivity to cloud end-point needs to be re-established before continuing. (Ref : **CP-5596**) 


~e)

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


ifdef(~sTARGET_VCD~e, ~s

###### **HDM Disk Controller Support**

Following are known limitations with virtual machine disk controller configurations for migration to VMware Cloud Director. HDM does not support migration of:



1. Virtual machines having IDE and NVMe based virtual disks.
2. Virtual machines with USB or ISO attached during migration.

###### **VM fails to poweron on Organization VDC after migration is successfully completed. **

This can happen is the CPU resources are exhausted for the Organization VDC into which the migration happened. Do update the CPU resources and try powering-on the VM. (Ref: **CP-5469**) 

###### **IPs may not be allocated for virtual machines having Ubuntu16 or SLEL16 Operating System post migration**
This is a known issue with these operating systems. IP addresses will need to be allocated manually. (Ref : **CP-5626**)


###### **Cold migration may be retried even after the user cancelled the vCenter task**

If the vCentre task for cold migration is cancelled by the user, the existing task gets cancelled. However, HDM re-attempts, the cold migration till all the retry attempts are over. The user should cancel all the re-attempts, so as to truly cancel the operation, (Ref: **CP-4365)**


###### **Migration failure due to insufficient space on the target**

Even though HDM checks free space on the target of a warm migration, the available space on target cannot always be pre-validated because actual storage required for thin disks can vary. This may lead to failure because of insufficient storage space during migration. 

User should explicitly make sure that the target has enough free space before attempting to migrate. 

(Ref: **CP-4301)**


~e)

###### **Applications on migrated VMs may fail due to incorrect network mapping specified**

During add cloud operation, users should specify the correct default application network on-cloud or map  on-premises network to on-cloud network. Failing to do so, the VM migration may succeed but applications on the migrated VMs may fail. In the SQS based migration, the network mapping can be specified at the migration time. (Ref: **CP-4433)**


###### **Enable Virtualized CPU Performance Counters Check flag not retained after migration to cloud**

Certain virtual machine parameters may not be retained post migration. These will need to be set manually. (Ref : **DP-2859**)

###### **Migration Wizard is not listing selected VM for migration**

If the VM being migrated has the substring "HDM" or "hdm" (case-insensity) in the name the VM will not be listed in the migration list. Example "test-hdm-vm", "video-hdmi" or  will not be 
migrated.

###### **vCenter does not show the option to migrate VM**

After complete deployment, users may not find any action available to migrate VM in vCenter or it may just show ‘loading...’. 

**Resolution**: The solution will be do logout-login of vCenter and try again migrating, if it still not giving any option then please restart vsphere-ui (`service-control --stop vsphere-ui;service-control --start vsphere-ui;`)  service from the vcenter ssh console.


###### **Already completed Migration status for Virtual machine goes into an error state**

For each Virtual Machine migration a vCenter task is created. The progress and status of migration is then updated in the vCenter task object. The same status is also reflected on the Migration’s In-Progress tab on HDM vCenter Plugin for global and cluster view. In cases where the task has been completed, a vSphere server may delete the reference from the vSphere database. In this case, as the task object has been removed, the correct status of migration does not reflect on the UI and shows the migration state as ERROR. Users can check the task status under vCenter task list for the virtual machine to get the correct status.


###### **IP conflict if HDM internal network configured with DHCP for Ubuntu and SLES**

In HDM on-cloud deployment, if the Internal network on the on-cloud is configured for DHCP IP addresses, IP addresses assigned to migrated VM (WARM or TBC) with DHCP can experience lease timeout. This is because on some versions of Linux distributions (mainly all Ubuntu and SLES distributions) DHCP lease is not renewed for the IBFT enabled NIC which is connected to the Internal network for TFTP/iSCSI booting. 

All the versions of Windows and RHEL/CentOS distributions are not affected by this issue.

If the Internal network on the on-cloud is configured for IP addresses with Static IP address pool, this issue will not arise.

Workaround:



*   If HDM on-cloud deployment is configured for DHCP IP addresses on the Internal network, configure DHCP IP address lease timeout to be greater than the time the migrated VM is supposed to stay booted on the on-cloud.
*   Configure the HDM on-cloud deployment to use IP addresses with Static IP address pool on the Internal network.

(Ref: **DP-2777**)

###### **Failed to generate migration request**

This issue can occur when the key manager details are not updated correctly. When editing the key manager, ensure that the operation is successful. If the operation fails, the key manager will be marked as unreachable. This will lead to the failure of try in cloud and warm migration. To ensure successful integration, be sure to use correct credentials and certificates to edit the key manager. Ensure that the key manager is reachable from the appliance at all times. (Ref: **CP-5444**)


###### **Prepare to migrate failed for VMs with UEFI BIOS**

HDM does not currently support UEFI BIOS. As a result, the prepare to migrate operation will fail for these VMs. Only use VMs with IBM PC BIOS for HDM migration.


###### **VMDK operations on the migrated VMs in cloud vCenter**

The Cloud vCenter enables a few VMDK operations such as add/grow disks on the migrated VMs. HDM does not support these operations on the migrated VMs. While the operation may succeed, these VMs can’t be migrated back or re-migrated to the cloud. (Ref: **CP-2595)**

###### **Warm migration fails for a linked clone VM**

To warm migrate linked clones, attach the SPBM policy _HDM Analyzer Profile_ to the base VM of the linked clone.


ifdef(~sTARGET_VCS~e, ~s

###### **Warm migration fails due to the inaccessibility of the cloud vCenter or ESXi in an FQDN based cloud environment **

In an FQDN based deployment, HDM may not be able to resolve the cloud vCenter or ESXi, which can cause the warm migration to fail. During HDM installation, the DNS entry should have been configured to resolve the FQDN. If this is missing, manually add the DNS nameserver to the HDM cloud cache component, using the following procedure:

1. Login to the cloud vCenter.
2. Find the HDM cloud cache component VMs with the name _HDM-Cloud-Cache-*_.
3. ssh into each HDM cloud cache component VM with root credentials and use the password _admin123_.
4. Set the DNS server in /`etc/resolv.conf` to resolve the FQDN.
5. Use the ping command to ensure that the FQDN is reachable.

(Ref: **CP-4330**)

~e)


###### **VM is present in HDM_MIGRATE_POOL even after migrate back**

After migrating back, moving the VM to its original resource pool can sometimes fail in vCenter 6.7. If this happens, use vCenter to move the VM from the HDM_MIGRATE_POOL to its original resource pool. (Ref: **CP-4652**)


###### **vCenter does not show the option to migrate the VM**

Once the deployment has completed, vCenter may not show an option to migrate the VM. Alternatively, it may just display _loading..._. 

**Resolution**: Logout and re-log into vCenter, then attempt the migration again. If the issue persists, restart the vsphere-ui (`service-control --stop vsphere-ui;service-control --start vsphere-ui;`) service from the vCenter ssh console.


###### **Some Linux guest VMs require an excessive amount of time to power off during migrate back**

VMs that are migrated back are first powered off in the cloud. For Ubuntu 16.04 and RHEL 7.4, this operation can require an extended period of time. I/O errors can also be seen in the guest VMs during this process. 

This is due to an issue in a specific version of the Linux kernel, where the iSCSI connection is closed too early during the shutdown process. This creates a backlog of ongoing I/Os, which stalls the shutdown of the guest VM. HDM will perform multiple retries and will ultimately hard power off these VMs during migration back. This issue is discussed further in a public forum:

[https://bugzilla.redhat.com/show_bug.cgi?id=1164756](https://bugzilla.redhat.com/show_bug.cgi?id=1164756)


###### **The migration request through SQS failed, because the appliance was not connected to the Internet**

Migration requests initiated through SQS can fail if the appliance lacks Internet access. Ensure that the appliance has Internet access while using SQS for migration. 


###### **Renaming the cloud VM failed during warm migration**

During warm migration, VMs in the cloud that are managed by HDM are identified by the postfix ‘ARM’. This postfix is later removed once the data has been transferred and changes have been synced to the cloud VM. The renaming of a VM can fail if an existing VM in the cloud has the same name.


###### **Completed migration status may not be correctly refelected in the wizard **

This may happen if the wizard is still open when the operation completes. Sometimes the status on the wIzard is not updated in a timely manner. For accurate status of the operation, refer to vCenter tasks. (Ref : **CP-5622**) 

# HDM System Health


###### **Details of failures associated with the HDM component are not visible in vCenter. **

Failures for migrate, migrate back, on-premises deployment, and add cloud are shown in vCenter under _Tasks and Events_. Any failure attributed to the HDM component going down will also be captured within vCenter events with a description that begins with <code><em>com.primaryio.hdm</em></code>. While the failures can be seen in the HTML and Flash views of vCenter, the details for the failures are not always available in both the views (e.g., it is only available in Flash view in vCenter version 6.5).  

###### **PrimaryIO appliance does not reflect the failure status of HDM components**

If an HDM cloud component VM remains shutdown for an extended period of time, the health of the failed HDM components may not be reflected in the PrimaryIO appliance. However, the failed component will be detected and alerts can be seen by selecting _Home_, followed by _HDM_, then _Dashboard_. Once the component VM is successfully rebooted, the appliance will correctly reflect the health of all components. (Ref: **CP-4647**)

# Failure Handling in HDM


###### **vCenter task failures with message “Request exceeded the limit set”**

Sometimes HDM operations fail and vCenter delivers the error message _Request exceeded the limit set_.

**Resolution**: The VAPI endpoint service may need to be restarted. To do this, log into vCenter using Flash and select _Home_, followed by _Administration_, _Deployment_, _System Configuration_, then _Services_. Right click on the VAPI endpoint service and select _Restart_. (Ref: **DP-2700)**


###### **HDM is in a hung state or crawling**

This can happen when HDM is in the process of repairing a failure, or while HDM is engaged in a recovery attempt. It can happen when HDM is deployed but there is no activity on the system, or when there is migration activity on the system. 

Wait for the system repair to finish. If it appears that HDM recovery has stalled, reset HDM and proceed with the redeployment with a clean state. 


###### **HDM has active migrations, but they fail to complete as expected**

If a failure causes migrations to not complete, the HDM recovery process will migrate back the affected VMs that were previously migrated, or are in the process of migrating. These VMs can be found in the on-premises HDM recovery pool. 


###### **All migrated VMs are automatically migrated back and present in RECOVERY_POOL_SUCCESS**

In the event of an HDM component failure, migrated VMs can be migrated back. As part of HDM recovery, the failed component will be repaired and only the affected VMs will be migrated back and appear in _RECOVERY_POOL_SUCCESS_. However, HDM cloud cache is a critical component and its failure would affect all migrated VMs. As a result, all VMs will be migrated back. (Ref: **DP-2739**)


###### **HDM Appliance hangs, becuase its datastore is full**

The HDM appliance can get hung if the datastore where it resides runs out of space. If this occurs, power off the HDM appliance VM, create enough space in the datastore, thne power the appliance back on. Please note that a full datastore can cause other issues and this resolution may not always work. In this case, an HDM reset may be necessary, or HDM can be re-deployed with adequate storage.


###### **Additional NICs attached to the VMs that were migrated back due to a network failure**

In the event of a network failure, HDM can migrate back previously migrated VMs. In some cases, these VMs can be found with additional NICs beyond what they were originally configured with. HDM adds these NICs during the migration operation and typically cleans them up automatically. However, in some failure scenarios when automatic cleanup has failed, these NICs will need to be manually cleaned up. (Ref: **CP-4841**) 


###### **How network disconnects result in failures**

Sometimes VMs are migrated back to the on-premises environment following a temporary migration to the cloud (e.g., the TBC use case), or because of a failure during the migration. Network availability is critical during the entire migration operation, as well as for the continuity of HDM component services. The disruption in network connectivity is tolerated for a limited time (typically up to 4-5 minutes), after which HDM will enter into failure and recovery mode. A recovery operation can only succeed when the network is available. If an HDM reset is required, it can only succeed when network connectivity is available for cleaning up state in the cloud. 

HDM operations are designed for retries and resilience for somewhat jittery networks. However, if connectivity is lost for more than 4-5 minutes continuously, failures will be triggered. Then, when the network becomes available, the process of recovery and repair will be initiated. 


# HDM Undeployment


###### **HDM cloud uninstall fails when one of the ESXi hosts in the cluster where it was installed becomes inaccessible**

Because uninstallation happens at the cluster level, it will fail if any host in the cluster becomes unavailable.

**Resolution**: Resolve the connection issue with the unreachable ESXi host, then retry the uninstallation process.


###### **The on-premises HDM uninstall fails when one of the ESXi hosts in the cluster where it was installed becomes inaccessible**

Uninstallation happens at the cluster level, so it will fail if a VIB or HDM component removal cannot be performed on any host in the cluster.

**Resolution:** Resolve the connectivity issue with the unreachable ESXi host, then retry the uninstallation process.


###### **‘praapa’ VIB uninstall failure during undeployment**

During HDM undeployment, the ‘praapa’ VIB can fail to uninstall on some ESXi instnaces in the cluster.

**Resolution**: Restart the iofilter daemon on ESXi (ssh log into the ESXi and run the command _/etc/init.d/iofilterd-prapaa restart_), then uninstall HDM. (Ref: **DP-2578)**


###### **HDM_DRS_* tags still present in the cloud vCenter following HDM uninstallation**

The tags are created to set affinity rules on HDM component hosts managed by the cloud HDM vCenter. These rules are only used by PrimaryIO HDM and do not affect other VMs in the cloud vCenter. Currently, these are not deleted as part of the HDM uninstallation process.

**Resolution**: Follow these steps to clean HDM_DRS_* tags from the cloud vcenter:

1. Delete the HDM tag:
    *   Log into the cloud vCenter.
    *   Select _Menu_, followed by _Tags & Custom Attributes_, then _Tags_
    *   Delete the tag _HDM_DRS_TAG_.
2. Delete teh HDM category:
    *   Log into the cloud vCenter.
    *   Select _Menu_, followed by _Tags & Custom Attributes_, then _Categories_.
    *   Delete the category _HDM_DRS_CATEGORY_.
3. Delete the HDM DRS policy:
    *   Log into the cloud vCenter.
    *   Select _Menu_, followed by _Policies and Profiles_, then _Compute Policies_.
    *   Delete the policy _HDM_DRS_POLICY_.


###### **Uninstallation of the HDM filter fails when a cluster host cannot be placed into maintenance mode**

Uninstallation of the HDM filter requires the cluster hosts to be in maintenance mode, one host at a time. If a host fails to enter maintenance mode for any reason, the HDM filter uninstall will fail. 

**Resolution**: Manually put the host into maintenance mode and retry the uninstall operation. This may require a vMotion on the active VMs to another host in the cluster. If the cluster only has one host, the active VMs may be required to be powered off. Please note that the PrimaryIO appliance host should not be powered off prior to initiating the uninstall.


###### **The praapa service is still present on the ESXi Configure tab in vCenter, even after the HDM filter has been uninstalled from the on-premises cluster**

A task to uninstall the HDM filter from the appliance executes successfully, but the HDM icon on vCenter still shows the HDM version, and the ‘praapa’ service remains on the ESXi host. 

**Resolution**: This issue is seen when the uninstall is attempted on a cluster where the ESXi hosts cannot be put into maintenance mode, either because DRS has not been configured or there is an insufficient number of ESXi instances for vMotion. This causes the uninstall request to be registered, but not executed. Follow these steps to complete the uninstallation:

1. Log into vCenter and manually put the host under the cluster where the HDM uninstall is pending into maintenance mode.
2. This will start the uninstallation task on ESXi and will cleanly remove the ‘praapa’ iofilter.
3. Exit maintenance mode once the installation is complete.
4. to completely remove HDM from the cluster, steps 1-3 may have to be repeated on all ESXi hosts that could not be put into maintenance mode.


###### **HDM plugin entry is not removed from vCenter after the HDM plugin is unregistered from the appliance.**

An entry for the HDM plugin continues to be displayed in the _Administration / Client Plug-Ins_ listing, or in the _Menu_, even after it has been unregistered from the appliance.

This is a vCenter listing issue and does not affect vCenter functionality.

**Issues**: The new plugin may not load properly if the same or a lower version of the plugin is registered. However, a higher version of the plugin will always work.

**Resolution**: Complete the following steps:

1. ssh into the vCenter shell.
2. Enter the following command to find and delete all stale entries for HDM and restart the vsphere-ui service:

_       `find / -name *piohyc* -exec rm -rf {} +;  service-control --stop vsphere-ui;service-control --start vsphere-ui;`_

###### **Disable monitoring failure during undeployment**

During uninstall, _disable monitoring_ on some VMs can fail in certain situations. 

**Resolution**: The workaround for this is to power the VMs off, then disable monitoring. (Ref: **CP-4431)**


###### **Undeployment while migration is in progress**

Do not perform cloud undeployment while migrations are in progress. While the UI does not prevent this action, the undeployment can fail and cleanup of the migrating VMs may not happen. (Ref: **CP-4373)** 


###### **Undeploy on-premises HDM failure due to VMs having snapshots**

The HDM on-premises uninstall can fail if there are any VMs that have snapshots that were created by HDM (named pio_*). This usually applies to VMs that were migrated back as part of failure recovery, and reside in HDM_RECOVERY_SUCCESS. 

**Resolution**: The migrate time snapshot (pio_*) should be explicitly deleted prior to retrying the undeploy. (Ref: **CP-3749)**


###### **Detaching the SPBM policy fails when the I/O filter service ‘praapa’ in ESXi is stopped or restarted**

If the I/O filter service ‘praapa’ is stopped or is restarting within an ESXi, detaching the SPBM policy on the VMs can fail, because the service is unavailable and policy state cannot be cleaned. Check service status on the ESXi configure page and retry the detach operation.


# HDM Reset


###### **HDM Reset did not remove all component VMs**

If there is a network disconnect between the appliance and the cloud, HDM cloud components and migrated VMs will not be deleted. Even if the HDM reset task on vCenter lists the operation as completed, HDM components and migrated VMs may still reside in the cloud, leaving the system in an unclean state. 

**Resolution**: Manually delete the HDM components and migrated VMs to complete the cleanup process and make it ready for a new deployment. 


###### **HDM reset failure due to appliance restart issues**

As part of the HDM reset, the PrimaryIO appliance must be restarted. In some cases, this restart may not succeed, or the appliance may not be assigned an IP address. 

**Resolution**: This is probably a transient error, so restart the appliance to enable the HDM reset to successfully complete. (Ref: **CP-4610)**


###### **Cleanup issues due to an ESXi host reboot during HDM Reset **

During HDM reset, if any of the ESXi hosts in the on-premises cluster are rebooted, the cleanup for that host may not happen. While the HDM reset may still succeed, any future attempts for an on-premises deployment may fail. 

**Resolution**: Retry the HDM reset, then attempt to redeploy. (Ref: **CP-4648)**


###### **HDM reset did not start, even after rebooting the appliance**

After rebooting the appliance, the HDM reset task remains queued, even after the appliance has been rebooted. This may happen if there have been transient issues while configuring network adapters within the appliance, following the reboot.

**Resolution:** Reboot the appliance again. (Ref: **CP-4836**)


###### **HDM reset and other operations fail after rebooting the appliance following an ESXi failure**

With non DRS or HA enabled clusters, when the appliance fails on an ESXi, the vApp option properties are reset on the VM.

**Resolution:** Perform the following steps:

*   Power the appliance off.
*   Select _Configure_, followed by _vApp_, then _Edit_. In the OVF setting, reset the VMware tool checkbox, then select _Save_.
*   Select _Configure_, followed by _vApp_, then _Edit_. In the OVF setting, set the VMware tool checkbox, then select _Save_.
*   Power the appliance on.

(Ref: **CP-4848**)

