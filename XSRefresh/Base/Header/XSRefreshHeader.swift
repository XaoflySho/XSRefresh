//
//  XSRefreshHeader.swift
//
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

open class XSRefreshHeader: XSRefreshComponent {

    
    /// 创建 Refresh Header
    /// - Parameter block: 回调
    public class func header(WithRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshHeader {
        let header = self.init()
        header.refreshingBlock = block
        return header
    }
    
    /// 创建 Refresh Header
    /// - Parameter block: 回调
    public convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {
        self.init()
        self.refreshingBlock = block
    }
    
    /// 创建 Refresh Header
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public class func header(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshHeader {
        let header = self.init()
        header.setRefreshing(target: target, action: action)
        return header
    }
    
    /// 创建 Refresh Header
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public convenience init(withRefreshing target: NSObject?, action: Selector?) {
        self.init()
        self.setRefreshing(target: target, action: action)
    }
    
    open var lastUpdatedTimeKey: String = XSRefreshHeaderConst.lastUpdateTimeKey
    open var lastUpdatedTime: Date? {
        return UserDefaults.standard.object(forKey: lastUpdatedTimeKey) as? Date
    }
    
    /// 忽略 Scroll View 的 Content Inset 顶部距离
    open var ignoredScrollViewContentInsetTop: CGFloat = 0 {
        didSet {
            self.xs.y = -self.xs.height - ignoredScrollViewContentInsetTop
        }
    }
    
    // MARK: - Private
    private var insetTDelta: CGFloat = 0
    
    override open func prepare() {
        super.prepare()
        
        xs.height = XSRefreshConst.headerHeight
    }
    
    override open func placeSubviews() {
        super.placeSubviews()
        
        xs.y = -xs.height - ignoredScrollViewContentInsetTop
    }
    
    override open var state: XSRefresh.State {
        didSet {
            guard let scrollView = self.scrollView else {
                return
            }
            
            switch state {
            case .idle:
                if oldValue != .refreshing {
                    return
                }
                UserDefaults.standard.set(Date(), forKey: lastUpdatedTimeKey)
                UserDefaults.standard.synchronize()
                                
                scrollView.isUserInteractionEnabled = false
                
                UIView.animate(withDuration: XSRefreshConst.slowAnimationDuration, animations: {
                    scrollView.xs.insetTop += self.insetTDelta
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
                        let top = self.scrollViewOriginalInset.top + self.xs.height
                        scrollView.xs.insetTop = top
                        var offset = scrollView.contentOffset
                        offset.y = -top
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
    
    override func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
        
        guard let scrollView = self.scrollView else { return }
        if self.state == .refreshing {
            
            var insetTop = max(-scrollView.xs.offsetY, scrollViewOriginalInset.top)
            insetTop = min(insetTop, xs.height + scrollViewOriginalInset.top)
            scrollView.xs.insetTop = insetTop
            insetTDelta = scrollViewOriginalInset.top - insetTop
            
            return
        }
        
        scrollViewOriginalInset = scrollView.xs.inset
        
        let offsetY = scrollView.xs.offsetY
        let happenOffsetY = -scrollViewOriginalInset.top
        
        if offsetY > happenOffsetY {
            return
        }
        
        // 普通 和 即将刷新 的临界点
        let normalPullingOffsetY = happenOffsetY - xs.height
        let pullingPercent = (happenOffsetY - offsetY) / xs.height
        // 如果正在拖拽
        if scrollView.isDragging {
            self.pullingPercent = pullingPercent
            if self.state == .idle && offsetY < normalPullingOffsetY {
                // 转为即将刷新状态
                self.state = .pulling
            } else if self.state == .pulling && offsetY >= normalPullingOffsetY {
                // 转为普通状态
                self.state = .idle
            }
        } else if self.state == .pulling { // 即将刷新 && 手松开
            //开始刷新
            self.beginRefreshing()
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
}
