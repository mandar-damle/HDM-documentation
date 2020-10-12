<!-- Copy and paste the converted output. -->

# 

# **HDM 2.1 Quick Start Guide for IBM VCS**


# **Single Network Configuration**

# About this Guide

This quick start guide is for quick deployment to test the HDM product. The steps are for an environment having NSX-V and a single on-premise network without separation of management and VM networks. Additionally the access to cloud via WAN link is also available over this network. All IP assignments are static in this guide. Also connectivity between on-premise and on-cloud is with an IPSec. For other types of network configurations, refer to the HDM install guide. 

HDM provides a very flexible deployment model providing options for catering to different user needs in terms of use case, performance, scalability and security. The HDM install guide has full details of all deployment modes. For simplicity this document will refer to HDM deployment in **_Standard-Standalone_** mode. This mode supports all the key features of HDM and can also be used for Cold Migration and validation purposes. 

 Following steps are required for deployment of HDM 



1. Review System Requirements - 15 minutes
2. Download PrimaryIO HDM - 5 minutes (depending on internet speed)
3. Network Planning & Mapping - 20 minutes
4. Validating Network Configuration - 5 minutes
5. Deploy PIO Appliance - 5 minutes
6. On-Prem Deployment - 10 minutes 
7. On-Cloud Deployment - 45 to 60 minutes
8. Migrating a VM to cloud - dependent on VM size


# Step 1/8 : Review System Requirements


```
Estimated time 10 minutes
```


