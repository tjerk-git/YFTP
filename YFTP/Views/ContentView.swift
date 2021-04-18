//
//  ContentView.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var preferences : PreferenceManager = PreferenceManager()
    
    var body: some View {
        switch preferences.notificationSetting {
            case .notset:
                PermissionView(preferences: preferences)
            case .accepted:
                MessageContainer()
            case .denied:
                MessageContainer()
            case .loading:
                Text ("Loading")
        }
    }
}

