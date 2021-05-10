//
//  SendMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI
import CoreData

struct ArchiveMessageView: View {
    @Binding var showModal: Bool
    @State private var selection = Set<String>()
    var messages = Messages.standard

    var body: some View {
        VStack(){
            Button("Back"){
                showModal = false
            }
            Button("save") {
                messages.addMessagesToCollection(selection: selection)
            }
            EditButton()
            List(messages.items, id: \.id, selection: $selection) { message in
                Text(message.body )
            }
            .navigationTitle("Add messages to category")
        }
    
        
        
//        HStack() {
//            VStack(alignment: .leading, spacing: 20) {
//                List {
//                    ForEach(archive, id: \.body) {
//                        MessageRow(message: $0)
//                    }.onDelete(perform: deleteMessage)
//                }.listRowBackground(Color.black)
//                .frame(maxHeight:.infinity)
//                Spacer()
//            }.padding(.top, 75)
//        }
//        .edgesIgnoringSafeArea(.all)
    }

//    func deleteMessage(at offsets: IndexSet) {
//      offsets.forEach { index in
//        let message = self.archive[index]
//        self.managedObjectContext.delete(message)
//      }
//      saveContext()
//    }
//
//
//    func saveContext() {
//      do {
//        try managedObjectContext.save()
//      } catch {
//        print("Error saving managed object context: \(error)")
//      }
//    }
//
}

//
//struct ArchiveMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveMessageView()
//    }
//}
