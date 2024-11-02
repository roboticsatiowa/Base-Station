# hidapi
# roslibpy

import hid
import roslibpy
import HID_parsers
from time import time, time_ns

gamepad_device = None
timeout = time() + 30
while True:
    for device in hid.enumerate():
        if device["product_string"] == "Wireless Controller":
            gamepad_device = device
    if gamepad_device:
        break
    if time() > timeout:
        raise Exception("Gamepad not found")

print(
    f"Found gamepad: {gamepad_device['manufacturer_string']} {gamepad_device['product_string']}"
)

hid_obj = hid.device()
hid_obj.open(gamepad_device["vendor_id"], gamepad_device["product_id"])
hid_obj.set_nonblocking(True)

hid_callback = HID_parsers.pid_callback_map[gamepad_device["product_id"]]

rosbridge_client = roslibpy.Ros("localhost", 7492)
rosbridge_client.run()

print("Connected to rosbridge on localhost:7492")

joy_topic = roslibpy.Topic(rosbridge_client, "/joy", "sensor_msgs/msg/Joy", throttle_rate=(1/20)*1000, queue_length=1)

print("Gamepad is now publishing to /joy")

prev = None
time_last = time()
while rosbridge_client.is_connected:
    # allowing unconstrained publishing rate causes severe lag. current rate is 20Hz (50ms).
    # Since we arent professional esports players, this should be fine. Our robot is slow anyway.
    if time() - time_last > 0.05:
        axes, buttons = hid_callback(hid_obj)
        if axes and buttons:
            prev = (axes, buttons)
        elif prev:
            axes, buttons = prev
            
        time_last = time()
        joy_topic.publish(
            roslibpy.Message(
                {
                    "axes": axes,
                    "buttons": buttons,
                }
            )
        )
