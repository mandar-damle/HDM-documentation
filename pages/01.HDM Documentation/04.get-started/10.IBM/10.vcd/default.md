---
title: 'VCD Hands-on Lab'
---

This Hands-on Lab is designed to quickly enable you to setup 
a sandbox environment with no network segregation and DHCP. This 
will allow you to deploy the product and exercise the functionality. 
The intention is to effectively understand the value HDM
has to offer for migration.

# Lab Setup

Set up the Lab without any network segregation, with DHCP and connectivity to the
target VCD cloud, as shown in _figure 1_.


_Figure 1: Lab Connectivity_
![Lab layout](images/single-network.png)

1. Set up the source environment.
   1. Set up a <a name="single">Single Network</a> with DHCP service with IPs in 192.168.1.0/24
   1. Provision two servers with at least 96 GB RAM each.
   1. Deploy and configure the two ESXi (6.5U2+ or 6.7) with Management on the single network
   1. Deploy vCenter Server (6.5 or 6.7) and configure it over the single network.
   1. Add ESXi to vCenter.
   1. Provision <a name="shared-ds">shared datastore</a> with at least 1 TB storage.
   1. Configure the two ESXi into a cluster 
   1. Add the shared storage to the two ESXi within the cluster.

The on-premises configuration is now complete. To configure the target cloud:


