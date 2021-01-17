//
//  SettingsView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 14/01/2021.
//

import SwiftUI

struct SettingsView: View {
    var viewModel : MessageContainerViewModel
    @State private var username: String = ""
    @State private var isEditing = false
    @State private var buttonText: String = "Save"
    let defaults = UserDefaults.standard
    var body: some View {
    
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 20){
                List(){
                Text("Messages will come from: ")
                TextField(
                    defaults.string(forKey: "Name") ?? "Username",
                         text: $username
                    ) { isEditing in
                        self.isEditing = isEditing
                }.padding(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                    Button(buttonText) {
                        defaults.set(username, forKey: "Name")
                        buttonText = "Saved ✅"
                    }
                    .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                Button("Go back") {
                    viewModel.messageContainerState = .composing
                }
                .frame(width: 250, height: 50, alignment: .center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)

                }.frame(maxHeight: .infinity)
                Spacer()
            }.padding(.top, 75)
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
}
}

    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel : MessageContainerViewModel())
    }
}
