//
//  XSExtension.swift
//
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

public final class XS<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol XSCompatible {}

public extension XSCompatible {
    var xs: XS<Self> {
        get {
            return XS(self)
        }
    }
    
    static var xs: XS<Self>.Type {
        get {
            return XS<Self>.self
        }
    }
}

extension UIView: XSCompatible {}
