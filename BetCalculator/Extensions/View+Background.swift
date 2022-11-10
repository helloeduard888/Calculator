//
//  View+Background.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI

extension View {
    func onMainBackground() -> some View {
        background(LinearGradient(colors: [.topGradientEnd, .topGradientStart],
                                  startPoint: .top,
                                  endPoint: .bottom).ignoresSafeArea())
    }
}
