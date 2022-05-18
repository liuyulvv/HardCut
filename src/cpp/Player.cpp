#include "Player.h"
#include <QString>

Player::Player(QObject *parent) : QObject{parent}, player(new QMediaPlayer(this))
{
}
