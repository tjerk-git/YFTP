//
//  CollectionManager.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import Foundation
import CoreData

class CollectionManager : ObservableObject {
    
    static let standard = CollectionManager()
    
    @Published public var categories = [Collection]()
    
    private init(){
        getAll()
    }
    
    func getByUUID(uuid: String){
        
    }
    
    func getAll()  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Collection")

        do {
             let persistenceController = PersistenceController.shared
             let results   = try persistenceController.container.viewContext.fetch(fetchRequest)
             categories = results as! [Collection]
            
        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
        
    }
    
    func addToCoreData(title: String, emoji :String) {
        let persistenceController = PersistenceController.shared
        let category = Collection(context: persistenceController.container.viewContext)

        persistenceController.container.viewContext.performAndWait {
            category.title = title
            category.emoji = emoji
           try? persistenceController.container.viewContext.save()
        }
        
        getAll()
    }
    
    func save() {
        let persistenceController = PersistenceController.shared
        persistenceController.container.viewContext.performAndWait {
           try? persistenceController.container.viewContext.save()
        }
        
        getAll()
        
    }
    
}
