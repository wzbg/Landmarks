//
//  NotificationView.swift
//  WatchLandmarks Extension
//
//  Created by unrealce on 2019/12/25.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
  let title: String?
  let message: String?
  let landmark: Landmark?
  
  init(title: String? = nil, message: String? = nil, landmark: Landmark? = nil) {
    self.title = title
    self.message = message
    self.landmark = landmark
  }
  
  var body: some View {
    VStack {
      if landmark != nil {
        CircleImage(image: landmark!.image.resizable())
          .scaledToFit()
      }
      Text(title ?? "未知地标")
        .font(.headline)
        .lineLimit(0)
      Divider()
      Text(message ?? "您在喜欢的地标5公里范围内")
        .font(.caption)
        .lineLimit(0)
    }
  }
}

struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NotificationView()
      NotificationView(
        title: "东方明珠",
        message: "您在东方明珠的5公里范围内",
        landmark: UserData().landmarks[0]
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
