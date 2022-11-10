//
//  AddView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct AddView: View {
    
    @StateObject var viewModel: AddBetViewModel
    @FocusState private var selectedField: Field?
    @State private var alertMessage: AlertMessage?
    
    enum Field {
        case betName
        case multiplier
        case amount
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Add Bet")
                .font(.mainFont(size: 31, weight: .light))
                .foregroundColor(.white)
                .alert(alertMessage?.title ?? "", isPresented: isErrorShown, actions: { Text("OK") }, message: { Text(alertMessage?.message ?? "") })
            Spacer()
            
            betName
                .padding(.bottom)
            multiplier
                .padding(.bottom)
            betAmount
            
            Spacer()
            saveButton
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onMainBackground()
    }
    
    private var saveButton: some View {
        Button {
            selectedField = nil
            handleBet()
        } label: {
            Text("Save")
                .font(.mainFont(size: 24, weight: .semibold))
                .modifier(MainButtonModifier())
        }
    }
    
    private var betName: some View {
        VStack {
            Text("Bet name")
                .font(.mainFont(size: 15))
            
            makeTextField(binding: $viewModel.name, type: .betName, keyboard: .default)
        }
        .foregroundColor(.white)
    }
    
    private var multiplier: some View {
        VStack {
            Text("Multiplier")
                .font(.mainFont(size: 15))
            
            makeTextField(binding: $viewModel.multiplier, type: .multiplier, keyboard: .decimalPad)
        }
        .foregroundColor(.white)
    }
    
    private var betAmount: some View {
        VStack {
            Text("You bet")
                .font(.mainFont(size: 15))
            
            makeTextField(binding: $viewModel.amount, type: .amount, keyboard: .decimalPad)
        }
        .foregroundColor(.white)
    }
    
    private func makeTextField(binding: Binding<String>, type: Field, keyboard: UIKeyboardType) -> some View {
        TextField("", text: binding)
            .keyboardType(keyboard)
            .focused($selectedField, equals: type)
            .submitLabel(.done)
            .font(.mainFont(size: 19))
            .foregroundColor(.white)
            .padding(.horizontal, 4)
            .frame(width: 240, height: 36)
            .background(Color(hex: "072A55").cornerRadius(5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.white))
    }
    
    private var isErrorShown: Binding<Bool> {
        Binding {
            alertMessage != nil
        } set: { _ in
            alertMessage = nil
        }
    }
    
    // MARK: - Actions
    
    private func handleBet() {
        do {
            try viewModel.saveBet()
        } catch let error as CreateBetError {
            switch error {
            case .invalidMultiplier:
                alertMessage = .init(message: "Invalid multiplier. Multiplier must be above 1")
            case .invalidAmount:
                alertMessage = .init(message: "Invalid bet amount. Amount must be above 0")
            case .emptyName:
                alertMessage = .init(message: "Name can not be empty")
            }
        } catch {
            alertMessage = .init(message: "Cannot create bet.")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(viewModel: .init(persistence: .preview))
    }
}
