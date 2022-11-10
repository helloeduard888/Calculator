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
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(viewModel: .init())
    }
}
