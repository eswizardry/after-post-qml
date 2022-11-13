#include "apptranslator.h"
#include "../helper/utils.h"

#include <QCoreApplication>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QTranslator>

AppTranslator::AppTranslator(QQmlEngine *engine, QObject *parent) : QObject(parent), m_engine(engine)
{
    m_appTranslator = new QTranslator();
    m_langPath      = ":/translations";
    this->availableLanguages(QStringList() << "en_US"
                                           << "th"
                                           << "cn");
    if (this->availableLanguages().contains(QLocale::system().name()))
        this->selectLanguage(QLocale::system().name());
    else
        this->selectLanguage("th");

    QStringList langNameList;
    for (auto langCode : this->availableLanguages()) {
        auto langName = QString("%1 (%2)").arg(languageToString(langCode)).arg(langCode);
        langNameList.append(langName);
    }
    this->availableLanguagesName(langNameList);

    connect(this, &AppTranslator::languageChanged, m_engine, &QQmlEngine::retranslate);
}

AppTranslator::~AppTranslator()
{
    Utils::DestructorMsg(this);
}

void AppTranslator::selectLanguage(QString language)
{
    QCoreApplication::removeTranslator(m_appTranslator);

    if (language != currentLanguage()) {
        if (availableLanguages().contains(language)) {
            auto langFile = QString("app_%1.qm").arg(language);

            if (m_appTranslator->load(langFile, m_langPath)) {
                currentLanguage(language);
                qInfo() << "CURRENT LANGUGE: " << currentLanguage();
            }
        }

        QCoreApplication::installTranslator(m_appTranslator);
        emit languageChanged();
    }
}

QString AppTranslator::languageToString(const QString &code)
{
    QLocale locale(code);
    return QLocale::languageToString(locale.language());
}

QTranslator *AppTranslator::appTranslator() const
{
    return m_appTranslator;
}
