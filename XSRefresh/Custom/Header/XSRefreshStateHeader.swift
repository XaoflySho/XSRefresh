//
//  XSRefreshStateHeader.swift
//  Pods-XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/21.
//

import UIKit

open class XSRefreshStateHeader: XSRefreshHeader {

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
    
    public func setTitle(_ text: String, for state: XSRefresh.State) {
        stateTitles[state] = text
        stateLabel.text = stateTitles[state]
    }
    
    override public var lastUpdatedTimeKey: String {
        didSet {
            if lastUpdatedTimeLabel.isHidden {
                return
            }
            
            let lastUpdatedTime = UserDefaults.standard.object(forKey: lastUpdatedTimeKey) as? Date
            if let lastUpdatedTimeText = lastUpdatedTimeText {
                lastUpdatedTimeLabel.text = lastUpdatedTimeText(lastUpdatedTime)
                return
            }
            
            if let lastUpdatedTime = lastUpdatedTime {
                let calendar = NSCalendar(calendarIdentifier: .gregorian)
                let unitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute]
                let components1 = calendar?.components(unitFlags, from: lastUpdatedTime)
                let components2 = calendar?.components(unitFlags, from: Date())

                let formatter = DateFormatter()
                var isToday = false
                if components1?.day == components2?.day {
                    formatter.dateFormat = " HH:mm"
                    isToday = true
                } else if components1?.year == components2?.year {
                    formatter.dateFormat = "MM-dd HH:mm"
                } else {
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                }
                
                let timeString = formatter.string(from: lastUpdatedTime)
                
                let string = "\(Bundle.localizedString(for: XSRefreshHeaderConst.lastTimeText))\(isToday ? Bundle.localizedString(for: XSRefreshHeaderConst.dateTodayText) : "")\(timeString)"
                lastUpdatedTimeLabel.text = string
            } else {
                let string = "\(Bundle.localizedString(for: XSRefreshHeaderConst.lastTimeText))\(Bundle.localizedString(for: XSRefreshHeaderConst.noneLastDateText))"
                lastUpdatedTimeLabel.text = string
            }
        }
    }
    
    override open func prepare() {
        super.prepare()
        addSubview(stateLabel)
        addSubview(lastUpdatedTimeLabel)
        
        setTitle(Bundle.localizedString(for: XSRefreshHeaderConst.idleText), for: .idle)
        setTitle(Bundle.localizedString(for: XSRefreshHeaderConst.pullingText), for: .pulling)
        setTitle(Bundle.localizedString(for: XSRefreshHeaderConst.refreshingText), for: .refreshing)
    }
    
    override open func placeSubviews() {
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
            
            if noConstrainsOnStatusLabel {
                stateLabel.frame = CGRect(x: 0, y: 0, width: xs.width, height: stateLabelHeight)
            }
            
            if lastUpdatedTimeLabel.constraints.count == 0 {
                lastUpdatedTimeLabel.frame = CGRect(x: 0, y: stateLabelHeight, width: xs.width, height: xs.height - lastUpdatedTimeLabel.xs.y)
            }
        }
    }
    
    override open var state: XSRefresh.State {
        didSet {
            self.stateLabel.text = stateTitles[state]
            self.lastUpdatedTimeKey = XSRefreshHeaderConst.lastUpdateTimeKey
        }
    }
}
