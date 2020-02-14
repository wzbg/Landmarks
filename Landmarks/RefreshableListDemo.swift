//
//  RefreshableListDemo.swift
//  SwiftUI-Common
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 unrealce. All rights reserved.
//

import SwiftUI

struct RefreshableListDemo: View {
  @State private var numbers = [[Double]]()
  
  @State public var showRefreshView = false
  @State public var offsetY: CGFloat = 0
  
  var body: some View {
    RefreshableList(showRefreshView: $showRefreshView, offsetY: $offsetY, action: {
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

struct RefreshableListDemo_Previews: PreviewProvider {
  static var previews: some View {
    RefreshableListDemo()
  }
}
