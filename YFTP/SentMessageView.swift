//
//  CompletedMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 12/12/2020.
//

import SwiftUI
import CoreData
import AudioToolbox

struct SentMessageView: View {
    var viewModel : MessageContainerViewModel
    var messages : Messages
    
    @State var hidden = false;
    
    var body: some View {
        let _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { timer in
            hidden = true
            AudioServicesPlaySystemSound(1521)
        })
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 20){
                ZStack{
                    Text("There it goes..")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title2)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                    Image("Moon")
                        .position(x: 80, y: 40)
                        .scaleEffect(1.6)
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("\(messages.lastMessage)")
                            .fontWeight(.regular)
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                            .font(.body)
                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                            .animation(.easeInOut(duration: 4))
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding(15)
                        
                            .isHidden(hidden)
                    }
                    Spacer()
                }
                }
                VStack(){
                    Button("Back to the present") {
                        viewModel.messageContainerState = .composing
                    }
                    .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    // generate random star function
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .position(x: 100, y: 30)
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 20, height: 20)
                        .position(x: 4, y: 200)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 13, height: 11)
                        .position(x: 80, y: 40)
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 3, height: 3)
                        .position(x: 140, y: 80)
                }.frame(maxHeight: .infinity)
                Spacer()
            }.padding(.top, 75)
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SentMessageView(viewModel : MessageContainerViewModel(), messages: Messages())
    }
}
extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