Refer to the [System Requirements](#appendix-a) in Appendix A of this document. Request you to print a copy of [Appendix A ](#appendix-a)and check off that your infrastructure meets each of the requirements. 


# Step 2/8 : Downloading PrimaryIO HDM


```
Estimated time 5 minutes
```


Thank you for deciding to use PrimaryIO HDM. To get your license and download link for HDM, click on the link below.

[https://www.primaryio.com/ibm/](https://www.primaryio.com/ibm/)

You will receive an email with 



*   A link to download the PrimaryIO HDM software
*   A link to training videos [https://www.primaryio.com/training/](https://www.primaryio.com/training/)
*   The license key for the software

To proceed with the installation, you should watch the training videos and use this guide to proceed with the installation. 


#<a name="networkplanning">Step 3/8 : Network Planning & Mapping</a>


```
Estimated time 20 minutes
```


Prior to HDM deployment, we need to understand and plan the network connectivity. This section will help plan the network settings. Network configuration information is required at a few points in the deployment process. The information captured in this section will be used in the later sections of the installation. If you don’t have IPSec tunnel and cloud configured this is the very first thing you would need to do. Please refer to [Appendix C](#appendix-c) at the end of this document, this will add another 30 minutes to the time in this section. After the connectivity and cloud is setup please go through this section and then use the pages from [Appendix B](#appendix-b) to capture network details. These will be required in the subsequent deployment process. 

This section will guide you through the steps required to setup the network - 


1. IPSec tunnel, firewall and Cloud network configuration (Refer[ Appendix C](#appendix-c))
2. Network requirements during OVF deployment
3. Network requirements during on-premise deployment
4. Network requirements during on-cloud deployment

```
Choose or Create "hdm_network/hdm_wan_network":

A simple network configuration where all connectivity is available through one network, for example "hdm_network". 
Here the "hdm_network" should have access to.
vCenter on premise
Cloud vCenter via WAN link
Premise ESXi
Cloud ESXi
Appliance

The connectivity required is depicted in the diagram below. For all steps in the deployment where a vmware network 
is required as input please provide the identified or created "hdm_network" for premise and "hdm_wan_network" for networks on the cloud. 

Failure to create or choose "hdm_network / hdm_wan_network" correctly will result in failure of the installation below.

```
We have to either identify a network which satisfies the above property or you have to **create** a network with connectivity to the above elements. 

![alt_text](images/image3.png "image_tooltip")


For the rest of this document we will assume you have created a network topology depicted in the diagram above. For simplicity we refer to the networks as named in the diagram. However if you choose to name the networks differently just substitute the name of your network for the one above. In this configuration all access is possible through the single VM network for this example called “hdm_network / hdm_wan_network”. 

You will need to provision 



*   A range of 10 static IPs on Premise network on “hdm_network”
*   A minimum range of 22 static IPs on Cloud network on “hdm_wan_network”

These will be required in different parts of the installation process.


```
Note:  
Even though we are mapping to a single network, separate IP ranges will still need to be provided for each of the network types.
The subnet range 172.17.0.0/16 is not available for the deployment; it is internally used by HDM microservices.
Please add vCenter FQDN both premise and cloud vCenter on both premise and cloud DNS server.
```


Please print the [Appendix B - Network Settings](#appendix-b) and fill in the forms in the appendix. This will allow you to identify the correct networks to configure and identify the other networking details. Please complete the Appendix B and then continue with the rest of the guide.


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

<img src="images/image14.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Perform the step as directed by the UI.

<li>Select “hdm_network” as the destination for all networks.

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

<img src="images/image2.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Fill in the network properties as captured in [Appendix B]</li>


<li><strong>Please make sure you enter “Default Gateway” the IP address of the default gateway of the network.</strong>
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
<img src="images/image1.png" width="" alt="alt_text" title="image_tooltip">   
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
   <img src="images/image6.png" width="" alt="alt_text" title="image_tooltip">
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
*   After login in click on ![alt_text](images/image13.png "image_tooltip")


<table>
  <tr>
   <td>



<img src="images/image16.png" width="" alt="alt_text" title="image_tooltip">

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


<img src="images/image15.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Provide the vCenter credentials

<li>“Add” to add vCenter
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

<img src="images/image17.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="images/image19.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="images/image23.jpg" width="" alt="alt_text" title="image_tooltip">

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


<img src="images/image7.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Complete all the steps to start the deployment.

<li>Refer details captured in [Appendix B - Network Settings] to fill these screens.

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

<img src="images/image20.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="images/image10.jpg" width="" alt="alt_text" title="image_tooltip">

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



<table>
  <tr>
   <td>

<img src="images/image21.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Use the Network configuration captured in [Appendix B]



<li>Leave the Oncloud WAN route in <strong>Network Configuration - Part 3</strong> empty.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image22.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Use the Network configuration captured in [Appendix B]

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

<img src="images/image11.png" width="" alt="alt_text" title="image_tooltip">

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
Migrations will be successful for VMs where network and disk interfaces are accessible to HDM via VMware APIs. 
In case network or disk interfaces are added dynamically, the virtual machine needs to be powered down so that 
information about the newly added network and disk interface are available via VMware APIs to HDM. 
Before migration is triggered, ensure that the health of HDM componentes is green. 
```


 


<table>
  <tr>
   <td>

<img src="images/image9.jpg" width="" alt="alt_text" title="image_tooltip">

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

<img src="images/image5.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="images/image8.png" width="" alt="alt_text" title="image_tooltip">

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
<strong>

<p id="gdcalert29" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Back to Top"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert30">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

<a href="#heading=h.pj7rznux9t2f">Back to Top</a></strong></p>



# 


# <a name="appendix-b"> Appendix B - Network Settings</a>


## Network requirement during OVF deployment



*   Provision  4 IPs on “hdm_network”
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


**Note : ** In this configuration all of the above will map to a single network. 

Common settings for the OVF deployment


<table>
  <tr>
   <td>Default gateway network
   </td>
   <td><em>Choose the “hdm_network”</em>
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
   <td><em>Set the default gateway for the “hdm_network” for this field</em>
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

Common setting of gateway, subnet, DNS etc.  which will be common across the on-prem networks.


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

You need to provision 6 IPs on the “hdm_network”. Fill in the table below for use in the deployment phase.


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
   <td><strong>(2 IPs required from “hdm_network” )</strong>
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
   <td><strong>(2 IPs required from “hdm_network”)</strong>
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
   <td><strong>(2 IPs required from “hdm_network”)</strong>
   </td>
  </tr>
</table>



## Network requirement during on-cloud deployment

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
   <td><strong>(2O IPs from HDM “hdm_wan_network)</strong>
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
   <td><strong>(2 IPs from “hdm_wan_network”)</strong>
   </td>
  </tr>
</table>


<p style="text-align: right">


<p id="gdcalert30" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Back to Top"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert31">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

<a href="#heading=h.fh32bxmc9gq4">Back to Top</a></p>





# <a name="appendix-c"> Appendix C - IPSec tunnel, firewall and Cloud network configuration</a>

To deploy the HDM product you need to have 



1. IPSec connectivity between the premise and the cloud.
2. Firewall rules setup to allow required traffic
3. Network configured correctly on the cloud side.

All these three steps are explained in detail in the “**HDM 2.1 - Network Configuration - Planning - VCS**”.  Please make sure of the following



*   Configure the cloud side network as depicted in the diagram in the [Step 3/8 : Network Planning & Mapping](#networkplanning).

For easy configuration of the firewall rules we would recommend to have following Firewall configuration for all on-prem and on- cloud endpoints:

*   Source - source subnet.
*   Destination - Destination subnet
*   Service - Any
