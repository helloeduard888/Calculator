//
//  Alert.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import Foundation

struct AlertMessage {
    var title: String = "Error"
    let message: String
    var action: (() -> Void)?
}
