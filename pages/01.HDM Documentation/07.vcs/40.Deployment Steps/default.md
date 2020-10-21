---
title: 'Deployment Steps' 
---

This section describes how to deploy, configure, and undeploy PrimaryIO Hybrid Cloud Data Management (HDM) 2.1.3 for enabling migrations of virtual machines to VMware Cloud Director (VCD).


## HDM Deployment Steps

HDM deployment involves the following six steps, each of which is discussed in detail in the sections below:

1. Deploy HDM Appliance on On-Premise
2. Add On-Premise vCenter to the Appliance
3. Register HDM Plugin to On-Premise vCenter
4. Add HDM License
5. Deploy HDM On-Premise
6. Deploy HDM On-Cloud

### Step 1/6  : Deploy HDM Appliance 

HDM Appliance manages both On-Premise and On-Cloud HDM operations. This section covers the following topics for deployment and configuration of HDM Appliance, please follow the instructions carefully:



1. Placement of the HDM Appliance on On-Premise
2. System Requirements for the Appliance 
3. Network Requirements
4. Deployment and configuration
5. Network Configuration for the Appliance
6. Adding the vCentre


#### Placement of HDM Appliance



1. It must be deployed on the same On-Premise vCenter which it needs to manage.
2. It should ideally be kept in a separate cluster than the one it is supposed to manage.


#### Deployment and Configuration

HDM Appliance is deployed from the OVF shipped as part of the HDM package. Please ensure that the placement and sizing of the deployment conforms to the requirements mentioned above.

Use the **Deploy OVF Template **option in vCenter to deploy the Appliance as shown below:


![alt_text](images/image55.png?classes=content-img "image_tooltip")



#### Network Configuration

Appliance network configuration requires the user to specify the available networks into 4 categories as described in the network requirements section and HDM Resource Requirements sections above.

In the simplest case, these networks can point to the same network. But best practice is to have them separate.

Also, it should be specified whether the Appliance should have static IP or DHCP.



![alt_text](images/image2.png?classes=content-img "image_tooltip")



#### IP Address Details

For all the 4 categories of network, choose the IP allocation mechanism : static or DHCP.

For static IP, following details are also required 



*   IP range : IP list that are free to be allocated for 
*   Subnet mask : subnet of the IP range
*   Gateway : gateway IP of the network
*   Domain : domain name of the network
*   DNS : to translate the domain name to IP
*   NTP : for time sync

Networks with DHCP, can skip this configuration.

**Note**: 



1. NTP server must be specified for static IP configuration. Not providing this input may cause a lot of further HDM operations to fail.
2. In case of static IP, gateway IP and the IP range specified should be in the same subnet.


![alt_text](images/image57.png?classes=content-img "image_tooltip")

#### Gateway settings

The setting in **Default gateway network** should be chosen so
that traffic for other subnets can be rounted through this interface. This would 
generally be the WAN network but please verify the specifics for
your network.

In the field **Default Gateway** set the default gateway for the 
network chosen under **Default gateway network**. 

> **Getting this wrong will cause deployment to fail eventually and you will have to perfrom an [HDM Reset](../../hdm%20reset)**

_Figure 8b: Configuring gateway, NTP and default gateway_
![alt_text](images/Gateway-OVF.png?classes=content-img)


#### Power on the Appliance

Go through the rest of the wizard and wait for the deployment to complete. Once the deployment is done, power on the Appliance from the vCenter.


#### Enable VMware HA on the Appliance

(_This step should be performed only for Cluster mode deployments of HDM_)

vmware HA should be enabled on the cluster on which Appliance has been deployed. For this, follow the below procedure



1. In the On-Premise vCenter, select the cluster on which Appliance is deployed
2. On the right hand pane, click on Configure tab and go to Services -> vSphere Availability
3. If the vSphere HA is Turned OFF, click on EDIT and enable vSphere HA


### Step 2/6 : Add On-Premise vCenter to the HDM Appliance

**Note**: The On-Premise vCenter to be added should be the same as where the HDM Appliance is deployed. 

Pre-requisites



1. Ensure that HDM Appliance is powered on and you have valid vCenter administrator credentials.

Steps



1. Log into the _PIO Appliance_ by accessing _https://&lt;appliance ip>_ in a supported web browser and entering the administrator credentials. The default administrator username and password are _‘administrator’_ and _‘2Hdm$aK!N@h!’_ respectively. Users are recommended to change the default password after the first login.
2. Click on **vCenters** in the top pane.
3. Click on **Add vCenter** at the top right.


