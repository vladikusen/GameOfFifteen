import QtQuick 2.0
import QtQuick.Controls 2.12

Popup {
    id: root
    padding: 0

    Rectangle {
        anchors.fill: parent
        color: "orange"
        border.width: 2
        border.color: "brown"
        Text {
         anchors.centerIn: parent
         text: "You won!"
         font.bold: true
         color: "brown"
         font.pointSize: Math.min(root.width, root.height) / 7
        }
    }

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
}
