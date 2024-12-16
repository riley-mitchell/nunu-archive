//
//  SwiftUIWebView.swift
//  NU
//
//  Created by Riley Mitchell on 8/22/24.
//

import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
