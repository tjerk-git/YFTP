//
//  CollectionView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import SwiftUI

struct CollectionView: View {
    
    @State private var showModal = false
    @ObservedObject var collections = CollectionManager.standard
    
    var body: some View {
     
        let columns = [
            GridItem(.fixed(175)),
            GridItem(.flexible()),
        ]
    
        ScrollView {
            Spacer()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(collections.categories, id: \.id) { category in
                    CategoryView(title: category.title, emoji: category.emoji)
                }
            }
            .padding(.horizontal)
            Spacer()
            VStack(){
                Spacer()
                Button(action: {
                    showModal = true
                }){
             
                Image(systemName: "rectangle.stack.fill.badge.plus").font(.largeTitle).foregroundColor(Color("Color"))
                Text("Add category")
                    .fontWeight(.bold)
                    .padding()
                    .overlay(
                        Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                    )
                    .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                
                }.sheet(isPresented: $showModal) {
                     ComposeCategory(showModal: $showModal)
                }
                Spacer()
                
            }
        }
        .frame(maxHeight: .infinity)
        
      

    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
