---
title: 'Release Notes'
---

The HDM 2.1.3 release has been qualified for production use for the _Cold Migration Use case_ in the Ultra Lite-Standalone and Ultra Lite-Cluster configurations for migration to VMware Cloud Director. 

For migrations to VMware Cloud Services or VMware Cloud Foundation HDM 2.1.3 release has been qualified for production use for the _Cold Migration, TBC and Warm Migration Use case_ in the Lite-Standalone,  Lite-Cluster, Standard-Standalone and Standard-Cluster configurations. 

What is new in HDM 2.1.3 Release?

*   Provides support for Cold Migration to VMware Cloud Director
*   Highly efficient, proprietary, data transport for cold migration


Recoverable failure conditions

*   Component failures are detected and repaired within 5 minutes
    *   Heartbeat will indicate the failed components and unavailability of the system
*   WAN disconnects lasting less than 2 minutes will be recovered
*   Behavior on failure recovery
    *   Running cold migration jobs will either succeed or fail with the appropriate response in the UI
    *   Will accept future migration requests

Cleanup required on failure conditions

*   Jobs that were running at the time of failure might leave stale files on the datastore which need to be cleaned. The files can be found on the datastore with [VM Name]/ folder.
*   Failed jobs can be retried. New jobs will be accepted and executed.

Non-Recoverable failure conditions and recovery actions



*   HDM may not recover from WAN disconnects greater than 2 minutes. An HDM reset will be required to recover from this condition (please refer to the [HDM Reset](../hdm%20reset) section of the Admin Guide).
*   In pathological failure cases where we cannot recover and the heartbeat status does not recover to “Ready”. In these cases “[HDM Reset](../hdm%20reset)”, followed by a redeployment, will be required.
*   Concurrent Infrastructure VM restarts and repeated Infrastructure VM restarts can get into unrecoverable states and require an “[HDM Reset](../hdm%20reset)” 

## Known Issues

Do not delete the component VMs or the content library deployed as part of the HDM product deployment. Doing so will result in the product to operate incorrectly, and will require an “[HDM Reset](../hdm%20reset)” followed by a redeployment.

**The following issues are related to Cold Migration to VMware Cloud Director**

CP-5262: During deployment, adding a VMware Cloud Director (VCD) target can take up to 5 minutes. This is due the time required by VCD APIs to return information regarding the target environment. 

**The following issues are related to the migration to VMware Cloud**


**CP-5612**: VMC does not always honor the "Disable DRS" settings on the component VMs deployed in the cloud. This can result in resources such as Cloud_Cache becoming seperated from the migrated VMs running in the cloud. This is generally not a cause for concern, but can result in the VM becoming unresponsive if the ESXi host were to fail. The system will correctly roll back the VM to on-premises and start it from the last RTO/RPO checkpoint.

DP-2738:  In the event the “On Prem I/O Manager” fails, recovery is impossible and the component will be marked as permanently failed in the control panel of the appliance UI. To recover from this condition, an “[HDM Reset](../hdm%20reset)”, followed by a redeployment, will be required.

CP-3036: In the event the API calls to the on-premises vCenter fails, tag inheritance for cloned virtual machines will also fail. To correct the issue, manually add the tag to the cloned virtual machines. (DCPN - 00055094)

CP-4217: When the PrimaryIO Manager service within the PrimaryIO appliance gets restarted, functionality such as "Enable/Disable Monitoring" and the rendering of screens on the vCenter HDM plugin UI can be adversely affected. The service is usually back up in a few seconds, so the user should retry the functionality or refresh their screen.

CP-4867: When an ESXi on the PrimaryIO Appliance fails in non DRS- or HA-enabled clusters, the vApp option properties on the virtual machine are reset. This is a normal VMware behavior that can even be seen when virtual machines are migrated across vCenter. When the PrimaryIO Appliance is rebooted, services will not be deployed, causing all operations to fail.

CP-4906: During flex mode of migration, if HDM_ON_CLOUD_NETWORK and the virtual machine application network are the same, not all Linux virtual machine IPs will be accessible post migration. To fix this, run the following command within the migrated Linux virtual machine:


```
        for f in $(find /proc/sys/net -name rp_filter); do
        echo 0 > $f
        done
```


CP-4917: Application dependency feature is not supported for Cold Migration. Each virtual machine migrated using cold migration will be migrated separately.

CP-5035 : Whether TBC, warm, or cold migration is employed, upon booting in the cloud, any VM configured for DHCP to Static IP address conversion will retain its previously-configured DHCP IP address, in addition to its new Static IP address. This is true for all Linux distributions. The OS’s old DHCP lease files are not deleted as part of DHCP to Static IP address conversion. Therefore, once the VM becomes available in the cloud, OS “network startup” scripts renew the old DHCP IP address, in addition to adding the new Static IP address. There is no workaround for this issue. The DHCP IP address will not disturb the newly-configured Static IP address.

CP-5076: In TBC and warm migration use cases, virtual machines migrated back will retain the post-migration cloud IP address. To resolve this issue, the virtual machine's network will need to be reconfigured.

CP-5104: Even in cases where the license has not yet expired, re-installation of HDM is not supported if the license-enforced migration limit has been reached.

CP-5107: On HDM_Cloud_Cache reboot, the cache service does not come up. An [HDM Reset](../hdm%20reset) will be required to recover migrated virtual machines and clean the HDM deployment.

CP-5112: If the on-premises VM remains powered on following a cold or warm migration, any virtual machine configured to sync data via a static IP address will cause an IP address collision upon power-on. As a result, the migrated VM will be unable to employ the newly-configured static IP address. This is mainly seen in the SLES Linux distribution where IP address collisions are detected as part of the “network startup” scripts, and IP addresses fail to come online. However, regardless of the specific Linux or Windows distribution, any time two VMs are assigned the same IP address, only one will be reachable through that IP address. To avoid this issue, only keep one VM (either the migrated or the original on-premises) powered on at any given time.

**Inconsistent data in HDM plugin UI:**

CP-5003: In the migration pop-up, the amount of data transferred and the compression ratio are shown as zero, even though both are running in the background and progress can be seen in the HDM migration task.

CP-5064: Historical IO analysis data is shown for powered-off virtual machines. The viewed timelines are not consistent with the historical timelines.

CP-5119: HDM supports two ARM parallel syncs per HDM cloud cache. If more ARM sync requests are submitted, the following error message will appear in the ARM sync pop-up:
```
"Error: PM-523: Failed to post data for sync. Please try again after sometime. 
{'msg': 'Failed to submit Sync operation for VM.', 'status': -1, 
  'vm_uuid': 	'192.168.5.228_vm-1040', 'resp': &lt;Response [429]>}"
```
