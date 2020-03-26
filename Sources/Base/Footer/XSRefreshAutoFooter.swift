//
//  XSRefreshAutoFooter.swift
//
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshAutoFooter: XSRefreshFooter {

    public var automaticallyRefresh: Bool = true
    
    public var triggerAutomaticallyRefreshPercent: CGFloat = 1.0
    
    public var autoTriggerTimes: Int = 1 {
        didSet {
            leftTriggerTimes = autoTriggerTimes
        }
    }
    
    private var triggerByDrag: Bool = false
    private var leftTriggerTimes: Int = 0
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let scrollView = scrollView else {
            return
        }
        if newSuperview != nil {
            if !isHidden {
                scrollView.xs.insetBottom += xs.height
            }
            xs.y = scrollView.xs.contentHeight
        } else {
            if !isHidden {
                scrollView.xs.insetBottom -= xs.height
            }
        }
    }
    
    override open func prepare() {
        super.prepare()
    }
    
    open override func scrollViewContentSizeDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change)
        guard let scrollView = scrollView else {
            return
        }
        xs.y = scrollView.xs.contentHeight + ignoredScrollViewContentInsetBottom
    }
    
    open override func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
        guard let scrollView = scrollView, let change = change else {
            return
        }
        
        xs.x = scrollView.contentOffset.x + scrollView.xs.insetLeft

        if state != .idle || !automaticallyRefresh || xs.y == 0 {
            return
        }
        
        if scrollView.xs.insetTop + scrollView.xs.contentHeight > scrollView.xs.height {
            if scrollView.xs.offsetY >= scrollView.xs.contentHeight - scrollView.xs.height + xs.height * triggerAutomaticallyRefreshPercent + scrollView.xs.insetBottom - xs.height {
                let old = change[.oldKey] as? CGPoint ?? CGPoint.zero
                let new = change[.newKey] as? CGPoint ?? CGPoint.zero
                if old.y <= new.y {
                    return
                }
                
                if scrollView.isDragging {
                    triggerByDrag = true
                }
                
                beginRefreshing()
            }
        }
    }
    
    open override func scrollViewPanStateDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewPanStateDidChange(change)
        
        guard state == .idle, let scrollView = scrollView else {
            return
        }
        
        let panState = scrollView.panGestureRecognizer.state
        
        switch panState {
        case .ended:
            if scrollView.xs.insetTop + scrollView.xs.contentHeight <= scrollView.xs.height {
                if scrollView.xs.offsetY >= -scrollView.xs.insetTop {
                    triggerByDrag = true
                    beginRefreshing()
                }
            } else {
                if scrollView.xs.offsetY >= scrollView.xs.contentHeight + scrollView.xs.insetBottom - scrollView.xs.height {
                    triggerByDrag = true
                    beginRefreshing()
                }
            }
        case .began:
            resetTriggerTimes()
        default:
            break
        }
    }
    
    private var unlimitedTrigger: Bool {
        return leftTriggerTimes == -1
    }
    
    public override func beginRefreshing(withCompletion block: (() -> Void)? = nil) {
        if triggerByDrag, leftTriggerTimes <= 0, !unlimitedTrigger {
            return
        }
        
        super.beginRefreshing(withCompletion: block)
    }
    
    override open var state: XSRefresh.State {
        didSet {
            guard let scrollView = self.scrollView else {
                return
            }
            
            if state == .refreshing {
                executeRefreshingCallback()
            } else if state == .noMoreData || state == .idle {
                if triggerByDrag {
                    if !unlimitedTrigger {
                        leftTriggerTimes -= 1
                    }
                    triggerByDrag = false
                }
                
                if oldValue == .refreshing {
                    if scrollView.isPagingEnabled {
                        var offset = scrollView.contentOffset
                        offset.y -= scrollView.xs.insetBottom
                        
                        UIView.animate(withDuration: XSRefreshConst.slowAnimationDuration, animations: {
                            scrollView.contentOffset = offset
                            self.endRefreshingAnimationBeginAction?()
                        }) { (_) in
                            self.endRefreshingCompletionBlock?()
                        }
                        return
                    }
                    
                    endRefreshingCompletionBlock?()
                }
            }
        }
    }
    
    func resetTriggerTimes() {
        leftTriggerTimes = autoTriggerTimes
    }
    
    override public var isHidden: Bool {
        willSet {
            if !isHidden, newValue {
                state = .idle
                
                scrollView?.xs.insetBottom -= xs.height
            } else if isHidden, !newValue {
                scrollView?.xs.insetBottom += xs.height
                
                xs.y = scrollView?.xs.contentHeight ?? 0
            }
        }
    }
}
