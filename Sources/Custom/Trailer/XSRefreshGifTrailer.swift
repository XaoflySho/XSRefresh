//
//  XSRefreshGifTrailer.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/30.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

open class XSRefreshGifTrailer: XSRefreshTrailer {

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
    
    override open func prepare() {
        super.prepare()
        addSubview(gifView)
    }
    
    override open func placeSubviews() {
        super.placeSubviews()
        
        if self.gifView.constraints.count != 0 {
            return
        }
        
        gifView.frame = bounds
        gifView.contentMode = .center
    }
    
    override open var pullingPercent: CGFloat {
        didSet {
            guard state == .idle, let images = stateImages[.idle], images.count != 0 else {
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
    
    override open var state: XSRefresh.State {
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
