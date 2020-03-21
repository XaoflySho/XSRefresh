//
//  XSLabel.swift
//
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

public extension UILabel {
    class func standard() -> UILabel {
        let label = self.init()
        label.font             = XSRefreshLabelFont
        label.textColor        = XSRefreshLabelTextColor
        label.autoresizingMask = .flexibleWidth
        label.textAlignment    = .center
        label.backgroundColor  = .clear
        return label
    }
}
