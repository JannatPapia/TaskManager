//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Jannatun Nahar Papia on 13/6/22.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
