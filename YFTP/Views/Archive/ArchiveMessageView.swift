//
//  SendMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI
import CoreData



struct ArchiveMessageView: View {
        
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Message.entity(), sortDescriptors: []
    ) var archive: FetchedResults<Message>
    
    var viewModel : MessageContainerViewModel
    var messages : Messages
        
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                List {
                    ForEach(archive, id: \.body) {
                        MessageRow(message: $0)
                    }.onDelete(perform: deleteMessage)
                }.listRowBackground(Color.black)
                .frame(maxHeight:.infinity)
                Spacer()
            }.padding(.top, 75)
            .background(Color.black)
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




//struct ArchiveMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveMessageView(viewModel : MessageContainerViewModel(), messages: Messages())
//    }
//}
