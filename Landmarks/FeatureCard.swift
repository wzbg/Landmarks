//
//  FeatureCard.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/25.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct FeatureCard: View {
  var landmark: Landmark
  
  var body: some View {
    landmark.featureImage?
      .resizable()
      .aspectRatio(3 / 2, contentMode: .fit)
      .overlay(TextOverlay(landmark: landmark))
  }
}

struct TextOverlay: View {
  var landmark: Landmark
  
  var gradient: LinearGradient {
    LinearGradient(
      gradient: Gradient(
        colors: [
          Color.black.opacity(0.6),
          Color.black.opacity(0)
      ]),
      startPoint: .bottom,
      endPoint: .center
    )
  }
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      Rectangle().fill(gradient)
      VStack(alignment: .leading) {
        Text(landmark.name)
          .font(.title)
          .bold()
        Text(landmark.park)
      }
      .padding()
    }
    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
  }
}

struct FeatureCard_Previews: PreviewProvider {
  static var previews: some View {
    FeatureCard(landmark: features[0])
  }
}
