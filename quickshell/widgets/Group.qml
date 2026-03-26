import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: root

    property int spacing: 0
    property int padding: 8
    property color bgColor
    property int radius: 12

    property bool roundLeftBottom: false
    property bool roundRightBottom: false
    default property alias content: container.data

    height: parent.height
    implicitWidth: container.implicitWidth + 2 * padding
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
        id: wrapper
        anchors.fill: parent
        bottomLeftRadius: root.roundLeftBottom ? root.radius : 0
        bottomRightRadius: root.roundRightBottom ? root.radius : 0
        color: root.bgColor

        RowLayout {
            id: container
            anchors.fill: parent
            anchors.margins: root.padding
            spacing: root.spacing
        }
    }
}