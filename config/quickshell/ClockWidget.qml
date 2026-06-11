import QtQuick
import QtQuick.Layouts

Text {
    required property string widgetTextColor

    color: widgetTextColor
    text: Time.time.trim()
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 14
    font.weight: Font.Bold
}
