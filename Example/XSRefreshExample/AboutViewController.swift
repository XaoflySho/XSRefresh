//
//  AboutViewController.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import WebKit
import XSRefresh

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let request = URLRequest(url: URL(string: "https://github.com/XaoflySho/XSRefresh")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        self.webView.scrollView.xs.header = XSRefreshNormalHeader {
            self.webView.load(self.request)
        }
        
        self.webView.scrollView.xs.header?.beginRefreshing()
    }

}

extension AboutViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.scrollView.xs.header?.endRefreshing()
    }
    
}
