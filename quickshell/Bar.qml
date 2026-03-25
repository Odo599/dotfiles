import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Scope {
    id: root
    property string textColor: "#f1c232"
    property string bgColor: "#211338"
    property string transparent: "#00000000"
    property string dividerColor: "#999999"

    Variants {
        model: Quickshell.screens;
        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 45

            color: transparent
            Group {
                anchors.right: parent.right
                Text {
                    color: textColor
                    text: Time.time
                    font.pointSize: 11
                }

            }
        }
    }
}