/******************************************************************************
* Copyright (C) 2017-2018 IKA-Werke GmbH & Co. KG
*
* Filename              : convertinghelpers.h
* Author                : jku
* Date First Issued     : 22.05.2018
* Description           : functions for value convertions.
* Last Changed By       :
* Last Changed Date     :
******************************************************************************/

#ifndef CONVERTINGHELPERS_H
#define CONVERTINGHELPERS_H

#include <QObject>
#include <string>
#include <QString>
#include <QPoint>

/// Contains static functions to convert between types.
class ConvertingHelpers : public QObject
{
    Q_OBJECT

public:
    ///Converts a std::string to double value.
    /// \param strVal The string value to convert.
    Q_INVOKABLE static double stdStringToDouble(std::string strVal);
    ///Converts a std::string to integer value.
    /// \param strVal The string value to convert.
    Q_INVOKABLE static int stdStringToInt(std::string strVal);
    ///Converts an integer value to a QString.
    /// \param iVal The integer value to convert.
    Q_INVOKABLE static QString intToQString(int iVal);
    ///Converts a double value to a QString
    /// \param dVal The double value to convert.
    /// \param decPlaces The number of decimal places.
    Q_INVOKABLE static QString doubleToQString(double dVal, int decPlaces);
    ///Converts 2 integers value to a QPoint.
    /// \param x The 1st integer value to convert.
    /// \param y The 2nd integer value to convert.
    Q_INVOKABLE static QPoint intToQPoint(int x, int y);
    ///Converts an int value to a QString in hh:mm:ss format
    /// \param sec The integer value of second to convert.
    Q_INVOKABLE static QString secToTimeFormat(int sec);
    ///Converts an time format (00:00:00) string to Minutes (int)
    /// \param timeString The time string format to convert.
    Q_INVOKABLE static int timeFormatToMin(QString timeString);
    ///Converts an unsigned int value to a mSec since Epoch
    /// \param min The integer value of minute to convert.
    Q_INVOKABLE static long long minToMsecsSinceEpoch(unsigned int min);
    ///Converts a QString of SecsSinceEpoch to a QString in "hh:mm:ss dd/MM/yyyy" format
    /// \param SecsSinceEpoch in QString format.
    Q_INVOKABLE static QString secsToDateTimeString(QString secs);
    ///Converts a String of file URL to file name
    /// \param file URL
    /// /// \param file extension
    Q_INVOKABLE static QString fileUrlToFilename(QString fileUrl, QString extension);
};

#endif // CONVERTINGHELPERS_H
