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

    func sendMessage(message : String, sender : String?) {
        let content = UNMutableNotificationContent()
        let persistenceController = PersistenceController.shared
        let defaults = UserDefaults.standard
        
        let name = defaults.string(forKey: "Name") ?? "You from the past"
        content.title = name
        
        // for gift messages
        if ((sender) != nil) {
            content.title = sender ?? "Someone from the past"
        }
        
        content.body = message
        lastMessage = message
        content.sound = UNNotificationSound.default
        let date = Date()
        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        var month = calendar.component(.month, from: date)
        let currentday = calendar.component(.day, from: date)
        let hour = Int.random(in: 8...18)
        let day = Int.random(in: currentday...28)

        // end of the month, go to next month, end of the year? stay in this year.
        if(currentday >= 25 && month != 12){
            month += 1
        }

        let dateComponents = DateComponents(year: year, month: month, day: day, hour: hour, minute: 22)
       // let dateComponents = DateComponents(year: 2021, month: 1, day: 16, hour: 23, minute: 32)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        // add to core data
        let newMessage = Message(context: persistenceController.container.viewContext)

        persistenceController.container.viewContext.performAndWait {
           newMessage.body = message
           newMessage.dateAdded = Date()
           newMessage.id = request.identifier
           try? persistenceController.container.viewContext.save()
        }
        
    }
}
