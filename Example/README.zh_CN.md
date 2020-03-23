# XSRefresh

[English](README.md)|[简体中文](README.zh_CN.md)

XSRefresh的类结构图：

![Mindmap](../Images/Mindmap.png)

- 上图中`红色文字的类` ：你可以直接使用
    - 下拉刷新控件类：
        - 普通：`XSRefreshNormalHeader`
        - 动图：`XSRefreshGifHeader`
    - 上拉加载控件类：
        - 自动加载：
            - 普通：`XSRefreshAutoNormalFooter`
            - 动图：`XSRefreshAutoGifFooter`
        - 回弹加载：
            - 普通：`XSRefreshBackNormalFooter`
            - 动图：`XSRefreshBackGifFooter`
- 上图中`非红色文字的类` ：可以继承，自定义刷新控件。
- 关于如何自定义刷新控件，可以参考`XSRefreshExample`。

### XSRefreshComponent

```swift
/* The Base Class of refresh control */
class XSRefreshComponent: UIView {
  /* Control the state of Refresh */
  /* BeginRefreshing */
  func beginRefreshing(withCompletion block: (() -> Void)? = nil) {}
  /* EndRefreshing */
  func endRefreshing(withCompletion block: (() -> Void)? = nil) {}
  /* IsRefreshing */
  var refreshing: Bool
  
  /* According to the drag ratio to change alpha automatically */
  var automaticallyChangeAlpha: Bool
} 
```

### XSRefreshHeader

```swift
class XSRefreshHeader: XSRefreshComponent {
  /* Creat header */
  class func header(WithRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshHeader {}
  convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {}
  
  /* Creat header */
  class func header(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshHeader {}
  convenience init(withRefreshing target: NSObject?, action: Selector?) {}
  
  /* This key is used to storage the time that the last time of drown-down successfully */
  var lastUpdatedTimeKey: String
  /* The last time of drown-down successfully */
  var lastUpdatedTime: Date
  
  /* Ignored scrollView contentInset top */
  var ignoredScrollViewContentInsetTop: CGFloat
}
```

### XSRefreshFooter

```swift
class XSRefreshFooter: XSRefreshComponent {
  /* Creat footer */
  class func footer(withRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshFooter {}
  convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {}
  
  /* Creat footer */
  class func footer(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshFooter {}
  convenience init(withRefreshing target: NSObject?, action: Selector?) {}
  
  /* NoticeNoMoreData */
  func endRefreshingWithNoMoreData(completion block: (() -> Void)? = nil) {}
  /* ResetNoMoreData (Clear the status of NoMoreData) */
  func resetNoMoreData() {}
  
  /* Ignored scrollView contentInset bottom */
  var ignoredScrollViewContentInsetBottom: CGFloat
}
```

### XSRefreshAutoFooter

```swift
class XSRefreshAutoFooter: XSRefreshFooter {
  /* Is Automatically Refresh(Default is True) */
  var automaticallyRefresh: Bool = true
  
  /* When there is much at the bottom of the control is automatically refresh(Default is 1.0，Is at the bottom of the control appears in full, will refresh automatically) */
  var triggerAutomaticallyRefreshPercent: CGFloat = 1.0
}
```