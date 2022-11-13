#include "unsafearea.h"

#include <QDebug>

UnsafeArea::UnsafeArea(QObject *parent) :
    QObject(parent), mUnsafeTopMargin(0), mUnsafeBottomMargin(0), mUnsafeLeftMargin(0), mUnsafeRightMargin(0), mMyDevice(MyDevice::OTHER)
{ 

}

// https://bugreports.qt.io/browse/QTBUG-64574
// I O S sizes to detect the device type
// https://stackoverflow.com/questions/46192280/detect-if-the-device-is-iphone-x
// 1136 iPhone 5, 5S, 5C
// 1334 iPhone 6/6S/7/8
// 1920,2208 iPhone 6+/6S+/7+/8+
// 2436 iPhone X, Xs
// 2688 iPhone Xs Max
// 1792 iPhone Xr
// https://developer.apple.com/library/archive/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
// attention: all sizes are UIKIT SIZES not NATIVE PIXEL
void UnsafeArea::configureDevice(int height, int width, int devicePixelRatio)
{
    qDebug() << "UNSAFE AREAS ? configureDevice - height: " << height << " width: " << width << " devicePixelRatio: " << devicePixelRatio;
    int portraitHeightPixel = 0;
    if(height > width) {
        portraitHeightPixel = height*devicePixelRatio;
    } else {
        portraitHeightPixel = width*devicePixelRatio;
    }
    switch (portraitHeightPixel) {
    case 1136:
        mMyDevice = MyDevice::IPHONE_5_5S_5C;
        qDebug() << "Device detected: " << "IPHONE_5_5S_5C";
        break;
    case 1334:
        mMyDevice = MyDevice::IPHONE_6_6S_7_8;
        qDebug() << "Device detected: " << "IPHONE_6_6S_7_8";
        break;
    case 1920:
    case 2208:
        mMyDevice = MyDevice::IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS;
        qDebug() << "Device detected: " << "IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS";
        break;
    case 2436:
        mMyDevice = MyDevice::IPHONE_X_XS;
        qDebug() << "Device detected: " << "IPHONE_X_XS";
        break;
    case 2688:
        mMyDevice = MyDevice::IPHONE_XSMAX;
        qDebug() << "Device detected: " << "IPHONE_XSMAX";
        break;
    case 1792:
        mMyDevice = MyDevice::IPHONE_XR;
        qDebug() << "Device detected: " << "IPHONE_XR";
        break;
    case 2732:
        mMyDevice = MyDevice::IPADPRO_129;
        qDebug() << "Device detected: " << "IPADPRO 12.9";
        break;
    case 2224:
        mMyDevice = MyDevice::IPADPRO_105;
        qDebug() << "Device detected: " << "IPADPRO 10.5";
        break;
    case 2048:
        mMyDevice = MyDevice::IPADPRO_97_AIR_MINI;
        qDebug() << "Device detected: " << "IPADPRO 9.7, Air 2, Mini4";
        break;
    case 2388:
        mMyDevice = MyDevice::IPADPRO_11;
        qDebug() << "Device detected: " << "IPADPRO 11";
        break;
    default:
        mMyDevice = MyDevice::OTHER;
        qDebug() << "Device detected: " << "OTHER";
    }
}

bool UnsafeArea::isKnownIPhone() {
    switch (mMyDevice) {
    case MyDevice::IPHONE_X_XS:
    case MyDevice::IPHONE_XSMAX:
    case MyDevice::IPHONE_XR:
    case MyDevice::IPHONE_5_5S_5C:
    case MyDevice::IPHONE_6_6S_7_8:
    case MyDevice::IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS:
        qDebug() << "isKnownIPhone";
        return true;
    default:
        break;
    }
    return false;
}

bool UnsafeArea::isKnownIPad() {
    switch (mMyDevice) {
    case MyDevice::IPADPRO_97_AIR_MINI:
    case MyDevice::IPADPRO_105:
    case MyDevice::IPADPRO_129:
    case MyDevice::IPADPRO_11:
        qDebug() << "isKnownIPad";
        return true;
    default:
        break;
    }
    return false;
}

void UnsafeArea::orientationChanged(int orientation)
{
    qDebug() << "orientationChanged: " << orientation;
    if(orientation == 1) {
        qDebug() << "PORTRAIT";
        portrait();
    } else if(orientation == 2) {
        qDebug() << "LANDSCAPE LEFT (HomeButton right)";
        landscapeLeft();
    } else if(orientation == 4) {
        qDebug() << "PORTRAIT INVERTED (HomeButton on top)";
        portraitInverted();
    } else if(orientation == 8) {
        qDebug() << "LANDSCAPE RIGHT (HomeButton left)";
        landscapeRight();
    } else {
        qWarning() << "unsupported Orientation: " << orientation;
    }
}

void UnsafeArea::portrait()
{
    switch (mMyDevice) {
    case MyDevice::IPHONE_X_XS:
    case MyDevice::IPHONE_XSMAX:
    case MyDevice::IPHONE_XR:
        setUnsafeTopMargin(24);
        setUnsafeBottomMargin(8);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPHONE_5_5S_5C:
    case MyDevice::IPHONE_6_6S_7_8:
    case MyDevice::IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS:
        setUnsafeTopMargin(16);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_97_AIR_MINI:
    case MyDevice::IPADPRO_105:
        setUnsafeTopMargin(16);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_129:
        // 3rd gen - we miss the older 12.9, but we have enough space, so it doesnt matter
    case MyDevice::IPADPRO_11:
        setUnsafeTopMargin(16);
        setUnsafeBottomMargin(16);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    default:
        break;
    }
}

