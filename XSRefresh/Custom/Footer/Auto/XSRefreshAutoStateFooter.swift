//
//  XSRefreshAutoStateFooter.swift
//  Pods-XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

public class XSRefreshAutoStateFooter: XSRefreshAutoFooter {
    
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
    
    override func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
        setTitle("1", for: .idle)
        setTitle("2", for: .refreshing)
        setTitle("3", for: .noMoreData)
        
        stateLabel.isUserInteractionEnabled = true
        stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateLabelClick)))
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    override var state: XSRefresh.State {
        didSet {
            if refreshingTitleHidden, state == .refreshing {
                stateLabel.text = nil
            } else {
                stateLabel.text = stateTitles[state]
            }
        }
    }
}
