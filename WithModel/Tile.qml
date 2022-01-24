import QtQuick 2.0

Rectangle {
    id: root
    color: "#F6B35A"

    border.color : "brown"
    border.width: 2
    radius: 8
    property alias outerTileText: innerText

    Text {
        id: innerText
        anchors.centerIn: root
        text: ""
        font.bold: true
        font.pointSize: Math.min(root.width, root.height) / 4
    }
}
