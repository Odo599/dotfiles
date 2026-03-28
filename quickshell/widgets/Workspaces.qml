import QtQuick
import QtQml.Models
import "../singletons" as Si

Item {
    id: root

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    function getIcon(w) {
        if (w.window === "alacritty") return "\uf120"
        else if (w.window === "___emptyworkspace___") return "\uf111"
        else if (w.window.toLowerCase().includes("firefox")) return "\ue007"
        else if (w.window.toLowerCase().includes("code")) return "\uf121"
        else return "\uf111"
    }

    function getColor(w, cid) {
        if (w.id === cid) return selectedColor
        else return textColor
    }

    function getFont(w) {
        if (w.window === "___emptyworkspace___") return awesomeFontRegular
        else return awesomeFont
    }

    Row {
        id: row
        spacing: 10
        Repeater {
            model: Si.Workspaces.workspaces
            delegate: IconText {
                text: (getIcon(modelData))
                color: (getColor(modelData, Si.Workspaces.currentWorkspace))
                font.family: (getFont(modelData))
            }
        }
    }
}