// seems that on iPhoneX there's no portrait inverse rotation
// https://forums.macrumors.com/threads/no-upside-down-rotation-on-the-iphone-x.2084890/page-2
// perhaps one day it will work ... I guessed that I only need the safe area at bottom where the notch is in inverse
// at first I removed portrait inverse from info.plist, but then upload to appstore fails because iPads need this orientation
void UnsafeArea::portraitInverted()
{
    switch (mMyDevice) {
    case MyDevice::IPHONE_X_XS:
    case MyDevice::IPHONE_XSMAX:
    case MyDevice::IPHONE_XR:
        setUnsafeTopMargin(0);
        setUnsafeBottomMargin(24);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPHONE_5_5S_5C:
    case MyDevice::IPHONE_6_6S_7_8:
    case MyDevice::IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS:
        setUnsafeTopMargin(16);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_97_AIR_MINI:
    case MyDevice::IPADPRO_105:
        setUnsafeTopMargin(16);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_129:
        // 3rd gen - we miss the older 12.9, but we have enough space, so it doesnt matter
    case MyDevice::IPADPRO_11:
        setUnsafeTopMargin(16);
        setUnsafeBottomMargin(16);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    default:
        break;
    }
}

// HomeButton right
void UnsafeArea::landscapeLeft()
{
    switch (mMyDevice) {
    case MyDevice::IPHONE_X_XS:
    case MyDevice::IPHONE_XSMAX:
    case MyDevice::IPHONE_XR:
        setUnsafeTopMargin(0);
        setUnsafeBottomMargin(8);
        setUnsafeLeftMargin(30);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPHONE_5_5S_5C:
    case MyDevice::IPHONE_6_6S_7_8:
    case MyDevice::IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS:
        setUnsafeTopMargin(10);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_97_AIR_MINI:
    case MyDevice::IPADPRO_105:
        setUnsafeTopMargin(10);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_129:
        // 3rd gen - we miss the older 12.9, but we have enough space, so it doesnt matter
    case MyDevice::IPADPRO_11:
        setUnsafeTopMargin(10);
        setUnsafeBottomMargin(16);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    default:
        break;
    }
}

// HomeButton left
void UnsafeArea::landscapeRight()
{
    switch (mMyDevice) {
    case MyDevice::IPHONE_X_XS:
    case MyDevice::IPHONE_XSMAX:
    case MyDevice::IPHONE_XR:
        setUnsafeTopMargin(0);
        setUnsafeBottomMargin(8);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(30);
        break;
    case MyDevice::IPHONE_5_5S_5C:
    case MyDevice::IPHONE_6_6S_7_8:
    case MyDevice::IPHONE_6PLUS_6SPLUS_7PLUS_8PLUS:
        setUnsafeTopMargin(10);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_97_AIR_MINI:
    case MyDevice::IPADPRO_105:
        setUnsafeTopMargin(10);
        setUnsafeBottomMargin(0);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    case MyDevice::IPADPRO_129:
        // 3rd gen - we miss the older 12.9, but we have enough space, so it doesnt matter
    case MyDevice::IPADPRO_11:
        setUnsafeTopMargin(10);
        setUnsafeBottomMargin(16);
        setUnsafeLeftMargin(0);
        setUnsafeRightMargin(0);
        break;
    default:
        break;
    }
}

int UnsafeArea::unsafeTopMargin() const
{
    return mUnsafeTopMargin;
}

int UnsafeArea::unsafeBottomMargin() const
{
    return mUnsafeBottomMargin;
}

int UnsafeArea::unsafeLeftMargin() const
{
    return mUnsafeLeftMargin;
}

int UnsafeArea::unsafeRightMargin() const
{
    return mUnsafeRightMargin;
}

void UnsafeArea::setUnsafeTopMargin(int unsafeTopMargin)
{
    if (mUnsafeTopMargin == unsafeTopMargin)
        return;
    mUnsafeTopMargin = unsafeTopMargin;
    emit unsafeTopMarginChanged(mUnsafeTopMargin);
}
void UnsafeArea::setUnsafeBottomMargin(int unsafeBottomMargin)
{
    if (mUnsafeBottomMargin == unsafeBottomMargin)
        return;
    mUnsafeBottomMargin = unsafeBottomMargin;
    emit unsafeBottomMarginChanged(mUnsafeBottomMargin);
}
void UnsafeArea::setUnsafeLeftMargin(int unsafeLeftMargin)
{
    if (mUnsafeLeftMargin == unsafeLeftMargin)
        return;
    mUnsafeLeftMargin = unsafeLeftMargin;
    emit unsafeLeftMarginChanged(mUnsafeLeftMargin);
}
void UnsafeArea::setUnsafeRightMargin(int unsafeRightMargin)
{
    if (mUnsafeRightMargin == unsafeRightMargin)
        return;
    mUnsafeRightMargin = unsafeRightMargin;
    emit unsafeRightMarginChanged(mUnsafeRightMargin);
}

UnsafeArea::~UnsafeArea()
{
    // place cleanUp code here
}
