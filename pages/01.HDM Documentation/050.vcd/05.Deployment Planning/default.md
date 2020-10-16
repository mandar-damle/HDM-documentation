## Deployment Requirements

HDM provides a flexible deployment model to support a wide range of user needs regarding use case, performance, scalability, and security. This section will help you choose the correct deployment type and network topology to support your needs. 


### Deployment Types 


#### Ultra-Lite, Lite, Standard, or Performance

HDM provides _ultra-lite_, _lite_, _standard_, and _performance_ deployment options. The trade-off between them is CPU and memory resource utilization, versus the concurrent migration capacity. Here are a few points to keep in mind when choosing the option that best fits your needs:



1. Ultra-lite is the least resource intensive of the options. However, it only supports cold migration, and only to vCD.
2. The lite option requires the least number of resources to support all HDM migration use cases. However, it is limited in migration parallelism and number of concurrently migrated VMs, compared to standard and performance deployment options.
3. The standard option is more scalable but requires more resources than the lite option, but is less scalable and requires fewer resources than the performance option.
4. The performance option requires the highest number of resources, but it provides the highest migration parallelism and number of concurrently migrated VMs.

More details on the resource requirements for these deployment options is available in the next section.**_ _**

**NOTE:_ _**Ultra-lite is the only Resource Allocation that supports migration to vCD.


#### Standalone or Cluster

You can choose either a standalone or cluster deployment mode, based on your scale and fault tolerance requirements. Here are a few points to keep in mind:



1. In standalone mode, a fixed number of HDM components are installed, regardless of the size of the on-premises cluster. Also, there is no HDM component redundancy in this mode, so fault tolerance is low.
2. In cluster mode, some HDM components are installed in proportion to the scale of the on-premises cluster to deliver higher redundancy and better fault tolerance. This requires higher resource consumption, but allows a higher number of concurrent migrations, than the standalone option.


### Concurrency and Scale Support 

HDM queues all migrations requests and is capable of processing eight VMDKs per HDM cluster node. 

	


### HDM Resource Requirements

Table 1 lists the resource requirements for each deployment type.

_Table 1: Resource Requirements_


<table>
  <tr>
   <td><em> </em>
   </td>
   <td><strong>Standalone</strong>
   </td>
   <td><strong>Cluster (N)</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Ultra-Lite</strong>
   </td>
   <td>
   </td>
   <td><em>NA</em>
   </td>
  </tr>
  <tr>
   <td>On-premises
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk)
<p>
<strong>1</strong> ESXMgr (4 vCPU, 4 GB RAM, 128 GB disk)
   </td>
   <td>1 Appliance (4 vCPU, 8 GB RAM, 144 GB disk)
<p>
2 ESXMgr (4 vCPU, 4 GB RAM, 128 GB disk)
   </td>
  </tr>
  <tr>
   <td>Cloud
   </td>
   <td><strong>1</strong> CloudCache (6 vCPU, 5 GB RAM, 64 GB disk)
   </td>
   <td>2 CloudCache (6 vCPU, 5 GB RAM, 64 GB disk)
   </td>
  </tr>
</table>


**NOTES**: 



1. The names _ESXMgr_ and _CloudCache_ are abbreviated names for the VMs containing HDM components. These are created as part of the HDM deployment.
2. The N in _Cluster (N)_ refers to the number of nodes in the cloud cluster.


### **Network Topology **

Your network topology choices determine how the HDM components will be configured within your network. It also dictates how VMs will be migrated to best support post-migration network security and VM isolation requirements. 

HDM provides the following network configuration flexibility:



1. Choice of networks HDM components should use
2. Choice of IP allocation type for HDM components


#### **Network Types**

An ideal network configuration isolates various types of network traffic for maximum security, performance, and access control. HDM assumes the following types of networks can be present in the environment:



1. Management Network (VM Network): This network usually maps to the VM network and provides access to vCenter. All management API communications with vCenter take place over this network.
2. ESXi Network (ESXi_Network): This network usually maps to the VM network and provides access to ESXi.
3. HDM Internal Network (HDM_Internal_Network): This network is used by HDM for communication among its components. It is recommended to configure a dedicated low latency network for this purpose. This network is illustrated in figure 2 as _PrimaryIO On-Premises_ and _PrimaryIO Cloud_.
4. WAN Network (Uplink_WAN_Network): This network provides access to the cloud. All data transfers between the on-premises and cloud environments take place over this network, via either a public link or a direct connection.
5. Application Network: This network facilitates application VM data transfers; each application can employ its own network.

_Figure 2: How HDM utilizes the various network types_


![drawing](images/image6.png)

**NOTES:**



1. During deployment, HDM components are configured to access necessary data store and meet component communication requirements.
2. During HDM deployment, discovered vCenter networks must be categorized according to the types discussed in this section (figure 3). 

_Figure 3: Selecting and Categorizing Networks_


![alt_text](images/image27.png "image_tooltip")


**NOTE: **While each traffic type should ideally employ its own network, configurations that allow one or multiple types of traffic to utilize the same network are also supported by HDM.


