English|[简体中文](Readme/README.zh_CN.md)

# XSRefresh [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](./LICENSE) [![podversion](https://img.shields.io/cocoapods/v/XSRefresh.svg?style=flat)](https://cocoapods.org/pods/XSRefresh) [![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D?style=flat)](https://github.com/Carthage/Carthage)

An easy way to use pull-to-refresh, Swift version of [MJRefresh](https://github.com/CoderMJLee/MJRefresh).

**[Release notes](RELEASE/RELEASE.md)**

- [Install](#install)
  - [CocoaPods](#cocoapods)
  - [Carthage](#carthage)
  - [Manual](#manual)
- [Usage](#usage)
  - [Quick start](#quick-start)
  - [More](#more)
  - [Swift Chaining Grammar](#Swift-Chaining-Grammar)
- [Example Readmes](#example-readmes)
- [TODO List](#todo-list)
- [Maintainers](#maintainers)
- [License](#license)

## Install

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate XSRefresh into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'XSRefresh'
```

###  Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate XSRefresh into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "XaoflySho/XSRefresh"
```

### Manual

Drag All files in the `XSRefresh/Sources` folder to project.

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

### Swift Chaining Grammar

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

## Example Readmes

To see how the specification has been applied, see the [example-readmes](Readme/EXAMPLE-README.md).

## TODO List

- [x] Support for Carthage management tools
- [ ] ~~Support for Swift package management tools~~
- [x] Support horizontal scroll control, eg.CollectionView
- [x] Support Swift Chaining Grammar
- [ ] ......

## Maintainers

[@XaoflySho](https://github.com/XaoflySho).

## License

[MIT](./LICENSE) © Xaofly Sho

