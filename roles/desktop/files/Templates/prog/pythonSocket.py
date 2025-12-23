#!/usr/bin/env python3

import socket

SERVER_IP = "localhost"
SERVER_PORT = 5438

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    print(f"Connecting to {SERVER_IP}:{SERVER_PORT}...")
    s.connect((SERVER_IP, SERVER_PORT))
    print("Connected. Type messages (Ctrl+C to exit).")

    while True:
        message = input("> ")
        if not message:
            continue
        s.sendall(message.encode())
        data = s.recv(1024)
        print("Server:", data.decode())
