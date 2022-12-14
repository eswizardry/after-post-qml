pragma Singleton

import QtQuick 2.13


/** @ingroup QML_Singleton
 *  @brief The QML Global for Styles
 */
QtObject {
  id: style
  property int lineSize: 1

  property int roundness: 4

  property int spacingSmall: 4
  property int spacingNormal: 8
  property int spacingBig: 12
}
