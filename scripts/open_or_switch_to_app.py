import sys
import subprocess
import json


IGNORE_SWITCH_TO = [
    "firefox",
    "org.codeberg.dnkl.foot",
    "org.gnome.Loupe",
]


def switch_to(class_name: str) -> bool:
    clients = json.loads(
        subprocess.run(
            ["hyprctl", "-j", "clients"], stdout=subprocess.PIPE
        ).stdout.decode("utf-8")
    )

    for client in clients:
        if client["class"] != class_name:
            continue
        workspace_id = client["workspace"]["id"]
        (subprocess.run(["hyprctl", "dispatch", "workspace", str(workspace_id)])
                   .check_returncode())

        active = json.loads(
            subprocess.run(
                ["hyprctl", "-j", "activewindow"], stdout=subprocess.PIPE
            ).stdout.decode("utf-8")
        )
        if active["fullscreen"] and active["class"] != class_name:
            (subprocess.run(["hyprctl", "dispatch", "fullscreen", "1"])
                       .check_returncode())
        return True
    return False


def open_or_switch_to_app(desktop_file_name: str) -> None:
    if desktop_file_name not in IGNORE_SWITCH_TO:
        if switch_to(desktop_file_name) or switch_to(desktop_file_name + ".desktop"):
            return
    try:
        subprocess.run(["gtk-launch", desktop_file_name]).check_returncode()
    except subprocess.CalledProcessError:
        subprocess.run(["gtk-launch", desktop_file_name + ".desktop"]).check_returncode()


if __name__ == "__main__":
    desktop_file_name_without_extension = sys.argv[1]
    open_or_switch_to_app(desktop_file_name_without_extension)
