//
//  XSBundle.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import Foundation

extension Bundle {
    
    static var refreshBundle: Bundle {
        let bundle = Bundle(path: Bundle(for: XSRefresh.self).path(forResource: "XSRefresh", ofType: "bundle")!)!
        return bundle
    }
    
    class func localizedString(for key: String) -> String {
        return refreshBundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
}
