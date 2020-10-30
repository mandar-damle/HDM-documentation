---
title: 'Performing Migrations'
---

# HDM Migrations

HDM is used to migrate VMs from on-premises to cloud environments. HDM supports the following migration types:

1. Agile Rapid Migration (ARM)
2. Try Before Commit (TBC)
3. Cold Migration

## Migrate a VM using vCenter 

**Note:** The migration operation can be performed using the PrimaryIO GUI interface in vCenter, or through the SQS interface library. The following sections describe the steps for executing the migration operation using vCenter. 

**Note**: Currently, HDM migration support is limited to one simultaneous cluster per vCenter. If the VMs to be migrated are from multiple clusters, the process will need to be repeated for each of them.

Pre-requisites

1. HDM deployment must be complete in the on-premises and cloud environments.
2. The HDM SPBM policy must be configured. 

Steps

1. Prepare the VM to migrate
2. Migrate the VM


### Prepare to Migrate

The VMs to be migrated will first need to be prepared:

1. Perform various checks to ensure that the VM's OS type and configuration are supported for migration.
2. If required, make the necessary configuration updates.

Pre-requisites

1. The VM must be powered on.
2. The VM's OS type must be supported for migration.
3. The latest version of VMware tools must be installed on the VM, and the tools service must be running and functional.
4. Administrator/root credentials of the VM must be available.
5. The OS must be present on the first VMDK of the VM
6. All OS related partitions must be present on the same disk/device. For example:
    *   The 'System Reserved' and 'System' partitions must be on the same disk
    *   /boot or /home must be present on the same disk
    *   LVM must be created from partitions on the same disk
7. The E1000E and VMXNet3 network adapters must be available in the on-premises and cloud vCenters
8. The VM must have access to the Internet.
9. A minimum of 50 MB must be available in the system partition
10. The OS or repository must configured to download the required install packages from the Internet.
11. For Ubuntu 16.04, LVM is not supported.
12. For all versions of Ubuntu, ensure that either the static IP is configured for internal network, or the DHCP lease is set to 30 days or greater.
13. If the OS is Linux, the sudo user’s home directory must be <code><em>/home</em></code>.
14. Wait for the boot process to complete. For example, on Linux:
    *   Use command <code>systemctl is-system-running </code>to ensure the system is fully operational
15. The VM cannot have UEFI BIOS. Only IBM PC BIOS is supported.
16. For a Windows VM, firewalls must be disabled for the duration of the _prepare to migrate_ operation.
17. For the Windows Domain user, the local security policy must be modified for the duration of the _prepare to migrate_ operation:
    *   Select _Local Security Policy_, followed by _Local Policies_, then _Security Options_
    *   On the policy <code>User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode, </code>choose the <code>Elevate without prompting </code>option
    *   Disable the policy _User Account Control: Turn on Admin Approval Mode_
    *   Reboot the VM


Steps

1. In the on-premises vCenter, right click on the VM to be migrated.
2. Select the **HDM -> Prepare to Migrate** option

![alt_text](images/image30.png?classes=content-img "image_tooltip")

3. Specify the administrator/root user credentials in the pop-up wizard 

![alt_text](images/image33.png?classes=content-img "image_tooltip")


**Note:  A full clone or linked clone of a VM must go through the “prepare to migrate” operation, even if its base VM has already has. For example, in the HDM migrate wizard in vCenter, clones are not shown in the list of available VMs for migration unless they have been explicitly prepared for migration.**


### Apply SPBM Policy

The migrate operation requires the VM to have the HDM SPBM policy applied to its disks. This may have already been attached when the _Enable I/O Monitoring_ was performed (see the Enable I/O Monitoring section for more details). But in cases where either the attempt to attach the VM policy failed at that time, or the VM was created at a later point in time, the following steps can be taken to verify - and, if required, apply - SPBM policy:

Pre-requisites

1. Enable I/O Monitoring has already been executed.


Steps

1. In the on-premises vCenter, right click on the VM to be migrated.
2. Select _VM Policies_, followed by _Edit VM Storage Policies_

![alt_text](images/image32.png?classes=content-img "image_tooltip")

