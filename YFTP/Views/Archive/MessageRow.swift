import SwiftUI

struct MessageRow: View {
  @State var opacity: Double = 0.5
    
  let message: Message
    static let taskDateFormat: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter
    }()

  var body: some View {
    VStack(alignment: .leading) {
        
        if(opacity != 0.5){
            message.body.map(Text.init)
              .font(.body)
              .padding(5)
              if(message.dateAdded != nil) {
                  Text("added: \(message.dateAdded!, formatter: Self.taskDateFormat)").font(/*@START_MENU_TOKEN@*/.caption2/*@END_MENU_TOKEN@*/).fontWeight(.thin).multilineTextAlignment(.trailing).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
              }
        } else {
            Image(systemName: "hand.draw.fill").foregroundColor(.white)
            Text("Hold to reveal message").foregroundColor(.white).opacity(1.0).padding(5)
        }
        
        if(message.isGift) {
            Text("Is a gift from \(message.sender ?? "Someone")").font(/*@START_MENU_TOKEN@*/.caption2/*@END_MENU_TOKEN@*/).fontWeight(.thin).multilineTextAlignment(.trailing).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            Image(systemName: "gift.fill").foregroundColor(.white).padding(5)
        }

    }
    .opacity(opacity)
    .transition(.identity)
    .onLongPressGesture(minimumDuration: 0.1) {
        withAnimation(.easeInOut(duration: 1)) {
            opacity = 1.0
        }
    }
  }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
