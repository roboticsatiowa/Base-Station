import pickle
import socket
import struct
import sys

import cv2

# echo-server.py


try:
    HOST = sys.argv[1]
except IndexError:
    HOST = input("IPv4: ") # 192.168.1.13

try: 
    PORT = int(sys.argv[2])
except IndexError:
    PORT = int(input("PORT: "))
    
try: 
    window_name = sys.argv[3]
except IndexError:
    window_name = input("PORT: ")

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
        cv2.namedWindow(window_name, cv2.WINDOW_NORMAL)
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
            #imS = cv2.resize(frame, (800, 800)) 
            cv2.imshow(window_name, frame)
            key = cv2.waitKey(1) & 0xFF
            if key == ord('q'):
                break
