---
title: 'System Requirements'
---

#### On-Premises Requirements
##### VMWare Environment
* Single version of ESX throughout the vCenter cluster
* ESX in connected state in the vCenter
* ESX able to communicate with vCenter
* Clusters have ESX 6.5U2+ and 6.7 
* vCenter Web Client: 6.5 or 6.7 (Use of HTML client is recommended with Chrome v.75 +)
* Datastore should be VMFS, NFS, or NFSv3
* E1000E and VMXNet3 network adapters should be available in the on-premises vCenter
* DRS is enabled and HA should be enabled on the vCenter cluster 

##### Network Environment
* Network speed: at least 1 Gbps (10 Gbps link is preferred)
* VM Network has connectivity to the cloud endpoint 
* VM Network has access to ESXi

#### Hardware Requirements
On-premises
   </td>
   <td><strong>Total resources required for HDM</strong>
<p>
11 vCPU, 16 GB RAM, 336 GB disk
   </td>
Appliance (4 vCPU, 8 GB RAM, 144 GB disk), \
PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),
<p>
ESXMgr (4 vCPU, 4GB RAM, 160 GB disk)

Total resources required for HDM equivalent to
10 vCPU, 26 GB RAM, 64 GB disk, 512 GB Cache
CloudMgr (4 vCPU, 6 GB RAM, 32 GB disk), \
<strong>1</strong> CloudCache (6 vCPU, 20 GB RAM, 32 GB disk, 512 GB cache)

Related document: For hardware and system requirements, refer to the [VMware Hardware Compatibility List (HCL).](https://www.vmware.com/resources/compatibility/search.php)

Cloud Requirements
Network connectivity between on-premises and cloud environments
*   Network Link: at least 1 Gbps
*   Network Round Trip Time Latencies: less than 30 ms

 **NOTES**:

1. Currently, HDM only supports migration of one cluster per vCenter at a time. If VMs need to be migrated from multiple clusters, the process of deploy, migrate, and undeploy must be repeated for each of the clusters.
2. VM Network (Management Network), HDM_Internal_Network (HDM Internal Network), Uplink_WAN_Network (WAN Network) and ESXi_Network (ESXi Network) can map to a single network or multiple networks. In the event that a single network provides all of this functionality, details would still need to provided for each. In this case, the IP subnet can be divided into multiple ranges that can be mapped to each of the four networks.
 

<table>
  <tr>
   <td>
On-Premises
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk), \
<strong>1</strong> PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),
<p>
<strong>1</strong> ESXMgr (4 vCPU, 4GB RAM, 160 GB disk)
   </td>
  </tr>
  <tr>
   <td>In the Cloud
   </td>
   <td><strong>1 </strong>CloudMgr (4 vCPU, 6 GB RAM, 32 GB disk), \
<strong>1</strong> CloudCache (6 vCPU, 20 GB RAM, 32 GB disk, 512 GB cache)
   </td>
  </tr>
</table>



    Related document: For hardware requirements and system requirements refer to the [VMware Hardware Compatibility List (HCL).](https://www.vmware.com/resources/compatibility/search.php)

**Recommendations :**



*   The PrimaryIO Appliance should be deployed on the same vCenter and datacenter it will be managing. It is recommended to deploy on a cluster that will not be migrated.
*   HDM components should be deployed on a shared datastore.


#### Cloud Requirements



*   Supported cloud endpoints:
    *   VMware Cloud on AWS
    *   IBM Cloud for VMware Solution
    *   VMware Cloud Foundation SDDC
    *   VMware Cloud Director
*   HDM components should be deployed on Shared Datastore
*   Network connectivity between on-premises and the cloud
    *   Network Link >= 1 Gbps
    *   Network Round Trip Time Latencies: &lt; 30 ms
*   Network requirement:
    *   Cloud HDM components should have access to the WAN network.
    *   Cloud VCenter and ESXi should be accessible on-premises at port 443.
    *   E1000E and VMXNet3 network adapter should be available in  the cloud vCenter.
    *   Network on which HDM components are deployed should have access to the cloud vCenter at port 443 and the cloud ESXi at port 443 and 902.
    *   Firewall rules for HDM cloud access:
        *   Port 22 - inbound and outbound
        *   Port 2379 - outbound 
        *   Port 6000-6010 - inbound and outbound
        *   Port 7000-7010 - inbound and outbound
        *   Port 8000-8010 - inbound and outbound
        *   Post 32820 - inbound and outbound


#### OS Support (TBC/Warm Migration)

**Windows**


<table>
  <tr>
   <td><strong>Windows Version</strong>
   </td>
   <td><strong>Edition</strong>
   </td>
  </tr>
  <tr>
   <td>Windows Server 2012 R2 (64 bit)
   </td>
   <td>Standard
   </td>
  </tr>
  <tr>
   <td>Windows Server 2016 (64 bit)
   </td>
   <td>Standard
   </td>
  </tr>
  <tr>
   <td>Windows Server 2019 (64 bit)
   </td>
   <td>Standard
   </td>
  </tr>
</table>


**Linux**


<table>
  <tr>
   <td><strong>Linux Distributions</strong>
   </td>
   <td><strong>Version</strong>
   </td>
  </tr>
  <tr>
   <td>RHEL
   </td>
   <td>6.9, 6.10, 7.2, 7.3, 7.4, 7.5, 7.6
   </td>
  </tr>
  <tr>
   <td>SLES
   </td>
   <td>12-SP4
   </td>
  </tr>
  <tr>
   <td>CentOS
   </td>
   <td>7.6 (1810), 7.5 (1804), 7.4 (1708)
   </td>
  </tr>
  <tr>
   <td>Ubuntu Server	
   </td>
   <td>16.04, 18.04
   </td>
  </tr>
</table>

