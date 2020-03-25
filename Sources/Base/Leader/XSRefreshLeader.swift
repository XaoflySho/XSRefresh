//
//  XSRefreshLeader.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

open class XSRefreshLeader: XSRefreshComponent {
    
    /// 创建 Refresh Leader
    /// - Parameter block: 回调
    public class func leader(WithRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshLeader {
        let leader = self.init()
        leader.refreshingBlock = block
        return leader
    }
    
    /// 创建 Refresh Leader
    /// - Parameter block: 回调
    public convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {
        self.init()
        self.refreshingBlock = block
    }
    
    /// 创建 Refresh Leader
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public class func leader(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshLeader {
        let leader = self.init()
        leader.setRefreshing(target: target, action: action)
        return leader
    }
    
    /// 创建 Refresh Leader
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public convenience init(withRefreshing target: NSObject?, action: Selector?) {
        self.init()
        self.setRefreshing(target: target, action: action)
    }
    
    // MARK: - Private
    private var insetLDelta: CGFloat = 0
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        self.xs.height = scrollView.xs.height
        self.xs.y      = scrollView.xs.insetTop
        
        /// 打开水平方向弹簧效果
        scrollView.alwaysBounceHorizontal = true
        /// 记录 Scroll View 初始 Inset
        scrollViewOriginalInset = scrollView.xs.inset
    }
    
    
    open override func prepare() {
        super.prepare()
        autoresizingMask = .flexibleHeight

        xs.width = XSRefreshConst.leaderWidth
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        
        xs.x = -xs.width
    }
    
    open override var state: XSRefresh.State {
        didSet {
            guard let scrollView = self.scrollView else {
                return
            }
            
            switch state {
            case .idle:
                if oldValue != .refreshing {
                    return
                }
                scrollView.isUserInteractionEnabled = false
                
                UIView.animate(withDuration: XSRefreshConst.slowAnimationDuration, animations: {
                    scrollView.xs.insetLeft += self.insetLDelta
                    if self.automaticallyChangeAlpha {
                        self.alpha = 0.0
                    }
                }) { (_) in
                    scrollView.isUserInteractionEnabled = true
                    self.pullingPercent = 0.0
                    self.endRefreshingCompletionBlock?()
                }
            case .refreshing:
                if scrollView.panGestureRecognizer.state == .cancelled {
                    self.executeRefreshingCallback()
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    scrollView.isUserInteractionEnabled = false
                    
                    UIView.animate(withDuration: XSRefreshConst.fastAnimationDuration, animations: {
                        let left = self.scrollViewOriginalInset.left + self.xs.width
                        scrollView.xs.insetLeft = left
                        var offset = scrollView.contentOffset
                        offset.x = -left
                        scrollView.setContentOffset(offset, animated: false)
                    }) { (_) in
                        scrollView.isUserInteractionEnabled = true
                        self.executeRefreshingCallback()
                    }
                }
            default:
                break
            }
        }
    }
    
    open override func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
        
        guard let scrollView = self.scrollView else { return }
        if state == .refreshing {
            
            var insetLeft = max(-scrollView.xs.offsetX, scrollViewOriginalInset.left)
            insetLeft = min(insetLeft, xs.width + scrollViewOriginalInset.left)
            scrollView.xs.insetLeft = insetLeft
            insetLDelta = scrollViewOriginalInset.left - insetLeft
            
            return
        }
        
        scrollViewOriginalInset = scrollView.xs.inset
        
        let offsetX = scrollView.xs.offsetX
        let happenOffsetX = -scrollViewOriginalInset.left
        
        if offsetX > happenOffsetX {
            return
        }
        
        let normalPullingOffsetX = happenOffsetX - xs.width
        let pullingPercent = (happenOffsetX - offsetX) / xs.width
        
        if scrollView.isDragging {
            self.pullingPercent = pullingPercent
            if self.state == .idle && offsetX < normalPullingOffsetX {
                self.state = .pulling
            } else if self.state == .pulling && offsetX >= normalPullingOffsetX {
                self.state = .idle
            }
        } else if self.state == .pulling {
            self.beginRefreshing()
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
}

