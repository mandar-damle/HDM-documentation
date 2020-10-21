<!-- Copy and paste the converted output. -->



# Deployment Checklist

The document lists the requirements and prerequisites that an admin will need for deploying HDM. Recommendation is to fill this document before deployment and use it for reference.


## **System Requirements**

Following are the system requirements for HDM deployment


### On-Premise Requirements



*   VMware Environment 
    *   PrimaryIO HDM only supports a single version of ESXi throughout the vCenter cluster. Currently, clusters with ESXi 6.5 and 6.7 are supported.
*   vCenter Web Client: 6.5 or 6.7. 
    *   Please note that deployment of ovf from vCenter web client is the only supported Installation method.
    *   Using HTML client is recommended. 
*   PIO Appliance should be deployed on the same vCenter and datacenter which it would be managing. Recommendation is to deploy on a cluster not identified for migration.
*   PIO Appliance sizing: refer to [resource requirement](https://docs.google.com/document/d/1IMu45eKXEkXlCjulAhM6yJBt8t3pNspq/edit#heading=h.4d34og8) for appropriately sizing the PIO Appliance.
*   Datastore should be one of: VMFS, NFS, NFSv3.
*   HDM components should be deployed on Shared Datastore.
*   DRS and HA should be enabled on the cluster.
    *   HA should be enabled only if there are more than 1 ESXi in the vCenter cluster.
*   Hardware Environment
    *   Network: >= 1 Gbps.
*   Browser: Chrome v.75 +.
*   Network requirement:
    *   Create an On-Premise ON_PREM_HDM_NETWORK for HDM component interactions. Recommeded 10 Gbps link.
    *   PrimaryIO Appliance should have access to following network:
        *   VM Network (Management Network)  - To access and manage virtual machines on 6.x the vcenter.
        *   HDM_Internal_Network (HDM Internal Network) - For HDM component heartbeat and RTO/RPO data sync to On-Premise VMs
        *   Uplink_WAN_Network (WAN Network) - For connectivity to On-Cloud endpoint for HDM deployment and migration.
        *   ESXi_Network (ESXi Network) - This usually maps to the VM network and provides access to ESXi. Required for IOA Analysis and data transfer.
        *   PrimaryIO Appliance should be accessible from ESXi servers of the cluster from which VMs will be migrated
        *   PrimaryIO Appliance should be accessible from ESXi.
    *   PrimaryIO Appliance should have access to On-Cloud vCenter and ESXi at port 443.
    *   PrimaryIO Appliance should have access to internet on port 8085.

    Related document: For hardware requirements and system requirements refer to the [VMware Hardware Compatibility List (HCL).](https://www.vmware.com/resources/compatibility/search.php)


**Note: VM Network (Management Network), HDM_Internal_Network (HDM Internal Network), Uplink_WAN_Network (WAN Network) and ESXi_Network (ESXi Network) can map to a single or more networks. **

In case a single network that provides all these functionality, customers would still need to provide details for each. Here, customers can divide the IP subnet into multiple ranges which can be mapped to these four networks. 

For example, for a network 192.168.1.0/24, we can have following IP ranges and can be used accordingly:



*   192.168.1.2 - 192.168.1.20 (VM Network)
*   192.168.1.21 - 192.168.1.40 (ESXi_Network)
*   192.168.1.41 - 192.168.1.60 (Uplink_WAN_Network)
*   192.168.1.61 - 192.168.1.80 (HDM_Internal_Networking)


### On-Cloud Requirements



*   Supported On-Cloud endpoints:
    *   VMware Cloud on AWS
    *   IBM Cloud for VMware Solution
    *   VMware Cloud Foundation SDDC
*   HDM components should be deployed on Shared Datastore.
*   Network connectivity between On-Premise and On-Cloud
    *   Network Link >= 1 Gbps
    *   Network Round Trip Time Latencies: &lt; 30 ms
*   Network requirement:
    *   Create ON_CLOUD_HDM_NETWORK. All other On-Cloud HDM components should be deployed on this network. Recommeded 10 Gbps link.
    *   On-Cloud HDM components should have access to WAN network.
    *   On-Cloud vcenter and esxi should be accessible from On-Premise at port 443.
    *   ON_CLOUD_HDM_NETWORK or WAN network  on which HDM components are deployed should have access to On-Cloud vCenter at port 443 and On-Cloud ESXi at port 443 and 902.
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



1. Here the names ESXMgr, CloudCache, PremMgr are abbreviated names of the VMs containing HDM components. These get created as part of the HDM deployment
2. **T**he N in Cluster (N) refers to the number of nodes in the On-Cloud cluster.

<table>
  <tr>
   <td>
<p style="text-align: right">
<em> </em></p>

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
  <tr>
   <td><strong>Lite</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>On-Premise
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk), \
<strong>1</strong> ESXMgr (4 vCPU, 4 GB RAM, 96 GB disk)
   </td>
   <td><strong>1 </strong>Appliance \
<strong>2</strong> ESXMgr
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>1</strong> CloudCache (6 vCPU, 12 GB RAM, 32 GB disk, 512 GB cache)
   </td>
   <td><strong>2</strong> CloudCache
   </td>
  </tr>
  <tr>
   <td><strong>Standard</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>On-Premise
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk), \
<strong>1</strong> PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),
<p>
<strong>1</strong> ESXMgr (4 vCPU, 4GB RAM, 160 GB disk)
   </td>
   <td><strong>1</strong> Appliance
