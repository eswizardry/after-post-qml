#pragma once

#include <QObject>
#include <qvariant.h>
#include <QDateTime>
#include "helper/PropertyHelper.h"

class SettingsData : public QObject
{
    Q_OBJECT

    AUTO_PROPERTY(int, id)
    AUTO_PROPERTY(int, version)
    AUTO_PROPERTY(QString, apiVersion)
    AUTO_PROPERTY(QDateTime, lastUpdate)
    AUTO_PROPERTY(bool, isProductionEnvironment)
    AUTO_PROPERTY(int, primaryColor)
    AUTO_PROPERTY(int, accentColor)
    AUTO_PROPERTY(bool, darkTheme)
    AUTO_PROPERTY(bool, useMarkerColors)
    AUTO_PROPERTY(bool, defaultMarkerColors)
    AUTO_PROPERTY(QString, markerColors)
    AUTO_PROPERTY(bool, hasPublicCache)
    AUTO_PROPERTY(bool, useCompactJsonFormat)
    AUTO_PROPERTY(int, lastUsedNumber)
    AUTO_PROPERTY(QString, publicRoot4Dev)
    AUTO_PROPERTY(bool, autoUpdate)
    AUTO_PROPERTY(int, autoUpdateEveryHours)
    AUTO_PROPERTY(QDateTime, lastUpdateStamp)
    AUTO_PROPERTY(int, navigationStyle)
    AUTO_PROPERTY(bool, oneMenuButton)
    AUTO_PROPERTY(bool, classicStackNavigation)
public:
    explicit SettingsData(QObject *parent = nullptr);
    virtual ~SettingsData();

    void fillFromMap(const QVariantMap& settingsDataMap);
    void fillFromForeignMap(const QVariantMap& settingsDataMap);
    void fillFromCacheMap(const QVariantMap& settingsDataMap);

    void prepareNew();

    bool isValid();

    Q_INVOKABLE
    QVariantMap toMap();
    QVariantMap toForeignMap();
    QVariantMap toCacheMap();

signals:

private:
    explicit SettingsData(const SettingsData &rhs) = delete;
    SettingsData &operator=(const SettingsData &rhs) = delete;
};
Q_DECLARE_METATYPE(SettingsData*)
