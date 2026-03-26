pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io


Singleton {
    readonly property string percentage: Math.round(100 * Number(chargeNowReader.text().trim()) / Number(chargeFullReader.text().trim()))
    readonly property bool charging: statusReader.text().trim() !== "Discharging"

    FileView {
        id: statusReader
        path: Qt.resolvedUrl("/sys/class/power_supply/macsmc-battery/status")
    }

    FileView {
        id: chargeNowReader
        path: Qt.resolvedUrl("/sys/class/power_supply/macsmc-battery/charge_now")
    }

    FileView {
        id: chargeFullReader
        path: Qt.resolvedUrl("/sys/class/power_supply/macsmc-battery/charge_full")
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