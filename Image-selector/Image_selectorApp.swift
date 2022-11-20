//
//  Image_selectorApp.swift
//  Image-selector
//
//  Created by Prerana on 19/11/22.
//

import SwiftUI

@main
struct Image_selectorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
