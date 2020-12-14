//
//  PreferenceManager.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import Foundation
import UserNotifications

enum NotificationSetting {
    case accepted, denied, notset, loading
    
    static func fromAuthorisationStatus (status : UNAuthorizationStatus) -> NotificationSetting{
        switch (status) {
            case .authorized: return NotificationSetting.accepted
            case .denied : return NotificationSetting.denied
            case .ephemeral: return NotificationSetting.accepted
            case .provisional: return NotificationSetting.accepted
            case .notDetermined: return NotificationSetting.notset
            default: return NotificationSetting.denied
        }
        
    }
}

class PreferenceManager: ObservableObject {
    @Published var notificationSetting : NotificationSetting = .loading
    
    init() {
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            DispatchQueue.main.async {
                self.notificationSetting = NotificationSetting.fromAuthorisationStatus(status: setting.authorizationStatus)
            }
        }
    }
    func requestLocalNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [self] success, _ in
            DispatchQueue.main.async {
                if success {
                    self.notificationSetting = .accepted
                } else {
                    self.notificationSetting = .denied
                }
            }
        }
    }
}