3. In the popup window, there is no need to do anything if the VM storage policy has already been set to the HDM Analyzer Profile. However, if it is set to **Datastore Default**, change it to _HDM Analyzer Profile_ and select _Apply to all_.

![alt_text](images/image35.png?classes=content-img "image_tooltip")

### Migrate the VM

Pre-requisites

1. _Prepare to Migrate_ has been successful on the VM
2. The HDM SPBM policy has been applied to all disks within the VM


Steps

1. In the on-premises vCenter, right click on the VM to be migrated.
2. Select the **HDM -> Migrate** option

![alt_text](images/image34.png?classes=content-img "image_tooltip")

3. The Migrate wizard will open. Select the migration type to be used to migrate the VM to the cloud.

![alt_text](images/image37.png?classes=content-img "image_tooltip")

4. On the **Select Cloud** page, review the cloud where the VM is to be migrated and ensure that adequate resources are available

![alt_text](images/image36.png?classes=content-img "image_tooltip")

5. Choose the list of VMs to migrate:
    *   Keep the option “Application Dependency” checked. 
    *   Review the cache size, CPU, and memory required in the cloud

![alt_text](images/image40.png?classes=content-img "image_tooltip")

6. If the Warm and Cold Migration type has been chosen, select the target resources on the cloud where the virtual machine will be migrated

![alt_text](images/image38.png?classes=content-img "image_tooltip")

7. If the Warm and Cold Migration type has been selected, map the network for the VM

![alt_text](images/image39.png?classes=content-img "image_tooltip")

8. Confirm all selections and select _MIGRATE_

![alt_text](images/image41.png?classes=content-img "image_tooltip")

9. The migration status page will display the status of the migration as it progresses.

![alt_text](images/image42.png?classes=content-img "image_tooltip")

10. The migration status can also be tracked in vCenter tasks.

![alt_text](images/image43.png?classes=content-img "image_tooltip")

11. The migrated VM can be seen in a new resource pool _HDM_MIGRATE_POOL_ in the on-premises vCenter in a powered off state, while the same VM will be in a powered on state in the cloud vCenter.

![alt_text](images/image44.png?classes=content-img "image_tooltip")

12. All migrations can be monitored by selected _Cluster_, followed by _Monitor_, _HDM_, _Migration_, then the _In Progress_ tab.

![alt_text](images/image28.png?classes=content-img "image_tooltip")

13.  For virtual machines that have been migrated using Warm Migration, the following steps are required to complete the migration workflow:
    *   START TRANSFER : This is an optional step where the virtual machine data can be transferred using **HDM Bulktransfer**. Select the virtual machine, then select **Start Transfer **.

![alt_text](images/image-start-transfer.png?classes=content-img "image_tooltip")

![alt_text](images/image45.png?classes=content-img "image_tooltip")

    *   CONFIGURE & SYNC : Once the virtual machine data has been moved to the cloud, select the newly-moved virtual machine to sync the latest changes.

![alt_text](images/image46.png?classes=content-img "image_tooltip")

    *   COMMIT :  Once the data has been synced, commit all changes to the migrated virtual machine on the cloud and clean up the HDM configuration.

![alt_text](images/image47.png?classes=content-img "image_tooltip")

14. VMs that have been migrated to the cloud will be shown in _Cluster_, followed by _Monitor_, _HDM_, _Migration_, then _Summary_ 

![alt_text](images/image11.png?classes=content-img "image_tooltip")



### Migrate Time Snapshot

As part of the VM migration, HDM creates a “migrate time snapshot”  for the VM. This snapshot is useful to restore data in the event of certain failures.

**Note**: Restoring the VM from the migrate time snapshot will result in loss of data for the time the VM was in the Cloud.

To view the snapshot:

1. In the on-premises vCenter, right click on the VM in the resource pool _HDM_MIGRATE_POOL_
2. Select _Snapshots_, followed by _Manage Snapshots_

The Manage Snapshots popup should display a snapshot named _hdm_xx_. For example, _hdm_1_ shown below:

![alt_text](images/image21.png?classes=content-img "image_tooltip")



### Cache Size For Migrated VMs

HDM allocates a cache quota in the cloud for all migrated VMs to ensure optimal performance of the applications running in the cloud. The cache size allocation follows these rules:

