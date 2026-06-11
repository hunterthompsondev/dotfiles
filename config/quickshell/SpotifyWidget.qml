import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell

Item {
    id: root
    property color widgetTextColor
    property int maxWidth: 10000
    property int outerMargin: 4
    property int pillHeight: parent.height - outerMargin * 2
    property int cornerRadius: 10
    property int imageMargin: 2
    property int imageRadius: Math.max(0, cornerRadius - imageMargin)

    implicitWidth: pill.width + outerMargin * 2
    implicitHeight: pill.height + outerMargin * 2

    Rectangle {
        id: pill
        anchors.centerIn: parent
        width: Math.min(rowLayout.implicitWidth + 24, root.maxWidth)
        height: root.pillHeight
        radius: root.cornerRadius
        color: "#50000000"

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: root.cornerRadius
            border.color: "#403b4252"
            border.width: 2
        }

        Rectangle {
            width: parent.width * PlayerCtlService.completionFraction
            height: parent.height
            clip: true

            color: "transparent"
            Rectangle {
                width: pill.width
                height: pill.height
                color: "transparent"
                radius: root.cornerRadius
                border.color: "#5e81ac"
                border.width: 2
            }
        }

        RowLayout {
            id: rowLayout
            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: 2
                rightMargin: 6
            }
            spacing: 6

            ClippingWrapperRectangle {
                Layout.preferredWidth: root.pillHeight - root.imageMargin * 2
                Layout.preferredHeight: root.pillHeight - root.imageMargin * 2
                Layout.alignment: Qt.AlignVCenter
                radius: root.imageRadius
                color: "transparent"

                Image {
                    anchors.fill: parent
                    source: PlayerCtlService.artUrl
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    asynchronous: true
                    cache: true
                }
            }

            Text {
                id: textLabel
                Layout.fillWidth: true
                text: PlayerCtlService.artist + " - " + PlayerCtlService.title
                color: root.widgetTextColor
                elide: Text.ElideRight
            }
        }
    }
}
