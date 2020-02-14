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
  
  var body: some View {
    RefreshableList(pullDown: {
      self.numbers.insert(self.randomDoubleArray(3), at: 0)
    }) {
      ForEach(self.numbers, id: \.self) {
        Rectangle()
          .foregroundColor(Color(red: $0[0], green: $0[1], blue: $0[2]))
      }
    }
  }
  
  private func randomDoubleArray(_ count: Int) -> [Double] {
    var array = [Double]()
    for _ in 0 ..< count {
      array.append(Double.random(in: 0 ... 1))
    }
    return array
  }
}

struct RefreshableListDemo_Previews: PreviewProvider {
  static var previews: some View {
    RefreshableListDemo()
  }
}
