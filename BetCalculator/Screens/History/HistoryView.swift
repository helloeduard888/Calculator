//
//  HistoryView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct HistoryView: View {
    var format: (Double) -> String
    
    var body: some View {
        BetsView(viewModel: .init(persistence: .shared,
                                  predicate: NSPredicate(format: "isWon != NULL")),
                 viewForBet: view(for:))
        .onMainBackground()
    }
    
    private func view(for bet: Bet) -> some View {
        VStack {
            HStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Bet:")
                        .font(.mainFont(size: 15, weight: .light))
                    Text("Amount:")
                        .font(.mainFont(size: 15, weight: .light))
                    Text("Multiplier:")
                        .font(.mainFont(size: 15, weight: .light))
                    Text(bet.isWon == true ? "Won:" : "Lost")
                        .foregroundColor(bet.isWon == true ? .green : .red)
                        .font(.mainFont(size: 15, weight: .light))
                }
                .foregroundColor(.white)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(bet.title ?? "N/A")
                        .font(.mainFont(weight: .semibold))
                    Text(format(bet.amount))
                        .font(.mainFont(weight: .semibold))
                    Text(String(format: "%.2f", bet.multiplier))
                        .font(.mainFont(weight: .semibold))
                    Text(bet.isWon == true ? format(bet.amount * bet.multiplier) : "")
                        .font(.mainFont(weight: .semibold))
                        .foregroundColor(.green)
                }
                .foregroundColor(.white)
                
            }
            
            Rectangle().stroke(.white).frame(maxHeight: 0.5)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(format: { i in String(format: "%.1f", i) + Constants.currency})
    }
}
