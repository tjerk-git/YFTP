//
//  CollectionManager.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import Foundation
import CoreData

struct Category: Identifiable {
    var id = UUID()
    var title:String
    var emoji:String
}


class CollectionManager : ObservableObject {
    
    static let standard = CollectionManager()
    
    @Published public var categories = [Category]()
    
    private init(){
        categories = getAll()
    }
    
    func getByUUID(uuid: String){
        
    }
    
    func getAll() -> [Category]  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Collection")
        var items: [Category] = []

        do {
             let persistenceController = PersistenceController.shared
             let results   = try persistenceController.container.viewContext.fetch(fetchRequest)
             let categories = results as! [Collection]
                
             for category in categories {
                items.append(
                    Category(
                        title: category.title ?? "Example",
                        emoji: category.emoji ?? "⚠️"
                    ))
             }

        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
        
        return items
    }
    
    func addToCoreData(title: String, emoji :String) {
        let persistenceController = PersistenceController.shared
        let category = Collection(context: persistenceController.container.viewContext)

        persistenceController.container.viewContext.performAndWait {
            category.title = title
            category.emoji = emoji
           try? persistenceController.container.viewContext.save()
        }
        
        categories = getAll()
        
    }
    
    
}
