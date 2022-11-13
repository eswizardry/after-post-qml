// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12

// special Loader to load Destinations:
// Pages, Panes, StackView, SwipeView, TabBar
// loaded from Navigation at root: Bottom/Side Navigation or Drawer
Loader {
  id: pageLoader
  property int pageActivationPolicy: modelData.a_p
  active: pageActivationPolicy === activationPolicy.IMMEDIATELY
  // Loader itself is invisible - Item will be pushed on stack
  // or used by SwipeView
  visible: false
  source: modelData.source

  onLoaded: {
    if (pageActivationPolicy !== activationPolicy.IMMEDIATELY) {
      drawerNavStack.replaceDestination(pageLoader)
    }
  }

  Component.onCompleted: {
    console.log("CREATED DESTINATION " + index)
  }
}
