#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.engine()->addImportPath(QLatin1String("../"));

    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
