<!-- Copy and paste the converted output. -->


<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 1; ALERTS: 15.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>
<a href="#gdcalert12">alert12</a>
<a href="#gdcalert13">alert13</a>
<a href="#gdcalert14">alert14</a>
<a href="#gdcalert15">alert15</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>



# 

<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")



# **HDM2.1 : Virtual Private Network configuration guide for VCS**

Version: 2.1

Publish Date: August, 2020

Copyright © 2020 PrimaryIO, Inc.

Contents


[TOC]



[TOC]





# About this Guide

This network configuration guide is for configuring a virtual private network (IPsec) between premise and cloud infrastructure prior to the deployment of the HDM product.  This guide assumes that cloud infrastructure and vCenter are on the different subnets than the on-premise infrastructure. The examples given in this document are for the configuration of IPsec tunnel between Edge gateway on NSX-V and premise SonicWall firewall. 


# Planning and preparation - Single Network.


## Prerequisites checks

Please ensure that following prerequisites are met before proceeding for deployment,



1. Cloud ESXi hosts, Cloud Vcenter and Cloud WAN network should be reachable from the appliance through VPN and FQDN is resolved. 
2. Virtual machines created on the Cloud side WAN network should be able to reach Cloud vCenter and Cloud ESXi and FQDN is resolved. 
3. The cloud DNS is also reachable from the on-premise through the IPsec tunnel. (Please make note that the Cloud side DNS details are required at the time of deployment of HDM product).

