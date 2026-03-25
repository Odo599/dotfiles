import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: root

    // spacing between child components
    property int spacing: 8
    property int padding: 8
    property color bgColor: "#99000000" // default semi-transparent background
    property int radius: 10

    // key: allows adding arbitrary components as children
    default property alias content: container.data

    // implicit size includes padding
    implicitWidth: container.implicitWidth + 2 * padding
    implicitHeight: container.implicitHeight + 2 * padding
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 5

    Rectangle {
        id: wrapper
        anchors.fill: parent
        radius: root.radius
        color: root.bgColor

        // layout holds all child components
        RowLayout {
            id: container
            anchors.fill: parent
            anchors.margins: root.padding
            spacing: root.spacing
        }
    }
}