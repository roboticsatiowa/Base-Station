import pickle
import socket
import struct
from time import sleep

import cv2
import imutils

# echo-server.py


HOST = "192.168.1.13" 
PORT = 55555  # Port to listen on (non-privileged ports are > 1023)

# AF_INET specifies IPv4        SOCK_STREAM specifies TCP Protocol
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    print(f"Starting server on: {HOST} Port: {PORT}...")
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print("video stream started")

        data = b''

        payload_size = struct.calcsize("Q")
        while True:
            i = 0
            packet = conn.recv(4 * 1024)
            if not packet:
                break
            data += packet
            packed_msg_size = data[:payload_size]
            data = data[payload_size:]
            msg_size = struct.unpack("Q", packed_msg_size)[0]
            while len(data) < msg_size:
                data += conn.recv(4 * 1024)
            frame_data = data[:msg_size]
            data = data[msg_size:]
            frame = pickle.loads(frame_data)
            cv2.imshow("Receiving...", frame)
            key = cv2.waitKey(1) & 0xFF
            if key == ord('q'):
                break
