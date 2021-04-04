import SwiftUI
import CardStack

struct CardStackView: View {
    let items: [DataExample] = [DataExample(id: UUID().uuidString, color: .red),
                 DataExample(id: UUID().uuidString, color: .blue),
                 DataExample(id: UUID().uuidString, color: .yellow),
                 DataExample(id: UUID().uuidString, color: .green),
                 DataExample(id: UUID().uuidString, color: .orange)
    ]
    
    let configuration = StackConfiguration()
    
    var body: some View {
        CardStack<CardExampleView, DataExample>(configuration: nil, items: items)
    }
}
