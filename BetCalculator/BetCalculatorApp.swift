//
//  BetCalculatorApp.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

@main
struct BetCalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
