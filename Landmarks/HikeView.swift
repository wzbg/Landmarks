//
//  HikeView.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/20.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

extension AnyTransition {
  static var moveAndFade: AnyTransition {
    .asymmetric(
      insertion: AnyTransition.move(edge: .trailing)
        .combined(with: .opacity),
      removal: AnyTransition.scale
        .combined(with: .opacity))
  }
}

struct HikeView: View {
  var hike: Hike
  @State private var showDetail = true
  
  var body: some View {
    VStack {
      HStack {
        HikeGraph(hike: hike, path: \.elevation)
          .frame(width: 50, height: 30)
          .animation(nil)
        VStack {
          Text(verbatim: hike.name)
            .font(.headline)
          Text(verbatim: hike.distanceText)
        }
        Spacer()
        Button(action: {
          withAnimation {
            self.showDetail.toggle()
          }
        }) {
          Image(systemName: "chevron.right.circle")
            .imageScale(.large)
            .rotationEffect(.degrees(showDetail ? 90 : 0))
            .scaleEffect(showDetail ? 1.5 : 1)
            .padding()
        }
      }
      if showDetail {
        HikeDetail(hike: hike)
          .transition(.moveAndFade)
      }
    }
  }
}

struct HikeView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      HikeView(hike: hikeData[0])
        .padding()
      Spacer()
    }
  }
}
