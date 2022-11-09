//
//  MainView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        LinearGradient(colors: [.topGradientStart, .topGradientEnd], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
