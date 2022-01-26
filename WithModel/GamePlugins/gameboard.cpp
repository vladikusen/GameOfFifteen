#include "gameboard.h"
#include <random>


GameBoard::GameBoard(const int boardSize, QObject *parent)
    : QAbstractListModel{ parent }, m_boardSize{ boardSize }
{
    m_tileBoard.resize(m_boardSize * boardSize);

    for(int i = 0; i < m_boardSize * m_boardSize; i++){
        m_tileBoard[i] = i + 1;
    }

    shuffle();
    while(!ifSolvable()){
        shuffle();
    }
}

int GameBoard::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);

    return m_tileBoard.size();
}

QVariant GameBoard::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || role != TextRole){
        return QVariant{};
    }


    return QVariant::fromValue(m_tileBoard[index.row()]);
}

size_t GameBoard::boardSize() const
{
    return m_boardSize;
}

void GameBoard::move(int sourceIndex, int destinationIndex)
{

    if(sourceIndex + 1 == destinationIndex){

        int buffer = m_tileBoard[sourceIndex];
        m_tileBoard[sourceIndex] = m_tileBoard[destinationIndex];
        m_tileBoard[destinationIndex]= buffer;

        emit rowsMoved(QModelIndex(), sourceIndex, sourceIndex, QModelIndex(), destinationIndex + 1, {});
    }
    if(sourceIndex - 1 == destinationIndex){

        int buffer = m_tileBoard[sourceIndex];
        m_tileBoard[sourceIndex] = m_tileBoard[destinationIndex];
        m_tileBoard[destinationIndex]= buffer;

        emit rowsMoved(QModelIndex(), sourceIndex, sourceIndex, QModelIndex(), destinationIndex + 1, {});
    }
    if(sourceIndex + m_boardSize == destinationIndex){

        int buffer = m_tileBoard[sourceIndex];
        m_tileBoard[sourceIndex] = m_tileBoard[destinationIndex];
        m_tileBoard[destinationIndex]= buffer;

        emit rowsMoved(QModelIndex(), sourceIndex, sourceIndex, QModelIndex(), destinationIndex + 1, {});
        emit rowsMoved(QModelIndex(), destinationIndex - 1, destinationIndex - 1, QModelIndex(), sourceIndex, {});
    }
    if(sourceIndex - m_boardSize == destinationIndex){

        int buffer = m_tileBoard[sourceIndex];
        m_tileBoard[sourceIndex] = m_tileBoard[destinationIndex];
        m_tileBoard[destinationIndex]= buffer;

        emit rowsMoved(QModelIndex(), sourceIndex, sourceIndex, QModelIndex(), destinationIndex, {});
        emit rowsMoved(QModelIndex(), destinationIndex + 1, destinationIndex + 1, QModelIndex(), sourceIndex + 1, {});
    }

}

bool GameBoard::checkCells()
{
    for(int i = 0; i < m_boardSize * m_boardSize; i++){
        if(i + 1 != m_tileBoard[i]){
            return false;
        }
    }


    return true;
}

void GameBoard::mixCells()
{
    shuffle();
    while(!ifSolvable()){
        shuffle();
    }


    emit dataChanged(createIndex(0, 0), createIndex(m_boardSize * m_boardSize, 0));

}

int GameBoard::findBlankTile()
{
    for(int i = 0; i < m_tileBoard.size(); i++){
        if(m_tileBoard.at(i) == m_boardSize * m_boardSize){
            return i;
        }
    }

    return -1;

}



QHash<int, QByteArray> GameBoard::roleNames() const
{
    QHash<int, QByteArray> names;
    names[TextRole] = "text";

    return names;
}

void GameBoard::shuffle()
{
    static auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    static std::mt19937 generator(seed);

    std::shuffle(m_tileBoard.begin(), m_tileBoard.end(), generator);
}

bool GameBoard::ifSolvable()
{
    size_t sumLowerElements = 0;
    size_t positionOfKeyTile = -1;

    for(int i = 0; i < m_boardSize * m_boardSize; i++){
        if(m_tileBoard[i] == m_boardSize * m_boardSize){
            positionOfKeyTile = floor(i / m_boardSize) + 1;
        }
        else{
            for(int j = i + 1; j < m_boardSize * m_boardSize; j++){
                if(m_tileBoard[j] < m_tileBoard[i] && m_tileBoard[j]!= m_boardSize * m_boardSize){
                    sumLowerElements++;
                }
            }
        }
    }

    if((sumLowerElements + positionOfKeyTile) % 2 != 0){
        return false;
    }
    return true;

}

bool GameBoard::isIndexValid(int index)
{
    return (index < m_boardSize * m_boardSize && index >= 0);
}
