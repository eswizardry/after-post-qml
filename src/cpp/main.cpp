#include <QGuiApplication>
#include <QFont>
#include <QFontDatabase>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QQuickStyle>
#include <QQuickWindow>
#include <QSslSocket>
#include <QtDebug>
#include <QtGlobal>
#include <QString>

#include "fileio.h"
#include "helper/utils.h"
#include "helper/apptranslator.h"
#include "platform.h"
#include "applicationui.h"
#include "customnetworkmanagerfactory.h"

#if defined(Q_OS_ANDROID)
#include "../soup/QtAndroidTools/QtAndroidTools/QtAndroidTools.h"
#endif

#include "spdlog/spdlog.h"
#include "spdlog/sinks/basic_file_sink.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qInstallMessageHandler(Utils::messageOutputHandler);

    QGuiApplication app(argc, argv);
    QFontDatabase::addApplicationFont(":/fonts/Roboto-Light.ttf");
    app.setFont(QFont("Roboto Light", 12));

    app.setApplicationName(APP_NAME);
    app.setOrganizationName(ORGANIZATION_NAME);
    app.setOrganizationDomain(ORGANIZATION_DOMAIN);

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    Platform              platform(&engine);
    FileIO                fileio;
    ApplicationUI         appUi;
    AppTranslator         appTranslator(&engine);

#if defined(Q_OS_ANDROID)
    QtAndroidTools::InitializeQmlTools();
#endif

    // Bypassing SSL certificate warnings which are caused due to the missing SSL certificate.
    // This can be done by providing our own custom QNetworkAccessManager
    // to the QQmlApplicationEngine which ignores the ssl errors.
    // More info [1] https://gargidas.blogspot.com/2012/01/how-to-ignore-ssl-error-to-get-https.html
    // [2] https://talk.maemo.org/showthread.php?t=70074
    CustomNetworkManagerFactory *myNetworkAccessManagerFactory = new CustomNetworkManagerFactory(&app);
    engine.setNetworkAccessManagerFactory(myNetworkAccessManagerFactory);

    // Expose C++ classes to QML
    auto context = engine.rootContext();
    context->setContextProperty("__appUi", &appUi);
    context->setContextProperty("__fileio", &fileio);
    context->setContextProperty("__platform", &platform);
    context->setContextProperty("__appTranslator", &appTranslator);

    appUi.addContextProperty(context);

    // clang-format off
    // lifecycle management
    QObject::connect(&app, SIGNAL(aboutToQuit()), &appUi, SLOT(onAboutToQuit()));
    QObject::connect(&app, SIGNAL(applicationStateChanged(Qt::ApplicationState)),
                     &appUi, SLOT(onApplicationStateChanged(Qt::ApplicationState)));
    // clang-format on

    // load main file
    platform.loadQml();

    auto rootObj   = engine.rootObjects().first();
    auto qmlWindow = qobject_cast<QQuickWindow *>(rootObj);
    auto isValid   = false;
    if (qmlWindow->objectName() == "appWindow") {
        qDebug("A p p l i c a t i o n   W i n d o w is successful created.");
        isValid = appUi.testQmlObject(qmlWindow->findChild<QQuickItem *>("mainScreen"));
    }

    if (isValid) {
#ifdef QT_DEBUG
        engine.rootObjects().first()->setProperty("_DEBUG_MODE", true);
        engine.rootObjects().first()->setProperty("_APP_VERSION", APP_VERSION);

        QString compileSSL = QSslSocket::sslLibraryBuildVersionString();
        QString runSSL     = QSslSocket::sslLibraryVersionString();
#else
        engine.rootObjects().first()->setProperty("_DEBUG_MODE", false);
#endif

#if defined(Q_OS_ANDROID)
        QtAndroid::hideSplashScreen();
#endif

        return app.exec();
    }

    return -1;
}
