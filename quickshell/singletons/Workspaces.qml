pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var workspaces: []
    property var currentWorkspace: -1

    Process {
        id: workspacesProc
        command: ["hyprctl", "workspaces", "-j"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let ws = []
                let highest = 6
                let lowest = -1
                JSON.parse(text).forEach((w) => {
                    ws.push({
                        "id": w.id,
                        "window": w.lastwindowtitle,
                        "monitor": w.monitor
                    })
                    if (w.id > highest) highest = w.id
                })
                for (let i = 1; i <= highest; i++) {
                    if (!ws.some((w) => w.id === i))
                    ws.push({"id": i, "window": "___emptyworkspace___", "monitor": i < 4 ? "eDP-1" : "HDMI-A-1"})
                }
                ws.sort((a,b) => a.id - b.id);

                workspaces = ws
            }
        }
    }

    Process {
        id: activeWorkspaceProc
        command: ["hyprctl", "activeworkspace", "-j"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: currentWorkspace = JSON.parse(text).id
        }
    }

    Timer {
        interval: 300
        running: true
        repeat: true
        onTriggered: {
            workspacesProc.running = true
            activeWorkspaceProc.running = true
        }
    }
}