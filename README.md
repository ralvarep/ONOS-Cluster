# ONOS Project → ONOS Cluster

This repository provides a virtual scenario to explore the ONOS Cluster.

Demo scenario has been created using [Virtual Networks over linuX (VNX)](http://www.dit.upm.es/~vnx/).

Index:
- [Requirements](https://github.com/ralvarep/ONOS-Cluster#requirements)
- [Scenario](https://github.com/ralvarep/ONOS-Cluster#scenario)
- [Usage](https://github.com/ralvarep/ONOS-Cluster#usage)
- [Author](https://github.com/ralvarep/ONOS-Cluster#author)
- [References](https://github.com/ralvarep/ONOS-Cluster#references)


## Requirements

 - VNX installed [(VNX Installation Guide)](http://web.dit.upm.es/vnxwiki/index.php/Vnx-install)
 - Operating System: Ubuntu 14.04 / Ubuntu 16.04
 - Hard Drive: 3,5 GB avaible space (Filesystem size)
 - Memory: 4 GB RAM or more


## Scenario

![Scenario](https://raw.githubusercontent.com/ralvarep/ONOS-Cluster/master/img/scenario.png)


## Usage

**STEP 1: Clone this repository**
~~~
$ git clone https://github.com/ralvarep/ONOS-Cluster.git
~~~

**STEP 2: Build filesystem**

The virtual scenario has been configured using the filesystem in [copy-on-write (COW) mode](https://en.wikipedia.org/wiki/Copy-on-write). This allows you to use a single filesystem for all virtual machines, thereby optimizing the disk space occupied.

Depending on your operating system, execute:
~~~
$ filesystems/create-rootfs_ubuntu14.04
~~~
~~~
$ filesystems/create-rootfs_ubuntu16.04
~~~
This step takes about 20-30 min. It will download all the necessary packages of the demo scenario.

**STEP 3: Create virtual scenario**

Move to a specific scenario folder and execute:
~~~
$ sudo vnx -f ONOS-Cluster.xml -t
~~~
When the scenario is created, you can login to consoles with root:xxxx.

**STEP 4: Configure ONOS Cluster**

Since the previous step, wait a few second while ONOS is starting.

To configure the ONOS Cluster you have to execute the following command:
~~~
$ sudo vnx -f ONOS-Cluster -x form-cluster
~~~

**STEP 5: Check ONOS (SDN Controller)**

Enter in the ONOS consoles and to enter in the Karaf Consoles, execute:
~~~
root@ONOS-1:~# onos-1.7.1/bin/onos
root@ONOS-2:~# onos-1.7.1/bin/onos

Logging in as karaf
Welcome to Open Network Operating System (ONOS)!
     ____  _  ______  ____     
    / __ \/ |/ / __ \/ __/   
   / /_/ /    / /_/ /\ \     
   \____/_/|_/\____/___/     
                               
onos> 
~~~

Once you are in the Karaf Console, you can check the active applications:
~~~
onos> apps -s -a
*   3 org.onosproject.optical-model        1.7.1    Optical information model
*   4 org.onosproject.hostprovider         1.7.1    Host Location Provider
*   5 org.onosproject.lldpprovider         1.7.1    LLDP Link Provider
*   6 org.onosproject.openflow-base        1.7.1    OpenFlow Provider
*   7 org.onosproject.openflow             1.7.1    OpenFlow Meta App
*   8 org.onosproject.fwd                  1.7.1    Reactive Forwarding App
*   9 org.onosproject.drivers              1.7.1    Default device drivers
~~~
and the cluster nodes:
~~~
onos> nodes
id=10.10.0.1, address=10.10.0.1:9876, state=READY, updated=15m ago
id=10.10.0.2, address=10.10.0.2:9876, state=READY, updated=15m ago
~~~
Also, you can monitor the roles of the current nodes to each device:
~~~
onos> masters
10.10.0.1: 4 devices
  of:0000000000000001
  of:0000000000000002
  of:0000000000000003
  of:0000000000000004
10.10.0.2: 0 devices
~~~
And change the roles:
~~~
onos> device-role of:0000000000000003 10.10.0.2 master
onos> device-role of:0000000000000004 10.10.0.2 master

onos> masters
10.10.0.1: 2 devices
  of:0000000000000001
  of:0000000000000002
10.10.0.2: 2 devices
  of:0000000000000003
  of:0000000000000004
~~~

In addition, ONOS GUI is avaible from your host through:

* [http://10.250.0.2:8181/onos/ui/login.html](http://10.250.0.2:8181/onos/ui/login.html).
* [http://10.250.0.6:8181/onos/ui/login.html](http://10.250.0.6:8181/onos/ui/login.html).

To login karaf:karaf. 

![ONOS-GUI](https://raw.githubusercontent.com/ralvarep/ONOS-Cluster/master/img/ONOS-GUI.png)


**STEP 6: Connectivity Test between clients**

Now you can test the connectivity between the clients. For example, entering in h1 console:
~~~
root@h1:~# ping 10.0.0.2
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=11.8 ms
64 bytes from 10.0.0.2: icmp_seq=2 ttl=64 time=0.076 ms
64 bytes from 10.0.0.2: icmp_seq=3 ttl=64 time=0.085 ms
~~~

**OTHER OPTIONS:**

* Launch terminal of some virtual machine
~~~
$ sudo vnx -f ONOS-Cluster.xml --console -M VM-NAME
~~~
* Shutdown scenario
~~~
$ sudo vnx -f ONOS-Cluster.xml --shutdown
~~~
* Start scenario that has previously been shutdown
~~~
$ sudo vnx -f ONOS-Cluster.xml --start
~~~
* Destroy scenario
~~~
$ sudo vnx -f ONOS-Cluster.xml -P
~~~


## Author

This project has been developed by [Raúl Álvarez Pinilla](https://es.linkedin.com/in/raulalvarezpinilla).


## References

 *  [ONOS Project](http://onosproject.org/)
 *  [Installing and Running ONOS](https://wiki.onosproject.org/display/ONOS/Installing+and+Running+ONOS)
 *  [Installing ONOS from onos.tar.gz file](https://wiki.onosproject.org/display/ONOS/Installing+ONOS+from+onos.tar.gz+file)
 *  [Deploying ONOS from onos.tar.gz file](https://www.youtube.com/watch?v=hk1cPmp46n8)
