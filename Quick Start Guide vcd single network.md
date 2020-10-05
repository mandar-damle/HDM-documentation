# About This Guide

This quick start guide is intended to help you rapidly deploy PrimaryIO HDM to a test environment. The steps are intended for a single on-premises network environment, with cloud access via a WAN link and no separation of the management and VM network. All IP assignments in this guide are static/static-pool and connectivity between the on-premises and cloud environments is via IPSec. For other types of network configurations, refer to the HDM 2.1 Install Guide.

HDM provides a flexible deployment model to cater to a wide range of user needs, including different use cases, performance requirements, scalability, and levels of security. The HDM 2.1 Install Guide contains full details of every deployment mode. For simplicity, this document describes an HDM deployment using the Standalone, Ultra-Lite option. This option supports all the key features of HDM and can also be used for cold migration and validation purposes.

The following steps are required to deploy HDM:

1. Review System Requirements (estimated time: 15 minutes)
1. Download PrimaryIO HDM (estimated time: 5 minutes – depending on Internet speed)
1. Network Planning & Mapping (estimated time: 20 minutes)
1. Deploy the HDM Appliance (estimated time: 5 minutes)
1. Validate the Network Configuration (estimated time: 5 minutes)
1. On-premises Deployment (estimated time: 10 minutes)
1. Cloud Deployment (estimated time: 45-60 minutes)
1. Perform a Cold Migration (estimated time: dependent on VM size)

# Step 1: Review System Requirements

Refer to the System Requirements in Appendix A of this document. Printing a copy of Appendix A to use as a checklist is recommended.

# Step 2: Download PrimaryIO HDM
To obtain your license and download link for HDM, visit https://www.primaryio.com/ibm/

 

You will receive an email with the following:

* A link to download the PrimaryIO HDM software
* A link to training videos
* A license key for the software
 

Before proceeding with the installation, watch the training videos and use this guide.


# Step 3: Network Planning and Mapping
Network configuration information is required at key points throughout the deployment process. So, develop a network connectivity plan prior to deploying HDM. This section will help guide you through that process. The information captured in this section will be employed later in the installation process. If an IPSec tunnel and cloud configuration have not yet been established, these must be done before moving any further. Follow the steps outlined in Appendix C of this document. Please be aware that this process will add 30 minutes to the estimated time to complete this section.

Once connectivity and cloud configuration are complete, be sure to record all applicable details in Appendix B of this document for easy reference later in the deployment process.

The following is required to complete the network plan:

1. IPSec tunnel, firewall, and cloud network configuration information (See Appendix C)
1. Network requirements during OVF deployment
1. Network requirements during on-premises deployment
1. Network requirements during cloud deployment

**Choose or Create an appropriate network:**

A simple network configuration where all connectivity to the cloud is available through one network (e.g., hdm_network). Here hdm_network should have access to the following:

* On-premises vCenter
* Cloud vCenter via WAN link
* On-premises ESXi
* Cloud ESXi
* HDM Appliance

The required connectivity is highlighted in figure 1. For all steps in the deployment that require a VMware network as input, provide the identified or created hdm_network. It will also be necessary to create two networks in the cloud, hdm_routed_network and hdm_internal.

**Failure to create, choose, or configure the networks correctly will cause the installation to fail.**

 

Figure 1: Network Configuration of the Test Environment
 

The remainder of this document will assume you have created a network topology like the one shown in Figure 1, and will refer to the networks by those names. In this configuration, all access has been made possible using single VM network, hdm_network. Four static IPs will need to be provisioned on this network for OVF deployment.

 

Figure 1: Network Configuration of the Test Environment

