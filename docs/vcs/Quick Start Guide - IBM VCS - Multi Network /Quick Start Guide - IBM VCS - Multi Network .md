<!-- Copy and paste the converted output. -->





# **HDM 2.1 Quick Start Guide for IBM VCS**


# **Multi-Network Configuration**

## 


# About this Guide

This quick start guide is for quick deployment to test the HDM product. The steps are for an environment having a on-premise multi-network with separation of management and VM networks. All IP assignments are static in this guide. Also connectivity between on-premise and on-cloud is with an IPSec. For other types of network configurations, refer to the HDM install guide. 

HDM provides a very flexible deployment model providing options for catering to different user needs in terms of use case, performance, scalability and security. The HDM install guide has full details of all deployment modes. For simplicity this document will refer to HDM deployment in **_Standard-Standalone_** mode. This mode supports all the key features of HDM and can also be used for Cold Migration and validation purposes. 

 Following steps are required for deployment of HDM 



1. Review System Requirements - 15 minutes
2. Download PrimaryIO HDM - 10 minutes (depending on internet speed)
3. Network Planning & Mapping - 20 minutes
4. Validating Network Configuration - 5 minutes
5. Deploy PIO Appliance - 5 minutes
6. On-Prem Deployment - 10 minutes 
7. On-Cloud Deployment - 45 to 60 minutes
8. Migrating a VM to cloud - dependent on VM size


# Step 1/8 : Review System Requirements


```
Estimated time 15 minutes
```


