# XSRefresh

![podversion](https://img.shields.io/cocoapods/v/XSRefresh.svg)

[English](../README.md)|[简体中文](README.zh_CN.md)

一个简捷的拉动刷新控件，[MJRefresh](https://github.com/CoderMJLee/MJRefresh)的Swift版本。

**[Release notes](https://github.com/XaoflySho/XSRefresh/releases)**

## 安装

### CocoaPods

[CocoaPods](https://cocoapods.org/) 是 Cocoa 项目的依赖项管理器。 有关使用和安装说明，请访问其网站。 要使用 CocoaPods 将 XSRefresh 集成到 Xcode 项目中，请在`Podfile`中指定：

```ruby
pod 'XSRefresh'
```

### 手动导入

拖动 XSRefresh 文件夹中的所有文件到项目中。

## 使用

### 快速开始

```swift
import XSRefresh

func tableViewRefreshSetting() {
  // Header, the drop-down refresh control.
  tableView.xs.header = XSRefreshNormalHeader {
    // Refreshing code...
	  
    // End refreshing.
    tableView.xs.header?.endRefreshing()
  }
	
  // Footer, the pull to refresh control.
  tableView.xs.footer = XSRefreshAutoNormalFooter {
    // Load or refreshing Code...
    
    // End refreshing.
    tableView.xs.footer?.endRefreshing()
  }
}
```

### 更多

```swift
import XSRefresh

func tableViewRefreshSetting() {
  // Header, the drop-down refresh control.
  tableView.xs.header = XSRefreshNormalHeader(withRefreshing: self, action: #selector(refresh))
  // Footer, the pull to refresh control.
  tableView.xs.footer = XSRefreshAutoNormalFooter(withRefreshing: self, action: #selector(loadMoreData))
}

@objc func refresh() {
  // Refreshing code...
  
  // End refreshing.
  tableView.xs.header?.endRefreshing()
}

@objc func loadMoreData() {
  // Load or refreshing Code...
  
  // End refreshing.
  if noMoreData {
    // No more data.
    tableView.xs.footer?.endRefreshingWithNoMoreData()
  } else {
    // End refreshing.
    tableView.xs.footer?.endRefreshing()
  }
}
```

## 示例说明

要了解如何应用该规范，请参见[example-readmes](../Example/README.zh_CN.md)。

## 维护

[@XaoflySho](https://github.com/XaoflySho).

## 许可证

[MIT](https://github.com/RichardLitt/standard-readme/blob/master/LICENSE) © Xaofly Sho

