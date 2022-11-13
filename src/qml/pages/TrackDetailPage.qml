import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import SortFilterProxyModel 0.2

import "../components"
import "../navigations"
import "../soup"

AppPage {
    id: trackDetailPage
    objectName: "TrackDetailsPage"
    title: dataModel.trackingNumber

    JSONListModel {
        id: jsonListModel
        json: JSON.stringify(dataModel.trackingData)
        query: "$[*]"
    }
    SortFilterProxyModel {
        id: sortedModel
        sorters: StringSorter { roleName: "status"; sortOrder: Qt.DescendingOrder }
        // Note: when using JsonListModel, the sorters or filter might not be applied correctly when directly assigning sourceModel
        // use the Component.onCompleted handler instead to initialize SortFilterProxyModel
        Component.onCompleted: sourceModel = jsonListModel.model
    }

    ColumnLayout {
        anchors.fill: parent
        AppListView {
            model: sortedModel
            delegate: SimpleRow {
                titleText: model.status_description
                detailText: model.status_date
                iconSource: logic.getIconStatus(Number(model.status))
                iconColor: logic.getIconColor(Number(model.status))
                badgeValue: model.location
            }

            emptyText.text: qsTr("Tracking item not found.")
        } // AppListView
    } // ColumnLayout
}
