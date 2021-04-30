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
    
    @objc func example41() {
        XSRefreshNormalHeader { [weak self] in
            self?.webView.reload()
        }
        .autoChangeTransparency(true)
        .afterBeginningAction {
            
        }
        .link(to: webView.scrollView)
        
        webView.scrollView.xs.header?.beginRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        webView.load(request)
        example41()
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
