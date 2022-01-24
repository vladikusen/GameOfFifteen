import QtQuick 2.0

ListModel
{
    id: tileModel

    property int boardSize: 3

    function shuffle(arr) {
      arr.sort(() => Math.random() - 0.5);
    }

    function ifSolvable(arr){
        var sum = 0
        var e = -1
        for(var i = 0; i < boardSize ** 2; i++){
            if(arr[i] === boardSize ** 2) {
                e = Math.floor(i / boardSize) + 1;
            }
            else
            {
                for(var j = i + 1; j < boardSize ** 2; j++){
                    if(arr[j] < arr[i] && arr[j] !== boardSize ** 2){
                        sum++;
                    }
                }
            }
        }
        if((e + sum) % 2 !== 0){
            return false;
        }
        return true;
    }

    function createModel(arr)
    {
        for(var i = 0; i < boardSize * boardSize; i++)
        {
            tileModel.append({ "display": arr[i] })
        }
    }

    function createArr(){
        var arr = []
        for(var i = 0; i < boardSize ** 2; i++)
        {
            arr[i] = i + 1;
        }


        shuffle(arr);
        while(!ifSolvable(arr)){
            shuffle(arr);
        }

        ifSolvable(arr)

        return arr;
    }

    function clearModel()
    {
        for(var i = tileModel.count; i >= 0; i--)
        {
            tileModel.remove(i);
        }
    }

    function getData(index)
    {
        return tileModel.get(index).display;
    }
    Component.onCompleted: { createModel(createArr()) }
}
