#include "settingsdata.h"
#include <QDebug>
#include <quuid.h>

// keys of QVariantMap used in this APP
static const QString idKey                      = "id";
static const QString versionKey                 = "version";
static const QString apiVersionKey              = "apiVersion";
static const QString lastUpdateKey              = "lastUpdate";
static const QString isProductionEnvironmentKey = "isProductionEnvironment";
static const QString primaryColorKey            = "primaryColor";
static const QString accentColorKey             = "accentColor";
static const QString darkThemeKey               = "darkTheme";
static const QString useMarkerColorsKey         = "useMarkerColors";
static const QString defaultMarkerColorsKey     = "defaultMarkerColors";
static const QString markerColorsKey            = "markerColors";
static const QString hasPublicCacheKey          = "hasPublicCache";
static const QString useCompactJsonFormatKey    = "useCompactJsonFormat";
static const QString lastUsedNumberKey          = "lastUsedNumber";
static const QString publicRoot4DevKey          = "publicRoot4Dev";
static const QString autoUpdateKey              = "autoUpdate";
static const QString autoUpdateEveryHoursKey    = "autoUpdateEveryHours";
static const QString lastUpdateStampKey         = "lastUpdateStamp";
static const QString navigationStyleKey         = "navigationStyle";
static const QString oneMenuButtonKey           = "oneMenuButton";
static const QString classicStackNavigationKey  = "classicStackNavigation";

// keys used from Server API etc
static const QString idForeignKey                      = "id";
static const QString versionForeignKey                 = "version";
static const QString apiVersionForeignKey              = "apiVersion";
static const QString lastUpdateForeignKey              = "lastUpdate";
static const QString isProductionEnvironmentForeignKey = "isProductionEnvironment";
static const QString primaryColorForeignKey            = "primaryColor";
static const QString accentColorForeignKey             = "accentColor";
static const QString darkThemeForeignKey               = "darkTheme";
static const QString useMarkerColorsForeignKey         = "useMarkerColors";
static const QString defaultMarkerColorsForeignKey     = "defaultMarkerColors";
static const QString markerColorsForeignKey            = "markerColors";
static const QString hasPublicCacheForeignKey          = "hasPublicCache";
static const QString useCompactJsonFormatForeignKey    = "useCompactJsonFormat";
static const QString lastUsedNumberForeignKey          = "lastUsedNumber";
static const QString publicRoot4DevForeignKey          = "publicRoot4Dev";
static const QString autoUpdateForeignKey              = "autoUpdate";
static const QString autoUpdateEveryHoursForeignKey    = "autoUpdateEveryHours";
static const QString lastUpdateStampForeignKey         = "lastUpdateStamp";
static const QString navigationStyleForeignKey         = "navigationStyle";
static const QString oneMenuButtonForeignKey           = "oneMenuButton";
static const QString classicStackNavigationForeignKey  = "classicStackNavigation";

SettingsData::SettingsData(QObject *parent) : QObject(parent)
{
    // Date, Time or Timestamp ? construct null value
    lastUpdate(QDateTime());
    lastUpdateStamp(QDateTime());

    id(-1);
    version(0);
    apiVersion("");
    isProductionEnvironment(false);
    primaryColor(0);
    accentColor(0);
    darkTheme(true);
    useMarkerColors(false);
    defaultMarkerColors(false);
    markerColors("");
    hasPublicCache(false);
    useCompactJsonFormat(false);
    lastUsedNumber(0);
    publicRoot4Dev("");
    autoUpdate(false);
    autoUpdateEveryHours(0);
    navigationStyle(0);
    oneMenuButton(false);
    classicStackNavigation(false);
}

SettingsData::~SettingsData() {}

/*
 * initialize SettingsData from QVariantMap
 * Map got from JsonDataAccess or so
 * includes also transient values
 * uses own property names
 * corresponding export method: toMap()
 */
