//
//  ImageUIView.swift
//  WatchLandmarks Extension
//
//  Created by unrealce on 2019/12/27.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct ImageUIView: View {
  var body: some View {
    List {
      ForEach(UIImage.gif(name: "貂蝉")!.images!, id: \.self) {
        Image(uiImage: $0)
          .resizable()
      }
      .scaledToFit()
    }
  }
}

struct ImageUIView_Previews: PreviewProvider {
  static var previews: some View {
    ImageUIView()
  }
}
