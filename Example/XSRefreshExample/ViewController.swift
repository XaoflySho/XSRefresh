//
//  ViewController.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/20.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.xs.header = XSChiBaoZiHeader.headerRefresh(with: self, action: #selector(refresh))
        tableView.xs.footer = XSRefreshBackStateFooter.footerRefresh(with: self, action: #selector(loadMoreData))
    }

    @objc
    func refresh() {
        print("REFRESHING")
        tableView.xs.footer?.resetNoMoreData()
        
    }
    
    @objc
    func loadMoreData() {
        print("LOAD MORE DATA")
//        tableView.xs.footer?.endRefreshingWithNoMoreData(completion: {
//            print("NO MORE DATA - END")
//        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.xs.header?.endRefreshing(withCompletion: {
            print("END")
        })
        tableView.xs.footer?.endRefreshing(withCompletion: {
            print("END")
        })
    }
}

