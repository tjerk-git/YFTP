//
//  StackExampleView.swift
//  CardStackExample
//
//  Created by Niels Hoogendoorn on 15/03/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import SwiftUI
import CardStack
import CoreData
import Messages
import AVFoundation

struct StackView: View {
    @State var randomIndex = 0;
    @State var wrongAttempt: Bool = false
   
    let items = Messages().constructMessageCardData()

    var body: some View {
        let configuration : StackConfiguration = {
            StackConfiguration (startIndex: randomIndex , numberOfCardsShown: 3)
        }()
        
        if(items.count > 0){
            CardStackView<CardMessageView, MessageCardData>(configuration: configuration, items: items)
        } else {
            Text("No messages yet, make some!");
        }
           
        Button(action: {
            randomIndex = Int.random(in: 0..<items.count)
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

//
//struct StackExampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        StackView()
//    }
//}
//
//
