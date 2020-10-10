//
//  MemoriesApp.swift
//  Memories
//
//  Created by Bryce on 2020/9/22.
//

import SwiftUI

@main
struct MemoriesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EmojiMemoryContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
