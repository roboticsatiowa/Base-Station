# echo-server.py

import socket
import sys
from time import sleep

import pygame

from src import XBcontroller


def main():

    try:
        HOST = sys.argv[1]
    except IndexError:
        HOST = input("IPv4: ") # 192.168.1.13
    try: 
        PORT = int(sys.argv[2])
    except IndexError:
        PORT = int(input("PORT: "))

    pygame.init()
    cont = XBcontroller.XBcontroller()

    # AF_INET specifies IPv4        SOCK_STREAM specifies TCP Protocol
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        print(f"Starting server on: {HOST} Port: {PORT}...")
        s.bind((HOST, PORT))
        s.listen()
        conn, addr = s.accept()

        with conn:
            print(f"Connected to client {addr[0]} on port {addr[1]}")

            while True:
                events = pygame.event.get()
                for event in events:  # allows multiple events to be handled at once
                    # inp = input("Enter msg:")
                    inp = cont.getInput(event)
                    if inp:
                        conn.sendall(inp.encode('UTF-8'))
                    sleep(0.01)


if __name__ == '__main__':
    main()