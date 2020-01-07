//
//  Home.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/23.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
  var categories: [String: [Landmark]] {
    .init(grouping: landmarkData) {
      $0.category.rawValue
    }
  }
  
  var featured: [Landmark] {
    landmarkData.filter { $0.isFavorite }
  }
  
  @State var showingProfile = false
  @EnvironmentObject var userData: UserData
  
  var profileButton: some View {
    Button(action: { self.showingProfile.toggle() }) {
      Image(systemName: "person.crop.circle")
        .imageScale(.large)
        .accessibility(label: Text("User Profile"))
        .padding()
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        FeaturedLandmarks(landmarks: featured)
          .scaledToFill()
          .frame(height: 200)
          .clipped()
          .listRowInsets(EdgeInsets())
        ForEach(categories.keys.sorted(), id: \.self) { key in
          CategoryRow(
            categoryName: key,
            items: self.categories[key]!
          )
        }
        .listRowInsets(EdgeInsets())
        NavigationLink(destination: LandmarkList { LandmarkDetail(landmark: $0) }) {
          Text("See All")
        }
      }
      .navigationBarTitle(Text("Featured"))
      .navigationBarItems(trailing: profileButton)
      .sheet(isPresented: $showingProfile) {
        ProfileHost()
          .environmentObject(self.userData)
      }
    }
  }
  
  struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
      landmarks[0].image.resizable()
    }
  }
}

struct CategoryHome_Previews: PreviewProvider {
  static var previews: some View {
    CategoryHome()
  }
}
