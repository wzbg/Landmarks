//
//  RefreshableNavigationViewDemo.swift
//  Landmarks
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 huanbing. All rights reserved.
//

import SwiftUI

struct RefreshableNavigationViewDemo: View {
  @State private var numbers = [Int]()
  
  var body: some View {
    RefreshableNavigationView(title: "Numbers", action: {
      self.numbers.append(Int.random(in: 0 ..< 100))
    }) {
      ForEach(self.numbers, id: \.self) {
        Text("\($0)")
      }
    }
  }
}

struct RefreshableNavigationViewDemo_Previews: PreviewProvider {
  static var previews: some View {
    RefreshableNavigationViewDemo()
  }
}
