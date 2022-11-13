#include "convertinghelpers.h"

#include <QString>
#include <QDateTime>

#include "../Common/biorecdefines.h"

double ConvertingHelpers::stdStringToDouble(std::string strVal)
{
    QString sVal            = QString::fromStdString(strVal);
    double dVal             = sVal.toInt();
    return dVal;
}

int ConvertingHelpers::stdStringToInt(std::string strVal)
{
    QString sVal            = QString::fromStdString(strVal);
    int iVal                = sVal.toInt();
    return iVal;
}

QString ConvertingHelpers::intToQString(int iVal)
{
    return QString::number(iVal);
}

QString ConvertingHelpers::doubleToQString(double dVal, int decPlaces)
{
    return QString::number(dVal, 'f', decPlaces);
}

QPoint ConvertingHelpers::intToQPoint(int x, int y)
{
    return QPoint(x, y);
}

QString ConvertingHelpers::secToTimeFormat(int sec)
{
    return QDateTime::fromTime_t(static_cast<unsigned int>(sec)).toUTC().toString("hh:mm:ss");
}

int ConvertingHelpers::timeFormatToMin(QString timeString)
{
    int minutes = 0;
    QStringList strList = timeString.split(':', QString::SkipEmptyParts);

    if (strList.size() == 2) {
        minutes = strList[0].toInt() * 60;
        minutes += strList[1].toInt();
    }

    return minutes;
}

long long ConvertingHelpers::minToMsecsSinceEpoch(unsigned int min)
{
    return QDateTime::fromTime_t(min).toUTC().toMSecsSinceEpoch();
}

QString ConvertingHelpers::secsToDateTimeString(QString secs)
{
    return QDateTime::fromSecsSinceEpoch(secs.toInt()).toString(kDateTimeFormat);
}

QString ConvertingHelpers::fileUrlToFilename(QString fileUrl, QString extension)
{
    auto filename = fileUrl.remove("file:///");
    if (!filename.endsWith(extension))
        filename.append(extension);

    return filename;
}
