#!/usr/bin/env python3

import json
import subprocess

# Map classes/titles → icons
ICON_MAP = [
    ({"class": "firefox", "title": "github"}, ""),
    ({"class": "firefox"}, ""),
    ({"title": "youtube"}, ""),
    ({"class": "code"}, ""),
    ({"class": "alacritty"}, ""),
]

DEFAULT_ICON = ""
EMPTY_ICON = ""
CELL_WIDTH = 3  # adjust for spacing

def hyprctl(cmd):
    return json.loads(subprocess.check_output(["hyprctl"] + cmd + ["-j"]))

def match_icon(client):
    cls = (client.get("class") or "").lower()
    title = (client.get("title") or "").lower()

    for rule, icon in ICON_MAP:
        if "class" in rule and rule["class"] not in cls:
            continue
        if "title" in rule and rule["title"] not in title:
            continue
        return icon

    return DEFAULT_ICON

def pad(s):
    return s.center(CELL_WIDTH)

def main():
    clients = hyprctl(["clients"])
    workspaces = hyprctl(["workspaces"])
    active_ws = hyprctl(["activeworkspace"])["id"]

    ws_map = {}
    for c in clients:
        ws_id = c["workspace"]["id"]
        if ws_id not in ws_map or c["focusHistoryID"] < ws_map[ws_id]["focusHistoryID"]:
            ws_map[ws_id] = c

    segments = []
    ws_ids = []

    for ws in sorted(workspaces, key=lambda w: w["id"]):
        ws_id = ws["id"]
        ws_ids.append(ws_id)

        if ws_id in ws_map:
            icon = match_icon(ws_map[ws_id])
        else:
            icon = EMPTY_ICON

        icon = pad(icon)

        if ws_id == active_ws:
            icon = f"<b>{icon}</b>"

        segments.append(icon)

    print(json.dumps({
        "text": " ".join(segments),
        "tooltip": " ".join(map(str, ws_ids))
    }))

if __name__ == "__main__":
    main()
