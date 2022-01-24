import QtQuick 2.15
import QtQuick.Controls 2.5

GridView
{
    id: root
    interactive: false

    Item {
        id: dndContainer
        anchors.fill: root
    }

    model: TilesModel{
        id: dndModel
    }

    cellHeight: height / dndModel.boardSize
    cellWidth: width / dndModel.boardSize

    delegate: Item{
        id: tileBackground

        width: root.cellWidth
        height: root.cellHeight

        Tile{
                id: tile
                innerText: model.display
                visible: model.display !== dndModel.boardSize * dndModel.boardSize
                anchors.fill: tileBackground
                anchors.margins: 4
        }
    }

    function checkCells(){
        for(var i = 0; i < dndModel.boardSize ** 2; i++){
            if(i + 1 !== dndModel.getData(i)){
                return false
            }
        }
        return true
    }

    function winMessage(){
        if(checkCells() === true){
            messagePopup.open()
        }
    }

    function findBlankTile(currentIndex){

        var buffer
        if(currentIndex + dndModel.boardSize < dndModel.boardSize * dndModel.boardSize){
            buffer = dndModel.getData(currentIndex + dndModel.boardSize)
            if(buffer === dndModel.boardSize * dndModel.boardSize){
                return currentIndex + dndModel.boardSize
            }
        }
        if(currentIndex - dndModel.boardSize >= 0){
            buffer = dndModel.getData(currentIndex - dndModel.boardSize)
            if(buffer === dndModel.boardSize * dndModel.boardSize){
                return currentIndex - dndModel.boardSize
            }
        }
        if(currentIndex + 1 < dndModel.boardSize * dndModel.boardSize){
            buffer = dndModel.getData(currentIndex + 1)
            if(buffer === dndModel.boardSize * dndModel.boardSize && (currentIndex + 1) % dndModel.boardSize !== 0){
                return currentIndex + 1
            }
        }
        if(currentIndex - 1 >= 0){
            buffer = dndModel.getData(currentIndex - 1)
            if(buffer === dndModel.boardSize * dndModel.boardSize && currentIndex % dndModel.boardSize !== 0){
                return currentIndex - 1
            }
        }



        return currentIndex;
    }

    move: Transition {
        NumberAnimation { properties: "x, y"; duration: 300 }
    }

    MouseArea {
        id: coords
        anchors.fill: root

        onClicked: {
            var blankTile = findBlankTile(root.indexAt(mouseX, mouseY))
                  if(blankTile !== -1){
                      var currIndex = root.indexAt(mouseX, mouseY)
                      if(currIndex + 1 === blankTile || currIndex - 1 === blankTile){
                          dndModel.move(currIndex, blankTile, 1)
                      }
                      if(currIndex + dndModel.boardSize === blankTile){
                          dndModel.move(currIndex, blankTile, 1)
                          dndModel.move(blankTile - 1, currIndex, 1)
                      }
                      if(currIndex - dndModel.boardSize === blankTile){
                          dndModel.move(currIndex, blankTile, 1)
                          dndModel.move(blankTile + 1, currIndex, 1)
                      }
                  }

              winMessage()
        }
    }
}
