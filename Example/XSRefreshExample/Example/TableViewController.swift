//
//  TableViewController.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/23.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class TableViewController: UITableViewController {
    
    lazy var dataSource: [String] = {
        var array: [String] = []
        for i in 0 ..< 5 {
            array.append(self.formatStringWithInt(i))
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()

        print("\(methodString)")
        
        let selector: Selector = NSSelectorFromString(methodString)
        if self.responds(to: selector) {
            self.perform(selector)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = dataSource[indexPath.row]

        return cell
    }
    
    deinit {
        print("Deinit")
    }
}

extension TableViewController {
    
    func randomData() -> String {
        let random = Int.random(in: 0 ..< 1000)
        return "随机数据 - \(random)"
    }
    
    func formatStringWithInt(_ int: Int) -> String {
        return "请求到的第\(int)条数据"
    }
}

extension TableViewController {
    
    @objc func refresh() {
        
        /// 模拟处理数据
        var array: [String] = []
        for i in 0 ..< 5 {
            array.append(self.formatStringWithInt(tableView.xs.totalDataCount + i))
        }
        
        dataSource = array + dataSource
        
        /// 模拟延迟加载数据，1秒后完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.tableView.reloadData()
            
            self?.tableView.xs.header?.endRefreshing()
        }
    }
    
    @objc func loadMoreData() {
        /// 模拟处理数据
        for i in 0 ..< 5 {
            dataSource.append(self.formatStringWithInt(tableView.xs.totalDataCount + i))
        }
        
        /// 模拟延迟加载数据，1秒后完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.tableView.reloadData()
            
            self?.tableView.xs.footer?.endRefreshing()
        }
    }
    
    @objc func loadMoreDataWithNoMore() {
        /// 模拟处理数据
        for i in 0 ..< 5 {
            dataSource.append(self.formatStringWithInt(tableView.xs.totalDataCount + i))
        }
        
        /// 模拟延迟加载数据，1秒后完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.tableView.reloadData()
            
            self?.tableView.xs.footer?.endRefreshingWithNoMoreData()
        }
    }
    
    @objc func resetNoMoreData() {
        tableView.xs.footer?.resetNoMoreData()
    }
    
    @objc func loadOnceData() {
        /// 模拟处理数据
        for i in 0 ..< 5 {
            dataSource.append(self.formatStringWithInt(tableView.xs.totalDataCount + i))
        }
        
        /// 模拟延迟加载数据，1秒后完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.tableView.reloadData()
            
            self?.tableView.xs.footer?.isHidden = true
        }
    }
    
    @objc func example01() {
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.xs.header = XSRefreshNormalHeader { [weak self] in
            self?.refresh()
        }
        
        // 进入刷新状态
        tableView.xs.header?.beginRefreshing()
    }
    
    @objc func example02() {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的refresh方法）
        tableView.xs.header = XSChiBaoZiHeader(withRefreshing: self, action: #selector(refresh))
        
        // 进入刷新状态
        tableView.xs.header?.beginRefreshing()
    }
    
    @objc func example03() {
        
        let header = XSRefreshNormalHeader(withRefreshing: self, action: #selector(refresh))
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = true
        // 隐藏时间
        header.lastUpdatedTimeLabel.isHidden = true
        // 进入刷新状态
        header.beginRefreshing()
        // 设置 header
        tableView.xs.header = header
    }
    
    @objc func example04() {
        
        let header = XSChiBaoZiHeader(withRefreshing: self, action: #selector(refresh))
        // 隐藏状态
        header.stateLabel.isHidden = true
        // 隐藏时间
        header.lastUpdatedTimeLabel.isHidden = true
        // 进入刷新状态
        header.beginRefreshing()
        // 设置 header
        tableView.xs.header = header
    }
    
    @objc func example05() {
    
        let header = XSRefreshNormalHeader(withRefreshing: self, action: #selector(refresh))
        // 设置文字
        header.setTitle("Pull down to refresh", for: .idle)
        header.setTitle("Release to refresh", for: .pulling)
        header.setTitle("Loading ...", for: .refreshing)
        
        // 设置字体
        header.stateLabel.font = UIFont.systemFont(ofSize: 15)
        header.lastUpdatedTimeLabel.font = UIFont.systemFont(ofSize: 12)
        
        // 设置颜色
        header.stateLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        header.lastUpdatedTimeLabel.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        // 进入刷新状态
        header.beginRefreshing()
        // 设置 header
        tableView.xs.header = header
    }
    
    @objc func example06() {
        
        // TODO: 自定义控件
    }
    
    @objc func example11() {
        self.example01()
        
        tableView.xs.footer = XSRefreshAutoNormalFooter { [weak self] in
            self?.loadMoreData()
        }
    }
    
    @objc func example12() {
        self.example01()
        
        tableView.xs.footer = XSChiBaoZiAutoFooter(withRefreshing: self, action: #selector(loadMoreData))
    }
    
    @objc func example13() {
        self.example01()
        
        let footer = XSChiBaoZiAutoFooter(withRefreshing: self, action: #selector(loadMoreData))
        // 隐藏状态
        footer.refreshingTitleHidden = true
        // 设置 Footer
        tableView.xs.footer = footer
    }
    
    @objc func example14() {
        self.example01()
        
        // 设置 Footer
        tableView.xs.footer = XSRefreshAutoNormalFooter(withRefreshing: self, action: #selector(loadMoreDataWithNoMore))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "重置", style: .plain, target: self, action: #selector(resetNoMoreData))
    }
    
    @objc func example15() {
        self.example01()
        
        let footer = XSRefreshAutoNormalFooter(withRefreshing: self, action: #selector(loadMoreData))
        // 禁止自动加载
        footer.automaticallyRefresh = false
        // 设置 Footer
        tableView.xs.footer = footer
    }
    
    @objc func example16() {
        self.example01()

        let footer = XSRefreshAutoNormalFooter(withRefreshing: self, action: #selector(loadMoreData))
        // 设置文字
        footer.setTitle("Click or drag up to refresh", for: .idle)
        footer.setTitle("Loading more ...", for: .refreshing)
        footer.setTitle("No more data", for: .noMoreData)
        
        // 设置字体
        footer.stateLabel.font = UIFont.systemFont(ofSize: 15)
        
        // 设置颜色
        footer.stateLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        // 设置 Footer
        tableView.xs.footer = footer
    }
    
    @objc func example17() {
        self.example01()

        tableView.xs.footer = XSRefreshAutoNormalFooter(withRefreshing: self, action: #selector(loadOnceData))
    }
    
    @objc func example18() {
        self.example01()
    
        let footer = XSRefreshBackNormalFooter(withRefreshing: self, action: #selector(loadMoreData))
        
        footer.ignoredScrollViewContentInsetBottom = 30
        
        tableView.xs.footer = footer
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    @objc func example19() {
        self.example01()
            
        let footer = XSChiBaoZiBackFooter(withRefreshing: self, action: #selector(loadMoreData))
        
        footer.automaticallyChangeAlpha = true
        // 设置 Footer
        tableView.xs.footer = footer
    }
    
    @objc func example20() {
        self.example01()

        // TODO: 自定义 Auto Footer
    }
    
    @objc func example21() {
        self.example01()

        // TODO: 自定义 Back Footer
    }
}
