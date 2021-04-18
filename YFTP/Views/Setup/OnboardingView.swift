//
//  SettingsView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 14/01/2021.
//

import SwiftUI

struct OnboardingView: View {
    //var viewModel : MessageContainerViewModel
    let defaults = UserDefaults.standard
    @Binding var showingBoard : Bool

    var body: some View {
            ZStack {
                Rectangle().foregroundColor(Color.black)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    ApplicationFeature(
                        featureTitle: "Send messages to yourself",
                        featureDescription: "Messages will arrive as a notification in the near future, hopefully at just the right moment.",
                        featureImage: "message.fill")
                    ApplicationFeature(featureTitle: "Gift messages to friends!",
                                       featureDescription: "Share your gift and make messages appear for your friends & family",
                                       featureImage: "gift.fill"
                    )
                    Spacer()
                    Button(action: {
                        self.showingBoard = false
                        UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                    }) {
                        Text("Continue")
                            .foregroundColor(Color.white)
                    }.padding(.all)
                    .background(Color.black)
                    .cornerRadius(8)
                }
            }
        }
}


//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView(showingBoard: Binding )
//    }
//}
