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
    @State private var showView = "CategoryDetailView"
    @State var selectedCollection = Collection()
    
    var body: some View {
     
        let columns = [
            GridItem(.fixed(175)),
            GridItem(.flexible()),
        ]
        
        switch showView {
            case "CategoryDetailView":
                ScrollView {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(collections.categories, id: \.id) { category in
                            CategoryDetailView(title: category.title ?? "", emoji: category.emoji ?? "").onTapGesture {
                                    showView = "CategoryView"
                                    selectedCollection = category
                                }
                        }
                    }.padding(.horizontal)
            

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
        case "CategoryView":
            VStack(){
                CategoryView(collection: selectedCollection)
                Button(action: {
                    showView = "CategoryDetailView"
                }){
                    Text("Back")
                        .fontWeight(.bold)
                        .padding()
                        .overlay(
                            Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                        )
                        .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                }
            }
    
        default:
            Text("something")
        }
    }
}

//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView(, selectedCategory: Category)
//    }
//}
