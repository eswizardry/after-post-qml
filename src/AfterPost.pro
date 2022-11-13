TEMPLATE                = app
QT                      +=  quick \
                            quickcontrols2 \
                            network \
                            qml \

CONFIG					+= c++14 \

TRANSLATIONS            += \
                           translations/app_en_US.ts \
                           translations/app_th.ts \
                           translations/app_cn.ts \

# Supported languages
LANGUAGES = th en_US cn

# The application version
VER_MAJ = 1
VER_MIN = 1
VER_PAT = 1
VERSION = $$sprintf("%1.%2.%3",$$VER_MAJ,$$VER_MIN,$$VER_PAT)

APPLICATION_NAME		= AfterPost
ORG_NAME				= esWizardry
ORG_DOMAIN				= eswizardry.github.io
BUILDDATE				= $$system( date /t ) $$system( time /t )
BUILDDATE				= $$member(BUILDDATE, 0)_$$member(BUILDDATE, 1)

# Define the preprocessor macro to get the application version in the application.
#Note: \\\" is important! Without them, the Macro is taken as a double constant instead of string constant.
DEFINES					+= APP_VERSION=\\\"$$VERSION\\\"
DEFINES					+= APP_NAME=$$shell_quote(\"$$APPLICATION_NAME\")
DEFINES					+= ORGANIZATION_NAME=$$shell_quote(\"$$ORG_NAME\")
DEFINES					+= ORGANIZATION_DOMAIN=$$shell_quote(\"$$ORG_DOMAIN\")
DEFINES					+= BUILD_DATE=$$shell_quote(\"$$BUILDDATE\")

TARGET                  = $$APPLICATION_NAME

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES					+= QT_DEPRECATED_WARNINGS

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$[QT_INSTALL_QML]

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Default rules for deployment.
include(./cpp/helper/helper.pri)
include(./cpp/common/common.pri)
include(./soup/soup.pri)
include(./android_openssl/openssl.pri)

SOURCES +=  cpp/main.cpp \
            cpp/applicationui.cpp \
            cpp/customnetworkmanagerfactory.cpp \
            cpp/settingsdata.cpp \
            cpp/unsafearea.cpp
HEADERS +=  cpp/platform.h \
            cpp/applicationui.h \
            cpp/customnetworkmanagerfactory.h \
            cpp/fileio.h \ \
            cpp/settingsdata.h \
            cpp/uiconstants.h \
            cpp/unsafearea.h

RESOURCES +=    resources.qrc \
                qml/fontAwesome/fontAwesome.qrc \
                qml/qml.qrc \
                qml/logic/logic.qrc \
                qml/model/model.qrc \
                qml/navigations/navigations.qrc \
                qml/pages/pages.qrc \
                qml/popups/popups.qrc \
                qml/singletons/singletons.qrc \
                qml/components/components.qrc \
                qml/soup/soup.qrc \
                fonts/fonts.qrc \
                images/images.qrc \
                translations/translations.qrc \

DISTFILES += \
                README.md \
#               translations/app_en_US.ts \
#               translations/app_de_DE.ts \
 \#               translations/app_th.ts \
    android-sources/res/drawable/splashscreen.xml \
    android-sources/res/values/styles.xml

CONFIG(debug, debug|release) {
    message("debug mode")
    QT += websockets
    CONFIG += qml_debug
} else {
    message("release mode")
}

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
#this has to be done on windows side, otherwise an error is generated at compiling
win32 {
    RC_FILE += win/app_icon.rc

    INCLUDEPATH += "C:/Program Files (x86)/Windows Kits/10/Include/10.0.17134.0/ucrt"
    LIBS += -L"C:/Program Files (x86)/Windows Kits/10/Lib/10.0.17134.0/ucrt/x64"
    LIBS += -luser32

    #  !contains(QMAKE_TARGET.arch, x86_64){
    #      message("x86 build")
    #  } else {
    #          message("x64 build")
           # LIBS +=				-LC:/OpenSSL-Win64/lib/VC -llibssl
           # LIBS +=				-LC:/OpenSSL-Win64/lib/VC -llibcrypto

           # INCLUDEPATH			+= C:/OpenSSL-Win64/include
    #  }
}

macx {
    ICON = osx/app_icon.icns
    QMAKE_INFO_PLIST = osx/Info.plist
}

ios {
    QMAKE_INFO_PLIST = ios/Info.plist

    # framework needed for Reachability classes
#    LIBS += -framework SystemConfiguration
    # Reachability to get reliable online state
#    SOURCES += ios/src/Reachability.mm \
#    ios/src/ReachabilityListener.mm

#    QMAKE_INFO_PLIST = ios/Info.plist

#    QMAKE_ASSET_CATALOGS = $$PWD/ios/Images.xcassets
#    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"

#    ios_artwork.files = $$files($$PWD/ios/iTunesArtwork*.png)
#    QMAKE_BUNDLE_DATA += ios_artwork
#    app_launch_screen.files = $$files($$PWD/ios/MyLaunchScreen.xib)
#    QMAKE_BUNDLE_DATA += app_launch_screen

#    QMAKE_IOS_DEPLOYMENT_TARGET = 11.0

#    disable_warning.name = GCC_WARN_64_TO_32_BIT_CONVERSION
#    disable_warning.value = NO
#    QMAKE_MAC_XCODE_SETTINGS += disable_warning

    # QtCreator 4.3 provides an easy way to select the development team
    # see Project - Build - iOS Settings
    # I have to deal with different development teams,
    # so I include my signature here
    # ios_signature.pri not part of project repo because of private signature details
    # contains:
    # QMAKE_XCODE_CODE_SIGN_IDENTITY = "iPhone Developer"
    # MY_DEVELOPMENT_TEAM.name = DEVELOPMENT_TEAM
    # MY_DEVELOPMENT_TEAM.value = your team Id from Apple Developer Account
    # QMAKE_MAC_XCODE_SETTINGS += MY_DEVELOPMENT_TEAM

#    include(ios_signature.pri)

    # see https://bugreports.qt.io/browse/QTBUG-70072
#    QMAKE_TARGET_BUNDLE_PREFIX = org.ekkescorner
#    QMAKE_BUNDLE = c2g.qtws

    # Note for devices: 1=iPhone, 2=iPad, 1,2=Universal.
#    QMAKE_APPLE_TARGETED_DEVICE_FAMILY = 1,2
}

android {
    QT += androidextras
    # provide openss libs
    # see https://github.com/KDAB/android_openssl
    include($$PWD/android_openssl/openssl.pri)

    DISTFILES += \
                    android-sources/AndroidManifest.xml \
                    android-sources/build.gradle \
                    android-sources/gradle/wrapper/gradle-wrapper.jar \
                    android-sources/gradle/wrapper/gradle-wrapper.properties \
                    android-sources/gradlew \
                    android-sources/gradlew.bat \
                    android-sources/res/values/libs.xml \

    defineReplace(droidVersionCode) {
        segments = $$split(1, ".")
        for (segment, segments): vCode = "$$first(vCode)$$format_number($$segment, width=3 zeropad)"
        contains(ANDROID_TARGET_ARCH, arm64-v8a): \
            suffix = 1
        else:contains(ANDROID_TARGET_ARCH, armeabi-v7a): \
            suffix = 0
        # add more cases as needed
        return($$first(vCode)$$first(suffix))
    }
    ANDROID_VERSION_NAME    = $$VERSION
    ANDROID_VERSION_CODE    = $$droidVersionCode($$ANDROID_VERSION_NAME)

    ANDROID_APP_LIB_NAME    = $$TARGET

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources

    # AndroidTools need to plac under ANDROID_PACKAGE_SOURCE_DIR only
    DEFINES += \
        QTAT_APP_PERMISSIONS \
        QTAT_APK_INFO \
        QTAT_SCREEN \
        QTAT_ADMOB_BANNER \

    include(soup/QtAndroidTools/QtAndroidTools/QtAndroidTools.pri)
}