void SettingsData::fillFromMap(const QVariantMap &settingsDataMap)
{
    //    mId = settingsDataMap.value(idKey).toInt();
    //    mVersion = settingsDataMap.value(versionKey).toInt();
    //    mApiVersion = settingsDataMap.value(apiVersionKey).toString();
    //    if (settingsDataMap.contains(lastUpdateKey)) {
    //        // always getting the Date as a String (from server or JSON)
    //        QString lastUpdateAsString = settingsDataMap.value(lastUpdateKey).toString();
    //        mLastUpdate = QDateTime::fromString(lastUpdateAsString, Qt::ISODate);
    //        if (!mLastUpdate.isValid()) {
    //            mLastUpdate = QDateTime();
    //            qDebug() << "mLastUpdate is not valid for String: " << lastUpdateAsString;
    //        }
    //    }
    //    mIsProductionEnvironment = settingsDataMap.value(isProductionEnvironmentKey).toBool();
    //    mPrimaryColor = settingsDataMap.value(primaryColorKey).toInt();
    //    mAccentColor = settingsDataMap.value(accentColorKey).toInt();
    //    mDarkTheme = settingsDataMap.value(darkThemeKey).toBool();
    //    mUseMarkerColors = settingsDataMap.value(useMarkerColorsKey).toBool();
    //    mDefaultMarkerColors = settingsDataMap.value(defaultMarkerColorsKey).toBool();
    //    mMarkerColors = settingsDataMap.value(markerColorsKey).toString();
    //    mHasPublicCache = settingsDataMap.value(hasPublicCacheKey).toBool();
    //    mUseCompactJsonFormat = settingsDataMap.value(useCompactJsonFormatKey).toBool();
    //    mLastUsedNumber = settingsDataMap.value(lastUsedNumberKey).toInt();
    //    mPublicRoot4Dev = settingsDataMap.value(publicRoot4DevKey).toString();
    //    mAutoUpdate = settingsDataMap.value(autoUpdateKey).toBool();
    //    mAutoUpdateEveryHours = settingsDataMap.value(autoUpdateEveryHoursKey).toInt();
    //    if (settingsDataMap.contains(lastUpdateStampKey)) {
    //        // always getting the Date as a String (from server or JSON)
    //        QString lastUpdateStampAsString = settingsDataMap.value(lastUpdateStampKey).toString();
    //        mLastUpdateStamp = QDateTime::fromString(lastUpdateStampAsString, Qt::ISODate);
    //        if (!mLastUpdateStamp.isValid()) {
    //            mLastUpdateStamp = QDateTime();
    //            qDebug() << "mLastUpdateStamp is not valid for String: " << lastUpdateStampAsString;
    //        }
    //    }
    //    mNavigationStyle = settingsDataMap.value(navigationStyleKey).toInt();
    //    mOneMenuButton = settingsDataMap.value(oneMenuButtonKey).toBool();
    //    mClassicStackNavigation = settingsDataMap.value(classicStackNavigationKey).toBool();
}
/*
 * initialize OrderData from QVariantMap
 * Map got from JsonDataAccess or so
 * includes also transient values
 * uses foreign property names - per ex. from Server API
 * corresponding export method: toForeignMap()
 */
void SettingsData::fillFromForeignMap(const QVariantMap &settingsDataMap)
{
    //    mId = settingsDataMap.value(idForeignKey).toInt();
    //    mVersion = settingsDataMap.value(versionForeignKey).toInt();
    //    mApiVersion = settingsDataMap.value(apiVersionForeignKey).toString();
    //    if (settingsDataMap.contains(lastUpdateForeignKey)) {
    //        // always getting the Date as a String (from server or JSON)
    //        QString lastUpdateAsString = settingsDataMap.value(lastUpdateForeignKey).toString();
    //        mLastUpdate = QDateTime::fromString(lastUpdateAsString, Qt::ISODate);
    //        if (!mLastUpdate.isValid()) {
    //            mLastUpdate = QDateTime();
    //            qDebug() << "mLastUpdate is not valid for String: " << lastUpdateAsString;
    //        }
    //    }
    //    mIsProductionEnvironment = settingsDataMap.value(isProductionEnvironmentForeignKey).toBool();
    //    mPrimaryColor = settingsDataMap.value(primaryColorForeignKey).toInt();
    //    mAccentColor = settingsDataMap.value(accentColorForeignKey).toInt();
    //    mDarkTheme = settingsDataMap.value(darkThemeForeignKey).toBool();
    //    mUseMarkerColors = settingsDataMap.value(useMarkerColorsForeignKey).toBool();
    //    mDefaultMarkerColors = settingsDataMap.value(defaultMarkerColorsForeignKey).toBool();
    //    mMarkerColors = settingsDataMap.value(markerColorsForeignKey).toString();
    //    mHasPublicCache = settingsDataMap.value(hasPublicCacheForeignKey).toBool();
    //    mUseCompactJsonFormat = settingsDataMap.value(useCompactJsonFormatForeignKey).toBool();
    //    mLastUsedNumber = settingsDataMap.value(lastUsedNumberForeignKey).toInt();
    //    mPublicRoot4Dev = settingsDataMap.value(publicRoot4DevForeignKey).toString();
    //    mAutoUpdate = settingsDataMap.value(autoUpdateForeignKey).toBool();
    //    mAutoUpdateEveryHours = settingsDataMap.value(autoUpdateEveryHoursForeignKey).toInt();
    //    if (settingsDataMap.contains(lastUpdateStampForeignKey)) {
    //        // always getting the Date as a String (from server or JSON)
    //        QString lastUpdateStampAsString = settingsDataMap.value(lastUpdateStampForeignKey).toString();
    //        mLastUpdateStamp = QDateTime::fromString(lastUpdateStampAsString, Qt::ISODate);
    //        if (!mLastUpdateStamp.isValid()) {
    //            mLastUpdateStamp = QDateTime();
    //            qDebug() << "mLastUpdateStamp is not valid for String: " << lastUpdateStampAsString;
    //        }
    //    }
    //    mNavigationStyle = settingsDataMap.value(navigationStyleForeignKey).toInt();
    //    mOneMenuButton = settingsDataMap.value(oneMenuButtonForeignKey).toBool();
    //    mClassicStackNavigation = settingsDataMap.value(classicStackNavigationForeignKey).toBool();
}
/*
 * initialize OrderData from QVariantMap
 * Map got from JsonDataAccess or so
 * excludes transient values
 * uses own property names
 * corresponding export method: toCacheMap()
 */
