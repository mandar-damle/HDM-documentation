---
title: 'Network Planning'
---

The network plan must be developed first, becuase the chosen network topology will affect how HDM components are configured. It also affects the way in which VMs are migrated, since this is based on the VMs network security and isolation requirements once it migrates to the cloud.

HDM enables the following network configuration flexibility:

1. Choice of networks that HDM components can use
2. Choice of IP type for HDM components


#### **Network Types**

An ideal network configuration provides isolation between various types of network traffic to deliver maximum security, performance, and access control. HDM supports the following types of networks:

1. Management Network (VM Network): This usually maps to the VM network and provides access to vCenter. All management API communications with vCenter occur over this network.
2. ESXi Network (ESXi_Network): This usually maps to the VM network and provides access to ESXi.
3. HDM Internal Network (HDM_Internal_Network): This network is used by HDM for communications among its components. A dedicated low latency network should be configured for this purpose. 
4. WAN Network (Uplink_WAN_Network): This network provides access to the cloud. All data transfers between the on-premises environment and the cloud occur over this network. A public link or a direct connection can be used.
5. Application Network: This network is used for data transfers by the application VMs and each application. A large number of application networks are supported to enable each application to utilize its own network. 


#### HDM Networking for Production : Multiple Network Topology

The various network selections and their usage by HDM components are illustrated below:

![drawing](images/image23.png?classes=content-img)

During deployment, HDM components are configured to meet network access requirements necessary data stores, networks, and other components. During the deployment process, users must categorize and map all of these discovered networks in vCenter. 

![alt_text](images/image2.png?classes=content-img "image_tooltip")

**Note:** Ideally, each traffic type should use a different network. However, a user may have one or multiple types of traffic using the same network. This is deemed as a valid configuration and supported by HDM.


#### HDM Networking for Test : Single Network Topology

While HDM deployment has the flexibility to support network traffic separation as mentioned in the previous section, for test purposes HDM can also be deployed in test environments where there may not be separation between the various types of networks mentioned above. In this situation, the network configuration would be simplified as illustrated below: 

![drawing](images/image41.png?classes=content-img)

In this case all “Source Networks” would map to the VM Network/Management Network during the deployment process as illustrated below:

![alt_text](images/image39.png?classes=content-img "image_tooltip")


#### IP Allocation

HDM supports DHCP and static IPs for its components. This choice will need to be made at deployment time. If static IPs are chosen, the IP allocation range must also be provided. The minimum number of required IPs will vary, based on the number of nodes in the cluster and the chosen deployment mode. 

**Note**: HDM does not support changing the IP address of any of its components (the appliance, as well as other component VMs). To change the IP of any HDM component, HDM will need to be redeployed.
