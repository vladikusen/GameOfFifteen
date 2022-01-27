import QtQuick 2.0
import GameBoard 1.0

GridView{
    id: root

    interactive: false
    property int draggedItemIndex: -1

    Item {
        id: dndContainer
        anchors.fill: root
    }

    model: GameBoardModel {
        id: dndModel
    }

    cellHeight: height / model.boardSize
    cellWidth: width / model.boardSize


    delegate: Item {
        id: tileBackground

        width: root.cellWidth
        height: root.cellHeight


        Tile {
            id: tile
            outerTileText.text: text
            visible: text !== dndModel.boardSize ** 2
            anchors.fill: tileBackground
            anchors.margins: 4


        }

    }


    function winMessage(){
        if(dndModel.checkCells() === true){
            messagePopup.open()
        }
    }


    move: Transition {
        NumberAnimation { properties: "x, y"; duration: 300 }
    }

    MouseArea {
        id: coords
        anchors.fill: root

        onClicked: {
            dndModel.move(root.indexAt(mouseX, mouseY), dndModel.findBlankTile())

            winMessage()
        }
    }
}
