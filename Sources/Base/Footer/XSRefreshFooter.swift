//
//  XSRefreshFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshFooter: XSRefreshComponent {
    
    /// 创建 Refresh Footer
    /// - Parameter block: 回调
    public class func footer(withRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshFooter {
        let footer = self.init()
        footer.refreshingBlock = block
        return footer
    }
    
    /// 创建 Refresh Footer
    /// - Parameter block: 回调
    public convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {
        self.init()
        self.refreshingBlock = block
    }
    
    /// 创建 Refresh Footerr
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public class func footer(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshFooter {
        let footer = self.init()
        footer.setRefreshing(target: target, action: action)
        return footer
    }
    
    /// 创建 Refresh Footerr
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public convenience init(withRefreshing target: NSObject?, action: Selector?) {
        self.init()
        self.setRefreshing(target: target, action: action)
    }
    
    /// 忽略 Scroll View 的 Content Inset 底部距离
    public var ignoredScrollViewContentInsetBottom: CGFloat = 0
    
    public func endRefreshingWithNoMoreData(completion block: (() -> Void)? = nil) {
        
        endRefreshingCompletionBlock = block
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state = .noMoreData
        }
    }
    
    public func resetNoMoreData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state = .idle
        }
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        self.xs.width = scrollView.xs.width
        self.xs.x     = scrollView.xs.insetLeft
        
        /// 打开垂直方向弹簧效果
        scrollView.alwaysBounceVertical = true
        /// 记录 Scroll View 初始 Inset
        scrollViewOriginalInset = scrollView.xs.inset
    }
    
    override open func prepare() {
        super.prepare()
        autoresizingMask = .flexibleWidth

        xs.height = XSRefreshConst.footerHeight
    }
}
