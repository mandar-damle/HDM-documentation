---
title: 'Org VDC System and Network Configuration'
---

This section, describes how to configure the VDC required for HDM deployment.

>> **To perform the configuration steps in this section can take from 30 to 60 minutes**

# Network Configuration

#### <a name="create-routed-network"> Step 1: Create Routed Network UPLINK_WAN_NETWORK</a>

This network will be connected to the edge gateway. Cross-WAN communications between on-premises and cloud will be routed through this network for the HDM Appliance. IPsec tunnels [step 3](#configure-vpn-tunnel-edge) will be configured to this network to complete the network configuration.

1. Select the _Virtual Data Center_ that will be the target of migration.
![Select ORG VDC](images/select-vdc.png?classes=content-img "Select Org VDC")

1. Select _Network_ -> _NEW_ to create a new network.
![Create new network](images/create-new-network.png?classes=content-img "Create new network")
1. Create a new network and select Routed Network Type
![alt_text](images/image4.png?classes=content-img "image_tooltip")

1. Provide the name “UPLINK_WAN_NETWORK” and Gateway CIDR for the network. Note the CIDR; this will be required when creating the VPN connection between on-premises and the edge gateway in the cloud.
![alt_text](images/image3.png?classes=content-img "image_tooltip")

1. Select the edge gateway 
![alt_text](images/image1.png?classes=content-img "image_tooltip")

1. Specify static-ip pool of at least 20 IP addresses
![alt_text](images/image8.png?classes=content-img "image_tooltip")

1. Add DNS records if required
![alt_text](images/image12.png?classes=content-img "image_tooltip")

1. Review, then select "Finish" to create the routed network
![alt_text](images/image14.png?classes=content-img "image_tooltip")

#### <a name="create-isolated-network">Step 2: Create Isolated Network HDM_INTERNAL_NETWORK</a>
    
This network will be created for HDM Appliance communications and for migrating virtual machines across vApps for the same VDC.

1. Create a new network and select "Isolated Network Type"

![alt_text](images/image18.png "image_tooltip")

2. Provide the name “HDM_INTERNAL_NETWORK” and Gateway CIDR for the network. Make sure enough IPs are available in the subnet, as this will be used for migrating virtual machines. The network will be assigned during migration and then removed post-migration.

![alt_text](images/image6.png "image_tooltip")

3. Specify static-ip pool or at least 30 IPs.

![alt_text](images/image5.png "image_tooltip")

4. Review, then select "Finish" to create the isolated network

![alt_text](images/image9.png "image_tooltip")

# System Configuration

## Configure vApp for HDM Deployment

The components of HDM need to be deployed on a vApp. If you don’t already have a vApp for this purpose, one will need to be created.

Attach the VDC network UPLINK_WAN_NETWORK and HDM_INTERNAL_NETWORK, both of which were created in steps 1 and 2, to the vApp where HDM will be deployed. 

**NOTE: HDM_INTERNAL_NETWORK should be added to all vApps where VMs will be migrated.**

![alt_text](images/image11.png "image_tooltip")
