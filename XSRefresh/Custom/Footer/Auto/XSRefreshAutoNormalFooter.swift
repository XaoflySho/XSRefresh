//
//  XSRefreshAutoNormalFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/22.
//

import UIKit

open class XSRefreshAutoNormalFooter: XSRefreshAutoStateFooter {
    
    private(set) lazy var loadingView: UIActivityIndicatorView = {
        var style = UIActivityIndicatorView.Style.gray
        if #available(iOS 13.0, *) {
            style = UIActivityIndicatorView.Style.medium
        }
        let view = UIActivityIndicatorView(style: style)
        return view
    }()
    
    open override func prepare() {
        super.prepare()
        addSubview(loadingView)
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        
        if loadingView.constraints.count != 0 {
            return
        }
        
        var loadingCenterX = xs.width * 0.5;
        if !refreshingTitleHidden {
            loadingCenterX -= stateLabel.xs.textWidth * 0.5 + labelLeftInset;
        }
        let loadingCenterY = xs.height * 0.5;
        loadingView.center = CGPoint(x: loadingCenterX, y: loadingCenterY)
    }
    
    open override var state: XSRefresh.State {
        didSet {
            if state == .noMoreData || state == .idle {
                loadingView.stopAnimating()
            } else if state == .refreshing {
                loadingView.startAnimating()
            }
        }
    }
    
}
