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
4. Set the mode of migration to ‘cold’
5. Submit a request for migration using ‘SourceCloneRequest’.
6. After submission, periodic responses will be sent with the status of the submitted request.

Cold migration of a VM will entail the following steps:

1. A bulk transfer of the VM will be initiated.
    1. Progress and updates will be sent via message bus responses
    2. vCenter Tasks will show the progress of the export and import of ovf on the source and target vCenters, respectively.
    3. This operation may get queued, depending on the resource profile, the number of migrations in progress, and total number of VMs migrated. A maximum of eight migrations can run concurrently. 
2. Necessary network changes will be performed on the migrated VM.

If the bulk transfer fails, it will be automatically retried a few times. The failure will be reported in the response message on the final failure only. In the vCenter, however, the retries and their statuses can also be seen.


### Warm Migration

Pre-requisites



1. HDM deployment mode should be anything other than ‘Appliance Only’.
2. VM must be in a powered-on state and must have the latest vmware tools installed.

Steps



1. Wait until system status is ‘Ready’. This is indicated by the heartbeat between HDM and SQS client. 
2. Send a ‘SourceInventoryRequest’ to get the list of VMs that can be migrated using HDM.
3. Choose a VM from the list of VMs returned in the response message.
4. Set the mode of migration to ‘warm’ and bulk transfer mode to online or offline.
5. Additionally the root user credentials of the VM for the “prepare to migrate” step would be required.
6. Submit request for migration using ‘SourceCloneRequest’.
7. After submission periodic responses will be sent with the status of the submitted request.

Warm migration of a VM will go through the following steps



1. Prepare to migrate the VM
2. Apply HDM SPBM policy to the VM
3. Take snapshot of the VM and create a linked clone on it
4. Do compute migrate the VM where the cloud cache is created and data path to On-Premise is also maintained
5. Bulk transfer the previously created a snapshot of the VM to the On-Cloud
6. Reconcile the new data in the cloud cache with the VM image transferred to On-Cloud
7. Power off the running VM and reboot from the reconciled VM image. 

In case of failure of any of the above steps, HDM would retry the step, before declaring the entire migration as failed.


## Migrate Back a VM

**Note**: The flow described here is useful for the TBC use case. 

Pre-requisites



1. The VM must be in a migrated state. It should be present in HDM_MIGRATE_POOL in On-Premise vCenter.

Steps



1. In the On-Premise vCenter, right click on the VM that is to be migrated back. Click on the HDM -> Migrate Back option.


![alt_text](images/image30.png?classes=content-img "image_tooltip")




2. Select the VMs that are to be migrated back. The dependent VMs will be migrated back together.


![alt_text](images/image23.png?classes=content-img "image_tooltip")




3. Review the selection and click on MIGRATE BACK.



![alt_text](images/image24.png?classes=content-img "image_tooltip")




4. You can view the status of the migrate back in the wizard



![alt_text](images/image25.png?classes=content-img "image_tooltip")




5. Also, the migrate back task in vCenter can be tracked


![alt_text](images/image26.png?classes=content-img "image_tooltip")




6. Once the migration back is successful, the VM is deleted from the On-Cloud vCenter. It has now moved from the HDM_MIGRATE_POOL to the original resource pool where it belonged before migration. Users should power on the VM explicitly.


# HDM Monitoring

HDM monitors the VMs in a cluster for the IO and resource usage activity. The monitoring gives the following data:



*   Active data set identification for VMs
*   Recommendation of what VMs to migrate
*   Cache size required on On-Cloud to meet the VM’s workload requirements
*   CPU resource utilization of the VMs
*   IO performance statistics for VMs
*   Network and cache usage statistics for migrated VMs

**Note**: In Lite mode of deployment(both standalone and cluster), the monitoring of VMs is limited to just applying the HDM SPBM policy. The detailed monitoring of VMs is present only in Standard and Performance mode of deployment. 


