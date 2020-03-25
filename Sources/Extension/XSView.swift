//
//  XSView.swift
//
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

public extension XS where Base: UIView {
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

public extension XS where Base: UIView {
    var cornerRadius: CGFloat {
        set {
            base.layer.cornerRadius = newValue
        }
        get {
            return base.layer.cornerRadius
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return base.layer.borderWidth
        }
        set {
            base.layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            if let color = base.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            base.layer.borderColor = newValue?.cgColor
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            return base.layer.shadowRadius
        }
        set {
            base.layer.shadowRadius = newValue
        }
    }
    
    var shadowOpacity: Float {
        get {
            return base.layer.shadowOpacity
        }
        set {
            base.layer.shadowOpacity = newValue
        }
    }
    
    var shadowColor: UIColor? {
        get {
            if let color = base.layer.shadowColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            base.layer.shadowColor = newValue?.cgColor
        }
    }
    
    var shadowOffset: CGSize {
        get {
            return base.layer.shadowOffset
        }
        set {
            base.layer.shadowOffset = newValue
        }
    }
}
