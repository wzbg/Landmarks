//
//  Landmark.swift
//  Landmarks
//
//  Created by huanbing on 2019/12/10.
//  Copyright © 2019 huanbing. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Landmark: Codable, Identifiable {
  var id: Int
  var name: String
  fileprivate var imageName: String
  fileprivate var coordinates: Coordinates
  var state: String
  var park: String
  var category: Category
  var isFavorite: Bool
  var isFeatured: Bool
  
  var locationCoordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude
    )
  }
  
  var featureImage: Image? {
    guard isFeatured else { return nil }
    return Image(
      ImageStore.loadImage(name: imageName),
      scale: 2,
      label: Text(verbatim: name)
    )
  }
  
  enum Category: String, Codable {
    case Lakes
    case Rivers
    case Mountains
  }
}

extension Landmark {
  var image: Image {
    ImageStore.shared.image(name: imageName)
  }
}

struct Coordinates: Codable {
  var latitude: Double
  var longitude: Double
}
