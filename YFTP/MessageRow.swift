import SwiftUI

struct MessageRow: View {
  let message: Message
    static let taskDateFormat: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter
    }()

  var body: some View {
    VStack(alignment: .leading) {
      message.body.map(Text.init)
        .font(.body)
        if(message.dateAdded != nil) {
            Text("added: \(message.dateAdded!, formatter: Self.taskDateFormat)").font(/*@START_MENU_TOKEN@*/.caption2/*@END_MENU_TOKEN@*/).fontWeight(.thin).multilineTextAlignment(.trailing).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
    }
  }
}
