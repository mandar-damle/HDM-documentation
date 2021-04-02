---
title: 'Non-Segregated Network'
---

The non-segregated network is represented would look like

![alt_text](images/image5.png "image_tooltip")


In this case, all of the 4 networks would map to **_VM Network / Management Network. _**Users would still need to provide details for each of the networks separately. Users can divide the IP subnet into multiple ranges which can be mapped to these four networks. 

For example, for a network 10.102.0.0/16, we can have following IP ranges and can be used accordingly:



*   10.102.1.2 - 10.102.1.20 (VM Network)
*   10.102.1.21 - 10.102.1.40 (ESXi_Network)
*   10.102.1.41 - 10.102.1.60 (Uplink_WAN_Network)
*   10.102.1.61 - 10.102.1.80 (HDM_Internal_Networking)

During HDM deployment, users are required to categorize and map the networks discovered in the vCenter as per the types mentioned above. 



![alt_text](images/image13.png "image_tooltip")


In this case all of the “Source Networks” would map to **_VM Network / Management Network_** during the deployment process as shown below. 

### Network planning spreadsheet

Please download the spreadsheet [Planning Template](../../../../Planning%20Template.xlsx) and use along with
your deployment process. 

The **Planning Template** is an active spreadsheet which will allow you 
to specify the deployment mode you have chosen. You need to select the 
correct mode using the drop down.

1. Choose the "Cloud Type"
1. Choose the "Deployment Mode"
1. Choose the "Resource Allocation" 

After this you need to fill in the number of ESXi on-premises and on the cloud. For VMware Cloud Director
the number of nodes on the cloud is irrelevant and please fill in 1 here.

The rest of the form requires you to fill in network configuration details like
IP address, ranges. The dynamic part of the form gives you information on the 
number of the resources you need to provision. 

The information in the **Planning Template** is almost identical to the 
sections below and should serve to identify the size of the IP pool required 
and capture information for easy entry during the deployment steps.


### HDM Network Configuration - Planning

Please fill the table below for use during installation later. 


<table>
  <tr>
   <td><strong>Network</strong>
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



#### Network requirements during on-premises deployment

During the premises deployment phase of the installation we will configure the following networks on-premises.



1. HDM_Internal_Network
2. Uplink_WAN_Network
3. ESXi_Network

These are the same as the ones described in previous section on OVF Deployment. During the premises deployment however you need to provide a range or list of IPs for each of these networks.


![alt_text](images/image18.png "image_tooltip")


For all the 3 categories of network, choose the IP allocation mechanism : static IP.

For static IP, following details are required for configuration.



*   IP range : IP list that are free to be allocated for use.
*   Subnet mask : subnet of the IP range
*   Gateway : gateway IP of the network
*   Domain : domain name of the network
*   DNS : to translate the domain name to IP
*   NTP : for time sync

A pool of IP addresses need to be allocated. The number of IPs for each category are

**HDM_Internal_Network: **2 IPs required

**Uplink_WAN_Network: ** 2 IPs required

**ESXi_Network: **2 IPs required


> **Note:**
> 1. **The subnet range 172.17.0.0/16 is not available for the deployment; it is internally used by HDM microservices.**
> 2. Please check the static ip usage using arping command before using it to ensure that ip should not be in use.
*arping  -c  2 -w 20  -I ens192  [IP]*

Please fill the table below for reference during the installation process.

**HDM_Internal_Network**


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
   <td><em>10.102.10.100-10.102.10.120,  10.102.10.130</em>
   </td>
   <td>
   </td>
  </tr>
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
   <td><em>10.102.10.1</em>
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
   <td><em>10.102.5.20, 10.102.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>10.102.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>


**Uplink_WAN_Network**


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
   <td><em>10.102.10.131-10.102.10.151</em>
   </td>
   <td>
   </td>
  </tr>
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
   <td><em>10.102.10.1</em>
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
   <td><em>10.102.5.20, 10.102.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>10.102.5.22</em>
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
   <td><em>10.102.10.152-10.102.10.172</em>
   </td>
   <td>
   </td>
  </tr>
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
   <td><em>10.102.10.1</em>
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
   <td><em>10.102.5.20, 10.102.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>10.102.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>



#### Network requirement during on-cloud deployment

Similar to the previous two deployment stages we need to provision IPs and identify the correct networks that satisfy the connectivity requirements. The networks that need to be configured are.

**HDM Internal network: **20 IP pool. Will also be used for VMs during migration

**WAN network configuration: **2 IPs.

Please fill the table below for reference during the installation process.

**HDM_Internal_Network**


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
   <td><em>10.50.10.100-10.50.10.120</em>
   </td>
   <td>
   </td>
  </tr>
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
   <td><em>10.50.10.1</em>
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
   <td><em>10.50.5.20, 10.50.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>10.50.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>


**Uplink_WAN_Network**


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
   <td><em>10.50.10.121,10.50.10.122,  10.50.10.123</em>
   </td>
   <td>
   </td>
  </tr>
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
   <td><em>10.50.10.1</em>
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
   <td><em>10.102.5.20, 10.102.5.21</em> 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>NTP</strong>
   </td>
   <td><em>10.102.5.22</em>
   </td>
   <td>
   </td>
  </tr>
</table>



#### WAN Routing Configuration

The following WAN routes are required to access on-cloud from on-premises and vice-versa. This is required in during the [Set WAN route](../../../deployment%20steps#wan-cfg) part of cloud configuration.


*   **On-premises WAN network details**

    The route which would be set on HDM appliance on-premises. The routes will enable communication from on-premises to HDM appliances on-cloud.

    *   **On-Premises WAN subnet :** Subnet of premises WAN network on which HDM appliances are deployed
    *   **On-Premises WAN gateway :** On-premises WAN gateway which allows access to on-cloud WAN subnet
*   **On-cloud WAN network details**

    The route which would be set on HDM components on the cloud. The routes will enable communication from the cloud components to HDM appliances on-premises.

    *   **On-cloud WAN subnet :** Subnet of cloud WAN network on which HDM appliances are deployed
    *   **On-cloud WAN gateway :** On-cloud WAN gateway which allows access to on-premises WAN subnet

<table>
  <tr>
   <td>
   </td>
   <td>
<strong>Example</strong>
   </td>
   <td><strong>Fill value here</strong>
   </td>
  </tr>
  <tr>
   <td><strong>On-Premises WAN subnet</strong>
   </td>
   <td><em>10.102.0.0/16</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>On-Premises WAN gateway</strong>
   </td>
   <td><em>10.102.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>On-cloud WAN subnet</strong>
   </td>
   <td><em>10.50.0.0/16</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>On-cloud WAN gateway</strong>
   </td>
   <td><em>10.50.10.1</em>
   </td>
   <td>
   </td>
  </tr>
</table>

