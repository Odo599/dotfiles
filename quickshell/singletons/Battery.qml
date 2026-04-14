pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io


Singleton {
    readonly property string percentage: Math.round(100 * Number(chargeNowReader.text().trim()) / Number(chargeFullReader.text().trim()))
    readonly property bool charging: statusReader.text().trim() !== "Discharging"

    FileView {
        id: statusReader
        path: Qt.resolvedUrl("/home/odo59/.config/quickshell/powersymlink/status")
    }

    FileView {
        id: chargeNowReader
        path: Qt.resolvedUrl("/home/odo59/.config/quickshell/powersymlink/energy_now")
    }

    FileView {
        id: chargeFullReader
        path: Qt.resolvedUrl("/home/odo59/.config/quickshell/powersymlink/energy_full")
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            chargeNowReader.reload()
            chargeFullReader.reload()
            statusReader.reload()
        }
    }
}