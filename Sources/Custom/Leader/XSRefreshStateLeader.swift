//
//  XSRefreshStateLeader.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

open class XSRefreshStateLeader: XSRefreshLeader {

    public lazy var stateLabel: UILabel = {
        let label = UILabel.standard()
        label.transform = .init(rotationAngle: -CGFloat.pi / 2)
        return label
    }()
    
    var stateTitles: [XSRefresh.State: String] = [:]
    
    public func setTitle(_ text: String, for state: XSRefresh.State) {
        stateTitles[state] = text
        stateLabel.text = stateTitles[self.state]
    }
    
    open override func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
        setTitle(Bundle.localizedString(for: XSRefreshHeaderConst.idleText), for: .idle)
        setTitle(Bundle.localizedString(for: XSRefreshHeaderConst.pullingText), for: .pulling)
        setTitle(Bundle.localizedString(for: XSRefreshHeaderConst.refreshingText), for: .refreshing)
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
                        
        if stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    open override var state: XSRefresh.State {
        didSet {
            self.stateLabel.text = stateTitles[state]
        }
    }
}
