//
//  Extension.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/23.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

private var MethodKey: UInt8 = 0
public extension UIViewController {
    
    var methodString: String {
        set {
            objc_setAssociatedObject(self, &MethodKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &MethodKey) as? String ?? ""
        }
    }
}
