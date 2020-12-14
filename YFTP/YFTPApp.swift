//
//  YFTPApp.swift
//  YFTP
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import SwiftUI
import UserNotifications


@main
struct YFTPApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
