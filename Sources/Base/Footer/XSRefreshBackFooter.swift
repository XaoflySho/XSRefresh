//
//  XSRefreshBackFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshBackFooter: XSRefreshFooter {
    
    private var lastRefreshCount: Int = 0
    private var lastBottomDelta: CGFloat = 0
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        scrollViewContentSizeDidChange(nil)
    }
    
    open override func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
        
        guard state != .refreshing, let scrollView = scrollView else {
            return
        }
        
        scrollViewOriginalInset = scrollView.xs.inset
        let currentOffsetY = scrollView.xs.offsetY
        let happenOffsetY = getHappenOffsetY()
        if currentOffsetY <= happenOffsetY {
            return
        }
        let pullingPercent = (currentOffsetY - happenOffsetY) / xs.height;
        if state == .noMoreData {
            self.pullingPercent = pullingPercent
        }
        
        if scrollView.isDragging {
            self.pullingPercent = pullingPercent
            let normalPullingOffsetY = happenOffsetY + xs.height;
            if state == .idle, currentOffsetY > normalPullingOffsetY {
                state = .pulling
            } else if state == .pulling, currentOffsetY <= normalPullingOffsetY {
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
        let contentHeight = scrollView.xs.contentHeight + ignoredScrollViewContentInsetBottom;
        let scrollHeight = scrollView.xs.height - scrollViewOriginalInset.top - scrollViewOriginalInset.bottom + ignoredScrollViewContentInsetBottom;
        xs.y = max(contentHeight, scrollHeight)
    }
    
    override open var state: XSRefresh.State {
        didSet {
            guard let scrollView = self.scrollView else {
                return
            }
            
            if state == .noMoreData || state == .idle {
                if oldValue == .refreshing {
                    UIView.animate(withDuration: XSRefreshConst.slowAnimationDuration, animations: {
                        self.endRefreshingAnimationBeginAction?()
                        scrollView.xs.insetBottom -= self.lastBottomDelta;

                        if self.automaticallyChangeAlpha {
                            self.alpha = 0.0
                        }
                    }) { (_) in
                        self.pullingPercent = 0.0
                        
                        self.endRefreshingCompletionBlock?()
                    }
                }
                
                let deltaHeight = heightForContentBreakView()
                if oldValue == .refreshing, deltaHeight > 0, scrollView.xs.totalDataCount != lastRefreshCount {
                    scrollView.xs.offsetY = scrollView.xs.offsetY
                }

            } else if state == .refreshing {
                lastRefreshCount = scrollView.xs.totalDataCount
                
                UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration, animations: {
                    var bottom = self.xs.height + self.scrollViewOriginalInset.bottom
                    let deltaHeight = self.heightForContentBreakView()
                    if deltaHeight < 0 {
                        bottom -= deltaHeight
                    }
                    self.lastBottomDelta = bottom - scrollView.xs.insetBottom
                    scrollView.xs.insetBottom = bottom
                    scrollView.xs.offsetY = self.getHappenOffsetY() + self.xs.height
                }) { (_) in
                    self.executeRefreshingCallback()
                }
            }
        }
    }
    
    private func getHappenOffsetY() -> CGFloat {
        let deltaHeight = heightForContentBreakView()
        if deltaHeight > 0 {
            return deltaHeight - scrollViewOriginalInset.top
        } else {
            return -scrollViewOriginalInset.top
        }
    }
    
    private func heightForContentBreakView() -> CGFloat {
        guard let scrollView = scrollView else {
            return 0.0
        }
        let height = scrollView.xs.height - scrollViewOriginalInset.bottom - scrollViewOriginalInset.top
        return scrollView.contentSize.height - height
    }
}
