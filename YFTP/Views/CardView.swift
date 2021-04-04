import SwiftUI
import CardStack

struct CardExampleView: Card {
    var data: DataExample?
    
    init<CardData>(data: CardData) where CardData: CardData {
        if let infoData = data as? DataExample {
            self.data = infoData
        }
    }
    
    var body: some View {
        data?.color
            .frame(width: 200, height: 200)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 0)
        .cornerRadius(8)
    }
}
