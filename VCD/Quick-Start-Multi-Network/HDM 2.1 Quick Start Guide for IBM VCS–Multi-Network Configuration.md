HDM 2.1 Quick Start Guide for IBM VCS–Multi-Network Configuration
=================================================================

Version 1.0.0

# About this Guide

This quick start guide is intended to help you rapidly deploy PrimaryIO
HDM to a test environment. The steps are intended for a multi-network
environment, with cloud access via a WAN link and no separation of the
management and VM network. All IP assignments in this guide are static
and connectivity between the on-premises and cloud environments is via
IPSec. For other types of network configurations, refer to the HDM 2.1
Install Guide.

HDM provides a flexible deployment model to cater to a wide range of
user needs, including different use cases, performance requirements,
scalability, and levels of security. The HDM 2.1 Install Guide contains
full details of every deployment mode. For simplicity, this document
describes an HDM deployment using the ***Standard, Standalone*** option.
This option supports all the key features of HDM and can also be used
for cold migration and validation purposes.

# Steps Required to Deploy HDM

The following steps are required to deploy HDM:

1.  Review System Requirements *(estimated time: 15 minutes)*
2.  Download PrimaryIO HDM *(estimated time: 5 minutes – depending on
    Internet speed)*
3.  Network Planning & Mapping *(estimated time: 20 minutes)*
4.  Deploy the HDM Appliance *(estimated time: 5 minutes)*
5.  Validate the Network Configuration *(estimated time: 5 minutes)*
6.  On-premises Deployment *(estimated time: 10 minutes)*
7.  Cloud Deployment *(estimated time: 45-60 minutes)*
8.  Migrating a VM to the cloud *(estimated time: dependent on VM size)*

### Step 1: Review System Requirements

Refer to the System Requirements in Appendix A of this document.
Printing a copy of Appendix A
to use as a checklist is recommended.

### Step 2: Download PrimaryIO HDM

