import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


Window {

    id:root
    width: 600
    height: 600
    visible: true
    title: qsTr("Game of Fifteen")

    Rectangle {
        id: mainWrapper

        anchors.fill: parent

        color: "#E5B989"
        Rectangle {
            id: gameBoardWrapper

            color: "#FEECD8"
            border.width: 2
            border.color: "brown"

            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            width: parent.width - 20
            height: parent.height - 20 - mixButton.height

            GameBoard {
                id: gameBoard

                anchors.fill:parent
                anchors.margins: 5
            }
        }

        MixButton {
            id: mixButton

            width: height * 2
            height: parent.width / 8

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        WinMessage {
            id: messagePopup

            visible: false
            width: parent.width / 5
            height: width

            anchors.centerIn: parent
        }

    }


}
