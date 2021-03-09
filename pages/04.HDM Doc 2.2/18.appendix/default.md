---
title: 'Appendix'
---

# Prepare to migrate

The following operations are done on the guest VM for prepare to migrate.

### Linux

For a Support Linux OS we will
1. Check VMware tools installed and running
1. Appliance copy prepare to migrate tool to Guest in User’s home directory->.PIO->hyc
1. Check iSCSI initiator package installed (install it if not)
1. Add iSCSI driver/module to initrd
1. Install grub scripts to support customized Grub entries and to support EFI
1. Configure and Update grub to allow iSCSI booting
1. Get network configuration pre-migration and then Set post migration network configuration


### Windows


For a Supported Windows OS we will
1. Disable WFP(Windows Filtering Platform) Lightweight Filter bindings from the NIC which will be used for iSCSI booting.
1. Turning on the 'msiscsi' service and setting 'service_start_mode' to 'automatic' so it will be going to autostart on each boot.
1. [add what packages will be added]
1. [what files are added with what permissions]
1. [Which site are we downloading additional packages.]


# HDM - Component Interactions


## Introduction

The document describes the interactions between HDM components and VMware Infrastructure both on premise and on cloud. The document would describe the authentication mechanism, permissions and network connectivity required for these interactions.





![drawing](images/image1.png)



1. User interaction with HDM PIO Appliance
    1. Authentication - User credentials
    1. Port - 22 (TCP), 443 (TCP) 
        1. Details
            1. User interactions with the PIO appliance over a web interface over HTTPS. HTTPS is configured with a self signed certificate initially.
            1. SSH for optional PrimaryIO customer support access.
1. HDM PIO Appliance to on-premise vCenter
    1. Authentication - User credentials
    1. Port - 443 (TCP)
        1. Details
            1. PIO Appliance uses vSphere API to interact with vCenter to manage:
            1. Plugin - Requires read and write permissions to register HDM vCenter plugin. HDM plugin provides interfaces to configure, monitor, manage and migrate virtual machines.
            1. Catalog - Requires read and write permission to Create catalog, Upload OVF,  Delete Catalog Item and Delete Catalog. HDM uploads OVF which are then required to deploy HDM appliances during the initial configuration.
            1. Virtual machine - Requires read and write permission to deploy/ create virtual machines, manage virtual machines and delete virtual machines. These permissions are required during HDM appliance deployment and virtual machine migration.
            1. ESXi - Requires permission to install VMware certified VAIO filter.
            1. Storage Policy Based Management - Required read and write permission to create, modify and delete storage policies.
1. HDM PIO Appliance to on-cloud vCenter
    1. Authentication - User credentials
    1. Port - 443 (TCP)
    1. Details
        1. PIO Appliance uses vSphere API to interact with vCenter to manage:
            1. Catalog - Requires read and write permission to Create catalog, Upload OVF,  Delete Catalog Item and Delete Catalog. HDM uploads OVF which are then required to deploy HDM appliances during the initial configuration.
            1. Virtual machine - Requires read and write permission to deploy/ create virtual machines, manage virtual machines and delete virtual machines. These permissions are required during HDM appliance deployment and virtual machine migration.
1. HDM PIO Appliance to HDM Prem Manager
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Ports - 22 (TCP), 443 (TCP), 2376 (TCP), 8000-8010 (TCP), 32820 (TCP)
    1. Details
        1. PIO Appliance uses port 2376 to deploy and manage HDM services containerized within HDM Prem Manager
        1. SSH access is required for initial configuration.
        1. Service level interaction between HDM services is over HTTPS authorized using SSL certificates.
        1. IO Analyzer summaries created in ESXi are pushed to PIO Appliance using port 32820
        1. 8000-8010 used for internal service configuration authorized using SSL certificates.
1. HDM PIO Appliance to HDM Prem ESXi Manager
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Ports - 22 (TCP), 443 (TCP), 2376 (TCP), 8000-8010 (TCP)
    1. Details
        1. PIO Appliance uses port 2376 to deploy and manage HDM services containerized within HDM Prem ESXi Manager
        1. SSH access is required for initial configuration.
        1. Service level interaction between HDM services is over HTTPS authorized using SSL certificates.
        1. 8000-8010 used for internal service configuration authorized using SSL certificates.
