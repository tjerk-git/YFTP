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
    
    
    func addToCoreData(message: String, identifier: String) {
        let persistenceController = PersistenceController.shared
        // add to core data
        let newMessage = Message(context: persistenceController.container.viewContext)

        persistenceController.container.viewContext.performAndWait {
           newMessage.body = message
           newMessage.dateAdded = Date()
           newMessage.id = identifier
           try? persistenceController.container.viewContext.save()
        }
    }
    
    func sendMessage(message: String, sender: String) {
        var identifier = ""
        identifier = self.setNotificationWithRandomDate(message: message, sender: sender)
        print("random")
        
        self.addToCoreData(message: message, identifier: identifier)
        
        lastMessage = message
    }

    func sendMessageWithDate(message : String, sender : String?, sendDate: Date?) {
        var identifier = ""
        identifier = self.setNotificationWithDate(sendDate: sendDate ?? Date(), message: message, sender: sender ?? "Someone from the past")
        print("with date")
        self.addToCoreData(message: message, identifier: identifier)
        
        lastMessage = message
    }
    
    func setNotificationWithDate(sendDate : Date, message : String , sender : String) -> String {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = sender
        content.body = message
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: sendDate)
        let month = calendar.component(.month, from: sendDate)
        let hour = calendar.component(.hour, from: sendDate)
        let day = calendar.component(.day, from: sendDate)
        let minute = calendar.component(.minute, from: sendDate)
        
        let dateComponents = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        return request.identifier
    }
    
    func setNotificationWithRandomDate(message : String, sender : String) -> String {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = sender
        content.body = message
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        var month = calendar.component(.month, from: date)
        let currentday = calendar.component(.day, from: date)
        let minute = Int.random(in: 8...59)
        let hour = Int.random(in: 8...18)
        let day = Int.random(in: currentday...28)

        // end of the month, go to next month, end of the year? stay in this year.
        if(currentday >= 25 && month != 12){
            month += 1
        }

        let dateComponents = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        return request.identifier
    }
    
//    func getUpcomingNotification() {
//        UNUserNotificationCenter.current().getPendingNotificationRequests {
//            (requests) in
//            var nextTriggerDates: [Date] = []
//
//            print(requests)
//            for request in requests {
//                if let trigger = request.trigger as? UNCalendarNotificationTrigger,
//                    let triggerDate = trigger.nextTriggerDate(){
//                    nextTriggerDates.append(triggerDate)
//                }
//            }
//
//           // print(nextTriggerDates)
//            if let nextTriggerDate = nextTriggerDates.min() {
//               // print(nextTriggerDate)
//            }
//        }
//    }
}