In order to meet above requirements, following route based IPsec VPN  tunnels need to be configure. For additional information please refer to VMware document [Configure a VPN Connection Between Your SDDC and On-Premises Data Center](https://docs.vmware.com/en/VMware-Cloud-on-AWS/services/com.vmware.vmc-aws.networking-security/GUID-92F6C09E-8E74-430E-8F79-C2E5B2150ADA.html)



1. **Premise WAN network to SDDC Compute Edge Gateway** -  This will allow communication to Cloud VC and cloud WAN network. Please add vCenter and WAN network in the same IPsec tunnel
2. **Premise WAN network to SDDC Management Edge Gateway** - This will allow communication to Cloud  ESXi through private IPs. 
3. **IPsec tunnel between  Compute and Management Edge gateways** - When NSX-V is used as a software defined network on cloud, the IPsec tunnel needs to be configured between  Compute and Management Edge gateways.  This is required for cloud HDM components to reach cloud ESXi hosts.  For more information please refer to the Blog [Can a VM in the VMC Compute Network access the SDDC Management Network](https://cloud.vmware.com/community/2019/05/06/can-vm-vmc-compute-network-access-sddc-management-network/)


## Creating Private Network on Cloud side

Here is the process to create the  network for HDM which will act as a WAN and INTERNAL network.



*   On cloud Vcenter Click on Networking -> SDDC-DSwitch-Private (Right Click)-> Distributed Port Group -> New Distributed Port Group. In this wizard, enter the network name and click on next. 

<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")

*   Follow the next section of setting port group properties. In this section, configure the setting as per your requirements

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")

*   Click on Finish.
*    Define static and DHCP IP ranges on Edge Gateway -> Manage -> DHCP -> click on “+” -> Enter the start IP, End IP, DNS and Default Gateway and save it.

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")

*   Please make sure Interface is in connected state

<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")

*   Please make sure the interface is connected to all required edges.

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")

*   


# Setting up Single Network IPsec tunnel 

This section describes the steps to setup a single network IPsec tunnel. Once all the prerequisites are met and planning is done, please follow the steps below.

**Premise WAN network to SDDC Compute Edge Gateway**

This section describes the steps to setup a single network IPsec tunnel. Once all the prerequisites are met and planning is done, please follow the steps below.


```
Note: The recommendation is to have following Firewall configuration for all on-premise and on-cloud endpoints
```


Here are the Firewall configuration on premise and at the cloud side. 



*   At the Source - source subnet.
*   At the Destination - Destination subnet
*   Service - **Any**

        

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")



 if you want to allow specific traffic from source to destination, please refer (&lt;Reference to Admin guide>)



1. Information required and the steps to be covered at the cloud side,
    1. Collect following information before you start with IPsec configuration:
        1. Local ID(cloud public IP)
        2. Local subnet(s)(cloud subnets)
        3. Peer ID(premise public IP)
        4. Peer subnet(s)(Premise subnets)
    2. Log on to the cloud vCenter.
    3. Click on “Home” -> “Network and Security” -> “NSX Edges” -> “Click on the edge”
    4. On edge - Click on “Manage” -> “VPN” -> “IPsec”

    

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


    5. Click on the “+” sign to add IPsec tunnel and fill up the required information.

    

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


    6.  Click on the Ok and start IPsec service.
2. Information required and the steps to be covered at the Premise Side,

    In this example we have used the SonicWall firewall. The sections may not be the same for other firewalls, but overall flow would  be the same.

    7. Fill up the general setting as shown below 

     


    ```
Note: Instructions below are specific to SonicWall and users are requested to do the equivalent for their specific firewall.
```



    

<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


3. Proposal settings should be similar to the cloud side. 

    

<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


4. Now start the IPsec tunnel services  and check the newly configured IPSec tunnel is up.

Once the configuration is done, to test the connectivity, try to ping/access cloud side VMs from the premise. If the test is not successful, it may be required to correctly add DNS to resolve FQDN.


    

<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")


Here are additional considerations, 



*   If management and compute networks are connected to the same edge gateway then you can specify multiple subnets under a single IPsec tunnel.
*   Once all the IPsec tunnels are up, please check if required port are opened of different end points as mentioned in this document (Link to port requirement doc).

**Premise WAN network to SDDC Management Edge Gateway**

Steps for this section are the same as **Premise WAN network to SDDC Compute Edge Gateway **except local/remote endpoints and subnets.

 **IPsec tunnel between  Compute and Management Edge gateways**

**	**In this section, users are supposed to configure IPsec tunnel between cloud  Compute amd Management gateway so that HDM components attached to hdm_internal network can communicate to ESXi hosts. For more details please refer to [this^](https://cloud.vmware.com/community/2019/05/06/can-vm-vmc-compute-network-access-sddc-management-network/) link.


# Setting up Multiple Network IPSec tunnel

This section describes the steps to setup a multiple network IPsec tunnel. Once all the prerequisites are met and planning is done, please follow the steps below.


```
Note: The recommendation is to have following Firewall configuration for all on-premise and on-cloud endpoints
```


Here are the Firewall configuration on premise and at the cloud side. 



*   At the Source - source subnet.
*   At the Destination - Destination subnet
*   Service - **Any**

        

<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")



 if you want to allow specific traffic from source to destination, please refer (&lt;HDM 2.1 for VMware Admin Guide - VCS>)


## Firewall Rules {#firewall-rules}

Below section covers setting in details to allow traffic going from source to destination. These settings should be done on all endpoints.  

&lt;Should cover the following // Does this cover it in details>



*   Ensure that the on cloud vCenter and ESXi is accessible from on premise endpoints at port 443.
*   The on cloud vCenter has E1000E and VMXNet3 network adapters available 
*   The on premise WAN network on which HDM components are deployed should have access to on cloud vCenter at port 443 as well as on cloud ESXi is accessible at port 443 and 902(Inbound and outbound).
*   The on cloud WAN network should have access to on premise WAN network on port 443(Inbound and outbound)
*   On premise network should have access to port 443 to the on cloud ESXi
*   Enable DNS and DNS-UDP service on firewall to resolve cloud VC and ESXi. This is required for on cloud VM network  to Management network also. Enabling port 53 will not work and  DNS services need to enabled
*   Below are the firewall rules (for cloud side firewall as well as premise side firewall) for on cloud access for HDM setup 
    *   Port 22 - inbound and outbound
    *   Port 2379 - outbound and inbound
    *   Port 6000-6010 - inbound and outbound
    *   Port 7000-7010 - inbound and outbound
    *   Port 8000-8010 - inbound and outbound
    *   Port 32820 - inbound and outbound
    *   Port 2376 - inbound and outbound
*   Example of firewall rules in Compute Edge or Customer Edge and Management Edge gateway is given below,
    *   10.50.1.0/24  is cloud WAN network
    *   10.102.0.0/16 is the premise WAN network. On premise ESXi, vCenter, Appliance and DNS have access to this subnet.
    *   10.168.92.66 is vCenter
    *   10.169.232.0/26 is cloud ESXi and cloud DNS network.

    &lt;Also need steps for> 


  Compute Edge or Customer Edge



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


  Management Edge

 

<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")



