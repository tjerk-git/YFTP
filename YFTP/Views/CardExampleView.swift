//
//  CardExampleView.swift
//  CardStackExample
//
//  Created by Niels Hoogendoorn on 15/03/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import SwiftUI
import CardStack

struct CardExampleView: CardView {
    var data: MessageCardData?
    
    init<Data>(data: Data) where Data: CardData {
        if let infoData = data as? MessageCardData {
            self.data = infoData
        }
    }
    
    var body: some View {
        HStack{
            Text(data?.body ?? "value").frame(minWidth: 300, maxWidth: .infinity, minHeight: 400, maxHeight: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color.black)
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 400, maxHeight: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(8)
        .background(data?.color)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 0)

    }
}

struct CardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CardExampleView(data: MessageCardData(
                            id: UUID().uuidString,
            dateAdded: Date(),
            body: "",
            sender: "",
            color: .red,
            uuid: ""
        ))
    }
}
