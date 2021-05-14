//
//  CardExampleView.swift
//  CardStackExample
//
//  Created by Niels Hoogendoorn on 15/03/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import SwiftUI
import CardStack
import AVFoundation

struct CardMessageView: CardView {
    @State private var showModal = false
    @State private var showingSheet = false
    var messages = Messages.standard
    
    var data: MessageCardData?
    var currentIndex: Int?
    var totalCards: Int?

    init<Data>(data: Data) where Data: CardData {
        if let infoData = data as? MessageCardData {
            self.data = infoData
        }
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(data?.dateAdded ?? Date(), style: .date).font(.footnote).fontWeight(.light).foregroundColor(.black)
            }
            .padding([.top, .trailing])
            HStack {
                Spacer()
            }
            .padding(.all)
            Spacer()
            HStack {
                Text("\"\(data?.body ?? "\"")\"" ).font(.title2).fontWeight(.light).foregroundColor(.black).multilineTextAlignment(.center).padding()
          
            }
            HStack {
                Text("-\(data?.sender ?? "You")")
                .font(.subheadline).fontWeight(.semibold).foregroundColor(.black)
            }
            Spacer()
            HStack {
                Text("#\(data?.currentIndex ?? 0) of \(data?.totalCards ?? 42)")
                Spacer()
                if(data?.loved == true){
                    Image(systemName: "heart.fill").foregroundColor(.red).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                } else {
                    Image(systemName: "heart").accentColor(Color("Color")).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(.all)
        }
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            Vibration.success.vibrate()
            messages.toggleLoveState(id: data?.uuid ?? "", currentIndex: data?.currentIndex ?? 0)
    
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 400, maxHeight: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(data?.color)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 0)
    }
}

struct CardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CardMessageView(
            data: MessageCardData(
            id: UUID().uuidString,
            dateAdded: Date(),
            body: "Go Through Emotions bad or good",
            sender: "",
            color: .white,
            uuid: "",
            currentIndex: 0,
            totalCards: 42,
            loved: false
        ))
    }
}
