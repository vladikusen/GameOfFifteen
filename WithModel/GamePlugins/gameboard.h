#ifndef GAMEBOARD_H
#define GAMEBOARD_H
#include <QAbstractListModel>
#include <vector>
#include <random>

class GameBoard : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int boardSize READ boardSize CONSTANT)
public:
    GameBoard(const int boardSize = 4 , QObject* parent = nullptr);

    enum {
        TextRole = Qt::UserRole
    };

    int rowCount(const QModelIndex& parent = QModelIndex{}) const override;

    QVariant data(const QModelIndex& index, int role = TextRole) const override;

    size_t boardSize() const;

    Q_INVOKABLE void move(int sourceIndex, int destinationIndex);
    Q_INVOKABLE bool checkCells();
    Q_INVOKABLE void mixCells();
    Q_INVOKABLE int findBlankTile();

    virtual QHash<int, QByteArray> roleNames() const override;
private:
    std::vector<int> m_tileBoard;
    const int m_boardSize;

    void shuffle();
    bool ifSolvable();
    bool isIndexValid(int index);
};


#endif // GAMEBOARD_H
