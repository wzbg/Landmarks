//
//  ContentView.swift
//  WatchLandmarks Extension
//
//  Created by unrealce on 2019/12/26.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    LandmarkList { WatchLandmarkDetail(landmark: $0) }
      .environmentObject(UserData())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
