//
//  XSRefreshConfig.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/30.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

public class XSRefreshConfig: NSObject {
    
    static let `default`: XSRefreshConfig = XSRefreshConfig()
    
    //
    public var automaticallyChangeAlpha: Bool = false
    
    // MARK: - Header
    var headerStateText: [XSRefresh.State: String] = [:]
    /// 设置全局默认 Header 标题
    /// - Parameters:
    ///   - text: text
    ///   - state: state
    public func setHeaderTitle(_ text: String, for state: XSRefresh.State) {
        headerStateText[state] = text
    }
    
    // MARK: - Footer
    var autoFooterStateText: [XSRefresh.State: String] = [:]
    /// 设置全局默认 Auto Footer 标题
    /// - Parameters:
    ///   - text: text
    ///   - state: state
    public func setAutoFooterTitle(_ text: String, for state: XSRefresh.State) {
        autoFooterStateText[state] = text
    }
    
    var backFooterStateText: [XSRefresh.State: String] = [:]
    /// 设置全局默认 Back Footer 标题
    /// - Parameters:
    ///   - text: text
    ///   - state: state
    public func setBackFooterTitle(_ text: String, for state: XSRefresh.State) {
        backFooterStateText[state] = text
    }
    
    public override init() {
        super.init()
        
        setHeaderTitle(Bundle.localizedString(for: XSRefreshHeaderConst.idleText), for: .idle)
        setHeaderTitle(Bundle.localizedString(for: XSRefreshHeaderConst.pullingText), for: .pulling)
        setHeaderTitle(Bundle.localizedString(for: XSRefreshHeaderConst.refreshingText), for: .refreshing)
        
        setAutoFooterTitle(Bundle.localizedString(for: XSRefreshAutoFooterConst.idleText), for: .idle)
        setAutoFooterTitle(Bundle.localizedString(for: XSRefreshAutoFooterConst.refreshingText), for: .refreshing)
        setAutoFooterTitle(Bundle.localizedString(for: XSRefreshAutoFooterConst.noMoreDataText), for: .noMoreData)
        
        setBackFooterTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.idleText), for: .idle)
        setBackFooterTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.pullingText), for: .pulling)
        setBackFooterTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.refreshingText), for: .refreshing)
        setBackFooterTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.noMoreDataText), for: .noMoreData)
    }
}
