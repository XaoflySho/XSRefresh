# XSRefresh

English|[简体中文](README.zh_CN.md)

The Class Structure Chart of XSRefresh:

![Mindmap](../Images/Mindmap.png)

- `The class of red text` in the chart：You can use them directly
    - The drop-down refresh control types
        - Normal: `XSRefreshNormalHeader`
        - Gif: `XSRefreshGifHeader`
    - The pull to refresh control types
        - Auto refresh
            - Normal: `XSRefreshAutoNormalFooter`
            - Gif: `XSRefreshAutoGifFooter`
        - Auto Back
            - Normal: `XSRefreshBackNormalFooter`
            - Gif: `XSRefreshBackGifFooter`
    - The right pull refresh control types
        - Normal: `XSRefreshNormalLeader`
        - Gif: `XSRefreshGifLeader`
    - The left pull refresh control types
        - Normal: `XSRefreshNormalTrailer`
        - Gif: `XSRefreshGifTrailer`
- `The class of non-red text` in the chart：For inheritance，to use DIY the control of refresh
- About how to DIY the control of refresh，You can refer the `XSRefreshExample`

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

### XSRefreshLeader

```swift
class XSRefreshLeader: XSRefreshComponent {
  /* Creat leader */
  class func leader(WithRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshLeader {}
  convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {}

  /* Creat leader */
  class func leader(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshLeader {}
  convenience init(withRefreshing target: NSObject?, action: Selector?) {}
}
```

### XSRefreshTrailer

```swift
class XSRefreshTrailer: XSRefreshComponent {
  /* Creat trailer */
  class func trailer(withRefreshing block: @escaping XSRefreshComponentAction) -> XSRefreshTrailer {}
  convenience init(withRefreshing block: @escaping XSRefreshComponentAction) {}

  /* Creat trailer */
  class func trailer(withRefreshing target: NSObject?, action: Selector?) -> XSRefreshTrailer {}
  convenience init(withRefreshing target: NSObject?, action: Selector?) {}
}
```

# Example

- Download the source code, or use Git to clone:

```
git clone https://github.com/XaoflySho/XSRefresh.git
```

- Open `XSRefresh.xcodeproj`;
- Select `XSRefreshExample` scheme;
- Run project.

