//
//  LoadingView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Image("splash")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Loading...")
                    .font(.mainFont(size: 30, weight: .semibold))
                    .foregroundColor(.white)
                
                Spinner()
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
