//
//  ImageUIView.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/26.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct ImageUIView: View {
  var body: some View {
    GIFView(name: "貂蝉")
      .scaledToFit()
  }
}

struct ImageUIView_Previews: PreviewProvider {
  static var previews: some View {
    ImageUIView()
  }
}
