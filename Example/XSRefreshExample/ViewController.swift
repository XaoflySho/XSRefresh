//
//  ViewController.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/20.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

let MJExample00: String = "UITableView + 下拉刷新"
let MJExample10: String = "UITableView + 上拉刷新"
let MJExample20: String = "UICollectionView"
let MJExample30: String = "WKWebView"

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var examples: [XSExample] = {
        var examples: [XSExample] = []
        
        var example0 = XSExample()
        example0.header = MJExample00
        example0.viewControllerClass = TableViewController()
        example0.titles = ["默认", "动画图片", "隐藏时间", "隐藏状态和时间", "自定义文字", "自定义刷新控件"]
        example0.methods = ["example01", "example02", "example03", "example04", "example05", "example06"]
        
        examples.append(example0)
        
        var example1 = XSExample()
        example1.header = MJExample10
        example1.viewControllerClass = TableViewController()
        example1.titles = ["默认", "动画图片", "隐藏刷新状态的文字", "全部加载完毕", "禁止自动加载", "自定义文字", "加载后隐藏", "自动回弹的上拉01", "自动回弹的上拉02", "自定义刷新控件(自动刷新)", "自定义刷新控件(自动回弹)"]
        example1.methods = ["example11", "example12", "example13", "example14", "example15", "example16", "example17", "example18", "example19", "example20", "example21"]
        
        examples.append(example1)
        
        var example2 = XSExample()
        example2.header = MJExample20
        example2.viewControllerClass = CollectionViewController()
        example2.titles = ["上下拉刷新"]
        example2.methods = ["example21"]
        
        examples.append(example2)
        
        var example3 = XSExample()
        example3.header = MJExample30
        example3.viewControllerClass = TableViewController()
        example3.titles = ["下拉刷新"]
        example3.methods = ["example41"]
        
        examples.append(example3)
        
        return examples
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewRefreshSetting()
    }
    
    func tableViewRefreshSetting() {
        /// 设置下拉刷新
        tableView.xs.header = XSRefreshNormalHeader {
            print("\(NSStringFromClass(type(of: self))) - \(self.title ?? "") - Header - Refreshing")
            /// 模拟延迟加载数据，2秒后完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                /// 结束刷新
                self.tableView.xs.header?.endRefreshing {
                    print("\(NSStringFromClass(type(of: self))) - \(self.title ?? "") - Header - End")
                }
                
            }
        }
        
        /// 设置上拉加载
        tableView.xs.footer = XSRefreshBackNormalFooter {
            
            print("\(NSStringFromClass(type(of: self))) - \(self.title ?? "") - Footer - Refreshing")
            
            /// 模拟延迟加载数据，2秒后完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                /// 结束加载
                self.tableView.xs.footer?.endRefreshing {
                    print("\(NSStringFromClass(type(of: self))) - \(self.title ?? "") - Footer - End")
                }
                
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples[section].titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exampleCell", for: indexPath)
        let example = examples[indexPath.section]
        
        cell.textLabel?.text = example.titles[indexPath.row]
        cell.detailTextLabel?.text = "\(NSStringFromClass(type(of: example.viewControllerClass.self))) - \(example.methods[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return examples[section].header
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = examples[indexPath.section]
        let viewController = example.viewControllerClass
        viewController.title = example.titles[indexPath.row]
//        viewController.setValue(example.methods[indexPath.row], forKey: "method")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

