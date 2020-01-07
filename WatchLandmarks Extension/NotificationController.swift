//
//  NotificationController.swift
//  WatchLandmarks Extension
//
//  Created by unrealce on 2019/12/25.
//  Copyright © 2019 huanbing. All rights reserved.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
  var title: String?
  var message: String?
  var landmark: Landmark?
  
  let landmarkIndexKey = "landmarkIndex"
  
  override var body: NotificationView {
    return NotificationView(title: title, message: message, landmark: landmark)
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

  override func didReceive(_ notification: UNNotification) {
    let userData = UserData()
    
    let notificationData = notification.request.content.userInfo
    
    let aps = notificationData["aps"] as? [String: Any]
    let alert = aps?["alert"] as? [String: Any]
    
    title = alert?["title"] as? String
    message = alert?["message"] as? String
    
    if let index = notificationData[landmarkIndexKey] as? Int {
      landmark = userData.landmarks[index]
    }
  }
}
