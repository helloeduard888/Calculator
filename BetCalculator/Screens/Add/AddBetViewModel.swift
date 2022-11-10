//
//  AddBetViewModel.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import Combine

final class AddBetViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var multiplier: String = ""
    
    init() {
        
    }
}
