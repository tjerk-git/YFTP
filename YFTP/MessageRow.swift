import SwiftUI

struct MessageRow: View {
  let message: Message
  var body: some View {
    VStack(alignment: .leading) {
      message.body.map(Text.init)
        .font(.body)
        .padding(5)
    }
  }
}
