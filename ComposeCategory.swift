//
//  ComposeCategory.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/05/2021.
//

import SwiftUI

struct ComposeCategory: View {
    @State var text = ""
    @State var emoji = ""
    @Binding var showModal: Bool
    
    var collections = CollectionManager.standard
    
    var body: some View {

        VStack(){
            Form(){
                TextField("Name", text: $text)
                TextField("Emoji", text: $emoji)
            }

            Button(action: {
                collections.addToCoreData(title: text, emoji: emoji)
                showModal = false
            }){
            Text("Save category")
                .fontWeight(.bold)
                .padding()
                .overlay(
                    Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                )
                .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
            }
        }
       
    }
}

//struct ComposeCategory_Previews: PreviewProvider {
//    static var previews: some View {
//        ComposeCategory( showModal: Binding false)
//    }
//}
