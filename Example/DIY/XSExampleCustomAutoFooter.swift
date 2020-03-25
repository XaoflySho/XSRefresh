//
//  XSExampleCustomAutoFooter.swift
//  Example
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class XSExampleCustomAutoFooter: XSRefreshAutoFooter {
    
    lazy var loadingView: UIActivityIndicatorView = {
        var style = UIActivityIndicatorView.Style.gray
        if #available(iOS 13.0, *) {
            style = UIActivityIndicatorView.Style.medium
        }
        let view = UIActivityIndicatorView(style: style)
        return view
    }()
    
    override func prepare() {
        super.prepare()
        addSubview(loadingView)
    
        xs.height = 30
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        loadingView.frame = bounds
    }
    
    override var state: XSRefresh.State {
        didSet {
            if state == .refreshing {
                loadingView.startAnimating()
            } else {
                loadingView.stopAnimating()
            }
        }
    }
    
    override var pullingPercent: CGFloat {
        didSet {
            loadingView.alpha = pullingPercent * 2
        }
    }
    
}
