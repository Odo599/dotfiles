pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io


Singleton {
    property string percentage: "100"
    property bool charging: false 

    Process {
        id: batteryProc
        command: ["bash","-c","upower -b | jc --upower"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const parsed = JSON.parse(this.text)
                percentage = parsed[0].detail.percentage
                charging = parsed[0].detail.state == "discharging" ? false : true
            }
        }

    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            batteryProc.running = true
        }
    }
}