void SettingsData::fillFromCacheMap(const QVariantMap &settingsDataMap)
{
    //    mId = settingsDataMap.value(idKey).toInt();
    //    mVersion = settingsDataMap.value(versionKey).toInt();
    //    mApiVersion = settingsDataMap.value(apiVersionKey).toString();
    //    if (settingsDataMap.contains(lastUpdateKey)) {
    //        // always getting the Date as a String (from server or JSON)
    //        QString lastUpdateAsString = settingsDataMap.value(lastUpdateKey).toString();
    //        mLastUpdate = QDateTime::fromString(lastUpdateAsString, Qt::ISODate);
    //        if (!mLastUpdate.isValid()) {
    //            mLastUpdate = QDateTime();
    //            qDebug() << "mLastUpdate is not valid for String: " << lastUpdateAsString;
    //        }
    //    }
    //    mIsProductionEnvironment = settingsDataMap.value(isProductionEnvironmentKey).toBool();
    //    mPrimaryColor = settingsDataMap.value(primaryColorKey).toInt();
    //    mAccentColor = settingsDataMap.value(accentColorKey).toInt();
    //    mDarkTheme = settingsDataMap.value(darkThemeKey).toBool();
    //    mUseMarkerColors = settingsDataMap.value(useMarkerColorsKey).toBool();
    //    mDefaultMarkerColors = settingsDataMap.value(defaultMarkerColorsKey).toBool();
    //    mMarkerColors = settingsDataMap.value(markerColorsKey).toString();
    //    mHasPublicCache = settingsDataMap.value(hasPublicCacheKey).toBool();
    //    mUseCompactJsonFormat = settingsDataMap.value(useCompactJsonFormatKey).toBool();
    //    mLastUsedNumber = settingsDataMap.value(lastUsedNumberKey).toInt();
    //    mPublicRoot4Dev = settingsDataMap.value(publicRoot4DevKey).toString();
    //    mAutoUpdate = settingsDataMap.value(autoUpdateKey).toBool();
    //    mAutoUpdateEveryHours = settingsDataMap.value(autoUpdateEveryHoursKey).toInt();
    //    if (settingsDataMap.contains(lastUpdateStampKey)) {
    //        // always getting the Date as a String (from server or JSON)
    //        QString lastUpdateStampAsString = settingsDataMap.value(lastUpdateStampKey).toString();
    //        mLastUpdateStamp = QDateTime::fromString(lastUpdateStampAsString, Qt::ISODate);
    //        if (!mLastUpdateStamp.isValid()) {
    //            mLastUpdateStamp = QDateTime();
    //            qDebug() << "mLastUpdateStamp is not valid for String: " << lastUpdateStampAsString;
    //        }
    //    }
    //    mNavigationStyle = settingsDataMap.value(navigationStyleKey).toInt();
    //    mOneMenuButton = settingsDataMap.value(oneMenuButtonKey).toBool();
    //    mClassicStackNavigation = settingsDataMap.value(classicStackNavigationKey).toBool();
}

void SettingsData::prepareNew() {}

/*
 * Checks if all mandatory attributes, all DomainKeys and uuid's are filled
 */
bool SettingsData::isValid()
{
    if (id() == -1) {
        return false;
    }
    return true;
}

/*
 * Exports Properties from SettingsData as QVariantMap
 * exports ALL data including transient properties
 * To store persistent Data in JsonDataAccess use toCacheMap()
 */