1. HDM PIO Appliance to HDM Cloud Cache
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Ports - 22 (TCP), 443 (TCP), 2376 (TCP), 8000-8010 (TCP)
    1. Details
        1. PIO Appliance uses port 2376 to deploy and manage HDM services containerized within HDM Cloud Cache
        1. SSH access is required for initial configuration.
        1. Service level interaction between HDM services is over HTTPS authorized using SSL certificates.
        1. 8000-8010 used for internal service configuration authorized using SSL certificates.
1. HDM PIO Appliance to HDM Cloud Manager
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Ports - 22 (TCP), 443 (TCP), 2376 (TCP), 8000-8010 (TCP)
    1. Details
        1. PIO Appliance uses port 2376 to deploy and manage HDM services containerized within HDM Cloud Manager
        1. SSH access is required for initial configuration.
        1. Service level interaction between HDM services is over HTTPS authorized using SSL certificates.
        1. 8000-8010 used for internal service configuration.
1. HDM Prem ESXi Manager to HDM Prem Manager
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Ports - 5000-5010 (TCP), 12000-12010 (TCP)
    1. Details
        1. 5000-5010, 12000-12010 are used for Internal data transfer.
1. HDM Prem Manager to HDM Cloud Manager (**Across Site to Site Network Interconnect**)
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Ports - 22 (TCP), 443 (TCP), 6000-6010 (TCP), 7000-7010 (TCP)
    1. Details
        1. Data transfer between the HDM prem manager and HDM cloud manager happens over port 600x and 700x. The data is compressed and encrypted before being transferred across the “interconnect”.
        1. SSH access is required for initial configuration.
        1. Service level communication across HDM components is over HTTPS using the SSL certificates.
1. HDM Cloud Manager and HDM Cloud Cache
    1. Authentication - User credentials
    1. Authorization - SSL certificate
    1. Port - 32820 (TCP), 5000-5010 (TCP), 12000-12010 (TCP)
    1. Details
        1. IO Analyzer summaries created on HDM cloud cache are pushed to HDM Cloud Manager over port 32820.
        1. 5000-5010, 12000-12010 are used for Internal data transfer.
1. HDM Prem ESXi Manager and on-premise ESXi
    1. Authentication - User credentials
    1. Authorization - VMware Authorization
    1. Port - 902 (TCP), 32821 (TCP), 32822 (TCP)
    1. Details
        1. Read and Write of data from and to VMDK is managed by HDM Prem ESXi Manager is done on port 32821 and 32822. 
        1. Port 902 is required for Network File Copy (NFC)
1. HDM Cloud Cache to Virtual machines running on cloud over cache
    1. Authentication - User credentials 
    1. Authorization - Data Encrypted
    1. Ports - 3260 (TCP), 9001 (TCP), 9002 (TCP)
    1. Details - 
        1. Virtual machines running over cache on cloud boots over iSCSI port 3260.
        1. 9001, 9002 is used for data Transfer using MicroVM.
1. HDM Cloud Cache to Cloud vCenter 
    1. Authentication - vCenter User Credentials
    1. Authorization - VMware Authentication
    1. Ports - 443 (TCP)
    1. Details
        1. HDM cloud cache requires access to on cloud vCenter at port 443 to authenticate access to ESXi at port 443 and 902 to write data to the VMDK.
1. HDM Cloud Cache to VMDK/ Disks on Cloud
    1. Authentication - vCenter User Credentials
    1. Authorization - VMware Authentication
    1. Ports - 443 (TCP), 902 (TCP)
    1. Details
        1. HDM cloud cache requires access to on cloud vCenter at port 443 to authenticate access to ESXi at port 443 and 902 to write data to the VMDK.
1. PIO Appliance to Virtual machines on premise
    1. Authentication - Sudo/ Admin user credentials
    1. Authorization - User credentials
    1. Port - 443 (TCP)
    1. Details
        1. Virtual machines that need to be migrated to the cloud using warm migration will need to be prepared on premise.
        1. PIO Appliance uses VMware Guest Tool to insert scripts to check and configure the following:
            1. Check VMware tool versions
            1. Check OS version
            1. Check iSCSI initiator configuration. If not installed, installs iSCSI initiator and configures VM boot over iSCSI on cloud
