#!/usr/bin/python

# A ideia do script e reproduzir o comportamento do whois
import socket,sys,re

_ISO_88591 = "ISO-8859-1"
_UTF8 = "utf-8"
padrao_whois = r'refer:\s+(\S+)'
padrao_nserver = r'nserver:\s+(\S+)'
padrao_ipv4 = r'nserver:\s+A\.DNS\.BR\s+(\d+\.\d+\.\d+\.\d+)'
padrao_ipv6 = r'nserver:\s+A\.DNS\.BR\s+\d+\.\d+\.\d+\.\d+\s+([a-fA-F0-9:]+)'

TARGET = sys.argv[1]
IANA = "whois.iana.org"
REGISTROBR = 'whois.registro.br'

def consulta(dominio, msg, _format_res, _format_msg):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((dominio, 43))
    s.send(str(msg).encode(_format_msg))
    res = s.recv(1024)
    res = res.decode(_format_res)
    s.close()
    return res

def descobrePadrao(padrao_whois, texto):
    correspondencia_whois = re.search(padrao_whois, texto)
    if correspondencia_whois:
        resultado_whois = correspondencia_whois.group(1)
        return resultado_whois       


res = consulta(IANA, str(TARGET+"\r\n"), _UTF8, _UTF8)
dominio = descobrePadrao(padrao_whois, res)
ipv4 = descobrePadrao(padrao_ipv4, res)
ipv6 = descobrePadrao(padrao_ipv6, res)
print(res)
print(30*"*")

if dominio == REGISTROBR:
    # faca a consulta no whois do registro.br
    res = consulta(dominio, str(TARGET+"\r\n"), _ISO_88591, _ISO_88591)
    print(res)
    print(30*"*")
else:
   # faca a consulta no whois do registro.br
    res = consulta(dominio, str(TARGET+"\r\n"), _UTF8, _UTF8)
    print(res)
    print(30*"*")
 
