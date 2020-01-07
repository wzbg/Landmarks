//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/24.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct ProfileSummary: View {
  var profile: Profile
  
  static let goalFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
  }()
  
  var body: some View {
    List {
      Text(profile.username)
        .font(.title)
        .bold()
      Text("Notifications: \(profile.prefersNotifications ? "On" : "Off")")
      Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
      Text("Goal Date: \(profile.goalDate, formatter: Self.goalFormat)")
      VStack(alignment: .leading) {
        Text("Completed Badges")
          .font(.headline)
        ScrollView {
          HStack {
            HikeBadge(name: "First Hike")
            HikeBadge(name: "Earth Day")
              .hueRotation(Angle(degrees: 90))
            HikeBadge(name: "Tenth Hike")
              .hueRotation(Angle(degrees: 45))
              .grayscale(0.5)
          }
        }
      }
      VStack(alignment: .leading) {
        Text("Recent Hikes")
          .font(.headline)
        HikeView(hike: hikeData[0])
      }
    }
  }
}

struct ProfileSummary_Previews: PreviewProvider {
  static var previews: some View {
    ProfileSummary(profile: .default)
  }
}