![alt_text](images/image56.png?classes=content-img "image_tooltip")


4. Specify the On-Premise vCenter IP or FQDN by which the vCenter is configured while its installation along with administrator credentials and click **Add vCenter**.
5. You should see the PIO Appliance now listing the On-Premise vCenter



![alt_text](images/image58.png?classes=content-img "image_tooltip")




### Step 3/6 : Register HDM Plugin to vCenter



6. Click on **Register** to register the HDM plugin to On-Premise vCenter.
7. Logout and login twice(and sometimes more) from the vCenter for the plug-in installation to complete. Successful installation should add a HDM icon in the vCenter home page.


![alt_text](images/image59.png?classes=content-img "image_tooltip")



    **Note**:  The PrimaryIO vCenter plugin will be automatically registered on all vCenters that are configured in _enhanced linked mode_.



### Step 4/6 : Add HDM License

For HDM deployment a license key is required to activate the product.  A trial license will be shared with the product which can be used to activate HDM. 

**Note**: Loading the HDM configuration page may take a few mins to load as product settings need to be initialised. 

Steps to add license:



1. In the On-Premise vCenter, click on PrimaryIO from Shortcuts or from Menu to access the PrimaryIO dashboard
2. Select **Administration** from the tab
3. Click on **License** to, add or list existing license.
4. Click on **Add License** to open a popup where the given **Trial license** can be pasted. 



![alt_text](images/image31.png?classes=content-img "image_tooltip")




5. Copy and paste shared license key and click on **OK**.



![alt_text](images/image60.png?classes=content-img "image_tooltip")




6. Once the license has been added, it will be listed on the licence page.
7. The same interface can then be used to add **Product License**.

![alt_text](images/image44.png?classes=content-img "image_tooltip")



### Step 5/6 : Deploy HDM On-Premise

This section covers the steps for completing the deployment of HDM On-Premise. The topics covered in this section are as follows:



1. Select a cluster for HDM deployment 
2. Select HDM deployment mode
3. Select HDM resource allocation
4. Network configuration 
5. Complete the deployment

On-Premise deployment may take anywhere between 10-20 mins depending on the network bandwidth and storage. Any failure-retries done by product during the deployment process are logged into vCenter events. **hdm** or **com.primaryio** keyword can be used in vCenter event search to search for events generated by HDM.

Pre-requisites 

It is assumed that the HDM Appliance deployment and configuration has been executed successfully. Ensure that Plugin has been registered on vCenter and HDM icon is visible in the vCenter home screen. A valid HDM license has been added to activate the product.

Steps for deployment



1. In the On-Premise vCenter, click on PrimaryIO from Shortcuts or from Menu to access the PrimaryIO dashboard
2. Select **Administration** from the tab
3. Click on **Configuration** to access the On-Premise cluster listing. 

![alt_text](images/image61.png?classes=content-img "image_tooltip")




4. Select a cluster on which the HDM product should get installed. And then click on **Install**.
    1. This will open a wizard to select resources for HDM component deployment.
5. Verify that the Appliance IP is correct. 
6. Select deployment mode based on the scale and failure tolerance requirements On-Premise and on On-Cloud. See section Deployment Requirements for details on different deployment mode.
7. Select resource allocation based on size and resource requirements. See section Deployment Requirements for details on different allocation types.


![alt_text](images/image42.png?classes=content-img "image_tooltip")




8. Select resource pool and shared datastore where HDM components should be deployed.



![alt_text](images/image46.png?classes=content-img "image_tooltip")


PS: Make sure enough resources are available on On-Premise and on On-Cloud  when selecting deployment modes. 



9. Specify Network Configurations

    Administrator can either use DHCP or Static for IP address allocation. For static IP address allocation, administrator would need to specify unused IP address or IP ranges along with gateway, subnet mask, domain search path along with one or more DNS and NTP server.  More details on these inputs are present in Deployment Requirements section. Administrator will have to repeat the steps for:

1. HDM Internal Network (HDM_Internal_Network)
2. WAN Network (Uplink_WAN_Network)
3. ESXi Network (ESXi_Network)


**Note:**
1. **If all are mapping to single network, separate IP ranges will still need to be provided for each of the network type.**
2. **The subnet range 172.17.0.0/16 is not available for the deployment; it is internally used by HDM microservices.**



