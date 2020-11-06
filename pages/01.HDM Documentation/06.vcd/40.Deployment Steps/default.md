---
title: 'Deployment Steps'
---

This section describes how to deploy, configure, and undeploy PrimaryIO Hybrid Cloud Data Management (HDM) 2.1.3 for enabling migrations of virtual machines to VMware Cloud Director (vCD).


## HDM Deployment Steps

HDM deployment involves the following six steps, each of which is discussed in detail in the sections below:



1. Deploy the HDM appliance on-premises
2. Add the on-premises vCenter to the HDM appliance
3. Register the HDM plug-in to the on-premises vCenter
4. Add the HDM license
5. Deploy HDM on-premises
6. Deploy HDM in the cloud


### Step 1: Deploy the HDM Appliance On-premises


#### Placement of HDM Appliance



1. The appliance must be deployed on the same on-premises vCenter it will manage.
2. The appliance should reside in a different cluster than the one it will manage for migrations.


#### Deployment and Configuration

The HDM appliance must be installed from the OVF in the HDM package. Be sure to check that the placement and sizing of the deployment conforms to the requirements mentioned above. To deploy the appliance, use the “Deploy OVF Template**” **option in vCenter (figure 6).

_Figure 6: Launching the “Deploy OVF” Template in vCenter_

![alt_text](images/image29.png?classes=content-img "image_tooltip")



#### Network Configuration for the Appliance

Appliance network configuration requires that the available networks be categorized into four types, described in the Network Requirements  and HDM Resource Requirements sections, above. While it is recommended to keep these networks separate, it is possible for each of them to point to a single network. In addition, the decision must be made at this point to deploy using a static IP or DHCP protocol (figure 7).

_Figure 7: Configuring the Network_


![alt_text](images/image27.png?classes=content-img "image_tooltip")



#### IP Address Details

_(If DHCP is chosen, this section can be skipped)_

For each network type, choose the IP allocation protocol: static or DHCP. The following details are required if static IP is chosen (figure 8):



*   IP range: list of IP addresses that are free to be allocated to various HDM components
*   Subnet mask: subnet of the IP range
*   Gateway: gateway IP of the network
*   Domain: domain name of the network
*   DNS: domain name translation for the IP address
*   NTP: server that will be used for time synchronization

**NOTES**:



1. If static IP is chosen, failure to specify an NTP server may cause further HDM operations to fail.
2. If static IP is chosen, the gateway IP and the specified IP range must be in the same subnet.

_Figure 8: Configuring the System for Static IP Protocol_


![alt_text](images/image31.png?classes=content-img "image_tooltip")

#### Gateway settings

The setting in **Default gateway network** should be chosen so
that traffic for other subnets can be routed through this interface. This would 
generally be the WAN network but please verify the specifics for
your network.

In the field **Default Gateway** set the default gateway for the 
network chosen under **Default gateway network**. 


> **Getting this wrong will cause deployment to fail eventually and you will have to perform an [HDM Reset](../../hdm%20reset)**

_Figure 8b: Configuring gateway, NTP and default gateway_
![alt_text](images/Gateway-OVF.png?classes=content-img)

#### Power on the Appliance

Complete the rest of the wizard and wait for the deployment to complete. Then, use vCenter to power on the appliance.
> **Please note that the appliance can take between 5 to 10 minutes to boot depending on the underlying datastore's performance.**

#### Enable VMware HA on the Appliance

(_This step should only be performed for HDM cluster mode deployments_)

VMware HA should be enabled on the cluster where the HDM appliance has been deployed. To complete this procedure, do the following:



1. In the on-premises vCenter, select the cluster where the HDM appliance is deployed
2. Select the “Configure” tab from the right-hand pane and navigate to _Services_ 🡪 _vSphere Availability_
3. If the vSphere HA is turned off, select _EDIT_ and _Enable vSphere HA_


### Step 2: Add the On-premises vCenter to the HDM Appliance

**NOTE**: The On-premises vCenter should be added to the same location as the HDM appliance. 

Pre-requisites



1. Ensure that the HDM appliance is powered on and valid vCenter administrator credentials are available.

Steps



1. Log into the HDM Appliance by accessing _https://&lt;appliance ip>_ in a supported web browser and enter the administrator credentials. The default administrator username and password are _‘administrator’_ and _‘2Hdm$aK!N@h!’,_ respectively. The default password should be changed immediately after the first login.
2. Select _vCenters_ from the top pane.
3. Select _Add vCenter_ at the top right (figure 9).

