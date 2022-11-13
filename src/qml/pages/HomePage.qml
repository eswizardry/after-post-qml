import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import SortFilterProxyModel 0.2

import "../components"
import "../popups"
import "../soup"

AppPage {
    objectName: "HomePage"
    title: "After Post"
    topPadding: 6

    JSONListModel {
        id: jsonListModel
        json: JSON.stringify(dataModel.favoriteListingsValues)
        query: "$[*]"
    }
    SortFilterProxyModel {
        id: sortedModel
        sorters: StringSorter { roleName: "status_date"; sortOrder: Qt.DescendingOrder }
        // Note: when using JsonListModel, the sorters or filter might not be applied correctly when directly assigning sourceModel
        // use the Component.onCompleted handler instead to initialize SortFilterProxyModel
        Component.onCompleted: sourceModel = jsonListModel.model
    }

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: searchBar.height
            color: "transparent"
            SearchTextPane {
                id: searchBar
                searchTextField.placeholderText: qsTr("Enter tracking number...")
                Component.onCompleted: logic.loadTokenData()

                searchTextField.onAccepted: {
                    if (currentSearchText === "")
                        return

                    console.debug("Search for: ", currentSearchText)
                    logic.loadTokenData()
                    logic.getItem(currentSearchText.toUpperCase())
                }
            }
        }

        AppListView {
            model: sortedModel
            delegate: SimpleRow {
                titleText: model.id
                detailText: model.status_date
                iconSource: logic.getIconStatus(Number(model.status))
                iconColor: logic.getIconColor(Number(model.status))
                badgeValue: model.status_description

                onClicked: {
                    logic.loadTokenData()
                    logic.getItem(titleText)
                }
            }

            emptyText.text: qsTr("No recent searches.")
        }
    } // ColumnLayout


    Connections {
        target: dataModel
        onTrackItemReceived: {
            showDetails()
        }
    }

    Connections {
        target: navStack
        onDepthChanged: {
            if (navStack.depth === 1) {
                // this is only required for HomePage with "activationPolicy.IMMEDIATELY"
                currentTitle = title
                console.debug("Search page loaded...")
            }
        }
    }

    Component {
        id: detailsPageComponent
        TrackDetailPage { }
    }

    function showDetails() {
        if (navStack.depth === 1) {
            console.debug("Push Detail page...")
            navStack.push(detailsPageComponent)
        }
    }
}
