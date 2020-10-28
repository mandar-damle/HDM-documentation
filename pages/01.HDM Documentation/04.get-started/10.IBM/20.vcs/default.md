---
title: 'VCS'
---

This Hands-on Lab is designed to quickly enable you to set up 
a sandbox environment with no network segregation and DHCP. This 
will allow you to deploy the product and exercise the functionality. 
The intention is to effectively understand the value HDM
has to offer for migration.

# Lab Setup

Set up the Lab without any network segregation, with DHCP and connectivity to the
target VCD cloud, as shown in _figure 1_.

_Figure 1: Lab Connectivity_
![alt_text](images/image3.png "image_tooltip")

1. Set up the source environment.
   1. Set up a <a name="single">single network</a> with DHCP service with IPs in 192.168.x.x
   1. Provision two servers with at least 96 GB RAM.
   1. Deploy and configure these two ESXi (6.5U2+ or 6.7) with management on the single network
   1. Deploy vCenter Server (6.5 or 6.7) and configure it over the single network.
   1. Add ESXi to vCenter.
   1. Provision a <a name="shared-ds">shared datastore</a> with at least 1 TB storage.
   1. Configure the two ESXi into a cluster 
   1. Add the shared storage to the two ESXi within the cluster.

The on-premises configuration is now complete. The target cloud can now be configured. 

1. Set up networking on the target VCS cloud
   1. In the step below, be sure to make the configurations using DHCP.
   1. Please follow the steps in [IPSec tunnel configuration](http://docs.primaryio.com/hdm%20documentation/vcs/network%20planning/ipsec%20tunnel#planning-and-preparation-single-network)
   1. The network created on cloud will be referred to as the cloud Single Network.
   1. After the IPSec tunnel is complete, the networks will be configured 
   on the target cloud and an IPSec tunnel will be connect to it.
   1. Set up DHCP service on the cloud Single Network.

Test for connectivity.

1. Test to ensure that the target cloud can be accessed from the source environment.
1. Deploy a TestVM1 on the source with the network connected to the Single Network.
1. Deploy another TestVM2 on the target cloud connected to the Single Network.
1. ssh into TestVM1 and try to connect to TestVM2.
1. If you are able to connect successfully, the setup is operational. 

# Downloading PrimaryIO HDM


```
Estimated time 5 minutes
```


Thank you for deciding to use PrimaryIO HDM. To get your license and download link for HDM, select the link below.

[https://www.primaryio.com/ibm/](https://www.primaryio.com/ibm/)

You will receive an email with:

*   A link to download the PrimaryIO HDM software
*   A link to training videos [https://www.primaryio.com/training/](https://www.primaryio.com/training/)
*   The license key for the software

To proceed with the installation, you should first watch the training videos and use this guide. 



# Deploy the PrimaryIO Appliance


```
Estimated time 5 minutes
```

*   Make sure you have at least 10GB free space to download the appliance.
*   Unzip the file HDM_2.1.zip from the download link
*   Deploy the appliance using the vCenter UI 

**Note :**

*   The PrimaryIO Appliance should be deployed on the same vCenter and datacenter it will manage. 
*   HDM components should be deployed on the shared datastore. Disks can be thin provisioned. 

<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image14.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Perform the steps as directed by the UI.
<li>Select <em>Single Network</em> created <a href="#single">during lab setup</a>.
<li> Select IP Allocation as DHCP.
<li> 
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image2.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>
<li>Skip the Customize template.
<li>Complete OVF deployment.
<li>Power on the appliance.
</ul>
   </td>
  </tr>
</table>



# Validate Network Configuration


```
Estimated time 10 minutes
```



<table>
  <tr>
   <td>
<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image1.png" width="" alt="alt_text" title="image_tooltip">   
   </td>
   <td>
<ul>

<li>All ESXi instances in vCenter should be connected
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>
   <img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image6.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>ESXi should be able to communicate with vCenter. A simple ping command from the ESXi server to vCenter FQDN (or IP)  can be used to test it.
</li>
</ul>
   </td>
  </tr>
</table>




# On-Premises Deployment


## Add On-Prem vCenter



*   Power on the appliance
*   Find the appliance IP
*   Open the appliance web interface for https://&lt;appliance-ip>
*   Log into the appliance web UI using default password 2Hdm$aK!N@h!
*   After login, click on ![alt_text](images/image13.png "image_tooltip")


<table>
  <tr>
   <td>



<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image16.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Select _Add vCenter_
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image15.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Provide vCenter credentials

<li>Select _Add_ to add vCenter
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image18.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>Register the vCenter plugin by selecting the _Register_ button.
   </td>
  </tr>
</table>


At this point, vCenter configuration is complete. Log into the vCenter you have just configured.


```
Note:
For the plugin to be visible within vCenter, you will need to logout and log back into vCenter at least twice.
```



## Configure License

Navigate to the Licensing page on the HDM vCenter Plugin


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image17.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>The HDM plugin can be reached via Menu->HDM

<li>The first time you navigate to HDM it can take approximately five minutes to load

<li>On the Licensing Tab, select _Add License_

<li>Add the license key received via email.
</li>
</ul>
   </td>
  </tr>
</table>



## Configure On-premises vCenter


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image19.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Select _Administration_ followed by _Configuration_

<li>Choose the cluster you want to install on

<li>Select _Install_
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image23.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Resource:- Standard

<li>Deployment:- Standalone

<li><strong>Only Choose these options. This guide is tailored specifically to this configuration</strong>
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>


<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image7.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>
<li>Complete all steps to begin the deployment
<li>Choose shared storage <a href="#shared-ds">created during lab setup</a> 
<li>Choose DHCP for all network configurations.
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

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image20.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Select _Clouds_, followed by _Add Cloud_

<li>The Wizard to configure the cloud will pop-up.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image10.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Choose _IBM Cloud on VMware Solutions Dedicated_

<li>Add the required details
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image21.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>
<li>For parts one and two, choose <em>DHCP</em>
</li>
</ul>
   </td>
  </tr>
</table>



### WAN Routing Configuration


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/10.vcd/images/image30.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li> Set the WAN subnet for on-premises and the cloud.
<li> Set the gateway for WAN on both sides.
<li> DON'T skip this step.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image22.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Use the network configuration captured in [Appendix B]

<li>Map the on-premises environment to the cloud network.

<li>This step may take up to an hour, depending on uplink speed.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image11.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>To ensure that the deployment has been successful, select _HDM_ -> Administration -> _HDM Health_ -> _Component Health_

<li>If the status is green, the setup is ready to start migration 
</li>
</ul>
   </td>
  </tr>
</table>



# Perform Cold Migration

During the cold migration, the VM that is being migrated is powered off. After the migration is complete on the cloud, the VM can be powered on.


```
Note:
Migrations will be successful for VMs where network and disk interfaces are accessible to HDM via VMware APIs. 
In case network or disk interfaces are added dynamically, the virtual machine needs to be powered down, so 
information about the newly added network and disk interface are available to HDM via VMware APIs. 
Before migration is triggered, ensure that the health of HDM componentes is green. 
```


 


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image9.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Right click on the VM 

<li>Select _Migrate_

<li>The migration wizard will appear
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image5.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/10.IBM/20.vcs/images/image8.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>The status of the migration will be shown in the wizard and will be displayed on vCenter tasks.

<li>After successful migration, the VM is ready for use in the cloud. 

<li>To migrate multiple VMs and the HDM dashboard, please refer to the _HDM Admin Guide_.
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



