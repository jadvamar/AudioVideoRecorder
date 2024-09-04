#ifndef FOLDERS_H
#define FOLDERS_H
#include <QFile>
#include <QDebug>
#include <QObject>
#include <QDir>


class Folders : public QObject
{
    Q_OBJECT
private:
    int videoCounter=1;
    int audioCounter=1;
    QString outputLocation;
    QString path = "C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Storage/";
public:
    Folders();
    Folders(QString l): outputLocation(l){
        QDir().mkpath(outputLocation);
    }
    Q_INVOKABLE bool deleteFile(const QString &filePath) {
        QFile file(path + filePath);
        if (file.remove()) {
            qDebug() << "File deleted successfully:" << filePath;
            return true;
        } else {
            qDebug() << "Failed to delete file:" << filePath;
            return false;
        }
    }

    Q_INVOKABLE QString getNextFileName(bool isVideo) {
        QDir().mkpath(outputLocation);

        QString prefix = isVideo ? "Rec_Video_" : "Rec_Audio_";
        int& counter = isVideo ? videoCounter : audioCounter;

        QString fileName;
        do {
            fileName = QString("%1/%2%3.%4").arg(outputLocation, prefix)
            .arg(counter, 3, 10, QChar('0'))
                .arg(isVideo ? "mp4" : "wav");
            counter++;
        } while (QFile::exists(fileName));

        return fileName;
    }
    Q_INVOKABLE void startRecording() {
        QString videoFileName = getNextFileName(true);
        QString audioFileName = getNextFileName(false);

        qDebug() << "Video will be saved as:" << videoFileName;
        qDebug() << "Audio will be saved as:" << audioFileName;
    }
};

#endif
