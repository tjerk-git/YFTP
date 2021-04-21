//
//  ContentView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var preferences : PreferenceManager = PreferenceManager()
    @EnvironmentObject var messages : Messages
    
    var body: some View {
        switch preferences.notificationSetting {
            case .notset:
                PermissionView(preferences: preferences)
            case .accepted:
                MessageContainer(messages: messages)
            case .denied:
                MessageContainer(messages: messages)
            case .loading:
                Text ("Loading")
        }
    }
}

