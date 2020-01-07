//
//  LandmarkList.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/11.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct LandmarkList<DetailView: View>: View {
  @EnvironmentObject var userData: UserData
  let detailViewProducer: (Landmark) -> DetailView
  
  var body: some View {
    List {
      Toggle(isOn: $userData.showFavoritesOnly) {
        Text("Favorites only")
      }
      ForEach(userData.landmarks) { landmark in
        if !self.userData.showFavoritesOnly || landmark.isFavorite {
          NavigationLink(destination: self.detailViewProducer(landmark)
            .environmentObject(self.userData)) {
            LandmarkRow(landmark: landmark)
          }
        }
      }
    }
    .navigationBarTitle(Text(/*@START_MENU_TOKEN@*/"Landmarks"/*@END_MENU_TOKEN@*/))
  }
}

#if os(watchOS)
  typealias PreviewDetailView = WatchLandmarkDetail
#else
  typealias PreviewDetailView = LandmarkDetail
#endif

struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
//    NavigationView {
  //    ForEach(["iPhone 8", "iPhone 11 Pro Max"], id: \.self) { deviceName in
      LandmarkList { PreviewDetailView(landmark: $0) }
        .environmentObject(UserData())
  //        .previewDevice(PreviewDevice(rawValue: deviceName))
  //        .previewDisplayName(deviceName)
  //    }
//    }
  }
}
