//
//  BetsViewViewModel.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import Foundation

final class BetsViewModel: ObservableObject {
    
    var bets: [Bet] {
        fetchBets()
    }
    
    private let persistence: PersistenceController
    private let predicate: NSPredicate
    
    init(persistence: PersistenceController, predicate: NSPredicate = .init(value: true)) {
        self.persistence = persistence
        self.predicate = predicate
    }
    
    private func fetchBets() -> [Bet] {
        let request = Bet.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Bet.timestamp, ascending: false)]
        do {
            return try persistence.container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
