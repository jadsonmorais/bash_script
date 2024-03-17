#!/usr/bin/python
import socket
import sys

if len(sys.argv)!=3:
    print("Modo de uso: python smtpenum.py IP usuario")
    sys.exit(0)

tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
tcp.connect((str(sys.argv[1]), 25))
banner = tcp.recv(1024)
print(3 * "*" + "SMTPENUM" + 30 * "*")
print(banner.decode())

# Enviando comandos
tcp.send(str("VRFY "+sys.argv[2]+"\r\n").encode())
user = tcp.recv(1024)
user = user.decode()
print(user)