![alt_text](images/image47.png?classes=content-img "image_tooltip")




10. Confirm the selection and submit the Installation request by clicking on FINISH button.
![alt_text](images/image48.png?classes=content-img "image_tooltip")

11. This will create a deployment task which can be monitored from vcenter tasks. Also, the deployment progress can be seen in the HDM configuration view:


![alt_text](images/image43.png?classes=content-img "image_tooltip")




2. Wait for the deployment task to finish.


## 

![alt_text](images/image50.png?classes=content-img "image_tooltip")



### Step 6/6 : Deploy HDM On-Cloud

This section covers the steps for deployment of HDM On-Cloud; it assumes that the deployment of HDM On-Premise has been executed successfully. 

The topics covered in this section are as follows:



1. Prerequisites for On-Cloud deployment
2. Add a Cloud
3. Select Cluster, resource pool, data store for HDM
4. Network Configuration - multiple networks to be configured 
5. Finish deployment

Add On-Cloud may take anywhere between 20-30 mins depending on the WAN bandwidth and WAN latency. Any failure-retries done by product during the deployment process are logged into vCenter events. **hdm** or **com.hdm** keyword can be used in vCenter event search to search for events generated by HDM.

Pre-requisites 



1. Ensure that HDM Plugin has been registered on vCenter and HDM icon is visible on the home screen. 
2. Ensure On-Premise deployment is done successfully.
3. Ensure that vCenter On-Cloud is reachable from HDM Appliance. If On-Cloud vCenter is on WAN network and WAN network is not reachable through the Appliance’s default route, then a static entry needs to be added on the HDM Appliance to reach the On-Cloud vCenter. This can be done through the following steps
    1. vim /etc/pio.routes and add the entry `ens256|&lt;cloud_subnet>|&lt;gateway_to_access_cloud>`

        Example:  ens256|10.3.0.0/24|10.1.0.1

    2. /usr/bin/setup/network.sh

Steps for deployment



1. In the On-Premise vCenter, click on HDM from Shortcuts or from Menu to access the HDM dashboard
2. Select **Administration** from the tab
3. Click on **Clouds** to access the On-Cloud listing


![alt_text](images/image52.png?classes=content-img "image_tooltip")




4. Click on **Add Cloud**
    1. This will open a wizard to select resources for HDM component deployment.
5. Select the On-Cloud type and enter On-Cloud credentials and the On-Cloud DNS. 

    **Note**: In current release, the On-Cloud type is just notional, deployment doesn’t change based  On-Cloud type selection.




![alt_text](images/image1.png?classes=content-img "image_tooltip")



![alt_text](images/image21.png?classes=content-img "image_tooltip")




6. Select cluster, resource pool,  datastore and VM folder On-Cloud where HDM component should be deployed. 

    **Note**: Select shared datastore On-Cloud when deploying HDM component.


![alt_text](images/image15.png?classes=content-img "image_tooltip")




7. Select network and IP configuration for ON_CLOUD_HDM_NETWORK, which will be used by HDM to do the VM boot and subsequent IO handling through the HDM components.

    Administrator can either use DHCP or Static for IP address allocation. For static IP address allocation, administrator would need to specify unused IP address or IP ranges along with gateway, subnet mask, domain search path along with one or more DNS and NTP server.



![alt_text](images/image16.png?classes=content-img "image_tooltip")




8. Select network IP configurations for WAN 

    Administrator can either use DHCP or Static for IP address allocation. For static IP address allocation, administrator would need to specify unused IP address or IP ranges along with gateway, subnet mask, domain search path along with one or more DNS and NTP server. 



![alt_text](images/image17.png?classes=content-img "image_tooltip")




9. Set WAN route configuration so that data traffic from On-Cloud to On-Premise is possible. See Deployment Requirements section for details.



![alt_text](images/image18.png?classes=content-img "image_tooltip")




10. If you have warm migration use case, you should set routing rules to access On-Cloud vCenter on port 443 and ESXi on port 443 and 902. Also need to specify which network out of HDM Internal Network or WAN Network be used for routing.



![alt_text](images/image37.png?classes=content-img "image_tooltip")




11. Select network mapping so that the network categorization done On-Premise gets percolated to On-Cloud 



![alt_text](images/image19.png?classes=content-img "image_tooltip")




12. Confirm the selection and click on **Finish** to submit the request.


![alt_text](images/image13.png?classes=content-img "image_tooltip")




