import QtQuick 2.12
import Qt.labs.settings 1.0

import "../logic"

Item {
    id: dataModel

    // property to configure target dispatcher / logic
    property alias dispatcher: logicConnection.target

    //true when there is data being loaded in the background
    readonly property bool loading: client.loading
    readonly property alias trackingData: _.trackingData
    readonly property alias trackingNumber: _.trackingNumber
    readonly property alias appLanguage: _.appLanguage
    readonly property alias favoriteListingsValues: _.favoriteListingsValues

    //called when a page of listings has been received from the server
    signal trackItemReceived

    signal loadJsonDataFailed(string error)

    Connections {
        id: logicConnection

        onLoadTokenData: {
            _.loadTokenFromStorage()
            let tokenExpireMsec = Date.parse(_.expire)
            let currentDate = new Date()
            let currentMsec = currentDate.getTime()

            if (currentMsec >= tokenExpireMsec) {
                console.debug("Requesting new token from server")
                logic.getToken()
            }
        }

        onClearData: {
            // Reset all data stored in the model and the cache
            _.setModelData(false, "", undefined, undefined, "", "", false)
        }

        onGetToken: {
            client.getToken(_.responseTokenCallback)
        }

        onGetItem: {
            _.trackingNumber = trackNumber
            client.getItem(_.responseItemCallback, _.token, _.searchLanguage, _.trackingNumber)
        }

        onGetItemRetry: {
            client.getItem(_.responseItemCallback, _.token, _.searchLanguage, _.trackingNumber)
        }

        onLoadRecentSearch: {
            _.loadRecentTrackingData()
        }

        onToggleFavorite: {
            var index = _.isFavorite()
            if (index < 0) {
                console.debug("Adding favorite...")
                _.favoriteListingsValues.push(_.favoriteItem) // add entry to favorites
            } else {
                console.debug("Remove favorite...")
                _.favoriteListingsValues.splice(index, 1)  // remove entry in favorites
            }

            _.saveFavorite()
            _.favoriteListingsValuesChanged()
        }

        onLanguageChanged: {
            console.debug("Language changed to", lang)
            localStorage.setValue("appLanguage", lang)
            _.loadAppSettings()
        }
    }

    function isFavorite() {
        _.isFavorite()
        return _.isFavorite() >= 0
    }

    Client {
        id: client
    }

    Settings {
        id: localStorage
        Component.onCompleted: {
            // After the storage has been initialized, check if any data is cached.
            // If yes, load it into our model.
            _.loadAppSettings()
            _.loadTokenFromStorage()
            _.loadRecentTrackingData()
        }
    }

    // private
    Item {
        id: _
        property string token: ""
        property string expire: ""
        property string trackingNumber: ""
        property string appLanguage: "th"
        property string searchLanguage: "TH"

        property var trackingData: []
        property var listingData: []
        property var favoriteItem: []
        property var favoriteListingsValues: []

        function saveFavorite() {
            localStorage.setValue("favoriteListingsValues", _.favoriteListingsValues)
        }

        function isFavorite() {
            favoriteItem = null

            if (_.trackingData.length == 0)
                return -1

            var lastStatus = _.trackingData[_.trackingData.length - 1]
            var  listData = {
                "id": lastStatus.barcode,
                "status_date": lastStatus.status_date,
                "location": lastStatus.location,
                "status_description": lastStatus.status_description,
                "status": lastStatus.status,
                "signature": lastStatus.signature
            }

            favoriteItem = listData

            for (var index in _.favoriteListingsValues) {
                if (_.favoriteListingsValues[index] === null) {
                    _.favoriteListingsValues.splice(index, 1)
                } else {
                    var id = _.favoriteListingsValues[index].id
                    if (id === listData.id)
                        return index
                }
            }

            return -1
        }

        function responseTokenCallback(obj) {
            console.debug("Get token and save to storage...")
            _.token = obj.token
            _.expire = obj.expire
            localStorage.setValue("token", _.token)
            localStorage.setValue("expire", _.expire)
        }

        function loadTokenFromStorage() {
            console.debug("Loading token from storage...")
            var savedExpire = localStorage.value("expire", null)
            var savedToken = localStorage.value("token", null)
            if (savedExpire) {
                console.debug("Found data in cache!")
                console.debug("Token: ", savedToken)
                console.debug("Expire: ", savedExpire)
                _.token = savedToken
                _.expire = savedExpire
            } else {
                _.expire = "1970-01-01 00:00:00+07:00" // set to January 1, 1970
            }
        }

        function loadRecentTrackingData() {
//            localStorage.setValue("favoriteListingsValues", [])
            console.debug("Loading recent data from storage...")
            var savedTrackNumber = localStorage.value("trackingNumber", null)
            if (savedTrackNumber) {
                console.debug("Found recent data in cache!")
                _.trackingNumber = savedTrackNumber
                _.trackingData = localStorage.value("trackingData", null)
            } else {
                _.trackingNumber = ""
                _.trackingData = []
            }

            var savedFavorite = localStorage.value("favoriteListingsValues", null)
            if (savedFavorite) {
                console.debug("Found favorite data in cache!")
                _.favoriteListingsValues = savedFavorite
            } else {
                _.favoriteListingsValues = []
            }
        }

        function loadAppSettings() {
            console.debug("Loading settings data from storage...")
            appLanguage = localStorage.value("appLanguage", "th")
            __appTranslator.selectLanguage(appLanguage)

            if (appLanguage === "th")
                _.searchLanguage = "TH"
            else if (appLanguage === "cn")
                _.searchLanguage = "CN"
            else
                _.searchLanguage = "EN"
        }

        function responseItemCallback(obj) {
            console.debug("Get item...")
            console.debug("Status: ", JSON.stringify(obj.status))
            console.debug("Message: ", JSON.stringify(obj.message))

            let response = obj.response
            console.debug("Track count: ", JSON.stringify(response.track_count))

            _.trackingData = response.items[_.trackingNumber]
            console.debug("Track data: ", _.trackingData)

            // check and update favorite data to latest status
            var index = _.isFavorite()
            if (index >= 0) {
                console.debug("Updating data in favorite list...")
                _.favoriteListingsValues[index] = _.favoriteItem
                _.saveFavorite()
                _.favoriteListingsValuesChanged()
            }

            // signal to search page
            trackItemReceived()

            // save recent search to storage
            localStorage.setValue("trackingNumber", _.trackingNumber)
            localStorage.setValue("trackingData", _.trackingData)
        }
    } // private
}
