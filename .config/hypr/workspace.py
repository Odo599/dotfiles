import argparse
import subprocess
import json

parser = argparse.ArgumentParser()
parser.add_argument("workspace", help="The id of the workspace to switch to in terms of the monitor", type=int)

args = parser.parse_args()
workspace: int = args.workspace
print("Workspace:", workspace)

monitors = json.loads(subprocess.run(["hyprctl","monitors","-j"], capture_output=True).stdout)
for m in monitors:
    if m['focused']:
        mname = m['name']

print("Active monitor:", mname)
if mname == "HDMI-A-1":
    rw = workspace + 3
else:
    rw = workspace

print("Switching to workspace", rw)
subprocess.run(["hyprctl", "dispatch", "workspace", str(rw)])
