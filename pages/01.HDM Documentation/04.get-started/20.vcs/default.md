
---
title: 'IBM Service for VMware Cloud Hands-on Lab'
---

This Hands-on Lab is designed to quickly enable you to setup 
a sandbox environment with no network segregation and DHCP. This 
will allow you deploy the product and exercise the functionality. 
The intention is to effectively understand the value HDM
has to offer for migration.

# Lab Setup

Setup the Lab without any network segregation with DHCP and connectivity to the
target VCD cloud as shown in the _figure 1_.

_Figure 1: Lab Connectivity_
![alt_text](images/image3.png "image_tooltip")

1. Setup the source environment.
   1. Setup a <a name="single">Single Network</a> with DHCP service with IPs in 192.168.x.x
   1. Provision 2 servers with at least 96 GB RAM.
   1. Deploy and configure these 2 ESXi (6.5U2+ or 6.7) with Management on the Single Network
   1. Deploy vCenter Server (6.5 or 6.7) and configure it over the Single Network.
   1. Add the ESXi to the vCenter.
   1. Provision <a name="shared-ds">Shared datastore</a> with at least 1 TB storage.
   1. Configure the two ESXi into a cluster 
   1. Add the shared storage to the 2 ESXi within the cluster.

Your on-premises configuration is over now we will configure the target cloud. 

1. Setup Networking on target VCS cloud
   1. In the step below, ensure you make the configurations with DHCP.
   1. Please follow the step in [IPSec tunnel configuration](http://docs.primaryio.com/hdm%20documentation/vcs/network%20planning/ipsec%20tunnel#planning-and-preparation-single-network)
   1. The we will refer to the network created on cloud as the cloud Single Network.
   1. After the IPSec tunnel is complete you will have Networks configured 
   on the target cloud and a IPSec tunnel to connect to it.
   1. Setup a DHCP service on the cloud Single Network.

Test connectivity.

1. Test that the target cloud  can be accessed from source environment.
1. Deploy a TestVM1 on the source with Network connected to the Single Network.
1. Deploy another TestVM2 on the target cloud connected to the Single Network.
1. ssh into TestVM1 and try to connect to TestVM2.
1. If you are able to connect successfully you setup is operational. 

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image14.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li>Perform the step as directed by the UI.
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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image2.png" width="" alt="alt_text" title="image_tooltip">

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



# Step 5: Validate Network Configuration


```
Estimated time 10 minutes
```



<table>
  <tr>
   <td>
<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image1.png" width="" alt="alt_text" title="image_tooltip">   
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
   <img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image6.png" width="" alt="alt_text" title="image_tooltip">
   </td>
   <td>
<ul>

<li>The ESXi should be able to communicate with the vCenter. Simple ping command from ESXi server to vCenter FQDN (or IP)  will ensure that
</li>
</ul>
   </td>
  </tr>
</table>




# Step 6: On-Prem Deployment


## Add On-Prem vCenter



*   Power On the appliance
*   Find the appliance IP
*   Open the appliance web interface for https://&lt;appliance-ip>
*   Login to the appliance web UI using default password 2Hdm$aK!N@h!
*   After login in click on ![alt_text](images/image13.png "image_tooltip")


<table>
  <tr>
   <td>



<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image16.png" width="" alt="alt_text" title="image_tooltip">

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


<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image15.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image18.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image17.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image19.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image23.jpg" width="" alt="alt_text" title="image_tooltip">

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


<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image7.jpg" width="" alt="alt_text" title="image_tooltip">

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



# Step 7: On-Cloud Deployment



## Configure On-Cloud vCenter


<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image20.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image10.jpg" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image21.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/10.vcd/images/image30.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>
<ul>

<li> Set the WAN subnet for both prem & cloud.
<li> Set the gateway for WAN both sides.
<li> DON'T Skip this step.
</li>
</ul>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image22.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image11.png" width="" alt="alt_text" title="image_tooltip">

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



# Step 8: Perform Cold Migration

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image9.jpg" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image5.png" width="" alt="alt_text" title="image_tooltip">

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

<img src="/user/pages/01.HDM Documentation/04.get-started/20.vcs/images/image8.png" width="" alt="alt_text" title="image_tooltip">

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



