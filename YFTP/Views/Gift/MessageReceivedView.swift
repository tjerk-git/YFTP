//
//  MessageReceivedView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 12/12/2020.
//

import SwiftUI
import AudioToolbox

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
                        Button("Accept & save 🚀"){
                            self.showingDetail = false
                        }.frame(maxWidth: .infinity, maxHeight: 75, alignment: .center)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(30)
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
