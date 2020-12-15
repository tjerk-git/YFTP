//
//  Messages.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import Foundation
import UserNotifications
import CoreData

class Messages : ObservableObject {
    
    @Published public var lastMessage = ""
        
    func sendMessage(message : String) {
        let content = UNMutableNotificationContent()
        content.title = "You from the past:"
        content.subtitle = message
        lastMessage = message
        content.sound = UNNotificationSound.default
        // month in seconds
        // 2629743
        let lower : UInt32 = 120
        let upper : UInt32 = 7200
        let randomNumber = arc4random_uniform(upper - lower) + lower
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(randomNumber), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
