# Network Configuration for Any config


1. Prerequisite for Appliance Deployment
    1. Identify Datacenter on On-Premise vCenter on which HDM will be deployed - 
    2. Identify Management network for the Datacenter (Management Network) -  
        1. Static or DHCP
        2. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
_
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    3. Identify network on which ESXI are deployed (ESXi Network)- 
        3. Static or DHCP
        4. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
_
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    4. Identify WAN network which will have connectivity to On-Cloud environment (WAN network) - 
        5. Static or DHCP
        6. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    5. Create or Identify a network which will be used for HDM internal communication (ON_PREM_HDM_NETWORK) - 
        7. Static or DHCP
        8. If Static

<table>
  <tr>
   <td>
IP
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    6. Identify network which have access to internet

<table>
  <tr>
   <td>
Gateway 
   </td>
   <td>Network (either of 1.b, 1.c, 1.d, and 1.e)
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
  </tr>
</table>




    7. Comma separated NTP server (Required) - 
    8. Comma separated DNS (Only if VCenter deployment is with FQDN) -
    9. Domain Search Path (Only if vCenter deployment is with FQDN) - 
2. On-Premise Deployment
    10. HDM deployment mode
        9. Ultra Lite Standalone
        10. Ultra Lite Cluster
    11. If required, add routes to access internet in appliance
    12. Cluster within the Datacenter identified for Migration - 
    13. Resource Pool within the cluster for HDM component deployment - 
    14. Shared datastore for HDM component deployment - 
    15. HDM Internal network configuration
        11. Static or DHCP
        12. If Static
            1. IP ranges 
                1. Standalone Ultra Lite - 1 IP required
                2. Cluster Ultra Lite - 2 IP required

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    16. WAN network configuration
        13. Static or DHCP
        14. If Static
            2. IP ranges 
                3. Appliance Only - NA
                4. Standalone Lite - 1 IP required
                5. Standalone Standard - 1 IP required
                6. Standalone Performance - 1 IP required
                7. Cluster Lite - 2 IP required
                8. Cluster Standard - 2 IP required (where n = # ESXi)
                9. Cluster Performance - 2 IP required  (where n = #ESXi)

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    17. ESXi network configuration
        15. Static or DHCP
        16. If Static
            3. IP ranges 
                10. Appliance Only - NA
                11. Standalone Lite - 1 IP required
                12. Standalone Standard - 1 IP required
                13. Standalone Performance - 1 IP required
                14. Cluster Lite - 2 IP required
                15. Cluster Standard - n IP required (where n = # ESXi)
                16. Cluster Performance - n IP required (where n = #ESXi)

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




3. On-Cloud Deployment
   18. DNS to resolve cloud Director FQDN if private - 
   19. If required (For On-Cloud not accessible over public network) add routes to access On-Cloud Director in appliance:
        17. Log into PIO Appliance over ssh - root/admin@123
        18. Add entry in /etc/pio.routes - &lt;ethernet_name>|&lt;cloud subnet>|&lt;prem_gateway>
        19. Execute ./setup_network.sh
    20. Virtual Data Center identified for Migration - 
    21. vApp for HDM component deployment - 
    22. Storage Policy for HDM component deployment - 
    23. HDM Internal network configuration
        20. Static or Static Pool or DHCP
        21. If Static
            4. IP ranges 
                17. Standalone Ultra Lite - 1 + m IP required (where m = # parallel migrated VM) - 
                18. Cluster Ultra Lite - 4 + m IP required (where m = # parallel migrated VM)

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    24. WAN network configuration
        22. Static or Static Pool or DHCP
        23. If Static
            5. IP ranges 
                19. Standalone Ultra Lite - 1 IP  required
                20. Cluster Ultra Lite - 2 IP  required

<table>
  <tr>
   <td>
IP Range
   </td>
   <td>Netmask
   </td>
   <td>Gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>




    25. Network Routes
        24. Route from On-Premise to access On-Cloud

<table>
  <tr>
   <td>
 On-Cloud WAN subnet
   </td>
   _
   <td>
 On-Premise WAN gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
  </tr>
</table>


        25. Route from On-Cloud to access On-Premise

<table>
  <tr>
   <td>
On-Premise WAN subnet
   </td>
   <td>On-Cloud WAN gateway
   </td>
  </tr>
  <tr>
   <td>
   _
   </td>
   <td>
   </td>
  </tr>
</table>




    26. Network Map - On-Premise application network to On-Cloud application network