import sys
import subprocess
import json

activewindow_info = json.loads(
    subprocess.run(
        ["hyprctl", "-j", "activewindow"], stdout=subprocess.PIPE
    ).stdout.decode("utf-8")
)

x = activewindow_info["at"][0]
y = activewindow_info["at"][1]
window_width = activewindow_info["size"][0]
window_height = activewindow_info["size"][1]

monitor_info = json.loads(
    subprocess.run(
        ["hyprctl", "-j", "monitors", "active"], stdout=subprocess.PIPE
    ).stdout.decode("utf-8")
)
monitor_width = monitor_info[0]["width"]
monitor_height = monitor_info[0]["height"]


left = 10
top = 40
right = monitor_width - 10 - window_width
bottom = monitor_height - 10 - window_height

where = sys.argv[1]
if where == "tl" or where == "lt":
    dx = left - x
    dy = top - y
elif where == "tr" or where == "rt":
    dx = right - x
    dy = top - y
elif where == "bl" or where == "lb":
    dx = left - x
    dy = bottom - y
elif where == "br" or where == "rb":
    dx = right - x
    dy = bottom - y
elif where == "lc" or where == "cl":
    dx = left - x
    dy = (top + bottom) // 2 - y
elif where == "rc" or where == "cr":
    dx = right - x
    dy = (top + bottom) // 2 - y
elif where == "tc" or where == "ct":
    dx = (left + right) // 2 - x
    dy = top - y
elif where == "bc" or where == "cb":
    dx = (left + right) // 2 - x
    dy = bottom - y
elif where == "cc":
    dx = (left + right) // 2 - x
    dy = (top + bottom) // 2 - y
else:
    exit(1)

subprocess.run(["hyprctl", "dispatch", "moveactive", str(dx), str(dy)])
