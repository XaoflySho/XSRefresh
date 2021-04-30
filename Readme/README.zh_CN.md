[English](../README.md)|简体中文

# XSRefresh [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](./LICENSE) [![podversion](https://img.shields.io/cocoapods/v/XSRefresh.svg?style=flat)](https://cocoapods.org/pods/XSRefresh) [![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D?style=flat)](https://github.com/Carthage/Carthage)

一个简捷的拉动刷新控件，[MJRefresh](https://github.com/CoderMJLee/MJRefresh)的Swift版本。

**[Release notes](../RELEASE/RELEASE.md)**

- [安装](#安装)
  - [CocoaPods](#cocoapods)
  - [Carthage](#carthage)
  - [手动导入](#手动导入)
- [使用](#使用)
  - [快速开始](#快速开始)
  - [更多](#更多)
  - [Swift链式语法](#Swift-链式语法)
- [示例说明](#示例说明)
- [待办事项](#待办事项)
- [维护](#维护)
- [许可证](#许可证)

## 安装

### CocoaPods

[CocoaPods](https://cocoapods.org/) 是 Cocoa 项目的依赖项管理器。 有关使用和安装说明，请访问其网站。 要使用 CocoaPods 将 XSRefresh 集成到 Xcode 项目中，请在`Podfile`中指定：

```ruby
pod 'XSRefresh'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) 是一个分散的依赖性管理器，可构建您的依赖性并为您提供二进制框架。 要使用 Carthage 将 XSRefresh 集成到 Xcode 项目中，请在 `Cartfile` 中指定：

```
github "XaoflySho/XSRefresh"
```

### 手动导入

拖动 `XSRefresh/Sources` 文件夹及其中所有文件到项目中。

## 使用

### 快速开始

```swift
import XSRefresh

func tableViewRefreshSetting() {
  // Header, the drop-down refresh control.
  tableView.xs.header = XSRefreshNormalHeader { [weak self] in
    // Refreshing code...
	  
    // End refreshing.
    self?.tableView.xs.header?.endRefreshing()
  }
	
  // Footer, the pull to refresh control.
  tableView.xs.footer = XSRefreshAutoNormalFooter { [weak self] in
    // Load or refreshing Code...
    
    // End refreshing.
    self?.tableView.xs.footer?.endRefreshing()
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

### Swift 链式语法

```swift
func tableViewRefreshSetting() {
	XSRefreshNormalHeader { [weak self] in
		// Do something...
	}
	.autoChangeTransparency(true)
	.link(to: tableView)
  
  XSRefreshAutoNormalFooter { [weak self] in
		// Do something...
	}
	.autoChangeTransparency(true)
	.link(to: tableView)
}
```

## 示例说明

要了解如何应用该规范，请参见[example-readmes](EXAMPLE-README.zh_CN.md)。

## 待办事项

- [x] 支持 Carthage 管理工具
- [ ] ~~支持 Swift Package Manager 管理工具~~
- [x] 支持横向滚动的控件，例如Collection View
- [x] 支持Swift链式语法
- [ ] ......

## 维护

[@XaoflySho](https://github.com/XaoflySho).

## 许可证

[MIT](../LICENSE) © Xaofly Sho

