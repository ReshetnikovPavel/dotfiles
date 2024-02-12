import sys
import subprocess
import json


name = sys.argv[1]

clients = json.loads(
    subprocess.run(
        ["hyprctl", "-j", "clients"], stdout=subprocess.PIPE
    ).stdout.decode("utf-8")
)

for client in clients:
    if client["class"] != name:
        continue
    workspace_id = client["workspace"]["id"]
    (subprocess.run(["hyprctl", "dispatch", "workspace", str(workspace_id)])
               .check_returncode())

    active = json.loads(
        subprocess.run(
                ["hyprctl", "-j", "activewindow"], stdout=subprocess.PIPE
        ).stdout.decode("utf-8")
    )
    if active["fullscreen"] and active["class"] != name:
        (subprocess.run(["hyprctl", "dispatch", "fullscreen", "1"])
                   .check_returncode())
    exit(0)

exit(1)