1. Set up networking on the target VCD
   1. In the next step you will create the required networks on the cloud target and set up an IPSec tunnel. If your VCD is within the Lab you can skip the IPSec tunnel configuration in the step below. Please make sure subnets on cloud side are not same as on-premises WAN subnet, use different network.
   1. Please follow the step in [ORG VDC System and Network Configuration](http://docs.primaryio.com/hdm%20documentation/vcd/network%20planning/cloud%20network%20config)
   1. After the ORG VDC setup is complete, the networks will be configured 
   on the target cloud and an IPSec tunnel will be connected to it.
   1. Set up a DHCP service on the UPLINK_WAN_NETWORK and the HDM_INTERNAL_NETWORK which was setup in step 1 with IPs in step#1. 

Test the connectivity.

1. Test to ensure that the VCD tenant portal can be accessed from the source environment.
1. Deploy a TestVM(linux or windows) on the premises and cloud side, attach the respective WAN Network configured earlier.
1. Test connection to the tenant portal from the TestVM.
1. Try connection from premises VM to Cloud VM and reverse.
1. If you are able to successfully connect, the setup is operational. 

# Download PrimaryIO HDM

To obtain your license and download link for HDM, visit [https://www.primaryio.com/ibm/](https://www.primaryio.com/ibm/)

You will receive an email with the following:
*   A link to download the PrimaryIO HDM software
*   A link to training videos
*   A license key for the software

Before proceeding with the installation, watch the training videos ([https://www.primaryio.com/training/](https://www.primaryio.com/training/)) and use this guide. 


# Deploy the HDM Appliance

*   Make sure you have at least 10GB of free space to download the appliance
*   Unzip the file _HDM_2.1.zip_ from the download link
*   Deploy the appliance using the vCenter UI 


<table>
  <tr>
   <td>
<img src="/user/pages/01.HDM%20Documentation/04.get-started/10.IBM/10.vcd/images/image12.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Perform the step as directed by the UI.

<li>Select <em>Single Network</em> created <a href="#single">during lab setup</a>.
<li> Select IP Allocation as DHCP.
</ul>
   </td>
  </tr>
</table>


 


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image13.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Skip the Customize template.
<li>Complete OVF deployment.
<li>Power on the appliance.
</li>
</ul>
   </td>
  </tr>
</table>





# Validate the Network Configuration


<table>
  <tr>
   <td>
<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image23.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>All ESXi servers in vCenter should be connected
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>
<img src="/user/pages/01.HDM Documentation/04.get-started/10.vcd/images/image10.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>The ESXi server must be able to communicate with vCenter. Test this using the ping command from the ESXi server to the vCenter FQDN (or IP)

<li>Check to ensure the appliance is powered on
</li>
</ul>
   </td>
  </tr>
</table>





# On-premises Deployment


## Add on-premise vCenter

*   Locate the IP address of the appliance
*   Enter _https://&lt;appliance-ip>_ in the appliance web interface
*   Log into the appliance web UI using default password: 2Hdm$aK!N@h!
*   After login, select ![alt_text](images/image14.png "image_tooltip")


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image16.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>Select <em>Add vCenter</em>
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.vcd/images/image15.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Enter the vCenter credentials

<li>Select <em>Add</em>
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="images/image19.png" width="" alt="alt_text" title="image_tooltip">
<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image19.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>Register the vCenter plugin by selecting <em>Register</em>
   </td>
  </tr>
</table>


vCenter configuration is now complete. Log into the newly-configured vCenter.


```
Note:
For the plugin to be visible within vCenter, you will need to logout and log back into vCenter at least twice.

```



## Configure the License

Navigate to the _Licensing_ page on the HDM vCenter Plugin


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image17.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>The HDM plugin can be accessed directly via the Menu

<li>It can take approximately five minutes to load HDM the first time it is accessed

<li>On the <em>Licensing</em> tab, select <em>Add License</em>

<li>Add the license key you received by mail
</li>
</ul>
   </td>
  </tr>
</table>



## Configure the On-premises vCenter


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image18.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Select <em>Administration</em>, then <em>Configuration</em>

<li>Choose the cluster where you want to install vCenter

<li>Select <em>Install</em>
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image20.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>For vCD, choose: 
<ul>
 
<li>Resource: Ultra-Lite
 
<li>Deployment: Cluster or Standalone
</li> 
</ul>

<li>Only choose these options (this guide is only tailored to this configuration)
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image21.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Complete all steps to begin the deployment
<li>Choose shared storage <a href="#shared-ds">created during lab setup</a> 
<li>Choose DHCP in all network configurations.
<li>This step will take a few minutes to complete. Progress will be shown on the vCenter task bar.
</li>
</ul>
   </td>
  </tr>
</table>



# Cloud Deployment


## Configure Cloud vCenter


<table>
  <tr>
   <td>


<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image24.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Select <em>Clouds</em>, then <em>Add Cloud</em>

<li>The cloud configuration wizard will pop-up automatically
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image25.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Choose vCloud Director

<li>Enter vCD credentials

<li>Select <em>Add</em>

<li>Please note, it will take approximately five minutes to configure vCD and move to the next screen
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image26.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Choose vApp to deploy HDM cloud components

<li>Choose the highest performance for rapid transfer
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image27.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>For Parts 1 and 2, choose <em>DHCP</em>
</li>
</ul>
   </td>
  </tr>
</table>



### WAN Routing Configuration


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image2.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>
<li> Set the WAN subnet for the on-premises and cloud environments.
<li> Set the gateway for both sides of the WAN.
<li> DON'T Skip this step.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>
<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image3.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Map the on-premises single network to UPLINK_WAN_NETWORK.
<li>Depending on the chosen configuration and uplink speed, this step may require up to an hour to complete
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image4.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>To ensure the deployment has been successful, select <em>HDM</em> from the Menu, followed by the <em>Administration</em>, <em>HDM Health</em>, and <em>Component Health</em> tabs

<li>Check the status. If it is green, it is ready to begin migration.
</li>
</ul>
   </td>
  </tr>
</table>



# Perform a Cold Migration

During cold migration, the VM being migrated is powered off. After the migration has been completed on the cloud, the VM can be powered back on.


```
NOTES:
Migrations will be successful for VMs where network and disk interfaces are accessible to HDM via VMware APIs.
If network or disk interfaces are added dynamically, the virtual machine will need to be powered down to allow 
the newly added network and disk interface information to become available to HDM via VMware APIs.
Before migration is triggered, ensure that the health of all HDM components is green. 
```

<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image5.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Right-click on the VM 

<li>Select <em>Migrate</em>

<li>The migration wizard will pop-up automatically
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image6.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Complete all steps 
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image7.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>The migration status will be displayed in the wizard, as well as in vCenter Tasks

<li>Following successful migration, the VM will be ready for use in the cloud

<li>To migrate multiple VMs and the HDM dashboard, please refer to the HDM 2.1.3 Admin Guide
</li>
</ul>
   </td>
  </tr>
</table>


