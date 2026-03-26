pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property int volume: parsed[0]
    property bool muted: parsed[1] === "1"

    property var parsed: {
        let parts = reader.text().trim().split(" ")
        return [
            Number(parts[0]) || 50,
            parts[1] || "0"
        ]
    }

    FileView {
        id: reader
        path: "/tmp/quickshell-volume"
        watchChanges: true
        onFileChanged: reload()
    }
}