#pragma once
#include <QObject>

class QQmlEngine;
class QTranslator;

#include "../helper/PropertyHelper.h"

class AppTranslator : public QObject
{
    Q_OBJECT

    AUTO_PROPERTY(QString, currentLanguage)
    AUTO_PROPERTY(QStringList, availableLanguages)
    AUTO_PROPERTY(QStringList, availableLanguagesName)

public:
    explicit AppTranslator(QQmlEngine *engine, QObject *parent = nullptr);
    ~AppTranslator();

    Q_INVOKABLE void           selectLanguage(QString language);
    Q_INVOKABLE static QString languageToString(const QString &code);

    QTranslator *appTranslator() const;

signals:
    void languageChanged();

private:
    QQmlEngine * m_engine;
    QTranslator *m_appTranslator; ///< contains the translations for this application
    QString      m_langPath;      ///< Path of language files. This is always fixed to /languages.
};
