//
//  CompletedMessageView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 12/12/2020.
//

import SwiftUI
import CoreData


struct SentMessageView: View {
    var viewModel : MessageContainerViewModel
    @FetchRequest(entity: Message.entity(), sortDescriptors: [])
    var messages: FetchedResults<Message>
    
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 20){
                Image("Moon")
                    .position(x: 80, y: 40)
                    .scaleEffect(1.6)
                ZStack{
                    ForEach(messages) { message in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(message.body ?? "Your message here")")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                   .font(.title2)
                                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                            }
                            Spacer()
                        }
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
        SentMessageView(viewModel : MessageContainerViewModel())
    }
}
