# XSRefresh

![podversion](https://img.shields.io/cocoapods/v/XSRefresh.svg)

English|[简体中文](Readme/README.zh_CN.md)

An easy way to use pull-to-refresh, Swift version of [MJRefresh](https://github.com/CoderMJLee/MJRefresh).

**[Release notes](https://github.com/XaoflySho/XSRefresh/releases)**

## Install

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate XSRefresh into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'XSRefresh'
```

### Manual import

Drag All files in the `XSRefresh` folder to project.

## Usage

### Quick start

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

### More

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

## Example Readmes

To see how the specification has been applied, see the [example-readmes](Example/README.md).

## TODO List

 ☐ Support for Carthage management tools

 ☐ Support for Swift package management tools

 ☐ Support horizontal scroll control, eg.CollectionView

 ☐ ......

## Maintainers

[@XaoflySho](https://github.com/XaoflySho).

## License

[MIT](./LICENSE) © Xaofly Sho

