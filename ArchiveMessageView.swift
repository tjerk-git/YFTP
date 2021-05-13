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
    @Environment(\.editMode) private var editMode
    var collection: Collection
    let collectionManager = CollectionManager.standard
    
    var messages = Messages.standard

    var body: some View {
        VStack(){
            Button("Back"){
                showModal = false
            }
            EditButton()
            List(messages.items, id: \.uuid, selection: $selection) { message in
                Text(message.body )
            }
            .onChange(of: editMode!.wrappedValue, perform: { value in
              if value.isEditing {
                 // Entering edit mode (e.g. 'Edit' tapped)
              } else {
                
                for uuid in selection {
                    let message = messages.getMessage(id: uuid)
                    collection.addToMessages(message)
                    collectionManager.save()
                }
                
                showModal = false
              }
            })
            .navigationTitle("Add messages to category")
        }
        
    }
}
