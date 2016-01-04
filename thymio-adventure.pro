TEMPLATE = app
QT += core quick widgets 3dcore 3dquick
SOURCES += main.cpp
RESOURCES += thymio-adventure.qrc
include(thymio-ar/thymio-ar.pri)
include(deployment.pri)

android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/res/values/libs.xml \
        android/build.gradle
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}
