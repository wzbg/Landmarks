//
//  NavigationUIView.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/30.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct NavUIView: View {
  var body: some View {
    NavigationView {
      NavigationLink(destination: GridView()) {
        Text("GridView")
          .navigationBarTitle(
            Text("Title"),
            displayMode: .inline
          )
          .navigationBarItems(
            leading: Text("Leading"),
            trailing: Text("Trailing"
          )
        )
      }
    }
  }
}

struct NavUIView_Previews: PreviewProvider {
  static var previews: some View {
    NavUIView()
  }
}
