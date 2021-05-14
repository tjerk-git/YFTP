//
//  AllMessages.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 14/05/2021.
//

import SwiftUI

struct AllMessages: View {
       @Environment(\.managedObjectContext) var managedObjectContext
       @FetchRequest(
           entity: Message.entity(), sortDescriptors: []
       ) var archive: FetchedResults<Message>
       
           
       var body: some View {
           HStack() {
               VStack(alignment: .leading, spacing: 20) {
                   List {
                        if(archive.count == 0){
                            Text("No messages yet!")
                        }
                       ForEach(archive, id: \.body) {
                           MessageRow(message: $0)
                       }.onDelete(perform: deleteMessage)
                   }.listRowBackground(Color.black)
                   .frame(maxHeight:.infinity)
                   Spacer()
               }.padding(.top, 75)
           }
           .edgesIgnoringSafeArea(.all)
       }
       
       func deleteMessage(at offsets: IndexSet) {
         offsets.forEach { index in
           let message = self.archive[index]
           self.managedObjectContext.delete(message)
         }
         saveContext()
       }
       

       func saveContext() {
         do {
           try managedObjectContext.save()
         } catch {
           print("Error saving managed object context: \(error)")
         }
       }
}
//
//struct AllMessages_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMessages()
//    }
//}
