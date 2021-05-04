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
    
    var body: some View {
        Button(
            action: {
                // did tap
            },
            label: {
                Text("\(emoji)").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                Text("\(title)").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/).fontWeight(.bold).foregroundColor(Color.black)
            }
        )
        .frame(width: 150, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(10)
        .background(Color.white)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(title: "Something", emoji: "🚀")
    }
}
