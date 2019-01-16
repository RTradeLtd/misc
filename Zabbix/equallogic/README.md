# equallogic

Tools related to monitoring of equallogic SANs, specifically tailored for RTrade.

Heavily based upon [already existing work](https://zabbix.org/wiki/Monitoring_Dell_Equallogic_Systems)

The script was not written by us, all credits go to the original authors. GPLv3 license

Tested against Zabbix 4.0.3 and Dell PS6000's

The Template was modified to include graph prototypes for various stats, as well as fix some items that would not work with PS6000's that have a max of 16 disks.

## README from the zip contained in the wiki

Description
-----------
This Zabbix template provides a check of Dell Equallogic systems.
The template assumes 24 disks are present in the system and has
been tested on a several PS6110 systems: PS6110XS, P6110XV and
PS6110E.

Contents
--------
Equallogic SAN Group.xml - Zabbix template
discover_eqlvolumes.pl - Perl helper script to generate a list
of SNMP sub-ids, one for each volume.

Author
------
The template was created by Ivo van Geel for Radboudumc in Nijmegen.

License
-------
The template and the helper script are released under the GNU GPLv3
license. See gpl.txt for more information on the GNU GPLv3 license.
You must include this file when distributing this Zabbix template.

Installation
------------
Please change the SNMP Community string in the Perl helper script,
if it is not set to "default" in your Equallogic systems.

Import the XML file into Zabbix (under Configuration -> Templates).

The SNMP Community string for the template can be set in the template
configuration itself, under Macros. By default this is set to: "default".

Copy the Perl helper script to the ExternalScripts directory
(see /etc/zabbix/zabbix_server.conf) and make sure it is executable
by running: chmod a+rx /path/to/discover_eqlvolumes.pl

