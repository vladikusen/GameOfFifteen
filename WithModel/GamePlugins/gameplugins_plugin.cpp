#include "gameplugins_plugin.h"

#include "gameboard.h"

#include <qqml.h>

void GamePluginsPlugin::registerTypes(const char *uri)
{
    // @uri GameBoard
    qmlRegisterType<GameBoard>(uri, 1, 0, "GameBoardModel");
}

