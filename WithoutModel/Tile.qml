import QtQuick 2.0

Rectangle {
    id: root
    color: "#F6B35A"
    property string innerText: ""

    border.color : "brown"
    border.width: 2
    radius: 8
    Text {
        id: tileText
        anchors.centerIn: root
        text: root.innerText
        font.bold: true
        font.pointSize: Math.min(root.width, root.height) / 4
    }
}
