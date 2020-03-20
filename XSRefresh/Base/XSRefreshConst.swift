//
//  XSRefreshConst.swift
//  
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

public struct XSRefreshConst {
    static let labelLeftInset : CGFloat = 25.0
    static let headerHeight   : CGFloat = 54.0
    static let footerHeight   : CGFloat = 44.0
    static let fastAnimationDuration    = 0.25
    static let slowAnimationDuration    = 0.4
}

struct XSRefreshKeyPath {
    static let contentOffset = "contentOffset"
    static let contentInset  = "contentInset"
    static let contentSize   = "contentSize"
    static let panState      = "state"
}

public struct XSRefreshHeaderConst {
    static let lastUpdateTimeKey = "XSRefreshHeaderLastUpdateTimeKey"
    static let idleText          = "XSRefreshHeaderIdleText"
    static let pullingText       = "XSRefreshHeaderPullingText"
    static let refreshingText    = "XSRefreshHeaderRefreshingText"

    static let lastTimeText      = "XSRefreshHeaderLastTimeText"
    static let dateTodayText     = "XSRefreshHeaderDateTodayText"
    static let noneLastDateText  = "XSRefreshHeaderNoneLastDateText"
}
