//
//  UIScrollView+RefreshView.swift
//  PullToRefresh
//
//  Created by mr.scorpion on 16/8/02.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

import UIKit

private var MSHeaderKey: UInt8 = 0
private var MSFooterKey: UInt8 = 0

extension UIScrollView {
    public typealias RefreshHandler = () -> Void
    
    private var ms_refreshHeader: RefreshView? {
        set {
            objc_setAssociatedObject(self, &MSHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &MSHeaderKey) as? RefreshView
        }
    }
    private var ms_refreshFooter: RefreshView? {
        set {
            objc_setAssociatedObject(self, &MSFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &MSFooterKey) as? RefreshView
        }
    }
    
    ///
    public func ms_addRefreshHeader<Animator where Animator: UIView, Animator: RefreshViewDelegate>(headerAnimator: Animator, refreshHandler: RefreshHandler ) {
        if let header = ms_refreshHeader {
            header.removeFromSuperview()
        }
        ///
        let frame = CGRect(x: 0.0, y: -headerAnimator.bounds.height, width: bounds.width, height: headerAnimator.bounds.height)
        ms_refreshHeader = RefreshView(frame: frame, refreshType: .header, refreshAnimator: headerAnimator, refreshHandler: refreshHandler)
        addSubview(ms_refreshHeader!)
        
    }
    ///
    public func ms_addRefreshFooter<Animator where Animator: UIView, Animator: RefreshViewDelegate>(footerAnimator: Animator, refreshHandler: RefreshHandler ) {
        if let footer = ms_refreshFooter {
            footer.removeFromSuperview()
        }
        /// this may not the final position
        let frame = CGRect(x: 0.0, y: contentSize.height, width: bounds.width, height: footerAnimator.bounds.height)
        ms_refreshFooter = RefreshView(frame: frame, refreshType: .footer,  refreshAnimator: footerAnimator, refreshHandler: refreshHandler)
        addSubview(ms_refreshFooter!)
    }
    /// 开启header刷新
    public func ms_startHeaderAnimation() {
        ms_refreshHeader?.canBegin = true
    }
    /// 结束header刷新
    public func ms_stopHeaderAnimation() {
        ms_refreshHeader?.canBegin = false
    }
    /// 开启footer刷新
    public func ms_startFooterAnimation() {
        ms_refreshFooter?.canBegin = true
    }
    /// 结束footer刷新
    public func ms_stopFooterAnimation() {
        ms_refreshFooter?.canBegin = false
    }
    
}