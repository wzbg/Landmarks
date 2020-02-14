//
//  RefreshableListDemo.swift
//  SwiftUI-Common
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 unrealce. All rights reserved.
//

import SwiftUI

struct RefreshableListDemo: View {
  @State private var colors = [Color]()
  
  var body: some View {
    RefreshableList(
      pullUpText: ("上拉可以加载更多", "正在加载更多数据..."),
      pullDownText: ("下拉可以刷新数据", "正在刷新数据中..."),
      pullUp: {
        self.colors.append(self.randomColor())
      }
      ,
      pullDown: {
        self.colors.insert(self.randomColor(), at: 0)
      }
    ) {
      ForEach(self.colors, id: \.self) {
        Rectangle()
          .foregroundColor($0)
      }
    }
  }
  
  private func randomColor() -> Color {
    Color(red: randomDouble(), green: randomDouble(), blue: randomDouble())
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
