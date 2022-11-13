#pragma once

#include <QObject>
#include <QQmlNetworkAccessManagerFactory>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QSslError>

// need to derive your class from QDeclarativeNetworkAccessManagerFactory, Our class is derived also from
// QObject the reason is to use signal and slot mechanism
class CustomNetworkManagerFactory : public QObject, public QQmlNetworkAccessManagerFactory
{
    Q_OBJECT
public:
    explicit CustomNetworkManagerFactory(QObject *parent = nullptr);
    virtual QNetworkAccessManager *create(QObject *parent);

public slots:
    void onIgnoreSSLErrors(QNetworkReply *reply, QList<QSslError> error);

private:
    QNetworkAccessManager *m_networkManager;
};