13. This will create deployment tasks for On-Cloud components deployment. The task can be monitored in vCenter Tasks. Also, the progress can be seen in HDM configuration view. 



![alt_text](images/image24.png?classes=content-img "image_tooltip")




14. Wait for the deployment task to finish.


![alt_text](images/image20.png?classes=content-img "image_tooltip")




## DNS Entry to resolve FQDN

In case On-Cloud vCenter or ESXii has been added with FQDN, the user should add the DNS nameserver in HDM cloud cache component explicitly, using the following procedure:



1. Login to the On-Cloud vCenter
2. User should find HDM cloud cache component VMs with name ‘HDM-Cloud-Cache-*’.
3. ssh into each HDM cloud cache component VM with root credentials and password ‘admin123’
4. Set the DNS server in /`etc/resolv.conf` required for resolving the FQDN
5. Ensure FQDN is reachable using ping command


## Deployment Validation

Once the deployment On-Premise and On-Cloud is complete, we have few ways to view the deployed components and their states.


### Appliance View

After successful installation of HDM On-Cloud, the Appliance control panel shows the list of components and their health. 


![alt_text](images/image22.png?classes=content-img "image_tooltip")


Figure: HDM components after the deployment

In addition to the Appliance Control Panel this information is also available on vCenter on the HDM plugin.

Menu > HDM > Administration > HDM Health > Component Health



![alt_text](images/image45.png?classes=content-img "image_tooltip")



### On-Premise vCenter

After successful On-Cloud deployment, the On-Premise vCenter should show the On-Cloud state as installed in the PrimaryIO -> Administration -> Clouds view. 



![alt_text](images/image40.png?classes=content-img "image_tooltip")



## Enable IO Monitoring

**Notes**: 



1. This step is not required for cold migration.
2. For Lite standalone and Lite cluster deployment modes, this step only creates the SPBM policy and attaches to VMs in the cluster, but doesn’t do detailed IO profiling.

HDM requires the VMs On-Premise to be monitored for IO by HDM. Monitoring helps in 



1. Estimating the cloud cache size requirement for a given VM 
2. Whether the VM is a suitable candidate for  migration

This is done by creating HDM SPBM policy of cache type and applying that policy to the existing VMs. Detailed steps are given below:

Pre-requisites 



1. Ensure On-Premise installation is done successfully.
2. Ensure that there is no HDM SPBM policy named ‘HDM Analyzer Profile’ already existing from previous attempts of HDM installations. This can be done using below steps
    1. In the On-Premise vCenter, go to Home -> Policies and Profiles -> VM Storage Policies
    2. If you see ‘HDM Analyzer Profile’, delete it

Steps



1. In the On-Premise vCenter, click on PrimaryIO from Shortcuts or from Menu to access the PrimaryIO dashboard
2. Select **Administration** from the tab
3. Click on **Configuration** to access the cluster listing.
4. Against the cluster on which HDM is installed, click on **Enable** under monitoring. This will open a popup.

![alt_text](images/image49.png?classes=content-img "image_tooltip")




5. Click on **OK** to enable monitoring.

This will create a _‘SPBM _policy of cache type for HDM. The default name for the policy is **HDM Analyzer Profile.** You can view this profile in the On-Premise vCenter at:

Home -> Policies and Profiles -> VM Storage Policies


![alt_text](images/image4.png?classes=content-img "image_tooltip")


This newly created HDM  policy is applied to all the virtual machines under the cluster and monitoring for IO activity gets enabled.  For each virtual machine a reconfiguration task will be generated when applying HDM SPBM policy. If VMs have been successfully reconfigured, VM policies for these virtual machine would have **‘HDM Analyzer Profile’** applied against each of their VMDKs.

Once the policy has been applied, the user can check  analyzer summaries by selecting **VM->Monitoring->PrimaryIO** from **Host and Clusters** view.

**Note**: 



1. You can execute Enable IO Monitoring step any number of times to enable monitoring for new VMs, since last execution.
2. Applying SPBM policy can fail for some VMs. For example, when the VM already has a snapshot. This doesn’t fail the entire operation.


### Disabling Monitoring on a VM

**Note**: this step must not be executed for a VM if you expect the VM to be migrated to On-Cloud.

The monitoring of a VM is a low overhead activity and is done transparently without affecting the ongoing IOs or operation. Still, if in case the user doesn’t want HDM to monitor certain VMs, the following are the steps to be executed. 

Steps



