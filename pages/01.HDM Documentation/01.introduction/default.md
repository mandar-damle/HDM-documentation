---
title: Introduction
---

## What is Hybrid Cloud Data Management (HDM)

PrimaryIO’s HDM provides solutions to perform migrations of VMware based virtual machines from on-premises to VMware based cloud environments.  HDM’s warm migration is a unique technology that decouples VM compute and storage to flexibly move workloads to and from the cloud rapidly and lets you fully control the data.  By combining the integrated smart IO analyzer and our optimized transfer technologies, we can ensure you can start using the cloud immediately instead of waiting days or weeks.

## How Does Hybrid Cloud Data Management (HDM) Work?
HDM decouples compute (Virtual Machines - VM) and storage (Virtual Disks - VMDK) functions to quickly and efficiently move workloads to VMware-based cloud providers by identifying the frequently used data (hot dataset) and initially only moving the minimum amount of that data to the cloud. This enables VMs to be migrated and turned up in the cloud provider in the shortest possible timeframe.  


_Figure 1: HDM Architecture_

![alt_text](images/arch02.png?classes=content-img "image_tooltip")


## Why Hybrid Cloud Data Management (HDM)?

1. **Rapid VM migration:** HDM allows for VMs to be powered up in the target cloud environment using only the hot data.  The cold data is efficiently transferred as a background process.
1. **Trial Migrations:** Migrations can be complicated and may take several maintenance windows before they are successful.  HDM’s flexible approach allows for VMs to be rapidly powered up in the target cloud and reverted to the onpremise environment if needed. 

The HDM product binaries can be used in VMware Cloud Director or VMware Cloud Service for IBM (Cloud Director and VCS). The components for each of these deployment is shown below.

## HDM Deployment for VMware Cloud Director

1. **PrimaryIO Plug-in:** Installed and registered on VMware vCenter for HDM management.
2. **PrimaryIO Manager:** The main controlling appliance that controls and orchestrates the entire system.
3. **On-premises Storage Gateway:** Provides access across the WAN link to deliver traffic optimization and redundancy against failures. It also accesses and manages the on-premises VMDKs for cloud-based VMs.
4. **Cloud Storage Gateway: **Provides access across the WAN link to enable cloud-based VMs read/write access back to the on-premises environment. It is possible to have multiple gateways for redundancy.
5. **Sync Daemon:** Located in both environments to deliver compression, encryption, and de-duplication for data being transferred from on-premises to cloud environments. It also provides a mechanism to pause and resume data transfers in the event of a WAN disconnect.

_Figure 2: Location of HDM 2.1.3 components_

![alt_text](images/image8.png?classes=content-img "image_tooltip")

## HDM Deployment for VMware Cloud Service for IBM VCS

1. **PrimaryIO Plug-in: **Installed and registered on VMware vCenter for HDM management.
2. **PrimaryIO Manager:** The main controlling appliance that controls and orchestrates the entire system.
3. **PrimaryIO Filter:** A **VMware VAIO filter framework** to gather I/O traces from each VM.
4. **PrimaryIO Analyzer:** The I/O Analyzer (IOA) aggregates I/O traces from all VMs and analyzes the I/O traces at a block level to make recommendations on the cloud cache requirements.
5. **On-premises Storage Gateway:** Provides access across the WAN link to deliver traffic optimization and redundancy against failures. It also accesses and manages the on-premises VMDKs for cloud-based VMs.
6. **Cloud Storage Gateway: **Provides access across the WAN link to enable cloud-based VMs read/write access back to the on-premises environment. It is possible to have multiple gateways for redundancy.
7. **Cloud Cache:** The cloud cache is a fast, reliable, persistent cache for the VMs in the cloud. The cache maintains the working set of VMs, enabling them to run efficiently without moving entire data sets into the cloud. When there is a cache miss, the storage gateway obtains blocks from the on-premises VMDK.

_Figure 3: HDM components_
![alt_text](images/image54.png?classes=content-img "image_tooltip")
 
# HDM Deployment

HDM provides a flexible deployment model to support a wide range of user needs regarding use case, performance, scalability, and security. The detailed steps and options for each deployment method are covered in the **Deployment planning** and subsequent sections. 

### Deployment Overview of HDM
[plugin:youtube](https://youtu.be/BtpGR64wLGQ)


# HDM Migrations

HDM 2.1.3 is used to migrate VMs from on-premises environments to the cloud. There are two main use cases for HDM migrations:

1. **Agile Rapid Migration (ARM):** The capability to decouple compute from data, to minimize downtime during migration.
2. **Try Before Commit (TBC):** The capability to quickly test the VMs running in the cloud before fully committing to the cloud.

## Use Cases

### Agile Rapid Migration (ARM)

This use case permanently moves the VM and all of its data to the cloud. Two types of this migration are possible:

*   **Cold migration**: Application data is moved to the cloud using **bulk migration**. The VM is powered off throughout the migration and becomes available in the cloud once the data has been fully transferred. 
*   **Warm migration**: A subset of data, called the working set, is moved to the cloud and the VM is instantly available. HDM’s cloud cache is used for optimal IO performance. Any cache misses are fetched from the on-premises environment via the WAN. The remainder of the data set is either moved online through HDM, or offline in the background. Once all data has been moved to the cloud, it is reconciled with the data from the running application to minimize application downtime.

The choice of which migration type to employ depends on the amount of data in the VM and if the VM needs to be instantly available during the migration, or if prolonged downtime can be tolerated.


### Try Before Commit (TBC)

This use case provides a quick way to migrate VMs to the cloud while retaining the data on-premises. This helps users validate how the applications would run in the cloud, to help them decide whether or not to fully migrate them. The user can choose to migrate the applications back to the on-premises environment at any time.

