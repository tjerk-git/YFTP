//
//  SendMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI
import CoreData



struct ArchiveMessageView: View {
        
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Message.entity(), sortDescriptors: []
    ) var archive: FetchedResults<Message>
    
    var viewModel : MessageContainerViewModel
    var messages : Messages
        
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                List {
                    ForEach(archive, id: \.body) {
                        MessageRow(message: $0)
                    }
                }.listRowBackground(Color.black)
                .frame(maxHeight:.infinity)
                                
                VStack(alignment: .center, content: {
                    Spacer()
                    Button("Lets go back") {
                        viewModel.messageContainerState = .composing
                    }
                    .frame(width:200, height:75, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(30)

                }).frame(maxWidth: .infinity, maxHeight: 100)
         
                Spacer()
            }.padding(.top, 75)
            .background(Color.black)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
struct ArchiveMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveMessageView(viewModel : MessageContainerViewModel(), messages: Messages())
    }
}
