'''
Created on 

@author: Marius Roets
'''

import os
import sys
import re

#Before
#linux-0hl4:~ # route -n
#Kernel IP routing table
#Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
#0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 wlp3s0
#172.24.229.0    0.0.0.0         255.255.255.0   U     0      0        0 enp0s25
#192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 wlp3s0
#After
#linux-0hl4:~ # route -n
#Kernel IP routing table
#Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
#0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 wlp3s0
#0.0.0.0         172.24.229.1    0.0.0.0         UG    1024   0        0 enp0s25
#147.110.0.0     0.0.0.0         255.255.0.0     U     0      0        0 enp0s25
#172.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 enp0s25
#172.24.229.1    0.0.0.0         255.255.255.255 UH    1024   0        0 enp0s25


class Address:
    ip = "";
    netmask = "";
    gw = "";
    dev = "";
    def __init__(self, ip, netmask, gw, dev):
        self.ip = ip
        self.netmask = netmask
        self.gw = gw
        self.dev = dev

class Device:
    name = "";
    type = "";
    gw = "";
    network = "";
    present = False
    def __init__(self, name, type):
        self.name = name
        self.type = type
        self.present = False
        self.network = ""
        self.gw = ""


class Devices:
    wifi = "wlan0"
    eth = "eth0"
    vpn = "vpn0"
    G3 = "ppp0"
    list = {}

    def __init__(self):
        self.list[self.wifi] = Device(self.wifi, "wifi")
        self.list[self.eth] = Device(self.eth, "eth")
        self.list[self.vpn] = Device(self.vpn, "vpn")
        self.list[self.G3] = Device(self.G3, "3G")

    def setPresent(self, name):
        self.list[name].present = True

    def setNotPresent(self, name):
        self.list[name].present = False

    def setGW(self, name, gw):
        self.list[name].gw = gw

    def setNetwork(self, name, network):
        self.list[name].network = network

    def device(self, name):
        return self.list[name]

    def device_by_type(self, type):
        for dev in self.list:
            if self.list[dev].type == type:
                return self.list[dev]
        return "";

    def is_present(self, name):
        return self.list[name].present

class Route:
    def __init__(self, route):
        self.network = route[0]
        self.gateway = route[1]
        self.netmask = route[2]
        self.device = route[7]
        if self.network == "0.0.0.0":
            self.type = "gateway"
        elif re.search(r"\d+\.\d+\.\d+\.1",self.network):
            self.type = "gateway_route"
        else:
            self.type = "network"

class RoutingTable:

    def __init__(self):
        self.devices = Devices()
        self.routes = []
        self.determineGateways()

    def determineGateways(self):
        output = os.popen("route -n","r") 
        line = output.readline()
        line = output.readline()
        line = output.readline()
        while (line):
            fields = line.split()
            route = Route(fields)
            self.routes.append(route)
            name = fields[7]
            self.devices.setPresent(name)

            if fields[0] == "0.0.0.0":
                self.devices.setGW(name,fields[1])

            if (fields[1] == "0.0.0.0"):
                d = self.devices.device(name)
                if route.type == "network":
                    self.devices.setNetwork(name, fields[0])
                if not d.gw:
                    gw = fields[0]
                    gw = gw.replace(".0", ".1", -1)
                    self.devices.setGW(name, gw)

            line = output.readline()

    def deleteNetworks(self, type):
        for r in self.routes:
            if r.type == type:
                print "* Deleting network {0} netmask {1} gw {2} dev {3}".format(
                    r.network,r.netmask,r.gateway,r.device)
                print("route del -net {0} netmask {1} gw {2} {3}".format(
                    r.network,r.netmask,r.gateway,r.device))
                os.system("route del -net {0} netmask {1} gw {2} {3}".format(
                    r.network,r.netmask,r.gateway,r.device))

    def setDefaultGW(self, dgw):
        print "* Setting default gw : {0}".format(dgw)
        print("route add default gw {0}".format(dgw))
        os.system("route add default gw {0}".format(dgw))

    def addNetwork(self, net, mask, device = "", gw = ""):
        print "* Adding network",
        if gw:
            print "using gw {0}".format(gw)
            print("route add -net {0} netmask {1} gw {2}".format(net,mask,gw)) 
            os.system("route add -net {0} netmask {1} gw {2}".format(net,mask,gw)) 
        elif device:
            print "using device {0}".format(device)
            print("route add -net {0} netmask {1} dev {2}".format(net,mask,device)) 
            os.system("route add -net {0} netmask {1} dev {2}".format(net,mask,device)) 
    
    def setupNetwork(self):
        os.system("ip route flush table main")
        os.system("ip route flush table main")
        ### First we delete any gateway routes
        #self.deleteNetworks("gateway_route")
        ### Then we delete all default gateways
        #self.deleteNetworks("gateway")

        ### Add Eskom networks
        eskom = self.eskomAddresses()
        for e in eskom:
            self.addNetwork(e.ip, e.netmask, e.dev)
        ### Add wifi network
        dev = self.devices.device_by_type("wifi")
        self.addNetwork(dev.network, "255.255.255.0", dev.name)
        ### Add the new default gateway (It is always the gateway for the wifi device)
        self.setDefaultGW(dev.gw)

    def eskomAddresses(self):
        dev = self.devices.device_by_type("eth")
        gw = ""
        name = ""
        if dev.present:
            gw = dev.gw
            name = dev.name
        if not gw:
            dev = self.devices.device_by_type("vpn")
            gw = dev.gw
            name = dev.name
        if not gw:
            print "Could not determine Eskom gateway"
            sys.exit(1)
            
        list = []
        list.append(Address("147.110.0.0", "255.255.0.0", gw, name))
        list.append(Address("172.0.0.0", "255.0.0.0", gw, name))
        return list;

if __name__ == "__main__":

    r = RoutingTable()
    #print vars(r.devices.device("enp0s25"))
    #print vars(r.devices.device("wlp3s0"))
    #print vars(r.devices.device("vpn0"))
    #print vars(r.devices.device("ppp0"))
    #for i in r.routes:
    #    print vars(i)

    r.setupNetwork()


