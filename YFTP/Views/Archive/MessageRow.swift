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
        
        if(opacity != 0.5 || message.hasBeenSeen != (0 != 0)){
            message.body.map(Text.init)
              .font(.body)
              .padding(0)

        } else {
            Button(action: {
                opacity = 1
                if(message.id != nil){
                    Messages().updateMessageToSeen(id: message.id!)
                }
               
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "eye.fill")
                    Text("Tap to reveal message")
                }
            }
            
            if(message.dateAdded != nil) {
                Text("\(message.dateAdded!, formatter: Self.taskDateFormat)").font(/*@START_MENU_TOKEN@*/.caption2/*@END_MENU_TOKEN@*/).fontWeight(.thin).multilineTextAlignment(.trailing).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
        }
        
        if(message.isGift) {
            Text("this is a gift from: \(message.sender ?? "Someone")").font(/*@START_MENU_TOKEN@*/.caption2/*@END_MENU_TOKEN@*/).fontWeight(.thin).multilineTextAlignment(.trailing).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }

    }
    .opacity(opacity)
    .transition(.identity)
    
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
