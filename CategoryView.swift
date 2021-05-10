//
//  CategoryView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import SwiftUI

struct CategoryView: View {
    var title:String
    var emoji:String
    
    @State var showModal = false
    
    var body: some View {
        Button(
            action: {
                showModal = true
            },
            label: {
                Text("\(emoji)").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/).multilineTextAlignment(.center)
                Text("\(title)").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/).fontWeight(.bold).foregroundColor(Color.black).multilineTextAlignment(.center)
            }
        ).fullScreenCover(isPresented: $showModal, content: {
            ArchiveMessageView(showModal: $showModal)
        })
        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(10)
        .background(Color.white)
        .shadow(radius: 5)
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView(title: "Something", emoji: "🚀", messages: Messages)
//    }
//}
