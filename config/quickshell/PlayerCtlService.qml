pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string title
    property string artist
    property string album
    property string artUrl
    property int lengthSeconds
    property string length
    property string lengthFormatted
    property int positionSeconds
    property int position
    property string positionFormatted
    property double completionFraction

    Process {
        id: dataProcess 
        command: ["bash", "-c", "playerctl --player=spotify metadata --format $'{{xesam:title}}\\n{{xesam:artist}}\\n{{xesam:album}}\\n{{mpris:artUrl}}\\n{{mpris:length}}' && playerctl --player=spotify position"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var fields = this.text.split("\n")
                root.title = fields[0] ?? ""
                root.artist = fields[1] ?? ""
                root.album = fields[2] ?? ""
                root.artUrl = fields[3] ?? ""
                root.length= fields[4]  ?? "1"
                root.position= fields[5] ?? "1"

                root.lengthSeconds = parseInt(root.length) / 1000000
                root.positionSeconds = parseInt(root.position)

                var lengthM = root.lengthSeconds / 60
                var lengthS = root.lengthSeconds % 60
                root.lengthFormatted = Math.floor(lengthM) + ":" + Math.floor(lengthS)

                var positionM = root.positionSeconds / 60
                var positionS = root.positionSeconds % 60
                root.positionFormatted = Math.floor(positionM) + ":" + Math.floor(positionS)

                completionFraction = positionSeconds / lengthSeconds
            }
        }
    }
    // Process {
    //     id: dataProcess 
    //     command: ["playerctl", "--player=spotify", "metadata", "--format",
    //               "{{title}}|{{artist}}|{{album}}|{{mpris:artUrl}}"]
    //     running: true
    //
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             var parts = this.text.trim().split("|")
    //             var lengthM
    //             root.title   = parts[0] ?? ""
    //             root.artist  = parts[1] ?? ""
    //             root.album   = parts[2] ?? ""
    //             root.artUrl  = parts[3] ?? ""
    //         }
    //     }
    // }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dataProcess.running = true
    }
}