1. In the On-Premise vCenter, right click on the VM you do not want to be monitored.
2. Select VM Policies -> Edit VM Storage Policies
3. In the popup, if the VM storage policy is HDM Analyzer Profile, then select VM storage policy as **Datastore Default** and click on **Apply to all**


![alt_text](images/image5.png?classes=content-img "image_tooltip")




4. The vCenter task will display the operation progress and status.

**Note**: HDM can’t migrate a VM, if it doesn’t have HDM SPBM policy. You can at any time apply the SPBM policy to a VM for making it available for migration.


# HDM SQS Configuration

HDM is integrated with SQS (Simple Queue Service from AWS) message bus.  HDM **_sqs-python_** is a python based library that provides an interface to manage and operate the HDM product. 

**Client Application** : Clients will be written by a third party and will use the sqs-python library to send HDM command messages and receive responses.

**SQS Messaging Service** :  Its role is to receive command requests from the client and pass on to the HDM. The responses are received from HDM and passed on to the client.

**HDM** : HDM acts as the server of the commands and sends responses. In addition there is also a periodic heartbeat that happens between HDM and client, so that client is aware of the system state of the server.


![drawing](images/image12.png?classes=content-img)

For third party integration to work, the HDM appliance after the deployment must be configured with the message bus. After this step, HDM will listen and execute operations posted on this bus and send back the status of these operations to the caller. 

Pre-requisites



1. HDM Appliance must be installed before the configuration of HDM SQS.
2. No other step in the HDM deployment should have been performed at this point.
3. User should be ready with the SQS message bus token to be used for the configuration

Steps



1. Access PrimaryIO Appliance on browser.
2. Log into the Appliance using the Administrator credentials.
3. Go to the vCenters page. Then click on the user profile icon


![alt_text](images/image6.png?classes=content-img "image_tooltip")




4. Click on **Configure Message Bus.**
5. Provide the SQS message bus token of the third party in the pop-up and click on **Configure.** 


![alt_text](images/image8.png?classes=content-img "image_tooltip")




6. The configured message bus details can be seen. Once configured, to change the message bus configuration, click on **Reconfigure**.


![alt_text](images/image9.jpg?classes=content-img "image_tooltip")


**Note: PIO Appliance should have access to the Internet for warm or cold migration through SQS.**




# TroubleShooting

## Troubleshooting Common Failure Scenarios

Common failure scenarios and possible reasons are provided below. If the failure is not one of the above reasons and the error message is not clear enough, please contact PrimaryIO Support.


### Deployment Failures

Some common reasons for deployment failures are listed below.



1. **Resources not sufficient** On-Premise or On-Cloud resources not sufficient enough to meet the deployment mode requirements.
2. **Unresolved input values**  inputs like vCenter FQDN/IP is not resolvable or not reachable.
3. **IP range issues** For static IP allocation, the IP range specified is not sufficient enough to assign to all HDM components.
4. **HDM component failed during or after the deployment**  HDM component failed during deployment.

Usually, the deployment UI wizard or vCenter tasks fail with error message pointing to one of the above reasons. The errors can be rectified and either the re-deployment can be initiated or an HDM reset followed by re-deployment should be tried.


### Undeployment Failures

Common reasons for undeployment failures are listed below:



1. VMs are still migrated to On-Cloud when undeployment is tried out.
2. On-Premise cluster host is not able to go to maintenance mode, due to 
    *   DRS not enabled on the cluster causing powered on VMs blocking the maintenance mode
    *   If it is a single host in the cluster and the HDM Appliance is part of it, then the HDM Appliance being powered on causing the maintenance mode to block. In this case, the user should initiate the uninstall of HDM filter and immediately power off the Appliance VM.

Monitoring the vCenter tasks would give the reasons for undeployment failures. If it is one of the above, rectify the failure reason and retry the operation.


# Support and Contact 


    In case of any issue, HDM support can be contacted through **email: [support@primaryio.com](mailto:support@primaryio.com)**

The email should have the following:



*   **Email subject **: Clearly mention the issue that is observed.
*   **Email body**: Clearly describe the problem. It can contain the deployment type, the operation being performed, any relevant screenshots etc.
*   **Email attachment** : Attach the relevant logs (as described in [HDM Support Logs](#heading=h.46et8132q0kj) section)
    *   HDM logs
    *   vm-support logs

    If the attachment size is large, an alternate shared location may be provided by the HDM support to help uploading the logs.
