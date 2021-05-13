//
//  CategoryView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import SwiftUI

struct CategoryDetailView: View {
    var title:String
    var emoji:String
    
    @State private var showView = "CategoryView"
    
    var body: some View {
        VStack(){
              Text("\(emoji)").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/).multilineTextAlignment(.center)
              Text("\(title)").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/).fontWeight(.bold).foregroundColor(Color.black).multilineTextAlignment(.center)
          }
        .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(10)
        .background(Color.white)
        .shadow(radius: 3)
    }
}

//struct CategoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView(title: "Something", emoji: "🚀", messages: Messages)
//    }
//}
