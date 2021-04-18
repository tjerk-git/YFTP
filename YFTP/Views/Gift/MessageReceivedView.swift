//
//  MessageReceivedView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 12/12/2020.
//

import SwiftUI
import CoreData
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
                    Image("Moon")
                        .position(x: 600, y: 10)
                        .scaleEffect(0.4)
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("You received 🎁 from: ")
                            .fontWeight(.medium)
                            .font(.title)
                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                            .animation(.easeInOut(duration: 5))
                            .padding(15)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                        Text("\(sender)")
                        .font(.title)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                        Text("The future will reveal it's contents")
                            .padding(15)
                            .foregroundColor(.white)
                        Spacer()
                        Button("Accept & save 🚀"){
                            self.showingDetail = false
                        }.frame(maxWidth: .infinity, maxHeight: 75, alignment: .center)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(30)
                    }
                    Spacer()
                }
                }
                VStack(){
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
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .edgesIgnoringSafeArea(.all)
    }
}
