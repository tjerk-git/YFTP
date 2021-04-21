//
//  GreetingView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 14/04/2021.
//

import SwiftUI

let quotes = [
    "It's Monday, psyche it's \(Date().dayOfWeek()!).",
    "Don't worry you are still On Track.",
    "You are here, good.",
    "Write something!",
    "Anything you add is good",
    "The only one judging yourself is you",
    "Wow, that's deep",
    "Woah, cool",
    "You hair looks amazing",
    "Nice weather huh?",
    "Did anything fun this weekend?",
    "Pet a cat today?",
    "Space, space, space, space",
    "Tap me, see what happens...",
    "Breathe, no really..",
    "Sup, son!",
    "You are wondering how many messages there are?",
    "Stop.. just.. take it easy",
    "Learn from the past",
    "It's weekend! oh wait it's \(Date().dayOfWeek()!).",
]



struct GreetingView: View {
    @State var randomIndex = Int.random(in: 0..<quotes.count)
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading){
                Text("\(quotes[randomIndex])").font(.title).fontWeight(.bold).foregroundColor(Color("Color")).multilineTextAlignment(.leading).padding([.top, .trailing], 10.0)
            }
        }.onTapGesture {
            randomIndex = Int.random(in: 0..<quotes.count)
            Vibration.success.vibrate()
        }
    }

    struct GreetingView_Previews: PreviewProvider {
        static var previews: some View {
            GreetingView()
        }
    }
}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
