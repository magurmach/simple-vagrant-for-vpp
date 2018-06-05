VPP-DEMO for GBP
================
This demo requires Vagrant (tested on 1.8.5 version) and VirtualBox (tested on 5.1.2 version)
To setup the environment just navigate to groupbasedpolicy\demos\vpp-demo along with LISP L3 provisioning. Execute following command::

    vagrant up

Vagrant then creates 3VMs (controller, compute0 and compute1). After vagrant finishes you can stop the VMs with
"vagrant halt" command and bring them up again with "vagrant up" command. This setup is significantly different from
default GBP's setup. We assume that the ODL is not strictly a part of OpenStack environment. The 3 VMs this script
initializes are 3 compute hosts.

DEMO setup
----------
(repeat this everytime you want to reset the demo)
To reset state of VMs run the following command on all VMs. It resolves on which node it is running and
configures IPs to vpp::

    /vagrant/reload-nodes.sh

To enter VMs use "vagrant ssh" command::

    vagrant ssh compute0
    vagrant ssh compute1
    vagrant ssh compute2

You need to install following features in ODL (logs are optional)::

    feature:install odl-vbd-ui odl-groupbasedpolicy-ui odl-groupbasedpolicy-neutron-vpp-mapper odl-restconf
    feature:install odl-lispflowmapping-neutron odl-lispflowmapping-mappingservice-shell

You can now import vpp-demo collection (lisp-vpp-demo-local.postman_collection.json) to postman and start demo by following these steps::

    1. You need to register VPP nodes in postman collection:
       a. Register VPP compute0
       b. Register VPP compute1
       c. Register VPP compute2
    2. After nodes are connected (you can check in "VPP renderer operational") you can feed data to ODL:
       use "neutron data - initial" from collection and we have 3 scenarios.
       a. First scenario:
          +------------+------+-------------+----------------+
          |   host     |VM No.|   VM Name   |     Subnet     |
          +------------+------+-------------+----------------+
          |  compute0  |  1   |     VM1     |  10.11.12.2/24 |
          +------------+------+-------------+----------------+
          |  compute1  |  1   |     VM1     |  10.11.12.3/24 |
          +------------+------+-------------+----------------+
          |  compute2  |  1   |     VM1     |  10.11.13.2/24 |
          +------------+------+-------------+----------------+
          We have 3 VMs and we ping from compute1 to 10.11.12.2 and 10.11.13.2.
       b. Second scenario:
          +------------+------+-------------+----------------+
          |   host     |VM No.|   VM Name   |     Subnet     |
          +------------+------+-------------+----------------+
          |  compute0  |  2   |     VM1     |  10.11.12.2/24 |
          |            |      +-------------+----------------|
          |            |      |     VM2     |  10.11.13.3/24 |
          +------------+------+-------------+----------------+
          |  compute1  |  1   |     VM1     |  10.11.13.2/24 |
          +------------+------+-------------+----------------+
          We ping from compute0 VM1 to 10.11.13.2.
       c. Third scenario:
          +------------+------+-------------+----------------+
          |   host     |VM No.|   VM Name   |     Subnet     |
          +------------+------+-------------+----------------+
          |  compute0  |  3   |VM1(tenant 1)|  10.11.12.2/24 |
          |            |      +-------------+----------------+
          |            |      |VM2(tenant 2)|  10.11.12.2/24 |
          |            |      +-------------+----------------+
          |            |      |VM3(tenant 2)|  10.11.12.3/24 |
          +------------+------+-------------+----------------+
          |  compute1  |  1   |VM1(tenant 1)|  10.11.13.2/24 |
          +------------+------+-------------+----------------+
          Here we ping from compute0's VM1 to 10.11.13.2 and from compute0's VM2 to 10.11.13.2.
    3. At this point ODL LFM MS should be populated with mapping records. Check that by:
       mappingservice:mappings
    4. After the `neutron data` call, we have to setup VPP for LISP and we have to provision the
       netns. It's very easy.

       cd /vagrant/lisp_scripts/new

       Run the respective script is the respective compute host based on the scenario.

As the last thing you need to assign Tap ports which were created by the above configuration to according namespaces.
