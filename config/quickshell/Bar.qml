import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope {
    id: root
    property string time
    property int mainBarHeight: 35
    property int borderBarHeight: 20
    property string barColor: "#aa0d1117"
    property string textColor: "#e8f4f0"

    Variants {
        model: Quickshell.screens
    
        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            implicitHeight: mainBarHeight

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                color: barColor
            }

            RowLayout {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    Layout.fillWidth: true
                    height: parent.height
                    color: "transparent"

                    Rectangle {
                        Layout.fillWidth: true
                        height: parent.height
                        color: "transparent"
                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            SpotifyWidget {
                                visible: PlayerCtlService.title != ""
                                widgetTextColor: textColor
                            }
                        }
                    }

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 8

                        ClockWidget { widgetTextColor: textColor }
                    }
                }
            }
        }
    }

    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            implicitHeight: borderBarHeight
            exclusiveZone: 0
            mask: Region { }

            anchors {
                top:true
                left: true
                right: true
            }

            Canvas {
                id: mycanvas
                anchors.fill: parent

                property int r: borderBarHeight
                property int lCOX: 0
                property int lCOY: 0
                property int rCOX: width
                property int rCOY: 0

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = barColor
                    
                    ctx.beginPath()
                    // Left inverted corner
                    ctx.moveTo(lCOX, lCOY + r)
                    ctx.arc(lCOX + r, lCOY + r, r, Math.PI, -Math.PI / 2, false)
                    ctx.lineTo(lCOX, lCOY)
                    ctx.closePath()
                    // Right inverted corner
                    ctx.moveTo(rCOX, rCOY + r)
                    ctx.arc(rCOX - r, rCOY + r, r, 0, -Math.PI / 2, true)
                    ctx.lineTo(rCOX, rCOY)
                    ctx.closePath()

                    ctx.fill()
                }
            }
        }
    }
  }
