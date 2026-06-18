import QtQuick
import QtQml.Models
import "../singletons" as Si

Item {
    id: root
    required property string screenName

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    function getIcon(w) {
        if (w.window === "alacritty") return "\uf120"
        else if (w.window === "___emptyworkspace___") return "\uf111"
        else if (w.window.toLowerCase().includes("firefox") || w.window.toLowerCase().includes("floorp")) return "\ue007"
        else if (w.window.toLowerCase().includes("chromium")) return "\uf268"
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

    function getRelevantWorkspaces(ws) {
        return ws.filter((w) => {
            return w.monitor === screenName
        })
    }

    Row {
        id: row
        spacing: 10
        Repeater {
            model: getRelevantWorkspaces(Si.Workspaces.workspaces)
            delegate: IconText {
                text: (getIcon(modelData))
                color: (getColor(modelData, Si.Workspaces.currentWorkspace))
                font.family: (getFont(modelData))
            }
        }
    }
}