[Image source](https://docs.google.com/drawings/d/1b5R6pmcL_TfTPkdaWITcJj6EyS5SKeA5bb_U743D9Yk/edit)
![](https://github.com/CacheboxInc/HDM-documentation/blob/master/Single%20Network%20VCS.svg)

You will need to provision

* 20 static IPs on Premise network
* At least 50 static-pool IPs on Cloud network
These will be required throughout the installation process.

 

**NOTE:**

1. Despite the fact that you will be mapping to a single network, separate IP ranges will need to be provided for each network type.
1. The subnet range 172.17.0.0/16 is not available for the deployment; it is used internally by HDM microservices.
1. Please add the vCenter FQDN for the on-premises and cloud vCenters on the on-premises and cloud DNS servers.

 

Before continuing with the rest of this Quick Start Guide, be sure to print [Appendix B – Network Settings]() and complete the forms. This will help you identify the correct networks to configure and identify all networking details.

# Step 4: Deploy the HDM Appliance

* Make sure you have at least 10GB free space to download the appliance
* Unzip the file 1.zip from the download link
* Deploy the appliance using the vCenter UI
* Perform the step as directed by the UI.
* Select hdm_network as the destination for all networks.
* Please refer to the “Network Configuration for the Appliance” section in the HDM Installation Guide for details on the network configuration.

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/OVF-deploy.png)

* Complete the network properties as captured in Appendix B – Network Settings
* Be sure to enter “Default Gateway” the IP address of the default gateway of the network.
* Power the appliance on after deploying it

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/OVF-deploy.png)

# Step 5: Validate the Network Configuration

* All ESXi servers in vCenter should be connected

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/Validate-network-1.png)

* The ESXi server must be able to communicate with vCenter. Test this using the ping command from the ESXi server to the vCenter FQDN (or IP)

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/Validate-network-2.png)

* Check to ensure the appliance is powered on
ssh to the HDM appliance that was deployed in step 4. Use the IP given on the “VM Network” (Management Network)
* Use the following credentials:
  * UID: root
  * Password: admin@123
* Use this session to validate connectivity

**Use the following commands to test connectivity between the endpoints:**
```
$ curl -k https://<prem_vcenter_fqdn>

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>

:

:

</body>

</html>
```
 

If the system states, curl: (7) Failed to connect to 10.10.48.2 port 443: Connection refused, the connectivity needs to be debugged.

 
```
$ curl -k https://<cloud_vcenter_fqdn>

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>

:

:

</body>

</html>
 ```

Ping the on-premises ESXi to verify connectivity.

 
```
$ curl -k https://<on_prem_esxi_ip>

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
```
 
# Step 6: On-Premises Deployment

## Add on-premises vCenter
* Locate the IP address of the appliance
* Enter https://<appliance-ip> in the appliance web interface
* Login to the appliance web UI using default password: admin@123

After login, select ![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/vCenter-icon.png)

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/add-vcenter-01.png)

* Enter the vCenter credentials
* Select Add

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/add-vcenter-02.png)

* Register the vCenter plugin by selecting Register

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/add-vcenter-03.png)

vCenter configuration is now complete. Log into the newly-configured vCenter.

**Note**
For the plugin to be visible within vCenter, you will need to logout/login to the vCenter at least twice
 
## Configure the License

Navigate to the Licensing page on the HDM vCenter Plugin

* HDM plugin can be accessed directly via the Menu
* It can take approximately five minutes to load HDM the first time it is accessed
* On the Licensing tab, select Add License
* Add the license key received by mail

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/Licensing-01.png)

## Configure the On-premises vCenter

* Select Administration, then Configuration
* Choose the cluster where you want to install vCenter
* Select Install

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/config-on-prem-01.png)

* For vCD, choose:
  * Resource: Ultra-Lite
  * Deployment: Cluster or Standalone
* Only choose these options (this guide is only tailored to this configuration)

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/config-on-prem-02.png)

* Complete all steps to begin the deployment
* Complete the configuration details using the information you recorded in Appendix B – Network Settings
* For additional details, refer to the “Deploy HDM On-premises” section in the HDM 2.1 Installation Guide
* This step will take a few minutes to complete. Progress will be shown on the vCenter task bar.

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/config-on-prem-03.png)

# Step 7: Cloud Deployment

## Cloud Static-Pool allocation

* Allocate static-pool IPs for hdm_internal and hdm_routed_network
* The procedure is detailed in document “HDM 2.1 Quick Start Guide – VCD – Single Network”
* Allocated 20 IPs on hdm_internal
* Allocate 30 IPs on hdm_routed_network
* Data in is used to assign these static ranges

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-static-pool.png)

