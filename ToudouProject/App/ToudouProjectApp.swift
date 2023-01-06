//
//  ToudouProjectApp.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

@main
struct ToudouProjectApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var toudouVM = ToudouViewModel()
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(toudouVM)
                .onAppear {
                    NotificationManager.shared.requestAuthorization()
                }
        }
    }
}
