#ifndef GAMEPLUGINS_PLUGIN_H
#define GAMEPLUGINS_PLUGIN_H

#include <QQmlExtensionPlugin>

class GamePluginsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // GAMEPLUGINS_PLUGIN_H
