//
//  XSRefreshBackStateFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshBackStateFooter: XSRefreshBackFooter {
    
    public var labelLeftInset: CGFloat = XSRefreshConst.labelLeftInset

    public lazy var stateLabel: UILabel = {
        let label = UILabel.standard()
        return label
    }()
    
    var stateTitles: [XSRefresh.State: String] = [:]

    public func setTitle(_ text: String, for state: XSRefresh.State) {
        stateTitles[state] = text
        stateLabel.text = stateTitles[state]
    }
    
    func title(for state: XSRefresh.State) -> String {
        return stateTitles[state] ?? ""
    }
    
    override open func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.idleText), for: .idle)
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.pullingText), for: .pulling)
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.refreshingText), for: .refreshing)
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.noMoreDataText), for: .noMoreData)
    }
    
    override open func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    override open var state: XSRefresh.State {
        didSet {
            stateLabel.text = stateTitles[state]
        }
    }
}
