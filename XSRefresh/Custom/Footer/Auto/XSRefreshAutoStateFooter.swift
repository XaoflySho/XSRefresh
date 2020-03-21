//
//  XSRefreshAutoStateFooter.swift
//  Pods-XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshAutoStateFooter: XSRefreshAutoFooter {
    
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
    
    var refreshingTitleHidden: Bool = false
    
    @objc private func stateLabelClick() {
        if state == .idle {
            beginRefreshing()
        }
    }
    
    override open func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
        setTitle(Bundle.localizedString(for: XSRefreshAutoFooterConst.idleText), for: .idle)
        setTitle(Bundle.localizedString(for: XSRefreshAutoFooterConst.refreshingText), for: .refreshing)
        setTitle(Bundle.localizedString(for: XSRefreshAutoFooterConst.noMoreDataText), for: .noMoreData)
        
        stateLabel.isUserInteractionEnabled = true
        stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateLabelClick)))
    }
    
    override open func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    override open var state: XSRefresh.State {
        didSet {
            if refreshingTitleHidden, state == .refreshing {
                stateLabel.text = nil
            } else {
                stateLabel.text = stateTitles[state]
            }
        }
    }
}
