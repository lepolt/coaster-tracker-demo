//
//  CoasterTrackerDemo1App.swift
//  CoasterTrackerDemo1
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import SwiftUI

@main
struct CoasterTrackerDemo1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
