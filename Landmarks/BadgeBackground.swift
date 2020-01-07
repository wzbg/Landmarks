//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/12.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct BadgeBackground: View {
  var body: some View {
    GeometryReader { geometry in
      Path { path in
        let height: CGFloat = min(geometry.size.width, geometry.size.height)
        let xScale: CGFloat = 0.832
        let xOffset = height * (1 - xScale) / 2
        let width = height * xScale
        path.move(
          to: CGPoint(
            x: xOffset + width * 0.95,
            y: height * (0.2 + HexagonParameters.adjustment)
          )
        )
        HexagonParameters.points.forEach {
          path.addLine(
            to: .init(
              x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
              y: height * $0.useHeight.0 * $0.yFactors.0
            )
          )
          path.addQuadCurve(
            to: .init(
              x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
              y: height * $0.useHeight.1 * $0.yFactors.1
            ),
            control: .init(
              x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
              y: height * $0.useHeight.2 * $0.yFactors.2
            )
          )
        }
      }
      .fill(LinearGradient(
        gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
        startPoint: .init(x: 0.5, y: 0),
        endPoint: .init(x: 0.5, y: 0.6)
      ))
      .aspectRatio(1, contentMode: .fit)
    }
  }

  static let gradientStart = Color(red: 239/255, green: 120/255, blue: 221/255)
  static let gradientEnd = Color(red: 239/255, green: 172/255, blue: 120/255)
}

struct BadgeBackground_Previews: PreviewProvider {
  static var previews: some View {
    BadgeBackground()
  }
}
