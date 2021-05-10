//
//  MessageReceivedView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 12/12/2020.
//

import SwiftUI

struct MessageReceivedView: View {
    @Binding var showingDetail : Bool
    
    var message : String
    var sender : String
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 20){
                ZStack{
                HStack {
                    VStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "gift.fill")
                            .font(.system(size: 56.0))
                        
                        Text("You received a gift from: ")
                            .fontWeight(.medium)
                            .font(.title)
                            .foregroundColor(Color.black)
                            .animation(.easeInOut(duration: 5))
                            .padding(15)

                        Text("\(sender)")
                        .font(.title)
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                        Text("The future will reveal it's contents")
                            .padding(15)
                            .foregroundColor(Color.black)
                        Spacer()

                        Button(action: {
                            self.showingDetail = false
                            Vibration.success.vibrate()
                        }){
                     
                        Text("Accept & Save")
                            .fontWeight(.bold)
                            .padding()
                            .overlay(
                                Capsule(style: .continuous).stroke(Color.blue, style: StrokeStyle(lineWidth: 3))
                            )
                            .foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Spacer()
                }
                }
                Spacer()
            }.padding(.top, 75)
        }.background(Color.white)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MessageReceivedView_Previews: PreviewProvider {
    @State static var value = true
    static var previews: some View {
        MessageReceivedView(showingDetail: $value, message: "message", sender: "Josytha")
    }
}
