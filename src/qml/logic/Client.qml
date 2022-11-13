import QtQuick 2.12

Item {
    readonly property bool loading: _.httpNetworkActivityIndicator
    property int retryCount: 0

    Component.onCompleted: {
        _.httpNetworkActivityIndicator = false
    }

    function getToken(callback) {
        let token = "AoZ-X1CvHoI:K0I%DmFwL;W@QbGMZ1XzRAHMxZBCdR%QMNoYoI!P@FXK3TDNET.URT0CEElK/HsN3J2JIH&TZLaGMVgWYM3TyEr"
        _.request('POST', "authenticate/token", null, token, callback)
    }

    function getItem(callback, token, lang, trackNumber) {
        var entry = {
            status: 'all',
            language: lang,
            barcode: [trackNumber]
        }
        _.request('POST', 'track', entry, token, callback)
    }

    // private members
    Item {
        id: _
        property bool httpNetworkActivityIndicator
        readonly property string baseUrl: "https://trackapi.thailandpost.co.th/post/api/v1"

        function request(verb, endpoint, jsonObj, token, callback) {
            console.debug('request: ' + verb + ' ' + baseUrl + (endpoint?'/' + endpoint:''))
            httpNetworkActivityIndicator = true

            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                console.debug('xhr: on ready state change: ' + xhr.readyState)

                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var content = xhr.responseText
                    var status = xhr.status
                    httpNetworkActivityIndicator = false

                    try {
                        var obj = JSON.parse(content)
                    } catch (ex) {
                        console.error("Could not parse server response as JSON:", ex)
                        console.debug("Response status :", status)
                        console.debug("Response Text :", content)

                        if (retryCount < 1) {
                          retryCount++
                          logic.getItemRetry()
                        }
                        return
                    }

                    if (status === 200) {
                        console.debug("Successfully parsed JSON response")
                        retryCount = 0
                        callback(obj)
                    } else {
                        console.error("Failed: " + status + " / " + content)
                    }
                }
            }

            xhr.open(verb, baseUrl + (endpoint?'/' + endpoint:''));
            if (token) {
                xhr.setRequestHeader('Authorization', 'Token ' + token);
            }
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.setRequestHeader('Accept', 'application/json');
            var data = jsonObj ? JSON.stringify(jsonObj) : ''
            xhr.send(data)
        } // request
    }
}

