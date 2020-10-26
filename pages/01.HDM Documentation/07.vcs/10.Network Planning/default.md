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

The different network selection and their usage by HDM components is depicted below:



![drawing](images/image23.png?classes=content-img)

During deployment, HDM components are configured such that the requirements for network access to necessary data stores, networks and communication with other components are met. For example, HDM doesn’t require access to application networks and so HDM components are not configured to access them. 

During HDM deployment, users are required to categorize and map and the networks discovered in the vCenter as per the types mentioned above. 




![alt_text](images/image2.png?classes=content-img "image_tooltip")


**Note:** In an ideal case, different traffic should use different network type. However, a user may have one or multiple types of traffic using the same network. This is deemed as a valid configuration and supported by HDM.


#### HDM Networking for Test : Single Network Topology

While HDM deployment has the flexibility of supporting separation of network traffic as mentioned in the previous section, for test purposes, HDM can also be deployed in test environments where there may not be separation between all the types of networks mentioned above. In such situations, the network configuration would be simplified as shown below : 



![drawing](images/image41.png?classes=content-img)

In this case all of the “Source Networks” would map to VM Network / Management Network during the deployment process as shown below. 



![alt_text](images/image39.png?classes=content-img "image_tooltip")



#### IP Allocation

HDM supports both DHCP or static IP for its components. At deployment time, the user is asked with this choice.For static IPs, IP allocation range also has to be provided. Minimum IPs required can vary with the number of nodes in the cluster and the deployment mode chosen. 

**Note**: HDM does not support the change of IP of its components (Appliance as well as other component VMs). If you wish to change the IP of any HDM component, you need to redeploy the HDM.
