//
//  SettingsView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 04/05/2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.openURL) var openURL
  
    @State private var username: String = ""
    @State private var buttonText: String = "Save"
    
    let defaults = UserDefaults.standard
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name used in notifications and gifts")) {
                    TextField(defaults.string(forKey: "Name") ?? "Name", text: $username)
                    
                    Button(buttonText) {
                        defaults.set(username, forKey: "Name")
                        Vibration.success.vibrate()
                    }
                    .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                }

                Section(header: Text("About")) {
                    HStack {
                            Text("Made by")
                            Spacer()
                            Text("Tjerk Dijkstra")
                        }
                    HStack {
                            Text("Version")
                            Spacer()
                            Text("1.4")
                        }
                }
                
                Section {
                    Button(action: {
                        openURL(URL(string: "https://www.buymeacoffee.com/tjerkdijkstra")!)
                    }) {
                        Text("Donate ❤️")
                    }
                    
                    Button(action: {
                        openURL(URL(string: "mailto://tjerk@hey.com")!)
                    }) {
                        Text("Feature request")
                    }
                }

                }
                .navigationBarTitle(Text("Settings"))
        }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
