//
//  UserData.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/12.
//  Copyright © 2019 huanbing. All rights reserved.
//

import Combine

final class UserData: ObservableObject {
  @Published var showFavoritesOnly = false
  @Published var landmarks = landmarkData
  @Published var profile = Profile.default
}
