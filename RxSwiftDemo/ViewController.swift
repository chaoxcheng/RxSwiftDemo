//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/10/16.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect.zero, style: .plain)
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        temp.dataSource = self
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = "cxc"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
