//
//  RotatedBadgeSymbol.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/13.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct RotatedBadgeSymbol: View {
  let angle: Angle
  
  var body: some View {
    BadgeSymbol()
      .padding(-60)
      .rotationEffect(angle, anchor: .bottom)
  }
}

struct RotatedBadgeSymbol_Previews: PreviewProvider {
  static var previews: some View {
    RotatedBadgeSymbol(angle: .init(degrees: 5))
  }
}