*   If the on-premises VM has been monitored for I/Os for a sufficient amount of time, the working set is derived by the I/O analysis and the cache size is based on the working set size. Note that this is only valid for _Standard_ and _Performance_ modes of deployment.
*   If the VM is not monitored, the cache size is based on the size of the VMDKs:
    *   15% for _Standard_ and _Performance_ modes of deployment
    *   25% for the _Lite_ mode of deployment 
*   There is also a minimum cache size per deployment mode:
    *   5 GB for _Lite_ and _Performance_ modes of deployment
    *   3 GB for the _Standard_ mode of deployment


## Migrate a VM using the SQS Interface 

HDM migration for the ARM use case is supported through the SQS interface. The prerequisites for using the SQS interface for migration are:

1. The HDM appliance must have access to Internet.
2. The SQS queues for command and response must be created in the Amazon SQS service.
3. The HDM appliance should be configured for the SQS message bus with the correct message bus token

Some important command messages exchanged between the client and HDM are:

1. **Heartbeat**: This message is from HDM to the client, to communicatethe state of HDM. Clients usually look for a ‘Ready’ state before sending the next migration request to HDM. 
2. **SourceInventoryRequest**: This message provides the list of on-premises VMs and their details. Clients select what to migrate from this list.
3. **SourceCloneRequest**: This is essentially the migration request to HDM. It has parameters to specify the migration type and associated details.
4. **BulkMigrationDoneRequest**: This message is important for migrations initiated using the offline bulk transfer option, because it tells HDM whether or not the offline bulk transfer is complete. 

Details for how these are used for warm and cold migration are provided below.


### Cold Migration

Follow these steps to perform a cold migration using the SQS interface:

1. Wait until system status is ‘Ready’. This is indicated by the heartbeat between HDM and the SQS client. 
2. Send a ‘SourceInventoryRequest’ message to get the list of VMs that can be migrated using HDM.
3. Choose a VM from the list in the response message.
4. Set the mode of migration to ‘cold’.
5. Submit a request for migration using ‘SourceCloneRequest’.
6. After submission, periodic responses will be sent with the status of the submitted request.

Cold migration of a VM will entail the following steps:

1. A bulk transfer of the VM will be initiated.
    1. Progress and updates will be sent via message bus responses.
    2. vCenter Tasks will show the progress of the export and import of ovf on the source and target vCenters, respectively.
    3. This operation may get queued, depending on the resource profile, the number of migrations in progress, and total number of VMs migrated. A maximum of eight migrations can run concurrently. 
2. Necessary network changes will be performed on the migrated VM.

If the bulk transfer fails, it will be automatically retried a few times. The failure will be reported in the response message on the final failure only. In the vCenter, however, the retries and their statuses can also be seen.


### Warm Migration

Pre-requisites

1. The HDM deployment mode cannot be ‘Appliance Only’. Any other mode is acceptable.
2. The VM must be in a powered-on state and must have the latest VMware tools installed.


Steps

1. Wait until system status is ‘Ready’. This is indicated by the heartbeat between HDM and the SQS client. 
2. Send a ‘SourceInventoryRequest’ to get the list of VMs that can be migrated using HDM.
3. Choose a VM from the list returned in the response message.
4. Set the mode of migration to ‘warm’ and the bulk transfer mode to 'online' or 'offline'.
5. The root user credentials of the VM for the “prepare to migrate” step will be required.
6. Submit the request for migration using ‘SourceCloneRequest’.
7. After submission, periodic responses will be sent with the status of the submitted request.

Warm migration of a VM will entail the following steps:

1. Prepare to migrate the VM.
2. Apply the HDM SPBM policy to the VM.
3. Take a snapshot of the VM and create a linked clone on it.
4. Migrate the compute VM, where the cloud cache is created and the data path to the on-premises environment is also maintained.
5. Bulk transfer the previously created VM snapshot to the cloud
6. Reconcile the new data in the cloud cache with the VM image transferred to the cloud
7. Power off the running VM and reboot from the reconciled VM image. 

If any of the above steps fail, HDM will retry the step before declaring that the entire migration has failed.


## Migrate Back a VM

**Note**: The flow described here is useful for the TBC use case. 


Prerequisites

