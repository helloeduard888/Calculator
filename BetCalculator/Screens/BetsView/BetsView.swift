//
//  BetsView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI

struct BetsView<BetView: View>: View {
    
    @StateObject var viewModel: BetsViewModel
    var viewForBet: (Bet) -> BetView
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(viewModel.bets) { bet in
                    viewForBet(bet)
                }
            }
        }
    }
}

struct BetsView_Previews: PreviewProvider {
    static var previews: some View {
        BetsView(viewModel: .init(persistence: .preview), viewForBet: { bet in Text(bet.title ?? "No title") })
    }
}
