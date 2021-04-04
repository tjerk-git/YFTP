//
//  StackExampleView.swift
//  CardStackExample
//
//  Created by Niels Hoogendoorn on 15/03/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import SwiftUI
import CardStack

struct StackExampleView: View {
    let items: [MessageCardData] = [
        MessageCardData(id: UUID().uuidString, dateAdded: Date(), body: "Go through emotions bad or good", sender: "from you:", color: Color.red),
        MessageCardData(id: UUID().uuidString, dateAdded: Date(), body: "Go through asdas bad asdas good", sender: "from you:", color: Color.blue),
        MessageCardData(id: UUID().uuidString, dateAdded: Date(), body: "Go through emotions bad or asdsa", sender: "from you:", color: Color.yellow),
    ]
    
    let configuration = StackConfiguration()
    
    var body: some View {
        CardStackView<CardExampleView, MessageCardData>(configuration: nil, items: items)
    }
}

struct StackExampleView_Previews: PreviewProvider {
    static var previews: some View {
        StackExampleView()
    }
}
