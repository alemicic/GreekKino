//
//  ContentView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 3.8.24..
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView()
    }
}

struct WebView: UIViewRepresentable {
    enum Constants {
        static let webViewUrlString = "https://www.mozzartbet.com/sr/lotto-animation/26#/"
    }
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: Constants.webViewUrlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
