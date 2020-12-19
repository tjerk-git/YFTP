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
    @State private var showingAlert = false
    
    var messages : Messages
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                Text("Send a message to yourself into the future")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                ZStack(alignment: .leading) {
                      if message.isEmpty { Text("Enter message...").foregroundColor(.white).padding(10) }
                        TextField("", text: $message)
                            .font(.title2)
                            .accentColor(.blue)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                  }
      
                VStack(alignment: .center, content: {
                    Button("Show sent messages") {
                        viewModel.messageContainerState = .archive
                    }.frame(width: .infinity, height:50, alignment: .center)
                    .font(.footnote)
                    Spacer()
                    ZStack {
                        Button("🚀 BLAST OFF") {
                            if !message.isEmpty {
                                viewModel.messageContainerState = .sending
                                addMessage(body: message)
                            } else {
                                self.showingAlert = true
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 75, alignment: .center)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(30)
                        .alert(isPresented: $showingAlert, content: {
                            Alert(title: Text("Please fill in a message"), message: Text("Message can't be empty!"), dismissButton: .default(Text("Sorry, jeez")))
                        })
                    }
                
           
                }).frame(maxHeight: .infinity)
         
                Spacer()
            }.padding(.top, 75)
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            let keyWindow = UIApplication.shared.connectedScenes
                               .filter({$0.activationState == .foregroundActive})
                               .map({$0 as? UIWindowScene})
                               .compactMap({$0})
                               .first?.windows
                               .filter({$0.isKeyWindow}).first
            keyWindow!.endEditing(true)
        }
    }
    
    func addMessage(body : String) {
        messages.sendMessage(message: body)
    }
}

//
//struct ComposeMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComposeMessageView(viewModel : MessageContainerViewModel(), messages: Messages())
//    }
//}
