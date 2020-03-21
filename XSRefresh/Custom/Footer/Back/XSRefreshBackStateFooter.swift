//
//  XSRefreshBackStateFooter.swift
//  
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

public class XSRefreshBackStateFooter: XSRefreshBackFooter {
    
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
    
    override func prepare() {
        super.prepare()
        addSubview(stateLabel)
        
        setTitle("1", for: .idle)
        setTitle("2", for: .pulling)
        setTitle("3", for: .refreshing)
        setTitle("4", for: .noMoreData)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    override var state: XSRefresh.State {
        didSet {
            stateLabel.text = stateTitles[state]
        }
    }
}