## Monitoring VMs On-Premise

HDM monitors the IO activity on all VMs on On-Premise on the cluster in which it is installed.

To view monitored data for such VMs



1. In the On-Premise vCenter, select the cluster
2. On the right hand panel, go to Monitor -> HDM -> Profiling



![alt_text](images/image27.png?classes=content-img "image_tooltip")


**Note**: In Lite mode of deployment(both standalone and cluster), this view is not present. Instead the following message should be there


![alt_text](images/image10.png?classes=content-img "image_tooltip")




3. You should see the doughnuts for
    1. Storage monitored : the amount of storage monitored within the vCenter. Monitoring is done only for the selected cluster within the vCenter.
    2. Active dataset : the active dataset size out of the total. IO activity is recorded periodically. The data set recently touched forms the active data set.
    3. Active VM storage health : the health of the storage is determined by the latency and throughput of the storage.
    4. Top storage utilized VMs : the VMs that are accessing the storage most often fall in this category.
4. A table summarizing the VM’s activity is also present below the doughnuts. Few important columns are
    5. Storage : The storage capacity of the VMs
    6. Cache size : The estimated working set size of the VM. If the VM is migrated to the On-Cloud, we should provision at least this much of cache to have optimal performance.
    7. Read IOPs : The observed rate of reads happening on the VM.
    8. Write IOPs : The observed rate of writes happening on the VM.
    9. Health : The health of the storage of VM based on the observed read/write IOPs.


## Monitoring VMs On-Cloud


### Migration Status

HDM keeps track of the number of VMs migrated and migrated back, their status etc. 

Such data is accessible through the steps



1. In the On-Premise vCenter, select the cluster
2. On the right hand panel, go to Monitor -> HDM -> Migration -> In Progress


![alt_text](images/image28.png?classes=content-img "image_tooltip")



### IO And Resource Usage

The VMs which have been migrated to the On-Cloud are also monitored for resource utilization and IO activity. To view monitored data for such VMs



1. In the On-Premise vCenter, select the cluster
2. On the right hand panel, go to Monitor -> HDM -> Monitoring

![alt_text](images/image9.png?classes=content-img "image_tooltip")



**Note**: In Lite mode of deployment(both standalone and cluster), this view is not present. Instead the following message will be displayed


![alt_text](images/image10.png?classes=content-img "image_tooltip")




3. You can view graphs for
    1. utilization for compute, memory and cache resources
    2. read and write data transferred over WAN
4. Detailed statistics for each migrated VM is available in tabular form


### Dashboard

A summarized information of the migration statistics and On-Cloud resource utilization can be found in a single dashboard. 

To view the dashboard data for such VMs



1. In the On-Premise vCenter, select the cluster
2. On the right hand panel, go to Monitor -> HDM -> Cloud Burst -> Dashboard
3. The migration summary gives the migration statistics and resource usage


![alt_text](images/image11.png?classes=content-img "image_tooltip")




4. Detailed log of migrate and migrate back is also present in tabular form


# HDM Policies


## RTO/RPO

HDM maintains an optimal cache on the On-Cloud for migrated VMs to provide good IO performance. The cache maintains the working set of the VM thus serving reads without having to go over WAN for every IO. The cache also absorbs writes, which are flushed on to On-Premise at regular intervals.

The periodicity of the write flush can be controlled by the user based on the RTO/RPO requirements.  It is currently set as 20 minutes as default, which means at 20 minutes interval data is flushed on to the on On-Premise. In case of failure, the application can lose 20 minutes worth of data.


### Guidelines to Configure RTO/RPO policies

Configuring RTO/RPO (Recovery Time Objective/Recovery Point Objective) should be based on the application need. Tradeoffs are



1. If the time is reduced, the write data flush would be triggered more often and it can cause additional WAN traffic, especially for applications that do frequent overwrites.
2. If the time is increased, the write data flush would be triggered less aggressively. If there are failures that result into VMs migrated back to On-Premise, the VMs would have data till last RTO/RPO flush, which can result in higher data loss. 

