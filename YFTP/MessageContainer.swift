//
//  MessageContainer.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import SwiftUI

enum MessageContainerState {
    case sent, sending, none
}

class MessageContainerViewModel: ObservableObject{
    @Published var messageContainerState : MessageContainerState = .none
}

struct MessageContainer: View {
    let defaults = UserDefaults.standard
    @State var currentView: Int = 1
    @ObservedObject var viewModel = MessageContainerViewModel()
    @State var showingDetail : Bool = false
    
    var messages = Messages()
        
    var body: some View {
                
        let tabview =  TabView(selection: $currentView) {
            ComposeMessageView(viewModel: viewModel, messages : messages)
             .tabItem {
                 Image(systemName: "square.and.pencil")
                 Text("Write")
             }.tag(1)
            
            ArchiveMessageView(viewModel: viewModel, messages : messages)
             .tabItem {
                 Image(systemName: "memories")
                 Text("Archive")
             }.tag(2)
            
            ComposeGiftView(viewModel: viewModel, messages: messages)
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Gift")
                }.tag(3)
  
            SettingsView(viewModel: viewModel)
             .tabItem {
                 Image(systemName: "gear")
                 Text("Settings")
             }.tag(4)
         }

        switch (viewModel.messageContainerState) {
            case .sending: SendingMessageView(viewModel: viewModel)
            case .sent: SentMessageView(viewModel: viewModel, messages : messages)
            case .none: tabview
        }
        
    }
    
}