To obtain your license and download link for HDM, visit
[https://www.primaryio.com/ibm/](https://www.primaryio.com/ibm/)

You will receive an email with the following:

-   A link to download the PrimaryIO HDM software
-   A link to training videos
-   A license key for the software

Before proceeding with the installation, watch the training videos and
use this guide.

### Step 3: Network Planning and Mapping

Network configuration information is required at key points throughout
the deployment process. So, develop a network connectivity plan prior to
deploying HDM. This section will help guide you through that process.
The information captured in this section will be employed later in the
installation process. If an IPSec tunnel and cloud configuration have
not yet been established, these must be done before moving any further.
Follow the steps outlined in [Appendix
C](https://www.primaryio.com/xdocs/hdm-2-1-quick-start-guide-ibm-vcs-test-multi-network-standard-standalone/#post-3364-_Appendix_C_-_1)
of this document. Please be aware that this process will add 30 minutes
to the estimated time to complete this section.

Once connectivity and cloud configuration are complete, be sure to
record all applicable details in [Appendix
B](https://www.primaryio.com/xdocs/hdm-2-1-quick-start-guide-ibm-vcs-test-multi-network-standard-standalone/#post-3364-_Appendix_B_-_1)
of this document for easy reference later in the deployment process.

The following is required to complete the network plan:

1.  IPSec tunnel, firewall, and cloud network configuration information
    (See [Appendix
    C](https://www.primaryio.com/xdocs/hdm-2-1-quick-start-guide-ibm-vcs-test-multi-network-standard-standalone/#post-3364-_Appendix_C_-_1))
2.  Network requirements during OVF deployment
3.  Network requirements during on-premises deployment
4.  Network requirements during cloud deployment

**Choose or create an appropriate network:**

Configuring the correct network for deployment is essential for HDM to   
properly function. Please choose or configure the networks to satisfy    
the required connectivity for your use case.                             
                                                                        
**ESXi\_Network:**                                                       
                                                                        
Network where the ESXi portion of the cluster is reachable.              
                                                                        
**VM\_Network/Management Network:**                                      
                                                                        
The network where the vCenters and management networks are configured.   
You may have the ESXi and vCenters configured over the same network. In  
this case, ESXi\_Network and VM\_Network will be the same.               
                                                                        
**HDM\_Internal\_Network:**                                              
                                                                        
The HDM internal network is used to connect the HDM components for their 
private communication.                                                   
                                                                        
**Uplink WAN Network:**                                                  
                                                                        
The network where the on-premises components can communicate with the    
cloud components.                                                        
                                                                        
**Failure to create, choose, or configure the networks correctly will    
cause the installation to fail.**                                        


Figure 1: Network Configuration of the Test Environment                  
                                                                          
 ![](./HDM%202.1%20Quick%20Start%20Guide%20for%20IBM%20VCS–Multi-Network% 
 20Configuration_files/word-image-118.png)                                

The remainder of this document will assume you have created a network
topology like the one shown in Figure 1, and will refer to the networks
by those names.

 **NOTES:**                                                               
1.  The subnet range 172.17.0.0/16 is not available for the deployment;  
     it is used internally by HDM microservices.                          
2.  Please add the vCenter FQDN for the on-premises and cloud vCenters   
     on the on-premises and cloud DNS servers.                            

Before continuing with the rest of this Quick Start Guide, be sure to
print [Appendix B – Network
Settings](https://www.primaryio.com/xdocs/hdm-2-1-quick-start-guide-ibm-vcs-test-multi-network-standard-standalone/#post-3364-_Appendix_B_-_1)
and complete the forms. This will help you identify the correct networks
to configure and identify all networking details.

### Step 4: Deploy the HDM Appliance

-   Make sure you have at least 10GB free space to download the
    appliance
-   Unzip the file *HDM\_2.1.zip* from the download link
-   Deploy the appliance using the vCenter UI

**NOTE:**

-   HDM appliance should be deployed on the same vCenter and datacenter
    it will manage.
-   HDM components should be deployed on a shared datastore. Disks can
    be thin provisioned.

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Perform the step as directed by  |
| ide%20for%20IBM%20VCS–Multi-Network% |     the UI.                          |
| 20Configuration_files/word-image-119 | -   Complete this screen using the   |
| .png)                                |     data you recorded in [Appendix B |
|                                      |     – Network                        |
|                                      |     Settings](https://www.primaryio. |
|                                      | com/xdocs/hdm-2-1-quick-start-guide- |
|                                      | ibm-vcs-test-multi-network-standard- |
|                                      | standalone/#post-3364-_Appendix_B_-_ |
|                                      | 1)                                   |
|                                      | -   Refer to the “Network            |
|                                      |     Configuration for the Appliance” |
|                                      |     section in the HDM Installation  |
|                                      |     Guide for details on the network |
|                                      |     configuration.                   |
|                                      | -   Power the appliance on after     |
|                                      |     deploying it.                    |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Choose “WAN” for the default     |
| ide%20for%20IBM%20VCS–Multi-Network% |     gateway network.                 |
| 20Configuration_files/word-image-120 | -   Complete the network properties  |
| .png)                                |     using the data you recorded in   |
|                                      |     [Appendix B – Network            |
|                                      |     Settings](https://www.primaryio. |
|                                      | com/xdocs/hdm-2-1-quick-start-guide- |
|                                      | ibm-vcs-test-multi-network-standard- |
|                                      | standalone/#post-3364-_Appendix_B_-_ |
|                                      | 1)                                   |
|                                      | -   Be sure to select the correct    |
|                                      |     default gateway interface. Enter |
|                                      |     the IP address of the WAN in the |
|                                      |     “Default Gateway” field. The     |
|                                      |     cloud VC should be accessible    |
|                                      |     from an appliance with the       |
|                                      |     default gateway.                 |
+--------------------------------------+--------------------------------------+

### Step 5: Validate the Network Configuration

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   All ESXi servers in the vCenter  |
| ide%20for%20IBM%20VCS–Multi-Network% |     should be connected              |
| 20Configuration_files/word-image-121 |                                      |
| .png)                                |                                      |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   The ESXi server must be able to  |
| ide%20for%20IBM%20VCS–Multi-Network% |     communicate with vCenter. Test   |
| 20Configuration_files/word-image-122 |     this using the ping command from |
| .png)                                |     the ESXi server to the vCenter   |
|                                      |     FQDN (or IP)                     |
+--------------------------------------+--------------------------------------+

-   ssh to the HDM appliance that was deployed in step 4. Use the IP
    given on the “VM Network” (Management Network)
-   Use the following credentials:
    -   UID: *root*
    -   Password: *admin@123*
-   Use this session to validate connectivity

**Use the following commands to test connectivity between the
endpoints:**

+--------------------------------------------------------------------------+
| \$ curl -k https://\<prem\_vcenter\_fqdn\>                               |
|                                                                          |
| \<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN”          |
| “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”\>              |
|                                                                          |
| :                                                                        |
|                                                                          |
| :                                                                        |
|                                                                          |
| \</body\>                                                                |
|                                                                          |
| \</html\>                                                                |
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| \$ curl -k https://\<cloud\_vcenter\_fqdn\>                              |
|                                                                          |
| \<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN”          |
| “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”\>              |
|                                                                          |
| :                                                                        |
|                                                                          |
| :                                                                        |
|                                                                          |
| \</body\>                                                                |
|                                                                          |
| \</html\>                                                                |
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| \$ curl -k https://\<on\_prem\_esxi\_ip\>                                |
|                                                                          |
| \<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN”          |
| “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”\>              |
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| \$ curl -k https://\<on\_cloud\_esxi\_ip\>                               |
|                                                                          |
| \<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN”          |
| “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”\>              |
+--------------------------------------------------------------------------+

 

### Step 6: On-premises Deployment

Add on-premises vCenter
-----------------------

-   Power On the appliance
-   Locate the IP address of the appliance
-   Enter *https://\<appliance-ip\>* in the appliance web interface
-   Login to the appliance web UI using default password: *admin@123*
-   After login, select
    ![](./HDM%202.1%20Quick%20Start%20Guide%20for%20IBM%20VCS–Multi-Network%20Configuration_files/word-image-123.png)

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Select *Add vCenter*             |
| ide%20for%20IBM%20VCS–Multi-Network% |                                      |
| 20Configuration_files/word-image-124 |                                      |
| .png)                                |                                      |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Enter the vCenter credentials    |
| ide%20for%20IBM%20VCS–Multi-Network% | -   Select *Add*                     |
| 20Configuration_files/word-image-125 |                                      |
| .png)                                |                                      |
+--------------------------------------+--------------------------------------+

  ------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------
  ![](./HDM%202.1%20Quick%20Start%20Guide%20for%20IBM%20VCS–Multi-Network%20Configuration_files/word-image-126.png)   Register the vCenter plugin by selecting *Register*”
  ------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------

