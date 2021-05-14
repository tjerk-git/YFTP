//
//  StackExampleView.swift
//  CardStackExample
//
//  Created by Niels Hoogendoorn on 15/03/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import SwiftUI
import CardStack
import AVFoundation

struct StackView: View {
    @State private var showModal = false
    @State var wrongAttempt: Bool = false
    @ObservedObject var messages = Messages.standard
    
    var viewModel : MessageContainerViewModel
    
    var body: some View {
        
        
        let configuration : StackConfiguration = {
            StackConfiguration (startIndex: messages.currentMessageIndex , numberOfCardsShown: 2)
        }()


        if(messages.items.count > 0) {
            CardStackView<CardMessageView, MessageCardData>(configuration: configuration, items: messages.items).environmentObject(messages)
            
        
        } else {
            VStack {
                HStack {
                    Spacer()
                }
                .padding([.top, .trailing])
                HStack {
                    Spacer()
                }
                .padding(.all)
                Spacer()
                HStack {
                    Text("No messages yet, make some!").font(.title2).fontWeight(.light).foregroundColor(.black).multilineTextAlignment(.center)
                }.padding(10)
                Spacer()
                HStack {
                    Spacer()
                }
                .padding(.all)
            }
            .background(Color.white)
        }
        
        Button(action: {
            showModal = true
        }) {
          Image(systemName: "plus.circle.fill").accentColor(Color("Color")).font(.largeTitle)
        }
        .sheet(isPresented: $showModal) {
            ComposeMessageView(viewModel: viewModel, showModal: $showModal)
        }
        
           
        if(messages.items.count > 0){
            Button(action: {
                messages.updateToRandomIndex()
                Vibration.success.vibrate()
            }) {
              Image(systemName: "repeat").accentColor(Color("Color")).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).overlay(
                RoundedRectangle(cornerRadius: 20)
                    .background(Color.orange)
                    .padding()
            )
            }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        


    }
}



//struct StackExampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        StackView(messages: Messages(), viewModel: MessageContainerViewModel())
//    }
//}
//
//
