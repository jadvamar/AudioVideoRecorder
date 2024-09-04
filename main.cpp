#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include<QQmlContext>
#include "folders.h"
#include "audiorecorder.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QString filePath = "C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Storage/";
    QDir dir(filePath);

    Folders folderObj;
    AudioRecorder audioObj2;
    Folders obj2("C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Storage");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("filePath", QUrl::fromLocalFile(filePath));
    engine.rootContext()->setContextProperty("folderObj", &folderObj);
    engine.rootContext()->setContextProperty("folderObj2", &obj2);
    engine.rootContext()->setContextProperty("audioObj", &audioObj2);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AudioVideoRecorder", "Main");
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
