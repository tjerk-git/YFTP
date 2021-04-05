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

struct StackExampleView: View {
    let items = Messages().constructMessageCardData()
    let configuration = StackConfiguration()
    @State var shuffle = false;
    
    var body: some View {
        if(shuffle){
            CardStackView<CardExampleView, MessageCardData>(configuration: nil, items: items.shuffled())
        } else {
            CardStackView<CardExampleView, MessageCardData>(configuration: nil, items: items)
        }
       
        Button("🚀 BLAST OFF") {
            shuffle = true
        }
        
    }
}

struct StackExampleView_Previews: PreviewProvider {
    static var previews: some View {
        StackExampleView()
    }
}
