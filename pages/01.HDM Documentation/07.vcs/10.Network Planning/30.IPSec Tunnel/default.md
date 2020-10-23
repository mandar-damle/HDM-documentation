---
title: 'IPSec tunnel configuration'
---

This network configuration section is for configuring a virtual private network (IPsec) between premise and cloud infrastructure prior to the deployment of the HDM product. This section assumes that cloud infrastructure and vCenter are on the different subnets than the on-premise infrastructure. The examples given in this document are for the configuration of IPsec tunnel between Edge gateway on NSX-V and premise SonicWall firewall. 

## Planning and preparation - Single Network

### Prerequisites checks

Please ensure that the following prerequisites are met before proceeding for deployment,



1. Cloud ESXi hosts, Cloud Vcenter and Cloud WAN network should be reachable from the appliance through VPN and FQDN is resolved. 
2. Virtual machines created on the Cloud  should be able to reach Cloud vCenter and Cloud ESXi and FQDN is resolved through either cloud HDM_WAN network or HDM_INTERNAL_NETWORK 
3. The cloud DNS is also reachable from the on-premise through the IPsec tunnel. (Please make note that the Cloud side DNS details are required at the time of deployment of HDM product).

In order to meet above requirements, following route based IPsec VPN  tunnels need to be configure. For additional information please refer to VMware document [Configure a VPN Connection Between Your SDDC and On-Premises Data Center](https://docs.vmware.com/en/VMware-Cloud-on-AWS/services/com.vmware.vmc-aws.networking-security/GUID-92F6C09E-8E74-430E-8F79-C2E5B2150ADA.html)



1. **Premise WAN network to SDDC Compute Edge Gateway** -  This will allow communication to Cloud VC and cloud WAN network. Please add vCenter and WAN network in the same IPsec tunnel
2. **Premise WAN network to SDDC Management Edge Gateway** - This will allow communication to Cloud  ESXi through private IPs. 
3. **IPsec tunnel between  Compute and Management Edge gateways** - When NSX-V is used as a software defined network on cloud, the IPsec tunnel needs to be configured between  Compute and Management Edge gateways.  This is required for cloud HDM components to reach cloud ESXi hosts.  For more information please refer to the Blog [Can a VM in the VMC Compute Network access the SDDC Management Network](https://cloud.vmware.com/community/2019/05/06/can-vm-vmc-compute-network-access-sddc-management-network/)


### Creating Private Network on Cloud side

Here is the process to create the  network for HDM which will act as a WAN and INTERNAL network.



*   On cloud Vcenter Click on Networking -> SDDC-DSwitch-Private (Right Click)-> Distributed Port Group -> New Distributed Port Group. In this wizard, enter the network name and click on next. 

![alt_text](images/image8.png?classes=content-img "image_tooltip")

*   Follow the next section of setting port group properties. In this section, configure the setting as per your requirements

![alt_text](images/image17.png?classes=content-img "image_tooltip")

*   Click on Finish.
*    Define static and DHCP IP ranges on Edge Gateway -> Manage -> DHCP -> click on “+” -> Enter the start IP, End IP, DNS and Default Gateway and save it.

![alt_text](images/image5.png?classes=content-img "image_tooltip")

*   Please make sure Interface is in connected state

![alt_text](images/image12.png?classes=content-img "image_tooltip")

*   Please make sure the interface is connected to all required edges.

![alt_text](images/image4.png?classes=content-img "image_tooltip")

*   


## Setting up Single Network IPsec tunnel 

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

![alt_text](images/image6.png?classes=content-img "image_tooltip")



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


![alt_text](images/image9.png?classes=content-img "image_tooltip")


    5. Click on the “+” sign to add IPsec tunnel and fill up the required information.


![alt_text](images/image3.png?classes=content-img "image_tooltip")


    6.  Click on the Ok and start IPsec service.
2. Information required and the steps to be covered at the Premise Side,

    In this example we have used the SonicWall firewall. The sections may not be the same for other firewalls, but overall flow would  be the same.

    7. Fill up the general setting as shown below 

     


```
Note: Instructions below are specific to SonicWall and users are requested to do the equivalent for their specific firewall.
```



![alt_text](images/image15.png?classes=content-img "image_tooltip")


3. Proposal settings should be similar to the cloud side. 

![alt_text](images/image14.png?classes=content-img "image_tooltip")


4. Now start the IPsec tunnel services  and check the newly configured IPSec tunnel is up.

Once the configuration is done, to test the connectivity, try to ping/access cloud side VMs from the premise. If the test is not successful, it may be required to correctly add DNS to resolve FQDN.


![alt_text](images/image2.png?classes=content-img "image_tooltip")


Here are additional considerations, 



*   If management and compute networks are connected to the same edge gateway then you can specify multiple subnets under a single IPsec tunnel.
*   Once all the IPsec tunnels are up, please check if required port are opened of different end points as mentioned in this document (Link to port requirement doc).

**Premise WAN network to SDDC Management Edge Gateway**

Steps for this section are the same as **Premise WAN network to SDDC Compute Edge Gateway **except local/remote endpoints and subnets.

 **IPsec tunnel between  Compute and Management Edge gateways**

**	**In this section, users are supposed to configure IPsec tunnel between cloud  Compute and Management gateway so that HDM components attached to hdm_internal network can communicate to ESXi hosts. For more details please refer to [this^](https://cloud.vmware.com/community/2019/05/06/can-vm-vmc-compute-network-access-sddc-management-network/) link.


## Setting up Multiple Network IPSec tunnel

This section describes the steps to setup a multiple network IPsec tunnel. Once all the prerequisites are met and planning is done, please follow the steps below.


```
Note: The recommendation is to have following Firewall configuration for all on-premise and on-cloud endpoints
```


Here are the Firewall configuration on premise and at the cloud side. 



*   At the Source - source subnet.
*   At the Destination - Destination subnet
*   Service - **Any**

![alt_text](images/image6.png?classes=content-img "image_tooltip")

 if you want to allow specific traffic from source to destination, please refer to the firewall rules section below.


## Firewall Rules

Below section covers setting in details to allow traffic going from source to destination. These settings should be done on all endpoints.  In case of a single network config, hdm_internal and hdm_wan network would be the same.


### Service/Port level requirement for HDM



1. **Premise wan network - Cloud wan network ports(Inbound/Outbound): **22, 2379, 32820, 2376, 6000-6050, 7000-7050, 8000-8050,  443
2. **Premise  wan network - tenant portal ( Inbound/Outbound): 443**
3. **Cloud** (Inbound/Outbound): **902, 443, 53(UDP, UDP-DNS)

### 
     Single Network firewall rules example


    Example of firewall rules in Compute Edge or Customer Edge and Management Edge gateway is given below,

    *   10.50.1.0/24  is cloud WAN network
    *   10.102.0.0/16 is the premise WAN network. On premise ESXi, vCenter, Appliance and DNS have access to this subnet.
    *   10.168.92.66 is vCenter
    *   10.169.232.0/26 is cloud ESXi and cloud DNS network.

  Compute Edge or Customer Edge

![alt_text](images/image11.png?classes=content-img "image_tooltip")


  Management Edge


![alt_text](images/image16.png?classes=content-img "image_tooltip")



### 
    Multiple Networks firewall rules example


    Example of firewall rules in Compute Edge or Customer Edge and Management Edge gateway is given below,



    *   10.50.1.0/24  is cloud WAN network i.e. hdm_wan_network
    *   10.51.1.0/24  is cloud INTERNAL network i.e. hdm_inernal_network
    *   10.0.4.1/24 is the premise of the WAN network. On premise ESXi, vCenter, Appliance and DNS have access to this subnet.
    *   10.168.92.66 is vCenter
    *   10.169.232.0/26 is cloud ESXi and cloud DNS network.

     


    Compute Edge rules:


![alt_text](images/image1.png?classes=content-img "image_tooltip")



    Management Edge firewall rules:

  

<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png?classes=content-img "image_tooltip")

