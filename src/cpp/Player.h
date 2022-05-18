#pragma once

#include <QAudioOutput>
#include <QMediaPlayer>
#include <QObject>
#include <QUrl>
#include <QtMultimedia>

class Player : public QObject
{
    Q_OBJECT
  public:
    explicit Player(QObject *parent = nullptr);
    ~Player()
    {
        player->stop();
        delete player;
        player = nullptr;
    }

  private:
    QMediaPlayer *player = nullptr;

  public slots:
    void play()
    {
        player->play();
    }
    void pause()
    {
        player->pause();
    }
    void setSource(QUrl url)
    {
        player->setSource(url);
    }
    void setVideo(QObject *obj)
    {
        player->setVideoOutput(obj);
    }
    void setAudio(QAudioOutput *obj)
    {
        player->setAudioOutput(obj);
    }

  signals:
};
