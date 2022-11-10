//
//  BetCalculatorApp.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

@main
struct BetCalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if settings.isAllowed {
                    WebView(url: settings.url ?? Constants.getMainURL(includeParams: true))
                        .ignoresSafeArea()
                } else {
                    appView
                }
            }
            .environmentObject(settings)
        }
    }
    
    @ViewBuilder
    private var appView: some View {
        if settings.isLoadingFinished {
            MainTabView()
        } else {
            LoadingView()
        }
    }
}