vCenter configuration is now complete. Log into the newly-configured
vCenter.

+--------------------------------------------------------------------------+
| Note:                                                                    |
|                                                                          |
| -   For the plugin to be visible within vCenter, you will need to        |
|     logout/login to the vCenter at least twice.                          |
+--------------------------------------------------------------------------+

Configure License
-----------------

Navigate to the *Licensing* page on the HDM vCenter Plugin

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   HDM plugin can be accessed       |
| ide%20for%20IBM%20VCS–Multi-Network% |     directly via the Menu            |
| 20Configuration_files/word-image-127 | -   It can take approximately five   |
| .png)                                |     minutes to load HDM the first    |
|                                      |     time it is accessed              |
|                                      | -   On the *Licensing* tab, select   |
|                                      |     *Add License*                    |
|                                      | -   Add the license key received by  |
|                                      |     mail                             |
+--------------------------------------+--------------------------------------+

Configure On-premises vCenter
-----------------------------

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Select *Administration*, then    |
| ide%20for%20IBM%20VCS–Multi-Network% |     *Configuration*                  |
| 20Configuration_files/word-image-128 | -   Choose the cluster where you     |
| .png)                                |     want to install vCenter          |
|                                      | -   Select *Install*                 |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Resource: Standard               |
| ide%20for%20IBM%20VCS–Multi-Network% | -   Deployment: Standalone           |
| 20Configuration_files/word-image-7.j | -   Only choose these options (this  |
| peg)                                 |     guide is only tailored to this   |
|                                      |     configuration)                   |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Complete all steps to begin the  |
| ide%20for%20IBM%20VCS–Multi-Network% |     deployment                       |
| 20Configuration_files/word-image-8.j | -   Complete the configuration       |
| peg)                                 |     details using the information    |
|                                      |     you recorded in [Appendix B –    |
|                                      |     Network                          |
|                                      |     Settings](https://www.primaryio. |
|                                      | com/xdocs/hdm-2-1-quick-start-guide- |
|                                      | ibm-vcs-test-multi-network-standard- |
|                                      | standalone/#post-3364-_Appendix_B_-_ |
|                                      | 1)                                   |
|                                      | -   For additional details, refer to |
|                                      |     the “Deploy HDM On-premises”     |
|                                      |     section in the HDM 2.1           |
|                                      |     Installation Guide               |
|                                      | -   This step will take a few        |
|                                      |     minutes to complete. Progress    |
|                                      |     will be shown on the vCenter     |
|                                      |     task bar                         |
+--------------------------------------+--------------------------------------+

