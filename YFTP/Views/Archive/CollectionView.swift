//
//  CollectionView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import SwiftUI

struct Category: Identifiable {
    var id = UUID()
    var title:String
    var emoji:String
}

let collections: () = CollectionManager.shared.getAll()

struct CollectionView: View {
    @State var categories = [
        Category(title: "Episode IV – A New Hope", emoji: "✅"),
        Category(title: "Episode 1231 – A New Hope", emoji: "⚠️"),
        Category(title: "asda IV – A New Hope", emoji: "🚀"),
    ]
    
    var body: some View {
        HStack(alignment: .center){
           
            ForEach(categories, id: \.id) { category in
                VStack(alignment: .center){
                    CategoryView(title: category.title, emoji: category.emoji)
                }
            }
            Spacer()
        }

//        List {
//            ForEach(categories, id: \.id) { category in
//                Text(category.title)
//            }
//        }
        
        
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
