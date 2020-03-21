//
//  XSRefreshGifHeader.swift
//  Pods-XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshGifHeader: XSRefreshStateHeader {
    
    private(set) lazy var gifView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    public func setImages(_ images: [UIImage], duration: TimeInterval? = nil, for state: XSRefresh.State) {
        guard images.count > 0 else {
            return
        }
        
        var duration = duration
        if duration == nil {
            duration = Double(images.count) * 0.1
        }
        
        stateImages[state] = images
        stateDurations[state] = duration
        
        let image = images.first!
        if image.size.height > xs.height {
            xs.height = image.size.height
        }
    }
    
    var stateImages: [XSRefresh.State: [UIImage]] = [:]
    var stateDurations: [XSRefresh.State: TimeInterval] = [:]
    
    override open func prepare() {
        super.prepare()
        addSubview(gifView)
        
        labelLeftInset = 20
    }
    
    override open func placeSubviews() {
        super.placeSubviews()
        
        if self.gifView.constraints.count != 0 {
            return
        }
        
        gifView.frame = bounds
        
        if stateLabel.isHidden, lastUpdatedTimeLabel.isHidden {
            gifView.contentMode = .center
        } else {
            gifView.contentMode = .right
            
            let stateWidth = stateLabel.xs.textWidth
            var timeWidth: CGFloat = 0
            if !lastUpdatedTimeLabel.isHidden {
                timeWidth = lastUpdatedTimeLabel.xs.textWidth
            }
            let textWidth = max(stateWidth, timeWidth)
            
            gifView.xs.width = xs.width * 0.5 - textWidth * 0.5 - labelLeftInset
        }
    }
    
    override var pullingPercent: CGFloat {
        didSet {
            guard let images = stateImages[.idle] else {
                return
            }
            if state != .idle || images.count == 0 {
                return
            }
            gifView.stopAnimating()
            var index = Int(CGFloat(images.count) * pullingPercent)
            if index >= images.count {
                index = images.count - 1
            }
            gifView.image = images[index]
        }
    }
    
    override var state: XSRefresh.State {
        didSet {
            if state == .pulling || state == .refreshing {
                guard let images = stateImages[state], images.count != 0 else {
                    return
                }
                gifView.stopAnimating()
                if images.count == 1 {
                    gifView.image = images.last
                } else {
                    gifView.animationImages = images
                    gifView.animationDuration = stateDurations[state] ?? Double(images.count) * 0.1
                    gifView.startAnimating()
                }
            } else if state == .idle {
                gifView.stopAnimating()
            }
        }
    }
}
