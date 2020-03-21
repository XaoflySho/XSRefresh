//
//  XSRefresh.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import Foundation
import UIKit

public class XSRefresh {
    /// 刷新控件的状态
    public enum State: Int {
        /// 闲置
        case idle = 1
        /// 松开就可以进行刷新
        case pulling
        /// 正在刷新中
        case refreshing
        /// 即将刷新
        case willRefresh
        /// 没有更多的数据
        case noMoreData
    }
}

public typealias XSRefreshComponentAction = () -> Void

