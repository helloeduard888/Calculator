//
//  CustomTabView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

struct CustomTabView<Content: View>: View {
    @Binding var selection: Int
    @ViewBuilder var content: (Int) -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                content(selection)
                HStack {
                    tabItem(image: "main", title: "Main", index: 0, in: geometry)
                    tabItem(image: "add", title: "Add", index: 1, in: geometry)
                    tabItem(image: "history", title: "History", index: 2, in: geometry)
                }
                .frame(width: geometry.size.width)
                .padding(.top, 12)
                .background(Color(hex: "082A56").shadow(radius: 2).edgesIgnoringSafeArea(.bottom))
            }
        }
    }
    
    func tabItem(image: String, title: String, index: Int, in geo: GeometryProxy) -> some View {
        VStack(spacing: 8) {
            Image(selection == index ? image + "_selected" : image)
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
            
            Text(title)
                .font(.mainFont(size: 15))
                .foregroundColor(selection == index ? .white : .white.opacity(0.5))
        }
        .frame(width: geo.size.width / 3, height: 55)
        .onTapGesture {
            withAnimation {
                selection = index
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selection: .constant(0), content: { _ in Color.red} )
    }
}
