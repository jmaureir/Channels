// Copyright Juan-Carlos Maureira 2010
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

import inet.nodes.ethernet.EtherSwitch;
import inet.nodes.inet.Router;
import inet.nodes.inet.StandardHost;
import DHCP.DHCPClient;
import DHCP.DHCPServer;

import channels.MyThroughputMeteringChannel;

//
// Example how to measure the throughput between two devices
//
network MeasuringThroughput
{
    @display("bgb=572,323");
    submodules:
        host1: StandardHost {
            @display("p=50,264");
            numUdpApps = 1;
            udpAppType = "DHCP.DHCPClient";
        }
        host2: StandardHost {
            @display("p=521,271");
            numUdpApps = 1;
            udpAppType = "DHCP.DHCPClient";
        }
        router1: Router {
            @display("p=182,75");
            routingFile = "router1.rt";
        }
        router2: Router {
            @display("p=399,75");
            routingFile = "router2.rt";
        }
        dhcpServer1: StandardHost {
            @display("p=62,98");
            routingFile = "dhcpServer1.rt";
            numUdpApps = 1;
            udpAppType = "DHCP.DHCPServer";
        }
        dhcpServer2: StandardHost {
            @display("p=514,110");
            routingFile = "dhcpServer2.rt";
            numUdpApps = 1;
            udpAppType = "DHCP.DHCPServer";
        }
        etherSwitch: EtherSwitch {
            @display("p=116,191");
        }
        etherSwitch1: EtherSwitch {
            @display("p=463,191");
        }
    connections:
        // Measure the link between the two routers and record the average(b) and current(B) bandwidth
        router1.ethg++ <--> MyThroughputMeteringChannel {  delay = 100us; format = "b B"; } <-->  router2.ethg++;
        
        host1.ethg++ <--> etherSwitch.ethg++;
        etherSwitch.ethg++ <--> dhcpServer1.ethg++;
        host2.ethg++ <--> etherSwitch1.ethg++;
        etherSwitch1.ethg++ <--> dhcpServer2.ethg++;
        etherSwitch1.ethg++ <--> router2.ethg++;
        etherSwitch.ethg++ <--> router1.ethg++;
}