Currently the setting is done at the cluster level, which means all the VMs within the cluster will inherit the same setting. 

**Note**: **RTO/RPO is set to the default value of 20 minutes, which is good enough for most applications. It should be reconfigured carefully keeping in mind the recovery tradeoffs for the application.**


### Steps to Configure

Following are the steps to configure RTO/RPO policy



1. In the On-Premise vCenter, select the cluster
2. On the right hand panel, go to Configure-> HDM -> Administration
3. Modify the default value of Recovery Time Objective (RTO) according to application needs



![alt_text](images/image12.png?classes=content-img "image_tooltip")


	


# HDM System Health

HDM keeps track of its constituent component’s health. It uses periodic messages (heartbeat) to keep track of the health of its components and thus determines the overall health of the system. If the heartbeat from a component is missed for two minutes, then the component is marked as failed. Additional probes are made to understand the nature of failure. Once the failure reason is understood, the recovery process is initiated.


## HDM in a Healthy State 

When there are no failures, all the HDM components show the state as ‘Healthy’ and its color can be seen as blue in the Appliance control panel. The HDM overall state is good if nothing is in red or yellow color. This can be seen in Appliance’s Control Panel. In addition to the Appliance Control Panel this information is also available on vCenter on the HDM plugin.

Menu > HDM > Administration > HDM Health > Component Health



![alt_text](images/image19.png?classes=content-img "image_tooltip")


Incase of a failure the affected components will be shown here.


![alt_text](images/image4.png?classes=content-img "image_tooltip")



![alt_text](images/image13.png?classes=content-img "image_tooltip")



## HDM in a Degraded State

When the system is in a degraded state due to a failure this will be visible in;



1. The Dashboard on the vCenter
2. The Control Panel on the appliance
3. vCenter event log
4. The state in the SQS heartbeat


### vCenter Dashboard



*   On the vCenter HDM -> Dashboard ,  we will see a notification mentioning **Services not ready or down...**


![alt_text](images/image14.png?classes=content-img "image_tooltip")



### Appliance Control Panel

In case a failure occurs, some components would get affected. The state of those components would be updated in the Appliance Control Panel as **Poor** and the HDM overall state is set to be ‘Not Ready’. The component color would change from blue to red. 


![alt_text](images/image15.png?classes=content-img "image_tooltip")




*   A hover over the faulted component will give detail about the error.


![alt_text](images/image16.png?classes=content-img "image_tooltip")



### vCenter Event Log

If there are failure events that impact the operation of HDM these are recorded in an “Events Logs”. This is present in the vCenter Events log as well as a HDM Events Logs. The HDM Events Logs can be reached

Menu > HDM > Administration > Event Logs

  

![alt_text](images/image8.png?classes=content-img "image_tooltip")


Failure and repair events generated will be shown in this events logs. A example of a failure seen in the log is below. There are events capturing failure of components and their successful recovery. The last failure on top of the log is an unrecoverable failure for which we need to do an HDM reset to recover from this error.




![alt_text](images/image20.png?classes=content-img "image_tooltip")


Additionally there are messages generated in the vCenter events log which indicate these failures. To narrow down on these messages. Select the “VCenter” and then “Monitor > Events”



*   
After selection the view will look like below.


![alt_text](images/image17.png?classes=content-img "image_tooltip")



*   To narrow down on the events generated by HDM we will apply filter on the “Event Type ID” on the extreme right column, apply filter _“com.hdm”_




![alt_text](images/image18.png?classes=content-img "image_tooltip")




*   After applying the filter the view will be limited to the event generated by PIO HDM. The selected event in the view below corresponds to a failure of a HDM service.




![alt_text](images/image1.png?classes=content-img "image_tooltip")

### Health State in the SQS Heartbeat

