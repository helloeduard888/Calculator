//
//  Persistence.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 1..<10 {
            let bet = Bet(context: viewContext)
            bet.title = i.description
            bet.amount = Double(i * 1000)
            bet.multiplier = Double(i) * 1.1
            bet.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BetCalculator")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getOrCreateUser() -> User {
        do {
            let request = User.fetchRequest()
            request.fetchLimit = 1
            let result = try container.viewContext.fetch(request)
            return result.first ?? createUser()
        } catch {
            return createUser()
        }
    }
    
    func save() {
        try? container.viewContext.save()
    }
    
    private func createUser() -> User {
        User(context: container.viewContext)
    }
}
