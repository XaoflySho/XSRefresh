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
        
        tableView.xs.header = XSRefreshStateHeader.headerRefresh(with: self, action: #selector(refresh))
    }

    @objc
    func refresh() {
        print("REFRESHING")
        tableView.xs.header?.endRefreshing(withCompletion: {
            print("END")
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        
    }
}

