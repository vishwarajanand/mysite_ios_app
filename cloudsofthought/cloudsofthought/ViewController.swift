//
//  ViewController.swift
//  cloudsofthought
//
//  Created by Vishwaraj Anand on 5/23/20.
//  Copyright © 2020 Vishwaraj Anand. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private let webView: WKWebView = WKWebView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.isUserInteractionEnabled = true
        
        let myURL = URL(string:"https://vishwarajanand.com/blog/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        view = webView
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard
            let url = navigationAction.request.url,
            let scheme = url.scheme else {
                // fallback to safari if no url scheme is specified
                decisionHandler(.cancel)
                return
        }
        
        // open in default mail application if mailto link is clicked
        if (scheme.lowercased() == "mailto") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            debugPrint("Safari can open this => \n" + scheme.lowercased())
            decisionHandler(.cancel)
            return
        }
        
        // pass through if dependencies
        if url.absoluteString.range(of: "disqus.com") != nil
            || url.absoluteString.range(of: "accounts.google.com") != nil
        {
            decisionHandler(.allow)
            return
        }
        
        // open in safari if not root website
        if url.absoluteString.range(of: "vishwarajanand.com") == nil
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            debugPrint("Safari can open this => \n" + url.absoluteString)
            return
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //        debugPrint("didFinish")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //        debugPrint("didFail")
    }
}
