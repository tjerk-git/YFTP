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
    
    var collection : Collection
    
    var body: some View {
        VStack(){
            
            Text(collection.title ?? "")
            Text(collection.emoji ?? "")
            
            ForEach(Array(collection.messages as? Set<Message> ?? []), id: \.self){ message in
                Text("\(message.body ?? "")" )
            }

            Button(action: {
                showModal = true
            }){
         
            Image(systemName: "rectangle.stack.fill.badge.plus").font(.largeTitle).foregroundColor(Color("Color"))
            Text("Add messages")
                .fontWeight(.bold)
                .padding()
                .overlay(
                    Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                )
                .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
            
            }.sheet(isPresented: $showModal) {
                ArchiveMessageView(showModal: $showModal, collection: collection)
            }
        }
    }
}

//
//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
