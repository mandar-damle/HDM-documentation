---
title: 'HDM Reset'
---


**CAUTION: Use this functionality with caution, as this can lead to HDM configuration data loss. This should _only_ be used when the system has entered an unrecoverable state.**

_HDM Reset_ is used to recover from situations when HDM enters into an unrecoverable state. It removes all cloud and on-premises component states, and is equivalent to a factory reset. HDM Reset is usually followed by re-deployment of HDM.


### What HDM Reset Won’t Do

HDM reset is not about removing all states. It only removes the states that are required to bring the system back to a point where HDM can be reinstalled.



1. It will not remove storage policies.
2. The VAIO component will not be removed from EXSi. 
3. It will not uninstall or unregister the vCenter plug-in.


### When to Perform HDM Reset

The few cases where HDM Reset may be required are:



*   **Multiple HDM components are simultaneously failing.** HDM tries to recover from multiple component failures. However, this will likely require an HDM reset.
*   **Prolonged WAN outages.** HDM can handle transient network failures, but long outages (greater than 5 minutes) may render it incapable of recovering.
*   **Component recovery failure for an extended period of time**. HDM will attempt to recover the failed components a few times. But if the failure condition does not disappear, the component recovery may continue to fail indefinitely. This may be the case if the Control Panel in the HDM appliance shows the components in the degraded state for more than 15 minutes.
*   **_Reset Required_ message received. **If HDM logs the following message in the on-premises vCenter: “Fatal Unrecoverable failure detected in HDM component: &lt;component_name> Please reset the HDM system and retry migration operations for the VMs in &lt;vm_name> and &lt;pool_name> resource pools”


### HDM Reset Steps

Pre-requisites



1. HDM appliance must be powered on.

Steps



1. To access the HDM dashboard, select _HDM_ from _Shortcuts_ or from the Menu in the on-premises vCenter.
2. Select the _Administration_ tab,** **then _HDM Health_ and** _HDM Reset_** (figure 43). If the _HDM Reset_ button is not enabled, then reboot the HDM appliance and try again.
3. Select the _HDM RESET_ button to trigger the reset.
4. You can view the task in the on-premises vCenter (figure 44).
5. Restart the HDM appliance from vCenter and wait for the restart to complete.

_Figure 43: vCenter HDM Reset Tab_


![alt_text](images/image2.png "image_tooltip")


_Figure 44: Reset Task in the On-Premises vCenter_


![alt_text](images/image3.png "image_tooltip")




6. On restart, you should see that the earlier queued task for HDM reset in vCenter can now proceed. 
7. Once the reset is complete, the vCenter task is updated (figure 45).

_Figure 45: Updated Task in On-Premises vCenter_


![alt_text](images/image4.png "image_tooltip")




8. The VMs will be migrated back and will remain in ‘_HDM_MIGRATE_POOL_’.
9. Be sure to monitor the state of the HDM components in the Control Panel of the HDM appliance to ensure that the on-premises load balancer, database, HA manager, and PrimaryIO manager are running. This will indicate the successful completion of the HDM reset.


### VM Recovery Following HDM Reset

To recover VMs following an HDM reset, the following steps should be performed:



1. Power on the VM and verify the sanity of the data
2. If the power-on and data sanity checks pass:
    1. Delete the HDM migrate time snapshot
    2. Move the VM to its pre-migration resource pool
3. If the power-on or the data sanity fail:
    3. Restore the data from the migrate time snapshot
    4. Delete the HDM migrate time snapshot
    5. Move the VM to its pre-migration resource pool
    6. Power on the VM 


### Redeployment Following an HDM Reset

As mentioned in earlier sections, a typical HDM deployment consists of the following steps:



1. Deploy the HDM appliance
2. Register the HDM plug-in
3. Deploy HDM on-premises
4. Deploy HDM in the cloud

HDM reset would undo the steps 3 and 4, above, so these have to be executed again:



1. Deploy HDM on-premises
2. Deploy HDM on the cloud
