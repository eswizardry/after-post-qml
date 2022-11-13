#pragma once
#include <QDebug>
#include <QFile>
#include <QList>
#include <QString>
#include <QStringList>

class CSVParser
{
public:
    CSVParser(QString data, QStringList headerList, QString delimeter = ",");

    bool init();
    bool readRow(QStringList &row);

private:
    QString     m_data;
    QStringList m_headerList;
    QStringList m_lineList;
    QString     m_delimeter;
    int         m_index;
};

CSVParser::CSVParser(QString data, QStringList headerList, QString delimeter) :
    m_data(data),
    m_headerList(headerList),
    m_delimeter(delimeter)
{
    m_index = 0;
    m_lineList = m_data.split("\n", QString::SkipEmptyParts);
}

bool CSVParser::init()
{
    m_index = 0;
    m_lineList = m_data.split("\n", QString::SkipEmptyParts);
    for (auto header : m_headerList) {
        auto headerRow = m_lineList.at(0).simplified().split(m_delimeter, QString::SkipEmptyParts);
        if (!headerRow.contains(header)) {
            qDebug() << QString("Column header [%1] not exist.").arg(header);
            return false;
        }
    }

    return true;
}

bool CSVParser::readRow(QStringList &row)
{
    ++m_index;
    if (m_index < m_lineList.size()) {
        row = m_lineList.at(m_index).split(m_delimeter);
        return true;
    } else {
        return false;
    }
}
