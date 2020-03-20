//
//  XSRefreshComponent.swift
//  
//
//  Created by 邵晓飞 on 2020/3/20.
//

import UIKit

/// 刷新控件的状态
enum XSRefreshState: Int {
    /// 闲置
    case idle = 1
    /// 松开就可以进行刷新
    case pulling
    /// 正在刷新中
    case refreshing
    /// 即将刷新
    case willRefresh
    /// 没有更多的数据
    case noMoreData
}

typealias XSRefreshComponentAction = () -> (Void)

class XSRefreshComponent: UIView {
    
    // MARK: - 刷新回调
    /// 正在刷新的回调
    var refreshingBlock: XSRefreshComponentAction?
    
    /// 回调对象
    var refreshingTarget: Any?
    
    /// 回调方法
    var refreshingAction: Selector?
    
    // MARK: - 刷新状态控制
    /// 进入刷新后的回调
    var beginRefreshingCompletionBlock: XSRefreshComponentAction?
    /// 带动画的结束刷新的回调
    var endRefreshingAnimationBeginAction: XSRefreshComponentAction?
    /// 结束刷新的回调
    var endRefreshingCompletionBlock: XSRefreshComponentAction?
    
    /// 是否正在刷新
    var refreshing: Bool {
        return true
    }
    
    /// 刷新状态
    var state: XSRefreshState
    
    private(set) weak var scrollView: UIScrollView?
    var scrollViewOriginalInset: UIEdgeInsets?
    
    private var pan: UIPanGestureRecognizer?
    
    override init(frame: CGRect) {
        state = .idle
        super.init(frame: frame)
        
        prepare()
    }
    
    required init?(coder: NSCoder) {
        state = .idle
        super.init(coder: coder)
        
        prepare()
    }
    
    func prepare() {
        autoresizingMask = .flexibleWidth
        backgroundColor  = .clear
    }
    
    override func layoutSubviews() {
        placeSubviews()
        super.layoutSubviews()
    }
    
    func placeSubviews() {}
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let newSuperview = newSuperview as? UIScrollView else {
            return
        }
        
        removeObservers()
        
        self.scrollView = newSuperview
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        self.xs.width = scrollView.xs.width
        self.xs.x     = scrollView.xs.insetLeft
        
        scrollView.alwaysBounceVertical = true
        scrollViewOriginalInset = scrollView.xs.inset
        
        addObservers()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if state == .willRefresh {
            state = .refreshing
        }
    }
    
    func addObservers() {
        let options: NSKeyValueObservingOptions = [.new, .old]
        scrollView?.addObserver(self, forKeyPath: XSRefreshKeyPath.contentOffset, options: options, context: nil)
        scrollView?.addObserver(self, forKeyPath: XSRefreshKeyPath.contentSize, options: options, context: nil)
        pan = scrollView?.panGestureRecognizer
        pan?.addObserver(self, forKeyPath: XSRefreshKeyPath.panState, options: options, context: nil)
    }
    
    func removeObservers() {
        superview?.removeObserver(self, forKeyPath: XSRefreshKeyPath.contentOffset)
        superview?.removeObserver(self, forKeyPath: XSRefreshKeyPath.contentSize)
        pan?.removeObserver(self, forKeyPath: XSRefreshKeyPath.panState)
        pan = nil
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard isUserInteractionEnabled else {
            return
        }
        
        if keyPath == XSRefreshKeyPath.contentSize {
            scrollViewContentSizeDidChange(change)
        }
        
        guard !isHidden else {
            return
        }
        
        if keyPath == XSRefreshKeyPath.contentOffset {
            scrollViewContentOffsetDidChange(change)
        }
        else if keyPath == XSRefreshKeyPath.panState {
            scrollViewPanStateDidChange(change)
        }
    }
    
    func scrollViewContentSizeDidChange(_ change: [NSKeyValueChangeKey : Any]?) {}
    func scrollViewContentOffsetDidChange(_ change: [NSKeyValueChangeKey : Any]?) {}
    func scrollViewPanStateDidChange(_ change: [NSKeyValueChangeKey : Any]?) {}
    
    func setRefreshing(target: Any?, action: Selector?) {
        refreshingTarget = target
        refreshingAction = action
    }
}
