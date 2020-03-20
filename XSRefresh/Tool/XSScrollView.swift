//
//  XSScrollView.swift
//  
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

extension XS where Base: UIScrollView {
    
    var inset: UIEdgeInsets {
        get {
            if #available(iOS 11.0, *) {
                return base.adjustedContentInset
            } else {
                return base.contentInset
            }
        }
    }
    
    var insetTop: CGFloat {
        set {
            var inset = base.contentInset
            inset.top = newValue
            if #available(iOS 11.0, *) {
                inset.top -= (base.adjustedContentInset.top - base.contentInset.top)
            }
            base.contentInset = inset
        }
        get {
            return inset.top
        }
    }
    
    var insetRight: CGFloat {
        set {
            var inset = base.contentInset
            inset.right = newValue
            if #available(iOS 11.0, *) {
                inset.right -= (base.adjustedContentInset.right - base.contentInset.right)
            }
            base.contentInset = inset
        }
        get {
            return inset.right
        }
    }
    
    var insetBottom: CGFloat {
        set {
            var inset = base.contentInset
            inset.bottom = newValue
            if #available(iOS 11.0, *) {
                inset.bottom -= (base.adjustedContentInset.bottom - base.contentInset.bottom)
            }
            base.contentInset = inset
        }
        get {
            return inset.bottom
        }
    }
    
    var insetLeft: CGFloat {
        set {
            var inset = base.contentInset
            inset.left = newValue
            if #available(iOS 11.0, *) {
                inset.left -= (base.adjustedContentInset.left - base.contentInset.left)
            }
            base.contentInset = inset
        }
        get {
            return inset.left
        }
    }
    
    var offsetX: CGFloat {
        set {
            var offset = base.contentOffset
            offset.x = newValue
            base.contentOffset = offset
        }
        get {
            return base.contentOffset.x
        }
    }
    
    var offsetY: CGFloat {
        set {
            var offset = base.contentOffset
            offset.y = newValue
            base.contentOffset = offset
        }
        get {
            return base.contentOffset.y
        }
    }
    
    var contentW: CGFloat {
        set {
            var size = base.contentSize
            size.width = newValue
            base.contentSize = size
        }
        get {
            return base.contentSize.width
        }
    }
    var contentH: CGFloat {
        set {
            var size = base.contentSize
            size.height = newValue
            base.contentSize = size
        }
        get {
            return base.contentSize.height
        }
    }
}