QVariantMap SettingsData::toMap()
{
    QVariantMap settingsDataMap;
    //    settingsDataMap.insert(idKey, mId);
    //    settingsDataMap.insert(versionKey, mVersion);
    //    settingsDataMap.insert(apiVersionKey, mApiVersion);
    //    if (hasLastUpdate()) {
    //        settingsDataMap.insert(lastUpdateKey, mLastUpdate.toString(Qt::ISODate));
    //    }
    //    settingsDataMap.insert(isProductionEnvironmentKey, mIsProductionEnvironment);
    //    settingsDataMap.insert(primaryColorKey, mPrimaryColor);
    //    settingsDataMap.insert(accentColorKey, mAccentColor);
    //    settingsDataMap.insert(darkThemeKey, mDarkTheme);
    //    settingsDataMap.insert(useMarkerColorsKey, mUseMarkerColors);
    //    settingsDataMap.insert(defaultMarkerColorsKey, mDefaultMarkerColors);
    //    settingsDataMap.insert(markerColorsKey, mMarkerColors);
    //    settingsDataMap.insert(hasPublicCacheKey, mHasPublicCache);
    //    settingsDataMap.insert(useCompactJsonFormatKey, mUseCompactJsonFormat);
    //    settingsDataMap.insert(lastUsedNumberKey, mLastUsedNumber);
    //    settingsDataMap.insert(publicRoot4DevKey, mPublicRoot4Dev);
    //    settingsDataMap.insert(autoUpdateKey, mAutoUpdate);
    //    settingsDataMap.insert(autoUpdateEveryHoursKey, mAutoUpdateEveryHours);
    //    if (hasLastUpdateStamp()) {
    //        settingsDataMap.insert(lastUpdateStampKey, mLastUpdateStamp.toString(Qt::ISODate));
    //    }
    //    settingsDataMap.insert(navigationStyleKey, mNavigationStyle);
    //    settingsDataMap.insert(oneMenuButtonKey, mOneMenuButton);
    //    settingsDataMap.insert(classicStackNavigationKey, mClassicStackNavigation);
    return settingsDataMap;
}

/*
 * Exports Properties from SettingsData as QVariantMap
 * To send data as payload to Server
 * Makes it possible to use defferent naming conditions
 */
QVariantMap SettingsData::toForeignMap()
{
    QVariantMap settingsDataMap;
    //    settingsDataMap.insert(idForeignKey, mId);
    //    settingsDataMap.insert(versionForeignKey, mVersion);
    //    settingsDataMap.insert(apiVersionForeignKey, mApiVersion);
    //    if (hasLastUpdate()) {
    //        settingsDataMap.insert(lastUpdateForeignKey, mLastUpdate.toString(Qt::ISODate));
    //    }
    //    settingsDataMap.insert(isProductionEnvironmentForeignKey, mIsProductionEnvironment);
    //    settingsDataMap.insert(primaryColorForeignKey, mPrimaryColor);
    //    settingsDataMap.insert(accentColorForeignKey, mAccentColor);
    //    settingsDataMap.insert(darkThemeForeignKey, mDarkTheme);
    //    settingsDataMap.insert(useMarkerColorsForeignKey, mUseMarkerColors);
    //    settingsDataMap.insert(defaultMarkerColorsForeignKey, mDefaultMarkerColors);
    //    settingsDataMap.insert(markerColorsForeignKey, mMarkerColors);
    //    settingsDataMap.insert(hasPublicCacheForeignKey, mHasPublicCache);
    //    settingsDataMap.insert(useCompactJsonFormatForeignKey, mUseCompactJsonFormat);
    //    settingsDataMap.insert(lastUsedNumberForeignKey, mLastUsedNumber);
    //    settingsDataMap.insert(publicRoot4DevForeignKey, mPublicRoot4Dev);
    //    settingsDataMap.insert(autoUpdateForeignKey, mAutoUpdate);
    //    settingsDataMap.insert(autoUpdateEveryHoursForeignKey, mAutoUpdateEveryHours);
    //    if (hasLastUpdateStamp()) {
    //        settingsDataMap.insert(lastUpdateStampForeignKey, mLastUpdateStamp.toString(Qt::ISODate));
    //    }
    //    settingsDataMap.insert(navigationStyleForeignKey, mNavigationStyle);
    //    settingsDataMap.insert(oneMenuButtonForeignKey, mOneMenuButton);
    //    settingsDataMap.insert(classicStackNavigationForeignKey, mClassicStackNavigation);
    return settingsDataMap;
}

/*
 * Exports Properties from SettingsData as QVariantMap
 * transient properties are excluded:
 * To export ALL data use toMap()
 */
QVariantMap SettingsData::toCacheMap()
{
    // no transient properties found from data model
    // use default toMao()
    return toMap();
}
