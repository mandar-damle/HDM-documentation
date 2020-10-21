---
title: 'Deployment Planning'
media_order: ''
body_classes: ''
order_by: ''
order_manual: ''
---

### HDM Deployment

HDM provides a very flexible deployment model providing options to be able to cater to different user needs in terms of use case, performance, scalability and security. This needs to be selected as part of installation of on-premise components. 


![alt_text](images/image42.png?classes=content-img "image_tooltip")



#### HDM Deployment Types

While deploying HDM users need to select a combination of **Deployment Mode** and **Resource Allocation** type. The features of the available options are provided below to guide the user to  choose the deployment type that is best suited for their requirements. HDM deployed components. 


#### Deployment Mode : Standalone or Cluster

Based on the scale and failure tolerance requirements,  users can choose the standalone or cluster modes of deployment. Please note the following points:



1. In the standalone mode, a fixed number of HDM components are installed irrespective of the size of the cluster. Also, in this mode, there is no redundancy in the HDM components, which means less fault tolerance.
2. In the cluster mode, some of the HDM components are installed according to the scale of the cluster for a higher redundancy and better failure tolerance. This means more resource consumption as compared to the standalone option. Number of concurrent migrations is also higher than the standalone option. 


#### Concurrency and Scale Support 

Below table depicts the concurrency and scale support in various HDM deployment types

**Note: **Here, the N in Cluster (N) refers to the number of nodes in the On-Cloud cluster where HDM is deployed.


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


Note : In Ultra Lite mode HDM can process multiple requests for migration at a time. The requests will be queued by the system. The system will analyse the virtual machines and process 8 VMDKs at a time per node of the cluster. 


#### Resource Allocation : Ultra Lite, Lite, Standard or Performance

HDM provides the Ultra LIte, Lite, Standard or Performance resource allocation options of deployment. Trade off is mainly in terms of CPU and memory resource utilization vs the capacity for the number of concurrent migrations. Few points to remember:



1. Ultra Lite is less resource intensive and supports cold migration using PIO’s proprietary data transport. 
2. Lite mode is least resource intensive among other options. The parallelism of migration as well as the number of concurrently migrated VMs is limited here.
3. Standard mode is more scalable as compared to Lite mode and less than the Performance mode, resource requirement is higher in a similar proportion.. 
4. Performance mode has the highest resource requirement,  it provides the highest performance in terms of maximum parallelism during migration as well as number of migrated VMs On-Cloud.


#### HDM Resource Requirements

Below table depicts the resources required for different deployment types.

**Note**: 



1. Here the names ESXMgr, CloudCache, PremMgr and CloudMgr are abbreviated names of the VMs containing HDM components. These get created as part of the HDM deployment
2. The N in Cluster (N) refers to the number of nodes in the On-Cloud cluster.

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
<strong>1</strong> ESXMgr (4 vCPU, 4 GB RAM, 128 GB disk)
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


**Recommendation**: It is recommended to use the Standard-Standalone mode for test purposes and any of the Cluster modes for production purposes. 