1. The VM must be in a migrated state. It should be listed in _HDM_MIGRATE_POOL_ in the on-premises vCenter.


Steps

1. In the on-premises vCenter, right click on the VM to be migrated back. Select _HDM_, followed by _Migrate Back_.

![alt_text](images/image30.png?classes=content-img "image_tooltip")

2. Select the VMs to be migrated back. The dependent VMs will be migrated back together.

![alt_text](images/image23.png?classes=content-img "image_tooltip")

3. Review the selection and select _MIGRATE BACK_.

![alt_text](images/image24.png?classes=content-img "image_tooltip")

4. The status of the migration back can be seen in the wizard.

![alt_text](images/image25.png?classes=content-img "image_tooltip")

5. The migrate back task can also be tracked in vCenter.

![alt_text](images/image26.png?classes=content-img "image_tooltip")

6. Once the migration back is successful, the VM will be deleted from the cloud vCenter. It will then be moved from the _HDM_MIGRATE_POOL_ to the original resource pool where it resided prior to the migration. At this point, the VM will have to be explicitly powered on.


# HDM Monitoring

HDM monitors the VMs in a cluster for I/O and resource usage activity. The following data will be provided:

*   Active data set identification for VMs
*   Recommendation of what VMs to migrate
*   Cache size required on the cloud to meet the VM’s workload requirements
*   CPU resource utilization of the VMs
*   I/O performance statistics for the VMs
*   Network and cache usage statistics for the migrated VMs

**Note**: In Lite mode (Standalone and Cluster), the monitoring of VMs is limited to applying the HDM SPBM policy. The detailed monitoring of VMs is only present in the Standard and Performance modes. 


## Monitoring VMs On-Premise

HDM monitors the I/O activity on all on-premises VMs on the cluster where it is installed. To view monitored data for these VMs:

1. In the on-premises vCenter, select the cluster
2. On the right-hand panel, select _Monitor_, followed by _HDM_, then _Profiling_

![alt_text](images/image27.png?classes=content-img "image_tooltip")

**Note**: In Lite mode (both standalone and cluster), this view is not present. Instead, the following message will be displayed:

![alt_text](images/image10.png?classes=content-img "image_tooltip")

3. You should see the doughnuts for:
    1. Storage monitored: The amount of storage monitored within vCenter. Monitoring is only active on the selected cluster within vCenter.
    2. Active dataset: The size of the active dataset, compared with the total. I/O activity is recorded periodically.
    3. Active VM storage health: The health of the storage is determined by its latency and throughput.
    4. Top storage utilized VMs: The VMs that access the storage most frequently.
4. A table summarizing the activity of the VMs is presented below the doughnuts. Some columns of particular importance are:
    5. Storage: The storage capacity of the VMs.
    6. Cache size: The estimated size of the VM's working set. If the VM is migrated to the cloud, this represents the minimum amount of cache that needs to be provisioned to maintain optimal performance.
    7. Read IOPs: The observed rate of reads happening on the VM.
    8. Write IOPs: The observed rate of writes happening on the VM.
    9. Health : The health of the VM storage, based on the observed read/write IOPs.


## Monitoring VMs in the Cloud


### Migration Status

HDM keeps track of the number of VMs migrated and migrated back, as well as their statuses and other essential information. This data is accessible through the following steps:

1. In the on-premises vCenter, select the cluster
2. On the right hand panel, select _Monitor_, followed by _HDM_, _Migration_, then _In Progress_

![alt_text](images/image28.png?classes=content-img "image_tooltip")



### I/O And Resource Usage

The VMs that have been migrated to the cloud are also monitored for resource utilization and I/O activity. To view monitored data for these VMs:

1. In the on-premises vCenter, select the cluster
2. On the right hand panel, select _Monitor_, followed by _HDM_, then _Monitoring_

![alt_text](images/image9.png?classes=content-img "image_tooltip")

**Note**: In Lite mode (both Standalone and Cluster), this view is not present. Instead, the following message will be displayed:

![alt_text](images/image10.png?classes=content-img "image_tooltip")

3. You can view graphs for:
    1. Utilization for compute, memory, and cache resources
    2. Read and write data transferred over the WAN
4. Detailed statistics for each migrated VM is displayed in tabular form


### Dashboard

