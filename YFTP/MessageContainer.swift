//
//  MessageContainer.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import SwiftUI

enum MessageContainerState {
    case none, home
}

class MessageContainerViewModel: ObservableObject{
    @Published var messageContainerState : MessageContainerState = .none
}

struct MessageContainer: View {
    let defaults = UserDefaults.standard
    @State var currentView: Int = 1
    @ObservedObject var viewModel = MessageContainerViewModel()
    @State var showingDetail : Bool = false
    
    var body: some View {
                
        let tabview =  TabView(selection: $currentView) {
            
            DashBoardView(viewModel: viewModel)
             .tabItem {
                 Image(systemName: "note.text")
                 Text("Messages")
             }.tag(1)
                        
            CollectionView()
             .tabItem {
                 Image(systemName: "mail.stack.fill")
                 Text("Collections")
             }.tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(3)

         }

        switch (viewModel.messageContainerState) {
            case .none: tabview
            case .home: DashBoardView(viewModel: viewModel)
        }
    }
    
}

