#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "AM_MonitorApp/AM_MonitorApp.h"

int main(int argc, char *argv[])
{
    int exitCode = 0;
    // may be needed to be an option in regular screens
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    AM_MonitorApp app(argc, argv);

    QQmlApplicationEngine engine;

    // feed qml resources to the engine
    engine.addImportPath("qrc:/qml");

    // init app
    app._initCommon();
    
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);

    exitCode = app.exec();

    app._shutdown();

    return exitCode;
}
