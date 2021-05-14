//
//  Favorites.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 14/05/2021.
//

import SwiftUI

struct Favorites: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Message.entity(), sortDescriptors: [], predicate: NSPredicate(format: "loved == 1")
    ) var archive: FetchedResults<Message>
    
        
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                List {
                    if(archive.count == 0){
                        Text("Add a favorite by double-tapping a message!")
                    }

                    ForEach(archive, id: \.body) {
                        MessageRow(message: $0)
                    }
                }.listRowBackground(Color.black)
                .frame(maxHeight:.infinity)
                Spacer()
            }.padding(.top, 75)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
