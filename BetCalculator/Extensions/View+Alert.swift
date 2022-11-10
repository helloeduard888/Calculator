//
//  View+Alert.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI

struct TextFieldAlertModifier: ViewModifier {

    @State private var alertController: UIAlertController?

    @Binding var isPresented: Bool

    let title: String
    let message: String
    let placeholder: String?
    let action: (String?) -> Void

    public func body(content: Content) -> some View {
        content.onChange(of: isPresented) { isPresented in
            if isPresented, alertController == nil {
                let alertController = makeAlertController()
                self.alertController = alertController
                Navigation.topMostViewController()?.present(alertController, animated: true)
            } else if !isPresented, let alertController = alertController {
                alertController.dismiss(animated: true)
                self.alertController = nil
            }
        }
    }

    private func makeAlertController() -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addTextField {
            $0.placeholder = placeholder
        }
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.action(nil)
            shutdown()
        })
        controller.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.action(controller.textFields?.first?.text)
            shutdown()
        })
        return controller
    }

    private func shutdown() {
        isPresented = false
        alertController = nil
    }
}

extension View {
    func textFieldAlert(isPresented: Binding<Bool>,
                        title: String,
                        message: String,
                        placeholder: String? = nil,
                        action: @escaping (String?) -> Void) -> some View {
        modifier(TextFieldAlertModifier(isPresented: isPresented, title: title, message: message, placeholder: placeholder, action: action))
    }
}

enum Navigation {
    static func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }
    
    private static func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
    }

    private static func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
}
