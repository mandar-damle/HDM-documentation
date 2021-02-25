---
title: 'Appendix'
---

## Prepare to migrate

The following operations are done on the guest VM for prepare to migrate.

### Linux

For a Support Linux OS we will
1. Check iscsi initiator drivers installed (install if not)
1. Add iscsi driver to initrd.
1. Add flag in kernel boot to allow iSCSI booting.


### Windows


For a Supported Windows OS we will
1. Disable WFP(Windows Filtering Platform) Lightweight Filter bindings from the NIC which will be used for iSCSI booting.
1. Turning on the 'msiscsi' service and setting 'service_start_mode' to 'automatic' so it will be going to autostart on each boot.
1. [add what packages will be added]
1. [what files are added with what permissions]
1. [Which site are we downloading additional packages.]
