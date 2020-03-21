//
//  XSRefreshBackNormalFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/22.
//

import UIKit

open class XSRefreshBackNormalFooter: XSRefreshBackStateFooter {
    
    private(set) lazy var arrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage.loadImage(named: "arrow"))
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

    override open func prepare() {
        super.prepare()
        addSubview(arrowView)
        addSubview(loadingView)
    }
    
    override open func placeSubviews() {
        super.placeSubviews()
        
        var arrowCenterX = xs.width * 0.5;
        if !stateLabel.isHidden {
            arrowCenterX -= labelLeftInset + stateLabel.xs.textWidth * 0.5;
        }
        let arrowCenterY = xs.height * 0.5;
        let arrowCenter = CGPoint(x: arrowCenterX, y: arrowCenterY);
        
        if arrowView.constraints.count == 0 {
            arrowView.xs.size = arrowView.image?.size ?? CGSize.zero
            arrowView.center = arrowCenter
        }
        
        if loadingView.constraints.count == 0 {
            loadingView.center = arrowCenter
        }
        
        arrowView.tintColor = stateLabel.textColor
    }
    
    override open var state: XSRefresh.State {
        didSet {
            if state == .idle {
                if oldValue == .refreshing {
                    arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    
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
                    arrowView.isHidden = false
                    loadingView.stopAnimating()
                    
                    UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration) {
                        self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    }
                }
            } else if state == .pulling {
                arrowView.isHidden = false
                
                self.loadingView.stopAnimating()
                UIView.animate(withDuration:XSRefreshConst.fastAnimationDuration) {
                    self.arrowView.transform = .identity
                }
            } else if state == .refreshing {
                arrowView.isHidden = true
                loadingView.startAnimating()
            } else if state == .noMoreData {
                arrowView.isHidden = true
                loadingView.stopAnimating()
            }
        }
    }
    
}
