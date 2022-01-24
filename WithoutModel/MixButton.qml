import QtQuick 2.0

Rectangle {
    id: root
    color: "#F6B35A"
    border.color: "brown"
    radius: 20
    border.width: 2
    Text {
        anchors.centerIn: root
        text: "Mix"
        color: "brown"
        font.pointSize: Math.max(root.width, root.height) / 5
    }

    MouseArea {
        anchors.fill: parent
        onClicked : {
            gameBoard.model.clearModel();
            gameBoard.model.createModel(gameBoard.model.createArr());

            gameBoardWrapper.opacity = 1
            winMess.visible = false
        }
    }
}