<p>
<strong>2</strong> PremMgr, 
<p>
<strong>N</strong> ESXMgr
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>1 </strong>CloudMgr (4 vCPU, 6 GB RAM, 32 GB disk), \
<strong>1</strong> CloudCache (6 vCPU, 20 GB RAM, 32 GB disk, 512 GB cache)
   </td>
   <td><strong>2</strong> CloudMgr, \
<strong>N</strong> CloudCache
   </td>
  </tr>
  <tr>
   <td><strong>Performance</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>On-Premise
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk) \
<strong>1</strong> PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),
<p>
<strong>1</strong> ESXMgr (5 vCPU, 9 GB RAM, 288 GB disk)
   </td>
   <td><strong>1</strong> Appliance \
<strong>2</strong> PremMgr,
<p>
<strong>N</strong> ESXMgr
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>1</strong> CloudMgr (6 vCPU, 6 GB RAM, 32 GB disk), \
<strong>1</strong> CloudCache (8 vCPU, 40 GB RAM, 32 GB disk, 2 TB cache)
   </td>
   <td><strong>2</strong> CloudMgr, \
<strong>N</strong> CloudCache
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
        9. Appliance Only
        10. Standalone Lite 
        11. Standalone Standard
        12. Standalone Performance
        13. Cluster Lite
        14. Cluster Standard
        15. Cluster Performance
    11. If required, add routes to access internet in appliance
    12. Cluster within the Datacenter identified for Migration - 
    13. Resource Pool within the cluster for HDM component deployment - 
    14. Shared datastore for HDM component deployment - 
    15. HDM Internal network configuration
        16. Static or DHCP
        17. If Static
            1. IP ranges 
                1. Appliance Only - NA
                2. Standalone Lite - 1 IP required
                3. Standalone Standard - 2 IP required
                4. Standalone Performance - 2 IP required
                5. Cluster Lite - 2 IP required
                6. Cluster Standard - 2 + n IP required (where n = # ESXi) 
                7. Cluster Performance - 2 + n IP required (where n = #ESXi)

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
        18. Static or DHCP
        19. If Static
            2. IP ranges 
                8. Appliance Only - NA
                9. Standalone Lite - 1 IP required
                10. Standalone Standard - 1 IP required
                11. Standalone Performance - 1 IP required
                12. Cluster Lite - 2 IP required
                13. Cluster Standard - 2 IP required (where n = # ESXi)
                14. Cluster Performance - 2 IP required  (where n = #ESXi)

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
        20. Static or DHCP
        21. If Static
            3. IP ranges 
                15. Appliance Only - NA
                16. Standalone Lite - 1 IP required
                17. Standalone Standard - 1 IP required
                18. Standalone Performance - 1 IP required
                19. Cluster Lite - 2 IP required
                20. Cluster Standard - n IP required (where n = # ESXi)
                21. Cluster Performance - n IP required (where n = #ESXi)

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
    18. DNS to resolve vCenter FQDN if private - 
    19. If required (For On-Cloud not accessible over public network) add routes to access On-Cloud vCenter in appliance:
        22. Log into PIO Appliance over ssh - root/admin@123
        23. Add entry in /etc/pio.routes - &lt;ethernet_name>|&lt;cloud subnet>|&lt;prem_gateway>
        24. Execute ./setup_network.sh
    20. Cluster within the Datacenter identified for Migration - 
    21. Resource Pool within the cluster for HDM component deployment - 
    22. Shared datastore for HDM component deployment - 
    23. VM folder for HDM component deployment
    24. HDM Internal network configuration
        25. Static or DHCP
        26. If Static
            4. IP ranges 
                22. Appliance Only - NA
                23. Standalone Lite - 1 + m IP required (where m = # parallel migrated VM) - 
                24. Standalone Standard - 2 + m IP required (where m = # parallel migrated VM)
                25. Standalone Performance - 2 + m IP required  (where m = # parallel migrated VM)
                26. Cluster Lite - 4 + m IP required (where m = # parallel migrated VM)
                27. Cluster Standard - 2 + 2 * n + m IP required (where n = # ESXi and m = # parallel migrated VM)
                28. Cluster Performance - 2 + 2 * n + m IP required (where n = #ESXi and m = # parallel migrated VM)

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




    25. WAN network configuration
        27. Static or DHCP
        28. If Static
            5. IP ranges 
                29. Appliance Only - NA
                30. Standalone Lite - 1 IP  required
                31. Standalone Standard - 1 IP  required
                32. Standalone Performance - 1 IP  required
                33. Cluster Lite - 2 IP  required
                34. Cluster Standard - 2 + n  IP required (where n = # ESXi)
                35. Cluster Performance - 2 + n IP required (where n = #ESXi)

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




    26. Network Routes
    27. Route from On-Premise to access On-Cloud

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


    28. Route from On-Cloud to access On-Premise

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




    29. On-Cloud Route

<table>
  <tr>
   <td>
Gateway to access On-Cloud vCenter
   </td>
   <td>
On-Cloud WAN/ ON_CLOUD_HDM_NETWORK gateway
   </td>
   <td>
On-Cloud ESXi subnet
   </td>
   <td>
On-Cloud WAN/ ON_CLOUD_HDM_NETWORK gateway
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    30. Network Map - On-Premise application network to On-Cloud application network