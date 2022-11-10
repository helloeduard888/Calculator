//
//  AddBetViewModel.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import Combine

enum CreateBetError: Error {
    case emptyName
    case invalidAmount
    case invalidMultiplier
}

final class AddBetViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var multiplier: String = ""
    
    private let persistence: PersistenceController
    
    init(persistence: PersistenceController) {
        self.persistence = persistence
    }
    
    func saveBet() throws {
        guard !name.isEmpty else { throw CreateBetError.emptyName }
        guard let amount = Double(amount), amount > 0 else { throw CreateBetError.invalidAmount }
        guard let multiplier = Double(multiplier), multiplier > 1 else { throw CreateBetError.invalidMultiplier }
        let bet = Bet(context: persistence.container.viewContext)
        bet.title = name
        bet.multiplier = multiplier
        bet.amount = amount
        persistence.save()
    }
}
