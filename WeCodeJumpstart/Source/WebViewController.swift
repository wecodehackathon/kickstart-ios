//
//  WebViewController.swift
//  WeCodeJumpstart
//
//  Created by Jereme Claussen on 1/4/19.
//  Copyright © 2019 WeCode. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: Properties

    @IBOutlet var webView: WKWebView!
    private var url: URL = URL(string: "http://wecodehackathon.com")!

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        webView.navigationDelegate = self

        let request = URLRequest(url: url)

        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        log.error("WebView navigation did fail: \(error)")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        log.event("WebView did finish navigation: \(String(describing: navigation))")
    }
}

// MARK: - WKUIDelegate

extension WebViewController: WKUIDelegate {
}
