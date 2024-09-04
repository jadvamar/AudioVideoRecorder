#ifndef AUDIOO_H
#define AUDIOO_H

#include <QObject>
#include <portaudio.h>
class Audioo: public QObject
{
    Q_OBJECT
public:
    Audioo();
    explicit Audioo(QObject *parent = nullptr){
        Pa_Initialize();
    }
    Q_INVOKABLE void startAudioCapture(){
        PaStream *stream;
        Pa_OpenDefaultStream(&stream, 1, 0, paFloat32, 44100, 256, audioCallback, nullptr);
        Pa_StartStream(stream);
    }
    Q_INVOKABLE void stopAudioCapture(){
        Pa_Terminate();
    }
private:
    Q_INVOKABLE static int audioCallback(const void *input, void *output,
                             unsigned long frameCount,
                             const PaStreamCallbackTimeInfo *timeInfo,
                             PaStreamCallbackFlags statusFlags,
                             void *userData)
    {
        return paContinue;
    }

    PaStream *stream = nullptr;
};

#endif // AUDIOO_H