The changes in the health of the system are also reported through the SQS heartbeats. The typical SQS heartbeat messages (as can be got at the sqs-python client) corresponding to various events are below.



*   Fully deployed system which is functional and without any failed components will have heartbeat as below

    ```
'status': 'Ready', 
'status_details': 'All the components are deployed and up.', 
'appliance_id': 'fa142afc-3c64-4086-b442-4ffcdc1580b2', 
```


*   When a component failure is detected we will see a heartbeat with the details of the failed component as below.

    ```
'status': 'Not Ready', 
'status_details': 'Services not ready or down On Prem IO Manager, On Prem 
                   Message Gateway'
'appliance_id': 'fa142afc-3c64-4086-b442-4ffcdc1580b2', 
```


*   When a reboot of a component VM host is detected we will get a heartbeat with details of the failed VM host.

    ```
'status': 'Not Ready',
'status_details': "HDM infrastructure VM rebooted or faulted 
                   ['HDM_OnPrem_ESXi_Manager-0']", 
'appliance_id': 'fa142afc-3c64-4086-b442-4ffcdc1580b2', 
```




# Failure Handling in HDM 

HDM  strategy in handling failures strives to meet the following requirements:



*   Cold VM migration will be resumed automatically after repair in case of specific HDM component failures.
*   In case of pathological scenarios where we can’t resume migration we will ensure VM availability in the event of failures and recovery post the failure. 
*   HDM system state recovered such that new migrations can be served even if ongoing migrations were cancelled and migrated VMs might have been migrated back. 


## Ensuring VM Availability 

As part of failure recovery, HDM will resume transfer of VM being cold migrated. Under pathological conditions or in warm migration HDM may identify that some VMs which were already migrated or some ongoing migrations can no longer continue to run on On-Cloud. Typically this is due to failure in the component that was used by VM to connect to On-Premise. To ensure application availability, such VMs are migrated back to On-Premise. 


## Data Consistency and Data Loss

VMs being cold migrated can never have data loss. For VMs being used for “Try Before Commit” VMs migrated back as part of failure recovery do not get the opportunity to synchronize the On-Premise with the latest data On-Cloud. Since On-Premise is synchronized in RTO/RPO interval, such VMs will have data till last RTO/RPO flush. 

Since the RTO/RPO flushes happen through point in time snapshot of the data on On-Cloud, this data is expected to be crash consistent. Modern applications and file systems are designed to deal with crashes and so, they should be able to use this data On-Premise.

In the extreme case, if the OS or the application is not able to utilize the data, the user has a choice to restore the data from migrate time snapshot, with the caveat that it causes all data while the VM was on On-Cloud, to be lost.


## HDM Failure Recovery


### Nature of Failures

Failures can be of various types. HDM mainly deals with the following types of errors



*   HDM Component Failures
    *   Appliance Restart
    *   HDM component VM restart
    *   HDM individual component failure due to software issues 
*   Network failures
    *   Transient network disconnect
    *   Permanent network disconnect
*   System failures
    *   Storage failures
    *   Memory errors


### Single Component Failure

The impact of the failure can result in failing a single HDM component. HDM is designed to recover from it automatically. The following scenarios are possible:


#### Failure when there is No Activity

Even when the system is idle after a successful deployment, it may go from “Healthy” to “Degraded”, due to a component failure. 

The HDM system health will be in the degraded state can be viewed in vCenter and Appliance (See System Health section for details).



*   Also, the vCenter Events would have new event for component failure

HDM would attempt to recover from the failure and bring the system back to a “Healthy” state. Here is a depiction of the recovery process. It shows three important stages:



*   Failure detection and moving to degraded state
*   HDM system repair
*   Healthy state

    

<p id="gdcalert46" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline drawings not supported directly from Docs. You may want to copy the inline drawing to a standalone drawing and export by reference. See <a href="https://github.com/evbacher/gd2md-html/wiki/Google-Drawings-by-reference">Google Drawings by reference</a> for details. The img URL below is a placeholder. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert47">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![drawing](https://docs.google.com/drawings/d/12345/export/png?classes=content-img)


