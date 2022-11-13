#include "utils.h"
#include <QString>
#include <QDebug>
#include <iostream>

#if defined(Q_OS_ANDROID)
#include <android/log.h>
#endif

static QString DESTRUCTOR_MSG = QStringLiteral("Running the %1 destructor.");

void Utils::DestructorMsg(const QString value)
{
    qDebug() << DESTRUCTOR_MSG.arg(value);
}

void Utils::DestructorMsg(const QObject *const object)
{
    DestructorMsg(object->metaObject()->className());
}

void Utils::messageOutputHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray  localMsg = msg.toLocal8Bit();
    const char *file     = context.file ? context.file : "";
    const char *function = context.function ? context.function : "";
    QString     filetype = QString(file).contains(".qml") ? "QML" : "Qt";

#if defined(Q_OS_ANDROID)
    android_LogPriority priority = ANDROID_LOG_DEBUG;

    auto logTag = filetype.toLocal8Bit();
    auto formatMsg =
            QString("%0 (%1: %2,%3)").arg(localMsg.constData()).arg(file).arg(context.line).arg(function);
    switch (type) {
    case QtDebugMsg:
        priority = ANDROID_LOG_DEBUG;
        logTag   = logTag + "-DEBUG";
        break;
    case QtInfoMsg:
        priority = ANDROID_LOG_INFO;
        logTag   = logTag + "-INFO";
        break;
    case QtWarningMsg:
        priority = ANDROID_LOG_WARN;
        logTag   = logTag + "-WARNING";
        break;
    case QtCriticalMsg:
        priority = ANDROID_LOG_ERROR;
        logTag   = logTag + "-ERROR";
        break;
    case QtFatalMsg:
        priority = ANDROID_LOG_FATAL;
        logTag   = logTag + "-FATAL";
        break;
    }
    __android_log_print(priority, logTag, "%s", qPrintable(formatMsg));
#else
    QString formatMsg = QString(" (%0: %1, %2)").arg(file).arg(context.line).arg(function);
    switch (type) {
    case QtDebugMsg:
        LOG_PRINT(std::cout, COLOR_DEBUG, "DEBUG", localMsg.constData(), formatMsg.toStdString());
        break;
    case QtInfoMsg:
        LOG_PRINT(std::cout, COLOR_INFO, "INFO", localMsg.constData(), formatMsg.toStdString());
        break;
    case QtWarningMsg:
        LOG_PRINT(std::cout, COLOR_WARN, "WARNING", localMsg.constData(), formatMsg.toStdString());
        break;
    case QtCriticalMsg:
        LOG_PRINT(std::cout, COLOR_CRITICAL, "ERROR", localMsg.constData(), formatMsg.toStdString());
        break;
    case QtFatalMsg:
        LOG_PRINT(std::cout, COLOR_FATAL, "FATAL", localMsg.constData(), formatMsg.toStdString());
        break;
    }
#endif
}
