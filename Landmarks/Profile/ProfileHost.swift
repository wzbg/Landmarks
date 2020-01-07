//
//  ProfileHost.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/24.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
  @Environment(\.editMode) var mode
  @EnvironmentObject var userData: UserData
  @State var draftProfile = Profile.default
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        if mode?.wrappedValue == .active {
          Button("Cancel") {
            self.draftProfile = self.userData.profile
            self.mode?.animation().wrappedValue = .inactive
          }
        }
        Spacer()
        EditButton()
      }
      if mode?.wrappedValue == .inactive {
        ProfileSummary(profile: draftProfile)
      } else {
        ProfileEditor(profile: $draftProfile)
          .onAppear {
            self.draftProfile = self.userData.profile
          }
          .onDisappear {
            self.userData.profile = self.draftProfile
          }
      }
    }
    .padding()
  }
}

struct ProfileHost_Previews: PreviewProvider {
  static var previews: some View {
    ProfileHost()
  }
}
