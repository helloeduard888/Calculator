//
//  Settings.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI

final class Settings: ObservableObject {
    @AppStorage("lastUrl") var url: URL?
    @Published var isAllowed: Bool = false
    var isLoadingFinished: Bool = false
}
