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
    @State var settings = GameSetting()


    var body: some Scene {
        WindowGroup {
            StartView().environmentObject(settings)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
