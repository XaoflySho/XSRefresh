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
        
        xs.width = XSRefreshConst.trailerWidth
    }
}
