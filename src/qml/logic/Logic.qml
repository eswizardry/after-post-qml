import QtQuick 2.12
import QtQuick.Controls.Material 2.12

Item {
    signal loadTokenData
    signal loadJsonData
    signal loadRecentSearch
    signal clearData
    signal getToken
    signal getItem(var trackNumber)
    signal getItemRetry()
    signal toggleFavorite()
    signal languageChanged(var lang)

    function getIconStatus(status) {
        var retIcon = "fa-truck"

        switch(status) {
        case 101: // เตรียมการฝากส่ง
        case 102: // รับฝากผ่านตัวแทน
        case 103: // รับฝาก
            retIcon = "fa-box"
            break

        case 201: // อยู่ระหว่างการขนส่ง
            break

        case 202: // ดำเนินพิธีการศุลกากร
            break

        case 203: // ส่งคืนต้นทาง
            break

        case 204: // ถึงที่ทำการแลกปลี่ยนระหว่างประเทศขาออก
        case 205: // ถึงที่ทำการแลกปลี่ยนระหว่างประเทศขาเข้า
        case 206: // ถึงที่ทำการไปรษณีย์
            break

        case 207: // เตรียมการขนส่ง
            retIcon = "fa-truck-loading"
            break

        case 301: // อยู่ระหว่างการนำจ่าย
            retIcon = "fa-shipping-fast"
            break

        case 302: // นำจ่าย ณ จุดรับสิ่งของ
          break

        case 401: // นำจ่ายไม่สำเร็จ
            retIcon = "fa-exclamation-circle"
            break

        case 501: // นำจ่ายสำเร็จ
            retIcon = "fa-check-circle"
            break

        default: // not found
            break
        }

        return retIcon
    }

    function getIconColor(status) {
        var retColor = textOnPrimary

        switch(status) {
        case 401: // นำจ่ายไม่สำเร็จ
            retColor = Material.color(Material.Red)
            break
        case 501: // นำจ่ายสำเร็จ
            retColor = Material.color(Material.Green)
            break
        default: // not found
            break
        }
        return retColor
    }
}