A summary of the migration statistics and cloud resource utilization can be found in a single dashboard. To view this dashboard data:

1. In the on-premises vCenter, select the cluster.
2. On the right hand panel, select _Monitor_, followed by _HDM_, _Cloud Burst_, then _Dashboard_.

![alt_text](images/image11.png?classes=content-img "image_tooltip")

4. A detailed log of the migrate and migrate back activities are also displayed in tabular form.


# HDM Policies


## Recovery Time Objective/Recovery Point Objective (RTO/RPO)

HDM maintains an optimal cache in the cloud for migrated VMs to provide superior I/O performance. The cache maintains the working set of VM to serve read requests without having to traverse the WAN for every I/O. The cache also absorbs writes, which are flushed to the on-premises environment at regular intervals.

The frequency of the write flush is based on the Recovery Time Objective/Recovery Point Objective (RTO/RPO) requirements. By default it is set to flush to the on-premises environment every 20 minutes. Therefore, in the event of a failure, the application can only lose up to 20 minutes worth of data.


### Guidelines to Configure RTO/RPO policies

Configuring RTO/RPO should be based on the application need. The trade-offs are:

1. If the time is reduced, the write data flush will be triggered more often. This can cause additional WAN traffic, especially for applications that perform frequent overwrites.
2. If the time is increased, the write data flush will be triggered less frequently. In the event of a failure that results in VMs having to migrate back to the on-premises environment, more data will reside on the VMs since the last RTO/RPO flush, which can result in higher data loss. 

The setting is maintained at the cluster level, so it will be inherited by all VMs within the cluster. 

**Note**: **RTO/RPO is set to the default value of 20 minutes, which is acceptable for most applications. Care should be taken prior to reconfiguring it, keeping in mind the recovery trade-offs for the application.**


### Steps to Configure

To configure the RTO/RPO policy:

1. In the on-premises vCenter, select the cluster
2. On the right hand panel, select _Configure_, followed by _HDM_, then _Administration_
3. Modify the default value of the Recovery Time Objective (RTO) according to the needs of the application

![alt_text](images/image12.png?classes=content-img "image_tooltip")



# HDM System Health

HDM uses periodic messages (heartbeat) to monitor the health of its components and determine the overall health of the system. If the heartbeat from a component is missed for two minutes, the component will be marked as failed. Additional probes will be conducted to understand the nature of the failure. Once the reason for the failure is understood, the recovery process will be initiated.


## HDM in a Healthy State 

When there are no failures, all HDM components will show the state as ‘Healthy’ and their color will be seen as blue in the appliance control panel. The overall state of the HDM is good if nothing is colored red or yellow. This can be seen in the appliance’s control panel, or on the HDM plugin within vCenter. To view this data, select _Menu_, followed by _HDM_, _Administration_, _HDM Health_, then _Component Health_.

![alt_text](images/image19.png?classes=content-img "image_tooltip")

In the event of a failure, the affected components will be shown here.

![alt_text](images/image4.png?classes=content-img "image_tooltip")

![alt_text](images/image13.png?classes=content-img "image_tooltip")


## HDM in a Degraded State

When the system is in a degraded state due to a failure, it can be seen in the following locations:

1. The vCenter dashboard
2. The appliance control panel
3. The vCenter event log
4. The state in the SQS heartbeat


### vCenter Dashboard

*   Select _vCenter HDM_, followed by _Dashboard_ to view a notification mentioning **Services not ready or down...**

![alt_text](images/image14.png?classes=content-img "image_tooltip")


### Appliance Control Panel

In the event of a failure, some components may be affected. The state of those components will be listed in the appliance control panel as **Poor** and the overall state of HDM will be set to _Not Ready_. The component color will change from blue to red. 

![alt_text](images/image15.png?classes=content-img "image_tooltip")

*   Simply hover over the faulted component to view details regarding the error.

![alt_text](images/image16.png?classes=content-img "image_tooltip")


### vCenter Event Log

If failure events impact HDM operations, they will be recorded in the vCenter events log, as well as the HDM events logs. The HDM events logs can be accessed by selecting _Menu_, followed by _HDM_, _Administration_, then _Event Logs_.  

![alt_text](images/image8.png?classes=content-img "image_tooltip")

