//
//  XSView.swift
//
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

extension XS where Base: UIView {
    var x: CGFloat {
        set {
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
        get {
            return base.frame.origin.x
        }
    }
    var y: CGFloat {
        set {
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
        get {
            return base.frame.origin.y
        }
    }
    var width: CGFloat {
        set {
            var frame = base.frame
            frame.size.width = newValue
            base.frame = frame
        }
        get {
            return base.frame.size.width
        }
    }
    var height: CGFloat {
        set {
            var frame = base.frame
            frame.size.height = newValue
            base.frame = frame
        }
        get {
            return base.frame.size.height
        }
    }
    var size: CGSize {
        set {
            var frame = base.frame
            frame.size = newValue
            base.frame = frame
        }
        get {
            return base.frame.size
        }
    }
    var origin: CGPoint {
        set {
            var frame = base.frame
            frame.origin = newValue
            base.frame = frame
        }
        get {
            return base.frame.origin
        }
    }
}