### Step 7: Cloud Deployment

Configure Cloud vCenter
-----------------------

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Select *Clouds*, then *Add       |
| ide%20for%20IBM%20VCS–Multi-Network% |     Cloud*                           |
| 20Configuration_files/word-image-129 | -   The cloud configuration wizard   |
| .png)                                |     will pop-up automatically        |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Choose *IBM Cloud on VMware      |
| ide%20for%20IBM%20VCS–Multi-Network% |     Solutions Dedicated*             |
| 20Configuration_files/word-image-9.j | -   Enter the required details       |
| peg)                                 |                                      |
+--------------------------------------+--------------------------------------+

### WAN Routing Configuration

The following WAN routes are required to gain access between the cloud
and on-premises environments:

-   **On-premises WAN route:**The route that is set on the on-premises
    HDM appliance. The routes enable communication from on-premises to
    cloud HDM appliances.
    -   **Cloud WAN subnet:**Location of the deployed HDM appliances
    -   **On-premises WAN gateway:**Enables access to the cloud WAN
        subnet
-   **On-premises WAN route:**The route that is set on the HDM appliance
    in the cloud. The routes enable communication from the cloud to
    on-premises HDM appliances.
    -   **On-premises WAN subnet:**Location of the deployed HDM
        appliances
    -   **Cloud WAN gateway:**Enables access to on-premises WAN subnet

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Complete with the correct routes |
| ide%20for%20IBM%20VCS–Multi-Network% |     for the chosen configuration     |
| 20Configuration_files/word-image-130 | -   Use the configuration            |
| .png)                                |     information recorded in          |
|                                      |     [Appendix                        |
|                                      |     B](https://www.primaryio.com/xdo |
|                                      | cs/hdm-2-1-quick-start-guide-ibm-vcs |
|                                      | -test-multi-network-standard-standal |
|                                      | one/#post-3364-_Appendix_B_-_1)      |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Use the configuration            |
| ide%20for%20IBM%20VCS–Multi-Network% |     information recorded in          |
| 20Configuration_files/word-image-131 |     [Appendix                        |
| .png)                                |     B](https://www.primaryio.com/xdo |
|                                      | cs/hdm-2-1-quick-start-guide-ibm-vcs |
|                                      | -test-multi-network-standard-standal |
|                                      | one/#post-3364-_Appendix_B_-_1)      |
|                                      | -   Map on-premises to the cloud     |
|                                      |     network to enable application    |
|                                      |     connectivity                     |
|                                      | -   Depending on the chosen          |
|                                      |     configuration and uplink speed,  |
|                                      |     this step may require up to an   |
|                                      |     hour to complete                 |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   To ensure the deployment has     |
| ide%20for%20IBM%20VCS–Multi-Network% |     been successful, select *HDM*    |
| 20Configuration_files/word-image-132 |     from the Menu, followed by the   |
| .png)                                |     *Administration*, *HDM Health*,  |
|                                      |     and *Component Health* tabs      |
|                                      | -   Check the status. If it is       |
|                                      |     green, it is ready to begin      |
|                                      |     migration                        |
+--------------------------------------+--------------------------------------+

### Step 8: Perform a Cold Migration

During cold migration, the VM being migrated is powered off. After the
migration has been completed on the cloud, the VM can be powered back
on.

