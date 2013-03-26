NagiosPlugin-HPSmartArrayController
===================================

A small Ruby plugin for Nagios for Smart Array controllers (all models supported by hpacucli)

USAGE
===================================
#show help
[root@myserver plugins]# ./check_smart_array -h
Usage: check_smart_array --slot SLOT_NUMBER 



#status OK
[root@myserver plugins]# ./check_smart_array --slot 4
 Smart Array OK




Check of array status
=====================

Simple check inside this output:
root@myserver plugins]#  hpacucli ctrl  slot=4  show config | head

Smart Array P812 in Slot 4                (sn: xxxxxxxxxxxxxxx)

   array A (SAS, Unused Space: 0  MB)


      logicaldrive 1 (136.7 GB, RAID 1, OK)

      physicaldrive 6I:1:1 (port 6I:box 1:bay 1, SAS, 146 GB, OK)
      physicaldrive 6I:1:2 (port 6I:box 1:bay 2, SAS, 146 GB, OK)


logicaldrive,physicaldrive should be OK for an exit status OK

Check of controller status
==========================

[root@myserver plugins]#  hpacucli ctrl  slot=4  show status

Smart Array P812 in Slot 4
   Controller Status: OK
   Cache Status: OK
   Battery/Capacitor Status: OK


for exit status OK all should be OK





