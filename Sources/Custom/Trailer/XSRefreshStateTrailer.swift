//
//  XSRefreshStateTrailer.swift
//  XSRefresh
//
//  Created by 邵晓飞 on 2020/3/26.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

open class XSRefreshStateTrailer: XSRefreshTrailer {
    
    public lazy var stateLabel: UILabel = {
        let label = UILabel.standard()
        label.transform = .init(rotationAngle: -CGFloat.pi / 2)
        return label
    }()
    
    var stateTitles: [XSRefresh.State: String] = [:]
    
    open override var state: XSRefresh.State {
        didSet {
            self.stateLabel.text = stateTitles[state]
        }
    }
    
    open override func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.idleText), for: .idle)
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.pullingText), for: .pulling)
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.refreshingText), for: .refreshing)
        setTitle(Bundle.localizedString(for: XSRefreshBackFooterConst.noMoreDataText), for: .noMoreData)
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
                        
        if stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    public func setTitle(_ text: String, for state: XSRefresh.State) {
        stateTitles[state] = text
        stateLabel.text = stateTitles[self.state]
    }
    
}
