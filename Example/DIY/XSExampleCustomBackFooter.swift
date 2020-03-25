//
//  XSExampleCustomBackFooter.swift
//  Example
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class XSExampleCustomBackFooter: XSRefreshBackFooter {
    
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
            
        stateLabel.text = "上拉查看更多内容😋"

        xs.height = 30
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        stateLabel.frame = bounds
        loadingView.frame = bounds
    }
    
    override var state: XSRefresh.State {
        didSet {
            switch state {
            case .idle:
                stateLabel.text = "上拉查看更多内容😋"
                stateLabel.isHidden = false
                loadingView.stopAnimating()
            case .pulling:
                stateLabel.text = "松开加载更多内容😋"
                stateLabel.isHidden = false
                loadingView.stopAnimating()
            case .refreshing:
                stateLabel.isHidden = true
                stateLabel.text = nil
                loadingView.startAnimating()
            case .noMoreData:
                stateLabel.text = "我已经被你看完了😱"
                stateLabel.isHidden = false
                loadingView.stopAnimating()
            default:
                break
            }
        }
    }
    
    override var pullingPercent: CGFloat {
        didSet {
            loadingView.alpha = pullingPercent * 2
        }
    }
}
