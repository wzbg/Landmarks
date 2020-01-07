//
//  BodyView.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/30.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI
import QGrid

extension String: Identifiable {
  public var id: Int {
    self.hashValue
  }
}

struct BodyView: View {
  let bodies = [
    "bibu",
    "jingbu",
    "jianbu",
    "xiongbu",
    "fubu",
    "beibu",
    "tuibu",
    "yaobu",
    "tunbu",
    "",
    "quanshen",
    "",
  ]
  
  var body: some View {
    QGrid(bodies, columns: 3) {
      Image($0)
    }
  }
}

struct BodyView_Previews: PreviewProvider {
  static var previews: some View {
    BodyView()
  }
}
