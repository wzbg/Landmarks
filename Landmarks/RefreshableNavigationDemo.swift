//
//  RefreshableNavigationDemo.swift
//  SwiftUI-Common
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 unrealce. All rights reserved.
//

import SwiftUI

struct RefreshableNavigationDemo: View {
  @State private var numbers = [[Double]]()
  
  var body: some View {
    RefreshableNavigationView(title: "Colors", action: {
      self.numbers.insert(
        [self.randomDouble(), self.randomDouble(), self.randomDouble()],
        at: 0
      )
    }) {
      ForEach(self.numbers, id: \.self) {
        Rectangle()
          .foregroundColor(Color(red: $0[0], green: $0[1], blue: $0[2]))
      }
    }
  }
  
  private func randomDouble() -> Double {
    Double.random(in: 0 ... 1)
  }
}

struct RefreshableNavigationDemo_Previews: PreviewProvider {
  static var previews: some View {
    RefreshableNavigationDemo()
  }
}
