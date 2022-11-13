#pragma once
#include <QObject>

#include "../Soup/tiny-aes/aes.hpp"
/**
 * @brief The Encryption class
 */
class Encryption : public QObject
{
    Q_OBJECT
public:
    explicit Encryption(QObject *parent = nullptr);

    /**
     * @brief encodeText
     * @param rawText
     * @param key
     * @return
     */
    static QString encodeText(const QString &rawText, const QString &key);
    /**
     * @brief decodeText
     * @param hexEncodedText
     * @param key
     * @return
     */
    static QString decodeText(const QString &hexEncodedText, const QString &key);
signals:

public slots:

private:
    /**
     * @brief getAlignedSize
     * @param currSize
     * @param alignment
     * @return
     */
    static constexpr int getAlignedSize(int currSize, int alignment);
};
