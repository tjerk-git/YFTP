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
            VStack(alignment: .leading, spacing: 20){
                Form {
                    Text("Messages will come from: ")
                    TextField(
                        defaults.string(forKey: "Name") ?? "Username",
                             text: $username
                        ) { isEditing in
                            self.isEditing = isEditing
                            self.buttonText = "Save"
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
                    .padding(20)
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }       .onTapGesture {
                defaults.set(username, forKey: "Name")
                buttonText = "Saved ✅"
                let keyWindow = UIApplication.shared.connectedScenes
                                   .filter({$0.activationState == .foregroundActive})
                                   .map({$0 as? UIWindowScene})
                                   .compactMap({$0})
                                   .first?.windows
                                   .filter({$0.isKeyWindow}).first
                keyWindow!.endEditing(true)
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)

        }
    }
}

    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel : MessageContainerViewModel())
    }
}
