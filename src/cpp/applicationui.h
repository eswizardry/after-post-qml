#pragma once

#include <QObject>
#include "helper/PropertyHelper.h"

class QQmlApplicationEngine;
class QQmlContext;
class QTimer;
class SettingsData;
class UnsafeArea;

/**
 * @brief The StartUp class
 *
 * @startuml
 * title A program entry point
 * actor myActor
 * database myDb
 * activate myActor
 * myActor ->> myDb: async request
 * activate myDb
 * myActor //-- myDb: response
 * destroy myDb
 * deactivate myActor
 * @enduml
 *
 */
class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    explicit ApplicationUI(QObject *parent = nullptr, QQmlApplicationEngine *engine = nullptr);
    ~ApplicationUI();

    Q_INVOKABLE
    QStringList swapThemePalette();

    Q_INVOKABLE
    QStringList defaultThemePalette();

    Q_INVOKABLE
    QStringList primaryPalette(const int paletteIndex);

    Q_INVOKABLE
    QStringList accentPalette(const int paletteIndex);

    Q_INVOKABLE
    QStringList defaultPrimaryPalette();

    Q_INVOKABLE
    QStringList defaultAccentPalette();

    /// Expose C++ class to Qml
    void addContextProperty(QQmlContext* context);
    /// Register the C++ types so that they are usable from QML side.
    void registerQmlTypes();
    /// Tesing Qml object
    bool testQmlObject(const QObject *const &ptr);

public slots:
    void onAboutToQuit();
    void onApplicationStateChanged(Qt::ApplicationState applicationState);

private slots:
    void onConnectToDevice();
    void onTimerFired();

private:
    QQmlApplicationEngine *m_engine;
    SettingsData* m_settingsData;
    UnsafeArea* m_unsafeArea;
    QTimer *m_timer;

    int     m_bootDelay;
    int     m_bootDelayCounter;


    void setupBootDelayTimer();

    explicit ApplicationUI(const ApplicationUI &rhs) = delete;
    ApplicationUI &operator=(const ApplicationUI &rhs) = delete;
};