Refer to the [Appendix A - System Requirements](#appendix-a) of this document. Request you to print a copy of [Appendix A ](#appendix-a). 


# Step 2/8 : Downloading PrimaryIO HDM


```
Estimated time 10 minutes
```


Thank you for deciding to use PrimaryIO HDM. To get your license and download link for HDM, click on the link below.

[https://www.primaryio.com/ibm/](https://www.primaryio.com/ibm/)

You will receive an email with 



*   A link to download the PrimaryIO HDM software
*   A link to training videos [https://www.primaryio.com/training/](https://www.primaryio.com/training/)
*   The license key for the software

To proceed with the installation, you should watch the training videos and use this guide to proceed with the installation.


# Step 3/8 : Network Planning & Mapping


```
Estimated time 20 minutes
```


Prior to HDM deployment, we need to understand and plan the network connectivity. This section will help plan the network settings. Network configuration information is required at a few points in the deployment process. The information captured in this section will be used in the later sections of the installation.  If you don’t have IPSec tunnel and cloud configured this is the very first thing you would need to do. Please refer to [Appendix C](#appendix-c) at the end of this document, this will add another 30 minutes to the time in this section. After the connectivity and cloud is setup please go through this section and then use the pages from [Appendix B](#appendix-b) to capture network details. These will be required in the subsequent deployment process. 

This section will guide you through the steps required to setup the network - 

1. IPSec tunnel, firewall and Cloud network configuration (Refer [ Appendix C](#appendix-c))
2. Network requirements during OVF deployment
3. Network requirements during on-premise deployment
4. Network requirements during on-cloud deployment

    ```
Choose or Create appropriate network:

Configuring and choosing the correct network for deployment is essential to the proper functioning of the HDM product.

Please choose or configure the networks so that the required connectivity for the specific network is satisfied.

ESXi_Network:
Network over which the ESXi part of the cluster is reachable.

VM_Network/Management Network:
The network over which the vCenters and the management networks are configured. You might have both the ESXi and vCenters configured over the same network in which case the both the ESXi_Network and VM_Network are the same.

HDM_Internal_Network:
The HDM internal network is used to connect the HDM components for their private communication.

Uplink WAN Network:
The network over which the on-premise components can communicate with the cloud components.

Failure to create or choose or configure the networks correctly will result in failure of the installation below.

We have to either identify a network which satisfies the above property or you have to **create** a network with connectivity to the above elements. 

Figure 1: Network Configuration of the Test Environment
![alt_text](images/image9.png "image_tooltip")

For the rest of this document we will assume you have created a network topology depicted in the diagram above. For simplicity we refer to the networks as named in the diagram. However if you choose to name the networks differently just substitute the name of your network for the one above. 


```
Note:  
The subnet range 172.17.0.0/16 is not available for the deployment; it is internally used by HDM microservices.
Please add vCenter FQDN both premise and cloud vCenter on both premise and cloud DNS server.
```


Please print the [Appendix B](#appendix-b) and fill in the forms in the appendix. This will allow you to identify the correct networks to configure and identify the other networking details.


# Step 4/8 : Deploy PIO Appliance


```
Estimated time 5 minutes
```


*   Make sure you have at least 10GB free space to download the appliance.
*   Unzip the file HDM_2.1.zip from the download link
*   Deploy the appliance using the vCenter UI 

**Note :**



*   PIO Appliance should be deployed on the same vCenter and datacenter which it would be managing. 
*   HDM components should be deployed on Shared Datastore. Disks can be thin provisioned. 

<table>
  <tr>
   <td>

<img src="images/image1.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Perform the step as directed by the UI.

<li>Fill in this screen we data captured in [Appendix B](#appendix-b)

<li>Please refer to the HDM Installation Guide section “Network Configuration for the Appliance” for details on the network configuration.

<li>Please poweron the appliance  after deploying it.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image4.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Choose the “Default gateway network” as “WAN”.

<li>Fill in the network properties as captured in Appendix B

<li><strong>Please make sure you select the correct default gateway interface and in the field “Default Gateway” provide the IP address of the “WAN” gateway . Cloud VC should be accessible from an appliance with default gateway.</strong>
</li>
</ul>
   </td>
  </tr>
</table>



# Step 5/8 : Validate Network Configuration


```
Estimated time 10 minutes
```



<table>
  <tr>
   <td>
    <img src="images/image12.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>All ESXi in the vCenter should be in connected state
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>
    <img src="images/image15.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>The ESXi should be able to communicate with the vCenter. Simple ping command from ESXi server to vCenter FQDN (or IP)  will ensure that
</li>
</ul>
   </td>
  </tr>
</table>





# Step 6/8 : On-Prem Deployment


```
Estimated time 10 minutes
```



## Add On-Prem vCenter



*   Power On the appliance
*   Find the appliance IP
*   Open the appliance web interface for https://&lt;appliance-ip>
*   Login to the appliance web UI using default password 2Hdm$aK!N@h!
*   After login in click on ![alt_text](images/image11.png "image_tooltip")

<table>
  <tr>
   <td>

<img src="images/image14.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Click on Add vCenter
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="images/image13.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Provide the vCenter credentials

<li>“Add” to add vCenter

<li>Fill in this screen we data captured in [Appendix B]
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image18.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>Register the vCenter plugin by clicking the “Register button”.
   </td>
  </tr>
</table>


At this point configuration of the vCenter is complete. Login to the vCenter you have just configured.


```
Note:
For the plugin to be visible within vCenter you will need to logout/login to the vCenter at least 2 times.
```



## Configure License

Navigate to the Licensing page on the HDM vCenter Plugin


<table>
  <tr>
   <td>

<img src="images/image16.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>HDM plugin can be reached via Menu->HDM

<li>The first time you navigate to HDM it can take about 5 minutes to load

<li>On the Licensing Tab click “Add License”

<li>Add the license key received by mail.
</li>
</ul>
   </td>
  </tr>
</table>



## Configure On-prem vCenter


<table>
  <tr>
   <td>

<img src="images/image17.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Click on Administration -> Configuration

<li>Choose the cluster we want to install on

<li>Click “Install”
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="images/image19.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Resource:- Standard

<li>Deployment:- Standalone

<li><strong>Only Choose these options, this guide is tailored to this config only</strong>
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image20.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Complete all the steps to start the deployment.

<li>Refer details captured in [Appendix B] to fill these screens.

<li>For further details refer to the HDM Installation Guide section “Deploy HDM On Premise”.

<li>This step will take a few minutes to complete. The progress will be shown on the vCenter task bar.
</li>
</ul>
   </td>
  </tr>
</table>



# Step 7/8 : On-Cloud Deployment


```
Estimated time 45 to 60 minutes
```



## Configure On-Cloud vCenter


<table>
  <tr>
   <td>

<img src="images/image21.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Select “Clouds”

<li>Followed by  “Add Cloud” 

<li>The Wizard to configure the cloud will pop-up.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image22.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Choose IBM Cloud on VMware Solutions Dedicated

<li>Add the required details
</li>
</ul>
   </td>
  </tr>
</table>



### WAN Routing Configuration

The following WAN routes are required to gain access between the cloud and on-premises environments:



*   **Onprem WAN network details: **The route that is set on the on-premises HDM appliance. The routes enable communication from on-premises to cloud HDM appliances.
    *   **Onprem WAN subnet(s): **Location of the deployed HDM appliances
    *   **Onprem WAN gateway: **Enables access to the cloud WAN subnet
*   **Oncloud WAN network details: **The route that is set on the HDM appliance in the cloud. The routes enable communication from the cloud to on-premises HDM appliances.
    *   **Oncloud WAN subnet(s): **Location of the deployed HDM appliances
    *   **Oncloud WAN gateway: **Enables access to on-premises WAN subnet

<table>
  <tr>
   <td>

<img src="images/image25.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Use the Network configuration captured in [Appendix B] to fill part 1&2

<li>Please fill the <strong>Network Configuration - Part 3</strong> correctly.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="images/image23.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Fill in this screen we data captured in [Appendix B]

<li>Please map the premise to the cloud network correctly for applications to have proper connectivity.

<li>This step might take an hour depending on the uplink speed.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="images/image8.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>To ensure that the deployment is successful, click HDM->Administration->HDM Health -> Component Health

<li>Compare the status, if it is green, the setup is ready to start migration 
</li>
</ul>
   </td>
  </tr>
</table>



# Step 8/8 : Perform Cold Migration

During the cold migration, the VM that is being migrated is powered off. After the migration is complete on the cloud, the VM can be powered on.


```
Note:
Migrations will be successful for VMs where network and disk interfaces are accessible to HDM via VMware APIs. In case network or disk interfaces are added dynamically, the virtual machine needs to be powered down so that information about the newly added network and disk interface are available via VMware APIs to HDM. 
Before migration is triggered, ensure that the health of HDM componentes is green.
```


 


<table>
  <tr>
   <td>


<img src="images/image3.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Right click on the VM 

<li>Select Migrate option

<li>The migration wizard     
             appears
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image6.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Complete all the steps 
</li>
</ul>
   </td>
  </tr>
</table>


          


<table>
  <tr>
   <td>


<img src="images/image2.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>The status of the migration will be shown in the wizard.

<li>The status of the migration will also be displayed on the vCenter tasks.

<li>After successful migration, the VM is ready for use on the cloud. 

<li>To migrate multiple VMs and the HDM dashboard please refer to the “ HDM Admin Guide”.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>
   </td>
   <td>.
   </td>
  </tr>
</table>


  




# <a name="appendix-a"> Appendix A - System Requirements</a>


<table>
  <tr>
   <td><strong>Requirement</strong>
   </td>
   <td><strong>Available (Yes / No)</strong>
   </td>
  </tr>
  <tr>
   <td>On-Premise Requirements
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>VMWare Environment
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>vCenter Web Client: 6.5 or 6.7 
<p>
(Use of HTML client is recommended with Chrome v.75 +)
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Single version of ESXi throughout the vCenter cluster. Versions supported : ESXi 6.5U2+, 6.7 are supported
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>ESXi in connected state in the vCenter
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>ESXi can communicate with vCenter
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Datastore should be one of: VMFS, NFS, NFSv3
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>E1000E and VMXNet3 network adapters should be available in On-Premise vCenter.
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>DRS is enabled and HA should be enabled (only if there are more than one ESXi) on the vCenter cluster 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Network Environment
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Network speed >= 1 Gbps
<p>
10 Gbps link is preferred. Anything > 1 Gbps would work
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>VM Network should have connectivity to On-Cloud endpoint 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>VM Network should have access to ESXi, VCenter
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Hardware Requirements
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>

<table>
  <tr>
   <td>On-Premise
   </td>
   <td><strong>Total resources required for HDM</strong>
<p>
11 vCPU, 16 GB RAM, 336 GB disk
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk), \
<strong>1</strong> PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),
<p>
<strong>1</strong> ESXMgr (4 vCPU, 4GB RAM, 160 GB disk)
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>Total resources required for HDM</strong>
<p>
10 vCPU, 26 GB RAM, 64 GB disk, 512 GB Cache
   </td>
   <td><strong>1 </strong>CloudMgr (4 vCPU, 6 GB RAM, 32 GB disk), \
<strong>1</strong> CloudCache (6 vCPU, 20 GB RAM, 32 GB disk, 512 GB cache)
   </td>
  </tr>
</table>


Related document: For hardware requirements and system requirements refer to the [VMware Hardware Compatibility List (HCL).](https://www.vmware.com/resources/compatibility/search.php)

   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>On-Cloud Requirements

   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Network connectivity between On-Premise and On-Cloud



*   Network Link >= 1 Gbps
*   Network Round Trip Time Latencies: &lt; 30 ms
   </td>
   <td>
   </td>
  </tr>
</table>



<p style="text-align: right">

# 


# <a name="appendix-b">Appendix B - Network Settings</a>


## Network requirement during OVF deployment



*   Provision  1 IPs from each of these networks
*   Use this during OVF deployment.

<table>
  <tr>
   <td>
<strong>Network</strong>
   </td>
   <td>IP 
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>VM Network (Management Network)
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>HDM_Internal_Network
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Uplink_WAN_Network
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>ESXi_Network
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>


The following information below is a required part of the installation. Please capture the information accordingly.


<table>
  <tr>
   <td>Default gateway network
   </td>
   <td><em>Choose the network from the above networks which you want to set as your default network. This should be the one through which we can access the internet.</em>
   </td>
  </tr>
  <tr>
   <td>NTP Server
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Network DNS
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Default gateway
   </td>
   <td><em>All traffic to the internet and other subnets will be forwarded to this gateway. Leave blank if  the default network is capable of routing to the internet and all other subnets.</em>
   </td>
  </tr>
  <tr>
   <td>Network DNS Search Path
   </td>
   <td>
   </td>
  </tr>
</table>



## Network requirement during on-premise deployment

Common setting of gateway, subnet, DNS etc. Depending on your network configuration this may be common across the networks you need configure or different for each of the networks. If they are different the table has to be repeated for each of the need works.


<table>
  <tr>
   <td><strong>Subnet mask</strong>
   </td>
   <td><em>255.255.0.0</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Gateway</strong>
   </td>
   <td><em>192.168.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Domain</strong>
   </td>
   <td><em>domain.lan</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>DNS</strong>
   </td>
   <td><em>192.168.5.20, 192.168.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>192.168.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>


**HDM_Internal_Network**

You need to provision a total of 6 IPs on the respective network. Fill in the table below for use in the deployment phase.


<table>
  <tr>
   <td>
   </td>
   <td><strong>Example</strong>
   </td>
   <td><strong>Fill value here</strong>
   </td>
  </tr>
  <tr>
   <td><strong>IP range</strong>
   </td>
   <td><em>192.168.10.100-192.168.10.120,  192.168.10.130 </em>
   </td>
   <td><strong>(2 IPs required)</strong>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td><strong>Subnet mask</strong>
   </td>
   <td><em>255.255.0.0</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Gateway</strong>
   </td>
   <td><em>192.168.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Domain</strong>
   </td>
   <td><em>domain.lan</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>DNS</strong>
   </td>
   <td><em>192.168.5.20, 192.168.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>192.168.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>


** \
Uplink_WAN_Network**


<table>
  <tr>
   <td>
   </td>
   <td><strong>Example</strong>
   </td>
   <td><strong>Fill value here</strong>
   </td>
  </tr>
  <tr>
   <td><strong>IP range</strong>
   </td>
   <td><em>192.168.10.100-192.168.10.120,  192.168.10.130 </em>
   </td>
   <td><strong>(2 IPs required)</strong>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td><strong>Subnet mask</strong>
   </td>
   <td><em>255.255.0.0</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Gateway</strong>
   </td>
   <td><em>192.168.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Domain</strong>
   </td>
   <td><em>domain.lan</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>DNS</strong>
   </td>
   <td><em>192.168.5.20, 192.168.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>192.168.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td><strong>Subnet mask</strong>
   </td>
   <td><em>255.255.0.0</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Gateway</strong>
   </td>
   <td><em>192.168.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Domain</strong>
   </td>
   <td><em>domain.lan</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>DNS</strong>
   </td>
   <td><em>192.168.5.20, 192.168.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>192.168.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>


**ESXi_Network**


<table>
  <tr>
   <td>
   </td>
   <td><strong>Example</strong>
   </td>
   <td><strong>Fill value here</strong>
   </td>
  </tr>
  <tr>
   <td><strong>IP range</strong>
   </td>
   <td><em>192.168.10.100-192.168.10.120,  192.168.10.130 </em>
   </td>
   <td><strong>(2 IPs required)</strong>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td><strong>Subnet mask</strong>
   </td>
   <td><em>255.255.0.0</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Gateway</strong>
   </td>
   <td><em>192.168.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Domain</strong>
   </td>
   <td><em>domain.lan</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>DNS</strong>
   </td>
   <td><em>192.168.5.20, 192.168.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>192.168.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>



## Network requirement during on-cloud deployment

Credentials and fqdn for the cloud vCenter.


<table>
  <tr>
   <td><strong>Cloud vCenter FQDN</strong>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Cloud vCenter username</strong>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Cloud vCenter password</strong>
   </td>
   <td>
   </td>
  </tr>
</table>


Common setting of gateway, subnet, DNS etc.  which will be common across the on-cloud networks


<table>
  <tr>
   <td><strong>Subnet mask</strong>
   </td>
   <td><em>255.255.0.0</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Gateway</strong>
   </td>
   <td><em>192.168.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Domain</strong>
   </td>
   <td><em>domain.lan</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>DNS</strong>
   </td>
   <td><em>192.168.5.20, 192.168.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>192.168.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>


Similar to the previous two deployment stages we need to provision IPs and identify the correct networks that satisfy the connectivity requirements. The networks that need to be configured are.

The networks to be configured **HDM Internal network** and **WAN network configuration **from the on-cloud “hdm_wan_netwrok”**. **Only the **IP Range** is different between the two networks, the rest of the parameters are the same.

**HDM Internal network** 


<table>
  <tr>
   <td>
   </td>
   <td><strong>Example</strong>
   </td>
   <td><strong>Fill value here</strong>
   </td>
  </tr>
  <tr>
   <td><strong>IP range</strong>
   </td>
   <td><em>192.168.10.100-192.168.10.120,  192.168.10.130 </em>
   </td>
   <td><strong>( At least  2O IPs)</strong>
   </td>
  </tr>
</table>


**WAN network configuration**


<table>
  <tr>
   <td>
   </td>
   <td><strong>Example</strong>
   </td>
   <td><strong>Fill value here</strong>
   </td>
  </tr>
  <tr>
   <td><strong>IP range</strong>
   </td>
   <td><em>192.168.10.100-192.168.10.120,  192.168.10.130 </em>
   </td>
   <td><strong>(2 IPs)</strong>
   </td>
  </tr>
</table>


<p style="text-align: right">



# <a name="appendix-c">Appendix C - IPSec tunnel, firewall and Cloud network configuration</a>

To deploy the HDM product you need to have 



1. IPSec connectivity between the premise and the cloud.
2. Firewall rules setup to allow required traffic
3. Network configured correctly on the cloud side.

All these three steps are explained in detail in the following “**HDM 2.1 - Network Configuration - Planning - VCS**”.  Please make sure of the following



*   Configure the cloud side network as depicted in the diagram in the 

[Step 3/8 : Network Planning & Mapping].

For easy configuration of the firewall rules we would recommend to have following Firewall configuration for all on-prem and on- cloud endpoints:



*   Source - source subnet.
*   Destination - Destination subnet
*   Service - Any
