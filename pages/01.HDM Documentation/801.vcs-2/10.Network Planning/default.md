---
title:"Network Planning"
---

This needs to be planned well because the HDM components are configured in a certain way within the network. Choice of network topology also matters for VMs to be migrated. It is based on the network security and isolation requirements for the VM once it migrates to the On-Cloud. 

HDM provides the following flexibility for the network configuration:



1. Choice of the networks that HDM components should use
2. Choice of IP type for HDM components


#### **Network Types**

An ideal network configuration provides for isolation between types of network traffic, for maximum security, performance and access control. HDM assumes there could be following types of networks in the environment:



1. Management Network (VM Network) : This usually maps to the VM network and provides access to vCenter. All management API communication with vCenter happens over this network.
2. ESXi Network (ESXi_Network): This usually maps to the VM network and provides access to ESXi.
3. HDM Internal Network (HDM_Internal_Network) : This network is used by HDM for communication among its components. It is recommended to have a dedicated low latency network be configured for this purpose. Depicted in image below as PIO OnPrem Network on On-Premise and PIO Cloud Network on On-Cloud.
4. WAN Network (Uplink_WAN_Network) - This network provides access to the cloud. All data transfer to and from premise to cloud happens over this network. This could be a public link or direct connection between On-Premise and On-Cloud.
5. Application Network : This network is used for data transfer by the Application VMs and each application can be accessed on its own network. So, a large number of application networks are possible. 


#### HDM Networking for Production : Multiple Network Topology

The different network selection and their usage by HDM components is depicted below:



![drawing](images/image23.png)

During deployment, HDM components are configured such that the requirements for network access to necessary data stores, networks and communication with other components are met. For example, HDM doesn’t require access to application networks and so HDM components are not configured to access them. 

During HDM deployment, users are required to categorise and map and the networks discovered in the vCenter as per the types mentioned above. 




![alt_text](images/image2.png "image_tooltip")


**Note:** In an ideal case, different traffic should use different network type. However, a user may have one or multiple types of traffic using the same network. This is deemed as a valid configuration and supported by HDM.


#### HDM Networking for Test : Single Network Topology

While HDM deployment has the flexibility of supporting separation of network traffic as mentioned in the previous section, for test purposes, HDM can also be deployed in test environments where there may not be separation between all the types of networks mentioned above. In such situations, the network configuration would be simplified as shown below : 



![drawing](images/image41.png)

In this case all of the “Source Networks” would map to VM Network / Management Network during the deployment process as shown below. 



![alt_text](images/image39.png "image_tooltip")



#### IP Allocation

HDM supports both DHCP or static IP for its components. At deployment time, the user is asked with this choice.For static IPs, IP allocation range also has to be provided. Minimum IPs required can vary with the number of nodes in the cluster and the deployment mode chosen. 

**Note**: HDM does not support the change of IP of its components (Appliance as well as other component VMs). If you wish to change the IP of any HDM component, you need to redeploy the HDM.
