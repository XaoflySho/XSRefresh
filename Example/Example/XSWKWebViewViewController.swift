//
//  XSWKWebViewViewController.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/23.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import WebKit
import XSRefresh

class XSWKWebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let request = URLRequest(url: URL(string: "https://github.com/XaoflySho/XSRefresh")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        let header = XSRefreshNormalHeader {
            self.webView.load(self.request)
        }
        header.stateLabel.isHidden = true
        header.lastUpdatedTimeLabel.isHidden = true
        
        self.webView.scrollView.xs.header = header
        
        header.beginRefreshing()
    }

    deinit {
        print("Deinit")
    }
    
}

extension XSWKWebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.scrollView.xs.header?.endRefreshing()
    }
    
}
