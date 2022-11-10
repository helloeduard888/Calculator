//
//  WebView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI
import WebKit

struct WebView: UIViewControllerRepresentable {
    @EnvironmentObject private var settings: Settings
    let url: URL
    
    func makeUIViewController(context: Context) -> WebController {
        let controller = WebController()
        let view = controller.view!
        let webView = makeWebView()
        view.addSubview(webView)
        webView.navigationDelegate = controller
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return controller
    }
    
    func updateUIViewController(_ uiViewController: WebController, context: Context) {
    }

    private func makeWebView() -> WKWebView {
        let preferences = WKPreferences()
        preferences.setValue(false, forKey: "fullScreenEnabled")
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.allowsInlineMediaPlayback = true
        
        let webView = TrackableWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1), configuration: configuration) { url in
            DispatchQueue.main.async { settings.url = url }
        }
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.load(URLRequest(url: url))
        return webView
    }
}

final class WebController: UIViewController, WKNavigationDelegate {
    private let id = "swiftui_custom_spinner"
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let views = view.subviews.filter{ $0.accessibilityIdentifier == id }
        views.forEach { $0.removeFromSuperview() }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let spinner = Spinner().foregroundColor(.black)
        guard let spinnerView = UIHostingController(rootView: spinner).view else { return }
        spinnerView.accessibilityIdentifier = id
        spinnerView.frame = webView.bounds.insetBy(dx: 100, dy: 300)
        view.addSubview(spinnerView)
    }
}

private final class TrackableWebView: WKWebView {

    private var onURLChange: (URL) -> Void
    
    private var webViewURLObserver: NSKeyValueObservation?
    
    init(frame: CGRect, configuration: WKWebViewConfiguration, onURLChange: @escaping (URL) -> Void) {
        self.onURLChange = onURLChange
        super.init(frame: frame, configuration: configuration)
        webViewURLObserver = observe(\.url, options: .new) { [weak self] webview, change in
            guard let new = change.newValue else { return }
            guard let url = new else { return }
            self?.onURLChange(url)
          }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

