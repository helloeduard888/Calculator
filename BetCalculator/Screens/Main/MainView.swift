//
//  MainView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingDeposit = false
    @State private var isShowingWithdraw = false
    @State private var isShowingWithrawError = false
    
    @StateObject var viewModel: MainViewViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            depositWithdrawView
            totalsView
            Color(hex: "04316A")
                .ignoresSafeArea()
                .alert("Withdraw Error", isPresented: $isShowingWithrawError, actions: { Text("OK") }, message: { Text("You don't have enough balance to withdraw") })
        }
        .onMainBackground()
    }
    
    private var depositWithdrawView: some View {
        VStack {
            Spacer()
            
            Text(viewModel.balance)
                .font(.mainFont(size: 31, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 20) {
                depositButton
                    .textFieldAlert(isPresented: $isShowingDeposit,
                                    title: "Deposit",
                                    message: "Enter deposit amount",
                                    action: handleDeposit(_:))
                Rectangle()
                    .stroke(.white)
                    .frame(width: 0.5, height: 40)
                withdrawButton
                    .textFieldAlert(isPresented: $isShowingWithdraw,
                                    title: "Withdraw",
                                    message: "Enter withdraw amount",
                                    action: handleWithdraw(_:))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    private var totalsView: some View {
        HStack {
            VStack(spacing: 42) {
                Text("Total won:")
                    .font(.mainFont(size: 21))
                
                Text("Total lost:")
                    .font(.mainFont(size: 21))
            }
            VStack(spacing: 32) {
                Text(viewModel.totalWon)
                    .font(.mainFont(size: 21))
                    .modifier(MainButtonModifier(strokeColor: .green))
                
                Text(viewModel.totalLost)
                    .font(.mainFont(size: 21))
                    .modifier(MainButtonModifier(strokeColor: .red))
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "082A56"))
    }
    
    private var depositButton: some View {
        Button {
            withAnimation {
                isShowingDeposit.toggle()
            }
        } label: {
            Text("Deposit")
                .font(.mainFont())
                .modifier(MainButtonModifier())
        }
    }
    
    private var withdrawButton: some View {
        Button {
            withAnimation {
                isShowingWithdraw.toggle()
            }
        } label: {
            Text("Withdraw")
                .font(.mainFont())
                .modifier(MainButtonModifier())
        }
    }
    
    // MARK: - Actions
    
    private func handleDeposit(_ deposit: String?) {
        guard let deposit, let amount = Double(deposit) else { return }
        viewModel.deposit(amount)
    }
    
    private func handleWithdraw(_ withdraw: String?) {
        guard let withdraw, let amount = Double(withdraw) else { return }
        do {
            try viewModel.withdraw(amount)
        } catch {
            withAnimation {
                isShowingWithrawError.toggle()
            }
        }
    }
}

struct MainButtonModifier: ViewModifier {
    var strokeColor: Color = .white
    var cornerRadius: CGFloat = 5
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 6)
            .background(Color(hex: "072A55").cornerRadius(cornerRadius))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(strokeColor))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init(persistence: PersistenceController.preview))
    }
}
