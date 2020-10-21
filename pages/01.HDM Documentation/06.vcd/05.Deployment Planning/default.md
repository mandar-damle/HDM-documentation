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
While deploying HDM users need to select a combination of Deployment Mode and Resource Allocation type. The features of the available options are provided below to guide the user to choose the deployment type that is best suited for his / requirements. HDM deployed components.

#### Deployment Mode : Standalone or Cluster

You can choose either a standalone or cluster deployment mode, based on your scale and fault tolerance requirements. Here are a few points to keep in mind:


1. In standalone mode, a fixed number of HDM components are installed, regardless of the size of the on-premises cluster. Also, there is no HDM component redundancy in this mode, so fault tolerance is low.
2. In cluster mode, some HDM components are installed in proportion to the scale of the on-premises cluster to deliver higher redundancy and better fault tolerance. This requires higher resource consumption, but allows a higher number of concurrent migrations, than the standalone option.


#### Resource Allocation : Ultra-Lite, Lite, Standard, or Performance

HDM provides _ultra-lite_, _lite_, _standard_, and _performance_ deployment options. The trade-off between them is CPU and memory resource utilization, versus the concurrent migration capacity. Here are a few points to keep in mind when choosing the option that best fits your needs:



1. Ultra-lite is the least resource intensive of the options. However, it only supports cold migration, and only to VCD.
2. The lite option requires the least number of resources to support all HDM migration use cases. However, it is limited in the number of parallel migrations and number of concurrently migrated VMs, compared to standard and performance deployment options.
3. The standard option is more scalable but requires more resources than the lite option, but is less scalable and requires fewer resources than the performance option.
4. The performance option requires the highest number of resources, but it provides the highest number of parallel migrations and number of concurrently migrated VMs.

More details on the resource requirements for these deployment options is available in the next section.**_ _**

**NOTE:_ _**Ultra-lite is the only mode that supports migration to vCD.



### Concurrency and Scale Support 

HDM queues all migrations requests and is capable of processing eight VMDKs per HDM cluster node. 

	


### HDM Resource Requirements

Table 1 lists the resource requirements for each ultra-lite deployment type.

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