+--------------------------------------------------------------------------+
| **NOTES:**                                                               |
|                                                                          |
| 1.  Migrations will be successful for VMs where network and disk         |
|     interfaces are accessible to HDM via VMware APIs.                    |
| 2.  If network or disk interfaces are added dynamically, the virtual     |
|     machine will need to be powered down to allow the newly added        |
|     network and disk interface information to become available to HDM    |
|     via VMware APIs.                                                     |
| 3.  Before migration is triggered, ensure that the health of the HDM     |
|     components is green.                                                 |
+--------------------------------------------------------------------------+

 

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Right-click on the VM            |
| ide%20for%20IBM%20VCS–Multi-Network% | -   Select *Migrate*                 |
| 20Configuration_files/word-image-10. | -   The migration wizard will pop-up |
| jpeg)                                |     automatically                    |
+--------------------------------------+--------------------------------------+

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   Complete all the steps           |
| ide%20for%20IBM%20VCS–Multi-Network% |                                      |
| 20Configuration_files/word-image-133 |                                      |
| .png)                                |                                      |
+--------------------------------------+--------------------------------------+

 

+--------------------------------------+--------------------------------------+
| ![](./HDM%202.1%20Quick%20Start%20Gu | -   The migration status will be     |
| ide%20for%20IBM%20VCS–Multi-Network% |     displayed in the wizard, as well |
| 20Configuration_files/word-image-134 |     as in vCenter tasks              |
| .png)                                | -   Following successful migration,  |
|                                      |     the VM will be ready for use in  |
|                                      |     the cloud                        |
|                                      | -   To migrate multiple VMs and the  |
|                                      |     HDM dashboard, please refer to   |
|                                      |     the HDM 2.1 Admin Guide          |
+--------------------------------------+--------------------------------------+

