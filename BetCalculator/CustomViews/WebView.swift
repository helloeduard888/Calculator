//
//  WebView.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @EnvironmentObject private var settings: Settings
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
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
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        
        private let id = "custom_spinner"
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            guard let spinner = webView.subviews.first(where: {$0.accessibilityIdentifier == id}) else { return }
            spinner.removeFromSuperview()
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            let spinner = Spinner().foregroundColor(.gray)
            guard let spinnerView = UIHostingController(rootView: spinner).view else { return }
            spinnerView.accessibilityIdentifier = id
            spinnerView.frame = webView.bounds
            webView.addSubview(spinnerView)
        }
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

