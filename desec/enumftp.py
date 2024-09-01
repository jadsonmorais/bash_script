#!/usr/bin/python

import socket

tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
tcp.connect(("172.16.1.108", 21))

print("Conectando ao servidor...")
banner = tcp.recv(1024)
print(banner.decode())

print("Enviando usuario")
tcp.send("USER ftp\r\n".encode('utf8'))
user = tcp.recv(1024)
print(user.decode())


print("Enviando senha")
tcp.send("PASS ftp\r\n".encode('utf8'))
key = tcp.recv(1024)
print(key.decode())


print("Enviando comando HELP")
tcp.send("HELP\r\n".encode('utf8'))
tcp.send("PWD\r\n".encode('utf8'))
cmd = tcp.recv(2048)
print(cmd.decode())
