//
//  WatchLandmarkDetail.swift
//  WatchLandmarks Extension
//
//  Created by unrealce on 2019/12/25.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct WatchLandmarkDetail: View {
  @EnvironmentObject var userData: UserData
  var landmark: Landmark
  
  var landmarkIndex: Int {
    userData.landmarks.firstIndex { $0.id == landmark.id }!
  }
  
  var body: some View {
    ScrollView {
      VStack {
        CircleImage(image: landmark.image.resizable())
          .scaledToFit()
        Text(landmark.name)
          .font(.headline)
          .lineLimit(0)
        Toggle(isOn: $userData.landmarks[landmarkIndex].isFavorite) {
          Text("Favorite")
        }
        Divider()
        Text(landmark.park)
          .font(.caption)
          .bold()
          .lineLimit(0)
        Text(landmark.state)
          .font(.caption)
        Divider()
        WatchMapView(landmark: landmark)
          .scaledToFit()
          .padding()
      }
      .padding(16)
    }
    .navigationBarTitle("Landmarks")
  }
}

struct WatchLandmarkDetail_Previews: PreviewProvider {
  static var previews: some View {
    let userData = UserData()
    return Group {
      WatchLandmarkDetail(landmark: userData.landmarks[0])
        .environmentObject(userData)
        .previewDevice("Apple Watch Series 4 - 44mm")
      WatchLandmarkDetail(landmark: userData.landmarks[1])
        .environmentObject(userData)
        .previewDevice("Apple Watch Series 2 - 38mm")
    }
  }
}
