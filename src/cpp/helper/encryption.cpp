#include "encryption.h"
#include <QCryptographicHash>

const uint8_t iv[] = { 0x61, 0x3d, 0xeb, 0x10, 0xfe, 0xca, 0x71, 0xbe,
                       0x2b, 0x73, 0xae, 0xfe, 0x85, 0x7d, 0x97, 0x81
                     };

Encryption::Encryption(QObject *parent) : QObject(parent)
{

}

constexpr int Encryption::getAlignedSize(int currSize, int alignment)
{
    int padding = (alignment - currSize % alignment) % alignment;
    return currSize + padding;
}

QString Encryption::encodeText(const QString &rawText, const QString &key)
{
    QCryptographicHash hash(QCryptographicHash::Md5);
    hash.addData(key.toUtf8());
    QByteArray keyData = hash.result();

    const ushort *rawData = rawText.utf16();
    void *rawDataVoid = (void *)rawData;
    const char *rawDataChar = static_cast<const char *>(rawDataVoid);
    QByteArray inputData;
    inputData.append(rawDataChar, rawText.size() * sizeof(QChar) + 1);

    const int length = inputData.size();
    int encryptionLength = getAlignedSize(length, 16);
    Q_ASSERT(encryptionLength % 16 == 0 && encryptionLength >= length);

    inputData.resize(encryptionLength);
    for (int i = length; i < encryptionLength; i++) {
        inputData[i] = 0;
    }

    struct AES_ctx ctx;
    AES_init_ctx_iv(&ctx, (const uint8_t *)keyData.data(), iv);
    AES_CBC_encrypt_buffer(&ctx, (uint8_t *)inputData.data(), encryptionLength);

    QString hex = QString::fromLatin1(inputData.toHex());
    return hex;
}

QString Encryption::decodeText(const QString &hexEncodedText, const QString &key)
{
    QCryptographicHash hash(QCryptographicHash::Md5);
    hash.addData(key.toUtf8());
    QByteArray keyData = hash.result();

    const int length = hexEncodedText.size();
    int encryptionLength = getAlignedSize(length, 16);

    QByteArray encodedText = QByteArray::fromHex(hexEncodedText.toLatin1());
    const int encodedOriginalSize = encodedText.size();
    Q_ASSERT(encodedText.length() <= encryptionLength);
    encodedText.resize(encryptionLength);
    for (int i = encodedOriginalSize; i < encryptionLength; i++) {
        encodedText[i] = 0;
    }

    struct AES_ctx ctx;
    AES_init_ctx_iv(&ctx, (const uint8_t *)keyData.data(), iv);
    AES_CBC_decrypt_buffer(&ctx, (uint8_t *)encodedText.data(), encryptionLength);

    encodedText.append("\0\0");
    void *data = encodedText.data();
    const ushort *decodedData = static_cast<ushort *>(data);
    QString result = QString::fromUtf16(decodedData, -1);
    return result;
}
