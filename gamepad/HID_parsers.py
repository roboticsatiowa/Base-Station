
DEADZONE = 20

def dualshock_4(hid_obj):
    def process_joy_axis(val):
        val = 2*val-255
        if abs(val) <= DEADZONE:
            return 0
        return val
    
    axes = []
    buttons = []
    
    report = hid_obj.read(64)
    
    if not report:
        return None, None
    
    # for some reason playstion hat buttons are setup very weirdly
    # this translates the bitmap so 1 bit corresponds to each button
    hat_map = {
        '1000':'0000',
        '0100':'1000',
        '0110':'0100',
        '0010':'0010',
        '0000':'0001',
        '0101':'1100',
        '0011':'1010',
        '0001':'0011',
        '0111':'0101'}
    
    axes.append(process_joy_axis(report[1]))
    axes.append(process_joy_axis(report[2]))
    axes.append(process_joy_axis(report[3]))
    axes.append(process_joy_axis(report[4]))
    axes.append(report[8])
    axes.append(report[9])
    
    button_map_1 = f"{report[5]:08b}"
    button_map_1 = button_map_1[:4] + hat_map[button_map_1[4:]]
    button_map_2 = f"{report[6]:08b}"
    button_map_3 = f"{report[7]:08b}"
    
    buttons.append(int(button_map_1[2]))
    buttons.append(int(button_map_1[3]))
    buttons.append(int(button_map_1[1]))
    buttons.append(int(button_map_1[0]))
    buttons.append(int(button_map_1[4]))
    buttons.append(int(button_map_1[5]))
    buttons.append(int(button_map_1[6]))
    buttons.append(int(button_map_1[7]))
    buttons.append(int(button_map_2[7]))
    buttons.append(int(button_map_2[6]))
    buttons.append(int(button_map_2[1]))
    buttons.append(int(button_map_2[0]))
    buttons.append(int(button_map_2[3]))
    buttons.append(int(button_map_2[2]))
    buttons.append(int(button_map_3[7]))
    return axes, buttons

pid_callback_map = {
    0x09cc:dualshock_4
}