## Configure Cloud vCenter

* Select Clouds, then Add Cloud
* The cloud configuration wizard will pop-up automatically

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-01.png)

* Choose vCloud Director
* Enter vCD credentials
* Select Add
* Please note, it will take approximately 5 minutes to configure vCD and move to the next screen

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-02.png)

* Choose vApp to deploy HDM cloud components
* Choose the highest performance for rapid transfer

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-03.png)

* For Parts 1 and 2, choose Static Pool

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-04.png)

## WAN Routing Configuration

The following WAN routes are required to gain access between the cloud and on-premises environments:

* On-premises WAN route: The route that is set on the on-premises HDM appliance. The routes enable communication from on-premises to cloud HDM appliances.
  * Cloud WAN subnet: Location of the deployed HDM appliances
  * On-premises WAN gateway: Enables access to the cloud WAN subnet
* On-premises WAN route: The route that is set on the HDM appliance in the cloud. The routes enable communication from the cloud to on-premises HDM appliances.
  * On-premises WAN subnet: Location of the deployed HDM appliances
  * Cloud WAN gateway: Enables access to on-premises WAN subnet
 

* Complete with the correct routes for the chosen configuration

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-05.png)

* Use the configuration information recorded in Appendix B
* Map on-premises to the cloud network to enable application connectivity
* Depending on the chosen configuration and uplink speed, this step may require up to an hour to complete

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-06.png)

* To ensure the deployment has been successful, select HDM from the Menu, followed by the Administration, HDM Health, and Component Health tabs
* Check the status. If it is green, it is ready to begin migration

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/cloud-deploy-07.png)

# Step 8: Perform a Cold Migration

During cold migration, the VM being migrated is powered off. After the migration has been completed on the cloud, the VM can be powered back on.


**NOTES:**

1. Migrations will be successful for VMs where network and disk interfaces are accessible to HDM via VMware APIs.
1. If network or disk interfaces are added dynamically, the virtual machine will need to be powered down to allow the newly added network and disk interface information to become available to HDM via VMware APIs.
1. Before migration is triggered, ensure that the health of the HDM components is green.

* Right-click on the VM
* Select Migrate
* The migration wizard will pop-up automatically

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/Migrate-1.png)

* Complete all steps

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/Migrate-2.png)

* The migration status will be displayed in the wizard, as well as in vCenter tasks
* Following successful migration, the VM will be ready for use in the cloud
* To migrate multiple VMs and the HDM dashboard, please refer to the HDM 2.1 Admin Guide

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/Migrate-3.png)

# Appendix A - System Requirements

**Requirements** | **Available Y/N**
--|--
On-premises Requirements	|
VMWare Environment	|
Single version of ESX throughout the vCenter cluster	|
ESX in connected state in the vCenter	|
ESX able to communicate with vCenter	|
Clusters have ESX 6.5U2+ and 6.7|
vCenter Web Client: 6.5 or 6.7 (Use of HTML client is recommended with Chrome v.75 +) |
Datastore should be VMFS, NFS, or NFSv3	|
E1000E and VMXNet3 network adapters should be available in the on-premises vCenter	|
DRS is enabled and HA should be enabled on the vCenter cluster|
**Network Environment** |	
Network speed: at least 1 Gbps (10 Gbps link is preferred)	|
VM Network has connectivity to the cloud endpoint	|
VM Network has access to ESXi|
**Hardware Requirements** |
On-premises	Total resources required for HDM 11 vCPU, 16 GB RAM, 336 GB disk |
1 Appliance (4 vCPU, 8 GB RAM, 144 GB disk),|
1 PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),1 ESXMgr (4 vCPU, 4GB RAM, 160 GB disk) |
Cloud	Total resources required for HDM equivalent to 10 vCPU, 26 GB RAM, 64 GB disk, 512 GB Cache|
1 CloudMgr (4 vCPU, 6 GB RAM, 32 GB disk), |
1 CloudCache (6 vCPU, 20 GB RAM, 32 GB disk, 512 GB cache) |
**Cloud Requirements** |
Network connectivity between on-premises and cloud environments|
* Network Link: at least 1 Gbps|
* Network Round Trip Time Latencies: less than 30 ms|

