//
//  XSExtension.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import Foundation
import UIKit

extension UILabel {
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

extension Bundle {
    
    static var refreshBundle: Bundle {
#if SWIFT_PACKAGE
        let containnerBundle = Bundle.module
#else
        let containnerBundle = Bundle(for: XSRefresh.self)
#endif
        let bundle = Bundle(path: containnerBundle.path(forResource: "XSRefresh", ofType: "bundle")!)!
        return bundle
    }
    
    class func localizedString(for key: String) -> String {
        return refreshBundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
}

extension UIImage {
    
    class func loadImage(named name: String) -> UIImage? {
        return self.init(named: name, in: Bundle.refreshBundle, compatibleWith: nil)
    }
    
}

extension XS where Base: UILabel {
    var textWidth: CGFloat {
        var stringWidth: CGFloat = 0.0
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        if let attributedText = base.attributedText {
            if attributedText.length == 0 {
                return 0
            }
            let bound = attributedText.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
            stringWidth = bound.width
        } else if let text = base.text {
            if text.count == 0 {
                return 0
            }
            let bound = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: base.font!], context: nil)
            stringWidth = bound.width
        }
        
        return stringWidth
    }
}