The screenshot below illustrates the types of failure and repair events that will appear in the events logs. These include component failure events and their successful recovery. The failure listed at the top of the log is an unrecoverable failure that will require an HDM reset.

![alt_text](images/image20.png?classes=content-img "image_tooltip")

These failure messages can also be seen in the vCenter events log, which can be accessed by selecting _vCenter_, followed by _Monitor_, then _Events_:

![alt_text](images/image17.png?classes=content-img "image_tooltip")

*   To narrow down the events generated by HDM, apply a filter on the event type ID. On the extreme right column, apply the filter _“com.hdm”_

![alt_text](images/image18.png?classes=content-img "image_tooltip")

*   After applying the filter, the view will be limited to the event generated by HDM. The selected event illustrated below corresponds to a failure of an HDM service:

![alt_text](images/image1.png?classes=content-img "image_tooltip")


### Health State in the SQS Heartbeat

The changes in system health are also reported through the SQS heartbeats. The typical SQS heartbeat messages (which can be retrieved from the sqs-python client) correspond to the various events listed below.

*   A fully deployed system that is functional and is free of failed components will have a heartbeat similar to the one listed below:

    ```
'status': 'Ready', 
'status_details': 'All the components are deployed and up.', 
'appliance_id': 'fa142afc-3c64-4086-b442-4ffcdc1580b2', 
```

*   When a component failure is detected, it will have a heartbeat containing details of the failed component, similar to the one below:

    ```
'status': 'Not Ready', 
'status_details': 'Services not ready or down On Prem IO Manager, On Prem 
                   Message Gateway'
'appliance_id': 'fa142afc-3c64-4086-b442-4ffcdc1580b2', 
```

*   When a reboot of a component VM host is detected, the heartbeat will display the details of the failed VM host, like the one illustrated below:

    ```
'status': 'Not Ready',
'status_details': "HDM infrastructure VM rebooted or faulted 
                   ['HDM_OnPrem_ESXi_Manager-0']", 
'appliance_id': 'fa142afc-3c64-4086-b442-4ffcdc1580b2', 
```

# Failure Handling in HDM 

HDM strives to meet the following requirements for handling failures:

*   Cold VM migration will be resumed automatically after repair in case of specific HDM component failures.
*   In the event of a specific HDM component failure during cold VM migration, the migration will be automatically resumed following repair.
*   In the event of pathological scenarios where migration can’t be resumed after a failure and subsequent recovery, VM availability will be ensured. 
*   HDM system state will be recovered to enable new migrations to be served, even if ongoing migrations had to be cancelled and migrated VMs were migrated back. 


## Ensuring VM Availability 

As part of failure recovery, HDM will resume the transfers of VMs that were in the process of being cold migrated. Under pathological conditions, or in the event of warm migration, HDM may identify that some VMs that were already migrated or some ongoing migrations can no longer continue to run in the cloud. This is typically due to a component failure that was used by the VM to connect to the on-premises environment. To ensure application availability, these VMs will be migrated back to the on-premises environment. 


## Data Consistency and Data Loss

VMs being cold migrated can never experience data loss. Conversely, VMs utilizing “Try Before Commit” that are migrated back as part of failure recovery do not get the opportunity to synchronize the on-premises environment with the latest cloud data. Since the on-premises environment is synchronized using an RTO/RPO interval, these VMs will hold data since the last RTO/RPO flush. 

Since the RTO/RPO flushes occur through point-in-time snapshots of the cloud data, this data is expected to be crash consistent. Modern applications and file systems are designed to withstand crashes. Therefore, they should be able to use this data on-premises.

In an extreme case, if the OS or the application is incapable of utilizing the data, the data can be restored from the migrate time snapshot, with the caveat that it causes the loss of all data that was written while the VM was in the cloud.


## HDM Failure Recovery


### Nature of Failures

While there can be a wide range of failures, HDM mainly deals with the following:

*   HDM Component Failures:
    *   Appliance restart
    *   HDM component VM restart
    *   HDM individual component failure due to software issues 
*   Network failures
    *   Transient network disconnect
    *   Permanent network disconnect
*   System failures
    *   Storage failures
    *   Memory errors


### Single Component Failure