Related document: For hardware and system requirements, refer to the VMware Hardware Compatibility List (HCL).
# Appendix B - Network Settings
## Network requirements during OVF deployment
* Provision four IPs on hdm_network
* Use this during OVF deployment

Network | IP | Netmask |  Gateway
--------|----|---------|------
VM Network (Management Network)| *Single IP* | |
HDM_Internal_Network | *Single IP* ||
Uplink_WAN_Network | *Single IP* ||
ESXi_Network | *Single IP* ||

Common settings for the OVF deployment

Default gateway network|*This should be the single configured network on-premises which in this document is “hdm_network”*
-----------------------|-----------------------
NTP Server|
Network DNS|
Default gateway|*Provide default gateway for the “hdm_network”*
Network DNS Search Path	|

## Network requirements during on-premises deployment

Common settings for the gateway, subnet, DNS etc., which will be common across the on-premises networks.

Subnet mask	| *255.255.0.0*
-|-
Gateway	| *192.168.10.1*	
Domain	| *domain.lan*	
DNS	| *192.168.5.20, 192.168.5.21*	
NTP	| *192.168.5.22*	

## HDM_Internal_Network

Provision six IPs on hdm_network. complete the table below for reference throughout deployment.

Entry |**Example**	|**Fill value here**
-|-|-
IP range	| *192.168.10.100-192.168.10.120, 192.168.10.130	(2 IPs required from “hdm_network” )*

## Uplink_WAN_Network

Entry |**Example**	|**Fill value here**
-|-|-
IP range	| *192.168.10.100-192.168.10.120, 192.168.10.130	(2 IPs required from “hdm_network” )*

## ESXi_Network
Entry |**Example**	|**Fill value here**
-|-|-
IP range	| *192.168.10.100-192.168.10.120, 192.168.10.130	(2 IPs required from “hdm_network” )*

## Network requirements during cloud deployment
The following cloud credentials are required to deploy to the cloud.

vCloud Director FQDN	|xyzpqr25.vmware-solutions.cloud.ibm.com
-|-
Organization name	|
Username	|
Password	|

Similar to the previous two deployment stages, provision IPs and identify the correct networks to satisfy the chosen connectivity requirements. The networks to be configured are HDM Internal network and WAN network configuration from the cloud hdm_wan_network. Only the IP Range is different between the two networks; all other parameters remain the same.

**HDM Internal network**


Entry |**Example**	|**Fill value here**
-|-|-
IP range|	192.168.10.100-192.168.10.120, 192.168.10.130	(20 IPs from HDM “hdm_internal)|
Subnet mask|	255.255.0.0	|
Gateway	|192.168.10.1	|
Domain	|domain.lan|	
DNS	|192.168.5.20, 192.168.5.21	|
NTP	|192.168.5.22	|

**WAN network configuration**

IP range|192.168.10.100-192.168.10.120, 192.168.10.130	(20 IPs from HDM “hdm_wan_network")|
-|-|-
Subnet mask|	255.255.0.0	|
Gateway	|192.168.10.1	|
Domain	|domain.lan|	
DNS	|192.168.5.20, 192.168.5.21	|
NTP	|192.168.5.22	|

# Appendix C - IPSec Configuration

Requirements to deploy HDM:

1. IPSec connectivity between on-premises and the vCD endpoint
1. Firewall rules configured to enable required traffic
1. Network configured correctly on the cloud side
 
Each of the above steps are discussed in detail in the HDM 2.1 – Org VDC System and Network Configuration.

 

Be sure to configure the cloud network as shown in the diagram in Step 3: Network Planning and Mapping.

**Firewall configuration in the cloud**

**NOTE:** The following firewall configuration is recommended for all on-premises and cloud endpoints:

* Source: source subnet
* Destination: destination subnet
* Service: any

![](https://github.com/CacheboxInc/HDM-documentation/blob/master/images/firewall.png)