_Figure 9: Adding vCenter to the HDM Appliance_


![alt_text](images/image33.png?classes=content-img "image_tooltip")




4. Specify the on-premises vCenter IP, or the FQDN that was set for the vCenter during its installation. Enter the administrator credentials, and then select _Add vCenter_. The HDM appliance should now list the on-premises vCenter (figure 10).

_Figure 10: Viewing the On-Premises vCenter on the HDM Appliance_


![alt_text](images/image32.png?classes=content-img "image_tooltip")



## Step 3: Register the HDM Plug-in to On-premises vCenter



1. Select  **Register** to register the HDM plug-in to on-premises vCenter.
2. **Logout and login twice** from the vCenter for the plug-in installation to complete. Successful installation should add an HDM icon to the vCenter home page (figure 11). Sometimes, multiple login/logout cycles may be required for this step to complete.

>> __You might have to logout/login from the web client at least two times or more before the HDM plugin in visible in the vCenter__

_Figure 11: HDM Icon on the vCenter Home Page_

![alt_text](images/image36.png?classes=content-img "image_tooltip")


**NOTE:** The PrimaryIO vCenter plug-in will be automatically registered on all vCenter instances that are configured in enhanced linked mode.


## Step 4: Add the HDM License

Following deployment, a license key is required to activate HDM. A trial license will be shared with the product which can be used to activate HDM.

**NOTE**: Initial product settings need to be initialized, so it may take a few minutes to load the HDM configuration page.

Steps to add the HDM license:



1. In the on-premises vCenter, access the HDM dashboard by selecting _HDM_ from _Shortcuts_ or the vCenter menu (_It may take a few minutes for the dashboard to load)_.
2. Select the _Administration** **_tab.
3. Select _Licensing_ to add a new license, and to see existing licenses (figure 12).
4. Select _Add License** **_to open a popup where the provided **Trial License** can be pasted (figure 13).
5. Copy and paste the shared license key and select _OK_. The license will now be listed on the license page (figure 14).
6. The same interface can then be used to add the actual **Product License** obtained as part of the ordering process.

_Figure 12: Add or See HDM Licenses_

![alt_text](images/image34.png?classes=content-img "image_tooltip")


_Figure 13: "Add License" Pop-up_


![alt_text](images/image35.png?classes=content-img "image_tooltip")
 

_Figure 14: Verify the Addition of the Trial License_


![alt_text](images/image37.png?classes=content-img "image_tooltip")



## Step 5: Deploy HDM On-premises

Depending on the network bandwidth and storage, it may take between 10 and 20 minutes to deploy HDM on-premises. Any failure-retries during the deployment process will be logged into vCenter Events. To search for events generated by HDM,** _hdm_** or _com.primaryio_ keywords can be used in vCenter event search.

Pre-requisites:

At this point, it is assumed that the HDM appliance deployment and configuration steps have been successfully completed. Ensure that the HDM plug-in has been registered on vCenter and the HDM icon is visible on the vCenter home screen. A valid HDM license must be added to activate the product.

Deployment steps:



1. To access the HDM dashboard from the on-premises vCenter, select _HDM_ from _Shortcuts_ or the Menu.
2. Select the _Administration** **_tab, followed by _Configuration_ to access the on-premises cluster listing (figure 15). 

_Figure 15: vCenter On-Premises Cluster Listing_


![alt_text](images/image38.png?classes=content-img "image_tooltip")




3. Select the cluster where the HDM will be installed and select _Install_. This will open the HDM Installation Wizard (figure 16).
4. Verify that the HDM appliance IP address is correct.
5. Select the desired deployment mode based on your scale and failure tolerance requirements. See the Deployment Requirements section for details on the various deployment modes.
6. Select resource allocation based on your size and resource requirements. See Deployment Requirements section for details on the various allocation types.

_Figure 16: HDM Installation Wizard_


![alt_text](images/image39.png?classes=content-img "image_tooltip")



    **NOTE: **For migration to vCD, select _Ultra-Lite_ as the resource allocation mode.** **



7. Select the resource pool and shared datastore where the HDM components will be deployed (figure 17). Before selecting the deployment mode, take care to ensure that enough resources are available on-premises and in the cloud.

_Figure 17: Resource Pool and Shared Datastore Selection_


![alt_text](images/image40.png?classes=content-img "image_tooltip")




