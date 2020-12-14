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
        VStack {
            Button("Request Permission") {
                preferences.requestLocalNotificationPermission()
            }
        }
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(preferences: PreferenceManager())
    }
}
