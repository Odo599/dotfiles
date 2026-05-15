pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var workspaces: []
    property var currentWorkspace: -1
    property var monitorsCount: 1

    Process {
        id: monitorProc
        command: ["hyprctl", "monitors", "-j"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
               monitorsCount = JSON.parse(text).length 
            }
        }
    }

    Process {
        id: workspacesProc
        command: ["hyprctl", "workspaces", "-j"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let ws = []
                let highest = monitorsCount == 1 ? 1 : 6 
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
                    if (monitorsCount == 1) ws.push({"id": i, "window": "___emptyworkspace___", "monitor": "eDP-1"})
                    else ws.push({"id": i, "window": "___emptyworkspace___", "monitor": i < 4 ? "eDP-1" : "HDMI-A-1"})
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

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            monitorProc.running = true
        }
    }
}
