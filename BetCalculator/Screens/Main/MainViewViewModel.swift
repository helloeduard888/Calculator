//
//  MainViewViewModel.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import Combine
import CoreData

enum WithdrawError: Error {
    case exceedsMaximum
}

final class MainViewViewModel: ObservableObject {
    
    private let persistence: PersistenceController
    
    init(persistence: PersistenceController) {
        self.persistence = persistence
    }
    
    var balance: String {
        let user = persistence.getOrCreateUser()
        return formattedString(for: user.totalBalance)
    }
    
    var totalWon: String {
        let request = Bet.fetchRequest()
        request.entity = Bet.entity()
        request.predicate = NSPredicate(format: "isWon == YES")
        do {
            let wonBets = try persistence.container.viewContext.fetch(request)
            let totalWon = wonBets.reduce(0, { $1.amount * $1.multiplier + $0})
            return formattedString(for: totalWon)
        } catch {
            return "0" + Constants.currency
        }
    }
    
    var totalLost: String {
        let request = Bet.fetchRequest()
        request.entity = Bet.entity()
        request.predicate = NSPredicate(format: "isWon == NO")
        do {
            let lostBets = try persistence.container.viewContext.fetch(request)
            let totalLost = lostBets.reduce(0, { $1.amount + $0})
            return formattedString(for: totalLost)
        } catch {
            return "0" + Constants.currency
        }
    }
    
    func deposit(_ amount: Double) {
        let user = persistence.getOrCreateUser()
        user.deposited += amount
        user.totalBalance += amount
        persistence.save()
        objectWillChange.send()
    }
    
    func withdraw(_ amount: Double) throws {
        let user = persistence.getOrCreateUser()
        guard user.totalBalance >= amount else { throw WithdrawError.exceedsMaximum }
        user.withdrawn += amount
        user.totalBalance -= amount
        persistence.save()
        objectWillChange.send()
    }
    
    private func formattedString(for amount: Double) -> String {
        String(format: "%.1f", amount) + Constants.currency
    }
}
