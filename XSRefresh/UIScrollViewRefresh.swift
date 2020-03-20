//
//  UIScrollViewRefresh.swift
//
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

private var headerKey: UInt8 = 0
private var footerKey: UInt8 = 0
public extension UIScrollView {
    var header: XSRefreshHeader? {
        set {
            if let newHeader = newValue {
                if header != newValue {
                    header?.removeFromSuperview()
                    self.insertSubview(newHeader, at: 0)
                    
                    objc_setAssociatedObject(self, &headerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            } else {
                header?.removeFromSuperview()
            }
        }
        get {
            return objc_getAssociatedObject(self, &headerKey) as? XSRefreshHeader
        }
    }
}

