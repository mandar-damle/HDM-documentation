# Terminology

This document uses the below terms and terminologies at multiple places.



*   **PrimaryIO or PIO** 

    PIO is often used for PrimaryIO in this document.

*   **HDM**

    Hybrid data management solution from PrimaryIO

*   **Onprem or On-Prem  or On-Premise or source**

    Refers to On-Premise datacenter.

*   **Oncloud or On-Cloud or target**

    Refers to the On-Cloud infrastructure created in connection with the migration of an On-Premise VM.

*   **Appliance or PIO Appliance or HDM Appliance**

    The HDM Appliance VM deployed on the On-Premise vCenter

*   **Agile Rapid Migration or ARM**

    A migration type supported by HDM in which a VM and its data is moved to On-Cloud completely.

*   **Cold migration**

    A migration type supported by HDM, where the VM being migrated is powered off and its data is moved to the On-Cloud either online through HDM or offline through external sources.

*   **Warm migration**

    An migration type supported by HDM where the VM’s compute is migrated to the On-Cloud early and its data set is moved online through HDM or offline through external software in the background.

*   **Compute migration**

    This refers to the VM migrated to the On-Cloud while it continues to access its data On-Premise.

*   **Migrate time snapshot**

    HDM created snapshot of the VM just before migrating it to On-Cloud. This is useful in restoring the VM in case of failures and data consistency issues with migrated VM.

*   **Cloud Burst**

    A VM migration use case supported by HDM in which a VM is migrated to the On-Cloud temporarily due to high resource usage On-Premise.

*   **Try Before Commit**

    A VM migration use case to test whether VMs in On-Cloud perform good enough, before deciding whether to migrate VM’s entire data set. 

*   **SPBM or Storage Policy Based Management**

    Vmware provided mechanism to define storage policies that can be applied to individual VMs.

*   **Bulk migration**

    Background movement of the VM data in case of ARM use case. It is said to be **online** if the transfer is done by HDM and is **offline** if third party mechanism like AWS snowball is used.

*   **Ultra Lite, Lite, Standard or Performance Deployment**

    Type of deployment based on the resource allocation. Lite has least requirements and performance has maximum. 

*   **Standalone or Cluster Deployment**

    Mode of deployment based on the scale and fault tolerance requirements. Standalone has a fixed scale while cluster deployment scales with the number of nodes in the cluster.

