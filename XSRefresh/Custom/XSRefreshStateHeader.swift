//
//  XSRefreshStateHeader.swift
//  Pods-XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

public class XSRefreshStateHeader: XSRefreshHeader {

    public var lastUpdatedTimeText: ((_ lastUpdatedTime: Date?) -> String)?
    
    public lazy var lastUpdatedTimeLabel: UILabel = {
        let label = UILabel.standard()
        return label
    }()
    
    public var labelLeftInset: CGFloat = XSRefreshConst.labelLeftInset
    
    public lazy var stateLabel: UILabel = {
        let label = UILabel.standard()
        return label
    }()
    
    var stateTitles: [XSRefresh.State: String] = [:]
    
    func setTitle(_ text: String, for state: XSRefresh.State) {
        stateTitles[state] = text
        stateLabel.text = stateTitles[state]
    }
    
    override public var lastUpdatedTimeKey: String {
        set {
            super.lastUpdatedTimeKey = newValue
            
            if lastUpdatedTimeLabel.isHidden {
                return
            }
            
            let lastUpdatedTime = UserDefaults.standard.object(forKey: newValue) as? Date
            if let lastUpdatedTimeText = lastUpdatedTimeText {
                lastUpdatedTimeLabel.text = lastUpdatedTimeText(lastUpdatedTime)
                return
            }
            
            if let lastUpdatedTime = lastUpdatedTime {
                // TODO: 时间格式化
                
                lastUpdatedTimeLabel.text = "00:00:--"
            } else {
                // TODO: 文本格式化
                lastUpdatedTimeLabel.text = "00:00:--"
            }
        }
        get {
            return super.lastUpdatedTimeKey
        }
    }
    
    override func prepare() {
        super.prepare()
        addSubview(stateLabel)
        addSubview(lastUpdatedTimeLabel)
        
        // TODO: 文本
        setTitle("1", for: .idle)
        setTitle("2", for: .pulling)
        setTitle("3", for: .refreshing)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.isHidden {
            return
        }
        
        let noConstrainsOnStatusLabel = stateLabel.constraints.count == 0
        
        if lastUpdatedTimeLabel.isHidden {
            // 状态
            if noConstrainsOnStatusLabel {
                stateLabel.frame = bounds
            }
        } else {
            let stateLabelHeight = xs.height * 0.5
            // 状态
            if noConstrainsOnStatusLabel {
                stateLabel.frame = CGRect(x: 0, y: 0, width: xs.width, height: stateLabelHeight)
            }
            // 更新时间
            if lastUpdatedTimeLabel.constraints.count == 0 {
                lastUpdatedTimeLabel.frame = CGRect(x: 0, y: stateLabelHeight, width: xs.width, height: xs.height - stateLabelHeight)
            }
        }
    }
    
    override var state: XSRefresh.State {
        set {
            let oldValue = self.state
            if oldValue == newValue {
                return
            }
            super.state = newValue
            
            self.stateLabel.text = stateTitles[newValue]
            self.lastUpdatedTimeKey = XSRefreshHeaderConst.lastUpdateTimeKey
        }
        get {
            return super.state
        }
    }
}
