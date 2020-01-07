//
//  Profile.swift
//  Landmarks
//
//  Created by unrealce on 2019/12/24.
//  Copyright © 2019 huanbing. All rights reserved.
//

import Foundation

struct Profile {
  var username: String
  var prefersNotifications: Bool
  var seasonalPhoto: Season
  var goalDate: Date
  
  static let `default` = Self(username: "￠幻冰")
  
  init(username: String, prefersNotifications: Bool = true, seasonalPhoto: Season = .spring) {
    self.username = username
    self.prefersNotifications = prefersNotifications
    self.seasonalPhoto = seasonalPhoto
    self.goalDate = Date()
  }
  
  enum Season: String, CaseIterable {
    case spring = "🌷"
    case summer = "🌞"
    case autumn = "🍂"
    case winter = "☃️"
  }
}
