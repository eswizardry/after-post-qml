pragma Singleton

import QtQuick 2.13


/** @ingroup QML_Singleton
 *  @brief The QML Global for Regular Expression Validator
 */
Item {
  id: root
  readonly property var regExp_integer: RegExpValidator {
    regExp: /^-?\d+$/
  }
  readonly property var regExp_posInteger: RegExpValidator {
    regExp: /^\d+$/
  }
  readonly property var regExp_negInteger: RegExpValidator {
    regExp: /^-\d+$/
  }
  readonly property var regExp_time24Hrs: RegExpValidator {
    regExp: /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/
  }
  readonly property var regExp_timeIso8601: RegExpValidator {
    regExp: /^(?![+-]?\d{4,5}-?(?:\d{2}|W\d{2})T)(?:|(\d{4}|[+-]\d{5})-?(?:|(0\d|1[0-2])(?:|-?([0-2]\d|3[0-1]))|([0-2]\d{2}|3[0-5]\d|36[0-6])|W([0-4]\d|5[0-3])(?:|-?([1-7])))(?:(?!\d)|T(?=\d)))(?:|([01]\d|2[0-4])(?:|:?([0-5]\d)(?:|:?([0-5]\d)(?:|\.(\d{3})))(?:|[zZ]|([+-](?:[01]\d|2[0-4]))(?:|:?([0-5]\d)))))$/
  }
  readonly property var regExp_hhmm: RegExpValidator {
    regExp: /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/
  }
  readonly property var regExp_ddmmyyyy: RegExpValidator {
    regExp: /^(0?[1-9]|[12][0-9]|3[01])([ \/\-])(0?[1-9]|1[012])\2([0-9][0-9][0-9][0-9])(([ -])([0-1]?[0-9]|2[0-3]):[0-5]?[0-9]:[0-5]?[0-9])?$/
  }
  readonly property var regExp_email: RegExpValidator {
    regExp: /^.+@.+$/
  }
  readonly property var regExp_userName: RegExpValidator {
    regExp: /^[a-zA-Z0-9_-]{3,16}$/
  }
  readonly property var regExp_ip4Address: RegExpValidator {
    regExp: /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
  }
  readonly property var regExp_ip6Address: RegExpValidator {
    regExp: /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/
  }
  QtObject {
    id: internal
  }
}