#### HDM Networking for Test: Single Network Topology

HDM can be deployed in test environments where there may not be separation between the various network types. In this situation, the network configuration would be simplified as illustrated in figure 4. In this case, you will need to map all of the “Source Networks” to the VM Network or the Management Network during the deployment process (figure 5).

_Figure 4: Test Environment Configuration_

![drawing](images/image5.png)

_Figure 5: Mapping Source and Destination Networks in a Single Network Test Environment_


![alt_text](images/image30.png "image_tooltip")



#### **IP Allocation**

HDM supports DHCP and static IP protocols. The protocol to be used must be selected during the HDM deployment process. When choosing static IP, an IP allocation range must be provided. The number of IPs required will depend on the number of nodes in the cluster and the deployment mode chosen. 

**NOTE**: HDM does not support the change of IP of its components (Appliance as well as other component VMs). Redeployment is required if IP for HDM components needs to be changed. 


### **OS Requirements**

There are no OS limitations for cold migration. 


## **Deployment checklist**



1. Prerequisite for Appliance Deployment
    1. Identify Datacenter on On-Premise vCenter on which HDM will be deployed - 
    2. Identify Management network for the Datacenter (Management Network) -  
        1. Static or DHCP
        2. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    3. Identify network on which ESXI are deployed (ESXi Network)- 
        3. Static or DHCP
        4. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    4. Identify WAN network which will have connectivity to On-Cloud environment (WAN network) - 
        5. Static or DHCP
        6. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    5. Create or Identify a network which will be used for HDM internal communication (ON_PREM_HDM_NETWORK) - 
        7. Static or DHCP
        8. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    6. Identify network which have access to internet

<table>
  <tr>
   <td>
Gateway 
   </td>
   <td>Network (either of 1.b, 1.c, 1.d, and 1.e)
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    7. Comma separated NTP server (Required) - 
    8. Comma separated DNS (Only if VCenter deployment is with FQDN) -
    9. Domain Search Path (Only if vCenter deployment is with FQDN) - 
2. On-Premise Deployment
    10. HDM deployment mode
        9. Ultra Lite Standalone
        10. Ultra Lite Cluster
    11. If required, add routes to access internet in appliance
    12. Cluster within the Datacenter identified for Migration - 
    13. Resource Pool within the cluster for HDM component deployment - 
    14. Shared datastore for HDM component deployment - 
    15. HDM Internal network configuration
        11. Static or DHCP
        12. If Static
            1. IP ranges 
                1. Standalone Ultra Lite - 1 IP required
                2. Cluster Ultra Lite - 2 IP required

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    16. WAN network configuration
        13. Static or DHCP
        14. If Static
            2. IP ranges 
                3. Appliance Only - NA
                4. Standalone Lite - 1 IP required
                5. Standalone Standard - 1 IP required
                6. Standalone Performance - 1 IP required
                7. Cluster Lite - 2 IP required
                8. Cluster Standard - 2 IP required (where n = # ESXi)
                9. Cluster Performance - 2 IP required  (where n = #ESXi)

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    17. ESXi network configuration
        15. Static or DHCP
        16. If Static
            3. IP ranges 
                10. Appliance Only - NA
                11. Standalone Lite - 1 IP required
                12. Standalone Standard - 1 IP required
                13. Standalone Performance - 1 IP required
                14. Cluster Lite - 2 IP required
                15. Cluster Standard - n IP required (where n = # ESXi)
                16. Cluster Performance - n IP required (where n = #ESXi)

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




3. On-Cloud Deployment
    18. DNS to resolve cloud Director FQDN if private - 
    19. If required (For On-Cloud not accessible over public network) add routes to access On-Cloud Director in appliance:
        17. Log into PIO Appliance over ssh - root/admin@123
        18. Add entry in /etc/pio.routes - &lt;ethernet_name>|&lt;cloud subnet>|&lt;prem_gateway>
        19. Execute ./setup_network.sh
    20. Virtual Data Center identified for Migration - 
    21. vApp for HDM component deployment - 
    22. Storage Policy for HDM component deployment - 
    23. HDM Internal network configuration
        20. Static or Static Pool or DHCP
        21. If Static
            4. IP ranges 
                17. Standalone Ultra Lite - 1 + m IP required (where m = # parallel migrated VM) - 
                18. Cluster Ultra Lite - 4 + m IP required (where m = # parallel migrated VM)

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    24. WAN network configuration
        22. Static or Static Pool or DHCP
        23. If Static
            5. IP ranges 
                19. Standalone Ultra Lite - 1 IP  required
                20. Cluster Ultra Lite - 2 IP  required

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    25. Network Routes
        24. Route from On-Premise to access On-Cloud

<table>
  <tr>
   <td>
 On-Cloud WAN subnet
   </td>
   <td>
 On-Premise WAN gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>


        25. Route from On-Cloud to access On-Premise

<table>
  <tr>
   <td>
On-Premise WAN subnet
   </td>
   <td>On-Cloud WAN gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    26. Network Map - On-Premise application network to On-Cloud application network