After recovery, a message is logged in vCenter Events:



<p id="gdcalert47" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image46.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert48">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image46.png?classes=content-img?classes=content-img "image_tooltip")



#### Failure during Migrations

If a failure occurs while the migration operation is going on. HDM will go in degraded state. HDM will repair itself and will come back to a healthy state. The ongoing migration operation may fail and those VMs can be migrated back as part of this recovery. Here is a depiction of the recovery process :


    

<p id="gdcalert48" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline drawings not supported directly from Docs. You may want to copy the inline drawing to a standalone drawing and export by reference. See <a href="https://github.com/evbacher/gd2md-html/wiki/Google-Drawings-by-reference">Google Drawings by reference</a> for details. The img URL below is a placeholder. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert49">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![drawing](https://docs.google.com/drawings/d/12345/export/png?classes=content-img)

For redundant components like HDM message gateway, recovery is complete only when the required level of redundancy is restored. If a migration operation is attempted, before the recovery is complete, it will fail.


#### Failure when there are Migrated VMs

Out of all VMs already migrated to the On-Cloud some might get affected due to a component failure. This would result in those VMs getting migrated back from On-Cloud to the On-Premise. The VMs would have data till the last RTO/RPO flush. 

Here is a depiction of the recovery process :


    

<p id="gdcalert49" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline drawings not supported directly from Docs. You may want to copy the inline drawing to a standalone drawing and export by reference. See <a href="https://github.com/evbacher/gd2md-html/wiki/Google-Drawings-by-reference">Google Drawings by reference</a> for details. The img URL below is a placeholder. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert50">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![drawing](https://docs.google.com/drawings/d/12345/export/png?classes=content-img)

**Note: **



1. As part of failure recovery, if the migrated back VMs can be booted successfully, they would be in HDM_RECOVERY_SUCCESS pool, else they would be placed in HDM_RECOVERY_FAILED pool. 
2. There are cases where HDM is not able to do the auto repair of its failed component. This could be due to a software issue or the error condition is permanent (example permanent network or storage disconnect). In such cases users can issue HDM Reset to come out of the situation and start over again. See the TroubleShooting section for more details.


#### Recovery Resource Pools

VMs migrated back as part of failure recovery are kept in recovery resource pools. These are of two types


##### **HDM_RECOVERY_SUCCESS **

This resource pool hosts the VMs which have been migrated back as part of failure handling and are likely to get successfully booted in On-Premise vCenter. They may have some data loss equivalent to the last RTO/RPO flush cycle (default 20 minutes).


    

<p id="gdcalert50" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image47.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert51">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image47.png?classes=content-img "image_tooltip")



##### **HDM_RECOVERY_FAILED **

This resource pool hosts the VMs which have been migrated back as part of failure handling but are likely not to have consistent data. Such VMs will require to restore their data from the migration time snapshot.

**Note: **Restoring data from the migrate time snapshot would mean the data loss for the entire duration for which the VM was on On-Cloud.


##### **Recovering VMs from the HDM Recovery Pools**

User should perform the following steps, if there are VMs in recovery resource pools:



1. Power on the VM and verify the sanity of the data. 
2. If the power on and data sanity checks passed
    1. delete the HDM migration time snapshot.
    2. Move the VM to the resource pool it originally belonged to before the migration.
3. If the power on or the data sanity failed
    3. Restore the data from migrate time snapshot
    4. Delete the HDM migrate time snapshot
    5. Move the VM to the resource pool it originally belonged before migration
    6. Power on the VM 

**Note: **Not moving the VMs to their original resource pool would cause the subsequent migration and migration back of these VMs happening from the HDM recovery pool only. 


### Multiple Component Failure

