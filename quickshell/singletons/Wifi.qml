// Wifi.qml
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    readonly property string ssid: _ssid
    readonly property bool connected: _ssid !== ""

    property string _ssid: ""

    Process {
        id: wifiProc
        command: ["bash", "-c", "nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d':' -f2"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                Wifi._ssid = text.trim()
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: wifiProc.running = true
    }
}