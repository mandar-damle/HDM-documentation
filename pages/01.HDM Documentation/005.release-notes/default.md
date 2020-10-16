---
title: 'HDM 2.1 Release Notes'
media_order: ''
body_classes: ''
order_by: ''
order_manual: ''
---
<!-- Copy and paste the converted output. -->


The HDM 2.1 release has been qualified for production use for the _Cold Migration Use case_ in the Ultra Lite-Standalone and Ultra Lite-Cluster configurations. 

What is new in HDM 2.1 Release ?



*   Provides support for Cold Migration to VMware Cloud Director
*   Highly efficient, proprietary, data transport for cold migration

Recoverable failure conditions



*   Component failures are detected and repaired within 5 minutes.
    *   Heartbeat will indicate the failed components and unavailability of the system.
*   WAN disconnects less than 2 minutes will be recovered
*   Behaviour on failure recovery
    *   Running cold migration jobs will either succeed or fail with the appropriate response on UI.
    *   Will accept future migration requests.

Cleanup required on failure conditions



*   Jobs that were running at the time of failure might leave stale files on the datastore which need to be cleaned. The files can be found on the datastore with [VM Name]/ folder.
*   Failed jobs can be retried. New jobs will be accepted and executed.

Non-Recoverable failure conditions and recovery actions



*   HDM may not recover from WAN disconnects greater than 2 minutes. An HDM reset (Please refer Admin Guide, HDM Reset section) will be required to recover from this condition.
*   In pathological failure cases where we cannot recover and the heartbeat status does not recover to “Ready”. In these cases “HDM reset” followed by a redeployment will be required.
*   Concurrent Infrastructure VM restarts and repeated Infrastructure VM restarts can get into unrecoverable states and require an “HDM reset” 

## Known Issues

Do not delete the component VMs or the content library deployed as part of the HDM product deployment. Doing so will result in the incorrect operation of the product and a “HDM reset” followed by a redeployment will be required.

**The following issues are related to Cold Migration to VMware Cloud Director**

CP-5262: During the deployment adding a VMware Cloud Director (VCD) target can take upto 5 mins. This is due the time taken by VCD APIs to return information regarding the target environment. 

**The following issues are related to Migration to VMware Cloud**


**CP-5612**: VMC does not always honour the disable DRS settings on the components VMs deployed on cloud. This can result in the resources like Cloud_Cache getting seperated from the migrated VMs running of the cloud. This is generally not a cause for concern but can result in the VM becoming unresponsive if the ESXi host were to fail. The system will correctly rollback the VM to premise and start it from the last RTO/RPO checkpoint.

DP-2738:  Occasionally in case of failure of the “On Prem I/O Manager” we are not able to recover from this failure and the component is marked as failed permanently in the Control panel in the appliance UI.To recover from this condition you need to do a “HDM reset” followed by a redeployment.

CP-3036: Tag inheritance fails for cloned virtual machines in case the API calls to On-Premise vCenter fails. To fix the issue, add tag manually to cloned virtual machines. (DCPN - 00055094)

CP-4217: PIO Manager service within PIO appliance gets restarted due to which functionalities like enable and disable monitoring can get affected along with screens not being rendered on vCenter HDM plugin UI. The service is usually up in seconds and the user should retry functionality or refresh screens.

CP-4867: In case of non DRS or HA enabled clusters, when an ESXi on which PIO Appliance fails the vApp option properties set on the virtual machine gets reset. This is a VMware behaviour and can be seen even when virtual machines are migrated across vCenter. In such a condition when PIO Appliance is finally rebooted, services will not get deployed and all operations will fail.

CP-4906: In flex mode of migration, post migration not all IPs of linux virtual machines would be accessible in case HDM_ON_CLOUD_NETWORK and virtual machines application network are the same. To fix this run the following command within the migrated linux virtual machine:


```
        for f in $(find /proc/sys/net -name rp_filter); do
        echo 0 > $f
        done
```


CP-4917: Application dependency feature is not supported for Cold Migration. Each virtual machine migrated using cold migration use-case will be migrated separately.

CP-5035 : When a VM on migration, TBC, WARM or COLD, is configured for DHCP to Static IP address conversion, the VM upon boot on the On-Cloud will still be configured with DHCP IP address it was configured previously, in addition to its new Static IP address. This is observed for all the distributions of Linux. The OS’s old DHCP lease files are not deleted as part of DHCP to Static IP address conversion, hence once the VM comes up online on the On-Cloud, OS “network startup” scripts brings back the old DHCP IP address, if the DHCP server from the lease files in reachable, in addition to its new Static IP address. There is no workaround for this issue. The DHCP configured IP address will not disturb the newly configured Static IP address.

CP-5076: In TBC or WARM migration use cases, virtual machines migrated back will have the same IP address that was set to be configured On-Cloud post migration. To resolve the issue, users would have to reconfigure the virtual machine's network.

CP-5104: Re-installation of HDM is not supported if the license enforced migration limit is reached even though the license has not expired.

CP-5107: On HDM_Cloud_Cache reboot, cache service does not come up. In this case the user will have to perform HDM Reset to recover migrated virtual machines and clean HDM deployment.

CP-5112: COLD or WARM migrated VM, once configured with static IP address as part of data sync process, will get IP address collision on power on if the original VM On-Premise is kept powered on simultaneously after the migration. Due to this IP address collision, the migrated VM will not be able to bring up the newly configured static IP address. This is mainly observed in SLES distribution of Linux where IP address collision will be detected as part of the “network startup” scripts, and IP address will not come up online. Although, in the network, if two VMs, be it any distribution of Linux or Windows, are having the same IP address assigned, only one VM will be reachable through that IP address. Keep either the migrated VM or the original VM On-Premise in the power on state, at any point in time.

**Inconsistent data in HDM plugin UI:**

CP-5003: In Migration pop-up, for cold migration data transferred and compression ratio are shown as zero even though both are happening in the background and progress can be seen in the HDM migration task.

CP-5064: Historical IO analysis data is shown for powered-off virtual machines. The viewed timelines are not consistent with the historical timelines.

CP-5119: HDM supports 2 ARM sync in parallel per HDM cloud cache. If more requests for ARM sync is submitted, user would see the following error message on ARM sync popup:

"Error: PM-523: Failed to post data for sync. Please try again after sometime. {'msg': 'Failed to submit Sync operation for VM.', 'status': -1, 'vm_uuid': '192.168.5.228_vm-1040', 'resp': &lt;Response [429]>}"
