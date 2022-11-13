#include "applicationui.h"
#include "uiconstants.h"
#include "settingsdata.h"
#include "unsafearea.h"

#include <QDebug>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQuickItem>
#include <QStringListModel>
#include <QTimer>

#include "helper/apptranslator.h"
#include "helper/provider.h"
#include "helper/utils.h"
#include "../soup/statusbar/src/statusbar.h"

using namespace ekke::constants;
const int TIMER_INTERVAL = 250;

ApplicationUI::ApplicationUI(QObject *parent, QQmlApplicationEngine *engine)
    : QObject(parent),
      m_engine(engine),
      m_settingsData(new SettingsData(this)),
      m_unsafeArea(new UnsafeArea(this)),
      m_timer(new QTimer(this))
{
    m_settingsData->primaryColor(8);
    m_settingsData->accentColor(13);
    registerQmlTypes();
}

ApplicationUI::~ApplicationUI()
{
    Utils::DestructorMsg(this);
}

void ApplicationUI::addContextProperty(QQmlContext *context)
{
    context->setContextProperty("__unsafeArea", m_unsafeArea);
}

void ApplicationUI::registerQmlTypes()
{
    qmlRegisterType<StatusBar>("StatusBar", 0, 1, "StatusBar");
}

bool ApplicationUI::testQmlObject(const QObject *const &ptr)
{
    auto isValid = false;
    if (ptr == nullptr) {
        qDebug() << QString("Can't find the Qml Item with objectname: %1.");
        isValid = false;
    } else {
        qDebug() << QString("M a i n   S c r e e n   Q m l  is successful created.");
        isValid = true;
    }

    return isValid;
}

QStringList ApplicationUI::swapThemePalette()
{
    m_settingsData->darkTheme(!m_settingsData->darkTheme());
    if (m_settingsData->darkTheme()) {
        return darkPalette;
    }
    return lightPalette;
}

QStringList ApplicationUI::defaultThemePalette()
{
    if (m_settingsData->darkTheme()) {
        return darkPalette;
    }
    return lightPalette;
}

QStringList ApplicationUI::primaryPalette(const int paletteIndex)
{
    m_settingsData->primaryColor(paletteIndex);
    switch (paletteIndex) {
    case 0:
        return materialRed;
    case 1:
        return materialPink;
    case 2:
        return materialPurple;
    case 3:
        return materialDeepPurple;
    case 4:
        return materialIndigo;
    case 5:
        return materialBlue;
    case 6:
        return materialLightBlue;
    case 7:
        return materialCyan;
    case 8:
        return materialTeal;
    case 9:
        return materialGreen;
    case 10:
        return materialLightGreen;
    case 11:
        return materialLime;
    case 12:
        return materialYellow;
    case 13:
        return materialAmber;
    case 14:
        return materialOrange;
    case 15:
        return materialDeepOrange;
    case 16:
        return materialBrown;
    case 17:
        return materialGrey;
    default:
        return materialBlueGrey;
    }
}

QStringList ApplicationUI::accentPalette(const int paletteIndex)
{
    m_settingsData->accentColor(paletteIndex);
    int         currentPrimary = m_settingsData->primaryColor();
    QStringList thePalette     = primaryPalette(paletteIndex);
    m_settingsData->primaryColor(currentPrimary);
    // we need: primaryColor, textOnPrimary, iconOnPrimaryFolder
    return QStringList { thePalette.at(1), thePalette.at(4), thePalette.at(7) };
}

QStringList ApplicationUI::defaultPrimaryPalette()
{
    return primaryPalette(m_settingsData->primaryColor());
}

QStringList ApplicationUI::defaultAccentPalette()
{
    return accentPalette(m_settingsData->accentColor());
}

// ATTENTION
// iOS: NO SIGNAL
// Android: SIGNAL if leaving the App with Android BACK Key
// Android: NO SIGNAL if using HOME or OVERVIEW and THEN CLOSE from there
void ApplicationUI::onAboutToQuit()
{
    qDebug() << "On About to Q U I T Signal received";
    //    startCaching();
}

void ApplicationUI::onApplicationStateChanged(Qt::ApplicationState applicationState)
{
    qDebug() << "S T A T E changed into: " << applicationState;
    if (applicationState == Qt::ApplicationState::ApplicationSuspended) {
        //        startCaching();
        return;
    }
    if (applicationState == Qt::ApplicationState::ApplicationActive) {
        //        resetCaching();
    }
}

void ApplicationUI::onConnectToDevice()
{
    // Attemps to connect to device if network connected
    setupBootDelayTimer();
}

void ApplicationUI::setupBootDelayTimer()
{
    //    if (m_systemSettings.deviceCommType() == enums::WIFI_COMM) {
    //        m_bootDelay = 5000;//m_settings.getBootDelay();
    //    } else {
    //        m_bootDelay = 500;//m_settings.getBootDelay();
    //    }

    m_bootDelayCounter = 0;
    m_timer->setInterval(TIMER_INTERVAL);
    connect(m_timer, SIGNAL(timeout()), SLOT(onTimerFired()));
    m_timer->start();
}

void ApplicationUI::onTimerFired()
{
    //    ++m_bootDelayCounter;
    //    float elapsed_time = TIMER_INTERVAL * m_bootDelayCounter;
    //    float progress = (elapsed_time / static_cast<float>(m_bootDelay)) * static_cast<float>(100.0);
    //    m_viewMgr.feedbackProgress(static_cast<int>(progress));

    //    if (progress > 100) {
    //        m_commDeviceMgr.connectToDevice();
    //        m_timer.stop();
    //    }
}
