//
//  Notifications.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import Foundation
import UserNotifications


let notificationCenter = UNUserNotificationCenter.current()

let options: UNAuthorizationOptions = [.alert, .sound, .badge]
notificationCenter.requestAuthorization(options: options) {
    (didAllow, error) in
    if !didAllow {
        print("User has declined notifications")
    }
}


func scheduleNotification(notificationType: String) {
    
    let content = UNMutableNotificationContent() // Содержимое уведомления
    
    content.title = notificationType
    content.body = "This is example how to create " + notificationType Notifications"
    content.sound = UNNotificationSound.default
    content.badge = 1
}