The impact of the failure can result in the failure of a single HDM component, which HDM is designed to recover from automatically. The following scenarios are possible:

#### Failure When There is No Activity

Even when the system is idle following a successful deployment, a component failure may cause it to go from “Healthy” to “Degraded”. The HDM system health will be in the degraded state. It can be viewed in vCenter, as well as the appliance (See the _System Health_ section for details).

*   vCenter Events will list a new event for a component failure

HDM will attempt to recover from the failure and bring the system back to a “Healthy” state. There are three important stages of the recovery process:

*   Failure detection and moving to degraded state
*   HDM system repair
*   Healthy state

<p id="gdcalert46" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline drawings not supported directly from Docs. You may want to copy the inline drawing to a standalone drawing and export by reference. See <a href="https://github.com/evbacher/gd2md-html/wiki/Google-Drawings-by-reference">Google Drawings by reference</a> for details. The img URL below is a placeholder. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert47">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![drawing](https://docs.google.com/drawings/d/12345/export/png?classes=content-img)

Following recovery, the following message is logged into vCenter Events:

<p id="gdcalert47" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image46.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert48">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image46.png?classes=content-img?classes=content-img "image_tooltip")


#### Failure during Migrations

If a failure occurs during the migration operation, HDM will enter a degraded state. HDM will repair itself and will return to a healthy state. The ongoing migration operation may fail and those VMs can be migrated back as part of this recovery. The recovery process will look like this:

<p id="gdcalert48" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline drawings not supported directly from Docs. You may want to copy the inline drawing to a standalone drawing and export by reference. See <a href="https://github.com/evbacher/gd2md-html/wiki/Google-Drawings-by-reference">Google Drawings by reference</a> for details. The img URL below is a placeholder. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert49">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![drawing](https://docs.google.com/drawings/d/12345/export/png?classes=content-img)

For redundant components like HDM message gateway, recovery is complete only when the required level of redundancy is restored. If a migration operation is attempted before the recovery is complete, it will fail.


#### Failure when there are Migrated VMs

Some VMs already migrated to the cloud may be affected by a component failure. This will result in those VMs getting migrated back from the cloud to the on-premises environment. The VMs will hold data since the last RTO/RPO flush. 

The recovery process will look like this:

<p id="gdcalert49" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline drawings not supported directly from Docs. You may want to copy the inline drawing to a standalone drawing and export by reference. See <a href="https://github.com/evbacher/gd2md-html/wiki/Google-Drawings-by-reference">Google Drawings by reference</a> for details. The img URL below is a placeholder. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert50">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![drawing](https://docs.google.com/drawings/d/12345/export/png?classes=content-img)

**Note: **
1. As part of the failure recovery, if the migrated back VMs can be booted successfully, they will appear in the _HDM_RECOVERY_SUCCESS_ pool. Otherwise, they will be placed in the _HDM_RECOVERY_FAILED_ pool. 
2. There are cases where HDM is not able to perform the auto repair of its failed components. This could be due to either a software issue, or the error condition is permanent (e.g., permanent network or storage disconnect). In these cases, an HDM reset can be issued to recover fro the error and restart the entire process. See the _Troubleshooting_ section for more details.


#### Recovery Resource Pools

VMs migrated back as part of failure recovery are kept in recovery resource pools. There are two types:


##### **HDM_RECOVERY_SUCCESS **

This resource pool hosts the VMs that have been migrated back as part of failure handling, and are likely to be successfully booted in the on-premises vCenter. They may have some data loss equivalent to the last RTO/RPO flush cycle (default 20 minutes).

<p id="gdcalert50" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image47.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert51">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image47.png?classes=content-img "image_tooltip")


##### **HDM_RECOVERY_FAILED **

This resource pool hosts the VMs that have been migrated back as part of failure handling, but are unlikely to have consistent data. These VMs will be required to restore their data from the migration time snapshot.

**Note: **Restoring data from the migrate time snapshot will cause the loss of all data written while the VM was in the cloud.


##### **Recovering VMs from the HDM Recovery Pools**

The following steps should be followed to recover VMs from recovery resource pools:

1. Power on the VM and verify the sanity of the data. 
2. If the power on and data sanity checks pass:
    1. delete the HDM migration time snapshot.
    2. Move the VM to the resource pool where it originally resided prior to the migration.
