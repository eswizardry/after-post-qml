#pragma once
#include <QObject>
#include <QDateTime>
#include <memory>

class QString;

/// Teminal color code
#define COLOR_BLACK "\033[30m"
#define COLOR_BLACK_BOLD "\033[30;1m"
#define COLOR_RED "\033[31m"
#define COLOR_RED_BOLD "\033[31;1m"
#define COLOR_GREEN "\033[32m"
#define COLOR_GREEN_BOLD "\033[32;1m"
#define COLOR_YELLOW "\033[33m"
#define COLOR_YELLOW_BOLD "\033[33;1m"
#define COLOR_BLUE "\033[34m"
#define COLOR_BLUE_BOLD "\033[34;1m"
#define COLOR_PURPLE "\033[35m"
#define COLOR_PURPLE_BOLD "\033[35;1m"
#define COLOR_CYAN "\033[36m"
#define COLOR_CYAN_BOLD "\033[36;1m"
#define COLOR_WHITE "\033[37m"
#define COLOR_WHITE_BOLD "\033[37;1m"
#define COLOR_RESET "\033[0m"

#define COLOR_INFO COLOR_WHITE_BOLD
#define COLOR_DEBUG COLOR_GREEN_BOLD
#define COLOR_WARN COLOR_YELLOW_BOLD
#define COLOR_CRITICAL COLOR_RED_BOLD
#define COLOR_FATAL COLOR_PURPLE_BOLD

#define LOG_PRINT(OUTPUT, COLOR, LEVEL, MSG, LOCATION)                                                       \
    OUTPUT << COLOR << QDateTime::currentDateTime().toString("hh:mm:ss:zzz").toStdString() << " " LEVEL " "  \
           << COLOR_RESET << MSG << COLOR_BLACK << LOCATION << std::endl

/**
 * @brief The Utils class
 */
class Utils
{
public:
    /**
     * @brief Utils
     */
    Utils();
    /**
     * @brief DestructorMsg
     * @param value
     */
    static void DestructorMsg(const QString value);

    static void DestructorMsg(const QObject *const object);
    template<typename T, typename... Args>
    static std::unique_ptr<T> make_unique(Args &&... args)
    {
        return std::unique_ptr<T>(new T(std::forward<Args>(args)...));
    }

    static void messageOutputHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);

private:
    explicit Utils(const Utils &rhs) = delete;
    Utils &operator=(const Utils &rhs) = delete;
};
