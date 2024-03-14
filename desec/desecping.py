#!/usr/bin/python

from scapy.all import *
conf.verb = 0

for ip in range(1,255):
    iprange = "".join(("192.168.1.", str(ip)))
    pIP = IP(dst=iprange)
    pacote = pIP/ICMP()
    resp, noresp = sr(pacote,timeout=1)
    if resp:
        resp[0][1].show()
