#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include<QQmlContext>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QString filePath = "C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Storage/";
    QDir dir(filePath);


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("filePath", QUrl::fromLocalFile(filePath));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AudioVideoRecorder", "Main");

    return app.exec();
}
