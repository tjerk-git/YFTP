//
//  PermissionView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 08/12/2020.
//

import SwiftUI

struct PermissionView: View {
    let preferences : PreferenceManager
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                Text("Hey there stranger, this app uses notifications! Why don't you press that button down there, to allow them.. please?")
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.body)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
          
               
                VStack(alignment: .center, content: {
                    Button("Ask for permissions") {
                        preferences.requestLocalNotificationPermission()
                    }
                    .transition(.slide)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }).frame(maxHeight: .infinity)
         
                Spacer()
            }.padding(.top, 75)
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
        }

    }


struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(preferences: PreferenceManager())
    }
}
