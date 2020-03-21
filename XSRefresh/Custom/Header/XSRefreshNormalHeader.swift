//
//  XSRefreshNormalHeader.swift
//  Pods-XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

public class XSRefreshNormalHeader: XSRefreshStateHeader {
    
    private(set) var arrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage.loadImage(named: "arrow"))
        return imageView
    }()
    
    private(set) var loadingView: UIActivityIndicatorView = {
        var style = UIActivityIndicatorView.Style.gray
        if #available(iOS 13.0, *) {
            style = UIActivityIndicatorView.Style.medium
        }
        let view = UIActivityIndicatorView(style: style)
        return view
    }()
    
    override func prepare() {
        super.prepare()
        addSubview(arrowView)
        addSubview(loadingView)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        var arrowCenterX = xs.width * 0.5
        if !stateLabel.isHidden {
            let stateWidth = stateLabel.xs.textWidth
            var timeWidth: CGFloat = 0.0
            if !lastUpdatedTimeLabel.isHidden {
                timeWidth = lastUpdatedTimeLabel.xs.textWidth
            }
            let textWidth = max(stateWidth, timeWidth)
            arrowCenterX -= textWidth / 2 + labelLeftInset
        }
        
        let arrowCenterY = xs.height * 0.5
        let arrowCenter = CGPoint(x: arrowCenterX, y: arrowCenterY)
        
        if arrowView.constraints.count == 0 {
            arrowView.xs.size = arrowView.image?.size ?? CGSize.zero
            arrowView.center = arrowCenter
        }
        
        if loadingView.constraints.count == 0 {
            loadingView.center = arrowCenter
        }
        
        self.arrowView.tintColor = self.stateLabel.textColor
    }
    
    override var state: XSRefresh.State {
        didSet {
            if state == .idle {
                if oldValue == .refreshing {
                    arrowView.transform = .identity
                    
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
                        self.arrowView.transform = .identity
                    }
                }
            } else if state == .pulling {
                loadingView.stopAnimating()
                arrowView.isHidden = false
                UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration) {
                    self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }
            } else if state == .refreshing {
                loadingView.alpha = 1.0
                loadingView.startAnimating()
                arrowView.isHidden = true
            }
        }
    }
}
