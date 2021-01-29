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
        ZStack {
            VStack {
                ApplicationFeature(
                    featureTitle: "Send messages to yourself",
                    featureDescription: "Messages will arrive as a notification in the near future, hopefully at just the right moment.",
                    featureImage: "message.fill")
                
                ApplicationFeature(featureTitle: "Can we send you notifications?",
                                   featureDescription: "With notifications you can receive your own messages at any time",
                                   featureImage: "bell.badge.fill")
                
                ApplicationFeature(featureTitle: "Gift messages to friends!",
                                   featureDescription: "Share your gift and make messages appear for your friends & family",
                                   featureImage: "gift.fill"
                )
                Spacer()
                Button(action: {
                    preferences.requestLocalNotificationPermission()
                    UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                }) {
                    Text("Continue")
                        .foregroundColor(Color.white)
                    
                }.padding(.all)
                .frame(width: 250, height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .cornerRadius(8)
            }
        }
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(preferences: PreferenceManager())
    }
}
