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
import AVFoundation


struct ComposeMessageView: View {
    @State var message: String = ""
    @State private var showingAlert = false
    var viewModel : MessageContainerViewModel
    var messages : Messages
    
    var body: some View {

        HStack() {

        TextEditor(text: $message)
            .background(Color.white)
            .foregroundColor(Color.white)
            .opacity(0.6)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(15)

            Button("🚀 BLAST OFF") {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                if !message.isEmpty {
                    viewModel.messageContainerState = .sending
                    addMessage(body: message)
                } else {
                    self.showingAlert = true
                }
            }.frame(maxWidth: .infinity, maxHeight: 75, alignment: .center)
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Please fill in a message"), message: Text("Message can't be empty!"), dismissButton: .default(Text("Sorry, jeez")))
            })
        }

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
        let defaults = UserDefaults.standard
        let sender = defaults.string(forKey: "Name") ?? "You from the past"
        
        messages.sendMessage(message: body, sender: sender, isGift: 0)
    }
}

struct ComposeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeMessageView(viewModel : MessageContainerViewModel(), messages: Messages())
    }
}
