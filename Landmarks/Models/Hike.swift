//
//  Hike.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/20.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI

struct Hike: Codable {
  var name: String
  var id: Int
  var distance: Double
  var difficulty: Int
  var observations: [Observation]
  
  static var formatter = LengthFormatter()
  
  var distanceText: String {
    Self.formatter.string(fromValue: distance, unit: .kilometer)
  }
  
  struct Observation: Codable {
    var distanceFromStart: Double
    var elevation: Range<Double>
    var pace: Range<Double>
    var heartRate: Range<Double>
  }
}
