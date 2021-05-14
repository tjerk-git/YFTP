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
    @Environment(\.managedObjectContext) var managedObjectContext
    
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
                        
                       HStack(){
                           VStack(){
                            Image(systemName: "heart.fill").foregroundColor(Color.red)
                                 Text("Favorites").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/).fontWeight(.bold).foregroundColor(Color.black).multilineTextAlignment(.center)
                             }
                           .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                           .padding(10)
                           .background(Color.white)
                           .shadow(radius: 3)
                       }.background(Color.white).onTapGesture {
                        showView = "Favorites"
                       }
                        
                        HStack(){
                            VStack(){
                                  Image(systemName: "mail.stack.fill")
                                  Text("All messages").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/).fontWeight(.bold).foregroundColor(Color.black).multilineTextAlignment(.center)
                              }
                            .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(10)
                            .background(Color.white)
                            .shadow(radius: 3)
                        }.background(Color.white).onTapGesture {
                         showView = "AllMessages"
                        }
                         
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
                 
                    Text("Create collection")
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
                    Text("Back to collections")
                        .fontWeight(.bold)
                        .padding()
                        .overlay(
                            Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                        )
                        .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }
    
        case "AllMessages":
            VStack(){
                AllMessages()
                Button(action: {
                    showView = "CategoryDetailView"
                }){
                    Text("Back to collections")
                        .fontWeight(.bold)
                        .padding()
                        .overlay(
                            Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                        )
                        .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }
        
        case "Favorites":
            VStack(){
                Favorites()
                Button(action: {
                    showView = "CategoryDetailView"
                }){
                    Text("Back to collections")
                        .fontWeight(.bold)
                        .padding()
                        .overlay(
                            Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                        )
                        .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                }
                Spacer()
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
