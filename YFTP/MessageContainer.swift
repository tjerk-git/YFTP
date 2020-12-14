//
//  MessageContainer.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import SwiftUI

enum MessageContainerState {
    case composing, sent, sending
}

class MessageContainerViewModel: ObservableObject{
    @Published var messageContainerState : MessageContainerState = .composing
}

struct MessageContainer: View {
    @ObservedObject var viewModel = MessageContainerViewModel()
    
    var body: some View {
        switch (viewModel.messageContainerState) {
            case .composing: ComposeMessageView(viewModel: viewModel)
            case .sending: SendingMessageView(viewModel: viewModel)
            case .sent: SentMessageView(viewModel: viewModel)
        }
    }
}

