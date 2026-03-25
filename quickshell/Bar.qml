import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Scope {
    id: root
    property string textColor: "#E6E6FA"
    property string bgColor: "#0B0C0C"
    property string transparent: "#00000000"
    property string dividerColor: "#999999"

    function getBatteryIcon(percentage) {
        if (percentage < 10) return ""
        else if (percentage < 33) return ""
        else if (percentage < 67) return ""
        else if (percentage < 90) return ""
        else return ""
    }

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
            implicitHeight: 40

            color: transparent
            // Right Group
            Group {
                anchors.right: parent.right
                bgColor: root.bgColor
                // Battery
                Text {
                    color: textColor
                    text: Battery.percentage + "% "
                    font.family: "Roboto"
                    font.pointSize: 11
                }
                Text {
                    color: textColor
                    text: (Battery.charging ? "" : getBatteryIcon(Battery.percentage))
                    font.pointSize: 11
                    font.family: "Font Awesome 7 Free Solid"
                }
                Divider {}
                // Date and Time
                Text {
                    color: textColor
                    text: Time.time
                    font.pointSize: 11
                    font.family: "Roboto"
                }

            }
        }
    }
}