//
//  XSRefreshAutoGifFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/22.
//

import UIKit

open class XSRefreshAutoGifFooter: XSRefreshAutoStateFooter {
    
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
    
    private var stateImages: [XSRefresh.State: [UIImage]] = [:]
    private var stateDurations: [XSRefresh.State: TimeInterval] = [:]
    
    open override func prepare() {
        super.prepare()
        addSubview(gifView)
        
        labelLeftInset = 20
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        
        if gifView.constraints.count != 0 {
            return
        }
        
        gifView.frame = bounds;
        
        if refreshingTitleHidden {
            gifView.contentMode = .center;
        } else {
            gifView.contentMode = .right;
            
            gifView.xs.width = xs.width * 0.5 - labelLeftInset - stateLabel.xs.textWidth * 0.5
        }
    }
    
    open override var state: XSRefresh.State {
        didSet {
            
            if state == .refreshing {
                guard let images = stateImages[state], images.count != 0 else {
                    return
                }
                gifView.stopAnimating()
                
                gifView.isHidden = false
                if images.count == 1 {
                    gifView.image = images.last!
                } else {
                    gifView.animationImages = images
                    gifView.animationDuration = stateDurations[state] ?? Double(images.count) * 0.1
                    gifView.startAnimating()
                }
            } else if state == .idle || state == .noMoreData {
                gifView.stopAnimating()
                gifView.isHidden = true
            }
        }
    }
}
