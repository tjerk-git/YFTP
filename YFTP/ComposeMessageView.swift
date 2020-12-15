//
//  SendMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI
import UserNotifications
import Messages
import CoreData



struct ComposeMessageView: View {
    var viewModel : MessageContainerViewModel
    @State var message: String = ""
    var messages : Messages
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                Text("Send a message to yourself into the future")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
    
                TextField("Enter message...", text: $message)
                    .font(.title2)
                    .accentColor(.blue)
                    .foregroundColor(Color.white)
                    .padding(10)
               
                VStack(alignment: .center, content: {
                    Button("🚀 BLAST OFF") {
                        viewModel.messageContainerState = .sending
                        addMessage(body: message)
                    }
                    .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }).frame(maxHeight: .infinity)
         
                Spacer()
            }.padding(.top, 75)
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    func addMessage(body : String) {
        messages.sendMessage(message: body)
    }
}

//
//struct ComposeMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComposeMessageView(viewModel : MessageContainerViewModel())
//    }
//}
