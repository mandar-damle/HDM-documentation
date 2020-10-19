---
title: 'Org VDC System and Network Configuration'
---

By now you understand the use cases for HDM, the resources required, and the tradeoffs associated with each of the configurations in which HDM may be deployed.

In this section, we will show you how to configure the VDC required for HDM deployment.

# Network Configuration

#### <a name="create-routed-network"> Step 1: Create Routed Network UPLINK_WAN_NETWORK</a>

This network will be connected to the edge gateway. Cross-WAN communications between on-premises and cloud will be routed through this network for the HDM Appliance. IPsec tunnels [step 3](#configure-vpn-tunnel-edge) will be configured to this network to complete the network configuration.

1. Create a new network and select Routed Network Type

![alt_text](images/image4.png "image_tooltip")

2. Provide the name “UPLINK_WAN_NETWORK” and Gateway CIDR for the network. Note the CIDR; this will be required when creating the VPN connection between on-premises and the edge gateway in the cloud.

![alt_text](images/image3.png "image_tooltip")

3. Select the edge gateway 

![alt_text](images/image1.png "image_tooltip")

4. Specify static-ip pool of at least 20 IP addresses

![alt_text](images/image8.png "image_tooltip")

5. Add DNS records if required

![alt_text](images/image12.png "image_tooltip")

6. Review, then select "Finish" to create the routed network

![alt_text](images/image14.png "image_tooltip")

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

#### <a name="configure-vpn-tunnel-edge"> Step 3: Configure VPN tunnel with Edge Gateway </a>

Create an IPSec tunnel between the organization's edge gateway and the on-premises datacenter. To complete the VPN setting the following information will be required:

*   Local ID - Edge gateway tenant external network IP 
*   Local Endpoint - Edge gateway tenant external network IP
*   Local Subnets - Routed network subnet where HDM appliances will be deployed ([Create Routed Network](#create-routed-network))
*   Peer ID - Public IP for the on-premises WAN network
*   Peer Endpoint - Public IP for the on-premises WAN network
*   Peer Subnets - Subnet of the on-premises WAN network where HDM appliances will be deployed.

### Edge gateway VPN config 

![alt_text](images/image15.png "image_tooltip")

### Recommended firewall rules

Add recommended firewall rule by specifying source and destination subnet

![alt_text](images/image2.png "image_tooltip")

#### Service/Port level requirement for HDM(Advanced firewall rules)

1. On-premises WAN network - Cloud WAN network ports(Inbound/Outbound):** **22, 2379, 32820, 2376, 6000-6050, 7000-7050, 8000-8050.

![alt_text](images/image10.png "image_tooltip")

![alt_text](images/image17.png "image_tooltip")

You can test the IPsec connectivity using ping command from on prem to cloud side routed network gateway. If you have configured advanced firewall rules, ensure that ICMP traffic is allowed.

Ping test from on-premises to the cloud gateway

![alt_text](images/image7.png "image_tooltip")

To ping test from the cloud to the on-premises IP, a test machine will need to be created on the routed network in the cloud.

![alt_text](images/image16.png "image_tooltip")

# System Configuration

## Configure vApp for HDM Deployment

The components of HDM need to be deployed on a vApp. If you don’t already have a vApp for this purpose, one will need to be created.

Attach the VDC network UPLINK_WAN_NETWORK and HDM_INTERNAL_NETWORK, both of which were created in steps 1 and 2, to the vApp where HDM will be deployed. 

**NOTE: HDM_INTERNAL_NETWORK should be added to all vApps where VMs will be migrated.**

![alt_text](images/image11.png "image_tooltip")