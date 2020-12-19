//
//  MessageContainer.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 11/12/2020.
//

import SwiftUI

enum MessageContainerState {
    case composing, sent, sending, archive
}

class MessageContainerViewModel: ObservableObject{
    @Published var messageContainerState : MessageContainerState = .composing
}

struct MessageContainer: View {
    @ObservedObject var viewModel = MessageContainerViewModel()
    var messages = Messages()
    
    var body: some View {
        switch (viewModel.messageContainerState) {
        case .composing: ComposeMessageView(viewModel: viewModel, messages: messages)
                .transition(.move(edge: .leading))
            case .sending: SendingMessageView(viewModel: viewModel)
                .transition(.scale)
                .animation(.easeInOut(duration: 1))
            case .sent: SentMessageView(viewModel: viewModel, messages : messages)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .move(edge: .bottom)))
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        case .archive: ArchiveMessageView(viewModel: viewModel, messages : messages)
            .transition(AnyTransition.asymmetric(insertion: .scale, removal: .move(edge: .bottom)))
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        }
    }
}

