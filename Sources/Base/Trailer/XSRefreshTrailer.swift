//
//  XSRefreshTrailer.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

open class XSRefreshTrailer: XSRefreshComponent {
    
    /// 创建 Refresh Trailer
    /// - Parameter block: 回调
    public class func trailer(withRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshTrailer {
        let trailer = self.init()
        trailer.refreshingBlock = block
        return trailer
    }
    
    /// 创建 Refresh Trailer
    /// - Parameter block: 回调
    public convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {
        self.init()
        self.refreshingBlock = block
    }
    
    /// 创建 Refresh Trailer
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public class func trailer(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshTrailer {
        let trailer = self.init()
        trailer.setRefreshing(target: target, action: action)
        return trailer
    }
    
    /// 创建 Refresh Trailer
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public convenience init(withRefreshing target: NSObject?, action: Selector?) {
        self.init()
        self.setRefreshing(target: target, action: action)
    }
    
    // MARK: -
    
    private var lastRefreshCount: Int = 0
    private var lastRightDelta: CGFloat = 0
    
    open override var state: XSRefresh.State {
        didSet {
            guard let scrollView = scrollView else {
                return
            }
            
            if state == .noMoreData || state == .idle {
                if oldValue == .refreshing {
                    UIView.animate(withDuration: XSRefreshConst.slowAnimationDuration, animations: {
                        self.endRefreshingAnimationBeginAction?()
                        scrollView.xs.insetRight -= self.lastRightDelta
                        
                        if self.automaticallyChangeAlpha {
                            self.alpha = 0.0
                        }
                    }) { (_) in
                        self.pullingPercent = 0.0
                        
                        self.endRefreshingCompletionBlock?()
                    }
                }
                
                let deltaWidth = widthForContentBreakView()
                if oldValue == .refreshing, deltaWidth > 0, scrollView.xs.totalDataCount != lastRefreshCount {
                    scrollView.xs.offsetX = scrollView.xs.offsetX
                }
                
            } else if state == .refreshing {
                lastRefreshCount = scrollView.xs.totalDataCount
                
                UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration, animations: {
                    var right = self.xs.width + self.scrollViewOriginalInset.right
                    let daltaWidth = self.widthForContentBreakView()
                    if daltaWidth < 0 {
                        right -= daltaWidth
                    }
                    self.lastRightDelta = right - scrollView.xs.insetRight
                    scrollView.xs.insetRight = right
                    scrollView.xs.offsetX = self.getHappenOffsetX() + self.xs.width
                }) { (_) in
                    self.executeRefreshingCallback()
                }
            }
        }
    }
    
    open override func prepare() {
        super.prepare()
        autoresizingMask = .flexibleHeight
        
        xs.width = XSRefreshConst.trailerWidth
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        
        if let scrollView = scrollView {
            if #available(iOS 11.0, *) {
                xs.height = scrollView.xs.safeAreaHeight
            } else {
                xs.height = scrollView.xs.height
            }
        }
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        /// 打开水平方向弹簧效果
        scrollView.alwaysBounceHorizontal = true
        /// 记录 Scroll View 初始 Inset
        scrollViewOriginalInset = scrollView.xs.inset
        
        scrollViewContentSizeDidChange(nil)
    }
    
    open override func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
        
        guard let scrollView = scrollView else {
            return
        }
        
        xs.y = scrollView.contentOffset.y + scrollView.xs.insetTop
        
        guard state != .refreshing else {
            return
        }
        
        scrollViewOriginalInset = scrollView.xs.inset
        let currentOffsetX = scrollView.xs.offsetX
        let happenOffsetX = getHappenOffsetX()
        if currentOffsetX <= happenOffsetX {
            return
        }
        let pullingPercent = (currentOffsetX - happenOffsetX) / xs.width
        if state == .noMoreData {
            self.pullingPercent = pullingPercent
        }
        
        if scrollView.isDragging {
            self.pullingPercent = pullingPercent
            let normalPullingOffsetX = happenOffsetX + xs.width
            if state == .idle, currentOffsetX > normalPullingOffsetX {
                state = .pulling
            } else if state == .pulling, currentOffsetX <= normalPullingOffsetX {
                state = .idle
            }
        } else if state == .pulling {
            beginRefreshing()
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
    
    open override func scrollViewContentSizeDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change)
        guard let scrollView = scrollView else {
            return
        }
        let contentWidth = scrollView.xs.contentWidth
        let scrollWidth = scrollView.xs.width - scrollViewOriginalInset.left - scrollViewOriginalInset.right
        xs.x = max(contentWidth, scrollWidth)
    }
    
    private func getHappenOffsetX() -> CGFloat {
        let deltaWidth = widthForContentBreakView()
        if deltaWidth > 0 {
            return deltaWidth - scrollViewOriginalInset.left
        } else {
            return -scrollViewOriginalInset.left
        }
    }
    
    private func widthForContentBreakView() -> CGFloat {
        guard let scrollView = scrollView else {
            return 0.0
        }
        let width = scrollView.xs.width - scrollViewOriginalInset.left - scrollViewOriginalInset.right
        return scrollView.contentSize.width - width
    }
}
