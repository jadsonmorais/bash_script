#!/usr/bin/python
import socket
import sys
import re

with open("lista.txt", 'r', encoding='utf8') as file:
    for i in file:
        try:
            tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            tcp.connect((str(sys.argv[1]), 25))
            banner = tcp.recv(1024)
            banner = banner.decode()
            tcp.send(str(f"VRFY {i}").encode())
            user = tcp.recv(1024)
            user = user.decode()
            if re.search("252", user):
                user = user.strip("252 2.0.0")
                print(str(f'Usuario encontrado: {user}'))
                
        except Exception as e:
            print(e)
