<!-- Copy and paste the converted output. -->


# **HDM 2.1.3 for VMware**


# **Network Configuration - Planning**

 	                        



# Introduction

This document describes the networking aspects of HDM. The HDM 2.1.3 Install Guide has the details of various types of network topologies that are supported. This document details the deployment and configuration of HDM for test purposes with a single network having Static IP. 

This document also covers the preparatory steps with respect to networking that users must perform prior to deploying HDM. 


# HDM Network Support

HDM provides the following flexibility for the network configuration:
1. Choice of networks HDM components should use
2. Choice of IP allocation type for HDM components (Static IP or DHCP)

**Network Types**

An ideal network configuration provides for isolation between types of network traffic, for maximum security, performance and access control. HDM assumes there could be following types of networks in the environment: 



1. Management Network (VM Network) : This usually maps to the VM network and provides access to vCenter. All management API communication with vCenter happens over this network.
2. ESXi Network (ESXi_Network): This usually maps to the VM network and provides access to ESXi.
3. HDM Internal Network (HDM_Internal_Network) : This network is used by HDM for communication among its components. It is recommended to have a dedicated low latency network be configured for this purpose. Depicted in image below as PIO OnPrem Network on On-Premise and PIO Cloud Network on On-Cloud.
4. WAN Network (Uplink_WAN_Network) - This network provides access to the cloud. All data transfer to and from premise to cloud happens over this network. This could be a public link or direct connection between On-Premise and On-Cloud.
5. Application Network : This network is used for data transfer by the Application VMs and each application can be accessed on its own network. So, a large number of application networks are possible. 

While HDM deployment has the flexibility of supporting separation of network traffic as mentioned in the previous section, for test purposes, HDM can also be deployed in environments where there may not be separation between all the types of networks mentioned above. In such situations, the network configuration would be as shown below : 


![alt_text](images/image10.jpg "image_tooltip")


In this case, all of the 4 networks would map to **_VM Network / Management Network. _**Users would still need to provide details for each of the networks separately. Users can divide the IP subnet into multiple ranges which can be mapped to these four networks. 

For example, for a network 10.102.0.0/16, we can have following IP ranges and can be used accordingly:



*   10.102.1.2 - 10.102.1.20 (VM Network)
*   10.102.1.21 - 10.102.1.40 (ESXi_Network)
*   10.102.1.41 - 10.102.1.60 (Uplink_WAN_Network)
*   10.102.1.61 - 10.102.1.80 (HDM_Internal_Networking)

During HDM deployment, users are required to categorise and map the networks discovered in the vCenter as per the types mentioned above. 



![alt_text](images/image13.png "image_tooltip")


In this case all of the “Source Networks” would map to **_VM Network / Management Network_** during the deployment process as shown below. 


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



#### Network requirements during on-premise deployment

During the premise deployment phase of the installation we will configure the following networks on prem.



1. HDM_Internal_Network
2. Uplink_WAN_Network
3. ESXi_Network

These are the same as the ones described in previous section on OVF Deployment. During the premise deployment however you need to provide a range or list of IPs for each of these networks.


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


    **Note:  **



1. **The subnet range 172.17.0.0/16 is not available for the deployment; it is internally used by HDM microservices.**

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

The following WAN routes are required to access on-cloud from on-premise and vice-versa.



*   **On-Prem WAN route**

    The route which would be set on HDM appliance on premise. The routes will enable communication from on-premise to HDM appliances on-cloud.

    *   **On-Cloud WAN subnet : **Subnet of cloud WAN network on which HDM appliances are deployed
    *   **On-Premise WAN gateway : **On premise WAN gateway which allows access to on-cloud WAN subnet
*   **On-Prem WAN route**

    The route which would be set on HDM appliance on cloud. The routes will enable communication from on-cloud to HDM appliances on-premise.

    *   **On-Premise WAN subnet : **Subnet of premise WAN network on which HDM appliances are deployed
    *   **On-Cloud WAN gateway : **On cloud WAN gateway which allows access to on-premise WAN subnet

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
   <td><strong>On-Cloud WAN subnet</strong>
   </td>
   <td><em>10.50.0.0/16</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>On-Premise WAN gateway</strong>
   </td>
   <td><em>10.102.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>On-Premise WAN subnet</strong>
   </td>
   <td><em>10.102.0.0/16</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>On-Cloud WAN gateway</strong>
   </td>
   <td><em>10.50.10.1</em>
   </td>
   <td>
   </td>
  </tr>
</table>


Again, HDM appliances on cloud will need to access Cloud vCenter and ESXi. If routes are requires, note the Network and the gateway which will allow access

**Cloud vCenter Route:**


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
   <td><strong>Route through</strong>
   </td>
   <td><em>10.50.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Network Type</strong>
   </td>
   <td><em>HDM Internal Network</em>
   </td>
   <td>
   </td>
  </tr>
</table>


**ESXi Route:**


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
   <td><strong>Subnet</strong>
   </td>
   <td><em>192.163.0.0/16</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Route through</strong>
   </td>
   <td><em>10.50.10.1</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>Network Type</strong>
   </td>
   <td><em>HDM Internal Network</em>
   </td>
   <td>
   </td>
  </tr>
</table>