3. If the power on or the data sanity failed:
    3. Restore the data from the migrate time snapshot.
    4. Delete the HDM migrate time snapshot.
    5. Move the VM to the resource pool where it originally resided prior to the migration.
    6. Power on the VM 

**Note: **Failure to move the VMs to their original resource pool will cause their subsequent migration and migration back to only occur from the HDM recovery pool. 


### Multiple Component Failure

If a second component fails while the system is recovering from the failure of a single component, HDM will detect the failure send a notification through vCenter events. This will also be the case if multiple HDM component hosts restart simultaneously. HDM components may not fully recover and migrated VMs may not migrate back. 

Multiple component failures may require an HDM reset to restore the system.


### HDM Appliance Restart

Restarting the appliance does not impact migrated VMs, nor does it impact future migration operations. Operations in progress during the appliance restart will be affected as follows:

1. ARM cold migration of a VM: The ongoing bulk transfer will fail and the operation will be retried from the beginning.
2. VM migration to the cloud will resume after restart and complete successfully
3. ARM warm migration:
    *   If the appliance reboot occurs while migrating the compute VM, the migration and the bulk transfer will both fail.
    *   If the appliance reboot occurs after the successful migration of the compute VM, only the bulk transfer will be retried.
4. VMs running in the cloud will continue to run. Some operations such as RTO/RPO periodic flush will resume after the reboot completes.
5. SQS heartbeats will be missing throughout the duration of the reboot, which should last approximately two minutes.
6. vCenter plugin will display a message throughout the duration of the reboot, that it cannot connect with the appliance.


### HDM Component VM Restart

An HDM deployment consists of a set of microservices running as containers in a VM that are deployed on-premises, as well as in the cloud. Depending on the deployment type, some or all of the following VMs will be included:

*   HDM_Cloud_Manager
*   HDM_Cloud_Cache
*   HDM_OnPrem_Manager
*   HDM_OnPrem_ESXi_Manager

Rebooting any of these VMs triggers the following repair actions:

1. All affected VMs are migrated back to the last RTO/RPO state.
2. A vCenter event is logged, communicating that a “Docker reboot” has occurred on the identified VM.
3. All components within that VM are repaired.
4. All future operations involving the repaired components should work correctly.


### WAN Network Disconnect

The WAN network disconnect may result in HDM components losing network connectivity with the central heartbeat monitoring entity. 


#### Transient Network Failure

HDM can recover from short network outages (those lasting less than 5 minutes) by retrying ongoing operations.


#### Permanent Network Failure

If the network outage lasts for an extended period of time (greater than 5 minutes), the HDM recovery may not succeed and an HDM reset may be required.


### ESXii Host Restart

If an on-premises ESXi host is restarted or the PRAAPA iofilter daemon service is restarted, the ongoing migrations will fail, VMs already migrated to the cloud will be migrated back, and new VM migrations will fail. An HDM reset and re-deployment of HDM on-premises and cloud components will be required prior to retrying the migration operation.


### System Failures

Failures such as storage or memory may result in some HDM component failures, or their impact could be limited to few operations or I/Os. If I/Os or some operations fail, they will be retried.


#### Boot Failure During Migrate

A guest VM boot may fail if VMware tools are not available early enough to detect the successful boot. HDM will retry (or, in this case, reboot) the operation a few times. 

**Note**: Multiple retries can delay the boot. In this case, wait 30 minutes for the migration operation to complete.


#### Bulk Transfer Failure During ARM Migration

If the bulk transfer fails during cold migration, the operation will be retried a few times. Errors such as transient network issues can be dealt with this mechanism.

**Note:** All retries will be attempted a fixed number of times. Once the number of retries has been exhausted, the operation will be marked as _failed_.

If a VM snapshot has been bulk transferred to the cloud and a failure occurs while the cloud cache syncs with it, the portion that has already transferred to the cloud must be explicitly deleted. HDM failure handling does not automatically delete the bulk transferred VM.


### Unresolved Issues

**Refer to the Troubleshooting Guide if failure issues are not resolved. The failure might have been caused by a known product issue. **

**PrimaryIO support may be required. Refer to the Install Guide for the details. **
