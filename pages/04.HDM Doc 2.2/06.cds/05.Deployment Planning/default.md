---
title: 'Deployment Planning'
media_order: ''
body_classes: ''
order_by: ''
order_manual: ''
---

## Deployment Requirements

HDM provides a flexible deployment model to support a wide range of user needs with respect to use cases, performance, scalability, and security. This section will help you choose the correct deployment type and network topology to support your needs. 


![alt_text](images/image42.png?classes=content-img "image_tooltip")


### HDM Deployment Types 
While deploying HDM users need to select a combination of Deployment Mode and Resource Allocation type. The features of the available options are provided below to guide the user to choose the deployment type that is best suited for their requirements.

#### Deployment Mode : Standalone or Cluster

You can choose either a standalone or cluster deployment mode, based on your scale and fault tolerance requirements. Here are a few points to keep in mind:


1. In standalone mode, a fixed number of HDM components are installed, regardless of the size of the on-premises cluster. Also, there is no HDM component redundancy in this mode, so fault tolerance is low.
2. In cluster mode, some HDM components are installed in proportion to the scale of the on-premises cluster to deliver higher redundancy and better fault tolerance. This requires higher resource consumption, but allows a higher number of concurrent migrations, than the standalone option.


#### Resource Allocation : Ultra-Lite, Lite, Standard, or Performance

HDM provides _ultra-lite_, _lite_, _standard_, and _performance_ deployment options. The trade-off between them is CPU and memory resource utilization, versus the concurrent migration capacity. Here are a few points to keep in mind when choosing the option that best fits your needs:



1. Ultra-lite is the least resource intensive of the options. However, it only supports cold migration, and only to Cloud Director.
2. The lite option requires the least number of resources to support all HDM migration use cases. However, it is limited in the number of parallel migrations and number of concurrently migrated VMs, compared to standard and performance deployment options.
3. The standard option is more scalable but requires more resources than the lite option, but is less scalable and requires fewer resources than the performance option.
4. The performance option requires the highest number of resources, but it provides the highest number of parallel migrations and number of concurrently migrated VMs.

More details on the resource requirements for these deployment options is available in the next section.**_ _**

**NOTE:_ _**Ultra-lite is the only mode that supports migration to vCD.




### Concurrency and Scale Support 

HDM queues all migration requests and is capable of processing eight VMDKs per HDM cluster node. 

	


### HDM Resource Requirements



The following table highlights the amount of concurrency and scalability supported by each HDM deployment type:

**Notes: 
1. The names _ESXMgr_ and _CloudCache_ are abbreviated names for the VMs containing HDM components. These are created as part of the HDM deployment.**
2. The N in _Cluster (N)_ refers to the number of nodes in the cloud cluster where HDM is deployed.


<table>
  <tr>
   <td>
   </td>
   <td><strong>Concurrent</strong>
<p>
<strong>Cold Migrations</strong>
   </td>
   <td><strong>Compute</strong>
<p>
<strong>Migrated VMs</strong>
<p>
<strong>On-Cloud</strong>
   </td>
   <td><strong>Concurrent</strong>
<p>
<strong>Warm Migrations</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Lite</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Standalone
   </td>
   <td>8
   </td>
   <td>10
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>Cluster (N)
   </td>
   <td>8
   </td>
   <td>2 x 10
   </td>
   <td>N x 2
   </td>
  </tr>
  <tr>
   <td><strong>Standard</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Standalone
   </td>
   <td>8
   </td>
   <td>20
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td>Cluster (N)
   </td>
   <td>8
   </td>
   <td>N x 20
   </td>
   <td>N x 4
   </td>
  </tr>
  <tr>
   <td><strong>Performance</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Standalone
   </td>
   <td>8
   </td>
   <td>25
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>Cluster (N)
   </td>
   <td>8
   </td>
   <td>N x 25
   </td>
   <td>N x 8
   </td>
  </tr>
</table>





Table 1 lists the resource requirements for each deployment type.

_Table 1: Resource Requirements_


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
   <td><strong>Ultra Lite</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>On-Premise
   </td>
   <td><strong>1</strong> Appliance (4 vCPU, 8 GB RAM, 144 GB disk)
<p>
<strong>1</strong> ESXMgr (8 vCPU, 8 GB RAM, 128 GB disk)
   </td>
   <td>1 Appliance (4 vCPU, 8 GB RAM, 144 GB disk)
<p>
2 ESXMgr (8 vCPU, 8 GB RAM, 128 GB disk)
   </td>
  </tr>
  <tr>
   <td>On-Cloud
   </td>
   <td><strong>1</strong> CloudCache (6 vCPU, 12 GB RAM, 64 GB disk)
   </td>
   <td>2 CloudCache (6 vCPU, 12 GB RAM, 64 GB disk)
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
<strong>1</strong> ESXMgr (8 vCPU, 8 GB RAM, 96 GB disk)
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




**Recommendation**: While any of the cluster modes can be used in the production environment, the Standard-Standalone mode is recommended for the test environment.

### Prepare Cloud for Deployment

To deploy the HDM solution on  _VMware Cloud Director/Cloud Director Service_ you would
need to

* Get the _Organization Administrator_ access credentials to the Cloud Director tenant portal.
* Identify the organization ID and save for later use.
* Create a new user with administrator privilege.

**Identify the organization ID**

* Login to the tenant portal
* The Organization ID can be identified from the location in  _Figure 1_

_Figure 1: Screenshot show how to identify Organization ID_
![Organization Id](images/CDS-Organization-id.png?classes=content-img "Screenshot showing how to find organization id") 


**Create new user with Organization Administrator privilege**

We recommend the creation of a new organization administrator for HDM integration.
We refer to this administrator in the rest of the documentation.

1. Create the new Org administrator user using procedure [here to create new user.](https://docs.vmware.com/en/VMware-Cloud-Director/10.1/VMware-Cloud-Director-Tenant-Portal-Guide/GUID-1CACBB2E-FE35-4662-A08D-D2BCB174A43C.html) 
1. Make sure you give it the **Organization Administrator** role see _Figure 2._


__Figure 2: Setting role for created user to **Organziation Administrator**__
![](images/organization-administrator.png?classes=content-img)

__Figure 3: Set the quota to unlimited__
![](images/quota.png?classes=content-img)

From the steps above please capture the information in the table below. 
The username is the newly created user with administrator privileges. You will need 
this part of the cloud deployment.

|vCloud Director FQDN| _ |
| :--| --- |
|Organization Name | _ |
|Username  | _ |
|Password | _ |