During the process of recovery from failure of a single component, if another component also fails, HDM would detect the failure and notify the user through the vCenter events. This also applies to the case of simultaneous multiple HDM component hosts restart. HDM components may not fully recover and migrated VMs may not get rolled back. 

Multiple component failures may require HDM Reset to restore the system.


### HDM Appliance Restart

Restarting the Appliance does not impact migrated VMs and it does not impact future migration operations as well.

Operations in progress during the appliance restart will be affected in the following way.



1. ARM cold migration of a VM.
    *   The ongoing bulk transfer will fail and the operation will be retried from the beginning.
2. VM migration to On-Cloud would resume after restart and complete successfully
3. ARM warm migration
    *   If the appliance reboot happened during the VM compute migrate of the flow, both the migrate and bulk transfer will fail.
    *   If the appliance reboot was after the successful VM compute migrate, only the bulk transfer will be retried.
4. VMs running on the cloud
    *   Will continue to run.
    *   Some operations like RTO/RPO periodic flush will resume after the reboot completes
5. SQS heartbeat
    *   SQS heartbeats will be missing for the duration of the reboot for about 2 minutes
6. vCenter plugin
    *   vCenter plugin will display the message that it cannot connect with appliance for this duration.


### HDM Component VM Restart

The HDM deployment consists of a set of  microservices running as containers in VM which are deployed On-Premise as well as On-Cloud. Depending on the deployment type, we will have all the below VMs or a subset of them



*   HDM_Cloud_Manager
*   HDM_Cloud_Cache
*   HDM_OnPrem_Manager
*   HDM_OnPrem_ESXi_Manager

 

When either of these are rebooted the repair actions are triggered:



1. All affected VMs as in single component failure case are migrated back to the last RTO/RPO state.
2. A vCenter event is logged specifying a “Docker reboot” has occurred specifying the particular VM which has reboot.
3. All components within that VM are repaired.
4. All future operations involving the repaired components should work correctly.


### WAN Network Disconnect

The WAN network disconnect may result in HDM components losing the network connectivity with the central heartbeat monitoring entity. 


#### Transient Network Failure

HDM can recover from short network outages by retrying ongoing operations. Outages less than 5 minutes are considered short outages.


#### Permanent Network Failure

If the network outage is for extended periods of time(greater than 5 minutes), the HDM recovery may not succeed and HDM Reset may be required.


### ESXii Host Restart

If On-Premise ESXi host is restarted or the PRAAPA iofilter daemon service is restarted, the ongoing migrations will fail, VMs already migrated to On-Cloud, will be migrated back. Also, new VM migration will fail. HDM reset and re-deployment of HDM On-Premise and On-Cloud components is required before retrying the migration operation.


### System Failures

Failures like storage or memory, may result in either some HDM component failures or their impact could be limited to few operations or IOs. We have already discussed the single and multiple component failures. If IOs or some operations fail, such failures are dealt with by retrying them.


#### Boot Failure During Migrate

Guest VM boot may fail due to reasons like vmware tools not coming up early enough to detect successful boot. HDM retries (in this case reboot) the operation a few times. 

**Note**: Multiple retries can delay the boot and in such cases, the user may have to wait till 30 minutes for the migration operation to complete.


#### Bulk Transfer Failure During ARM Migration

If the bulk transfer failed during cold migration, the operation is retried a few times. Errors such as transient network issues can be dealt with this mechanism.

**Note:** All retries happen for a fixed number of times. If the retries exhaust, the operation is marked as failed.

If a snapshot of a VM has been bulk transferred to On-Cloud and a failure occurs when sync to it is in progress through the cloud cache, the user has to explicitly delete the bulk transferred VM from the On-Cloud. The HDM failure handling does not automatically delete the bulk transferred VM.


### Unresolved Issues

**Refer to the Troubleshooting Guide in case the failure issues are not resolved. The failure might have been caused due to one of the known product issues. **

**Finally, seeking help from PrimaryIO support may be required, refer to the Install Guide for the details. **
