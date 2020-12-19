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
//    @Published public var archive = []
//    
//    init(){
//        // load latest messages
//        let persistenceController = PersistenceController.shared
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
//            request.returnsObjectsAsFaults = false
//            do {
//                let result = try persistenceController.container.viewContext.fetch(request)
//                for data in result as! [NSManagedObject] {
//                    archive.append(data.value(forKey: "body") ?? "")
//                   //print(data.value(forKey: "body") as! String)
//              }
//
//            } catch {
//                print("Failed")
//            }
//    }
//
    func sendMessage(message : String) {
        let content = UNMutableNotificationContent()
        let persistenceController = PersistenceController.shared
        
        content.title = "You from the past:"
        content.subtitle = message
        lastMessage = message
        content.sound = UNNotificationSound.default
        // month in seconds
        // 2629743
        let lower : UInt32 = 120
        // set to two weeks for now
        let upper : UInt32 = 1209600
        let randomNumber = arc4random_uniform(upper - lower) + lower
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(randomNumber), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        // add to core data
        let newMessage = Message(context: persistenceController.container.viewContext)

        persistenceController.container.viewContext.performAndWait {
           newMessage.body = message
           try? persistenceController.container.viewContext.save()
        }
        
    }
}
