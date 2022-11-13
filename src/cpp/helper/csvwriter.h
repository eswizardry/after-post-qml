#pragma once
#include <iostream>
#include <fstream>
#include <string>
#include <QString>

/**
 * @brief The CSVWriter class
 */
class CSVWriter
{
public:
    /**
     * @brief CSVWriter
     * @param filename
     * @param delimeter
     */
    CSVWriter(QString filename, QString delimeter = ",");


    template<typename T>
    /**
     * @brief addDataRow
     * @param first
     * @param last
     */
    void addDataRow(T first, T last);

private:
    /**
     * @brief m_fileName
     */
    QString     m_fileName;
    /**
     * @brief m_delimeter
     */
    QString     m_delimeter;
    /**
     * @brief m_linesCount
     */
    int         m_linesCount;
};

CSVWriter::CSVWriter(QString filename, QString delimeter) :
    m_fileName(filename),
    m_delimeter(delimeter),
    m_linesCount(0)
{

}

template<typename T>
void CSVWriter::addDataRow(T begin, T end)
{
    std::ofstream file;

    file.open(qPrintable(m_fileName),
              std::ios::out | (m_linesCount ? std::ios::app : std::ios::trunc));

    // Iterate to add each element to file seperated by delimeter.
    for (; begin != end; ) {
        file << qPrintable(*begin);
        if (++begin != end)
            file << qPrintable(m_delimeter);
    }

    file << std::endl;
    m_linesCount++;

    file.close();
}
