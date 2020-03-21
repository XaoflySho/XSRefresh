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
    public class func footerRefresh(with block: @escaping XSRefreshComponentAction) -> XSRefreshFooter {
        let footer = self.init()
        footer.refreshingBlock = block
        return footer
    }
    
    /// 创建 Refresh Footerr
    /// - Parameters:
    ///   - target: 回调目标
    ///   - action: 回调方法
    public class func footerRefresh(with target: NSObject?, action: Selector?) -> XSRefreshFooter {
        let footer = self.init()
        footer.setRefreshing(target: target, action: action)
        return footer
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
    
    override func prepare() {
        super.prepare()
        
        xs.height = XSRefreshConst.footerHeight
    }
}
