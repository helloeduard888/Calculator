//
//  MainTabView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    @StateObject var mainModdel = MainViewViewModel(persistence: .shared)
    
    var body: some View {
        CustomTabView(selection: $selection) { index in
            switch index {
            case 0:
                MainView(viewModel: mainModdel)
                    .transition(.identity)
            case 1:
                AddView(viewModel: .init(persistence: .shared)) {
                    withAnimation { selection = 0 }
                }
                .transition(.identity)
            case 2:
                HistoryView { amount in
                    String(format: "%.1f", amount) + Constants.currency
                }
                .transition(.identity)
            default:
                EmptyView()
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
