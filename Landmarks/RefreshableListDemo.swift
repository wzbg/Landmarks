//
//  PullToRefreshView.swift
//  Landmarks
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 huanbing. All rights reserved.
//

import SwiftUI

struct RefreshableListDemo: View {
  @State private var numbers = [Int]()
  
  @State public var showRefreshView: Bool = false
  @State public var pullStatus: CGFloat = 0
  
  var body: some View {
    RefreshableList(showRefreshView: $showRefreshView, pullStatus: $pullStatus, action: {
      self.numbers.insert(Int.random(in: 0 ..< 100), at: 0)
    }) {
      ForEach(self.numbers, id: \.self) {
        Text("\($0)")
      }
    }
  }
}

struct RefreshableListDemo_Previews: PreviewProvider {
  static var previews: some View {
    RefreshableListDemo()
  }
}
