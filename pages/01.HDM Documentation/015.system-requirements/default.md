<!-- Copy and paste the converted output. -->



# **HDM 2.1 for VMware**


# **System Requirements**

#### System Requirements

This document describes the system requirements for HDM deployment for test purposes. 


#### On-Premise Requirements



*   VMware Environment
    *   Single version of ESX throughout the vCenter cluster. 
    *   ESX in connected state in the vCenter
    *   ESX can communicate with vCenter
    *   Clusters with ESX 6.5U2+ and 6.7 are supported.
    *   vCenter Web Client: 6.5 or 6.7 (Use ofHTML client is recommended with Chrome v.75 +)
    *   Datastore should be one of: VMFS, NFS, NFSv3.
    *   E1000E and VMXNet3 network adapter should be available in On-Premise vCenter.
    *   DRS and HA should be enabled on the vCenter cluster. 
    *   Need credentials that will authenticate with the VMware endpoint. Single signon like Workspace ONE are not supported. 
*   Network requirement:
    *   Network: >= 1 Gbps..
    *   10 Gbps link is preferred. Anything greater than 1 Gbps would work though.
    *   PrimaryIO Appliance should have access to following network:
        *   VM Network (Management Network) - To access and manage virtual machines on 6.x the vcenter.
        *   VM Network will be used for connectivity to On-Cloud endpoint for HDM deployment and migration
        *   VM network will also provide access to ESXi. This is required for IOA Analysis and data transfer.
        *   PrimaryIO Appliance should be accessible from ESXi servers of the cluster from which VMs will be migrated
        *   PrimaryIO Appliance should be accessible from ESXi.
    *   PrimaryIO Appliance should have access to On-Cloud vCenter and ESXi at port 443.
    *   ESXi, with multiple IP addresses should provide access to port 22 and 443 from all IPs of PIO Appliance
*   Hardware requirements:
    *   Following are the resource requirements for HDM components for **Standard-Standalone **deployment
  

<table>
  <tr>
   <td>
On-Premise
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk), \
<strong>1</strong> PremMgr (3 vCPU, 4 GB RAM, 32 GB disk),
<p>
<strong>1</strong> ESXMgr (4 vCPU, 4GB RAM, 160 GB disk)
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>1 </strong>CloudMgr (4 vCPU, 6 GB RAM, 32 GB disk), \
<strong>1</strong> CloudCache (6 vCPU, 20 GB RAM, 32 GB disk, 512 GB cache)
   </td>
  </tr>
</table>



    Related document: For hardware requirements and system requirements refer to the [VMware Hardware Compatibility List (HCL).](https://www.vmware.com/resources/compatibility/search.php)

**Recommendations :**



*   PIO Appliance should be deployed on the same vCenter and datacenter which it would be managing. Recommendation is to deploy on a cluster not identified for migration.
*   HDM components should be deployed on Shared Datastore.


#### On-Cloud Requirements



*   Supported On-Cloud endpoints:
    *   VMware Cloud on AWS
    *   IBM Cloud for VMware Solution
    *   VMware Cloud Foundation SDDC
    *   VMware Cloud Director
*   HDM components should be deployed on Shared Datastore
*   Network connectivity between On-Premise and On-Cloud
    *   Network Link >= 1 Gbps
    *   Network Round Trip Time Latencies: &lt; 30 ms
*   Network requirement:
    *   On-Cloud HDM components should have access to the WAN network.
    *   On-Cloud VCenter and ESXi should be accessible from On-Premise at port 443.
    *   E1000E and VMXNet3 network adapter should be available in On-Cloud vCenter.
    *   Network on which HDM components are deployed should have access to On-Cloud vCenter at port 443 and On-Cloud ESXi at port 443 and 902.
    *   Firewall Rules for On-Cloud access for HDM:
        *   Port 22 - inbound and outbound
        *   Port 2379 - outbound 
        *   Port 6000-6010 - inbound and outbound
        *   Port 7000-7010 - inbound and outbound
        *   Port 8000-8010 - inbound and outbound
        *   Post 32820 - inbound and outbound


#### OS Support (TBC/ Warm Migration)

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

