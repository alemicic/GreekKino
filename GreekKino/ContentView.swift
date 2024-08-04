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
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: "https://www.mozzartbet.com/sr/lotto-animation/26#/") {
            webView.load(URLRequest(url: url))
        }
    }
}
