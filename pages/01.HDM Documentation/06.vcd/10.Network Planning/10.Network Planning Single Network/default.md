---
title: 'Network Planning'
published: false
---

This single network config is intended to help you rapidly deploy PrimaryIO HDM to a test environment. The steps are intended for a single on-premises network environment, with cloud access via a WAN link and no separation of the management and VM network. All IP assignments in this guide are static/static-pool and connectivity between the on-premises and cloud environments is via IPSec. HDM deployment considered here is the **_Standalone, Ultra-Lite_** option. This option supports all the key features of HDM and can also be used for cold migration and validation purposes. 

Network configuration information is required at key points throughout the deployment process. So, develop a network connectivity plan prior to deploying HDM. This section will help guide you through that process. The information captured in this section will be employed later in the installation process. If an IPSec tunnel and cloud configuration have not yet been established, these must be done before moving any further. 

Once connectivity and cloud configuration are complete, be sure to record all applicable details in the tables at the end of this section for easy reference later in the deployment process. 

The following is required to complete the network plan: 


1. Network requirements during OVF deployment
1. Network requirements during on-premises deployment
1. Network requirements during cloud deployment

```
Choose or Create an appropriate network:

A simple network configuration where all connectivity to the cloud is available through one network (e.g., hdm_network). Here hdm_network should have access to the following:
* On-premises vCenter 
* Cloud vCenter via WAN link
* On-premises ESXi
* Cloud ESXi
* HDM Appliance

The required connectivity is highlighted in figure 1. For all steps in the deployment that require a VMware network as input, provide the identified or created hdm_network. It will also be necessary to create two networks in the cloud, hdm_routed_network and hdm_internal.

Failure to create, choose, or configure the networks correctly will cause the installation to fail.
```
Figure 1: Network Configuration of the Test Environment
![alt_text](images/image1-qsg.png "image_tooltip")


The remainder of this document will assume you have created a network topology like the one shown in Figure 1, and will refer to the networks by those names. In this configuration, all access has been made possible using single VM network, _hdm_network_.

You will need to provision 

*   20 static IPs on Premise network
*   At least 50 static-pool IPs on Cloud network

These will be required throughout the installation process.

```
NOTE: 
Despite the fact that you will be mapping to a single network, separate IP ranges will need to be provided for each network type.
The subnet range 172.17.0.0/16 is not available for the deployment; it is used internally by HDM microservices.
Please add the vCenter FQDN for the on-premises and cloud vCenters on the on-premises and cloud DNS servers.
```

### Network planning sheet

Please download this [spread sheet](../../../Planning%20Template.xlsx) and use along with
your deployment process.

1. Choose the "Cloud Type"
1. Choose the "Deployment Mode"
1. Choose the "Resource Allocation" 

After this you need to fill in the nuber of ESXi on premises and on the cloud. For vCD
the number of nodes on the cloud is irrelevant and please fill in 1 here.

The rest of the form requires you to fill in network configuration details like
IP address, ranges. The dynamic part of the form gives you information on the 
number of the resources you need to provision. 