8. To specify the internal network configurations, start by choosing the IP allocation protocol: static or DHCP (figure 18). The following details are required if static IP is chosen:
*   IP range
*   Subnet mask
*   Gateway
*   Domain
*   DNS
*   NTP

    See the Deployment Requirements section for additional details on these requirements. These steps must be repeated for the following components:

1. HDM Internal Network (HDM_Internal_Network)
2. WAN Network (Uplink_WAN_Network)
3. ESXi Network (ESXi_Network)

    **NOTES: **

1. If all are mapping to single network, separate IP ranges must be provided for each network type.
2. The subnet range 172.17.0.0/16 is not available for the deployment; it is used internally by HDM microservices.

_Figure 18: Network Configuration Settings_

![alt_text](images/image41.png?classes=content-img "image_tooltip")




9. Confirm the selection and submit the installation request by clicking on the **FINISH** button (figure 19).

_Figure 19: HDM Installation Summary_


![alt_text](images/image42.png?classes=content-img "image_tooltip")




10. This will create a deployment task which can be monitored from vCenter Tasks. The deployment progress can also be seen in the HDM Configuration view within vCenter (figure 20).

_Figure 20: vCenter HDM Configuration View_


![alt_text](images/image13.png?classes=content-img "image_tooltip")



## Step 6: Deploy HDM in the Cloud

Depending on the WAN bandwidth and WAN latency, it may take between 10 and 20 minutes to deploy HDM components in the cloud. Any failure-retries during the deployment process will be logged into vCenter Events. To search for events generated by HDM,** _hdm_** or _com.primaryio_ keywords can be used in vCenter event search.

Pre-requisites 



1. Ensure that the HDM plug-in has been registered on vCenter and the HDM icon is visible on the home screen. 
2. Ensure that the on-premises deployment has successfully completed.
3. Ensure that the vCenter cloud is reachable from the HDM appliance. If cloud vCD is on the WAN and the WAN is not reachable through the appliance’s default route, then a static entry must be added to the HDM appliance to reach the cloud vCD. This can be accomplished by following these steps:
    1. vim /etc/pio.routes and add the entry
```
        ens256|<cloud_subnet>|<gateway_to_access_cloud>
        Example: ens256|10.3.0.0/24|10.1.0.1`
