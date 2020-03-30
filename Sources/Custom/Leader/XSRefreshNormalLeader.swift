//
//  XSRefreshNormalLeader.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/30.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

open class XSRefreshNormalLeader: XSRefreshLeader {
    
    private(set) lazy var arrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage.loadImage(named: "arrow"))
        imageView.transform = .init(rotationAngle: -CGFloat.pi / 2)
        return imageView
    }()
    
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
        addSubview(arrowView)
        addSubview(loadingView)
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        
        let arrowCenterX = xs.width * 0.5
        let arrowCenterY = xs.height * 0.5
        let arrowCenter = CGPoint(x: arrowCenterX, y: arrowCenterY)
        
        if arrowView.constraints.count == 0 {
            arrowView.xs.size = CGSize(width: arrowView.image?.size.height ?? 0, height: arrowView.image?.size.width ?? 0)
            arrowView.center = arrowCenter
        }
        
        if loadingView.constraints.count == 0 {
            loadingView.center = arrowCenter
        }
    }
    
    open override var state: XSRefresh.State {
        didSet {
            if state == .idle {
                if oldValue == .refreshing {
                    arrowView.transform = .init(rotationAngle: -CGFloat.pi / 2)
                    
                    UIView.animate(withDuration: XSRefreshConst.slowAnimationDuration, animations: {
                        self.loadingView.alpha = 0.0
                    }) { (_) in
                        if self.state != .idle {
                            return
                        }
                        self.loadingView.alpha = 1.0
                        self.loadingView.stopAnimating()
                        self.arrowView.isHidden = false
                    }
                } else {
                    loadingView.stopAnimating()
                    arrowView.isHidden = false
                    UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration) {
                        self.arrowView.transform = .init(rotationAngle: -CGFloat.pi / 2)
                    }
                }
            } else if state == .pulling {
                loadingView.stopAnimating()
                arrowView.isHidden = false
                UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration) {
                    self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                }
            } else if state == .refreshing {
                loadingView.alpha = 1.0
                loadingView.startAnimating()
                arrowView.isHidden = true
            }
        }
    }
    
}
