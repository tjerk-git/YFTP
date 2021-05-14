//
//  CategoryView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/05/2021.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    @State private var showModal = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var collection : Collection
    var messages = Messages.standard
    var collectionManager = CollectionManager.standard
    @State private var showingAlert = false
    
    var body: some View {
        VStack(){
            VStack(){
                Button(action: {
                    showModal = true
                }){
             
                Image(systemName: "plus").font(.largeTitle).foregroundColor(Color("Color"))
                }.sheet(isPresented: $showModal) {
                    ArchiveMessageView(showModal: $showModal, collection: collection)
                }
                
                Text(collection.title ?? "").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/).multilineTextAlignment(.center)
                Text(collection.emoji ?? "").font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/).multilineTextAlignment(.center)
                
            }

            List{
                ForEach(Array(collection.messages as? Set<Message> ?? []), id: \.body){ message in
                    MessageRow(message: message)
                }
            }

            Spacer()
            VStack(){
                Spacer()
                Button("Delete collection") {
                        showingAlert = true
                    }
                .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/).foregroundColor(Color.red)
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete this?"),
                        message: Text("There is no undo"),
                        primaryButton: .destructive(Text("Delete")) {
                            self.managedObjectContext.delete(collection)
                            do{ try self.managedObjectContext.save()}
                            catch{
                            // nonting
                            }
                            collectionManager.getAll()
                            
                        },
                        secondaryButton: .cancel()
                    )
                }
            }

        }
    }
}


//
//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView(Collection())
//    }
//}
