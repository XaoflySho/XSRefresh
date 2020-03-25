//
//  XSExampleCustomHeader.swift
//  Example
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class XSExampleCustomHeader: XSRefreshHeader {
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
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
        addSubview(stateLabel)
        addSubview(loadingView)
        
        xs.height = 44
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        stateLabel.frame = bounds
        stateLabel.xs.y = 14
        stateLabel.xs.height = 30
        loadingView.frame = bounds
        loadingView.xs.y = 14
        loadingView.xs.height = 30
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewPanStateDidChange(change)
    }
    
    override var state: XSRefresh.State {
        didSet {
            switch state {
            case .idle:
                loadingView.stopAnimating()
                stateLabel.text = "下拉刷新"
                stateLabel.isHidden = false
            case .pulling:
                loadingView.stopAnimating()
                stateLabel.text = "松开刷新"
                stateLabel.isHidden = false
            case .refreshing:
                loadingView.startAnimating()
                stateLabel.text = nil
                stateLabel.isHidden = true
            default:
                break
            }
        }
    }
    
    override var pullingPercent: CGFloat {
        didSet {
            stateLabel.alpha = pullingPercent * 2
        }
    }
}
