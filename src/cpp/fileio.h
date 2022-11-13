#pragma once

#include <QDebug>
#include <QDir>
#include <QFile>
#include <QObject>
#include <QTextStream>
#include <QUrl>

class FileIO : public QObject
{
    Q_OBJECT

public slots:
    bool write(const QString &source, const QString &data)
    {
        if (source.isEmpty())
            return false;

        QFile file(source);
        if (!file.open(QFile::WriteOnly | QFile::Truncate)) {
            qCritical() << file.errorString();
            return false;
        }

        QTextStream out(&file);
        out << data;
        file.close();

        return true;
    }

    QString read(const QString &source)
    {
        if (source.isEmpty())
            return "";

        QFile file(source);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qCritical() << file.errorString();
            return "";
        }

        return file.readAll();
    }

    bool isFileExists(const QString filename) { return QFile::exists(filename); }

    bool isDirExists(const QString dirname)
    {
        QDir dir(dirname);
        return dir.exists();
    }

    void mkDir(const QString dirname)
    {
        QDir dir(dirname);
        if (!dir.exists())
            dir.mkpath(".");
    }

    QString homeDir() { return QDir::homePath(); }

public:
    FileIO() {}
};