```
    2. /usr/bin/setup/network.sh
4. HDM_INTERNAL_NETWORK and WAN Network should be connected to the selected vApp.

Deployment steps:



1. To access the HDM dashboard from the on-premises vCenter, select _HDM_ from _Shortcuts_ or the Menu.
2. Select the _Administration_ tab, then _Clouds_ to access the cloud listing (figure 21).

_Figure 21: vCenter Cloud Listing_


![alt_text](images/image43.png?classes=content-img "image_tooltip")




3. Select _Add Cloud_. This will open the HDM Cloud Wizard (figure 22).
4. Select the Cloud type and enter your vCD credentials and the Cloud DNS. 

_Figure 22: HDM Cloud Wizard_



![alt_text](images/image17.png?classes=content-img "image_tooltip")




5. Select vDC, vApp and storage profile cloud where HDM components will be deployed (figure 23). You must use a Storage Profile of at least **10 IOPS/GB** or **standard** for deployment.

_Figure 23: Select Cloud Cluster_


![alt_text](images/image18.png?classes=content-img "image_tooltip")




6. Select the network and IP configuration for ON_CLOUD_HDM_NETWORK (HDM Internal Network) that will be used by HDM for VM boot and subsequent IO handling through the HDM components. Choose the IP allocation protocol: static, static pool, or DHCP (figure 24). If static IP address allocation is chosen, the unused IP addresses or IP ranges, along with the gateway and subnet mask, would need to be specified.

_Figure 24: Network Configuration_



![alt_text](images/image19.png?classes=content-img "image_tooltip")




7. Select network IP configurations for the WAN. Choose the IP allocation protocol: static, static pool, or DHCP (figure 25). If static IP address allocation is chosen, the unused IP addresses or IP ranges, along with the gateway and subnet mask, domain search path, and one or more DNS and NTP servers, would need to be specified

_Figure 25: WAN Configuration_

![alt_text](images/image20.png?classes=content-img "image_tooltip")




8. Set WAN route configuration to enable data traffic to travel from the cloud to the on-premises environment (figure 26). See the network planning section <a name="wan-cfg">[WAN Routing Configuration](../network%20planning/planning%20template/single%20network#wan-routing-configuration)</a>.

_Figure 26: WAN Route Configuration_



![alt_text](images/image21.png?classes=content-img "image_tooltip")




9. Select network mapping to enable the on-premises network categorization to also be applied to cloud components (figure 27).

_Figure 27: Network Mapping_



![alt_text](images/image22.png?classes=content-img "image_tooltip")




10. To submit the request and initiate the cloud deployment, select _FINISH_. This will create deployment tasks for the cloud components, which can be monitored in vCenter Tasks. The progress can also be seen in the HDM Clouds view (figure 29).

>>> **Attention**: 
>>> After you submit the request, the cloud deployment can take from 45 minutes to 
>>> over an hour, depending on storage and network performance. Please note
>>> that the progress bar displayed during this process is not linear and 
>>> specific steps take longer, resulting in the progress bar spending
>>> longer time at a certain percentage.
>>>
>>> For the Cloud deployment task, it takes about 40-50 minutes at 1%.
>>>
>>> Under the Organization VDC upload ISO task, stays at 50% for
>>> about 25 minutes. 
>>>
>>> Under the Organization VDC upload OVF task, lingers at 1% for about 20 minutes.

_Figure 28: Summary and Request Submission_


![alt_text](images/image23.png?classes=content-img "image_tooltip")


_Figure 29: HDM Clouds View_



![alt_text](images/image10.png?classes=content-img "image_tooltip")



## Deployment Validation

Once the on-premises and cloud deployments have completed, the state of the components can be viewed in the following ways:


### Appliance View

After successful installation of HDM in the cloud, the HDM appliance control panel shows the list of components and their health (figure 30). This information can also be viewed from the HDM plug-in in vCenter (figure 31).

_Figure 30: HDM Appliance Control Panel_



![alt_text](images/image24.png?classes=content-img "image_tooltip")


_Figure 31: vCenter HDM Plug-In_


![alt_text](images/image25.png?classes=content-img "image_tooltip")



### On-premises vCenter

To verify that the on-premises vCenter shows the cloud state as installed, select _HDM_, then the _Administration_ and _Clouds _tabs. 

_Figure 32: Verify Installation of the Cloud State_



![alt_text](images/image7.png?classes=content-img "image_tooltip")


**NOTE:** Configuration information needs to be gathered and loaded from vCD, so it may take a few minutes to load the Cloud Dashboard for the first time. 



# TroubleShooting


## Troubleshooting Common Failure Scenarios

Common failure scenarios and their possible reasons are discussed below. If the failure is not one of the above reasons and the error message is not clear, please contact PrimaryIO Support.


### Deployment Failures

Some common reasons for deployment failures are:



1. **Insufficient resources. **On-premises or cloud resources are not sufficient to meet the requirements for the specified deployment mode.
2. **Unresolved input values.** Inputs such as vCenter FQDN/IP are either unresolvable or unreachable.
3. **IP range issues.** For static IP allocation, the specified IP range is insufficient for all HDM components.
4. **HDM component failed during or after the deployment.** The HDM component failed during deployment.

Usually, the deployment UI wizard or vCenter tasks fail with error message pointing to one of the above reasons. The errors can be rectified and either a re-deployment can be initiated or an HDM reset followed by re-deployment should be attempted.


### Undeployment Failures

Common reasons for undeployment failures are:



1. VMs are still migrated to the cloud when undeployment is attempted. (This is applicable to TBC only)
2. The on-premises cluster host is unable to enter maintenance mode, for one of the following reasons: 
    *   DRS is not enabled on the cluster, thereby causing powered-on VMs to block the maintenance mode
    *   The HDM appliance is part of a single host cluster. Therefore, the HDM appliance being powered-on blocks the maintenance mode. In this case, the user should immediately power off the HDM appliance.

Monitoring the vCenter tasks will provide the reason for an undeployment failure. If it is one of the above, rectify the reason for the failure and re-attempt the operation.


# Support and Contact 


    In case of any issue, HDM support can be contacted via **email: [support@primaryio.com](mailto:support@primaryio.com)**

The email should contain the following:



*   **Email subject:** Clearly highlight the issue.
*   **Email body**: Clearly describe the problem. It can contain the deployment type, the operation being performed, any relevant screenshots, etc.
*   **Email attachment**: Attach the relevant logs (see the [HDM Support Logs](http://docs.primaryio.com/hdm%20documentation/support%20logs) section for instructions):
    *   HDM logs
    *   vm-support logs

    If the attachment size is too large, an alternate shared location may be provided by HDM Support where the logs can be uploaded.
