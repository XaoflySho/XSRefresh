//
//  XSRefreshAutoStateFooter.swift
//  
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
    
    lazy var stateTitles: [XSRefresh.State: String] = self.config.autoFooterStateText

    public func setTitle(_ text: String, for state: XSRefresh.State) {
        stateTitles[state] = text
        stateLabel.text = stateTitles[self.state]
    }
    
    public var refreshingTitleHidden: Bool = false
    
    @objc private func stateLabelClick() {
        if state == .idle {
            beginRefreshing()
        }
    }
    
    override open func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
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
