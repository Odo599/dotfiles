import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "singletons" as Si
import "widgets" as Wd

Scope {
    id: root
    property string textColor: "#E6E6FA"
    property string bgColor: "#0B0C0C"
    property string selectedColor: "#007DFF"
    property string transparent: "#00000000"
    property string dividerColor: "#999999"

    property string awesomeFont: "Font Awesome 7 Free Solid"
    property string awesomeFontRegular: "Font Awesome 7 Free"
    property string mainFont: "MonaspiceRnNerd Font"

    function getBatteryIcon(percentage) {
        if (percentage < 10) return ""
        else if (percentage < 33) return ""
        else if (percentage < 67) return ""
        else if (percentage < 90) return ""
        else return ""
    }

    function getVolumeIcon(percentage) {
        if (percentage <= 0) return ""
        else if (percentage <= 50) return ""
        else return ""
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
            // MIDDLE GROUP
            Wd.Group {
                anchors.horizontalCenter: parent.horizontalCenter
                roundRightBottom: true
                roundLeftBottom: true

                Wd.Workspaces {
                    screenName: screen.name
                }
            }
            // LEFT GROUP
            Wd.Group {
                anchors.left: parent.left
                roundRightBottom: true
                // Wifi
                Wd.IconText {
                    text: (Si.Wifi.connected ? "" : "")
                }
                Wd.TextWid {
                    text: " " + (Si.Wifi.connected ? Si.Wifi.ssid : "Disconnected")
                }
            }
            // RIGHT GROUP
            Wd.Group {
                anchors.right: parent.right
                roundLeftBottom: true
                // Volume
                Wd.TextWid {
                    text: (Si.Volume.muted ? 0 : Si.Volume.volume) + "% "
                }
                Wd.IconText {
                    text: (Si.Volume.muted ? "" : getVolumeIcon(Si.Volume.volume))
                }
                Wd.Divider {}
                // Battery
                Wd.TextWid {
                    text: Si.Battery.percentage + "% "
                }
                Wd.IconText {
                    text: (Si.Battery.charging ? "" : getBatteryIcon(Si.Battery.percentage))
                }
                Wd.Divider {}
                // Date and Time
                Wd.IconText {
                    text: " "
                    font.family: awesomeFontRegular
                }
                Wd.TextWid {
                    text: Si.Time.time
                }
                Wd.IconText {
                    text: "  "
                    font.family: awesomeFontRegular
                }
                Wd.TextWid {
                    text: Si.Time.date
                }
            }
        }
    }
}
