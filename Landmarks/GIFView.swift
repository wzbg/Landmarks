//
//  GIFView.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/27.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct GIFView: UIViewRepresentable {
  var name: String?
  var asset: String?
  
  init(name: String) {
    self.name = name
  }
  
  init(asset: String) {
    self.asset = asset
  }
  
  func makeUIView(context: Context) -> UIView {
    var image: UIImage?
    if let name = name {
      image = UIImage.gif(name: name)
    }
    if let asset = asset {
      image = UIImage.gif(asset: asset)
    }
    return UIImageView(image: image)
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
  }
}

struct GIFView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      GIFView(asset: "diaochan")
        .previewDisplayName("by asset")
      GIFView(name: "貂蝉")
        .previewDisplayName("by name")
    }
  }
}
