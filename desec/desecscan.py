#!/usr/bin/python

import sys
from scapy.all import *

# Para desabilitar o modo verbose
conf.verb = 0

portas = [21,22,23,25,80,443,110]

# Usar sys.argv[1] para pegar o IP dinamicamente
pIP = IP(dst="192.168.1.8")
pTCP = TCP(dport=portas,flags="S")
pacote = pIP/pTCP
resp, noresp = sr(pacote)
# Vendo a resposta com comando show
# print(resp.show())
# Vendo o detalhe do primeiro pacote enviado
# print(resp[0][0].show())
# Vendo o detalhe do primeiro pacote
# print(resp[0][1].show())
# Vendo o resultado de uma flag específica
# print(resp[4][1][TCP].flags)
# Vendo quais resostas retornaram a flag SA e em seguida
#  mostra as portas

#for i in resp:
#    flag = i[1][TCP].flags
#    if flag == 'SA':
#        open_port = i[1][TCP].sport
#        print(open_port, flag)
        
    