[**](https://www.primaryio.com/xdocs/hdm-2-1-quick-start-guide-ibm-vcs-test-multi-network-standard-standalone/#appendix-a-system-requirements)Appendix A - System Requirements {.page-header}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 

+--------------------------------------+--------------------------------------+
| **Requirement**                      | **Available (Yes / No)**             |
+--------------------------------------+--------------------------------------+
| On-premises Requirements             |                                      |
+--------------------------------------+--------------------------------------+
| VMware Environment                   |                                      |
+--------------------------------------+--------------------------------------+
| vCenter Web Client: 6.5 or 6.7       |                                      |
|                                      |                                      |
| (Use of HTML client is recommended   |                                      |
| with Chrome v 75 +)                  |                                      |
+--------------------------------------+--------------------------------------+
| Single version of ESXi throughout    |                                      |
| the vCenter cluster. Versions        |                                      |
| supported: ESXi 6.5U2+, 6.7          |                                      |
+--------------------------------------+--------------------------------------+
| ESXi in connected state in the       |                                      |
| vCenter                              |                                      |
+--------------------------------------+--------------------------------------+
| ESXi can communicate with vCenter    |                                      |
+--------------------------------------+--------------------------------------+
| Datastore should be one of: VMFS,    |                                      |
| NFS, NFSv3                           |                                      |
+--------------------------------------+--------------------------------------+
| E1000E and VMXNet3 network adapters  |                                      |
| should be available in On-premises   |                                      |
| vCenter                              |                                      |
+--------------------------------------+--------------------------------------+
| DRS is enabled and HA should be      |                                      |
| enabled (only if there are more than |                                      |
| one ESXi) on the vCenter cluster     |                                      |
+--------------------------------------+--------------------------------------+
| Network Environment                  |                                      |
+--------------------------------------+--------------------------------------+
| Network speed: at least 1 Gbps (10   |                                      |
| Gbps link is preferred)              |                                      |
+--------------------------------------+--------------------------------------+
| VM Network has connectivity to the   |                                      |
| cloud endpoint                       |                                      |
+--------------------------------------+--------------------------------------+
| VM Network should have access to     |                                      |
| ESXi, VCenter                        |                                      |
+--------------------------------------+--------------------------------------+
| Hardware Requirements                |                                      |
+--------------------------------------+--------------------------------------+
| +--------------------------+-------- |                                      |
| ------------------+----------------- |                                      |
| ---------+                           |                                      |
| | On-premises              | **Total |                                      |
|  resources        | **1** Appliance  |                                      |
| (4 vCPU, |                           |                                      |
| |                          | require |                                      |
| d for HDM**       | 8 GB RAM, 144 GB |                                      |
|  disk),\ |                           |                                      |
| |                          |         |                                      |
|                   |  **1** PremMgr ( |                                      |
| 3 vCPU,  |                           |                                      |
| |                          | 11 vCPU |                                      |
| , 16 GB RAM, 336  | 4 GB RAM, 32 GB  |                                      |
|          |                           |                                      |
| |                          | GB disk |                                      |
|                   | disk),**1** ESXM |                                      |
| gr (4    |                           |                                      |
| |                          |         |                                      |
|                   | vCPU, 4GB RAM, 1 |                                      |
| 60 GB    |                           |                                      |
| |                          |         |                                      |
|                   | disk)            |                                      |
|          |                           |                                      |
| +--------------------------+-------- |                                      |
| ------------------+----------------- |                                      |
| ---------+                           |                                      |
| | Cloud                    | **Total |                                      |
|  resources        | **1**CloudMgr (4 |                                      |
|  vCPU, 6 |                           |                                      |
| |                          | require |                                      |
| d for HDM**       | GB RAM, 32 GB di |                                      |
| sk),\    |                           |                                      |
| |                          |         |                                      |
|                   |  **1** CloudCach |                                      |
| e (6     |                           |                                      |
| |                          | 10 vCPU |                                      |
| , 26 GB RAM, 64   | vCPU, 20 GB RAM, |                                      |
|  32 GB   |                           |                                      |
| |                          | GB disk |                                      |
| , 512 GB Cache    | disk, 512 GB cac |                                      |
| he)      |                           |                                      |
| +--------------------------+-------- |                                      |
| ------------------+----------------- |                                      |
| ---------+                           |                                      |
|                                      |                                      |
| Related document: For hardware       |                                      |
| requirements and system requirements |                                      |
| refer to the [VMware Hardware        |                                      |
| Compatibility List                   |                                      |
| (HCL).](https://www.vmware.com/resou |                                      |
| rces/compatibility/search.php)       |                                      |
+--------------------------------------+--------------------------------------+
| Cloud Requirements                   |                                      |
+--------------------------------------+--------------------------------------+
| Network connectivity between         |                                      |
| On-premises and Cloud                |                                      |
|                                      |                                      |
| -   Network Link: at least 1 Gbps    |                                      |
| -   Network Round Trip Time          |                                      |
|     Latencies: less than 30 ms       |                                      |
+--------------------------------------+--------------------------------------+

# Appendix B - Network Settings
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Network requirement during OVF deployment
-----------------------------------------

-   Provision one IP from each of these networks
-   Use this during OVF deployment.

  --------------------------------- ---- --------- ---------
  **Network**                       IP   Netmask   Gateway
  VM Network (Management Network)                  
  HDM\_Internal\_Network                           
  Uplink\_WAN\_Network                             
  ESXi\_Network                                    
  --------------------------------- ---- --------- ---------

The following information is required for installation:

  ------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Default gateway network   *Choose your desired default network from the list above. This will be the one that accesses the Internet.*
  NTP Server                
  Network DNS               
  Default gateway           *All traffic to the Internet and other subnets will be forwarded to this gateway. Leave blank if the default network is capable of routing to the Internet and all other subnets.*
  Network DNS Search Path   
  ------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Network requirement during on-premises deployment
-------------------------------------------------

Common settings for the gateway, subnet, DNS etc. Depending on your
network configuration, these settings may or may not be common across
each of the networks. If they are different, repeat the table for each
required netowrk.

  ----------------- ------------------------------ --
  **Subnet mask**   *255.255.0.0*                  
  **Gateway**       *192.168.10.1*                 
  **Domain**        *domain.lan*                   
  **DNS**           *192.168.5.20, 192.168.5.21*   
  **NTP**           *192.168.5.22*                 
  ----------------- ------------------------------ --

**HDM\_Internal\_Network**

Provision six IPs on the respective network. Complete the table below
for use in the deployment phase.

  -------------- ------------------------------------------------- ----------------------
                 **Example**                                       **Fill value here**
  **IP range**   *192.168.10.100-192.168.10.120, 192.168.10.130*   **(2 IPs required)**
  -------------- ------------------------------------------------- ----------------------

  ----------------- ------------------------------ --
  **Subnet mask**   *255.255.0.0*                  
  **Gateway**       *192.168.10.1*                 
  **Domain**        *domain.lan*                   
  **DNS**           *192.168.5.20, 192.168.5.21*   
  **NTP**           *192.168.5.22*                 
  ----------------- ------------------------------ --

**\
 Uplink\_WAN\_Network**

  -------------- ------------------------------------------------- ----------------------
                 **Example**                                       **Fill value here**
  **IP range**   *192.168.10.100-192.168.10.120, 192.168.10.130*   **(2 IPs required)**
  -------------- ------------------------------------------------- ----------------------

  ----------------- ------------------------------ --
  **Subnet mask**   *255.255.0.0*                  
  **Gateway**       *192.168.10.1*                 
  **Domain**        *domain.lan*                   
  **DNS**           *192.168.5.20, 192.168.5.21*   
  **NTP**           *192.168.5.22*                 
  ----------------- ------------------------------ --

  ----------------- ------------------------------ --
  **Subnet mask**   *255.255.0.0*                  
  **Gateway**       *192.168.10.1*                 
  **Domain**        *domain.lan*                   
  **DNS**           *192.168.5.20, 192.168.5.21*   
  **NTP**           *192.168.5.22*                 
  ----------------- ------------------------------ --

**ESXi\_Network**

  -------------- ------------------------------------------------- ----------------------
                 **Example**                                       **Fill value here**
  **IP range**   *192.168.10.100-192.168.10.120, 192.168.10.130*   **(2 IPs required)**
  -------------- ------------------------------------------------- ----------------------

  ----------------- ------------------------------ --
  **Subnet mask**   *255.255.0.0*                  
  **Gateway**       *192.168.10.1*                 
  **Domain**        *domain.lan*                   
  **DNS**           *192.168.5.20, 192.168.5.21*   
  **NTP**           *192.168.5.22*                 
  ----------------- ------------------------------ --

Network requirements during cloud deployment
--------------------------------------------

The following credentials and FQDN are required for the cloud vCenter.

  ---------------------------- --
  **Cloud vCenter FQDN**       
  **Cloud vCenter username**   
  **Cloud vCenter password**   
  ---------------------------- --

Common settings for the gateway, subnet, DNS etc., which will be common
across the cloud networks.

  ----------------- ------------------------------ --
  **Subnet mask**   *255.255.0.0*                  
  **Gateway**       *192.168.10.1*                 
  **Domain**        *domain.lan*                   
  **DNS**           *192.168.5.20, 192.168.5.21*   
  **NTP**           *192.168.5.22*                 
  ----------------- ------------------------------ --

Similar to the previous two deployment stages, provision IPs and
identify the correct networks to satisfy the chosen connectivity
requirements. The networks to be configured are *HDM Internal network*
and *WAN network configuration* from the cloud
*hdm\_wan\_network***.**Only the IP Range is different between the two
networks; all other parameters remain the same.

**HDM Internal network**

  -------------- ------------------------------------------------- ------------------------
                 **Example**                                       **Fill value here**
  **IP range**   *192.168.10.100-192.168.10.120, 192.168.10.130*   **( At least 2O IPs)**
  -------------- ------------------------------------------------- ------------------------

**WAN network configuration**

  -------------- ------------------------------------------------- ---------------------
                 **Example**                                       **Fill value here**
  **IP range**   *192.168.10.100-192.168.10.120, 192.168.10.130*   **(2 IPs)**
  -------------- ------------------------------------------------- ---------------------

# Appendix C - IPSec tunnel, firewall, and cloud network configuration
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Requirements to deploy HDM:

1.  IPSec connectivity between on-premises and the vCD endpoint
2.  Firewall rules configured to enable required traffic
3.  Network configured correctly on the cloud side

Each of the above steps are discussed in detail in HDM 2.1 – Network
Configuration – Planning – VCS.

Be sure to configure the cloud network as shown in the diagram in [Step
3: Network Planning and
Mapping](https://www.primaryio.com/xdocs/hdm-2-1-quick-start-guide-ibm-vcs-test-multi-network-standard-standalone/#post-3364-_Step_3:_Network).

**Firewall configuration in the cloud**

The following firewall configuration is recommended for all on-premises
and cloud endpoints:

-   Source: source subnet
-   Destination: destination subnet
-   Service: any

Version 1.0.0

Copyright © 2020 PrimaryIO
