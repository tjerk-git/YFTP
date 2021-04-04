//
//  DataExample.swift
//  CardStackExample
//
//  Created by Niels Hoogendoorn on 15/03/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import SwiftUI
import CardStack

struct MessageCardData: CardData {
    var id: String
    var dateAdded: Date
    var body: String
    var sender: String
    var color: Color
}
