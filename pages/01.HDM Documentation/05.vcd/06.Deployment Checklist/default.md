<!-- Copy and paste the converted output. -->

# Deployment Checklist 


# HDM 2.1 for VMware Cloud Director

The document lists the requirements and prerequisites that an admin will need for deploying HDM. Recommendation is to fill this document before deployment and use it for reference.


## **System Requirements**

Following are the system requirements for HDM deployment

**On-Premise Requirements**



*   VMware Environment
    *   HDM supports only a single version of ESX throughout the vCenter cluster. Currently, clusters with ESX version 6.5 and 6.7 are supported.
*   vCenter Web Client: 6.5 or 6.7 
    *   Please note that deployment of ovf from vCenter web client is the only supported Installation method.
    *   Using HTML client is recommended with Chrome v.75 +.. 
*   PIO Appliance should be deployed on the same vCenter and datacenter which it would be managing. Recommendation is to deploy on a cluster separate from the one which is going to be migrated.
*   PIO Appliance sizing: refer to HDM Resource Requirements section for appropriately sizing the PIO Appliance.
*   Datastore should be one of: VMFS, NFS, NFSv3.
*   HDM components should be deployed on a shared datastore.
*   DRS and HA should be enabled on the cluster.
    *   HA should be enabled only if there are more than 1 ESX in the vCenter cluster. 
*   E1000E and VMXNet3 network adapter support should be available on the On-Premise vCenter.
*   Hardware Environment
    *   Network: >= 1 Gbps.
*   Network requirement:
    *   An On-Premise network called ON_PREM_HDM_NETWORK needs to be created for HDM component interactions (**HDM Internal Network** mentioned in the “Network Types” section).

        **Note**: Creating a new network as ON_PREM_HDM_NETWORK is not a mandatory step. You can configure HDM such that HDM traffic goes through one of the existing networks. However having a separate network is recommended for network isolation.  

    *   10 Gbps link is preferred. Anything greater than 1 Gbps would work.
    *   PrimaryIO Appliance should have access to following network:
        *   VM Network (Management Network)  - To access and manage virtual machines on 6.x the vcenter.
        *   HDM_Internal_Network (HDM Internal Network) - For HDM component heartbeat and RTO/RPO data sync to On-Premise VMs
        *   Uplink_WAN_Network (WAN Network) - For connectivity to On-Cloud endpoint for HDM deployment and migration
        *   ESXi_Network (ESXi Network) - This usually maps to the VM network and provides access to ESXi. Required for IOA Analysis and data transfer.
        *   PrimaryIO Appliance should be accessible from ESXi servers of the cluster from which VMs will be migrated
        *   PrimaryIO Appliance should be accessible from ESXi servers of the cluster from which VMs will be migrated
    *   PrimaryIO Appliance should have access to On-Cloud organization.
    *   ESXi, having multiple IP addresses should provide access to port 22 and 443 from all IPs to PIO Appliance.

    Related document: For hardware requirements and system requirements refer to the [VMware Hardware Compatibility List (HCL).](https://www.vmware.com/resources/compatibility/search.php)


**Note**: Currently, HDM supports deployment for migration for only one cluster per vCenter at a time. If the VMs are to be migrated from multiple clusters, the process of deploy, migrate, undeploy would have to repeated for each of the clusters.

**Note: VM Network (Management Network), HDM_Internal_Network (HDM Internal Network), Uplink_WAN_Network (WAN Network) and ESXi_Network (ESXi Network) can map to a single or more networks. **

In case a single network that provides all these functionality, customers would still need to provide details for each. Here, customers can divide the IP subnet into multiple ranges which can be mapped to these four networks. 

For example, for a network 192.168.1.0/24, we can have following IP ranges and can be used accordingly:



*   192.168.1.2 - 192.168.1.20 (VM Network)
*   192.168.1.21 - 192.168.1.40 (ESXi_Network)
*   192.168.1.41 - 192.168.1.60 (Uplink_WAN_Network)
*   192.168.1.61 - 192.168.1.80 (HDM_Internal_Networking)


#### **On-Cloud Requirements**



*   Supported On-Cloud endpoints:
    *   VMware Cloud Director 9.7
    *   VMware Cloud Director 10.1
*   Network connectivity between On-Premise and on-cloud
    *   Network Link >= 1 Gbps
    *   Network Round Trip Time Latencies: &lt; 30 ms
*   Network requirement:
    *   Create ON_CLOUD_HDM_NETWORK (HDM Internal Network). All On-Cloud HDM components should be deployed on this network. Recommeded 10 Gbps link. 

        **Note**: Creating a new network as ON_CLOUD_HDM_NETWORK is not a mandatory step. You can configure HDM such that HDM traffic goes through one of the existing networks. However having a separate network is recommended for network isolation.

    *   On-Cloud HDM components should have access to WAN Network.
    *   On-Cloud organization should be accessible from On-Premise.
    *   Firewall Rules for On-Cloud access for HDM:
        *   Port 22 - inbound and outbound
        *   Port 2379 - outbound 
        *   Port 6000-6010 - inbound and outbound
        *   Port 7000-7010 - inbound and outbound
        *   Port 8000-8010 - inbound and outbound
        *   Post 32820 - inbound and outbound


### HDM Resource Requirements

Below table depicts the resources required for different deployment types.

**Note**: 



1. Here the names ESXMgr, CloudCache, PremMgr are abbreviated names of the VMs containing HDM components. These are created as part of the HDM deployment
2. **T**he N in Cluster (N) refers to the number of nodes in the cluster.

<table>
  <tr>
   <td>
<em> </em>
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
   <td>On-Premise
   </td>
   <td>1 Appliance (4 vCPU, 8 GB RAM, 144 GB disk)
<p>
1 ESXMgr (4 vCPU, 4 GB RAM, 128 GB disk)
   </td>
   <td>1 Appliance (4 vCPU, 8 GB RAM, 144 GB disk)
<p>
2 ESXMgr (4 vCPU, 4 GB RAM, 128 GB disk)
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>1</strong> CloudCache (6 vCPU, 5 GB RAM, 64 GB disk)
   </td>
   <td>2 CloudCache (6 vCPU, 5 GB RAM, 64 GB disk)
   </td>
  </tr>
</table>



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