//
//  GridView.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/30.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI
import QGrid

struct GridView: View {
  var body: some View {
    QGrid(landmarkData, columns: 3) {
      $0.image
        .resizable()
        .scaledToFit()
    }
  }
}

struct GridView_Previews: PreviewProvider {
  static var previews: some View {
    GridView()
  }
}
