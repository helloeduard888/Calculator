//
//  MainTabView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    
    var body: some View {
        CustomTabView(selection: $selection) { index in
            switch index {
            case 0:
                MainView(viewModel: .init(persistence: .shared))
                    .transition(.identity)
            case 1:
                AddView(viewModel: .init(persistence: .shared))
                    .transition(.identity)
            case 2:
                HistoryView()
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
