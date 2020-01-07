//
//  WatchMapView.swift
//  WatchLandmarks Extension
//
//  Created by unrealce on 2019/12/26.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct WatchMapView: WKInterfaceObjectRepresentable {
  var landmark: Landmark
  
  func makeWKInterfaceObject(
    context: WKInterfaceObjectRepresentableContext<WatchMapView>
  ) -> WKInterfaceMap {
    WKInterfaceMap()
  }
  
  func updateWKInterfaceObject(
    _ map: WKInterfaceMap,
    context: WKInterfaceObjectRepresentableContext<WatchMapView>) {
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: landmark.locationCoordinate, span: span)
    map.setRegion(region)
  }
}

struct WatchMapView_Previews: PreviewProvider {
  static var previews: some View {
    WatchMapView(landmark: UserData().landmarks[0])
  }
}
